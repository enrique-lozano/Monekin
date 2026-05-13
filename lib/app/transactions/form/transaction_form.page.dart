import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/assets/widgets/asset_valuation_impact_section.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/app/transactions/form/asset_trade_form_context.dart';
import 'package:monekin/app/transactions/form/dialogs/amount_selector.dart';
import 'package:monekin/app/transactions/form/dialogs/evaluate_expression.dart';
import 'package:monekin/app/transactions/form/widgets/debt_link_banner.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_account_selector_row.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_amount_display.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_date_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_fields.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_selectors.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/database/services/user-setting/default_transaction_values.service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../../core/models/transaction/transaction_type.enum.dart';

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({
    super.key,
    this.mode,
    this.fromAccount,
    this.toAccount,
    this.transactionToEdit,
    this.linkedDebt,
    this.assetTradeContext,
  });

  final TransactionType? mode;

  final MoneyTransaction? transactionToEdit;

  final Account? fromAccount;

  /// When non-null, the transfer receiving account will be pre-filled
  /// with this account.
  final Account? toAccount;

  /// When non-null, the created transaction will be automatically linked to
  /// this debt. A banner indicator is shown inside the form.
  final Debt? linkedDebt;

  /// Opens the form for a new asset buy/sell. The asset and direction live here for
  /// the lifetime of the route (no duplicate state in the page).
  final AssetTradeFormContext? assetTradeContext;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  final TextEditingController _amountTextController = TextEditingController();
  bool _amountFieldSyncGuard = false;

  // --- Form Fields ---

  double transactionValue = 0;

  TextEditingController valueInDestinyController = TextEditingController();
  double? get valueInDestinyToNumber =>
      double.tryParse(valueInDestinyController.text);

  Category? selectedCategory;

  Account? fromAccount;
  Account? transferAccount;

  DateTime date = DateTime.now();

  TransactionStatus? status;

  TextEditingController notesController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  RecurrencyData recurrentRule = const RecurrencyData.noRepeat();

  List<Tag> tags = [];

  // --- End Form Fields ---

  /// The asset for an investment buy/sell row: from [assetTradeContext] when creating,
  /// or loaded from the DB when editing.
  Asset? _asset;

  /// Whether valuation updates are applied for this asset trade.
  bool _updateValuations = false;

  bool get isEditMode => widget.transactionToEdit != null;

  /// Current transaction mode; reassigned when the user switches expense / income / transfer tabs.
  late TransactionType transactionType;

  /// True for a buy/sell on a specific asset: opened via [TransactionFormPage.assetTradeContext]
  /// or by editing an investment with [MoneyTransaction.assetID]. Tabs are hidden and
  /// [transactionType] stays [TransactionType.investment].
  bool get _isAssetTradeInvestment {
    if (widget.assetTradeContext != null) return true;
    final edit = widget.transactionToEdit;
    return edit != null &&
        edit.type == TransactionType.investment &&
        edit.assetID != null;
  }

  /// Buy moves cash into the asset (stored value negative); sell withdraws (positive).
  bool get _investmentIsBuy {
    final ctx = widget.assetTradeContext;
    if (ctx != null) return ctx.isBuy;
    final edit = widget.transactionToEdit;
    if (edit != null &&
        edit.type == TransactionType.investment &&
        edit.assetID != null &&
        edit.assetID!.isNotEmpty) {
      return edit.value.isNegative;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _amountTextController.addListener(_onAmountFieldTextChanged);

    assert(
      widget.assetTradeContext == null || widget.transactionToEdit == null,
    );

    if (_isAssetTradeInvestment) {
      transactionType = TransactionType.investment;
      if (widget.transactionToEdit != null) {
        _fillForm(widget.transactionToEdit!);
        unawaited(_loadInvestmentAsset());
        return;
      }
      if (widget.assetTradeContext != null) {
        _asset = widget.assetTradeContext!.asset;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final tr = Translations.of(context);
          titleController.text = _investmentIsBuy
              ? tr.assets.details.buy
              : tr.assets.details.sell;
          await _initializeFormValues();
          final tradeCtx = widget.assetTradeContext;
          if (tradeCtx != null && mounted) {
            if (tradeCtx.prefillDate != null) {
              date = tradeCtx.prefillDate!;
            }
            final prefillAmt = tradeCtx.prefillTradeAmountAbs;
            if (prefillAmt != null && prefillAmt > 0) {
              transactionValue = prefillAmt;
            }
            final prefillUv = tradeCtx.prefillUpdateValuations;
            if (prefillUv != null) {
              _updateValuations = prefillUv;
            }
          }
          if (mounted) setState(() {});
        });
      }
      return;
    }

    if (widget.transactionToEdit != null) {
      transactionType = widget.transactionToEdit!.type;
    } else if (widget.mode != null) {
      transactionType = widget.mode!;
    } else {
      final defaultTypeStr =
          appStateSettings[SettingKey.defaultTransactionType];

      if (defaultTypeStr != null) {
        transactionType =
            TransactionType.values.firstWhereOrNull(
              (e) => e.name == defaultTypeStr,
            ) ??
            TransactionType.expense;
      } else {
        transactionType = TransactionType.expense;
      }
    }

    if (widget.transactionToEdit != null) {
      _fillForm(widget.transactionToEdit!);
      return;
    }

    _initializeFormValues();
  }

  Future<void> _loadInvestmentAsset() async {
    final id = widget.transactionToEdit?.assetID;
    if (id == null) return;
    final loaded = await InvestmentService.instance.getAssetById(id).first;
    if (mounted) setState(() => _asset = loaded);
  }

  @override
  void dispose() {
    _amountTextController.removeListener(_onAmountFieldTextChanged);
    _amountTextController.dispose();
    super.dispose();
  }

  void _onAmountFieldTextChanged() {
    if (_isAssetTradeInvestment || _amountFieldSyncGuard) return;
    final raw = _amountTextController.text.trim().replaceAll(',', '.');
    if (raw.isEmpty) {
      if (transactionValue != 0) {
        setState(() => transactionValue = 0);
      }
      return;
    }
    final double parsed;
    try {
      parsed = evaluateExpression(raw).abs();
    } catch (_) {
      return;
    }
    if (parsed != transactionValue) {
      setState(() => transactionValue = parsed);
    }
  }

  void _syncAmountFieldFromTransactionValue() {
    if (_isAssetTradeInvestment) return;
    _amountFieldSyncGuard = true;
    final v = transactionValue.abs();
    if (v == 0) {
      _amountTextController.text = '';
    } else {
      final rounded = double.parse(v.toStringAsFixed(2));
      final isInt = rounded == rounded.roundToDouble();
      _amountTextController.text = isInt
          ? rounded.toInt().toString()
          : rounded.toString();
    }
    _amountFieldSyncGuard = false;
  }

  void _onTransactionTypeChanged(TransactionType newType) {
    if (newType == transactionType) return;
    transactionType = newType;

    if (transactionType.isTransfer && transactionValue.isNegative) {
      transactionValue = transactionValue * -1;
    }

    if (selectedCategory != null &&
        !transactionType.isTransfer &&
        !selectedCategory!.type.matchWithTransactionType(transactionType)) {
      selectedCategory = null;
    }

    setState(() {});
  }

  void _swapTransferAccounts() {
    if (!transactionType.isTransfer) return;
    setState(() {
      final tmp = fromAccount;
      fromAccount = transferAccount;
      transferAccount = tmp;
    });
  }

  /// Set default values when opening the form (in create mode)
  Future<void> _initializeFormValues() async {
    final settings = await DefaultTransactionValuesService.instance
        .getAllSettings()
        .first;
    final lastTr = DefaultTransactionValuesService.lastCreatedTransaction.value;

    bool useLast(TransactionFormField f) =>
        settings.lastUsedFields.contains(f) && lastTr != null;

    // 1. Account
    if (widget.fromAccount != null) {
      fromAccount = widget.fromAccount;
    } else if (_isAssetTradeInvestment && _asset?.linkedAccountID != null) {
      final acc = await AccountService.instance
          .getAccountById(_asset!.linkedAccountID!)
          .first;
      if (acc != null) fromAccount = acc;
    } else if (useLast(TransactionFormField.account)) {
      final acc = await AccountService.instance
          .getAccountById(lastTr!.transaction.accountID)
          .first;
      if (acc != null) fromAccount = acc;
    }

    // If still null (or not using last), use default logic (first available account)
    if (fromAccount == null) {
      final accounts = await AccountService.instance
          .getAccounts(
            predicate: (acc, curr) => buildDriftExpr([
              acc.type.equalsValue(AccountType.saving).not(),
              acc.closingDate.isNull(),
            ]),
            limit: transactionType.isTransfer ? 2 : 1,
          )
          .first;

      if (accounts.isNotEmpty) {
        fromAccount = accounts[0];
        if (transactionType.isTransfer && accounts.length > 1) {
          transferAccount = accounts[1];
        }
      }
    }

    if (widget.toAccount != null) {
      transferAccount = widget.toAccount;
    }

    if (!_isAssetTradeInvestment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _displayAmountModal(context);
      });
    }

    // 2. Category
    if (!_isAssetTradeInvestment) {
      String? categoryIdToLoad;
      if (useLast(TransactionFormField.category)) {
        categoryIdToLoad = lastTr!.transaction.categoryID;
      } else {
        categoryIdToLoad = settings.values.categoryId;
      }

      if (categoryIdToLoad != null) {
        selectedCategory = await CategoryService.instance
            .getCategoryById(categoryIdToLoad)
            .first;
      }
    }

    // 3. Status
    if (useLast(TransactionFormField.status)) {
      status = lastTr!.transaction.status;
    } else {
      status = settings.values.status;
    }

    // 4. Tags
    List<String>? tagIdsToLoad;
    if (useLast(TransactionFormField.tags)) {
      tagIdsToLoad = lastTr!.tagIds;
    } else {
      tagIdsToLoad = settings.values.tagIds;
    }

    if (tagIdsToLoad != null && tagIdsToLoad.isNotEmpty) {
      tags = await TagService.instance
          .getTags(filter: (t) => t.id.isIn(tagIdsToLoad!))
          .first;
    }

    // 5. Date
    if (useLast(TransactionFormField.date)) {
      date = lastTr!.transaction.date;
    }

    // 6. Note
    if (useLast(TransactionFormField.note)) {
      notesController.text = lastTr!.transaction.notes ?? '';
    }

    _syncAmountFieldFromTransactionValue();
    setState(() {});
  }

  void submitForm() {
    if ((transactionType.isIncomeOrExpense && selectedCategory == null) ||
        (transactionType.isTransfer && transferAccount == null)) {
      _shakeKey.currentState?.shake();
      return;
    }

    final t = Translations.of(context);

    if (_isAssetTradeInvestment && _asset == null) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.general.validations.form_error),
      );
      return;
    }

    if (transactionValue == 0) {
      MonekinSnackbar.warning(
        SnackbarParams(t.transaction.form.validators.zero),
      );

      return;
    }

    if (transactionValue < 0 && transactionType.isTransfer) {
      MonekinSnackbar.warning(
        SnackbarParams(t.transaction.form.validators.negative_transfer),
      );

      return;
    }

    if (fromAccount != null && fromAccount!.date.compareTo(date) > 0) {
      MonekinSnackbar.warning(
        SnackbarParams(
          t.transaction.form.validators.date_after_account_creation,
        ),
      );

      return;
    }

    final newTrID = widget.transactionToEdit?.id ?? generateUUID();

    final double signedValue;
    if (transactionType == TransactionType.expense) {
      signedValue = transactionValue * -1;
    } else if (transactionType == TransactionType.investment &&
        _isAssetTradeInvestment) {
      final abs = transactionValue.abs();
      signedValue = _investmentIsBuy ? -abs : abs;
    } else {
      signedValue = transactionValue;
    }

    final titleTrim = titleController.text.trim();
    final String? resolvedTitle;
    if (titleTrim.isEmpty) {
      resolvedTitle = _isAssetTradeInvestment
          ? (_investmentIsBuy ? t.assets.details.buy : t.assets.details.sell)
          : null;
    } else {
      resolvedTitle = titleTrim;
    }

    final transactionToPost = TransactionInDB(
      id: newTrID,
      date: date,
      type: transactionType,
      accountID: fromAccount!.id,
      value: signedValue,
      isHidden: false,
      status: date.compareTo(DateTime.now()) > 0
          ? TransactionStatus.pending
          : status,
      notes: notesController.text.isEmpty ? null : notesController.text,
      title: resolvedTitle,
      intervalEach: _isAssetTradeInvestment ? null : recurrentRule.intervalEach,
      intervalPeriod: _isAssetTradeInvestment
          ? null
          : recurrentRule.intervalPeriod,
      endDate: _isAssetTradeInvestment
          ? null
          : recurrentRule.ruleRecurrentLimit?.endDate,
      remainingTransactions: _isAssetTradeInvestment
          ? null
          : recurrentRule.ruleRecurrentLimit?.remainingIterations,
      valueInDestiny: transactionType.isTransfer
          ? valueInDestinyToNumber
          : null,
      categoryID: transactionType.isIncomeOrExpense
          ? selectedCategory?.id
          : null,
      debtId: widget.linkedDebt?.id,
      receivingAccountID: transactionType.isTransfer
          ? transferAccount?.id
          : null,
      assetID: _isAssetTradeInvestment
          ? _asset!.id
          : widget.transactionToEdit?.assetID,
    );

    final shouldUpdateAssetValuations =
        !_isAssetTradeInvestment || _updateValuations;
    final shouldUpdateFutureAssetValuations =
        _isAssetTradeInvestment && _updateValuations;

    Future<int> postCall = TransactionService.instance.updateTransaction(
      transactionToPost,
      updateAssetValuations: shouldUpdateAssetValuations,
      updateFutureAssetValuations: shouldUpdateFutureAssetValuations,
    );

    if (!isEditMode) {
      postCall = TransactionService.instance.insertTransaction(
        transactionToPost,
        updateAssetValuations: shouldUpdateAssetValuations,
        updateFutureAssetValuations: shouldUpdateFutureAssetValuations,
      );
    }

    postCall
        .then((value) async {
          final db = AppDB.instance;

          final existingTags = widget.transactionToEdit?.tags ?? [];

          // Tags to remove: present in the current transaction but not in the new tags list
          final tagsToRemove = existingTags
              .where(
                (existingTag) =>
                    !tags.any((newTag) => newTag.id == existingTag.id),
              )
              .toList();

          // Tags to add: present in the new tags list but not in the current transaction
          final tagsToAdd = tags
              .where(
                (newTag) => !existingTags.any(
                  (existingTag) => existingTag.id == newTag.id,
                ),
              )
              .toList();

          try {
            // Remove tags
            for (final tag in tagsToRemove) {
              await (db.delete(db.transactionTags)..where(
                    (tbl) =>
                        tbl.tagID.isValue(tag.id) &
                        tbl.transactionID.isValue(newTrID),
                  ))
                  .go();
            }

            // Add new tags
            await TagService.instance.linkTagsToTransaction(
              transactionId: newTrID,
              tagIds: tagsToAdd.map((t) => t.id).toList(),
            );

            DefaultTransactionValuesService.lastCreatedTransaction.value = (
              transaction: transactionToPost,
              tagIds: tags.map((t) => t.id).toList(),
            );

            RouteUtils.popRoute();

            MonekinSnackbar.success(
              SnackbarParams(
                isEditMode
                    ? t.transaction.edit_success
                    : t.transaction.new_success,
              ),
            );
          } catch (error) {
            if (mounted) RouteUtils.popRoute();
            MonekinSnackbar.error(SnackbarParams.fromError(error));
          }
        })
        .catchError((error) {
          MonekinSnackbar.error(SnackbarParams.fromError(error));
        });
  }

  Future<List<Account>?> showAccountSelector(Account? account) {
    return showAccountSelectorBottomSheet(
      context,
      AccountSelectorModal(
        allowMultiSelection: false,
        filterSavingAccounts: transactionType.isIncomeOrExpense,
        includeArchivedAccounts: false,
        selectedAccounts: [if (account != null) account],
      ),
    );
  }

  Future<void> selectCategory() async {
    final modalRes = await showCategoryPickerModal(
      context,
      modal: CategoryPicker(
        selectedCategory: selectedCategory,
        categoryType: transactionType == TransactionType.expense
            ? [CategoryType.E, CategoryType.B]
            : [CategoryType.I, CategoryType.B],
      ),
    );

    if (modalRes != null) {
      setState(() {
        selectedCategory = modalRes;
      });
    }
  }

  Future<void> _fillForm(MoneyTransaction transaction) async {
    fromAccount = transaction.account;
    transferAccount = transaction.receivingAccount;
    date = transaction.date;
    status = transaction.status;
    selectedCategory = transaction.category;
    recurrentRule = transaction.recurrentInfo;
    tags = [...transaction.tags];

    notesController.text = transaction.notes ?? '';
    titleController.text = transaction.title ?? '';
    transactionValue = transaction.value;
    transactionType = transaction.type;

    if (transactionType == TransactionType.investment) {
      transactionValue = transaction.value.abs();
    } else if (transactionType == TransactionType.expense) {
      transactionValue = transactionValue * -1;
    }

    valueInDestinyController.text =
        transaction.valueInDestiny?.abs().toString() ?? '';

    _syncAmountFieldFromTransactionValue();
    setState(() {});
  }

  Color get foregroundColor {
    if (_isAssetTradeInvestment) {
      return _investmentAccent(context).getContrastColor();
    }
    return transactionType.color(context).getContrastColor();
  }

  /// Green for buy (cash into asset), red for sell (cash out).
  Color _investmentAccent(BuildContext context) => _investmentIsBuy
      ? TransactionType.income.color(context)
      : TransactionType.expense.color(context);

  CurrencyInDB? get _amountDisplayCurrency =>
      _isAssetTradeInvestment ? _asset?.currency : fromAccount?.currency;

  String _resolveFrameworkTitle(Translations t) {
    if (isEditMode) {
      return t.transaction.edit;
    }
    if (_isAssetTradeInvestment) {
      return _investmentIsBuy
          ? t.assets.details.trade_sheet_title_buy
          : t.assets.details.trade_sheet_title_sell;
    }
    return t.transaction.create;
  }

  PreferredSizeWidget _buildStandardTransactionAppBar(Translations t) {
    final accent = transactionType.color(context);
    return AppBar(
      title: Text(_resolveFrameworkTitle(t)),
      centerTitle: false,
      backgroundColor: accent,
      foregroundColor: foregroundColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(124),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTransactionTypeSegmented(context),
              const SizedBox(height: 10),
              _buildAmountInputRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeSegmented(BuildContext context) {
    final fg = foregroundColor;
    final types = [
      TransactionType.income,
      TransactionType.expense,
      TransactionType.transfer,
    ];
    return SegmentedButton<TransactionType>(
      segments: types
          .map(
            (e) => ButtonSegment<TransactionType>(
              value: e,
              label: Text(
                e.displayName(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      selected: {transactionType},
      onSelectionChanged: (next) {
        final v = next.firstOrNull;
        if (v != null) _onTransactionTypeChanged(v);
      },
      showSelectedIcon: false,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: WidgetStateProperty.all(BorderSide(color: fg.withOpacity(0.35))),
        foregroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? fg : fg.withOpacity(0.85),
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? fg.withOpacity(0.22)
              : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildAmountInputRow(BuildContext context) {
    final baseColor = transactionType.color(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(transactionType.mathIcon, color: baseColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _amountTextController,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: twoDecimalDigitFormatter,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              isDense: true,
              fillColor: baseColor,
              border: InputBorder.none,
              hintText: '0',
              hintStyle: TextStyle(
                color: foregroundColor.withOpacity(0.35),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        IconButton.outlined(
          color: foregroundColor,
          style: IconButton.styleFrom(
            side: BorderSide(color: foregroundColor),
            foregroundColor: foregroundColor,
          ),
          onPressed: _openAmountSelectorSheet,
          icon: Icon(Icons.calculate),
        ),
      ],
    );
  }

  Widget _formSectionHeader(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          letterSpacing: 0.85,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildFormCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(inputBorderRadius),
        side: BorderSide(color: scheme.surfaceContainerHighest),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i != 0) Divider(height: 1, color: scheme.outlineVariant),
            children[i],
          ],
        ],
      ),
    );
  }

  Future<void> _openTagPicker() async {
    final value = await showTagListModal(
      context,
      modal: TagSelector(
        selectedTags: tags,
        allowEmptySubmit: true,
        includeNullTag: false,
      ),
    );
    if (value == null || !mounted) return;
    setState(() {
      tags = value.selectedTags.nonNulls.toList();
    });
  }

  Widget _buildTagsStrip(BuildContext context) {
    final t = Translations.of(context);
    final hint = AppColors.of(context).textHint;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _formSectionHeader(context, t.tags.display(n: 10)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              if (tags.isEmpty)
                ActionChip(
                  avatar: Icon(
                    Icons.label_outline_rounded,
                    size: 18,
                    color: hint,
                  ),
                  label: Text(
                    t.tags.select.title,
                    style: TextStyle(color: hint),
                  ),
                  onPressed: _openTagPicker,
                )
              else ...[
                ...tags.map(
                  (tag) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: FilterChip(
                      label: Text(
                        tag.name,
                        style: TextStyle(color: tag.colorData),
                      ),
                      selected: true,
                      onSelected: (_) {
                        setState(() {
                          tags = [...tags]..removeWhere((e) => e.id == tag.id);
                        });
                      },
                      showCheckmark: false,
                      selectedColor: tag.colorData.lighten(0.8),
                      avatar: tag.displayIcon(),
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: _openTagPicker,
                  icon: const Icon(Icons.add_rounded),
                  tooltip: t.ui_actions.add,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentAmountHeader(BuildContext context) {
    return TransactionAmountDisplay(
      transactionType: transactionType,
      transactionValue: transactionValue,
      fromAccount: fromAccount,
      displayCurrencyOverride: _asset?.currency,
      accentColor: _investmentAccent(context),
      mathIconOverride: _investmentIsBuy
          ? TransactionType.income.icon
          : TransactionType.expense.icon,
      onTap: _openAmountSelectorSheet,
    );
  }

  Widget _buildAccountSelectorBlock(BuildContext context) {
    return TransactionAccountSelectorRow(
      transactionType: transactionType,
      fromAccount: fromAccount,
      transferAccount: transferAccount,
      selectedCategory: selectedCategory,
      shakeKey: _shakeKey,
      investmentAssetName: _isAssetTradeInvestment
          ? (_asset?.name ?? '…')
          : null,
      onSwapTransferAccounts: transactionType.isTransfer
          ? _swapTransferAccounts
          : null,
      onFromAccountTap: () async {
        final modalRes = await showAccountSelector(fromAccount);
        if (modalRes != null && modalRes.isNotEmpty) {
          setState(() {
            fromAccount = modalRes.first;
          });
        }
      },
      onTransferAccountTap: () async {
        final modalRes = await showAccountSelector(transferAccount);
        if (modalRes != null && modalRes.isNotEmpty) {
          setState(() {
            transferAccount = modalRes.first;
          });
        }
      },
      onCategoryTap: () => selectCategory(),
    );
  }

  List<Widget> _buildFormFieldSections(
    BuildContext context, {
    required bool showValueIndicator,
  }) {
    final t = Translations.of(context);
    final detailsChildren = <Widget>[
      TransactionTitleField(controller: titleController),
      if (widget.linkedDebt != null &&
          BreakPoint.of(context).isSmallerOrEqualTo(BreakpointID.sm))
        DebtLinkBanner(debt: widget.linkedDebt!),
      TransactionDateSelector(
        date: date,
        fromAccount: fromAccount,
        onDateChanged: (newDate) => setState(() => date = newDate),
      ),
      if (showValueIndicator)
        AssetValuationImpactSection(
          asset: _asset!,
          isBuy: _investmentIsBuy,
          cardMargin: EdgeInsets.zero,
          tradeDate: date,
          tradeAmountAbs: transactionValue.abs(),
          previousSignedValue: isEditMode
              ? widget.transactionToEdit?.value
              : null,
          previousTradeDate: isEditMode ? widget.transactionToEdit?.date : null,
          updateValuations: _updateValuations,
          onUpdateValuationsChanged: (v) =>
              setState(() => _updateValuations = v),
        ),
      if (!_isAssetTradeInvestment)
        TransactionRecurrencySelector(
          recurrentRule: recurrentRule,
          onRecurrencyChanged: (newRule) =>
              setState(() => recurrentRule = newRule),
        ),
      TransactionStatusSelector(
        date: date,
        status: status,
        onStatusChanged: (newStatus) => setState(() => status = newStatus),
      ),
    ];

    final extraChildren = <Widget>[
      if (transactionType.isTransfer)
        TransactionValueInDestinyField(
          controller: valueInDestinyController,
          transferAccount: transferAccount,
          onChanged: () => setState(() {}),
        ),
      TransactionDescriptionField(controller: notesController),
    ];

    return [
      _formSectionHeader(context, t.general.details),
      _buildFormCard(context, children: detailsChildren),
      const SizedBox(height: 4),
      _buildTagsStrip(context),
      const SizedBox(height: 8),
      _buildFormCard(context, children: extraChildren),
    ];
  }

  Widget _paddedScrollableColumn({
    required List<Widget> children,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(16, 16, 16, 24),
  }) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final pageBg = Color.alphaBlend(
      scheme.surfaceTint.withOpacity(0.04),
      scheme.surface,
    );

    final showValueIndicator =
        _asset != null && _isAssetTradeInvestment && transactionValue.abs() > 0;

    final formSections = _buildFormFieldSections(
      context,
      showValueIndicator: showValueIndicator,
    );

    final accountBlock = _buildAccountSelectorBlock(context);

    final mdLeadingColumn = _paddedScrollableColumn(
      children: [
        if (_isAssetTradeInvestment) _buildInvestmentAmountHeader(context),
        accountBlock,
        if (widget.linkedDebt != null &&
            BreakPoint.of(context).isLargerThan(BreakpointID.sm)) ...[
          const SizedBox(height: 16),
          DebtLinkBanner(debt: widget.linkedDebt!, padding: EdgeInsets.zero),
        ],
      ],
    );

    final mdTrailingColumn = _paddedScrollableColumn(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 24),
      children: formSections,
    );

    final mobileScrollChildren = <Widget>[
      if (_isAssetTradeInvestment) _buildInvestmentAmountHeader(context),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: accountBlock,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: formSections,
        ),
      ),
    ];

    final saveLabel = isEditMode
        ? t.transaction.edit
        : _isAssetTradeInvestment
        ? t.transaction.create
        : '${t.ui_actions.save} ${transactionType.displayName(context)}';

    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      top: BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md),
      child: ColoredBox(
        color: pageBg,
        child: PageFramework(
          title: _resolveFrameworkTitle(t),
          appBarBackgroundColor: (_isAssetTradeInvestment
              ? _investmentAccent(context)
              : transactionType.color(context)),
          appBarForegroundColor: foregroundColor,
          appBarBuilder: _isAssetTradeInvestment
              ? null
              : (
                  String title,
                  TabBar? unusedTab,
                  List<Widget>? unusedActions,
                ) => _buildStandardTransactionAppBar(t),
          persistentFooterButtons: [
            PersistentFooterButton(
              child: FilledButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    submitForm();
                  } else {
                    MonekinSnackbar.error(
                      SnackbarParams(t.general.validations.form_error),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: Text(saveLabel),
              ),
            ),
          ],
          body: Form(
            key: _formKey,
            child: BreakpointContainer(
              mdChild: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: mdLeadingColumn),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: scheme.outlineVariant,
                  ),
                  Expanded(child: mdTrailingColumn),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: _paddedScrollableColumn(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                      children: mobileScrollChildren,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openAmountSelectorSheet() {
    final tr = Translations.of(context);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => AmountSelector(
        title: tr.transaction.form.value,
        initialAmount: transactionValue,
        enableSignToggleButton: transactionType.isIncomeOrExpense,
        currency: _amountDisplayCurrency ?? fromAccount?.currency,
        onSubmit: (amount) {
          setState(() {
            transactionValue = _isAssetTradeInvestment ? amount.abs() : amount;
            if (!_isAssetTradeInvestment) {
              _syncAmountFieldFromTransactionValue();
            }
            RouteUtils.popRoute();
          });
        },
      ),
    );
  }

  void _displayAmountModal(BuildContext context) {
    _openAmountSelectorSheet();
  }
}

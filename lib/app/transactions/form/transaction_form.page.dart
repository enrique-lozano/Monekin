import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/assets/asset_trade_valuation.dart';
import 'package:monekin/app/assets/widgets/asset_valuation_impact_section.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/form/dialogs/amount_selector.dart';
import 'package:monekin/app/transactions/form/widgets/debt_link_banner.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_account_selector_row.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_amount_display.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_date_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_fields.dart';
import 'package:monekin/app/transactions/form/asset_trade_form_context.dart';
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
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
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

  /// Opens the form in locked investment mode for a new buy/sell on [asset].
  final AssetTradeFormContext? assetTradeContext;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  TabController? _tabController;

  Asset? _lockedAsset;
  bool _assetTradeIsBuy = true;
  bool _updateLaterValuations = false;

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

  bool get isEditMode => widget.transactionToEdit != null;

  late TransactionType transactionType;

  bool get _isLockedInvestmentAssetForm {
    if (widget.assetTradeContext != null) return true;
    final edit = widget.transactionToEdit;
    return edit != null &&
        edit.type == TransactionType.investment &&
        edit.assetID != null;
  }

  @override
  void initState() {
    super.initState();
    assert(
      widget.assetTradeContext == null || widget.transactionToEdit == null,
    );

    if (_isLockedInvestmentAssetForm) {
      transactionType = TransactionType.investment;
      if (widget.transactionToEdit != null) {
        _fillForm(widget.transactionToEdit!);
        unawaited(_loadLockedAssetForEdit());
        return;
      }
      if (widget.assetTradeContext != null) {
        _lockedAsset = widget.assetTradeContext!.asset;
        _assetTradeIsBuy = widget.assetTradeContext!.isBuy;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final tr = Translations.of(context);
          titleController.text = _assetTradeIsBuy
              ? tr.assets.details.buy
              : tr.assets.details.sell;
          await _initializeFormValues();
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

    _tabController = TabController(
      length: 3,
      initialIndex: math.min(transactionType.index, 2),
      vsync: this,
    );

    _tabController!.addListener(_onTabSelectionChanged);

    if (widget.transactionToEdit != null) {
      _fillForm(widget.transactionToEdit!);
      return;
    }

    _initializeFormValues();
  }

  Future<void> _loadLockedAssetForEdit() async {
    final id = widget.transactionToEdit?.assetID;
    if (id == null) return;
    final asset = await InvestmentService.instance.getAssetById(id).first;
    if (mounted) setState(() => _lockedAsset = asset);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _onTabSelectionChanged() {
    final c = _tabController;
    if (c == null || c.indexIsChanging) return;
    transactionType = TransactionType.values.elementAt(c.index);

    // Function to execute when the transaction mode change:
    if (transactionType.isTransfer && transactionValue.isNegative) {
      transactionValue = transactionValue * -1;
    }

    if (selectedCategory != null &&
        !transactionType.isTransfer &&
        !selectedCategory!.type.matchWithTransactionType(transactionType)) {
      // Unselect the selected category if the transactionType don't match
      selectedCategory = null;
    }

    setState(() {});
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
    } else if (_isLockedInvestmentAssetForm &&
        _lockedAsset?.linkedAccountID != null) {
      final acc = await AccountService.instance
          .getAccountById(_lockedAsset!.linkedAccountID!)
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

    if (!_isLockedInvestmentAssetForm) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _displayAmountModal(context);
      });
    }

    // 2. Category
    if (!_isLockedInvestmentAssetForm) {
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

    setState(() {});
  }

  void submitForm() {
    if ((transactionType.isIncomeOrExpense && selectedCategory == null) ||
        (transactionType.isTransfer && transferAccount == null)) {
      _shakeKey.currentState?.shake();
      return;
    }

    final t = Translations.of(context);

    if (_isLockedInvestmentAssetForm && _lockedAsset == null) {
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
        _isLockedInvestmentAssetForm) {
      final abs = transactionValue.abs();
      signedValue = _assetTradeIsBuy ? -abs : abs;
    } else {
      signedValue = transactionValue;
    }

    final titleTrim = titleController.text.trim();
    final String? resolvedTitle;
    if (titleTrim.isEmpty) {
      resolvedTitle = _isLockedInvestmentAssetForm
          ? (_assetTradeIsBuy ? t.assets.details.buy : t.assets.details.sell)
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
      intervalEach: _isLockedInvestmentAssetForm
          ? null
          : recurrentRule.intervalEach,
      intervalPeriod: _isLockedInvestmentAssetForm
          ? null
          : recurrentRule.intervalPeriod,
      endDate: _isLockedInvestmentAssetForm
          ? null
          : recurrentRule.ruleRecurrentLimit?.endDate,
      remainingTransactions: _isLockedInvestmentAssetForm
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
      assetID: _isLockedInvestmentAssetForm
          ? _lockedAsset!.id
          : widget.transactionToEdit?.assetID,
    );

    Future<int> postCall = TransactionService.instance.updateTransaction(
      transactionToPost,
    );

    if (!isEditMode) {
      postCall = TransactionService.instance.insertTransaction(
        transactionToPost,
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

            if (_isLockedInvestmentAssetForm && _lockedAsset != null) {
              await shiftFollowingValuationsForTradeEdit(
                assetId: _lockedAsset!.id,
                tradeDate: date,
                previousSignedValue: widget.transactionToEdit?.value ?? 0,
                newSignedValue: signedValue,
                applyShift: _updateLaterValuations,
              );
            }

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
      _assetTradeIsBuy = transaction.value.isNegative;
    } else if (transactionType == TransactionType.expense) {
      transactionValue = transactionValue * -1;
    }

    valueInDestinyController.text =
        transaction.valueInDestiny?.abs().toString() ?? '';

    setState(() {});
  }

  Color get foregroundColor {
    if (_isLockedInvestmentAssetForm) {
      return _lockedAssetTradeAccent(context).getContrastColor();
    }
    return transactionType.color(context).getContrastColor();
  }

  Color _lockedAssetTradeAccent(BuildContext context) => _assetTradeIsBuy
      ? TransactionType.income.color(context)
      : TransactionType.expense.color(context);

  CurrencyInDB? get _amountDisplayCurrency =>
      _isLockedInvestmentAssetForm ? _lockedAsset?.currency : fromAccount?.currency;

  Widget _buildHeader(BuildContext context) {
    final t = Translations.of(context);
    return RepaintBoundary(
      child: Column(
        children: [
          if (_isLockedInvestmentAssetForm) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _lockedAssetTradeAccent(context).withOpacity(0.22),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _lockedAssetTradeAccent(context).withOpacity(0.55),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _assetTradeIsBuy
                              ? Icons.add_circle_outline
                              : Icons.remove_circle_outline,
                          size: 18,
                          color: _lockedAssetTradeAccent(context),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            _assetTradeIsBuy
                                ? t.assets.details.buy
                                : t.assets.details.sell,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: _lockedAssetTradeAccent(context),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          TransactionAmountDisplay(
            transactionType: transactionType,
            transactionValue: transactionValue,
            fromAccount: fromAccount,
            displayCurrencyOverride: _isLockedInvestmentAssetForm
                ? _lockedAsset?.currency
                : null,
            accentColor: _isLockedInvestmentAssetForm
                ? _lockedAssetTradeAccent(context)
                : null,
            mathIconOverride: _isLockedInvestmentAssetForm
                ? (_assetTradeIsBuy ? Icons.add : Icons.remove)
                : null,
            onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (context) => AmountSelector(
                title: t.transaction.form.value,
                initialAmount: transactionValue,
                enableSignToggleButton: transactionType.isIncomeOrExpense,
                currency: _amountDisplayCurrency ?? fromAccount?.currency,
                onSubmit: (amount) {
                  setState(() {
                    transactionValue = _isLockedInvestmentAssetForm
                        ? amount.abs()
                        : amount;
                    RouteUtils.popRoute();
                  });
                },
              ),
            );
          },
        ),
        TransactionAccountSelectorRow(
          transactionType: transactionType,
          fromAccount: fromAccount,
          transferAccount: transferAccount,
          selectedCategory: selectedCategory,
          shakeKey: _shakeKey,
          rowAccentColor: _isLockedInvestmentAssetForm
              ? _lockedAssetTradeAccent(context)
              : null,
          investmentAssetName: _isLockedInvestmentAssetForm
              ? (_lockedAsset?.name ?? '…')
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
        ),
        if (widget.linkedDebt != null &&
            BreakPoint.of(context).isLargerThan(BreakpointID.sm)) ...[
          const SizedBox(height: 24),
          DebtLinkBanner(
            debt: widget.linkedDebt!,
            padding: EdgeInsets.zero,
          ),
        ],
      ],
    ),
    );
  }

  String _resolveFrameworkTitle(Translations t) {
    if (isEditMode) {
      return t.transaction.edit;
    }
    if (_isLockedInvestmentAssetForm) {
      return _assetTradeIsBuy
          ? t.assets.details.trade_sheet_title_buy
          : t.assets.details.trade_sheet_title_sell;
    }
    if (transactionType == TransactionType.transfer) {
      return t.transfer.create;
    }
    if (transactionType == TransactionType.expense) {
      return t.transaction.new_expense;
    }
    return t.transaction.new_income;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final formFieldWithDividers = [
      TransactionTitleField(controller: titleController),
      if (widget.linkedDebt != null &&
          BreakPoint.of(context).isSmallerOrEqualTo(BreakpointID.sm)) ...[
        DebtLinkBanner(debt: widget.linkedDebt!),
        const Divider(),
      ],
      const Divider(),
      TransactionDateSelector(
        date: date,
        fromAccount: fromAccount,
        onDateChanged: (newDate) => setState(() => date = newDate),
      ),
      const Divider(),
      if (_lockedAsset != null && _isLockedInvestmentAssetForm) ...[
        AssetValuationImpactSection(
          asset: _lockedAsset!,
          isBuy: _assetTradeIsBuy,
          tradeDate: date,
          tradeAmountAbs: transactionValue.abs(),
          isEditingExistingTransaction: isEditMode,
          updateLaterValuations: _updateLaterValuations,
          onUpdateLaterValuationsChanged: (v) =>
              setState(() => _updateLaterValuations = v),
        ),
        const Divider(),
      ],
      if (!_isLockedInvestmentAssetForm) ...[
        TransactionRecurrencySelector(
          recurrentRule: recurrentRule,
          onRecurrencyChanged: (newRule) =>
              setState(() => recurrentRule = newRule),
        ),
        const Divider(),
      ],
      TransactionStatusSelector(
        date: date,
        status: status,
        onStatusChanged: (newStatus) => setState(() => status = newStatus),
      ),
      const Divider(),
      TransactionTagsSelector(
        tags: tags,
        onTagsChanged: (newTags) => setState(() => tags = newTags),
      ),
      const Divider(),
      if (transactionType.isTransfer) ...[
        TransactionValueInDestinyField(
          controller: valueInDestinyController,
          transferAccount: transferAccount,
          onChanged: () => setState(() {}),
        ),
        const Divider(),
      ],
      TransactionDescriptionField(controller: notesController),
      const Divider(),
    ];

    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      top: BreakPoint.of(context).isLargerOrEqualTo(BreakpointID.md),
      child: PageFramework(
        title: _resolveFrameworkTitle(t),
        appBarBackgroundColor: (_isLockedInvestmentAssetForm
                ? _lockedAssetTradeAccent(context)
                : transactionType.color(context))
            .withOpacity(0.85),
        appBarForegroundColor: foregroundColor,
        tabBar: _tabController == null
            ? null
            : TabBar(
                indicatorColor: foregroundColor,
                labelColor: foregroundColor,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                unselectedLabelColor: foregroundColor.withOpacity(0.8),
                tabAlignment: TabAlignment.fill,
                dividerColor: transactionType.color(context).darken(0.3),
                controller: _tabController!,
                tabs: TransactionType.values
                    .where((type) => type != TransactionType.investment)
                    .map((tType) => Tab(text: tType.displayName(context)))
                    .toList(),
                isScrollable: false,
              ),
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
              label: Text(
                isEditMode ? t.transaction.edit : t.transaction.create,
              ),
            ),
          ),
        ],
        body: Form(
          key: _formKey,
          child: BreakpointContainer(
            mdChild: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [_buildHeader(context)]),
                  ),
                ),
                const VerticalDivider(thickness: 2),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 16,
                    ),
                    child: Column(children: formFieldWithDividers),
                  ),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),

                //   const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    child: Column(children: formFieldWithDividers),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _displayAmountModal(BuildContext context) {
    final tr = Translations.of(context);
    showModalBottomSheet(
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
            transactionValue = _isLockedInvestmentAssetForm
                ? amount.abs()
                : amount;
            RouteUtils.popRoute();
          });
        },
      ),
    );
  }
}

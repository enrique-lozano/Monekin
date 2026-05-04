import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/assets/asset_trade_valuation.dart';
import 'package:monekin/app/assets/widgets/asset_valuation_impact_section.dart';
import 'package:monekin/app/transactions/form/asset_trade_form_context.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Buy / sell against an asset (creates a transaction + auto valuation).
Future<void> showAssetTradeSheet(
  BuildContext context, {
  required Asset asset,
  required bool isBuy,

  TransactionInDB? transaction,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) =>
        _AssetTradeSheet(asset: asset, isBuy: isBuy, transaction: transaction),
  );
}

class _AssetTradeSheet extends StatefulWidget {
  const _AssetTradeSheet({
    required this.asset,
    required this.isBuy,
    this.transaction,
  });

  final Asset asset;
  final bool isBuy;
  final TransactionInDB? transaction;

  @override
  State<_AssetTradeSheet> createState() => _AssetTradeSheetState();
}

class _AssetTradeSheetState extends State<_AssetTradeSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  DateTime _date = DateTime.now();
  Account? _account;
  Category? _expenseCategory;
  bool _treatAsInvestment = false;
  bool _updateLaterValuations = false;

  @override
  void initState() {
    super.initState();

    final tr = widget.transaction;

    if (tr != null) {
      // EDIT MODE
      _date = tr.date;
      _amountController.text = tr.value.abs().toString();
      _treatAsInvestment = tr.type == TransactionType.investment;
    } else {
      // CREATE MODE
      _treatAsInvestment = widget.asset.assetType.isFinancial;
    }

    _prefillAccount();
    _prefillExpenseCategory();
  }

  Future<void> _prefillAccount() async {
    if (widget.transaction != null) {
      final acc = await AccountService.instance
          .getAccountById(widget.transaction!.accountID)
          .first;
      if (mounted) setState(() => _account = acc);
      return;
    }

    final linkedId = widget.asset.linkedAccountID;
    if (linkedId != null) {
      final linkedAcc =
          await AccountService.instance.getAccountById(linkedId).first;
      if (linkedAcc != null && mounted) {
        setState(() => _account = linkedAcc);
        return;
      }
    }

    final accounts = await AccountService.instance
        .getAccounts(
          predicate: (acc, curr) => buildDriftExpr([
            acc.type.equalsValue(AccountType.saving).not(),
            acc.closingDate.isNull(),
          ]),
          limit: 1,
        )
        .first;

    if (accounts.isNotEmpty && mounted) {
      setState(() => _account = accounts.first);
    }
  }

  Future<void> _prefillExpenseCategory() async {
    if (widget.transaction?.categoryID != null) {
      final cats = await CategoryService.instance.getCategories().first;

      final match = cats.firstWhere(
        (c) => c.id == widget.transaction!.categoryID,
        orElse: () => cats.first,
      );

      if (mounted) setState(() => _expenseCategory = match);
      return;
    }

    final cats = await CategoryService.instance
        .getCategories(
          predicate: (c, pc) => buildDriftExpr([
            c.parentCategoryID.isNull(),
            c.type.isInValues([CategoryType.E, CategoryType.B]),
          ]),
        )
        .first;
    if (cats.isNotEmpty && mounted) {
      setState(() => _expenseCategory = cats.first);
    }
  }

  double? get _parsedTradeAmount {
    final abs = double.tryParse(_amountController.text.replaceAll(',', '.'));
    return abs != null && abs > 0 ? abs : null;
  }

  TransactionType _resolvedType() {
    if (widget.asset.assetType.isFinancial || _treatAsInvestment) {
      return TransactionType.investment;
    }
    return TransactionType.expense;
  }

  Future<void> _submit() async {
    final t = Translations.of(context);

    if (_formKey.currentState?.validate() != true) {
      MonekinSnackbar.error(
        SnackbarParams(t.general.validations.form_error),
      );
      return;
    }

    final abs = double.tryParse(_amountController.text.replaceAll(',', '.'));
    if (abs == null || abs <= 0) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.assets.form.initial_value_invalid),
      );
      return;
    }

    final type = _resolvedType();

    if (type == TransactionType.expense && _expenseCategory == null) {
      MonekinSnackbar.error(SnackbarParams.fromError(t.general.categories));
      return;
    }

    final value = widget.isBuy ? -abs : abs;

    final isEditing = widget.transaction != null;

    final tr = TransactionInDB(
      id: isEditing ? widget.transaction!.id : generateUUID(),
      date: _date,
      accountID: _account!.id,
      value: value,
      title: widget.isBuy ? t.assets.details.buy : t.assets.details.sell,
      type: type,
      status: TransactionStatus.reconciled,
      categoryID: type == TransactionType.expense ? _expenseCategory!.id : null,
      receivingAccountID: null,
      isHidden: false,
      assetID: widget.asset.id,
    );

    if (isEditing) {
      await TransactionService.instance.updateTransaction(tr);
    } else {
      await TransactionService.instance.insertTransaction(tr);
    }

    await shiftFollowingValuationsForTradeEdit(
      assetId: widget.asset.id,
      tradeDate: _date,
      previousSignedValue: widget.transaction?.value ?? 0,
      newSignedValue: value,
      applyShift: _updateLaterValuations,
    );

    if (mounted) Navigator.of(context).pop();

    MonekinSnackbar.success(
      SnackbarParams(isEditing ? t.ui_actions.edit : t.ui_actions.save),
    );
  }

  void _openFullForm() {
    Navigator.of(context).pop();
    RouteUtils.pushRoute(
      TransactionFormPage(
        assetTradeContext: AssetTradeFormContext(
          asset: widget.asset,
          isBuy: widget.isBuy,
        ),
        fromAccount: _account,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: widget.isBuy
          ? t.assets.details.trade_sheet_title_buy
          : t.assets.details.trade_sheet_title_sell,
      subtitle: widget.isBuy
          ? t.assets.details.trade_sheet_description_buy
          : t.assets.details.trade_sheet_description_sell,
      bodyPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: decimalDigitFormatter(
                widget.asset.currency.decimalPlaces,
              ),
              decoration: InputDecoration(labelText: t.transaction.form.value),
              onChanged: (_) => setState(() {}),
            ),
          const SizedBox(height: 12),

          DateTimeFormField(
            mode: DateTimeFieldPickerMode.date,
            decoration: InputDecoration(labelText: t.general.time.date),
            initialDate: _date,
            firstDate: DateTime(2000),
            lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
            onDateSelected: (picked) {
              setState(() => _date = picked);
            },
          ),
          const SizedBox(height: 12),
          AssetValuationImpactSection(
            asset: widget.asset,
            isBuy: widget.isBuy,
            tradeDate: _date,
            tradeAmountAbs: _parsedTradeAmount,
            isEditingExistingTransaction: widget.transaction != null,
            updateLaterValuations: _updateLaterValuations,
            onUpdateLaterValuationsChanged: (v) =>
                setState(() => _updateLaterValuations = v),
          ),
          const SizedBox(height: 12),

          StreamBuilder<List<Account>>(
            stream: AccountService.instance.getAccounts(),
            builder: (context, snap) {
              final accounts = snap.data ?? [];
              if (_account != null &&
                  accounts.isNotEmpty &&
                  !accounts.any((a) => a.id == _account!.id)) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) setState(() => _account = null);
                });
              }

              final valueInList =
                  _account != null &&
                      accounts.any((a) => a.id == _account!.id)
                  ? _account
                  : null;

              final items = accounts.isEmpty
                  ? <DropdownMenuItem<Account?>>[
                      DropdownMenuItem<Account?>(
                        value: null,
                        child: Text(t.general.unspecified),
                      ),
                    ]
                  : accounts
                      .map(
                        (a) => DropdownMenuItem<Account?>(
                          value: a,
                          child: Text(a.name),
                        ),
                      )
                      .toList();

              return DropdownButtonFormField<Account?>(
                value: accounts.isEmpty ? null : valueInList,
                decoration: InputDecoration(
                  labelText: t.general.account,
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(left: 16, right: 4),
                    child:
                        valueInList?.displayIcon(context) ??
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
                hint: accounts.isNotEmpty && valueInList == null
                    ? Text(t.general.unspecified)
                    : null,
                items: items,
                validator: (value) {
                  if (accounts.isEmpty || value == null) {
                    return t.general.validations.required;
                  }
                  return null;
                },
                onChanged: accounts.isEmpty
                    ? null
                    : (a) => setState(() => _account = a),
              );
            },
          ),
          if (!widget.asset.assetType.isFinancial)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.assets.details.treat_as_investment),
              value: _treatAsInvestment,
              onChanged: (v) => setState(() => _treatAsInvestment = v),
            ),
          if (_resolvedType() == TransactionType.expense && !_treatAsInvestment)
            StreamBuilder<List<Category>>(
              stream: CategoryService.instance.getCategories(
                predicate: (c, pc) => buildDriftExpr([
                  c.parentCategoryID.isNull(),
                  c.type.isInValues([CategoryType.E, CategoryType.B]),
                ]),
              ),
              builder: (context, snap) {
                final cats = snap.data ?? [];
                return DropdownButtonFormField<Category>(
                  value: _expenseCategory,
                  decoration: InputDecoration(labelText: t.general.category),
                  items: cats
                      .map(
                        (c) => DropdownMenuItem(value: c, child: Text(c.name)),
                      )
                      .toList(),
                  onChanged: (c) => setState(() => _expenseCategory = c),
                );
              },
            ),

          const SizedBox(height: 16),
        ],
        ),
      ),

      footer: BottomSheetFooter(
        extraActions: [
          ListTileActionItem(
            label: t.assets.details.trade_sheet_full_form,
            icon: Icons.article_outlined,
            onClick: _openFullForm,
          ),
        ],
        onSaved: _submit,
      ),
    );
  }
}

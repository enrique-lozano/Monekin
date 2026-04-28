import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Buy / sell against an asset (creates a transaction + auto valuation).
Future<void> showAssetTradeSheet({
  required BuildContext context,
  required Asset asset,
  required bool isBuy,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => _AssetTradeSheet(asset: asset, isBuy: isBuy),
  );
}

class _AssetTradeSheet extends StatefulWidget {
  const _AssetTradeSheet({required this.asset, required this.isBuy});

  final Asset asset;
  final bool isBuy;

  @override
  State<_AssetTradeSheet> createState() => _AssetTradeSheetState();
}

class _AssetTradeSheetState extends State<_AssetTradeSheet> {
  final _amountController = TextEditingController();
  DateTime _date = DateTime.now();
  Account? _account;
  Category? _expenseCategory;
  bool _treatAsInvestment = false;

  @override
  void initState() {
    super.initState();
    _treatAsInvestment = widget.asset.assetType.isFinancial;
    _prefillAccount();
    _prefillExpenseCategory();
  }

  Future<void> _prefillAccount() async {
    final linkedId = widget.asset.linkedAccountID;
    if (linkedId == null) return;
    final acc = await AccountService.instance.getAccountById(linkedId).first;
    if (mounted) setState(() => _account = acc);
  }

  Future<void> _prefillExpenseCategory() async {
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

  TransactionType _resolvedType() {
    if (widget.asset.assetType.isFinancial || _treatAsInvestment) {
      return TransactionType.investment;
    }
    return TransactionType.expense;
  }

  Future<void> _submit() async {
    final t = Translations.of(context);
    final abs = double.tryParse(_amountController.text.replaceAll(',', '.'));
    if (abs == null || abs <= 0) {
      MonekinSnackbar.error(SnackbarParams.fromError(t.assets.form.initial_value_invalid));
      return;
    }
    if (_account == null) {
      MonekinSnackbar.error(SnackbarParams.fromError(t.assets.details.select_account));
      return;
    }

    final type = _resolvedType();
    if (type == TransactionType.expense && _expenseCategory == null) {
      MonekinSnackbar.error(SnackbarParams.fromError(t.general.categories));
      return;
    }

    final value = widget.isBuy ? -abs : abs;
    final tr = TransactionInDB(
      id: generateUUID(),
      date: _date,
      accountID: _account!.id,
      value: value,
      title: widget.isBuy ? t.assets.details.buy : t.assets.details.sell,
      notes: t.assets.details.trade_valuation_notice,
      type: type,
      status: TransactionStatus.reconciled,
      categoryID: type == TransactionType.expense ? _expenseCategory!.id : null,
      receivingAccountID: null,
      isHidden: false,
      assetID: widget.asset.id,
    );

    await TransactionService.instance.insertTransaction(tr);
    if (mounted) Navigator.of(context).pop();
    MonekinSnackbar.success(SnackbarParams(t.ui_actions.save));
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isBuy ? t.assets.details.trade_sheet_title_buy : t.assets.details.trade_sheet_title_sell,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(t.assets.details.trade_valuation_notice, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: t.transaction.form.value,
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(t.general.time.date),
            subtitle: Text(MaterialLocalizations.of(context).formatMediumDate(_date)),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
              );
              if (picked != null) setState(() => _date = picked);
            },
          ),
          StreamBuilder<List<Account>>(
            stream: AccountService.instance.getAccounts(),
            builder: (context, snap) {
              final accounts = snap.data ?? [];
              return DropdownButtonFormField<Account>(
                value: _account,
                decoration: InputDecoration(labelText: t.general.account),
                items: accounts
                    .map(
                      (a) => DropdownMenuItem(
                        value: a,
                        child: Text(a.name),
                      ),
                    )
                    .toList(),
                onChanged: (a) => setState(() => _account = a),
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
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c.name),
                        ),
                      )
                      .toList(),
                  onChanged: (c) => setState(() => _expenseCategory = c),
                );
              },
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _submit,
            child: Text(t.ui_actions.submit),
          ),
        ],
      ),
    );
  }
}

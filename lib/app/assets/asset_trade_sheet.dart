import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
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
    if (linkedId == null) return;

    final acc = await AccountService.instance.getAccountById(linkedId).first;
    if (mounted) setState(() => _account = acc);
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

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      symbol: widget.asset.currency.symbol,
      decimalDigits: widget.asset.currency.decimalPlaces,
    ).format(amount);
  }

  bool _isAfterCalendarDay(DateTime candidate, DateTime reference) {
    final candidateDate = DateTime(
      candidate.year,
      candidate.month,
      candidate.day,
    );
    final referenceDate = DateTime(
      reference.year,
      reference.month,
      reference.day,
    );
    return candidateDate.isAfter(referenceDate);
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
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.assets.form.initial_value_invalid),
      );
      return;
    }

    if (_account == null) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.assets.details.select_account),
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

    // * Important: valuation delta fix when editing
    if (_updateLaterValuations) {
      final previousValue = widget.transaction?.value ?? 0;
      final delta = -(value - previousValue);

      final valuations = await InvestmentService.instance
          .getValuationsForAsset(widget.asset.id)
          .first;

      final laterValuations = valuations
          .where((v) => _isAfterCalendarDay(v.date, _date))
          .toList();

      if (laterValuations.isNotEmpty) {
        await Future.wait(
          laterValuations.map(
            (valuation) => InvestmentService.instance.insertOrUpdateValuation(
              valuation.copyWith(value: valuation.value + delta),
            ),
          ),
        );
      }
    }

    if (mounted) Navigator.of(context).pop();

    MonekinSnackbar.success(
      SnackbarParams(isEditing ? t.ui_actions.edit : t.ui_actions.save),
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
      body: Column(
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
          Builder(
            builder: (context) {
              final amount = _parsedTradeAmount ?? 0;
              return AnimatedExpanded(
                expand: _parsedTradeAmount != null,
                child: StreamBuilder(
                  stream: InvestmentService.instance.getAssetValueAtDate(
                    widget.asset,
                    date: _date,
                  ),
                  builder: (context, snapshot) {
                    final originalValue =
                        snapshot.data ?? widget.asset.initialValue;

                    final transactionValue = widget.isBuy ? -amount! : amount!;
                    final updatedValue = originalValue - transactionValue;
                    final formattedDate = DateFormat.yMMMd(
                      Localizations.localeOf(context).toString(),
                    ).format(_date);

                    final infoText = t.assets.details
                        .trade_sheet_update_value_info(
                          date: formattedDate,
                          value: _formatCurrency(updatedValue),
                        );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InlineInfoCard(
                          mode: InlineInfoCardMode.info,
                          text: infoText,
                          margin: const EdgeInsets.only(bottom: 12),
                        ),
                        StreamBuilder(
                          stream: InvestmentService.instance
                              .getValuationsForAsset(widget.asset.id),
                          builder: (context, valuationsSnap) {
                            final laterValuations = (valuationsSnap.data ?? [])
                                .where(
                                  (valuation) => _isAfterCalendarDay(
                                    valuation.date,
                                    _date,
                                  ),
                                )
                                .toList();
                            if (laterValuations.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            final warningText = t.assets.details
                                .trade_sheet_following_valuations_warning(
                                  date: formattedDate,
                                );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InlineInfoCard(
                                  mode: InlineInfoCardMode.warn,
                                  text: warningText,
                                  margin: const EdgeInsets.only(bottom: 12),
                                ),
                                SwitchListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    t
                                        .assets
                                        .details
                                        .trade_sheet_update_following_valuations,
                                  ),
                                  subtitle: Text(
                                    t
                                        .assets
                                        .details
                                        .trade_sheet_update_following_valuations_description,
                                  ),
                                  value: _updateLaterValuations,
                                  onChanged: (value) => setState(
                                    () => _updateLaterValuations = value,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          StreamBuilder<List<Account>>(
            stream: AccountService.instance.getAccounts(),
            builder: (context, snap) {
              final accounts = snap.data ?? [];
              return DropdownButtonFormField<Account>(
                initialValue: _account,
                decoration: InputDecoration(
                  labelText: t.general.account,
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(left: 16, right: 4),
                    child: _account?.displayIcon(context),
                  ),
                ),
                items: accounts
                    .map((a) => DropdownMenuItem(value: a, child: Text(a.name)))
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
                  initialValue: _expenseCategory,
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

      footer: BottomSheetFooter(onSaved: _submit),
    );
  }
}

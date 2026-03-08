import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/widgets/balance_currency_form_field.dart';
import 'package:monekin/app/debts/components/transaction_selector.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/icon_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class DebtFormPage extends StatefulWidget {
  const DebtFormPage({super.key, this.debt, this.type})
    : assert(
        debt != null || type != null,
        'Either debt (for editing) or type (for creation) must be provided',
      );

  /// Existing debt to edit. When non-null, the form operates in edit mode
  /// showing a single flat form pre-populated with the debt's current data.
  final Debt? debt;

  /// The direction type for a brand-new debt. Required when [debt] is null.
  final DebtDirection? type;

  bool get isEditing => debt != null;

  @override
  State<DebtFormPage> createState() => _DebtFormPageState();
}

class _DebtFormPageState extends State<DebtFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  int _radioValue = 1;

  MoneyTransaction? _transaction;
  Currency? _currency;

  DateTime _openingDate = DateTime.now();
  DateTime? _closeDate;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController(
    text: '0',
  );

  double get _initialAmount => double.tryParse(_amountController.text) ?? 0;

  SupportedIcon _icon = SupportedIconService.instance.defaultSupportedIcon;

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      final debt = widget.debt!;
      _nameController.text = debt.name;
      _amountController.text = debt.initialAmount.toString();
      _openingDate = debt.startDate;
      _closeDate = debt.endDate;
      _currency = Currency.fromDB(currencyInDB: debt.currency);
      _icon = SupportedIconService.instance.getIconByID(debt.iconId);
    } else {
      CurrencyService.instance.ensureAndGetPreferredCurrency().first.then((
        value,
      ) {
        setState(() {
          _currency = value;
        });
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: widget.isEditing
          ? widget.debt!.name
          : t.debts.actions.create.title,
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: _submitButtonEnabled(t) ? () => submitForm() : null,
            icon: const Icon(Icons.save),
            label: Text(
              widget.isEditing ? t.ui_actions.save : t.ui_actions.add,
            ),
          ),
        ),
      ],
      body: widget.isEditing
          ? _buildEditBody(context, t)
          : _buildAddBody(context, t),
    );
  }

  /// The submit button is always enabled in edit mode (validation runs inside
  /// [submitForm]). In add mode it is disabled on step 0 and when the
  /// step-2 form is invalid.
  bool _submitButtonEnabled(Translations t) {
    if (widget.isEditing) return true;
    return _currentStep != 0 && (_formKey.currentState?.validate() ?? false);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Edit layout – single flat form page
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildEditBody(BuildContext context, Translations t) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIconAndNameField(context),
            const SizedBox(height: 12),
            ..._buildAmountAndCurrencyFields(context),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: DebtService.instance.getDebtTotalAmount(
                widget.debt!,
                countInitialAmount: false,
              ),
              builder: (context, asyncSnapshot) {
                final currency = widget.debt!.currency;
                final initialAmount = widget.debt!.initialAmount;
                final trAmount = asyncSnapshot.data ?? 0;
                final totalAmount = (initialAmount + trAmount)
                    .roundWithDecimals(currency.decimalPlaces);

                return Text(
                  '${t.debts.form.total_amount}: ${UINumberFormatter.currency(amountToConvert: initialAmount, currency: currency).getFormattedAmount()} + ${UINumberFormatter.currency(amountToConvert: trAmount, currency: currency).getFormattedAmount()}'
                  ' = ${UINumberFormatter.currency(amountToConvert: totalAmount, currency: currency).getFormattedAmount()}',

                  style: Theme.of(context).textTheme.bodySmall,
                );
              },
            ),
            const SizedBox(height: 16),
            ..._buildDateFields(context, t),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Add layout – stepper
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildAddBody(BuildContext context, Translations t) {
    return Stepper(
      currentStep: _currentStep,
      controlsBuilder: (context, details) {
        if (_currentStep == 1) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.only(top: 16),
          width: double.infinity,
          child: FilledButton(
            onPressed: details.onStepContinue,
            child: Text(t.ui_actions.continue_text),
          ),
        );
      },
      onStepContinue: () => setState(() => _currentStep++),
      onStepTapped: (step) {
        if (step < _currentStep) setState(() => _currentStep = step);
      },
      steps: [
        Step(
          title: Text(t.debts.form.step_initial_value),
          content: _buildInitialValueStep(context, t),
        ),
        Step(
          title: Text(t.debts.form.step_details),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIconAndNameField(context),
                const SizedBox(height: 16),
                ..._buildDateFields(context, t),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialValueStep(BuildContext context, Translations t) {
    return RadioGroup(
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _radioValue = value;
          _nameController.text = '';
        });
      },
      groupValue: _radioValue,
      child: Column(
        children: [
          RadioListTile.adaptive(
            value: 0,
            title: Text(t.debts.form.from_transaction.title),
          ),
          AnimatedExpanded(
            expand: _radioValue == 0,
            child: Builder(
              builder: (context) {
                if (_transaction == null) {
                  return ListTile(
                    title: Text(t.transaction.select),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    subtitle: Text(t.debts.form.from_transaction.tap_to_select),
                    onTap: () => _showTransactionSelector(context),
                  );
                }
                return TransactionListTile(
                  transaction: _transaction!,
                  showAccount: false,
                  heroTag: null,
                  onTap: () => _showTransactionSelector(context),
                );
              },
            ),
          ),
          RadioListTile.adaptive(
            value: 1,
            title: Text(t.debts.form.from_amount.title),
          ),
          AnimatedExpanded(
            expand: _radioValue == 1,
            child: Column(
              children: [
                const SizedBox(height: 6),
                Text(
                  t.debts.form.from_amount.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                ..._buildAmountAndCurrencyFields(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Shared field builders
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildIconAndNameField(BuildContext context) {
    final t = Translations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconDisplayer(
          supportedIcon: _icon,
          mainColor: Theme.of(context).colorScheme.primary,
          size: 32,
          onTap: () => showIconSelectorModal(
            context,
            IconSelectorModal(
              preselectedIconID: _icon.id,
              subtitle: t.icon_selector.select_category_icon,
              onIconSelected: (selectedIcon) {
                setState(() => _icon = selectedIcon);
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: _nameController,
            maxLength: maxLabelLenghtForDisplayNames,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(labelText: '${t.debts.form.name} *'),
            validator: (value) => fieldValidator(value, isRequired: true),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAmountAndCurrencyFields(BuildContext context) {
    final t = Translations.of(context);

    return [
      AmountAndCurrencyFormField(
        amountController: _amountController,
        currency: _currency,
        amountLabel: t.debts.form.initial_amount,
        isRequired: false,
        onCurrencySelected: (newCurrency) {
          setState(() {
            _currency = newCurrency;
          });
        },
      ),
    ];
  }

  List<Widget> _buildDateFields(BuildContext context, Translations t) {
    final t = Translations.of(context);

    return [
      DateTimeFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.event),
          labelText: '${t.general.time.start_date} *',
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
              topLeft: inputBorderRadius,
              topRight: inputBorderRadius,
            ),
          ),
        ),
        initialDate: _openingDate,
        dateFormat: DateFormat.yMMMMd(),
        lastDate: _closeDate ?? DateTime.now(),
        mode: DateTimeFieldPickerMode.date,
        validator: (e) => e == null ? t.general.validations.required : null,
        onDateSelected: (DateTime value) {
          setState(() => _openingDate = value);
        },
      ),
      const Divider(),
      DateTimeFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.event),
          labelText: t.general.time.end_date,
          border: appInputBorder.copyWith(
            borderRadius: BorderRadius.only(
              bottomLeft: inputBorderRadius,
              bottomRight: inputBorderRadius,
            ),
          ),
        ),
        initialDate: _closeDate,
        dateFormat: DateFormat.yMMMMd(),
        firstDate: _openingDate,
        mode: DateTimeFieldPickerMode.date,
        onDateSelected: (DateTime value) {
          setState(() => _closeDate = value);
        },
      ),
    ];
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Form submission
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> submitForm() async {
    if (_formKey.currentState?.validate() != true) return;
    _formKey.currentState!.save();

    final debtToUpload = Debt(
      id: widget.debt?.id ?? generateUUID(),
      name: _nameController.text,
      startDate: _openingDate,
      endDate: _closeDate,
      currency: _currency!,
      iconId: _icon.id,
      initialAmount: _initialAmount,
      type: widget.debt?.type ?? widget.type!,
    );

    try {
      if (widget.isEditing) {
        await DebtService.instance.updateDebt(debtToUpload);
      } else {
        await DebtService.instance.insertDebt(debtToUpload);

        if (_transaction != null && _radioValue == 0) {
          await TransactionService.instance.updateTransaction(
            _transaction!.copyWith(debtId: Value(debtToUpload.id)),
          );
        }
      }

      final t = Translations.of(context);
      MonekinSnackbar.success(
        SnackbarParams(
          widget.isEditing
              ? t.debts.actions.edit.success
              : t.debts.actions.create.success,
        ),
      );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      MonekinSnackbar.error(SnackbarParams.fromError(e));
    }
  }

  void _showTransactionSelector(BuildContext context) {
    return showTransactionSelectorModal(
      context,
      initialFilters: TransactionFilterSet(
        transactionTypes: [
          if (widget.type == DebtDirection.lent) TransactionType.expense,
          if (widget.type == DebtDirection.borrowed) TransactionType.income,
        ],
      ),
      onTransactionSelected: (selectedTransaction) {
        setState(() {
          _transaction = selectedTransaction;
          _nameController.text =
              selectedTransaction.title ??
              selectedTransaction.category?.name ??
              '';
          _currency = Currency.fromDB(
            currencyInDB: selectedTransaction.account.currency,
          );
        });
      },
    );
  }
}

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/debts/transaction_selector.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/read_only_form_field.dart';
import 'package:monekin/core/presentation/widgets/icon_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class DebtFormPage extends StatefulWidget {
  const DebtFormPage({super.key, required this.type});

  final DebtDirection type;

  @override
  State<DebtFormPage> createState() => _DebtFormPageState();
}

class _DebtFormPageState extends State<DebtFormPage> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;
  int radioValue = 1;

  double initialAmount = 0;
  MoneyTransaction? transaction;
  Currency? _currency;

  DateTime _openingDate = DateTime.now();
  DateTime? _closeDate;

  final TextEditingController _nameController = TextEditingController();
  SupportedIcon _icon = SupportedIconService.instance.defaultSupportedIcon;

  @override
  void initState() {
    super.initState();

    CurrencyService.instance.ensureAndGetPreferredCurrency().first.then((
      value,
    ) {
      setState(() {
        _currency = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: "Preste",
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: currentStep == 0 || !_formKey.currentState!.validate()
                ? null
                : () => submitForm(),
            icon: const Icon(Icons.save),
            label: Text(t.ui_actions.add),
          ),
        ),
      ],
      body: Stepper(
        currentStep: currentStep,
        controlsBuilder: (context, details) {
          if (currentStep == 1) {
            return const SizedBox.shrink();
          }

          bool nextButtonDisabled = false;

          return Container(
            margin: const EdgeInsets.only(top: 16),
            width: double.infinity,
            child: FilledButton(
              onPressed: nextButtonDisabled ? null : details.onStepContinue,
              child: Text(t.ui_actions.continue_text),
            ),
          );
        },
        onStepContinue: () {
          setState(() => currentStep++);
        },
        onStepTapped: (step) {
          if (step < currentStep) {
            setState(() => currentStep = step);
          }
        },
        steps: [
          Step(
            title: Text("Valor inicial"),
            content: RadioGroup(
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  radioValue = value;
                  _nameController.text = '';
                });
              },
              groupValue: radioValue,
              child: Column(
                children: [
                  RadioListTile.adaptive(
                    value: 0,
                    title: Text("Desde una transacción"),
                  ),
                  AnimatedExpanded(
                    expand: radioValue == 0,
                    child: Builder(
                      builder: (context) {
                        if (transaction == null) {
                          return ListTile(
                            title: Text("Select a transaction"),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            subtitle: Text("Tap to select a transaction"),
                            onTap: () => _showTransactionSelector(context),
                          );
                        }

                        return TransactionListTile(
                          transaction: transaction!,
                          showAccount: false,
                          heroTag: null,
                          onTap: () => _showTransactionSelector(context),
                        );
                      },
                    ),
                  ),

                  RadioListTile.adaptive(
                    value: 1,
                    title: Text("A partir de un monto"),
                  ),

                  AnimatedExpanded(
                    expand: radioValue == 1,
                    child: Column(
                      children: [
                        const SizedBox(height: 6),

                        Text(
                          "El monto de esta deuda no será tenido en cuenta para las estadísticas como un gasto/ingreso. Si que se usará para calcular saldos y patrimonio",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),

                        const SizedBox(height: 12),

                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: "Monto"),
                        ),

                        ReadOnlyTextFormField(
                          displayValue: _currency != null
                              ? _currency!.name
                              : t.general.unspecified,
                          onTap: () {
                            if (_currency == null) return;

                            showCurrencySelectorModal(
                              context,
                              CurrencySelectorModal(
                                preselectedCurrency: _currency!,
                                onCurrencySelected: (newCurrency) {
                                  setState(() {
                                    _currency = newCurrency;
                                  });
                                },
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            labelText: t.currencies.currency,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            prefixIcon: _currency != null
                                ? Container(
                                    margin: const EdgeInsets.all(10),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: SvgPicture.asset(
                                      _currency!.currencyIconPath,
                                      height: 25,
                                      width: 25,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text("Datos"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                              setState(() {
                                _icon = selectedIcon;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          maxLength: maxLabelLenghtForDisplayNames,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: '${t.categories.name} *',
                            hintText: 'Ex.: My account',
                          ),
                          validator: (value) =>
                              fieldValidator(value, isRequired: true),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),

                  DateTimeFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.event),
                      labelText: 'START DATE *',
                    ),
                    initialDate: _openingDate,
                    dateFormat: DateFormat.yMMMMd(),
                    lastDate: _closeDate ?? DateTime.now(),
                    mode: DateTimeFieldPickerMode.date,
                    validator: (e) =>
                        e == null ? t.general.validations.required : null,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        _openingDate = value;
                      });
                    },
                  ),

                  DateTimeFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.event),
                      labelText: 'END DATE',
                    ),
                    initialDate: _closeDate,
                    dateFormat: DateFormat.yMMMMd(),
                    firstDate: _openingDate,
                    mode: DateTimeFieldPickerMode.date,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        _closeDate = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> submitForm() async {
    if (_formKey.currentState?.validate() != true) return;
    _formKey.currentState!.save();

    final debtToUpload = Debt(
      id: generateUUID(),
      name: _nameController.text,
      startDate: _openingDate,
      endDate: _closeDate,
      currency: _currency!,
      iconId: _icon.id,
      initialAmount: initialAmount,
      type: widget.type,
    );

    try {
      await DebtServive.instance.insertDebt(debtToUpload);

      if (transaction != null && radioValue == 0) {
        await TransactionService.instance.updateTransaction(
          transaction!.copyWith(debtId: Value(debtToUpload.id)),
        );
      }

      MonekinSnackbar.success(SnackbarParams("SUCCESS"));
      Navigator.of(context).pop();
    } catch (e) {
      MonekinSnackbar.error(SnackbarParams.fromError(e));
    }
  }

  void _showTransactionSelector(BuildContext context) {
    return showTransactionSelectorModal(
      context,
      onTransactionSelected: (selectedTransaction) {
        setState(() {
          transaction = selectedTransaction;

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

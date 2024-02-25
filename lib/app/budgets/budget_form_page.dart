import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/category_selector.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_field.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/icon_displayer_widgets.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/account/account.dart';
import '../../core/presentation/widgets/persistent_footer_button.dart';

class BudgetFormPage extends StatefulWidget {
  const BudgetFormPage({super.key, this.budgetToEdit, required this.prevPage});

  final Budget? budgetToEdit;

  final Widget prevPage;

  @override
  State<BudgetFormPage> createState() => _BudgetFormPageState();
}

class _BudgetFormPageState extends State<BudgetFormPage> {
  final _formKey = GlobalKey<FormState>();

  bool get isEditMode => widget.budgetToEdit != null;

  TextEditingController valueController = TextEditingController();
  double? get valueToNumber => double.tryParse(valueController.text);

  TextEditingController nameController = TextEditingController();

  List<Category>? categories;
  List<Account>? accounts;

  Periodicity? intervalPeriod = Periodicity.month;

  DateTime startDate = DateTime.now();
  DateTime? endDate;

  Widget selector({
    required String title,
    required String? inputValue,
    required Function onClick,
  }) {
    return TextFormField(
        controller: TextEditingController(text: inputValue ?? ''),
        readOnly: true,
        onTap: () => onClick(),
        validator: (value) {
          if (inputValue == null) {
            return 'Please, specify at least one item here';
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ));
  }

  submitForm() {
    final t = Translations.of(context);

    if (valueToNumber! < 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.budgets.form.negative_warn)));

      return;
    }

    onSuccess() {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isEditMode
              ? t.transaction.edit_success
              : t.transaction.new_success)));
    }

    final Budget toPush;

    toPush = Budget(
      id: isEditMode ? widget.budgetToEdit!.id : const Uuid().v4(),
      name: nameController.text,
      limitAmount: valueToNumber!,
      intervalPeriod: intervalPeriod,
      startDate: intervalPeriod == null ? startDate : null,
      endDate: intervalPeriod == null ? endDate : null,
      categories: categories?.map((e) => e.id).toList(),
      accounts: accounts?.map((e) => e.id).toList(),
    );

    if (isEditMode) {
      BudgetServive.instance.updateBudget(toPush).then((value) {
        onSuccess();
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    } else {
      BudgetServive.instance.insertBudget(toPush).then((value) {
        onSuccess();
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (isEditMode) {
      fillForm(widget.budgetToEdit!);
    }
  }

  fillForm(Budget budget) async {
    nameController.text = budget.name;
    valueController.text = budget.limitAmount.abs().toString();

    if (budget.intervalPeriod == null) {
      startDate = budget.startDate!;
      endDate = budget.endDate;
    }

    categories = budget.categories == null
        ? null
        : await CategoryService.instance
            .getCategories(
              predicate: (p0, p1) => p0.id.isIn(budget.categories!),
            )
            .first;

    accounts = budget.accounts == null
        ? null
        : await AccountService.instance
            .getAccounts(
              predicate: (p0, p1) => p0.id.isIn(budget.accounts!),
            )
            .first;

    intervalPeriod = budget.intervalPeriod;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? t.budgets.form.edit : t.budgets.form.create),
      ),
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: categories != null && categories!.isEmpty
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      submitForm();
                    }
                  },
            icon: const Icon(Icons.save),
            label:
                Text(isEditMode ? t.budgets.form.edit : t.budgets.form.create),
          ),
        )
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                maxLength: 15,
                validator: (value) => fieldValidator(value, isRequired: true),
                decoration: InputDecoration(
                  labelText: '${t.budgets.form.name} *',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: valueController,
                decoration: InputDecoration(
                  labelText: '${t.budgets.form.value} *',
                  hintText: 'Ex.: 200',
                  suffix: StreamBuilder(
                      stream:
                          CurrencyService.instance.getUserPreferredCurrency(),
                      builder: (context, snapshot) {
                        return Text(snapshot.data?.symbol ?? '');
                      }),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final defaultNumberValidatorResult = fieldValidator(value,
                      isRequired: true, validator: ValidatorType.double);

                  if (defaultNumberValidatorResult != null) {
                    return defaultNumberValidatorResult;
                  }

                  if (valueToNumber! == 0) {
                    return t.transaction.form.validators.zero;
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: intervalPeriod,
                decoration: InputDecoration(
                  labelText: '${t.general.time.periodicity.display} *',
                ),
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text(t.general.time.periodicity.no_repeat),
                  ),
                  ...List.generate(
                      Periodicity.values.length,
                      (index) => DropdownMenuItem(
                          value: Periodicity.values[index],
                          child: Text(Periodicity.values[index]
                              .allThePeriodsText(context))))
                ],
                onChanged: (value) {
                  setState(() {
                    intervalPeriod = value;
                  });
                },
              ),
              if (intervalPeriod == null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DateTimeFormField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.event),
                          labelText: '${t.general.time.start_date} *',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        initialDate: startDate,
                        lastDate: endDate,
                        dateFormat: DateFormat.yMMMd(),
                        validator: (e) =>
                            e == null ? t.general.validations.required : null,
                        onDateSelected: (DateTime value) {
                          setState(() {
                            startDate = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DateTimeFormField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.event),
                          labelText: '${t.general.time.end_date} *',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        initialDate: endDate,
                        firstDate: startDate,
                        dateFormat: DateFormat.yMMMd(),
                        validator: (e) =>
                            e == null ? t.general.validations.required : null,
                        onDateSelected: (DateTime value) {
                          setState(() {
                            endDate = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Text('${t.general.accounts}:'),
              const SizedBox(height: 6),
              StreamBuilder(
                stream: AccountService.instance.getAccounts(),
                builder: (context, snapshot) {
                  return AccountSelector(IconDisplayerSelectorData(
                    iconPadding: 12,
                    iconSize: 40,
                    availableItems: snapshot.data,
                    selectedItems: accounts,
                    onChange: (selection) {
                      setState(() {
                        accounts = selection;
                      });
                    },
                  ));
                },
              ),
              Text('${t.general.categories}:'),
              const SizedBox(height: 6),
              StreamBuilder(
                  stream: CategoryService.instance.getMainCategories(),
                  builder: (context, snapshot) {
                    return StreamBuilder(
                        stream: CategoryService.instance.getMainCategories(),
                        builder: (context, snapshot) {
                          return CategorySelector(IconDisplayerSelectorData(
                            availableItems: snapshot.data,
                            selectedItems: categories,
                            onChange: (selection) {
                              setState(() {
                                categories = selection;
                              });
                            },
                          ));
                        });
                  }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

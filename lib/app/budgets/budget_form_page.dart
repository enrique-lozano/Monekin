import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/selectors/category_multi_selector.dart';
import 'package:monekin/app/layout/scaffold_configuration.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/budget/budget_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/budget/budget.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/page_framework.dart';

import '../../core/models/account/account.dart';
import '../../core/presentation/widgets/count_indicator.dart';
import '../../core/presentation/widgets/form_fields/list_tile_field.dart';
import '../../core/presentation/widgets/persistent_footer_button.dart';

class BudgetFormPage extends StatefulWidget {
  const BudgetFormPage({super.key, this.budgetToEdit, required this.prevPage});

  final Budget? budgetToEdit;

  final Widget prevPage;

  @override
  State<BudgetFormPage> createState() => _BudgetFormPageState();
}

class _BudgetFormPageState extends State<BudgetFormPage> with PageWithScaffold {
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

  submitForm() {
    final t = Translations.of(context);

    if (valueToNumber! < 0) {
      MonekinSnackbar.warning(SnackbarParams(t.budgets.form.negative_warn));
      return;
    }

    onSuccess() {
      Navigator.pop(context);

      MonekinSnackbar.success(
        SnackbarParams(
          isEditMode
              ? t.budgets.form.edit_success
              : t.budgets.form.create_success,
        ),
      );
    }

    final Budget toPush;

    toPush = Budget(
      id: isEditMode ? widget.budgetToEdit!.id : generateUUID(),
      name: nameController.text,
      limitAmount: valueToNumber!,
      intervalPeriod: intervalPeriod,
      startDate: intervalPeriod == null ? startDate : null,
      endDate: intervalPeriod == null ? endDate : null,
      categories: categories?.map((e) => e.id).toList(),
      accounts: accounts?.map((e) => e.id).toList(),
    );

    if (isEditMode) {
      BudgetServive.instance
          .updateBudget(toPush)
          .then((value) {
            onSuccess();
          })
          .catchError((error) {
            MonekinSnackbar.error(SnackbarParams.fromError(error));
          });
    } else {
      BudgetServive.instance
          .insertBudget(toPush)
          .then((value) {
            onSuccess();
          })
          .catchError((error) {
            MonekinSnackbar.error(SnackbarParams.fromError(error));
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
              .getAccounts(predicate: (p0, p1) => p0.id.isIn(budget.accounts!))
              .first;

    intervalPeriod = budget.intervalPeriod;

    setState(() {});
  }

  @override
  // TODO: implement scaffoldConfiguration
  ScaffoldConfiguration get scaffoldConfiguration => ScaffoldConfiguration(
    title: isEditMode ? t.budgets.form.edit : t.budgets.form.create,

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
          label: Text(isEditMode ? t.budgets.form.edit : t.budgets.form.create),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      scaffoldConfiguration: scaffoldConfiguration,
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
                    stream: CurrencyService.instance.getUserPreferredCurrency(),
                    builder: (context, snapshot) {
                      return Text(snapshot.data?.symbol ?? '');
                    },
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final defaultNumberValidatorResult = fieldValidator(
                    value,
                    isRequired: true,
                    validator: ValidatorType.double,
                  );

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
                      child: Text(
                        Periodicity.values[index].allThePeriodsText(context),
                      ),
                    ),
                  ),
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
              StreamBuilder(
                stream: AccountService.instance.getAccounts(),
                builder: (context, snapshot) {
                  List<Account>? selectedAccounts = accounts == null
                      ? snapshot.data
                      : (snapshot.data ?? [])
                            .where(
                              (element) => accounts!
                                  .map((e) => e.id)
                                  .contains(element.id),
                            )
                            .toList();

                  return ListTileField(
                    title: t.general.accounts,
                    leading: const Icon(Icons.account_balance_rounded),
                    trailing: CountIndicatorWithExpandArrow(
                      countToDisplay: accounts?.length,
                    ),
                    subtitle: accounts != null
                        ? selectedAccounts!.map((e) => e.name).printFormatted()
                        : t.account.select.all,
                    onTap: () =>
                        showAccountSelectorBottomSheet(
                          context,
                          AccountSelectorModal(
                            allowMultiSelection: true,
                            filterSavingAccounts: false,
                            selectedAccounts: selectedAccounts ?? [],
                          ),
                        ).then((selection) {
                          if (selection == null) return;

                          setState(() {
                            accounts = selection.length == snapshot.data!.length
                                ? null
                                : selection;
                          });
                        }),
                  );
                },
              ),
              const SizedBox(height: 16),
              StreamBuilder(
                stream: CategoryService.instance.getCategories(),
                builder: (context, snapshot) {
                  List<Category>? selectedCategories = categories == null
                      ? snapshot.data
                      : (snapshot.data ?? [])
                            .where(
                              (element) => categories!
                                  .map((e) => e.id)
                                  .contains(element.id),
                            )
                            .toList();

                  return ListTileField(
                    title: t.general.categories,
                    leading: const Icon(Icons.category_rounded),
                    trailing: CountIndicatorWithExpandArrow(
                      countToDisplay: categories?.length,
                    ),
                    subtitle: categories != null
                        ? selectedCategories!
                              .map((e) => e.name)
                              .printFormatted()
                        : t.categories.select.all,
                    onTap: () {
                      showMultiCategoryListModal(
                        context,
                        CategoryMultiSelectorModal(
                          selectedCategories: selectedCategories ?? [],
                        ),
                      ).then((selection) {
                        if (selection == null) return;

                        categories = selection.length == snapshot.data!.length
                            ? null
                            : selection;

                        setState(() {});
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

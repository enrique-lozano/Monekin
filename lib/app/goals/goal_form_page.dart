import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/selectors/category_multi_selector.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/goal/goal_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/goal/goal.dart';
import 'package:monekin/core/models/goal/goal_type.enum.dart';
import 'package:monekin/core/models/goal/goal_type_selector.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/count_indicator.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/list_tile_field.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class GoalFormPage extends StatefulWidget {
  const GoalFormPage({super.key, this.goalToEdit});

  final Goal? goalToEdit;

  @override
  State<GoalFormPage> createState() => _GoalFormPageState();
}

class _GoalFormPageState extends State<GoalFormPage> {
  final _formKey = GlobalKey<FormState>();

  bool get isEditMode => widget.goalToEdit != null;

  TextEditingController nameController = TextEditingController();

  TextEditingController amountController = TextEditingController();
  double? get amountToNumber => double.tryParse(amountController.text);

  TextEditingController initialAmountController = TextEditingController();
  double? get initialAmountToNumber =>
      double.tryParse(initialAmountController.text);

  GoalType goalType = GoalType.income;

  DateTime startDate = DateTime.now();
  DateTime? endDate;

  List<Category>? categories;
  List<Account>? accounts;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      fillForm(widget.goalToEdit!);
    } else {
      initialAmountController.text = "0";
    }
  }

  fillForm(Goal goal) async {
    nameController.text = goal.name;
    amountController.text = goal.amount.toString();
    initialAmountController.text = goal.initialAmount.toString();
    goalType = goal.type;
    startDate = goal.startDate;
    endDate = goal.endDate;

    categories = goal.trFilters.categoriesIds == null
        ? null
        : await CategoryService.instance
              .getCategories(
                predicate: (p0, p1) =>
                    p0.id.isIn(goal.trFilters.categoriesIds!),
              )
              .first;

    accounts = goal.trFilters.accountsIDs == null
        ? null
        : await AccountService.instance
              .getAccounts(
                predicate: (p0, p1) => p0.id.isIn(goal.trFilters.accountsIDs!),
              )
              .first;

    setState(() {});
  }

  void submitForm() {
    final t = Translations.of(context);

    if (_formKey.currentState?.validate() != true) return;
    _formKey.currentState!.save();

    if ((amountToNumber ?? 0) < 0 || (initialAmountToNumber ?? 0) < 0) {
      MonekinSnackbar.warning(SnackbarParams(t.goals.form.negative_warn));
      return;
    }

    final Goal toPush = Goal(
      id: isEditMode ? widget.goalToEdit!.id : generateUUID(),
      name: nameController.text,
      amount: amountToNumber!,
      initialAmount: initialAmountToNumber ?? 0,
      startDate: startDate,
      endDate: endDate,
      type: goalType,
      trFilters: TransactionFilterSetInDB(
        id: isEditMode ? widget.goalToEdit!.filterID : generateUUID(),
        categoriesIds: categories?.map((e) => e.id).toList(),
        accountsIDs: accounts?.map((e) => e.id).toList(),
      ),
    );

    Future<void> saveOperation = isEditMode
        ? GoalService.instance.updateGoal(toPush)
        : GoalService.instance.insertGoal(toPush);

    saveOperation
        .then((value) {
          RouteUtils.popRoute();
          MonekinSnackbar.success(
            SnackbarParams(
              isEditMode
                  ? t.goals.form.edit_success
                  : t.goals.form.create_success,
            ),
          );
        })
        .catchError((error) {
          MonekinSnackbar.error(SnackbarParams.fromError(error));
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: isEditMode ? t.goals.form.edit_title : t.goals.form.new_title,
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: () => submitForm(),
            icon: const Icon(Icons.save),
            label: Text(isEditMode ? t.ui_actions.save : t.ui_actions.add),
          ),
        ),
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
                maxLength: 25,
                validator: (value) => fieldValidator(value, isRequired: true),
                decoration: InputDecoration(
                  labelText: '${t.goals.form.name} *',
                  hintText: t.goals.form.name_hint,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: '${t.goals.form.target_amount} *',
                        suffix: _buildCurrencySuffix(),
                      ),
                      validator: (value) => fieldValidator(
                        value,
                        isRequired: true,
                        validator: ValidatorType.double,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: initialAmountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: t.goals.form.initial_amount,
                        suffix: _buildCurrencySuffix(),
                      ),
                      validator: (value) => fieldValidator(
                        value,
                        isRequired: false,
                        validator: ValidatorType.double,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              TextField(
                controller: TextEditingController(
                  text: goalType.title(context),
                ),
                mouseCursor: SystemMouseCursors.click,
                decoration: InputDecoration(
                  labelText: '${t.goals.type.display} *',
                  suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                  prefix: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: goalType.color(context).lighten(),
                    ),
                    child: Icon(Icons.golf_course_rounded, size: 14),
                  ),
                ),
                readOnly: true,

                onTap: () {
                  showGoalTypeModal(context, initialType: goalType).then((
                    modalRes,
                  ) {
                    if (modalRes == null || modalRes.result == null) return;

                    setState(() {
                      goalType = modalRes.result!;
                    });
                  });
                },
              ),

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
                        labelText: t.general.time.end_date,
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      initialDate: endDate,
                      firstDate: startDate,
                      dateFormat: DateFormat.yMMMd(),
                      onDateSelected: (DateTime value) {
                        setState(() {
                          endDate = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(height: 8),
              const SizedBox(height: 16),

              Text(
                t.general.filters,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),

              _buildAccountSelector(t),
              const SizedBox(height: 16),
              _buildCategorySelector(t),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector(Translations t) {
    return StreamBuilder(
      stream: CategoryService.instance.getCategories(),
      builder: (context, snapshot) {
        List<Category>? selectedCategories = categories == null
            ? snapshot.data
            : (snapshot.data ?? [])
                  .where(
                    (element) =>
                        categories!.map((e) => e.id).contains(element.id),
                  )
                  .toList();

        return ListTileField(
          title: t.general.categories,
          leading: const Icon(Icons.category_rounded),
          trailing: CountIndicatorWithExpandArrow(
            countToDisplay: categories?.length,
          ),
          subtitle: categories != null
              ? selectedCategories!.map((e) => e.name).printFormatted()
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
    );
  }

  Widget _buildAccountSelector(Translations t) {
    return StreamBuilder(
      stream: AccountService.instance.getAccounts(),
      builder: (context, snapshot) {
        List<Account>? selectedAccounts = accounts == null
            ? snapshot.data
            : (snapshot.data ?? [])
                  .where(
                    (element) =>
                        accounts!.map((e) => e.id).contains(element.id),
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
    );
  }

  Widget _buildCurrencySuffix() {
    return StreamBuilder(
      stream: CurrencyService.instance.ensureAndGetPreferredCurrency(),
      builder: (context, snapshot) {
        return Text(snapshot.data?.symbol ?? '');
      },
    );
  }
}

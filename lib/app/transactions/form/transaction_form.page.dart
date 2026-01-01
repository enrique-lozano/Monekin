import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/form/dialogs/amount_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_account_selector_row.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_amount_display.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_date_selector.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_fields.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_selectors.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/database/services/user-setting/default_transaction_values.service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
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
    this.transactionToEdit,
  });

  final TransactionType? mode;

  final MoneyTransaction? transactionToEdit;

  final Account? fromAccount;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  late TabController _tabController;

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

  @override
  void initState() {
    super.initState();

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
            TransactionType.E;
      } else {
        transactionType = TransactionType.E;
      }
    }

    _tabController = TabController(
      length: 3,
      initialIndex: transactionType.index,
      vsync: this,
    );

    _tabController.addListener(_onTabSelectionChanged);

    if (widget.transactionToEdit != null) {
      _fillForm(widget.transactionToEdit!);
      return;
    }

    _initializeFormValues();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelectionChanged() {
    transactionType = TransactionType.values.elementAt(_tabController.index);

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _displayAmountModal(context);
    });

    // 2. Category
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
    if (transactionType.isIncomeOrExpense && selectedCategory == null ||
        transactionType.isTransfer && transferAccount == null) {
      _shakeKey.currentState?.shake();
      return;
    }

    final t = Translations.of(context);

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

    final transactionToPost = TransactionInDB(
      id: newTrID,
      date: date,
      type: transactionType,
      accountID: fromAccount!.id,
      value: transactionType == TransactionType.E
          ? transactionValue * -1
          : transactionValue,
      isHidden: false,
      status: date.compareTo(DateTime.now()) > 0
          ? TransactionStatus.pending
          : status,
      notes: notesController.text.isEmpty ? null : notesController.text,
      title: titleController.text.isEmpty ? null : titleController.text,
      intervalEach: recurrentRule.intervalEach,
      intervalPeriod: recurrentRule.intervalPeriod,
      endDate: recurrentRule.ruleRecurrentLimit?.endDate,
      remainingTransactions:
          recurrentRule.ruleRecurrentLimit?.remainingIterations,
      valueInDestiny: transactionType.isTransfer
          ? valueInDestinyToNumber
          : null,
      categoryID: transactionType.isIncomeOrExpense
          ? selectedCategory?.id
          : null,
      receivingAccountID: transactionType.isTransfer
          ? transferAccount?.id
          : null,
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
        categoryType: transactionType == TransactionType.E
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

    if (transactionType == TransactionType.E) {
      transactionValue = transactionValue * -1;
    }

    valueInDestinyController.text =
        transaction.valueInDestiny?.abs().toString() ?? '';

    setState(() {});
  }

  Color get foregroundColor {
    return transactionType.color(context).getContrastColor();
  }

  Widget _buildHeader(BuildContext context) {
    final t = Translations.of(context);
    return Column(
      children: [
        TransactionAmountDisplay(
          transactionType: transactionType,
          transactionValue: transactionValue,
          fromAccount: fromAccount,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (context) => AmountSelector(
                title: t.transaction.form.value,
                initialAmount: transactionValue,
                enableSignToggleButton: transactionType.isIncomeOrExpense,
                currency: fromAccount?.currency,
                onSubmit: (amount) {
                  setState(() {
                    transactionValue = amount;
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
          onFromAccountTap: () async {
            final modalRes = await showAccountSelector(fromAccount!);
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final formFieldWithDividers = [
      TransactionTitleField(controller: titleController),
      const Divider(),
      TransactionDateSelector(
        date: date,
        fromAccount: fromAccount,
        onDateChanged: (newDate) => setState(() => date = newDate),
      ),
      const Divider(),
      TransactionRecurrencySelector(
        recurrentRule: recurrentRule,
        onRecurrencyChanged: (newRule) =>
            setState(() => recurrentRule = newRule),
      ),
      const Divider(),
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
        title: isEditMode
            ? t.transaction.edit
            : transactionType == TransactionType.T
            ? t.transfer.create
            : transactionType == TransactionType.E
            ? t.transaction.new_expense
            : t.transaction.new_income,
        appBarBackgroundColor: transactionType.color(context).withOpacity(0.85),
        appBarForegroundColor: foregroundColor,
        tabBar: TabBar(
          indicatorColor: foregroundColor,
          labelColor: foregroundColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          unselectedLabelColor: foregroundColor.withOpacity(0.8),
          tabAlignment: TabAlignment.fill,
          dividerColor: transactionType.color(context).darken(0.3),
          controller: _tabController,
          tabs: TransactionType.values
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => AmountSelector(
        title: t.transaction.form.value,
        initialAmount: transactionValue,
        enableSignToggleButton: transactionType.isIncomeOrExpense,
        currency: fromAccount?.currency,
        onSubmit: (amount) {
          setState(() {
            transactionValue = amount;
            RouteUtils.popRoute();
          });
        },
      ),
    );
  }
}

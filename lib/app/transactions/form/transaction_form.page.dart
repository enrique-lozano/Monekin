import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/tags/tag_list.page.dart';
import 'package:monekin/app/transactions/form/calculator_modal.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/animations/shake/shake_widget.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/expansion_panel/single_expansion_panel.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/status_filter/transaction_status_filter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/tags_filter/tags_filter_container.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:uuid/uuid.dart';

import '../../../core/presentation/app_colors.dart';

enum TransactionFormMode { transfer, incomeOrExpense }

@RoutePage()
class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({
    super.key,
    this.transactionToEdit,
    this.mode = TransactionFormMode.incomeOrExpense,
    this.fromAccount,
    this.toAccount,
  });

  final MoneyTransaction? transactionToEdit;
  final TransactionFormMode mode;

  final Account? fromAccount;
  final Account? toAccount;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController valueController = TextEditingController();
  double? get valueToNumber => double.tryParse(valueController.text);

  TextEditingController valueInDestinyController = TextEditingController();
  double? get valueInDestinyToNumber =>
      double.tryParse(valueInDestinyController.text);

  Category? selectedCategory;

  Account? fromAccount;
  Account? toAccount;

  DateTime date = DateTime.now();

  TransactionStatus? status;

  TextEditingController notesController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool get isEditMode => widget.transactionToEdit != null;

  RecurrencyData recurrentRule = const RecurrencyData.noRepeat();

  List<Tag> tags = [];

  TransactionType currentTransactionTypeToAdd = TransactionType.expense;

  final _shakeKey = GlobalKey<ShakeWidgetState>();

  Widget selector({
    required String title,
    required String? inputValue,
    required Widget icon,
    required Function onClick,
  }) {
    final t = Translations.of(context);

    return InkWell(
      onTap: () => onClick(),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  Text(
                    inputValue ?? t.general.unspecified,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  submitForm() {
    if (widget.mode == TransactionFormMode.incomeOrExpense &&
        selectedCategory == null) {
      _shakeKey.currentState?.shake();
      return;
    }

    final t = Translations.of(context);
    final scMessenger = ScaffoldMessenger.of(context);

    if (valueToNumber == null || valueToNumber == 0) {
      scMessenger.showSnackBar(
        SnackBar(content: Text(t.transaction.form.validators.zero)),
      );

      return;
    }

    if (valueToNumber! < 0) {
      scMessenger.showSnackBar(SnackBar(
        content: Text(widget.mode == TransactionFormMode.incomeOrExpense
            ? t.transaction.form.validators.negative_transaction
            : t.transaction.form.validators.negative_transfer),
      ));

      return;
    }

    if (fromAccount != null && fromAccount!.date.compareTo(date) > 0) {
      scMessenger.showSnackBar(
        SnackBar(
            content: Text(
                t.transaction.form.validators.date_after_account_creation)),
      );

      return;
    }

    onSuccess() {
      Navigator.pop(context);

      scMessenger.showSnackBar(SnackBar(
          content: Text(isEditMode
              ? t.transaction.edit_success
              : t.transaction.new_success)));
    }

    final newTrID = widget.transactionToEdit?.id ?? const Uuid().v4();

    TransactionService.instance
        .insertOrUpdateTransaction(
      TransactionInDB(
        id: newTrID,
        date: date,
        accountID: fromAccount!.id,
        value: widget.mode == TransactionFormMode.incomeOrExpense &&
                selectedCategory!.type.isExpense
            ? valueToNumber! * -1
            : valueToNumber!,
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
        valueInDestiny: widget.mode == TransactionFormMode.transfer
            ? valueInDestinyToNumber
            : null,
        categoryID: widget.mode == TransactionFormMode.incomeOrExpense
            ? selectedCategory?.id
            : null,
        receivingAccountID:
            widget.mode == TransactionFormMode.transfer ? toAccount?.id : null,
      ),
    )
        .then((value) {
      final db = AppDB.instance;

      Future.wait(
        [
          for (final tag in tags)
            if (widget.transactionToEdit != null &&
                widget.transactionToEdit!.tags
                    .any((element) => element.id == tag.id))
              (db.delete(db.transactionTags)
                    ..where((tbl) => tbl.tagID.isValue(tag.id)))
                  .go()
            else
              db
                  .into(db.transactionTags)
                  .insert(TransactionTag(transactionID: newTrID, tagID: tag.id))
        ],
      ).then((value) {
        onSuccess();
      }).catchError((error) {
        scMessenger.showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }).catchError((error) {
      scMessenger.showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.transactionToEdit != null) {
      fillForm(widget.transactionToEdit!);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        displayAmountModal(context);
      });

      AccountService.instance
          .getAccounts(
              predicate: (acc, curr) => AppDB.instance.buildExpr([
                    acc.type.equalsValue(AccountType.saving).not(),
                    acc.closingDate.isNull()
                  ]),
              limit: widget.mode == TransactionFormMode.incomeOrExpense ? 1 : 2)
          .first
          .then((acc) {
        fromAccount = widget.fromAccount ?? acc[0];

        if (widget.mode == TransactionFormMode.transfer) {
          toAccount = widget.toAccount ??
              (acc[1].id != fromAccount!.id ? acc[1] : acc[0]);
        }

        setState(() {});
      });
    }
  }

  Future<List<Account>?> showAccountSelector(Account account) {
    return showAccountSelectorBottomSheet(
        context,
        AccountSelector(
          allowMultiSelection: false,
          filterSavingAccounts:
              widget.mode == TransactionFormMode.incomeOrExpense,
          includeArchivedAccounts: false,
          selectedAccounts: [account],
        ));
  }

  Future<void> selectCategory() async {
    final modalRes = await showCategoryListModal(
      context,
      const CategoriesList(
        mode: CategoriesListMode.modalSelectSubcategory,
      ),
    );

    if (modalRes != null && modalRes.isNotEmpty) {
      setState(() {
        selectedCategory = modalRes.first;
      });
    }
  }

  fillForm(MoneyTransaction transaction) async {
    setState(() {
      fromAccount = transaction.account;
      toAccount = transaction.receivingAccount;
      date = transaction.date;
      status = transaction.status;
      selectedCategory = transaction.category;
      recurrentRule = transaction.recurrentInfo;

      if (selectedCategory != null &&
          selectedCategory!.type == CategoryType.B) {
        if (transaction.value < 0) {
          selectedCategory!.type = CategoryType.E;
        } else {
          selectedCategory!.type = CategoryType.I;
        }
      }

      tags = [...transaction.tags];
    });

    notesController.text = transaction.notes ?? '';
    titleController.text = transaction.title ?? '';
    valueController.text = transaction.value.abs().toString();

    valueInDestinyController.text =
        transaction.valueInDestiny?.abs().toString() ?? '';
  }

  List<Widget> buildExtraFields() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: TextField(
          controller:
              TextEditingController(text: recurrentRule.formText(context)),
          readOnly: true,
          onTap: () {
            showIntervalSelectoHelpDialog(context,
                selectedRecurrentRule: recurrentRule,
                onRecurrentRuleSelected: (res) {
              setState(() {
                recurrentRule = res;
              });
            });
          },
          decoration: InputDecoration(
            labelText: t.general.time.periodicity.display,
            suffixIcon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
      const SizedBox(height: 12),
      if (widget.mode == TransactionFormMode.transfer) ...[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: TextFormField(
            controller: valueInDestinyController,
            decoration: InputDecoration(
                labelText:
                    t.transfer.form.currency_exchange_selector.value_in_destiny,
                hintText: 'Ex.: 200',
                suffixText: toAccount?.currency.symbol),
            keyboardType: TextInputType.number,
            inputFormatters: decimalDigitFormatter,
            validator: (value) {
              final defaultNumberValidatorResult = fieldValidator(value,
                  isRequired: false, validator: ValidatorType.double);

              if (defaultNumberValidatorResult != null) {
                return defaultNumberValidatorResult;
              }

              if (valueToNumber == null) {
                return null;
              } else if (valueToNumber! == 0) {
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
        ),
        if (widget.mode == TransactionFormMode.transfer &&
            valueToNumber != null &&
            valueInDestinyToNumber == null)
          InlineInfoCard(
            text: '${t.transfer.form.currency_info_add(
              x: NumberFormat.currency(symbol: toAccount!.currency.symbol)
                  .format(valueToNumber),
            )} ',
            mode: InlineInfoCardMode.info,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          ),
        const SizedBox(height: 12),
      ],
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: TextFormField(
          minLines: 2,
          maxLines: 10,
          controller: notesController,
          decoration: InputDecoration(
            labelText: t.transaction.form.description,
            alignLabelWithHint: true,
            hintText: t.transaction.form.description_info,
          ),
        ),
      ),
      if (recurrentRule.isNoRecurrent) ...[
        const SizedBox(height: 16),
        StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TransactionStatusFilter(
              selectedStatuses: [
                date.compareTo(DateTime.now()) > 0
                    ? TransactionStatus.pending
                    : status
              ],
              allowMultipleSelection: false,
              onSelected: date.compareTo(DateTime.now()) > 0
                  ? null
                  : (statusSelected, value) {
                      setState(() {
                        status = statusSelected;
                      });
                    },
            ),
          );
        }),
      ],
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StatefulBuilder(builder: (context, setState) {
          return TagsFilterContainer(
            child: Wrap(
              spacing: 6,
              runSpacing: 0,
              children: [
                ...List.generate(tags.length, (index) {
                  final tag = tags[index];

                  return FilterChip(
                    label: Text(
                      tag.name,
                      style: TextStyle(color: tag.colorData),
                    ),
                    selected: true,
                    onSelected: (value) => setState(() {
                      tags.removeWhere((element) => element.id == tag.id);
                    }),
                    showCheckmark: false,
                    selectedColor: tag.colorData.lighten(0.75),
                    avatar: tag.displayIcon(),
                  );
                }),
                ActionChip(
                  label: Text(t.tags.add),
                  avatar: const Icon(Icons.add),
                  onPressed: () =>
                      showTagListModal(context, selectedTags: tags).then(
                    (value) {
                      if (value != null) {
                        setState(() {
                          tags = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      )
    ];
  }

  Widget buildTitleField() {
    return TextFormField(
      controller: titleController,
      maxLength: maxLabelLenghtForDisplayNames,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.title_rounded),
        labelText: t.transaction.form.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    if (widget.mode == TransactionFormMode.transfer) {
      currentTransactionTypeToAdd = TransactionType.transfer;
    } else if (selectedCategory != null) {
      if (selectedCategory!.type.isIncome) {
        currentTransactionTypeToAdd = TransactionType.income;
      } else {
        currentTransactionTypeToAdd = TransactionType.expense;
      }
    } else {
      currentTransactionTypeToAdd = TransactionType.expense;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode
              ? t.transaction.edit
              : currentTransactionTypeToAdd == TransactionType.transfer
                  ? t.transfer.create
                  : currentTransactionTypeToAdd == TransactionType.expense
                      ? t.transaction.new_expense
                      : t.transaction.new_income,
        ),
      ),
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                submitForm();
              }
            },
            icon: const Icon(Icons.save),
            label: Text(isEditMode ? t.transaction.edit : t.transaction.create),
          ),
        )
      ],
      body: Form(
        key: _formKey,
        child: BreakpointContainer(
          lgChild: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      buildAmountContainer(context),
                      const SizedBox(height: 18),
                      buildAccoutAndCategorySelectorRow(context),
                      const SizedBox(height: 12),
                      buildTransactionDateSelector(),
                      const SizedBox(height: 12),
                      buildTitleField(),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  child: Column(
                    children: [...buildExtraFields()],
                  ),
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildAmountContainer(context),
                    const SizedBox(height: 18),
                    buildAccoutAndCategorySelectorRow(context),
                  ],
                ),
              ),
              //   const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const Divider(thickness: 2.2),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            buildTransactionDateSelector(),
                            const SizedBox(height: 12),
                            buildTitleField(),
                          ],
                        ),
                      ),
                      //       ...buildExtraFields()
                      SingleExpansionPanel(
                        child: Column(
                          children: [
                            const SizedBox(height: 6),
                            ...buildExtraFields()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void displayAmountModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => AmountSelector(
        title: t.transaction.form.value,
        amountToConvert: valueToNumber ?? 0,
        onSubmit: (amount) {
          setState(() {
            valueController.text = amount.toString();
            Navigator.pop(context);
          });
        },
      ),
    );
  }

  Widget buildAmountContainer(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => displayAmountModal(context),
      child: Container(
        decoration: BoxDecoration(
          color: currentTransactionTypeToAdd.color(context).withOpacity(0.7),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconDisplayer(
              mainColor: currentTransactionTypeToAdd.color(context),
              secondaryColor: Colors.white,
              padding: 2,
              borderRadius: 4,
              icon: currentTransactionTypeToAdd.mathIcon,
            ),
            Builder(builder: (context) {
              final bigTextStyle =
                  Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: (valueToNumber ?? 0) >= 1000
                          ? (valueToNumber ?? 0) >= 1000000
                              ? 28
                              : 34
                          : 38);

              return CurrencyDisplayer(
                amountToConvert: valueToNumber ?? 0,
                currency: fromAccount?.currency,
                currencyStyle: bigTextStyle,
                integerStyle: bigTextStyle,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionDateSelector() {
    return Column(
      children: [
        DateTimeFormField(
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.event),
            labelText: '${t.general.time.date} *',
          ),
          initialDate: date,
          dateFormat: DateFormat.yMMMd().add_jm(),
          validator: (e) => e == null ? t.general.validations.required : null,
          onDateSelected: (DateTime value) {
            setState(() {
              date = value;
            });
          },
        ),
        if (date.compareTo(DateTime.now()) > 0)
          InlineInfoCard(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 4),
            text: t.transaction.form.validators.date_max,
            mode: InlineInfoCardMode.info,
          ),
        if (fromAccount != null &&
            fromAccount!.date.compareTo(date) > 0 &&
            !(date.compareTo(DateTime.now()) > 0))
          InlineInfoCard(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 4),
            text: t.transaction.form.validators.date_after_account_creation,
            mode: InlineInfoCardMode.warn,
          ),
      ],
    );
  }

  Card buildAccoutAndCategorySelectorRow(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.all(0),
      elevation: 0,
      // color: AppColors.of(context).primary,
      clipBehavior: Clip.hardEdge,
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
                child: selector(
                    title: t.general.account,
                    inputValue: fromAccount?.name,
                    icon: fromAccount?.displayIcon(context) ??
                        IconDisplayer(
                          displayMode: IconDisplayMode.polygon,
                          icon: Icons.question_mark_rounded,
                          mainColor: AppColors.of(context).primary,
                        ),
                    onClick: () async {
                      final modalRes = await showAccountSelector(fromAccount!);

                      if (modalRes != null && modalRes.isNotEmpty) {
                        setState(() {
                          fromAccount = modalRes.first;
                        });
                      }
                    }),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: Icon(Icons.arrow_forward, size: 16),
            ),
            if (widget.mode == TransactionFormMode.transfer)
              Flexible(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
                  child: selector(
                      title: t.transfer.form.to,
                      inputValue: toAccount?.name,
                      icon: toAccount?.displayIcon(context) ??
                          IconDisplayer(
                            displayMode: IconDisplayMode.polygon,
                            icon: Icons.question_mark_rounded,
                            mainColor: AppColors.of(context).primary,
                          ),
                      onClick: () async {
                        final modalRes = await showAccountSelector(toAccount!);

                        if (modalRes != null && modalRes.isNotEmpty) {
                          setState(() {
                            toAccount = modalRes.first;
                          });
                        }
                      }),
                ),
              ),
            if (widget.mode == TransactionFormMode.incomeOrExpense)
              Flexible(
                child: ShakeWidget(
                  duration: const Duration(milliseconds: 200),
                  shakeCount: 1,
                  shakeOffset: 10,
                  key: _shakeKey,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
                    child: selector(
                      title: t.general.category,
                      inputValue: selectedCategory?.name,
                      icon: selectedCategory != null
                          ? IconDisplayer.fromCategory(context,
                              category: selectedCategory!)
                          : IconDisplayer(
                              icon: Icons.question_mark_rounded,
                              mainColor: AppColors.of(context).primary,
                            ),
                      onClick: () => selectCategory(),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

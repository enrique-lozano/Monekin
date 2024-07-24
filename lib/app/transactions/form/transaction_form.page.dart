import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/transactions/form/dialogs/transaction_more_info.modal.dart';
import 'package:monekin/app/transactions/form/dialogs/transaction_status_selector.dart';
import 'package:monekin/app/transactions/form/dialogs/transaction_title_modal.dart';
import 'package:monekin/app/transactions/form/widgets/transaction_form_calculator.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/shake/shake_widget.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/translations.g.dart';

import 'widgets/account_or_category_selector.dart';

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage(
      {super.key,
      this.mode = TransactionType.E,
      this.fromAccount,
      this.transactionToEdit});
  final TransactionType mode;

  final MoneyTransaction? transactionToEdit;

  final Account? fromAccount;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  late TransactionType transactionType;
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  Account? fromAccount;
  Account? toAccount;

  Category? selectedCategory;

  DateTime date = DateTime.now();

  double transactionAmount = 0;

  TransactionStatus? status;

  String? title;

  bool get isEditMode => widget.transactionToEdit != null;

  RecurrencyData recurrentRule = const RecurrencyData.noRepeat();

  List<Tag> get tags => moreInfo.tags;

  TransactionMoreInfo moreInfo = const TransactionMoreInfo();

  //TODO: Maybe a controller not neccessary here
  TextEditingController valueInDestinyController = TextEditingController();
  double? get valueInDestinyToNumber =>
      double.tryParse(valueInDestinyController.text);

  @override
  void initState() {
    super.initState();

    transactionType = widget.mode;

    if (transactionType == TransactionType.E) {
      transactionAmount = transactionAmount * -1;
    }

    if (widget.transactionToEdit != null) {
      fillForm(widget.transactionToEdit!);
    } else {
      AccountService.instance
          .getAccounts(
              predicate: (acc, curr) => AppDB.instance.buildExpr([
                    acc.type.equalsValue(AccountType.saving).not(),
                    acc.closingDate.isNull()
                  ]),
              limit: transactionType.isTransfer ? 2 : 1)
          .first
          .then((acc) {
        fromAccount = widget.fromAccount ?? acc[0];

        if (transactionType.isTransfer) {
          toAccount = acc[1].id != fromAccount!.id ? acc[1] : acc[0];
        }

        setState(() {});
      });
    }
  }

  submitForm() {
    if (transactionType.isIncomeOrExpense && selectedCategory == null ||
        transactionType.isTransfer && toAccount == null) {
      _shakeKey.currentState?.shake();
      return;
    }

    final t = Translations.of(context);
    final scMessenger = ScaffoldMessenger.of(context);

    if (transactionAmount == 0) {
      scMessenger.showSnackBar(
        SnackBar(content: Text(t.transaction.form.validators.zero)),
      );

      return;
    }

    if (transactionAmount < 0 && transactionType.isTransfer) {
      scMessenger.showSnackBar(SnackBar(
        content: Text(t.transaction.form.validators.negative_transfer),
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

    if (transactionType.isTransfer && fromAccount!.id == toAccount!.id) {
      scMessenger.showSnackBar(
        SnackBar(
            content: Text(
                t.transaction.form.validators.transfer_between_same_accounts)),
      );

      return;
    }

    // VALIDATIONS ENDED -- PROCEED:

    onSuccess() {
      Navigator.pop(context);

      scMessenger.showSnackBar(SnackBar(
          content: Text(isEditMode
              ? t.transaction.edit_success
              : t.transaction.new_success)));
    }

    final newTrID = widget.transactionToEdit?.id ?? generateUUID();

    TransactionService.instance
        .insertOrUpdateTransaction(
      TransactionInDB(
        id: newTrID,
        date: date,
        accountID: fromAccount!.id,
        value: transactionAmount,
        isHidden: false,
        type: transactionType,
        status: date.compareTo(DateTime.now()) > 0
            ? TransactionStatus.pending
            : status,
        notes: moreInfo.note.notEmptyString,
        title: title.notEmptyString,
        intervalEach: recurrentRule.intervalEach,
        intervalPeriod: recurrentRule.intervalPeriod,
        endDate: recurrentRule.ruleRecurrentLimit?.endDate,
        remainingTransactions:
            recurrentRule.ruleRecurrentLimit?.remainingIterations,
        valueInDestiny:
            transactionType.isTransfer ? valueInDestinyToNumber : null,
        categoryID:
            transactionType.isIncomeOrExpense ? selectedCategory?.id : null,
        receivingAccountID: transactionType.isTransfer ? toAccount?.id : null,
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

      moreInfo = TransactionMoreInfo(
        tags: transaction.tags,
        note: transaction.notes,
      );
    });

    title = transaction.title;
    transactionAmount = transaction.value;

    valueInDestinyController.text =
        transaction.valueInDestiny?.abs().toString() ?? '';
  }

  Card buildAccoutAndCategorySelectorRow(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        //  side: BorderSide(color: Theme.of(context).dividerColor, width: 2),
        borderRadius: BorderRadius.circular(12),
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
                child: AccountOrCategorySelector(
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
            if (transactionType == TransactionType.T)
              Flexible(
                child: ShakeWidget(
                  duration: const Duration(milliseconds: 200),
                  shakeCount: 1,
                  shakeOffset: 10,
                  key: _shakeKey,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
                    child: AccountOrCategorySelector(
                        title: t.transfer.form.to,
                        inputValue: toAccount?.name,
                        icon: toAccount?.displayIcon(context) ??
                            IconDisplayer(
                              displayMode: IconDisplayMode.polygon,
                              icon: Icons.question_mark_rounded,
                              mainColor: AppColors.of(context).primary,
                            ),
                        onClick: () async {
                          final modalRes = await showAccountSelector(toAccount);

                          if (modalRes != null && modalRes.isNotEmpty) {
                            setState(() {
                              toAccount = modalRes.first;
                            });
                          }
                        }),
                  ),
                ),
              ),
            if (transactionType != TransactionType.T)
              Flexible(
                child: ShakeWidget(
                  duration: const Duration(milliseconds: 200),
                  shakeCount: 1,
                  shakeOffset: 10,
                  key: _shakeKey,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
                    child: AccountOrCategorySelector(
                        title: t.general.category,
                        inputValue: selectedCategory?.name,
                        icon: IconDisplayer.fromCategory(
                          context,
                          category: selectedCategory ??
                              Category.fromDB(Category.unkown(), null),
                          size: 24,
                        ),
                        onClick: () => selectCategory()),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Future<List<Account>?> showAccountSelector(Account? account) {
    return showAccountSelectorBottomSheet(
        context,
        AccountSelectorModal(
          allowMultiSelection: false,
          filterSavingAccounts: transactionType.isIncomeOrExpense,
          includeArchivedAccounts: false,
          selectedAccounts: [if (account != null) account],
        ));
  }

  Future<void> selectCategory() async {
    final modalRes = await showCategoryListModal(
      context,
      CategoriesList(
        mode: CategoriesListMode.modalSelectSubcategory,
        selectedCategories: [
          if (selectedCategory != null)
            selectedCategory!.parentCategory ?? selectedCategory!
        ],
      ),
    );

    if (modalRes != null && modalRes.isNotEmpty) {
      setState(() {
        selectedCategory = modalRes.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: SegmentedButton(
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: transactionType.color(context),
            selectedForegroundColor: Colors.white,
          ),
          showSelectedIcon: false,
          segments: TransactionType.values
              .map(
                (e) => ButtonSegment(
                  value: e,
                  icon: Icon(e.mathIcon),
                  tooltip: e.displayName(context),
                ),
              )
              .toList(),
          selected: {transactionType},
          onSelectionChanged: (newMode) {
            transactionType = newMode.first;

            if (transactionType == TransactionType.E &&
                !transactionAmount.isNegative) {
              transactionAmount = transactionAmount * -1;
            } else if (transactionType != TransactionType.E &&
                transactionAmount.isNegative) {
              // Transfers and incomes -> Convert to positive
              transactionAmount = transactionAmount * -1;
            }

            setState(() {});
          },
        ),
        actions: [
          MonekinPopupMenuButton(actionItems: [
            //TODO
          ])
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildDatePickerButtons(context),
                        const SizedBox(height: 8),
                        Builder(builder: (context) {
                          final bigTextStyle = Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.w800,
                                color: transactionType.color(context),
                                fontSize: transactionAmount.abs() >= 1000
                                    ? transactionAmount >= 1000000
                                        ? 32
                                        : 38
                                    : 48,
                              );

                          return CurrencyDisplayer(
                            amountToConvert: transactionAmount,
                            currencyStyle: bigTextStyle.copyWith(
                                fontWeight: FontWeight.w400),
                            integerStyle: bigTextStyle,
                            currency: fromAccount?.currency,
                          );
                        }),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      buildAccoutAndCategorySelectorRow(context),
                      const Divider(height: 4),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: buildTitleButton(context)),
                          const SizedBox(width: 12),
                          buildExtraInfoButtons(context)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 275,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: AppColors.of(context).light,
            ),
            child: TransactionFormCalculator(
              amountToConvert: transactionAmount,
              showNegativeToggleButton: transactionType.isIncomeOrExpense,
              onSubmit: () => submitForm(),
              onChange: (amount) {
                setState(() {
                  transactionAmount = amount;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Row buildExtraInfoButtons(BuildContext context) {
    return Row(
      children: [
        Builder(builder: (context) {
          final selectedStatus = date.compareTo(DateTime.now()) > 0
              ? TransactionStatus.pending
              : status;

          return IconButton.outlined(
            icon: Icon(
              selectedStatus.icon,
              color: (selectedStatus?.color ?? AppColors.of(context).primary)
                  .withOpacity(date.compareTo(DateTime.now()) > 0 ? 0.3 : 1),
            ),
            tooltip: t.transaction.status.display_long,
            onPressed: date.compareTo(DateTime.now()) > 0
                ? null
                : () => showTransactioStatusModal(
                      context,
                      initialStatus: selectedStatus,
                    ).then((modalRes) {
                      if (modalRes == null) return;

                      setState(() {
                        status = modalRes.result;
                      });
                    }),
          );
        }),
        const SizedBox(width: 6),
        IconButton.outlined(
          onPressed: () => showTransactionMoreInfoModal(
            context,
            data: moreInfo,
          ).then((modalRes) {
            if (modalRes == null) return;

            setState(() {
              moreInfo = modalRes;
            });
          }),
          icon: const Icon(Icons.notes_rounded),
        ),
      ],
    );
  }

  Widget buildDatePickerButtons(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: AppColors.of(context).light,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: buttonStyle,
          onPressed: () {
            openDateTimePicker(
              context,
              showTimePickerAfterDate: false,
              initialDate: date,
            ).then((res) {
              if (res == null) return;

              setState(() {
                date = date.copyWith(
                  day: res.day,
                  year: res.year,
                  month: res.month,
                  isUtc: res.isUtc,
                );
              });
            });
          },
          child: Text(
            DateFormat.yMMMd().format(date),
          ),
        ),
        const SizedBox(width: 4),
        TextButton(
          style: buttonStyle,
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(date),
            ).then((res) {
              if (res == null) return;

              setState(() {
                date = date.copyWith(
                  hour: res.hour,
                  minute: res.minute,
                );
              });
            });
          },
          child: Text(
            DateFormat.Hm().format(date),
          ),
        ),
        const SizedBox(width: 4),
        TextButton(
          style: buttonStyle,
          onPressed: () {
            showIntervalSelectoHelpDialog(context,
                selectedRecurrentRule: recurrentRule,
                onRecurrentRuleSelected: (res) {
              setState(() {
                recurrentRule = res;
              });
            });
          },
          child:
              Icon(recurrentRule.isRecurrent ? Icons.repeat : Icons.repeat_one),
        )
      ],
    );
  }

  TextButton buildTitleButton(BuildContext context) {
    return TextButton(
      onPressed: () => showTransactionTitleModal(
        context,
        initialTitle: title,
      ).then((modalRes) {
        if (modalRes == null) return;

        setState(() {
          title = modalRes;
        });
      }),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        alignment: Alignment.centerLeft,
      ),
      child: Text(
        title.notEmptyString ?? t.transaction.form.title,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight:
                  title.isNotNullNorEmpty ? FontWeight.w400 : FontWeight.w300,
            ),
      ),
    );
  }
}

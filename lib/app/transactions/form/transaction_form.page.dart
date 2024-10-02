import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/transactions/form/dialogs/amount_selector.dart';
import 'package:monekin/app/transactions/form/dialogs/transaction_status_selector.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/animations/scaled_animated_switcher.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../../core/models/transaction/transaction_type.enum.dart';
import '../../../core/presentation/app_colors.dart';
import '../../tags/tags_selector.modal.dart';

openTransactionFormDialog(BuildContext context, TransactionFormPage widget) {
  return showDialog(
      context: context,
      builder: (context) {
        return widget;
      });
}

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({
    super.key,
    this.mode = TransactionType.E,
    this.fromAccount,
    this.transactionToEdit,
  });

  final TransactionType mode;

  final MoneyTransaction? transactionToEdit;

  final Account? fromAccount;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

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

  bool get isEditMode => widget.transactionToEdit != null;

  RecurrencyData recurrentRule = const RecurrencyData.noRepeat();

  List<Tag> tags = [];

  late TransactionType transactionType;

  final _shakeKey = GlobalKey<ShakeWidgetState>();

  late TabController _tabController;
  final _mainContainerRadius = 12.0;

  @override
  void initState() {
    super.initState();

    transactionType = widget.mode;

    _tabController = TabController(
      length: 3,
      initialIndex: transactionType.index,
      vsync: this,
    );

    _tabController.addListener(() {
      transactionType = TransactionType.values.elementAt(_tabController.index);

      if (transactionType.isTransfer && transactionValue.isNegative) {
        transactionValue = transactionValue * -1;
      }

      setState(() {});
    });

    if (widget.transactionToEdit != null) {
      fillForm(widget.transactionToEdit!);

      return;
    }

    AccountService.instance
        .getAccounts(
          predicate: (acc, curr) => AppDB.instance.buildExpr([
            acc.type.equalsValue(AccountType.saving).not(),
            acc.closingDate.isNull()
          ]),
          limit: transactionType.isTransfer ? 2 : 1,
        )
        .first
        .then((acc) {
      fromAccount = widget.fromAccount ?? acc[0];

      WidgetsBinding.instance.addPostFrameCallback((_) {
        displayAmountModal(context);
      });

      if (widget.mode.isTransfer) {
        transferAccount = (acc[1].id != fromAccount!.id ? acc[1] : acc[0]);
      }

      setState(() {});
    });
  }

  Widget selector(
      {required String title,
      required String? inputValue,
      required Widget icon,
      required Function onClick,
      required BorderRadius? borderRadius}) {
    final t = Translations.of(context);

    return InkWell(
      onTap: () => onClick(),
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
    print("HOLAALLALA");
    print(transactionType.isTransfer);
    print(transferAccount);
    if (transactionType.isIncomeOrExpense && selectedCategory == null ||
        transactionType.isTransfer && transferAccount == null) {
      _shakeKey.currentState?.shake();
      return;
    }

    final t = Translations.of(context);
    final scMessenger = ScaffoldMessenger.of(context);

    if (transactionValue == 0) {
      scMessenger.showSnackBar(
        SnackBar(content: Text(t.transaction.form.validators.zero)),
      );

      return;
    }

    if (transactionValue < 0 && transactionType.isTransfer) {
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
        type: transactionType,
        accountID: fromAccount!.id,
        value: transactionType.isIncomeOrExpense &&
                selectedCategory!.type.isExpense
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
        valueInDestiny:
            transactionType.isTransfer ? valueInDestinyToNumber : null,
        categoryID:
            transactionType.isIncomeOrExpense ? selectedCategory?.id : null,
        receivingAccountID:
            transactionType.isTransfer ? transferAccount?.id : null,
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
    final modalRes = await showCategoryPickerModal(
      context,
      modal: CategoryPicker(
        selectedCategory: selectedCategory,
        categoryType: transactionType == TransactionType.E
            ? [CategoryType.E]
            : [CategoryType.I],
      ),
    );

    if (modalRes != null) {
      setState(() {
        selectedCategory = modalRes;
      });
    }
  }

  fillForm(MoneyTransaction transaction) async {
    setState(() {
      fromAccount = transaction.account;
      transferAccount = transaction.receivingAccount;
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
    transactionValue = transaction.value;
    transactionType = transaction.type;

    if (transactionType == TransactionType.E) {
      transactionValue = transactionValue * -1;
    }

    valueInDestinyController.text =
        transaction.valueInDestiny?.abs().toString() ?? '';
  }

  Widget buildValueInDestinyFormField() {
    return ListTile(
      leading: const Icon(Icons.trending_flat_rounded),
      minTileHeight: 64,
      title: TextFormField(
        controller: valueInDestinyController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: t.transfer.form.value_in_destiny.title,
          suffixText: transferAccount?.currency.symbol,
          filled: false,
          isDense: false,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: decimalDigitFormatter,
        validator: (value) {
          final defaultNumberValidatorResult = fieldValidator(value,
              isRequired: false, validator: ValidatorType.double);

          if (defaultNumberValidatorResult != null) {
            return defaultNumberValidatorResult;
          }

          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget buildStatusSelector() {
    final isSelectorDisabled = date.compareTo(DateTime.now()) > 0;

    final selectedStatus =
        isSelectorDisabled ? TransactionStatus.pending : status;

    return ListTile(
      leading: ScaledAnimatedSwitcher(
        keyToWatch: selectedStatus.icon.toString(),
        child: Icon(
          selectedStatus.icon,
          color:
              (selectedStatus?.color ?? Theme.of(context).colorScheme.primary)
                  .withOpacity(isSelectorDisabled ? 0.3 : 1),
        ),
      ),
      minTileHeight: 64,
      title: Text(selectedStatus.displayName(context)),
      enabled: !isSelectorDisabled,
      onTap: () {
        showTransactioStatusModal(context, initialStatus: status)
            .then((modalRes) {
          if (modalRes == null) return;

          setState(() {
            status = modalRes.result;
          });
        });
      },
    );
  }

  Widget buildRecurrencySelectorField() {
    return ListTile(
      leading: Icon(
        recurrentRule.isRecurrent ? Icons.repeat_rounded : Icons.repeat_one,
      ),
      minTileHeight: 64,
      title: Text(recurrentRule.formText(context)),
      onTap: () {
        showIntervalSelectoHelpDialog(context,
            selectedRecurrentRule: recurrentRule,
            onRecurrentRuleSelected: (res) {
          setState(() {
            recurrentRule = res;
          });
        });
      },
    );
  }

  Widget buildDescriptionField() {
    return ListTile(
      leading: const Icon(Icons.description_rounded),
      minTileHeight: 64,
      titleAlignment: ListTileTitleAlignment.titleHeight,
      title: TextFormField(
        controller: notesController,
        minLines: 2,
        maxLines: 10,
        decoration: InputDecoration(
          isDense: false,
          filled: false,
          border: InputBorder.none,
          hintText: t.transaction.form.description_info,
        ),
      ),
    );
  }

  Widget buildTitleField() {
    return ListTile(
      leading: const Icon(Icons.title_rounded),
      title: TextFormField(
        controller: titleController,
        maxLength: maxLabelLenghtForDisplayNames,
        decoration: InputDecoration(
          isDense: false,
          filled: false,
          counterText: '',
          border: InputBorder.none,
          hintText: t.transaction.form.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final formFieldWithDividers = [
      buildTitleField(),
      const Divider(),
      buildTransactionDateSelector(),
      const Divider(),
      buildRecurrencySelectorField(),
      const Divider(),
      buildStatusSelector(),
      const Divider(),
      buildTransactionTagsSelector(),
      const Divider(),
      if (transactionType.isTransfer) ...[
        buildValueInDestinyFormField(),
        const Divider(),
      ],
      buildDescriptionField(),
      const Divider(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode
              ? t.transaction.edit
              : transactionType == TransactionType.T
                  ? t.transfer.create
                  : transactionType == TransactionType.E
                      ? t.transaction.new_expense
                      : t.transaction.new_income,
        ),
        backgroundColor: transactionType.color(context).withOpacity(0.85),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          unselectedLabelColor: Colors.white.withOpacity(0.8),
          tabAlignment: TabAlignment.fill,
          dividerColor: transactionType.color(context).darken(0.3),
          controller: _tabController,
          tabs: TransactionType.values
              .map((tType) => Tab(
                    text: tType.displayName(context),
                  ))
              .toList(),
          isScrollable: false,
        ),
      ),
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                submitForm();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.general.validations.form_error)),
                );
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          buildAmountContainer(context),
                          buildAccoutAndCategorySelectorRow(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(thickness: 2),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  child: Column(
                    children: formFieldWithDividers,
                  ),
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildAmountContainer(context),
              buildAccoutAndCategorySelectorRow(context),

              //   const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 4, bottom: 12),
                  child: Column(
                    children: formFieldWithDividers,
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
        initialAmount: transactionValue,
        enableSignToggleButton: transactionType.isIncomeOrExpense,
        currency: fromAccount?.currency,
        onSubmit: (amount) {
          setState(() {
            transactionValue = amount;
            Navigator.pop(context);
          });
        },
      ),
    );
  }

  Widget buildAmountContainer(BuildContext context) {
    return Tappable(
      bgColor: transactionType.color(context).withOpacity(0.85),
      onTap: () => displayAmountModal(context),
      borderRadius: BreakPoint.of(context).isLargerThan(BreakpointID.md)
          ? BorderRadius.only(
              topLeft: Radius.circular(_mainContainerRadius),
              topRight: Radius.circular(_mainContainerRadius),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: IconDisplayer(
                      key: ValueKey(transactionType.mathIcon.toString()),
                      mainColor: transactionType.color(context),
                      secondaryColor: Colors.white,
                      padding: 2,
                      borderRadius: 4,
                      icon: transactionType.mathIcon,
                    ),
                  ),
                  AnimatedDefaultTextStyle(
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: transactionValue >= 1000
                            ? transactionValue >= 1000000
                                ? 28
                                : 34
                            : 38),
                    duration: const Duration(milliseconds: 200),
                    child: Builder(builder: (context) {
                      const bigTextStyle =
                          TextStyle(fontWeight: FontWeight.w800);

                      return CurrencyDisplayer(
                        amountToConvert: transactionValue,
                        currency: fromAccount?.currency,
                        currencyStyle: bigTextStyle,
                        integerStyle: bigTextStyle,
                        followPrivateMode: false,
                      );
                    }),
                  ),
                ],
              ),
              if (fromAccount != null)
                StreamBuilder(
                    stream: ExchangeRateService.instance
                        .calculateExchangeRateToPreferredCurrency(
                      fromCurrency: fromAccount!.currency.code,
                      amount: transactionValue,
                    ),
                    builder: (context, exchangeRateSnapshot) {
                      final shouldHide = !exchangeRateSnapshot.hasData ||
                          exchangeRateSnapshot.data! == transactionValue;

                      final valueInPrefCurrencyIndicator = Column(
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.swap_horizontal_circle_rounded,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              CurrencyDisplayer(
                                amountToConvert: exchangeRateSnapshot.data ?? 0,
                                integerStyle: const TextStyle(
                                    fontWeight: FontWeight.w300),
                                followPrivateMode: false,
                              ),
                            ],
                          ),
                        ],
                      );

                      return AnimatedSizeSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: !shouldHide
                            ? valueInPrefCurrencyIndicator
                            : const SizedBox.shrink(),
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTransactionTagsSelector() {
    final Widget tagsChips = Wrap(
      spacing: 6,
      runSpacing: 0,
      children: List.generate(tags.length, (index) {
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
          selectedColor: tag.colorData.lighten(0.8),
          avatar: tag.displayIcon(),
        );
      }),
    );

    return ListTile(
        leading: Icon(Tag.icon),
        minTileHeight: 64,
        onTap: () {
          showTagListModal(context,
              modal: TagSelector(
                selectedTags: tags,
                allowEmptySubmit: true,
                includeNullTag: false,
              )).then(
            (value) {
              if (value == null) {
                return;
              }

              setState(() {
                tags = value.nonNulls.toList();
              });
            },
          );
        },
        title: tags.isEmpty
            ? Text(
                t.tags.select.title,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                ),
              )
            : tagsChips);
  }

  Widget buildTransactionDateSelector() {
    final dateFormat = date.year == currentYear
        ? DateFormat.MMMMd().add_jm()
        : DateFormat.yMMMd().add_jm();

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.event),
          minTileHeight: 64,
          title: Text(dateFormat.format(date)),
          onTap: () async {
            final datePickerRes = await openDateTimePicker(
              context,
              initialDate: date,
              showTimePickerAfterDate: true,
            );

            if (datePickerRes != null) {
              setState(() {
                date = datePickerRes;
              });
            }
          },
        ),
        if (date.compareTo(DateTime.now()) > 0)
          InlineInfoCard(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            text: t.transaction.form.validators.date_max,
            mode: InlineInfoCardMode.info,
          ),
        if (fromAccount != null &&
            fromAccount!.date.compareTo(date) > 0 &&
            !(date.compareTo(DateTime.now()) > 0))
          InlineInfoCard(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            text: t.transaction.form.validators.date_after_account_creation,
            mode: InlineInfoCardMode.warn,
          ),
      ],
    );
  }

  Widget buildAccoutAndCategorySelectorRow(BuildContext context) {
    final borderRadius = Radius.circular(_mainContainerRadius);

    return DecoratedBox(
        decoration: BoxDecoration(
          color: transactionType.color(context).withOpacity(0.35),
          borderRadius: BorderRadius.only(
            bottomLeft: borderRadius,
            bottomRight: borderRadius,
          ),
        ),
        child: SizedBox(
          height: 74,
          child: Row(
            children: [
              ...[
                Expanded(
                  flex: 1,
                  child: selector(
                      title: t.general.account,
                      inputValue: fromAccount?.name,
                      borderRadius: BorderRadius.only(bottomLeft: borderRadius),
                      icon: fromAccount?.displayIcon(context) ??
                          IconDisplayer(
                            displayMode: IconDisplayMode.polygon,
                            icon: Icons.question_mark_rounded,
                            mainColor: Theme.of(context).colorScheme.primary,
                          ),
                      onClick: () async {
                        final modalRes =
                            await showAccountSelector(fromAccount!);

                        if (modalRes != null && modalRes.isNotEmpty) {
                          setState(() {
                            fromAccount = modalRes.first;
                          });
                        }
                      }),
                ),
                VerticalDivider(
                  color: transactionType.color(context).withOpacity(0.85),
                  thickness: 2,
                )
              ],
              if (transactionType.isTransfer)
                Expanded(
                  flex: 1,
                  child: ShakeWidget(
                    duration: const Duration(milliseconds: 200),
                    shakeCount: 1,
                    shakeOffset: 10,
                    key: _shakeKey,
                    child: selector(
                        title: t.transfer.form.to,
                        inputValue: transferAccount?.name,
                        borderRadius:
                            BorderRadius.only(bottomRight: borderRadius),
                        icon: transferAccount?.displayIcon(context) ??
                            IconDisplayer(
                              displayMode: IconDisplayMode.polygon,
                              icon: Icons.question_mark_rounded,
                              mainColor: Theme.of(context).colorScheme.primary,
                            ),
                        onClick: () async {
                          final modalRes =
                              await showAccountSelector(transferAccount);

                          if (modalRes != null && modalRes.isNotEmpty) {
                            setState(() {
                              transferAccount = modalRes.first;
                            });
                          }
                        }),
                  ),
                ),
              if (!transactionType.isTransfer)
                Expanded(
                  flex: 1,
                  child: ShakeWidget(
                    duration: const Duration(milliseconds: 200),
                    shakeCount: 1,
                    shakeOffset: 10,
                    key: _shakeKey,
                    child: selector(
                      title: t.general.category,
                      inputValue: selectedCategory?.name,
                      borderRadius:
                          BorderRadius.only(bottomRight: borderRadius),
                      icon: IconDisplayer.fromCategory(
                        context,
                        category: selectedCategory ??
                            Category.fromDB(Category.unkown(), null),
                        size: 24,
                      ),
                      onClick: () => selectCategory(),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}

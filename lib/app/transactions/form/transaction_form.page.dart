import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/tags/tag_list.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.dart';
import 'package:monekin/core/presentation/animations/shake/shake_widget.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/expansion_panel/single_expansion_panel.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/status_filter/transaction_status_filter.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/tags_filter/tags_filter_container.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:uuid/uuid.dart';

enum TransactionFormMode { transfer, incomeOrExpense }

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

  final _shakeKey = GlobalKey<ShakeWidgetState>();

  Widget selector({
    required bool isMobile,
    required String title,
    required String? inputValue,
    required SupportedIcon? icon,
    required Color? iconColor,
    required Function onClick,
  }) {
    icon ??= SupportedIconService.instance.defaultSupportedIcon;
    iconColor ??= Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.primaryContainer;

    final t = Translations.of(context);

    if (isMobile) {
      return InkWell(
        onTap: () => onClick(),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              icon.displayFilled(color: iconColor, size: 28),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Text(
                    inputValue ?? t.general.unspecified,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return TextFormField(
        controller:
            TextEditingController(text: inputValue ?? t.general.unspecified),
        readOnly: true,
        validator: (_) => fieldValidator(inputValue, isRequired: true),
        onTap: () => onClick(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.arrow_drop_down),
          prefixIcon: Container(
            margin: const EdgeInsets.fromLTRB(14, 8, 8, 8),
            child: icon.displayFilled(color: iconColor),
          ),
        ));
  }

  submitForm() {
    final t = Translations.of(context);
    final scMessenger = ScaffoldMessenger.of(context);

    if (valueToNumber! < 0) {
      scMessenger.showSnackBar(SnackBar(
          content: Text(widget.mode == TransactionFormMode.incomeOrExpense
              ? t.transaction.form.validators.negative_transaction
              : t.transaction.form.validators.negative_transfer)));

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
      AccountService.instance
          .getAccounts(
              predicate: (acc, curr) => AppDB.instance.buildExpr([
                    acc.type.equalsValue(AccountType.saving).not(),
                    acc.isArchived.isNotValue(true)
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
      if (widget.mode == TransactionFormMode.transfer) ...[
        TextFormField(
          controller: valueInDestinyController,
          decoration: InputDecoration(
              labelText:
                  '${t.transfer.form.currency_exchange_selector.value_in_destiny}  *',
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
        const SizedBox(height: 16),
      ],
      if (widget.mode == TransactionFormMode.transfer &&
          valueToNumber != null &&
          valueInDestinyToNumber == null) ...[
        InlineInfoCard(
            text: '${t.transfer.form.currency_info_add(
              x: NumberFormat.currency(symbol: toAccount!.currency.symbol)
                  .format(valueToNumber),
            )} ',
            mode: InlineInfoCardMode.info),
        const SizedBox(height: 16),
      ],
      TextFormField(
        minLines: 2,
        maxLines: 10,
        controller: notesController,
        decoration: InputDecoration(
          labelText: t.transaction.form.description,
          alignLabelWithHint: true,
          hintText: t.transaction.form.description_info,
        ),
      ),
      if (recurrentRule.isNoRecurrent) ...[
        const SizedBox(height: 16),
        TransactionStatusFilter(
          selectedStatuses: [status],
          allowMultipleSelection: false,
          onSelected: (statusSelected, value) {
            setState(() {
              status = statusSelected;
            });
          },
        ),
      ],
      const SizedBox(height: 16),
      TagsFilterContainer(
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
              onPressed: () => showTagListModal(
                      context, TagList(isModal: true, selected: tags))
                  .then((value) {
                if (value != null) {
                  setState(() {
                    tags = value;
                  });
                }
              }),
            ),
          ],
        ),
      )
    ];
  }

  Widget buildTitleField() {
    return TextFormField(
      controller: titleController,
      maxLength: maxLabelLenghtForDisplayNames,
      decoration: InputDecoration(labelText: t.transaction.form.title),
    );
  }

  Widget buildCalculatorButton(
    BuildContext context, {
    required String text,
    int flex = 1,
    Color? bgColor,
    Color? textColor,
  }) {
    textColor ??= Theme.of(context).colorScheme.onBackground;
    bgColor ??= Theme.of(context).colorScheme.background;

    onButtonPress() {
      HapticFeedback.lightImpact();

      final decimalPlaces = valueController.text.split('.').elementAtOrNull(1);

      if (text == 'DONE') {
        if (widget.mode == TransactionFormMode.incomeOrExpense &&
            selectedCategory == null) {
          _shakeKey.currentState?.shake();
          return;
        }

        submitForm();
        return;
      }

      if (text == 'AC') {
        valueController.text = '0';
      } else if (text == '⌫' && valueToNumber != null) {
        valueController.text =
            valueController.text.substring(0, valueController.text.length - 1);
      } else {
        if (decimalPlaces != null && decimalPlaces.length >= 2) {
          return;
        }

        valueController.text += text;
      }
      setState(() {});
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shadowColor: bgColor.darken(0.15),
            surfaceTintColor: bgColor.darken(0.15),
            foregroundColor: textColor,
            disabledForegroundColor: textColor.withOpacity(0.3),
            disabledBackgroundColor: bgColor.withOpacity(0.3),
            elevation: 0,
          ),
          onPressed:
              text == 'DONE' && (valueToNumber == null || valueToNumber == 0)
                  ? null
                  : () => onButtonPress(),
          child: text == '⌫' || text == 'DONE'
              ? Icon(
                  text == '⌫' ? Icons.backspace_rounded : Icons.check_rounded)
              : Text(
                  text,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final bool isBlue = (widget.mode == TransactionFormMode.transfer ||
        selectedCategory == null);

    final trColor = isBlue
        ? CustomColors.of(context).brand.lighten()
        : (selectedCategory!.type.isIncome
            ? CustomColors.of(context).success
            : CustomColors.of(context).danger);

    final trColorLighten = Theme.of(context).brightness == Brightness.light
        ? trColor.lighten(0.65)
        : trColor.darken(0.65);

    return StreamBuilder(
        stream: UserSettingService.instance
            .getSetting(SettingKey.transactionMobileMode),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isEditMode
                    ? t.transaction.edit
                    : widget.mode == TransactionFormMode.transfer
                        ? t.transfer.create
                        : selectedCategory == null
                            ? t.transaction.create
                            : selectedCategory!.type.isExpense
                                ? t.transaction.new_expense
                                : t.transaction.new_income,
              ),
            ),
            persistentFooterButtons: snapshot.hasData && snapshot.data == '0'
                ? [
                    PersistentFooterButton(
                      child: FilledButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            submitForm();
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: Text(isEditMode
                            ? t.transaction.edit
                            : t.transaction.create),
                      ),
                    )
                  ]
                : null,
            body: Builder(builder: (context) {
              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }

              if (snapshot.data == '1') {
                /* -----------------------------------------------
                ---------- FORM IN A CALCULATOR STYLE ------------
                ------------------------------------------------- */

                return Column(
                  children: [
                    Flexible(
                      flex: 8,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 400),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          fontSize: (valueToNumber ?? 0) >= 1000
                                              ? (valueToNumber ?? 0) >= 1000000
                                                  ? 36
                                                  : 42
                                              : 56),
                                  child: CurrencyDisplayer(
                                    amountToConvert: valueToNumber ?? 0,
                                    currency: fromAccount?.currency,
                                  ),
                                ),
                                if (date.compareTo(DateTime.now()) > 0)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 32),
                                    child: InlineInfoCard(
                                      text: t
                                          .transaction.form.validators.date_max,
                                      direction: Axis.horizontal,
                                      mode: InlineInfoCardMode.info,
                                    ),
                                  ),
                                if (fromAccount != null &&
                                    fromAccount!.date.compareTo(date) > 0 &&
                                    !(date.compareTo(DateTime.now()) > 0))
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InlineInfoCard(
                                      text: t.transaction.form.validators
                                          .date_after_account_creation,
                                      direction: Axis.vertical,
                                      mode: InlineInfoCardMode.warn,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          //const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        child: recurrentRule.isNoRecurrent
                                            ? Text(
                                                DateFormat.yMMMMd()
                                                    .add_Hm()
                                                    .format(date),
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              )
                                            : Text(
                                                '${DateFormat.yMMMMd().format(date)} - ${recurrentRule.formText(context)}',
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              ),
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await openDateTimePicker(
                                            context,
                                            initialDate: date,
                                            firstDate: fromAccount?.date,
                                            showTimePickerAfterDate: true,
                                          );
                                          if (pickedDate == null) return;

                                          setState(() {
                                            date = pickedDate;
                                          });
                                        },
                                      ),
                                    ),
                                    IconButton.filled(
                                      onPressed: () async {
                                        final res =
                                            await showIntervalSelectoHelpDialog(
                                                context,
                                                selectedRecurrentRule:
                                                    recurrentRule);

                                        if (res == null) return;

                                        setState(() {
                                          recurrentRule = res;
                                        });
                                      },
                                      icon: recurrentRule.isRecurrent
                                          ? const Icon(
                                              Icons.event_repeat_rounded)
                                          : const Icon(
                                              Icons.repeat_one_rounded),
                                    ),
                                    IconButton.filled(
                                      icon:
                                          const Icon(Icons.text_fields_rounded),
                                      onPressed: () => showModalBottomSheet(
                                        context: context,
                                        showDragHandle: true,
                                        isScrollControlled: true,
                                        builder: (context) =>
                                            DraggableScrollableSheet(
                                                expand: false,
                                                maxChildSize: 0.85,
                                                minChildSize: 0.5,
                                                initialChildSize: 0.55,
                                                builder: (context,
                                                    scrollController) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              ScrollableWithBottomGradient(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 8,
                                                              horizontal: 16,
                                                            ),
                                                            controller:
                                                                scrollController,
                                                            child: Column(
                                                              children: [
                                                                buildTitleField(),
                                                                const SizedBox(
                                                                    height: 16),
                                                                ...buildExtraFields()
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        BottomSheetFooter(
                                                            submitText: t
                                                                .general
                                                                .close_and_save,
                                                            showCloseIcon:
                                                                false,
                                                            submitIcon: Icons
                                                                .keyboard_arrow_down_rounded,
                                                            onSaved: () {
                                                              Navigator.pop(
                                                                  context);
                                                            })
                                                      ],
                                                    ),
                                                  );
                                                }),
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  color: Theme.of(context).colorScheme.primary,
                                  child: DefaultTextStyle.merge(
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          selector(
                                              isMobile: true,
                                              title: t.general.account,
                                              inputValue: fromAccount?.name,
                                              icon: fromAccount?.icon,
                                              iconColor: null,
                                              onClick: () async {
                                                final modalRes =
                                                    await showAccountSelector(
                                                        fromAccount!);

                                                if (modalRes != null &&
                                                    modalRes.isNotEmpty) {
                                                  setState(() {
                                                    fromAccount =
                                                        modalRes.first;
                                                  });
                                                }
                                              }),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: appColorScheme(context)
                                                .onPrimary,
                                          ),
                                          if (widget.mode ==
                                              TransactionFormMode.transfer)
                                            selector(
                                                isMobile: true,
                                                title: t.transfer.form.to,
                                                inputValue: toAccount?.name,
                                                icon: toAccount?.icon,
                                                iconColor: null,
                                                onClick: () async {
                                                  final modalRes =
                                                      await showAccountSelector(
                                                          toAccount!);

                                                  if (modalRes != null &&
                                                      modalRes.isNotEmpty) {
                                                    setState(() {
                                                      toAccount =
                                                          modalRes.first;
                                                    });
                                                  }
                                                }),
                                          if (widget.mode ==
                                              TransactionFormMode
                                                  .incomeOrExpense)
                                            ShakeWidget(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              shakeCount: 1,
                                              shakeOffset: 10,
                                              key: _shakeKey,
                                              child: selector(
                                                isMobile: true,
                                                title: t.general.category,
                                                inputValue:
                                                    selectedCategory?.name,
                                                icon: selectedCategory?.icon,
                                                iconColor: selectedCategory !=
                                                        null
                                                    ? ColorHex.get(
                                                        selectedCategory!.color)
                                                    : null,
                                                onClick: () => selectCategory(),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const Divider(),
                        ],
                      ),
                    ),

                    /*  ---------- NUMMBER CALCULATOR BUTTONS ------------ */
                    Flexible(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: trColorLighten,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '1'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '4'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '7'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '.'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '2'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '5'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '8'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '0'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '3'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '6'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '9'),
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: '⌫'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildCalculatorButton(context,
                                      bgColor: trColorLighten, text: 'AC'),
                                  buildCalculatorButton(context,
                                      bgColor: trColor,
                                      text: 'DONE',
                                      textColor: Colors.white,
                                      flex: 3),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }

              /* -----------------------------------------------
              ---------- FORM IN IT'S DEFAULT STYLE ------------
              ------------------------------------------------- */

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: valueController,
                              decoration: InputDecoration(
                                  labelText: '${t.transaction.form.value} *',
                                  hintText: 'Ex.: 200',
                                  suffixText: fromAccount?.currency.symbol),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                final defaultNumberValidatorResult =
                                    fieldValidator(value,
                                        isRequired: true,
                                        validator: ValidatorType.double);

                                if (defaultNumberValidatorResult != null) {
                                  return defaultNumberValidatorResult;
                                }

                                if (valueToNumber! == 0) {
                                  return t.transaction.form.validators.zero;
                                }

                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              inputFormatters: decimalDigitFormatter,
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 16),
                            selector(
                                isMobile: false,
                                title: '${t.general.account} *',
                                inputValue: fromAccount?.name,
                                icon: fromAccount?.icon,
                                iconColor: null,
                                onClick: () async {
                                  final modalRes =
                                      await showAccountSelector(fromAccount!);

                                  if (modalRes != null && modalRes.isNotEmpty) {
                                    setState(() {
                                      fromAccount = modalRes.first;
                                    });
                                  }
                                }),
                            const SizedBox(height: 16),
                            if (widget.mode == TransactionFormMode.transfer)
                              selector(
                                  isMobile: false,
                                  title: '${t.transfer.form.to} *',
                                  inputValue: toAccount?.name,
                                  icon: toAccount?.icon,
                                  iconColor: null,
                                  onClick: () async {
                                    final modalRes =
                                        await showAccountSelector(toAccount!);

                                    if (modalRes != null &&
                                        modalRes.isNotEmpty) {
                                      setState(() {
                                        toAccount = modalRes.first;
                                      });
                                    }
                                  }),
                            if (widget.mode ==
                                TransactionFormMode.incomeOrExpense)
                              selector(
                                isMobile: false,
                                title: '${t.general.category} *',
                                inputValue: selectedCategory?.name,
                                icon: selectedCategory?.icon,
                                iconColor: selectedCategory != null
                                    ? ColorHex.get(selectedCategory!.color)
                                    : null,
                                onClick: () => selectCategory(),
                              ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: TextEditingController(
                                  text: DateFormat.yMMMMd()
                                      .add_Hm()
                                      .format(date)),
                              decoration: InputDecoration(
                                  labelText: '${t.general.time.datetime} *'),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await openDateTimePicker(
                                  context,
                                  initialDate: date,
                                  firstDate: fromAccount?.date,
                                  showTimePickerAfterDate: true,
                                );
                                if (pickedDate == null) return;

                                setState(() {
                                  date = pickedDate;
                                });
                              },
                            ),
                            if (date.compareTo(DateTime.now()) > 0) ...[
                              const SizedBox(height: 8),
                              InlineInfoCard(
                                  text: t.transaction.form.validators.date_max,
                                  mode: InlineInfoCardMode.info),
                              const SizedBox(height: 4),
                            ],
                            const SizedBox(height: 16),
                            TextField(
                              controller: TextEditingController(
                                  text: recurrentRule.formText(context)),
                              readOnly: true,
                              onTap: () async {
                                final res = await showIntervalSelectoHelpDialog(
                                    context,
                                    selectedRecurrentRule: recurrentRule);

                                if (res == null) return;

                                setState(() {
                                  recurrentRule = res;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: t.general.time.periodicity.display,
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            const SizedBox(height: 16),
                            buildTitleField()
                          ],
                        ),
                      ),
                    ),
                    SingleExpansionPanel(
                      sidePadding: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: buildExtraFields()),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_type_selector.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/currency_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/date_form_field/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/expansion_panel/single_expansion_panel.dart';
import 'package:monekin/core/presentation/widgets/icon_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filters.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class AccountFormPage extends StatefulWidget {
  const AccountFormPage({Key? key, this.account}) : super(key: key);

  /// Account UUID to edit (if any)
  final Account? account;

  @override
  State<AccountFormPage> createState() => _AccountFormPageState();
}

class _AccountFormPageState extends State<AccountFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _swiftController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  AccountType _type = AccountType.normal;
  SupportedIcon _icon = SupportedIconService.instance.defaultSupportedIcon;
  Currency? _currency;
  Currency? _userPrCurrency;

  Account? _accountToEdit;

  DateTime _openingDate = DateTime.now();
  DateTime? _closeDate;

  submitForm() async {
    final accountService = AccountService.instance;

    double newBalance = double.parse(_balanceController.text);

    navigateBack() => Navigator.pop(context);
    final snackbarDisplayer = ScaffoldMessenger.of(context).showSnackBar;

    if (_accountToEdit != null) {
      if ((await TransactionService.instance
              .getTransactions(
                filters: TransactionFilters(
                    accountsIDs: [_accountToEdit!.id], maxDate: _openingDate),
                limit: 2,
              )
              .first)
          .isNotEmpty) {
        snackbarDisplayer(
            SnackBar(content: Text(t.account.form.tr_before_opening_date)));

        return;
      }

      newBalance = _accountToEdit!.iniValue +
          newBalance -
          await accountService.getAccountMoney(account: _accountToEdit!).first;
    }

    Account accountToSubmit = Account(
      id: _accountToEdit?.id ?? const Uuid().v4(),
      name: _nameController.text,
      iniValue: newBalance,
      date: _openingDate,
      closingDate: _closeDate,
      type: _type,
      iconId: _icon.id,
      currency: _currency!,
      iban: _ibanController.text.isEmpty ? null : _ibanController.text,
      description: _textController.text.isEmpty ? null : _textController.text,
      swift: _swiftController.text.isEmpty ? null : _swiftController.text,
    );

    if (_accountToEdit != null) {
      await accountService
          .updateAccount(accountToSubmit)
          .then((value) => {navigateBack()});
    } else {
      final db = AppDB.instance;

      final query = db.select(db.accounts)
        ..addColumns([db.accounts.id.count()])
        ..where((tbl) => tbl.name.isValue(_nameController.text));

      if (await query.watchSingleOrNull().first != null) {
        snackbarDisplayer(SnackBar(
          content: Text(t.account.form.already_exists),
        ));

        return;
      }

      await accountService
          .insertAccount(accountToSubmit)
          .then((value) => {navigateBack()});
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.account != null) {
      _accountToEdit = widget.account;
      _fillForm();
    }

    CurrencyService.instance.getUserPreferredCurrency().first.then((value) {
      setState(() {
        if (widget.account == null) {
          _currency = value;
        }
        _userPrCurrency = value;
      });
    });
  }

  void _fillForm() {
    final accountService = AccountService.instance;

    if (_accountToEdit == null) return;

    _nameController.text = _accountToEdit!.name;
    _ibanController.text = _accountToEdit!.iban ?? '';
    _swiftController.text = _accountToEdit!.swift ?? '';
    _textController.text = _accountToEdit!.description ?? '';

    _openingDate = _accountToEdit!.date;
    _closeDate = _accountToEdit!.closingDate;

    _type = _accountToEdit!.type;

    accountService
        .getAccountMoney(account: _accountToEdit!)
        .first
        .then((value) {
      _balanceController.text = value.toString();
    });

    _icon = _accountToEdit!.icon;

    CurrencyService.instance
        .getCurrencyByCode(_accountToEdit!.currency.code)
        .first
        .then((value) {
      setState(() {
        _currency = value;
      });
    });

    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _textController.dispose();
    _ibanController.dispose();
    _swiftController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
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
            label: Text(_accountToEdit != null
                ? t.account.form.edit
                : t.account.form.create),
          ),
        )
      ],
      appBar: AppBar(
        title: Text(widget.account != null
            ? t.account.form.edit
            : t.account.form.create),
      ),
      body: widget.account != null && _accountToEdit == null
          ? const LinearProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              showIconSelectorModal(
                                context,
                                IconSelectorModal(
                                  preselectedIconID: _icon.id,
                                  subtitle: t.icon_selector.select_account_icon,
                                  onIconSelected: (selectedIcon) {
                                    setState(() {
                                      _icon = selectedIcon;
                                    });
                                  },
                                ),
                              );
                            },
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.625,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: _icon.display(
                                    size: 48,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground)),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: '${t.account.form.name} *',
                                hintText: 'Ex.: My account',
                              ),
                              validator: (value) =>
                                  fieldValidator(value, isRequired: true),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _balanceController,
                        decoration: InputDecoration(
                          labelText: widget.account != null
                              ? '${t.account.form.current_balance} *'
                              : '${t.account.form.initial_balance} *',
                          hintText: 'Ex.: 200',
                          suffixText: _currency?.symbol,
                        ),
                        keyboardType: TextInputType.number,
                        enabled: !(widget.account != null &&
                            widget.account!.isClosed),
                        inputFormatters: decimalDigitFormatter,
                        validator: (value) => fieldValidator(value,
                            validator: ValidatorType.double, isRequired: true),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                          controller: TextEditingController(
                              text: _currency != null
                                  ? _currency?.name
                                  : t.general.unspecified),
                          readOnly: true,
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
                                  }),
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
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: SvgPicture.asset(
                                        _currency!.currencyIconPath,
                                        height: 25,
                                        width: 25,
                                      ),
                                    )
                                  : null)),
                      const SizedBox(height: 12),
                      if (_currency != null)
                        StreamBuilder(
                            stream: ExchangeRateService.instance
                                .getLastExchangeRateOf(
                                    currencyCode: _currency!.code),
                            builder: (context, snapshot) {
                              if (snapshot.hasData ||
                                  _currency?.code == _userPrCurrency?.code) {
                                return Container();
                              } else {
                                return InlineInfoCard(
                                    text:
                                        t.account.form.currency_not_found_warn,
                                    mode: InlineInfoCardMode.warn);
                              }
                            }),
                      StreamBuilder(
                        stream: _accountToEdit == null
                            ? Stream.value(true)
                            : TransactionService.instance
                                .countTransactions(
                                  predicate: TransactionFilters(
                                    transactionTypes: [
                                      TransactionType.expense,
                                      TransactionType.income
                                    ],
                                    accountsIDs: [_accountToEdit!.id],
                                  ),
                                )
                                .map((event) => event.numberOfRes == 0),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data! == false) {
                            return Container();
                          }

                          return Column(
                            children: [
                              const SizedBox(height: 12),
                              AccountTypeSelector(
                                  selectedType: _type,
                                  onSelected: (newType) {
                                    setState(() {
                                      _type = newType;
                                    });
                                  })
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SingleExpansionPanel(
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            DateTimeFormField(
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.event),
                                labelText: '${t.account.date} *',
                              ),
                              initialDate: _openingDate,
                              dateFormat: DateFormat.yMMMd().add_jm(),
                              lastDate: _closeDate ?? DateTime.now(),
                              validator: (e) => e == null
                                  ? t.general.validations.required
                                  : null,
                              onDateSelected: (DateTime value) {
                                setState(() {
                                  _openingDate = value;
                                });
                              },
                            ),
                            const SizedBox(height: 22),
                            if (_accountToEdit != null &&
                                _accountToEdit!.isClosed) ...[
                              DateTimeFormField(
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.event),
                                  labelText: t.account.close_date,
                                ),
                                initialDate: _closeDate,
                                firstDate: _openingDate,
                                lastDate: DateTime.now(),
                                dateFormat: DateFormat.yMMMd().add_jm(),
                                onDateSelected: (DateTime value) {
                                  setState(() {
                                    _closeDate = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 22),
                            ],
                            TextFormField(
                              controller: _ibanController,
                              decoration: InputDecoration(
                                labelText: t.account.form.iban,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 22),
                            TextFormField(
                              controller: _swiftController,
                              decoration: InputDecoration(
                                labelText: t.account.form.swift,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 22),
                            TextFormField(
                              minLines: 2,
                              maxLines: 10,
                              controller: _textController,
                              decoration: InputDecoration(
                                labelText: t.account.form.notes,
                                hintText: t.account.form.notes_placeholder,
                                alignLabelWithHint: true,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 22),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

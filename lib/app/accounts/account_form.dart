import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/account_type_selector.dart';
import 'package:monekin/app/accounts/tracking_mode_selector.dart';
import 'package:monekin/app/accounts/widgets/account_group.dart';
import 'package:monekin/app/accounts/widgets/balance_currency_form_field.dart';
import 'package:monekin/app/categories/form/icon_and_color_selector.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/list_tile_field.dart';
import 'package:monekin/core/presentation/widgets/icon_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/show_more_content_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class AccountFormPage extends StatefulWidget {
  const AccountFormPage({super.key, this.account});

  /// Account UUID to edit (if any)
  final Account? account;

  @override
  State<AccountFormPage> createState() => _AccountFormPageState();
}

class _AccountFormPageState extends State<AccountFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final FocusNode _groupFocusNode = FocusNode();

  /// The group names already in use, offered as autocomplete suggestions.
  List<String> _existingGroups = [];

  /// The accounts of each existing group (in display order), used both to
  /// render the group icon/color in the suggestions and to prefill the
  /// icon/color when the user picks a group.
  final Map<String, List<Account>> _accountsByGroup = {};

  /// Whether the user has explicitly picked an icon or color. While `false`,
  /// choosing a group adopts that group's icon and color.
  bool _iconOrColorTouched = false;

  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _swiftController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController(
    text: '0',
  );
  final TextEditingController _cutoffDayController = TextEditingController();
  final TextEditingController _dueDayController = TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();
  final TextEditingController _minPaymentPctController =
      TextEditingController();

  AccountType _type = AccountType.money;
  bool _isSaving = false;
  AccountTrackingMode _trackingMode = AccountTrackingMode.transactions;
  SupportedIcon _icon = SupportedIconService.instance.defaultSupportedIcon;
  Color _color = ColorHex.get(defaultColorPickerOptions.randomItem());
  Currency? _currency;
  Currency? _userPrCurrency;

  late final Account? _accountToEdit;

  DateTime _openingDate = DateTime.now();
  DateTime? _closeDate;

  Future<void> submitForm() async {
    final t = Translations.of(context);
    final accountService = AccountService.instance;

    double iniValue;
    if (_accountToEdit != null) {
      // Check if there are transactions before the opening date of the account:
      if ((await TransactionService.instance
              .getTransactions(
                filters: TransactionFilterSet(
                  accountsIDs: [_accountToEdit.id],
                  maxDate: _openingDate,
                ),
                limit: 2,
              )
              .first)
          .isNotEmpty) {
        MonekinSnackbar.warning(
          SnackbarParams(t.account.form.tr_before_opening_date),
        );

        return;
      }

      iniValue = _accountToEdit.iniValue;
    } else {
      iniValue = double.parse(_balanceController.text);

      // Credit cards ask for the current debt, stored as a negative balance.
      if (_type == AccountType.credit) iniValue = -iniValue;
    }

    // Accounts are grouped by an exact match of this text, so a stray space
    // would silently create a group of its own.
    final groupName = _groupController.text.trim();
    final isCredit = _type == AccountType.credit;
    final minPaymentPct = double.tryParse(_minPaymentPctController.text);

    Account accountToSubmit = Account(
      id: _accountToEdit?.id ?? generateUUID(),
      name: _nameController.text,
      groupName: groupName.isEmpty ? null : groupName,
      displayOrder: _accountToEdit?.displayOrder ?? 10,
      iniValue: iniValue,
      date: _openingDate,
      closingDate: _closeDate,
      type: _type,
      isSaving: _type == AccountType.money ? _isSaving : false,
      trackingMode: _type == AccountType.investment
          ? _trackingMode
          : AccountTrackingMode.transactions,
      iconId: _icon.id,
      color: _color.toHex(),
      currency: _currency!,
      iban: _ibanController.text.isEmpty ? null : _ibanController.text,
      description: _textController.text.isEmpty ? null : _textController.text,
      swift: _swiftController.text.isEmpty ? null : _swiftController.text,
      cutoffDay: isCredit ? int.parse(_cutoffDayController.text) : null,
      dueDay: isCredit ? int.parse(_dueDayController.text) : null,
      creditLimit: isCredit
          ? double.tryParse(_creditLimitController.text)
          : null,
      minPaymentPct: isCredit && minPaymentPct != null
          ? minPaymentPct / 100
          : null,
    );

    // Check for accounts with same names before continue:
    if (_accountToEdit == null || _accountToEdit.name != accountToSubmit.name) {
      final db = AppDB.instance;
      final query = db.select(db.accounts)
        ..addColumns([db.accounts.id.count()])
        ..where((tbl) => tbl.name.isValue(_nameController.text));

      if (await query.watchSingleOrNull().first != null) {
        MonekinSnackbar.error(
          SnackbarParams.fromError(
            t.account.form.already_exists,
            duration: const Duration(seconds: 6),
          ),
        );

        return;
      }
    }

    if (_accountToEdit != null) {
      // Each tracking mode reads positions from a different source (trades vs.
      // portfolio snapshots). Holdings mode also takes cash from the snapshot,
      // so the current cash is written into it as well.
      if (accountToSubmit.trackingMode != _accountToEdit.trackingMode) {
        await HoldingService.instance.convertTrackingMode(
          accountId: accountToSubmit.id,
          to: accountToSubmit.trackingMode,
          anchorTradeTitle: t.assets.holdings.opening_position,
          snapshotCash: await accountService
              .getAccountCash(account: _accountToEdit)
              .first,
        );
      }

      await accountService
          .updateAccount(accountToSubmit)
          .then((value) => {RouteUtils.popRoute()});
    } else {
      await accountService
          .insertAccount(accountToSubmit)
          .then((value) => {RouteUtils.popRoute()});
    }
  }

  @override
  void initState() {
    super.initState();

    _accountToEdit = widget.account;

    if (_accountToEdit != null) {
      _fillForm();
    }

    CurrencyService.instance.ensureAndGetPreferredCurrency().first.then((
      value,
    ) {
      setState(() {
        if (widget.account == null) {
          _currency = value;
        }
        _userPrCurrency = value;
      });
    });

    AccountService.instance.getAccounts().first.then((accounts) {
      if (!mounted) return;

      final byGroup = <String, List<Account>>{};
      for (final account in accounts) {
        final group = account.groupName;
        if (group != null) {
          byGroup.putIfAbsent(group, () => []).add(account);
        }
      }

      setState(() {
        _accountsByGroup
          ..clear()
          ..addAll(byGroup);
        _existingGroups = byGroup.keys.toList()..sort();
      });
    });

    _groupController.addListener(_adoptGroupStyleIfUntouched);
  }

  /// When creating an account and the user hasn't customized the icon/color
  /// yet, adopt them from the first account of the chosen group.
  void _adoptGroupStyleIfUntouched() {
    if (_accountToEdit != null || _iconOrColorTouched) return;

    final accounts = _accountsByGroup[_groupController.text.trim()];
    if (accounts == null) return;

    final match = accountGroupRepresentative(accounts);

    setState(() {
      _icon = match.icon;
      _color = match.getComputedColor(context);
    });
  }

  void _fillForm() {
    if (_accountToEdit == null) return;

    final accountService = AccountService.instance;

    _nameController.text = _accountToEdit.name;
    _groupController.text = _accountToEdit.groupName ?? '';
    _ibanController.text = _accountToEdit.iban ?? '';
    _swiftController.text = _accountToEdit.swift ?? '';
    _textController.text = _accountToEdit.description ?? '';

    _openingDate = _accountToEdit.date;
    _closeDate = _accountToEdit.closingDate;

    _type = _accountToEdit.type;
    _isSaving = _accountToEdit.isSaving;
    _trackingMode = _accountToEdit.trackingMode;

    _cutoffDayController.text = _accountToEdit.cutoffDay?.toString() ?? '';
    _dueDayController.text = _accountToEdit.dueDay?.toString() ?? '';
    _creditLimitController.text = _accountToEdit.creditLimit?.toString() ?? '';
    _minPaymentPctController.text = _accountToEdit.minPaymentPct == null
        ? ''
        : (_accountToEdit.minPaymentPct! * 100).toString();

    accountService.getAccountMoney(account: _accountToEdit).first.then((value) {
      setState(() {
        _color = _accountToEdit.getComputedColor(context);
      });
    });

    _icon = _accountToEdit.icon;

    CurrencyService.instance
        .getCurrencyByCode(_accountToEdit.currency.code)
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
    _groupController.removeListener(_adoptGroupStyleIfUntouched);
    _groupController.dispose();
    _groupFocusNode.dispose();
    _balanceController.dispose();
    _textController.dispose();
    _ibanController.dispose();
    _swiftController.dispose();
    _cutoffDayController.dispose();
    _dueDayController.dispose();
    _creditLimitController.dispose();
    _minPaymentPctController.dispose();

    super.dispose();
  }

  /// The account type tile. A [locked] one is greyed out and, instead of
  /// opening the selector, tells why it can't be changed.
  Widget _buildAccountTypeField({bool locked = false}) {
    final t = Translations.of(context);

    // The tile gets its own context so that the selector popover anchors to it
    // and not to the whole form (on wide layouts it is positioned and sized
    // after the render box of the widget that opened it).
    final field = Builder(
      builder: (context) => ListTileField(
        leading: Icon(
          _type.icon,
          color: locked
              ? Theme.of(context).disabledColor
              : Theme.of(context).colorScheme.primary,
        ),
        title: t.account.types.title,
        subtitle: _type.title(context),
        trailing: locked
            ? Tooltip(
                message: t.account.types.locked_warn,
                child: const Icon(Icons.lock_outline),
              )
            : const Icon(Icons.chevron_right),
        onTap: locked
            ? () => MonekinSnackbar.info(
                SnackbarParams(t.account.types.locked_warn),
              )
            : () async {
                final selected = await showAccountTypeSelector(
                  context,
                  selectedType: _type,
                );

                if (selected != null) {
                  setState(() => _type = selected);
                }
              },
      ),
    );

    return locked ? Opacity(opacity: 0.6, child: field) : field;
  }

  /// Billing cycle, limit and minimum payment of a credit card account.
  Widget _buildCreditCardFields() {
    final t = Translations.of(context);

    String? dayValidator(String? value) {
      final error = fieldValidator(value, isRequired: true);
      if (error != null) return error;

      final day = int.tryParse(value!);
      return day == null || day < 1 || day > 31
          ? t.account.credit.form.day_validation
          : null;
    }

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _cutoffDayController,
                decoration: InputDecoration(
                  labelText: '${t.account.credit.cutoff_day} *',
                  helperText: t.account.credit.form.day_descr,
                  helperMaxLines: 2,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: dayValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _dueDayController,
                decoration: InputDecoration(
                  labelText: '${t.account.credit.due_day} *',
                  helperText: t.account.credit.form.day_descr,
                  helperMaxLines: 2,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: dayValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: _creditLimitController,
          decoration: InputDecoration(
            labelText: t.account.credit.limit,
            suffixText: _currency?.symbol,
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: twoDecimalDigitFormatter,
          validator: (value) => fieldValidator(
            value,
            isRequired: false,
            validator: ValidatorType.double,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
        ),
        TextFormField(
          controller: _minPaymentPctController,
          decoration: InputDecoration(
            labelText: t.account.credit.form.min_payment_pct,
            helperText: t.account.credit.form.min_payment_pct_descr,
            helperMaxLines: 2,
            suffixText: '%',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: twoDecimalDigitFormatter,
          validator: (value) {
            final error = fieldValidator(
              value,
              isRequired: false,
              validator: ValidatorType.double,
            );
            if (error != null) return error;

            final pct = double.tryParse(value ?? '');
            return pct != null && pct > 100
                ? t.account.credit.form.pct_validation
                : null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final pageTitle = widget.account != null
        ? t.account.form.edit
        : t.account.form.create;
    final footerButtons = [
      PersistentFooterButton(
        child: FilledButton.icon(
          style: getMediumButtonStyle(context),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              submitForm();
            }
          },
          icon: const Icon(Icons.save),
          label: Text(pageTitle),
        ),
      ),
    ];

    return PageFramework(
      title: pageTitle,
      persistentFooterButtons: footerButtons,
      body: Builder(
        builder: (context) {
          if (widget.account != null && _accountToEdit == null) {
            return const LinearProgressIndicator();
          }

          final isDark = isAppInDarkBrightness(context);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Builder(
                builder: (context) {
                  final List<Widget> formChildren = [];

                  void add(Widget w) {
                    formChildren.add(w);
                    formChildren.add(const SizedBox(height: 12));
                  }

                  // Name
                  add(
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: '${t.account.form.name} *',
                        hintText: t.account.form.name_placeholder,
                      ),
                      validator: (value) =>
                          fieldValidator(value, isRequired: true),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                    ),
                  );

                  // Group
                  add(
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return RawAutocomplete<String>(
                          textEditingController: _groupController,
                          focusNode: _groupFocusNode,
                          optionsBuilder: (textEditingValue) {
                            final input = textEditingValue.text
                                .trim()
                                .toLowerCase();

                            return _existingGroups.where((group) {
                              final lower = group.toLowerCase();

                              // Don't suggest what's already fully typed.
                              if (lower == input) return false;

                              return input.isEmpty || lower.contains(input);
                            });
                          },
                          fieldViewBuilder:
                              (context, controller, focusNode, onSubmitted) {
                                return TextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: t.account.form.group,
                                    hintText: t.account.form.group_placeholder,
                                    helperText: t.account.form.group_descr,
                                    helperMaxLines: 2,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) => onSubmitted(),
                                );
                              },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(8),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: 200,
                                    maxWidth: constraints.maxWidth,
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);

                                      final groupAccounts =
                                          _accountsByGroup[option];

                                      return ListTile(
                                        dense: true,
                                        leading: groupAccounts == null
                                            ? null
                                            : accountGroupIcon(
                                                context,
                                                groupAccounts,
                                                size: 20,
                                              ),
                                        title: Text(option),
                                        onTap: () => onSelected(option),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );

                  // Icon & color selector
                  add(
                    IconAndColorSelector(
                      iconSelectorModalSubtitle:
                          t.icon_selector.select_account_icon,
                      iconDisplayer: IconDisplayer(
                        supportedIcon: _icon,
                        size: 36,
                        isOutline: true,
                        outlineWidth: 1.5,
                        onTap: () {
                          showIconSelectorModal(
                            context,
                            IconSelectorModal(
                              preselectedIconID: _icon.id,
                              subtitle: t.icon_selector.select_account_icon,
                              onIconSelected: (selectedIcon) {
                                setState(() {
                                  _icon = selectedIcon;
                                  _iconOrColorTouched = true;
                                });
                              },
                            ),
                          );
                        },
                        mainColor: _color.lighten(
                          isDark ? IconDisplayer.darkLightenFactor : 0,
                        ),
                        secondaryColor: _color.lighten(
                          isDark ? 0 : IconDisplayer.darkLightenFactor,
                        ),
                        displayMode: IconDisplayMode.polygon,
                      ),
                      onDataChange: ((data) {
                        setState(() {
                          _icon = data.icon;
                          _color = data.color;
                          _iconOrColorTouched = true;
                        });
                      }),
                      data: (color: _color, icon: _icon),
                    ),
                  );

                  // Amount / Currency fields (conditionally add)
                  if (widget.account == null) {
                    add(
                      AmountAndCurrencyFormField(
                        amountController: _balanceController,
                        currency: _currency,
                        amountLabel: _type == AccountType.credit
                            ? t.account.credit.form.initial_debt
                            : t.account.form.initial_balance,
                        enabled: true,
                        onCurrencySelected: (newCurrency) {
                          setState(() {
                            _currency = newCurrency;
                          });
                        },
                      ),
                    );
                  } else if (_currency != null) {
                    add(
                      CurrencyFormField(
                        currency: _currency,
                        onCurrencySelected: (newCurrency) {
                          setState(() {
                            _currency = newCurrency;
                          });
                        },
                      ),
                    );
                  }

                  // Exchange rate info: only include spacing when showing content
                  if (_currency != null) {
                    formChildren.add(
                      StreamBuilder(
                        stream: ExchangeRateService.instance
                            .getLastExchangeRateOf(
                              currencyCode: _currency!.code,
                            ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData ||
                              _currency?.code == _userPrCurrency?.code) {
                            return const SizedBox.shrink();
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InlineInfoCard(
                                  text: t.account.form.currency_not_found_warn,
                                  mode: InlineInfoCardMode.warn,
                                ),
                                const SizedBox(height: 12),
                              ],
                            );
                          }
                        },
                      ),
                    );
                  }

                  // Account type. Any account can become an investment one,
                  // but the way back is only offered while there is nothing
                  // investment-specific that would be left unreachable.
                  final investmentAccountId =
                      _accountToEdit?.type == AccountType.investment
                      ? _accountToEdit!.id
                      : null;

                  add(
                    investmentAccountId == null
                        ? _buildAccountTypeField()
                        : StreamBuilder(
                            stream: HoldingService.instance
                                .hasInvestmentRecords(investmentAccountId),
                            builder: (context, snapshot) =>
                                _buildAccountTypeField(
                                  locked: snapshot.data ?? true,
                                ),
                          ),
                  );

                  // Savings flag (only relevant for money accounts)
                  if (_type == AccountType.money) {
                    formChildren.add(
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        value: _isSaving,
                        onChanged: (v) => setState(() => _isSaving = v),
                        title: Text(t.account.types.saving),
                        subtitle: Text(t.account.types.saving_descr),
                      ),
                    );
                    formChildren.add(const SizedBox(height: 12));
                  }

                  // Tracking mode (only relevant for investment accounts)
                  if (_type == AccountType.investment) {
                    formChildren.add(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Builder(
                            builder: (context) => ListTileField(
                              leading: Icon(
                                _trackingMode.icon,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: t.account.tracking_modes.title,
                              subtitle: _trackingMode.title(context),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () async {
                                final selectedMode =
                                    await showTrackingModeSelector(
                                      context,
                                      selectedMode: _trackingMode,
                                    );
                                if (selectedMode != null) {
                                  setState(() => _trackingMode = selectedMode);
                                }
                              },
                            ),
                          ),
                          if (_accountToEdit?.type == AccountType.investment &&
                              _trackingMode !=
                                  _accountToEdit?.trackingMode) ...[
                            const SizedBox(height: 4),
                            InlineInfoCard(
                              text: t.account.tracking_modes.switch_warn,
                              mode: InlineInfoCardMode.warn,
                            ),
                          ],
                        ],
                      ),
                    );
                    formChildren.add(const SizedBox(height: 12));
                  }

                  if (_type == AccountType.credit) {
                    add(_buildCreditCardFields());
                  }

                  // Show more fields
                  // Build the inner column as before (it manages its own spacing)
                  formChildren.add(
                    ShowMoreContentButton(
                      headerPadding: const EdgeInsets.only(top: 12),
                      child: Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                          if (_accountToEdit != null && _accountToEdit.isClosed)
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _ibanController,
                                decoration: InputDecoration(
                                  labelText: t.account.form.iban,
                                  border: appInputBorder.copyWith(
                                    borderRadius: BorderRadius.only(
                                      topLeft: inputBorderRadius,
                                      topRight: inputBorderRadius,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                              const Divider(),
                              TextFormField(
                                controller: _swiftController,
                                decoration: InputDecoration(
                                  labelText: t.account.form.swift,
                                  border: appInputBorder.copyWith(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: inputBorderRadius,
                                      bottomRight: inputBorderRadius,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ],
                          ),

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
                  );

                  // Remove trailing spacing if present
                  if (formChildren.isNotEmpty &&
                      formChildren.last is SizedBox) {
                    formChildren.removeLast();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: formChildren,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

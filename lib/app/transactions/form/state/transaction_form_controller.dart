import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/accounts/account_selector.dart';
import 'package:monekin/app/accounts/details/holdings_card.dart';
import 'package:monekin/app/categories/selectors/category_picker.dart';
import 'package:monekin/app/tags/tags_selector.modal.dart';
import 'package:monekin/app/transactions/form/dialogs/amount_selector.dart';
import 'package:monekin/app/transactions/form/dialogs/evaluate_expression.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/tags/tags_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/database/services/user-setting/default_transaction_values.service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/utils/drift_utils.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/tags/tag.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/shake_widget.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class TransactionFormController extends ChangeNotifier {
  TransactionFormController({
    TransactionType? mode,
    MoneyTransaction? transactionToEdit,
    Account? fromAccount,
    Account? toAccount,
    Debt? linkedDebt,
    SecurityInDB? security,
    bool isSell = false,
  }) : _mode = mode,
       _transactionToEdit = transactionToEdit,
       _prefillFromAccount = fromAccount,
       _prefillToAccount = toAccount,
       _linkedDebt = linkedDebt,
       _security = security,
       _securityTradeIsSell = isSell {
    _amountTextController.addListener(_onAmountFieldTextChanged);
    valueInDestinyController.addListener(_onValueInDestinyTextChanged);
    quantityController.addListener(_onTradeFieldChanged);
    priceController.addListener(_onTradeFieldChanged);
    tradeTotalController.addListener(_safeNotify);
    installmentsController.addListener(_onInstallmentsTextChanged);
  }

  final TransactionType? _mode;
  final MoneyTransaction? _transactionToEdit;
  final Account? _prefillFromAccount;
  final Account? _prefillToAccount;
  final Debt? _linkedDebt;

  /// Whether a save is in progress (used to ignore repeated taps on save).
  bool isSubmitting = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ShakeWidgetState> shakeKey = GlobalKey<ShakeWidgetState>();
  final GlobalKey dualLegTopCardKey = GlobalKey();
  final GlobalKey dualLegBottomCardKey = GlobalKey();

  final FocusNode amountFocusNode = FocusNode(debugLabel: 'transactionAmount');
  final FocusNode titleFocusNode = FocusNode(debugLabel: 'transactionTitle');
  final FocusNode notesFocusNode = FocusNode(debugLabel: 'transactionNotes');
  final FocusNode quantityFocusNode = FocusNode(debugLabel: 'tradeQuantity');

  Future<void>? _formDefaultsFuture;

  final TextEditingController _amountTextController = TextEditingController();
  bool _amountFieldSyncGuard = false;

  double transactionValue = 0;
  final TextEditingController valueInDestinyController =
      TextEditingController();
  double? get valueInDestinyToNumber =>
      double.tryParse(valueInDestinyController.text);

  Category? selectedCategory;
  Account? fromAccount;
  Account? transferAccount;
  DateTime date = DateTime.now();
  TransactionStatus? status;
  final TextEditingController notesController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  RecurrencyData recurrentRule = const RecurrencyData.noRepeat();
  List<Tag> tags = [];

  /// Monthly installments of a credit card purchase. Null when paid at once.
  int? installments;
  final TextEditingController installmentsController = TextEditingController();

  /// Only one-off purchases of a credit card can be paid in installments, not
  /// inverted expenses (refunds).
  bool get canPayInInstallments =>
      transactionType == TransactionType.expense &&
      transactionValue >= 0 &&
      fromAccount?.isCredit == true &&
      recurrentRule.isNoRecurrent;

  // --- Security trades (stock/fund/crypto buy & sell) ---------------------
  SecurityInDB? _security;
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool _securityTradeIsSell;

  /// Units held before this trade, used to cap a sell. Null until loaded.
  double? _heldQuantity;
  Future<void>? _heldQuantityLoad;

  // The price is in the security currency but the cash moves in the account
  // one. When they differ, the cash amount is its own field: filled in with
  // the stored exchange rate unless the user types what they really paid.
  // With the same currency the cash is always quantity × price, so the average
  // cost (which ignores the fees) stays consistent with it.
  final TextEditingController tradeTotalController = TextEditingController();
  bool _customTradeTotal = false;

  /// An edited trade starts with its saved total. It only counts as typed by
  /// the user if it is not the one the form would have computed.
  bool _checkSavedTradeTotal = false;
  CurrencyInDB? _securityCurrency;
  double _securityToAccountRate = 1;

  /// True for a security trade (type N with a securityID): when creating one
  /// (opened with the investment mode) or editing an existing one.
  bool get isSecurityTradeInvestment {
    final edit = _transactionToEdit;
    if (edit == null) return _mode == TransactionType.investment;
    return edit.type == TransactionType.investment && edit.securityID != null;
  }

  SecurityInDB? get security => _security;
  bool get securityTradeIsBuy => !_securityTradeIsSell;

  /// Units available to sell, counting back the units of the trade being
  /// edited when they are part of the holding. Null until loaded.
  double? get securityTradeAvailableUnits {
    final held = _heldQuantity;
    if (held == null) return null;
    final edit = _transactionToEdit;
    final editCountsInHolding =
        edit != null &&
        edit.recurrentInfo.isNoRecurrent &&
        edit.status != TransactionStatus.pending &&
        edit.status != TransactionStatus.voided;
    return editCountsInHolding ? held - (edit.quantity ?? 0) : held;
  }

  double get securityTradeQuantity =>
      double.tryParse(quantityController.text.trim().replaceAll(',', '.')) ?? 0;
  double get securityTradePricePerUnit =>
      double.tryParse(priceController.text.trim().replaceAll(',', '.')) ?? 0;
  double get securityTradeTotal =>
      securityTradeQuantity * securityTradePricePerUnit;

  CurrencyInDB? get securityCurrency => _securityCurrency;

  /// True when the security is quoted in another currency than the account.
  bool get isTradeCurrencyMismatch {
    final account = fromAccount;
    final security = _security;
    return account != null &&
        security != null &&
        security.currencyId != account.currencyId;
  }

  bool get isTradeTotalCustom => _customTradeTotal;

  /// The stored rate from the security currency to the account one.
  double get securityToAccountRate => _securityToAccountRate;

  /// What the trade is worth at the stored rate, in the account currency.
  double get securityTradeConvertedValue =>
      securityTradeTotal * _securityToAccountRate;

  /// The rate the user really got: what moved in the account currency over
  /// what the trade is worth in the security one. Null until both are known.
  double? get securityTradeEffectiveRate {
    final total = securityTradeTotal;
    final cash = securityTradeCashAmount;
    return total > 0 && cash > 0 ? cash / total : null;
  }

  /// How much more the trade cost (or less it brought) than at the stored rate,
  /// in the account currency: fees and the exchange spread together. Positive
  /// is a loss, whether buying or selling.
  double get securityTradeExtraCost {
    final difference = securityTradeCashAmount - securityTradeConvertedValue;
    return securityTradeIsBuy ? difference : -difference;
  }

  /// The cash of the trade, in the account currency: quantity × price, or the
  /// total of [tradeTotalController] when the currencies differ.
  double get securityTradeCashAmount {
    if (!isTradeCurrencyMismatch) return securityTradeTotal;
    return double.tryParse(
          tradeTotalController.text.trim().replaceAll(',', '.'),
        ) ??
        0;
  }

  void _syncTradeTotal() {
    if (_customTradeTotal || !isTradeCurrencyMismatch) return;
    final decimals = fromAccount?.currency.decimalPlaces ?? 2;
    tradeTotalController.text = _plainNumber(
      double.parse(
        (securityTradeTotal * _securityToAccountRate).toStringAsFixed(decimals),
      ),
    );
  }

  /// With [v], the total can be typed. Without it, it goes back to the amount
  /// converted with the stored exchange rate.
  void setTradeTotalCustom(bool v) {
    if (_customTradeTotal == v) return;
    _customTradeTotal = v;
    if (!v) _syncTradeTotal();
    _safeNotify();
  }

  void setSecurityTradeIsSell(bool v) {
    if (_securityTradeIsSell == v) return;
    _securityTradeIsSell = v;
    _safeNotify();

    // Only a held security can be sold: ask again if this one isn't
    if (v && !isEditMode) unawaited(_dropSecurityIfNotHeld());
  }

  Future<void> _dropSecurityIfNotHeld() async {
    final security = _security;
    final account = fromAccount;
    if (security == null || account == null) return;

    final holding = await HoldingService.instance
        .getHolding(account.id, security.id)
        .first;
    if (_disposed || _security?.id != security.id || !_securityTradeIsSell) {
      return;
    }
    if (holding != null && holding.quantity > 1e-7) return;

    _security = null;
    _heldQuantity = null;
    _safeNotify();
  }

  void _onTradeFieldChanged() {
    _syncTradeTotal();
    _safeNotify();
  }

  /// When true, money flows from the bottom leg to the top leg (transfer).
  bool _dualLegFlowReversed = false;

  /// Transfer: when false both legs stay linked through the exchange rate.
  bool _customTransferAmounts = false;

  bool get customTransferAmounts => _customTransferAmounts;

  TextEditingController get amountTextController => _amountTextController;

  bool get isEditMode => _transactionToEdit != null;

  late TransactionType transactionType;

  /// Transfer: combined account + amount cards replace the classic amount
  /// row and account selector layout.
  bool get usesDualLegAmountLayout => transactionType.isTransfer;

  bool get dualLegFlowReversed => _dualLegFlowReversed;

  bool get dualLegTopIsOutflow => !_dualLegFlowReversed;

  Account? get effectiveTransferFromAccount =>
      _dualLegFlowReversed ? transferAccount : fromAccount;

  Account? get effectiveTransferToAccount =>
      _dualLegFlowReversed ? fromAccount : transferAccount;

  /// Rate to convert the transfer amount from the origin to the destination
  /// currency at [date] (1 when they match or an account is missing).
  Stream<double> get transferRate {
    final from = effectiveTransferFromAccount;
    final to = effectiveTransferToAccount;

    if (from == null || to == null || from.currency.code == to.currency.code) {
      return Stream.value(1);
    }

    return ExchangeRateService.instance.calculateExchangeRate(
      fromCurrency: from.currency.code,
      toCurrency: to.currency.code,
      date: date,
    );
  }

  MoneyTransaction? get transactionToEdit => _transactionToEdit;
  Debt? get linkedDebt => _linkedDebt;

  bool _disposed = false;

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  void initialize() {
    if (isSecurityTradeInvestment) {
      transactionType = TransactionType.investment;
      final edit = _transactionToEdit;
      if (edit == null) {
        fromAccount = _prefillFromAccount;
        if (_security != null) _onSecuritySelected(_security!);
        return;
      }
      _securityTradeIsSell = !edit.value.isNegative;
      quantityController.text = _plainNumber((edit.quantity ?? 0).abs());
      priceController.text = _plainNumber(edit.pricePerUnit ?? 0);
      _customTradeTotal = true;
      _checkSavedTradeTotal = true;
      tradeTotalController.text = _plainNumber(edit.value.abs());
      _fillForm(edit);
      _heldQuantityLoad = _loadSecurity().then((_) => _loadHeldQuantity());
      unawaited(_heldQuantityLoad);
      return;
    }

    final edit = _transactionToEdit;
    transactionType =
        edit?.type ?? _mode ?? _defaultTransactionTypeFromSettings();
    if (edit != null) {
      _fillForm(edit);
      return;
    }

    _formDefaultsFuture = _initializeFormValues();
  }

  TransactionType _defaultTransactionTypeFromSettings() {
    final raw = appStateSettings[SettingKey.defaultTransactionType];
    if (raw == null) return TransactionType.expense;
    return TransactionType.values.firstWhereOrNull((e) => e.name == raw) ??
        TransactionType.expense;
  }

  Future<void> waitForFormDefaults() async {
    await (_formDefaultsFuture ?? Future.value());
  }

  /// After create-mode defaults (and optional category sheet), moves focus to amount.
  Future<void> bootstrapCreateCategoryAndFocusAmount(
    BuildContext context,
  ) async {
    if (isEditMode) return;
    if (!transactionType.isIncomeOrExpense) {
      if (usesDualLegAmountLayout) return;
      _requestAmountFocusSoon();
      return;
    }

    if (selectedCategory == null) {
      await selectCategory(context);
      if (_disposed || !context.mounted) return;
    }
    _requestAmountFocusSoon();
  }

  void _requestAmountFocusSoon() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_disposed) return;
      amountFocusNode.requestFocus();
    });
  }

  void requestAmountFocusAfterFrame() {
    if (usesDualLegAmountLayout) return;
    _requestAmountFocusSoon();
  }

  Future<void> _loadSecurity() async {
    final id = _transactionToEdit?.securityID;
    if (id == null) return;
    final loaded = await SecurityService.instance.getSecurityById(id).first;
    if (_disposed) return;
    _security = loaded;
    _safeNotify();
    unawaited(_loadTradeCurrencyAndRate());
  }

  /// Lets the user pick the security of a new trade.
  Future<void> pickSecurity(BuildContext context) async {
    final account = fromAccount;
    final picked = await showSecurityPicker(
      context,
      heldInAccountId: securityTradeIsBuy ? null : account?.id,
      accountCurrencyId: account?.currencyId,
    );
    if (picked == null || _disposed) return;
    _onSecuritySelected(picked);
  }

  void _onSecuritySelected(SecurityInDB security) {
    _security = security;
    _heldQuantity = null;
    _securityCurrency = null;
    _securityToAccountRate = 1;
    _customTradeTotal = false;
    priceController.text = _plainNumber(security.currentPrice ?? 0);
    _safeNotify();
    _heldQuantityLoad = _loadHeldQuantity();
    unawaited(_heldQuantityLoad);
    unawaited(_loadTradeCurrencyAndRate());
    requestQuantityFocusAfterFrame();
  }

  void requestQuantityFocusAfterFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_disposed) quantityFocusNode.requestFocus();
    });
  }

  /// Loads the currency of the security and the rate to the account currency
  /// on the date of the trade.
  Future<void> _loadTradeCurrencyAndRate() async {
    final security = _security;
    final account = fromAccount;
    if (security == null || account == null) return;
    final requestedDate = date;

    final currency = await CurrencyService.instance
        .getCurrencyByCode(security.currencyId)
        .first;
    final rate = security.currencyId == account.currencyId
        ? 1.0
        : await ExchangeRateService.instance
              .calculateExchangeRate(
                fromCurrency: security.currencyId,
                toCurrency: account.currencyId,
                date: requestedDate,
              )
              .first;

    // Requests can finish out of order: only the one for what is selected now
    // may set the rate
    if (_disposed ||
        _security?.id != security.id ||
        fromAccount?.currencyId != account.currencyId ||
        date != requestedDate) {
      return;
    }

    _securityCurrency = currency;
    _securityToAccountRate = rate;
    if (_checkSavedTradeTotal) {
      _checkSavedTradeTotal = false;
      if (nearlyEqualMoney(
        securityTradeConvertedValue,
        securityTradeCashAmount,
      )) {
        _customTradeTotal = false;
      }
    }
    _syncTradeTotal();
    _safeNotify();
  }

  Future<void> _loadHeldQuantity() async {
    final account = fromAccount;
    final security = _security;
    if (account == null || security == null) return;
    final holding = await HoldingService.instance
        .getHolding(account.id, security.id)
        .first;
    if (_disposed) return;
    _heldQuantity = holding?.quantity ?? 0;
    _safeNotify();
  }

  static String _plainNumber(double v) {
    if (v == 0) return '';
    final isInt = v == v.roundToDouble();
    return isInt ? v.toInt().toString() : v.toString();
  }

  @override
  void dispose() {
    _disposed = true;
    _amountTextController.removeListener(_onAmountFieldTextChanged);
    _amountTextController.dispose();
    valueInDestinyController.removeListener(_onValueInDestinyTextChanged);
    valueInDestinyController.dispose();
    quantityController.removeListener(_onTradeFieldChanged);
    quantityController.dispose();
    priceController.removeListener(_onTradeFieldChanged);
    priceController.dispose();
    tradeTotalController.removeListener(_safeNotify);
    tradeTotalController.dispose();
    installmentsController.removeListener(_onInstallmentsTextChanged);
    installmentsController.dispose();
    notesController.dispose();
    titleController.dispose();
    amountFocusNode.dispose();
    titleFocusNode.dispose();
    notesFocusNode.dispose();
    quantityFocusNode.dispose();
    super.dispose();
  }

  void _onValueInDestinyTextChanged() {
    _safeNotify();
  }

  void _onAmountFieldTextChanged() {
    if (_amountFieldSyncGuard) return;

    final raw = _amountTextController.text.trim().replaceAll(',', '.');

    if (raw.isEmpty) {
      if (transactionValue != 0) {
        transactionValue = 0;
        _safeNotify();
      }
      return;
    }

    final double parsed;
    try {
      parsed = evaluateExpression(raw);
    } catch (_) {
      return;
    }

    transactionValue = parsed;
    _safeNotify();
  }

  void syncAmountFieldFromTransactionValue() {
    _amountFieldSyncGuard = true;

    if (transactionValue == 0) {
      _amountTextController.text = '';
    } else {
      final rounded = double.parse(
        transactionValue.toStringAsFixed(
          fromAccount?.currency.decimalPlaces ?? 2,
        ),
      );

      final isInt = rounded == rounded.roundToDouble();
      _amountTextController.text = isInt
          ? rounded.toInt().toString()
          : rounded.toString();
    }
    _amountFieldSyncGuard = false;
  }

  void onTransactionTypeChanged(TransactionType newType) {
    if (newType == transactionType) return;
    transactionType = newType;
    if (transactionType.isTransfer && transactionValue.isNegative) {
      transactionValue = transactionValue * -1;
    }
    if (selectedCategory != null &&
        !transactionType.isTransfer &&
        !selectedCategory!.type.matchWithTransactionType(transactionType)) {
      selectedCategory = null;
    }
    _safeNotify();
  }

  void toggleDualLegFlowDirection() {
    if (!transactionType.isTransfer) return;

    _dualLegFlowReversed = !_dualLegFlowReversed;
    valueInDestinyController.clear();

    HapticFeedback.mediumImpact();

    _safeNotify();
  }

  Future<void> _initializeFormValues() async {
    final settings = await DefaultTransactionValuesService.instance
        .getAllSettings()
        .first;
    final lastTr = DefaultTransactionValuesService.lastCreatedTransaction.value;

    bool useLast(TransactionFormField f) =>
        settings.lastUsedFields.contains(f) && lastTr != null;

    if (_prefillFromAccount != null) {
      fromAccount = _prefillFromAccount;
    } else if (useLast(TransactionFormField.account)) {
      final acc = await AccountService.instance
          .getAccountById(lastTr!.transaction.accountID)
          .first;
      if (acc != null) fromAccount = acc;
    }

    if (_prefillToAccount != null) {
      transferAccount = _prefillToAccount;
    }

    // On a transfer the source can't be the same account as the destination.
    // Drop a source that collides with a prefilled destination so it gets
    // re-picked below with a different account.
    if (transactionType.isTransfer &&
        fromAccount != null &&
        fromAccount!.id == transferAccount?.id) {
      fromAccount = null;
    }

    if (fromAccount == null ||
        (transactionType.isTransfer && transferAccount == null)) {
      final accounts = await AccountService.instance
          .getAccounts(
            predicate: (acc, curr) => buildDriftExpr([
              acc.isSaving.equals(false),
              acc.closingDate.isNull(),
            ]),
            limit: transactionType.isTransfer ? 3 : 1,
          )
          .first;

      if (fromAccount == null) {
        fromAccount =
            accounts.firstWhereOrNull((a) => a.id != transferAccount?.id) ??
            accounts.firstOrNull;
      }

      if (transactionType.isTransfer && transferAccount == null) {
        transferAccount = accounts.firstWhereOrNull(
          (a) => a.id != fromAccount?.id,
        );
      }
    }

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

    if (useLast(TransactionFormField.status)) {
      status = lastTr!.transaction.status;
    } else {
      status = settings.values.status;
    }

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

    if (useLast(TransactionFormField.date)) {
      date = lastTr!.transaction.date;
    }

    if (useLast(TransactionFormField.note)) {
      notesController.text = lastTr!.transaction.notes ?? '';
    }

    syncAmountFieldFromTransactionValue();
    if (!_disposed) notifyListeners();
  }

  /// Account whose balance the draft can reduce (the transfer source, honoring the flow direction).
  Account? get balanceWarningAccount =>
      transactionType.isTransfer ? effectiveTransferFromAccount : fromAccount;

  /// Net ledger effect of the draft on [balanceWarningAccount] (matches how balances aggregate rows).
  double draftEffectOnFromAccountLedger() {
    if (transactionType == TransactionType.expense) {
      return transactionValue * -1;
    }
    if (transactionType == TransactionType.transfer) {
      return -transactionValue.abs();
    }
    return transactionValue;
  }

  /// Ledger effect of the row being edited on [balanceWarningAccount], if it matches the edited row's account.
  double? get oldEffectOnFromAccountLedgerForEdit {
    final edit = _transactionToEdit;
    final from = balanceWarningAccount;
    if (edit == null || from == null) return null;
    if (edit.type == TransactionType.transfer &&
        edit.receivingAccount?.id == from.id) {
      return edit.valueInDestiny ?? edit.value;
    }
    if (edit.account.id != from.id) return null;
    if (edit.type == TransactionType.transfer) {
      return -edit.value;
    }
    return edit.value;
  }

  Future<void> submitForm(BuildContext context) async {
    if (isSecurityTradeInvestment) {
      await _submitSecurityTrade(context);
      return;
    }

    if ((transactionType.isIncomeOrExpense && selectedCategory == null) ||
        (transactionType.isTransfer && transferAccount == null)) {
      shakeKey.currentState?.shake();
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

    final accountForDateCheck = transactionType.isTransfer
        ? effectiveTransferFromAccount
        : fromAccount;
    if (accountForDateCheck != null &&
        accountForDateCheck.date.compareTo(date) > 0) {
      MonekinSnackbar.warning(
        SnackbarParams(
          t.transaction.form.validators.date_after_account_creation,
        ),
      );
      return;
    }

    final newTrID = _transactionToEdit?.id ?? generateUUID();

    final double signedValue;
    if (transactionType == TransactionType.expense) {
      signedValue = transactionValue * -1;
    } else {
      signedValue = transactionValue;
    }

    final titleTrim = titleController.text.trim();
    final String? resolvedTitle = titleTrim.isEmpty ? null : titleTrim;

    final postingFrom = transactionType.isTransfer
        ? effectiveTransferFromAccount
        : fromAccount;

    // Without it the balance would credit the origin amount unconverted
    double? valueInDestiny = valueInDestinyToNumber;
    final transferTo = effectiveTransferToAccount;

    if (transactionType.isTransfer &&
        valueInDestiny == null &&
        transferTo != null &&
        transferTo.currency.code != postingFrom!.currency.code) {
      valueInDestiny = (transactionValue.abs() * await transferRate.first)
          .roundWithDecimals(transferTo.currency.decimalPlaces);
    }

    final transactionToPost = TransactionInDB(
      id: newTrID,
      date: date,
      type: transactionType,
      accountID: postingFrom!.id,
      value: signedValue,
      isHidden: false,
      status: recurrentRule.isNoRecurrent && date.compareTo(DateTime.now()) > 0
          ? TransactionStatus.pending
          : status,
      notes: notesController.text.isEmpty ? null : notesController.text,
      title: resolvedTitle,
      intervalEach: recurrentRule.intervalEach,
      intervalPeriod: recurrentRule.intervalPeriod,
      endDate: recurrentRule.ruleRecurrentLimit?.endDate,
      remainingTransactions:
          recurrentRule.ruleRecurrentLimit?.remainingIterations,
      installments: canPayInInstallments ? installments : null,
      valueInDestiny: transactionType.isTransfer ? valueInDestiny : null,
      categoryID: transactionType.isIncomeOrExpense
          ? selectedCategory?.id
          : null,
      debtId: _linkedDebt?.id,
      receivingAccountID: transactionType.isTransfer
          ? effectiveTransferToAccount?.id
          : null,
      assetID: _transactionToEdit?.assetID,
    );

    Future<int> postCall = TransactionService.instance.updateTransaction(
      transactionToPost,
    );

    if (!isEditMode) {
      postCall = TransactionService.instance.insertTransaction(
        transactionToPost,
      );
    }

    await postCall
        .then((value) async {
          final db = AppDB.instance;
          final existingTags = _transactionToEdit?.tags ?? [];
          final tagsToRemove = existingTags
              .where(
                (existingTag) =>
                    !tags.any((newTag) => newTag.id == existingTag.id),
              )
              .toList();
          final tagsToAdd = tags
              .where(
                (newTag) => !existingTags.any(
                  (existingTag) => existingTag.id == newTag.id,
                ),
              )
              .toList();

          try {
            for (final tag in tagsToRemove) {
              await (db.delete(db.transactionTags)..where(
                    (tbl) =>
                        tbl.tagID.isValue(tag.id) &
                        tbl.transactionID.isValue(newTrID),
                  ))
                  .go();
            }

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
            if (context.mounted) RouteUtils.popRoute();
            MonekinSnackbar.error(SnackbarParams.fromError(error));
          }
        })
        .catchError((error) {
          MonekinSnackbar.error(SnackbarParams.fromError(error));
        });
  }

  Future<void> _submitSecurityTrade(BuildContext context) async {
    final t = Translations.of(context);
    final account = fromAccount;
    final security = _security;

    if (security == null) {
      shakeKey.currentState?.shake();
      return;
    }

    if (account == null) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.general.validations.form_error),
      );
      return;
    }

    final qty = securityTradeQuantity;
    final price = securityTradePricePerUnit;
    final cash = securityTradeCashAmount;

    if (qty <= 0 || price <= 0 || cash <= 0) {
      MonekinSnackbar.warning(
        SnackbarParams(t.transaction.form.validators.zero),
      );
      return;
    }

    if (account.date.compareTo(date) > 0) {
      MonekinSnackbar.warning(
        SnackbarParams(
          t.transaction.form.validators.date_after_account_creation,
        ),
      );
      return;
    }

    if (!securityTradeIsBuy) await _heldQuantityLoad;
    if (_disposed) return;

    final available = securityTradeAvailableUnits;
    if (!securityTradeIsBuy && available != null && qty > available + 1e-7) {
      MonekinSnackbar.warning(
        SnackbarParams(t.assets.holdings.not_enough_units),
      );
      return;
    }

    final id = _transactionToEdit?.id ?? generateUUID();
    final signedQty = securityTradeIsBuy ? qty : -qty;
    final signedCash = securityTradeIsBuy ? -cash : cash;

    final titleTrim = titleController.text.trim();
    final resolvedTitle = titleTrim.isEmpty
        ? (securityTradeIsBuy ? t.assets.holdings.buy : t.assets.holdings.sell)
        : titleTrim;

    final tx = TransactionInDB(
      id: id,
      date: date,
      type: TransactionType.investment,
      accountID: account.id,
      value: signedCash,
      isHidden: false,
      status: recurrentRule.isNoRecurrent && date.compareTo(DateTime.now()) > 0
          ? TransactionStatus.pending
          : status,
      notes: notesController.text.isEmpty ? null : notesController.text,
      title: resolvedTitle,
      intervalEach: recurrentRule.intervalEach,
      intervalPeriod: recurrentRule.intervalPeriod,
      endDate: recurrentRule.ruleRecurrentLimit?.endDate,
      remainingTransactions:
          recurrentRule.ruleRecurrentLimit?.remainingIterations,
      securityID: security.id,
      quantity: signedQty,
      pricePerUnit: price,
    );

    try {
      if (isEditMode) {
        await TransactionService.instance.updateTransaction(tx);
      } else {
        await TransactionService.instance.insertTransaction(tx);
      }
      await HoldingService.instance.recomputeHolding(
        accountId: account.id,
        securityId: security.id,
      );
      await _syncTagsFor(tx);

      DefaultTransactionValuesService.lastCreatedTransaction.value = (
        transaction: tx,
        tagIds: tags.map((tag) => tag.id).toList(),
      );

      RouteUtils.popRoute();
      MonekinSnackbar.success(
        SnackbarParams(
          isEditMode ? t.transaction.edit_success : t.transaction.new_success,
        ),
      );
    } catch (error) {
      MonekinSnackbar.error(SnackbarParams.fromError(error));
    }
  }

  Future<void> _syncTagsFor(TransactionInDB tx) async {
    final db = AppDB.instance;
    final newTrID = tx.id;
    final existingTags = _transactionToEdit?.tags ?? [];

    final tagsToRemove = existingTags
        .where(
          (existingTag) => !tags.any((newTag) => newTag.id == existingTag.id),
        )
        .toList();
    final tagsToAdd = tags
        .where(
          (newTag) =>
              !existingTags.any((existingTag) => existingTag.id == newTag.id),
        )
        .toList();

    for (final tag in tagsToRemove) {
      await (db.delete(db.transactionTags)..where(
            (tbl) =>
                tbl.tagID.isValue(tag.id) & tbl.transactionID.isValue(newTrID),
          ))
          .go();
    }

    await TagService.instance.linkTagsToTransaction(
      transactionId: newTrID,
      tagIds: tagsToAdd.map((tag) => tag.id).toList(),
    );
  }

  Color tradeAccent(BuildContext context) => securityTradeIsBuy
      ? TransactionType.income.color(context)
      : TransactionType.expense.color(context);

  Future<List<Account>?> showAccountSelector(
    BuildContext context,
    Account? account,
  ) {
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

  Future<void> selectCategory(BuildContext context) async {
    final modalRes = await showCategoryPickerModal(
      context,
      modal: CategoryPicker(
        selectedCategory: selectedCategory,
        categoryType: transactionType == TransactionType.expense
            ? [CategoryType.E, CategoryType.B]
            : [CategoryType.I, CategoryType.B],
      ),
    );

    if (modalRes != null) {
      selectedCategory = modalRes;
      _safeNotify();
    }
  }

  void _fillForm(MoneyTransaction transaction) {
    fromAccount = transaction.account;
    transferAccount = transaction.receivingAccount;
    date = transaction.date;
    status = transaction.status;
    selectedCategory = transaction.category;
    recurrentRule = transaction.recurrentInfo;
    installments = transaction.installments;
    installmentsController.text = installments?.toString() ?? '';
    tags = [...transaction.tags];

    notesController.text = transaction.notes ?? '';
    titleController.text = transaction.title ?? '';
    transactionValue = transaction.value;
    transactionType = transaction.type;

    if (transactionType == TransactionType.investment) {
      transactionValue = transaction.value.abs();
    } else if (transactionType == TransactionType.expense) {
      transactionValue = transactionValue * -1;
    }

    valueInDestinyController.text =
        transaction.valueInDestiny?.abs().toString() ?? '';
    _customTransferAmounts = transaction.valueInDestiny != null;

    syncAmountFieldFromTransactionValue();
  }

  Color foregroundColor(BuildContext context) =>
      transactionType.color(context).getContrastColor();

  String resolveFrameworkTitle(Translations t) {
    if (isEditMode) {
      return t.transaction.edit;
    }
    if (isSecurityTradeInvestment) {
      final name = _security?.name;
      if (name == null) {
        return securityTradeIsBuy
            ? t.assets.holdings.buy
            : t.assets.holdings.sell;
      }
      return securityTradeIsBuy
          ? t.assets.holdings.buy_title(security: name)
          : t.assets.holdings.sell_title(security: name);
    }
    return t.transaction.create;
  }

  Future<void> openTagPicker(BuildContext context) async {
    final value = await showTagListModal(
      context,
      modal: TagSelector(
        selectedTags: tags,
        allowEmptySubmit: true,
        includeNullTag: false,
      ),
    );
    if (value == null || _disposed) return;
    tags = value.selectedTags.nonNulls.toList();
    _safeNotify();
  }

  void removeTag(Tag tag) {
    tags = [...tags]..removeWhere((e) => e.id == tag.id);
    _safeNotify();
  }

  void setDate(DateTime v) {
    date = v;
    _safeNotify();
    if (_security != null) unawaited(_loadTradeCurrencyAndRate());
  }

  void setStatus(TransactionStatus? v) {
    status = v;
    _safeNotify();
  }

  void setRecurrency(RecurrencyData v) {
    recurrentRule = v;
    _safeNotify();
  }

  /// Fewer than 2 installments (or an empty field) means paying at once.
  void _onInstallmentsTextChanged() {
    final n = int.tryParse(installmentsController.text);
    final value = n != null && n >= 2 ? n : null;
    if (value == installments) return;

    installments = value;
    _safeNotify();
  }

  void setFromAccount(Account? a) {
    fromAccount = a;
    _safeNotify();
  }

  void setTransferAccount(Account? a) {
    transferAccount = a;
    _safeNotify();
  }

  Future<void> pickFromAccount(BuildContext context) async {
    final modalRes = await showAccountSelector(context, fromAccount);
    if (modalRes != null && modalRes.isNotEmpty) {
      setFromAccount(modalRes.first);
    }
  }

  Future<void> pickTransferAccount(BuildContext context) async {
    final modalRes = await showAccountSelector(context, transferAccount);
    if (modalRes != null && modalRes.isNotEmpty) {
      setTransferAccount(modalRes.first);
    }
  }

  void onTitleFieldSubmitted(BuildContext context, String _) {
    notesFocusNode.requestFocus();
  }

  void onNotesFieldSubmitted(BuildContext context, String _) {
    FocusScope.of(context).unfocus();
  }

  void applyAmountFromSelector(double amount) {
    transactionValue = amount;
    syncAmountFieldFromTransactionValue();
    _safeNotify();
  }

  static bool nearlyEqualMoney(double a, double b) => (a - b).abs() < 0.005;

  /// Plain positive amount string for [valueInDestinyController].
  String formatMoneyAmountPlain(double v) {
    final rounded = double.parse(v.abs().toStringAsFixed(2));
    final isInt = rounded == rounded.roundToDouble();
    return isInt ? rounded.toInt().toString() : rounded.toString();
  }

  void applyTransferSourceAmount(double amount) {
    transactionValue = amount.abs();
    syncAmountFieldFromTransactionValue();
    _safeNotify();
  }

  /// Sets an explicit destination amount, or clears the override when it
  /// matches [defaultDestinationAmount] (same currency or converted default).
  void applyTransferDestinationAmount(
    double amount, {
    required double defaultDestinationAmount,
  }) {
    final a = amount.abs();
    if (nearlyEqualMoney(a, defaultDestinationAmount)) {
      valueInDestinyController.clear();
    } else {
      valueInDestinyController.text = formatMoneyAmountPlain(a);
    }
    _safeNotify();
  }

  void clearTransferDestinationOverride() {
    if (valueInDestinyController.text.isEmpty) return;
    valueInDestinyController.clear();
    _safeNotify();
  }

  /// Turning it off re-links the destination to the source amount.
  void setCustomTransferAmounts(bool v) {
    if (_customTransferAmounts == v) return;
    _customTransferAmounts = v;
    if (!v) valueInDestinyController.clear();
    _safeNotify();
  }

  /// Linked mode: sets the destination amount by deriving the source from [rate].
  void applyTransferDestinationLinked(double amount, {required double rate}) {
    final decimals = effectiveTransferFromAccount?.currency.decimalPlaces ?? 2;
    final source = rate > 0 ? amount.abs() / rate : amount.abs();
    transactionValue = double.parse(source.toStringAsFixed(decimals));
    syncAmountFieldFromTransactionValue();
    valueInDestinyController.clear();
    _safeNotify();
  }

  /// Sets the source debit to [inverseConvertedSource] (already in the origin
  /// account currency) and clears an explicit destiny amount so the pair is
  /// consistent again.
  void alignTransferSourceFromInverseConverted(double inverseConvertedSource) {
    transactionValue = inverseConvertedSource.abs();
    syncAmountFieldFromTransactionValue();
    valueInDestinyController.clear();
    _safeNotify();
  }

  void openTransferSourceAmountSelector(BuildContext context) {
    final tr = Translations.of(context);
    RouteUtils.showResponsiveModal<void>(
      (dualLegTopIsOutflow ? dualLegTopCardKey : dualLegBottomCardKey)
              .currentContext ??
          context,
      builder: (ctx) => AmountSelector(
        title: tr.transaction.form.value,
        initialAmount: transactionValue.abs(),
        enableSignToggleButton: false,
        currency: effectiveTransferFromAccount?.currency,
        onSubmit: (amount) {
          applyTransferSourceAmount(amount);
          RouteUtils.popRoute();
        },
      ),
    );
  }

  /// When [linkedRate] is set the entered amount drives the source leg
  /// instead of overriding the destination.
  void openTransferDestinationAmountSelector(
    BuildContext context, {
    required double defaultDestinationAmount,
    double? linkedRate,
  }) {
    final tr = Translations.of(context);
    final initial = valueInDestinyToNumber ?? defaultDestinationAmount;
    RouteUtils.showResponsiveModal<void>(
      (dualLegTopIsOutflow ? dualLegBottomCardKey : dualLegTopCardKey)
              .currentContext ??
          context,
      builder: (ctx) => AmountSelector(
        title: tr.transfer.form.value_in_destiny.title,
        initialAmount: initial,
        enableSignToggleButton: false,
        currency: effectiveTransferToAccount?.currency,
        onSubmit: (amount) {
          if (linkedRate != null) {
            applyTransferDestinationLinked(amount, rate: linkedRate);
          } else {
            applyTransferDestinationAmount(
              amount,
              defaultDestinationAmount: defaultDestinationAmount,
            );
          }
          RouteUtils.popRoute();
        },
      ),
    );
  }

  void openDualLegTopAmountSelector(
    BuildContext context, {
    double defaultDestinationAmount = 0,
  }) {
    if (dualLegTopIsOutflow) {
      openTransferSourceAmountSelector(context);
    } else {
      openTransferDestinationAmountSelector(
        context,
        defaultDestinationAmount: defaultDestinationAmount,
      );
    }
  }

  Future<void> onSavePressed(BuildContext context) async {
    if (isSubmitting) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isSubmitting = true;
      notifyListeners();
      try {
        await submitForm(context);
      } finally {
        isSubmitting = false;
        if (!_disposed) notifyListeners();
      }
    } else {
      MonekinSnackbar.error(
        SnackbarParams(Translations.of(context).general.validations.form_error),
      );
    }
  }

  void openAmountSelectorSheet(BuildContext context) {
    final tr = Translations.of(context);
    RouteUtils.showResponsiveModal<void>(
      context,
      builder: (ctx) => AmountSelector(
        title: tr.transaction.form.value,
        initialAmount: transactionValue,
        enableSignToggleButton: transactionType.isIncomeOrExpense,
        currency: fromAccount?.currency,
        onSubmit: (amount) {
          applyAmountFromSelector(amount);
          RouteUtils.popRoute();
        },
      ),
    );
  }
}

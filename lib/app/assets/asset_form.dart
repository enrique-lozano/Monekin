import 'package:collection/collection.dart';
import 'package:drift/drift.dart' show BaseAggregate;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/widgets/balance_currency_form_field.dart';
import 'package:monekin/app/assets/widgets/asset_type_selector.dart';
import 'package:monekin/app/debts/components/transaction_selector.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/database/services/account/asset_valuation_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/asset/asset_type.enum.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/list_tile_field.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum _AcquisitionValueMode { manual, transaction }

class AssetFormPage extends StatefulWidget {
  const AssetFormPage({super.key, this.asset, this.initialAssetType});

  /// Asset UUID to edit (if any)
  final Asset? asset;

  /// Pre-selected asset type (chosen in the add-asset type selector). When set
  /// and creating, the type dropdown is hidden.
  final AssetType? initialAssetType;

  @override
  State<AssetFormPage> createState() => _AssetFormPageState();
}

class _AssetFormPageState extends State<AssetFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  /// Optional purchase value. Empty means unspecified; when filled it is stored
  /// as a valuation on the acquisition date, not in the legacy `initialValue`.
  final TextEditingController _purchaseValueController =
      TextEditingController();

  final TextEditingController _currentValueController = TextEditingController();

  /// Existing purchase valuation row (acquisition day), so edits update it
  /// instead of duplicating.
  String? _originalPurchaseValuationId;

  /// Latest valuation value when the edit form opened, to skip recording an
  /// unchanged "today" valuation.
  double? _latestValuationValue;

  Currency? _currency;
  DateTime _creationDate = DateTime.now();
  AssetType _assetType = AssetType.other;

  _AcquisitionValueMode _acquisitionValueMode = _AcquisitionValueMode.manual;

  /// Current step in the creation flow: 0 = choose the asset type, 1 = fill the
  /// form. Only relevant when [_hasTypeStep] is true.
  int _step = 1;

  final PageController _pageController = PageController();

  /// Type highlighted in the type-selection step, before confirming it.
  AssetType? _pendingType;

  /// Existing liability (debt) linked to this asset, if any.
  String? _linkedDebtId;

  /// Expense chosen as the asset's purchase, linked on submit.
  MoneyTransaction? _acquisitionTransaction;

  /// Acquisition transaction already linked when the edit form opened, to know
  /// whether to unlink it on submit.
  MoneyTransaction? _originalAcquisitionTransaction;

  late final Asset? _assetToEdit;

  /// When creating without a pre-selected type, the form shows an initial
  /// type-selection step so both steps live in the same place.
  bool get _hasTypeStep =>
      _assetToEdit == null && widget.initialAssetType == null;

  /// The type dropdown is hidden whenever the type is chosen elsewhere (a
  /// pre-selected type or the type-selection step).
  bool get _isTypeLocked => _assetToEdit == null;

  /// The acquisition transaction must be dated on or before the asset's
  /// creation date (see [AssetValuationService.isAcquisitionTransaction]).
  bool get _creationDateBeforeAcquisitionTransaction {
    final tx = _acquisitionTransaction;
    if (tx == null) return false;
    return DateUtils.dateOnly(
      _creationDate,
    ).isBefore(DateUtils.dateOnly(tx.date));
  }

  bool get _creationDateInvalid => _creationDateBeforeAcquisitionTransaction;

  String _dateFieldLabel(Translations t) => t.assets.form.acquisition_date;

  Widget _buildLiabilitySection(Translations t) {
    if (_linkedDebtId != null) {
      return StreamBuilder<Debt?>(
        stream: DebtService.instance.getDebtById(_linkedDebtId!),
        builder: (context, snap) {
          return Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Icon(DebtDirection.borrowed.icon()),
              title: Text(t.assets.form.linked_liability),
              subtitle: Text(snap.data?.name ?? '...'),
              trailing: IconButton(
                icon: const Icon(Icons.link_off),
                onPressed: () => setState(() => _linkedDebtId = null),
              ),
            ),
          );
        },
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.link_rounded),
        title: Text(t.assets.form.link_existing_liability),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        onTap: _pickExistingDebt,
      ),
    );
  }

  /// Left-aligned subtitle that introduces a group of related fields.
  Widget _sectionTitle(String title) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Mandatory current value; also carries the currency selector.
  Widget _buildCurrentValueField(Translations t) {
    return AmountAndCurrencyFormField(
      amountController: _currentValueController,
      currency: _currency,
      amountLabel: t.assets.form.current_value,
      enabled: true,
      onCurrencySelected: (newCurrency) {
        setState(() {
          _currency = newCurrency;
        });
      },
    );
  }

  Widget _buildAcquisitionSection(Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(t.assets.form.acquisition_info),
        const SizedBox(height: 8),
        // When creating, the date lives inside the manual option (with a linked
        // transaction it's derived from the transaction). When editing there's
        // no switch, so it's shown right after the value.
        if (_assetToEdit == null)
          _buildAcquisitionValueSelector(t)
        else ...[
          _buildPurchaseValueField(t),
          const SizedBox(height: 16),
          _buildAcquisitionDateField(t),
        ],
      ],
    );
  }

  Widget _buildAcquisitionValueSelector(Translations t) {
    return RadioGroup<_AcquisitionValueMode>(
      groupValue: _acquisitionValueMode,
      onChanged: (mode) {
        if (mode == null) return;
        setState(() {
          _acquisitionValueMode = mode;
          if (mode == _AcquisitionValueMode.manual) {
            _acquisitionTransaction = null;
          } else {
            _purchaseValueController.clear();
          }
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile<_AcquisitionValueMode>.adaptive(
            value: _AcquisitionValueMode.manual,
            title: Text(t.assets.form.purchase_value_option),
            contentPadding: EdgeInsets.zero,
          ),
          AnimatedExpanded(
            expand: _acquisitionValueMode == _AcquisitionValueMode.manual,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildManualPurchaseField(t),
                  const SizedBox(height: 16),
                  _buildAcquisitionDateField(t),
                ],
              ),
            ),
          ),
          RadioListTile<_AcquisitionValueMode>.adaptive(
            value: _AcquisitionValueMode.transaction,
            title: Text(t.assets.form.link_acquisition_transaction),
            contentPadding: EdgeInsets.zero,
          ),
          AnimatedExpanded(
            expand: _acquisitionValueMode == _AcquisitionValueMode.transaction,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildTransactionPicker(t),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseValueField(Translations t) {
    if (_acquisitionTransaction != null) {
      return _buildLinkedTransactionCard(t);
    }
    return _buildManualPurchaseField(t);
  }

  Widget _buildTransactionPicker(Translations t) {
    if (_acquisitionTransaction == null) {
      return Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: const Icon(Icons.receipt_long_rounded),
          title: Text(t.transaction.select),
          subtitle: Text(t.assets.form.link_acquisition_transaction_descr),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
          onTap: _pickAcquisitionTransaction,
        ),
      );
    }
    return _buildLinkedTransactionCard(t);
  }

  Widget _buildLinkedTransactionCard(Translations t) {
    final tx = _acquisitionTransaction!;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.receipt_long_rounded),
        title: Text(t.assets.form.acquisition_transaction),
        subtitle: Text(
          '${tx.displayName(context)} · ${getMMMdDateFormatBasedOnYear(tx.date).text}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.link_off),
          onPressed: () => setState(() => _acquisitionTransaction = null),
        ),
      ),
    );
  }

  Widget _buildManualPurchaseField(Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _purchaseValueController,
          decoration: InputDecoration(
            labelText: t.assets.form.purchase_value,
            hintText: 'Ex.: 200',
            suffixText: _currency?.symbol,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: decimalDigitFormatter(_currency?.decimalPlaces ?? 2),
          validator: (value) => fieldValidator(
            value,
            validator: ValidatorType.double,
            isRequired: false,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _purchaseValueController,
          builder: (context, value, child) => AnimatedExpanded(
            expand: value.text.trim().isEmpty,
            child: InlineInfoCard(
              margin: const EdgeInsets.only(top: 12),
              text: t.assets.form.purchase_value_help,
              mode: InlineInfoCardMode.info,
            ),
          ),
        ),
      ],
    );
  }

  /// Mandatory acquisition date. While a transaction is linked, its date
  /// defines the acquisition date, so the field is locked to it.
  Widget _buildAcquisitionDateField(Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateTimeFormField(
          key: ValueKey(_creationDate),
          enabled: _acquisitionTransaction == null,
          decoration: InputDecoration(
            suffixIcon: Icon(
              _acquisitionTransaction != null
                  ? Icons.lock_outline_rounded
                  : Icons.event,
            ),
            labelText: '${_dateFieldLabel(t)} *',
          ),
          initialDate: _creationDate,
          lastDate: DateTime.now(),
          dateFormat: DateFormat.yMMMd().add_jm(),
          validator: (e) {
            if (e == null) return t.general.validations.required;
            if (_creationDateBeforeAcquisitionTransaction) {
              return t.assets.form.creation_date_before_acquisition_transaction;
            }
            return null;
          },
          onDateSelected: (DateTime value) {
            setState(() {
              _creationDate = value;
            });
          },
        ),
        if (_acquisitionTransaction != null)
          InlineInfoCard(
            margin: const EdgeInsets.only(top: 12),
            text: t.assets.form.acquisition_date_from_transaction,
            mode: InlineInfoCardMode.info,
          )
        else if (_creationDateBeforeAcquisitionTransaction)
          InlineInfoCard(
            margin: const EdgeInsets.only(top: 12),
            text: t.assets.form.creation_date_before_acquisition_transaction,
            mode: InlineInfoCardMode.warn,
          ),
      ],
    );
  }

  Widget _buildDetailsSection(Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(t.general.details),
        const SizedBox(height: 12),
        if (!_isTypeLocked) ...[
          // The Builder gives the selector a context whose render box is this
          // field, so the popover highlight/arrow anchors to the field itself
          // and not the whole drawer.
          Builder(
            builder: (fieldContext) => ListTileField(
              leading: Icon(_assetType.icon(), color: _assetType.color()),
              title: t.assets.form.asset_type,
              subtitle: _assetType.displayName(context),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final selected = await showAssetTypeSelector(
                  fieldContext,
                  selectedType: _assetType,
                );
                if (selected != null) {
                  setState(() => _assetType = selected);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
        ],

        _buildLiabilitySection(t),
        const SizedBox(height: 16),

        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: t.assets.form.description),
          maxLines: 2,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  /// Picks an expense as the purchase; linked on submit, left untouched here.
  Future<void> _pickAcquisitionTransaction() async {
    final t = Translations.of(context);

    showTransactionSelectorModal(
      context,
      subtitle: t.assets.form.link_acquisition_transaction_descr,
      initialFilters: const TransactionFilterSet(
        transactionTypes: [TransactionType.expense],
        assetIds: [],
      ),
      onTransactionSelected: (transaction) async {
        final convertedAmount = await _convertToAssetCurrency(
          transaction,
          _currency?.code,
        );

        if (!mounted) return;

        setState(() {
          _acquisitionTransaction = transaction;
          _purchaseValueController.text = convertedAmount.toStringAsFixed(2);
          _creationDate = transaction.date;
        });
      },
    );
  }

  /// Converts a transaction's absolute amount into [targetCurrencyCode] at its
  /// date. Returns the raw absolute amount when no conversion is needed (same
  /// currency or the target is not yet known).
  Future<double> _convertToAssetCurrency(
    MoneyTransaction transaction,
    String? targetCurrencyCode,
  ) async {
    final amountAbs = transaction.value.abs();

    if (targetCurrencyCode == null ||
        transaction.account.currency.code == targetCurrencyCode) {
      return amountAbs;
    }

    return ExchangeRateService.instance
        .calculateExchangeRate(
          fromCurrency: transaction.account.currency.code,
          toCurrency: targetCurrencyCode,
          amount: amountAbs,
          date: transaction.date,
        )
        .first;
  }

  Future<void> _pickExistingDebt() async {
    final t = Translations.of(context);

    final selected = await showModalBottomSheet<Debt>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => ModalContainer(
        title: t.assets.form.link_existing_liability,
        body: StreamBuilder<List<Debt>>(
          stream: DebtService.instance.getDebts(),
          builder: (context, snapshot) {
            final debts = (snapshot.data ?? [])
                .where((d) => d.type == DebtDirection.borrowed)
                .toList();

            if (debts.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  t.assets.form.no_liabilities,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView(
              shrinkWrap: true,
              children: debts
                  .map(
                    (d) => ListTile(
                      leading: Icon(DebtDirection.borrowed.icon()),
                      title: Text(d.name),
                      onTap: () => RouteUtils.popRoute(d),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        _linkedDebtId = selected.id;
      });
    }
  }

  Future<void> submitForm() async {
    final t = Translations.of(context);

    if (_creationDateBeforeAcquisitionTransaction) {
      MonekinSnackbar.warning(
        SnackbarParams(
          t.assets.form.creation_date_before_acquisition_transaction,
        ),
      );
      return;
    }

    if (_currency == null) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.assets.form.select_currency),
      );
      return;
    }

    final assetService = AssetService.instance;

    // Check if there are valuations before the creation date of the asset:
    if (_assetToEdit != null) {
      if ((await AssetValuationService.instance
              .getValuationsForAsset(_assetToEdit.id)
              .first)
          .where((v) => v.date.isBefore(_creationDate))
          .isNotEmpty) {
        MonekinSnackbar.warning(
          SnackbarParams(t.assets.form.valuation_before_creation_date),
        );
        return;
      }
    }

    // Legacy column: the purchase value is stored as a valuation instead.
    final AssetInDB assetToSubmit = AssetInDB(
      id: _assetToEdit?.id ?? generateUUID(),
      name: _nameController.text,
      initialValue: 0,
      currencyId: _currency!.code,
      creationDate: _creationDate,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      assetType: _assetType,
      linkedDebtId: _linkedDebtId,
    );

    // Check for assets with same names before continue:
    if (_assetToEdit == null || _assetToEdit.name != assetToSubmit.name) {
      final db = AppDB.instance;
      final query = db.select(db.assets)
        ..addColumns([db.assets.id.count()])
        ..where((tbl) => tbl.name.isValue(_nameController.text));

      if (await query.watchSingleOrNull().first != null) {
        MonekinSnackbar.error(
          SnackbarParams.fromError(
            t.assets.form.already_exists,
            duration: const Duration(seconds: 6),
          ),
        );

        return;
      }
    }

    if (_assetToEdit != null) {
      await assetService.updateAsset(assetToSubmit);
      //MonekinSnackbar.success(SnackbarParams(t.assets.form.edit_success));
    } else {
      await assetService.insertAsset(assetToSubmit);
      //  MonekinSnackbar.success(SnackbarParams(t.assets.form.create_success));
    }

    if (_acquisitionTransaction != null) {
      await assetService.linkTransactionToAsset(
        transactionId: _acquisitionTransaction!.id,
        assetId: assetToSubmit.id,
      );
    } else if (_originalAcquisitionTransaction != null) {
      await assetService.unlinkTransactionFromAsset(
        _originalAcquisitionTransaction!.id,
      );
    }

    await _persistValuations(assetToSubmit.id);

    RouteUtils.popRoute();
  }

  /// Stores the manual purchase value as a valuation on the acquisition date
  /// (only when no transaction defines it) and the current value as one dated
  /// today (skipped on edit when unchanged).
  Future<void> _persistValuations(String assetId) async {
    final valuationService = AssetValuationService.instance;

    if (_acquisitionTransaction == null) {
      final purchaseText = _purchaseValueController.text.trim();
      final purchaseValue = purchaseText.isEmpty
          ? null
          : double.tryParse(purchaseText);

      if (purchaseValue != null) {
        await valuationService.insertOrUpdateValuation(
          AssetValuationInDB(
            id: _originalPurchaseValuationId ?? generateUUID(),
            assetId: assetId,
            date: _creationDate,
            value: purchaseValue,
          ),
        );
      } else if (_originalPurchaseValuationId != null) {
        await valuationService.deleteValuation(_originalPurchaseValuationId!);
      }
    }

    final currentText = _currentValueController.text.trim();
    final currentValue = currentText.isEmpty
        ? null
        : double.tryParse(currentText);

    if (currentValue != null &&
        (_assetToEdit == null || currentValue != _latestValuationValue)) {
      await valuationService.insertOrUpdateValuation(
        AssetValuationInDB(
          id: generateUUID(),
          assetId: assetId,
          date: DateTime.now(),
          value: currentValue,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _assetToEdit = widget.asset;

    if (widget.initialAssetType != null) {
      _assetType = widget.initialAssetType!;
    }

    _step = _hasTypeStep ? 0 : 1;

    if (_assetToEdit != null) {
      _fillForm();
    }

    CurrencyService.instance.ensureAndGetPreferredCurrency().first.then((
      value,
    ) {
      setState(() {
        if (widget.asset == null) {
          _currency = value;
        }
      });
    });
  }

  void _fillForm() {
    if (_assetToEdit == null) return;

    _nameController.text = _assetToEdit.name;
    _descriptionController.text = _assetToEdit.description ?? '';
    _creationDate = _assetToEdit.creationDate;
    _assetType = _assetToEdit.assetType;
    _linkedDebtId = _assetToEdit.linkedDebtId;

    CurrencyService.instance
        .getCurrencyByCode(_assetToEdit.currency.code)
        .first
        .then((value) {
          setState(() {
            _currency = value;
          });
        });

    _loadLinkedAcquisitionTransaction(_assetToEdit);
    _loadValuations(_assetToEdit);
  }

  /// Prefills the purchase value (from the acquisition-day valuation or legacy
  /// `initialValue`) and the current value (from the latest valuation).
  Future<void> _loadValuations(Asset asset) async {
    final valuations = await AssetValuationService.instance
        .getValuationsForAsset(asset.id)
        .first;

    final purchaseValuation = valuations.firstWhereOrNull(
      (v) => DateUtils.isSameDay(v.date, asset.creationDate),
    );

    final latestValuation = valuations.isEmpty
        ? null
        : valuations.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

    if (!mounted) return;

    setState(() {
      if (purchaseValuation != null) {
        _originalPurchaseValuationId = purchaseValuation.id;
        _purchaseValueController.text = purchaseValuation.value.toStringAsFixed(
          2,
        );
      } else if (asset.initialValue != 0) {
        _purchaseValueController.text = asset.initialValue.toStringAsFixed(2);
      }

      if (latestValuation != null) {
        _latestValuationValue = latestValuation.value;
        _currentValueController.text = latestValuation.value.toStringAsFixed(2);
      } else if (asset.initialValue != 0) {
        // Legacy asset without valuations: seed so the field isn't blank.
        _currentValueController.text = asset.initialValue.toStringAsFixed(2);
      }
    });
  }

  /// Surfaces the transaction already linked as the asset's acquisition, if any.
  Future<void> _loadLinkedAcquisitionTransaction(Asset asset) async {
    final linkedTransactions = await TransactionService.instance
        .getTransactions(filters: TransactionFilterSet(assetIds: [asset.id]))
        .first;

    final acquisitionTransaction = linkedTransactions.firstWhereOrNull(
      (tx) => AssetValuationService.isAcquisitionTransaction(tx, asset),
    );

    if (acquisitionTransaction == null || !mounted) return;

    final convertedAmount = await _convertToAssetCurrency(
      acquisitionTransaction,
      asset.currency.code,
    );

    if (!mounted) return;

    setState(() {
      _acquisitionTransaction = acquisitionTransaction;
      _originalAcquisitionTransaction = acquisitionTransaction;
      _purchaseValueController.text = convertedAmount.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _purchaseValueController.dispose();
    _currentValueController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  void _goToStep(int step) {
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  Widget _stepIndicator(int activeIndex) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Center(
        child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: 2,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            spacing: 4,
            expansionFactor: 3,
            radius: 3,
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotColor: Theme.of(context).colorScheme.primary.withAlpha(60),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeStepBody(Translations t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.assets.add.subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              AssetTypeGrid(
                selectedType: _pendingType,
                onSelected: (type) => setState(() => _pendingType = type),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(Translations t, String pageTitle) {
    final isTypeStep = _hasTypeStep && _step == 0;
    final creationDateInvalid = _creationDateInvalid;

    // Offset the whole footer (not just the primary button) above the keyboard,
    // so the back button rises with it instead of being hidden behind it.
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: [
          if (_hasTypeStep)
            AnimatedExpanded(
              axis: Axis.horizontal,
              expand: _step == 1,
              child: Padding(
                // Same inset as the [PersistentFooterButton] next to it, so
                // both buttons share their margins.
                padding: const EdgeInsets.all(4),
                child: IconButton.outlined(
                  onPressed: () => _goToStep(0),
                  icon: const Icon(Icons.arrow_back_rounded),
                  iconSize: 20,
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(
                      Size(42, mediumButtonStyleHeight),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          defaultButtonBorderRadius,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: PersistentFooterButton(
              moveWithKeyboard: false,
              child: isTypeStep
                  ? FilledButton.icon(
                      style: getMediumButtonStyle(context),
                      onPressed: _pendingType == null
                          ? null
                          : () {
                              setState(() => _assetType = _pendingType!);
                              _goToStep(1);
                            },
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(t.ui_actions.continue_text),
                    )
                  : FilledButton.icon(
                      style: getMediumButtonStyle(context),
                      onPressed: creationDateInvalid
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                submitForm();
                              }
                            },
                      icon: const Icon(Icons.save),
                      label: Text(pageTitle),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormBody(Translations t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '${t.assets.form.name} *',
                    hintText: _assetType.nameHint(context),
                  ),
                  validator: (value) => fieldValidator(value, isRequired: true),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                _buildCurrentValueField(t),

                // Dividers keep the acquisition group visually separate.
                const Divider(height: 48),
                _buildAcquisitionSection(t),
                const Divider(height: 48),

                _buildDetailsSection(t),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final pageTitle = widget.asset != null
        ? t.assets.form.edit
        : t.assets.form.create;

    return PopScope(
      canPop: !(_hasTypeStep && _step == 1),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _goToStep(0);
      },
      child: PageFramework(
        title: pageTitle,
        // The back gesture moves between the form steps, so the close button
        // has to dismiss the page explicitly.
        onClose: RouteUtils.popRoute,
        appBarActions: _hasTypeStep ? [_stepIndicator(_step)] : null,
        persistentFooterButtons: [_buildFooter(t, pageTitle)],
        body: _hasTypeStep
            ? PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _step = index),
                children: [_buildTypeStepBody(t), _buildFormBody(t)],
              )
            : _buildFormBody(t),
      ),
    );
  }
}

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
  final TextEditingController _initialValueController = TextEditingController(
    text: '0',
  );

  Currency? _currency;
  DateTime _creationDate = DateTime.now();
  AssetType _assetType = AssetType.other;

  /// Current step in the creation flow: 0 = choose the asset type, 1 = fill the
  /// form. Only relevant when [_hasTypeStep] is true.
  int _step = 1;

  final PageController _pageController = PageController();

  /// Type highlighted in the type-selection step, before confirming it.
  AssetType? _pendingType;

  /// Existing liability (debt) linked to this asset, if any.
  String? _linkedDebtId;

  /// Existing expense transaction chosen as the asset's purchase, linked on
  /// submit instead of manually specifying an initial value. Only offered
  /// when creating (see [_buildInitialValueSection]).
  MoneyTransaction? _acquisitionTransaction;

  /// The acquisition transaction that was already linked to the asset when the
  /// edit form opened, if any. Used to know whether to unlink it in the DB when
  /// the user removes it while editing (see [submitForm]).
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

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: TextButton.icon(
        onPressed: _pickExistingDebt,
        icon: const Icon(Icons.link_rounded),
        label: Text(t.assets.form.link_existing_liability),
      ),
    );
  }

  /// Manual amount entry, or a summary of the linked acquisition transaction
  /// once one has been picked (see [_pickAcquisitionTransaction]). Linking a
  /// transaction is only offered when creating a new asset.
  Widget _buildInitialValueSection(Translations t) {
    final tx = _acquisitionTransaction;

    if (tx != null) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AmountAndCurrencyFormField(
          amountController: _initialValueController,
          currency: _currency,
          amountLabel: t.assets.form.initial_value,
          enabled: true,
          onCurrencySelected: (newCurrency) {
            setState(() {
              _currency = newCurrency;
            });
          },
        ),
        if (_assetToEdit == null) ...[
          const SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: _pickAcquisitionTransaction,
              icon: const Icon(Icons.receipt_long_rounded),
              label: Text(t.assets.form.link_acquisition_transaction),
            ),
          ),
        ],
      ],
    );
  }

  /// Lets the user pick an existing expense as the asset's purchase, instead
  /// of typing an initial value. The transaction's amount (converted to the
  /// asset's currency) becomes the initial value; the transaction itself is
  /// left untouched and only linked to the asset on submit.
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
          _initialValueController.text = convertedAmount.toStringAsFixed(2);
          if (transaction.date.isAfter(_creationDate)) {
            _creationDate = transaction.date;
          }
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

    final initialValue = double.tryParse(_initialValueController.text) ?? 0;

    final AssetInDB assetToSubmit = AssetInDB(
      id: _assetToEdit?.id ?? generateUUID(),
      name: _nameController.text,
      initialValue: initialValue,
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

    RouteUtils.popRoute();
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
    _initialValueController.text = _assetToEdit.initialValue.toString();
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
  }

  /// When editing, surfaces any transaction already linked as this asset's
  /// acquisition so the read-only summary card is shown (instead of a bare
  /// editable field) and its amount stays derived from the transaction.
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
      _initialValueController.text = convertedAmount.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _initialValueController.dispose();
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

    return Row(
      children: [
        if (_hasTypeStep)
          AnimatedExpanded(
            axis: Axis.horizontal,
            expand: _step == 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
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
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '${t.assets.form.name} *',
                  ),
                  validator: (value) => fieldValidator(value, isRequired: true),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // Initial value field (or the linked acquisition transaction)
                _buildInitialValueSection(t),
                const SizedBox(height: 16),

                if (!_isTypeLocked) ...[
                  // The Builder gives the selector a context whose render box
                  // is this field, so the popover highlight/arrow anchors to
                  // the field itself and not the whole drawer.
                  Builder(
                    builder: (fieldContext) => ListTileField(
                      leading: Icon(
                        _assetType.icon(),
                        color: _assetType.color(),
                      ),
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

                // Assets can have a linked liability (e.g. a mortgage).
                _buildLiabilitySection(t),
                const SizedBox(height: 16),

                // Description field
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: t.assets.form.description,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 16),

                DateTimeFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.event),
                    labelText: '${_dateFieldLabel(t)} *',
                  ),
                  initialDate: _creationDate,
                  lastDate: DateTime.now(),
                  dateFormat: DateFormat.yMMMd().add_jm(),
                  validator: (e) {
                    if (e == null) return t.general.validations.required;
                    if (_creationDateBeforeAcquisitionTransaction) {
                      return t
                          .assets
                          .form
                          .creation_date_before_acquisition_transaction;
                    }
                    return null;
                  },
                  onDateSelected: (DateTime value) {
                    setState(() {
                      _creationDate = value;
                    });
                  },
                ),
                if (_creationDateBeforeAcquisitionTransaction)
                  InlineInfoCard(
                    margin: const EdgeInsets.only(top: 12),
                    text: t
                        .assets
                        .form
                        .creation_date_before_acquisition_transaction,
                    mode: InlineInfoCardMode.warn,
                  ),
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

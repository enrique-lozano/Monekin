import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/app/accounts/widgets/balance_currency_form_field.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/app/securities/widgets/taxonomy_category_picker.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/taxonomy/taxonomy_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/asset/security_type.enum.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/expanding_segmented_tabs.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/market_data/market_data_provider.dart';
import 'package:monekin/core/services/market_data/market_data_service.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Opens the unified security editor (general details + classification) as a
/// full page. Returns the created/updated [SecurityInDB], or `null` when
/// dismissed. Pass [openClassification] to land on the classification tab
/// (only relevant while editing).
Future<SecurityInDB?> showSecurityFormSheet(
  BuildContext context, {
  SecurityInDB? securityToEdit,
  bool openClassification = false,
}) {
  return RouteUtils.showResponsiveForm<SecurityInDB>(
    _SecurityFormPage(
      securityToEdit: securityToEdit,
      initialTab: openClassification
          ? _FormTab.classification
          : _FormTab.general,
    ),
  );
}

enum _FormTab { general, classification }

/// A category option flattened from the taxonomy tree (used for single-select
/// chips).
typedef _CategoryOption = ({TaxonomyCategoryInDB category, int depth});

/// Per-taxonomy editing state.
class _TaxonomyEditState {
  _TaxonomyEditState({
    required this.taxonomy,
    required this.categories,
    required this.options,
  });

  final TaxonomyInDB taxonomy;
  final List<TaxonomyCategoryInDB> categories;
  final List<_CategoryOption> options;

  /// Single-select taxonomies keep one chosen category (nullable = none).
  String? singleSelected;

  /// Multi-select taxonomies keep a list of (categoryId, weight%) rows.
  final List<_WeightRow> rows = [];

  TaxonomyCategoryInDB? categoryById(String? id) {
    if (id == null) return null;
    for (final c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }
}

class _WeightRow {
  _WeightRow({this.categoryId, double weightPercent = 100}) {
    weightController = TextEditingController(text: _plainNumber(weightPercent));
  }

  String? categoryId;
  late final TextEditingController weightController;

  double get weightPercent =>
      double.tryParse(weightController.text.replaceAll(',', '.')) ?? 0;
}

String _plainNumber(double value) {
  if (value == value.roundToDouble()) return value.toInt().toString();
  return value.toString();
}

class _SecurityFormPage extends StatefulWidget {
  const _SecurityFormPage({this.securityToEdit, required this.initialTab});

  final SecurityInDB? securityToEdit;
  final _FormTab initialTab;

  @override
  State<_SecurityFormPage> createState() => _SecurityFormPageState();
}

class _SecurityFormPageState extends State<_SecurityFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final _nameController = TextEditingController(
    text: widget.securityToEdit?.name ?? '',
  );
  late final _tickerController = TextEditingController(
    text: widget.securityToEdit?.ticker ?? '',
  );
  // Only shown on creation (mandatory), so it starts empty. On edit the price
  // is managed from the price-history section and this controller is unused.
  late final _priceController = TextEditingController(
    text: widget.securityToEdit != null
        ? (widget.securityToEdit!.currentPrice ?? 0).toString()
        : '',
  );
  late final _notesController = TextEditingController(
    text: widget.securityToEdit?.notes ?? '',
  );

  late SecurityType _type = widget.securityToEdit?.type ?? SecurityType.stock;
  Currency? _currency;

  late _FormTab _tab = widget.initialTab;

  List<_TaxonomyEditState>? _taxStates;
  bool _saving = false;

  // --- Online lookup (creation only) ---
  Timer? _searchDebounce;
  List<MarketSearchResult> _onlineResults = const [];
  bool _onlineSearching = false;
  bool _onlineLoadingQuote = false;

  /// Taxonomy guesses derived from the picked online result, persisted on save.
  List<OnlineTaxonomyGuess> _pendingOnlineClassification = const [];

  bool get _isEditing => widget.securityToEdit != null;

  @override
  void initState() {
    super.initState();

    final currencyCode = widget.securityToEdit?.currencyId;
    final currencyStream = currencyCode != null
        ? CurrencyService.instance.getCurrencyByCode(currencyCode)
        : CurrencyService.instance.ensureAndGetPreferredCurrency();

    currencyStream.first.then((value) {
      if (mounted) setState(() => _currency = value);
    });

    // Classification is only editable while editing an existing security.
    if (_isEditing) _loadTaxonomies();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _nameController.dispose();
    _tickerController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    for (final s in _taxStates ?? const <_TaxonomyEditState>[]) {
      for (final r in s.rows) {
        r.weightController.dispose();
      }
    }
    super.dispose();
  }

  Future<void> _loadTaxonomies() async {
    final taxonomies = await TaxonomyService.instance.getTaxonomies().first;

    final assignments = _isEditing
        ? await TaxonomyService.instance
              .getAssignmentsForSecurity(widget.securityToEdit!.id)
              .first
        : const <SecurityTaxonomyAssignmentInDB>[];

    final states = <_TaxonomyEditState>[];

    for (final taxonomy in taxonomies) {
      final categories = await TaxonomyService.instance
          .getCategories(taxonomy.id)
          .first;

      final state = _TaxonomyEditState(
        taxonomy: taxonomy,
        categories: categories,
        options: _flatten(categories),
      );

      final own = assignments
          .where((a) => a.taxonomyID == taxonomy.id)
          .toList();

      if (taxonomy.isSingleSelect) {
        state.singleSelected = own.isEmpty ? null : own.first.categoryID;
      } else {
        for (final a in own) {
          state.rows.add(
            _WeightRow(categoryId: a.categoryID, weightPercent: a.weight / 100),
          );
        }
      }

      states.add(state);
    }

    if (mounted) setState(() => _taxStates = states);
  }

  /// Flattens the category tree (parents followed by their children).
  List<_CategoryOption> _flatten(List<TaxonomyCategoryInDB> categories) {
    final byParent = <String?, List<TaxonomyCategoryInDB>>{};
    for (final c in categories) {
      byParent.putIfAbsent(c.parentID, () => []).add(c);
    }

    final result = <_CategoryOption>[];
    void walk(String? parentId, int depth) {
      for (final c in byParent[parentId] ?? const <TaxonomyCategoryInDB>[]) {
        result.add((category: c, depth: depth));
        walk(c.id, depth + 1);
      }
    }

    walk(null, 0);
    return result;
  }

  void _onNameChanged(String value) {
    _searchDebounce?.cancel();
    final query = value.trim();

    if (query.length < 2) {
      if (_onlineResults.isNotEmpty || _onlineSearching) {
        setState(() {
          _onlineResults = const [];
          _onlineSearching = false;
        });
      }
      return;
    }

    setState(() => _onlineSearching = true);
    _searchDebounce = Timer(
      const Duration(milliseconds: 350),
      () => _runOnlineSearch(query),
    );
  }

  Future<void> _runOnlineSearch(String query) async {
    final results = await MarketDataService.instance.search(query);
    if (!mounted) return;

    // Drop stale results if the user kept typing.
    if (_nameController.text.trim() != query) return;

    setState(() {
      _onlineResults = results;
      _onlineSearching = false;
    });
  }

  Future<void> _selectOnlineResult(MarketSearchResult result) async {
    _searchDebounce?.cancel();
    FocusScope.of(context).unfocus();

    setState(() {
      _nameController.text = result.name;
      _tickerController.text = result.symbol;
      _type = MarketDataService.securityTypeFor(result.quoteType);
      _pendingOnlineClassification = MarketDataService.classificationFor(
        result,
      );
      _onlineResults = const [];
      _onlineSearching = false;
      _onlineLoadingQuote = true;
    });

    final quote = await MarketDataService.instance.getQuote(result.symbol);
    if (!mounted) return;

    if (quote?.price != null) {
      _priceController.text = quote!.price!.toString();
    }
    if (quote?.currencyCode != null) {
      final currency = await CurrencyService.instance
          .getCurrencyByCode(quote!.currencyCode!)
          .first;
      if (mounted && currency != null) {
        setState(() => _currency = currency);
      }
    }

    if (mounted) setState(() => _onlineLoadingQuote = false);
  }

  /// Persists the taxonomy guesses gathered from the online pick, skipping any
  /// category the user may have deleted from the built-in taxonomies.
  Future<void> _applyOnlineClassification(String securityId) async {
    final byTaxonomy = <String, List<String>>{};
    for (final guess in _pendingOnlineClassification) {
      byTaxonomy.putIfAbsent(guess.taxonomyId, () => []).add(guess.categoryId);
    }

    for (final entry in byTaxonomy.entries) {
      final existingIds =
          (await TaxonomyService.instance.getCategories(entry.key).first)
              .map((c) => c.id)
              .toSet();

      final valid = entry.value.where(existingIds.contains).toList();
      if (valid.isEmpty) continue;

      await TaxonomyService.instance.replaceAssignments(
        securityId: securityId,
        taxonomyId: entry.key,
        assignments: [for (final id in valid) (categoryId: id, weight: 10000)],
      );
    }
  }

  Future<void> _submit() async {
    final t = Translations.of(context);

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _tab = _FormTab.general);
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _formKey.currentState?.validate(),
      );
      return;
    }

    if (_currency == null) {
      MonekinSnackbar.error(
        SnackbarParams.fromError(t.assets.form.select_currency),
      );
      return;
    }

    // Validate multi-select classification totals before touching the DB.
    final states = _taxStates;
    if (_isEditing && states != null) {
      for (final state in states) {
        if (state.taxonomy.isSingleSelect) continue;
        final total = state.rows.fold<double>(0, (s, r) => s + r.weightPercent);
        if (total > 100.0001) {
          setState(() => _tab = _FormTab.classification);
          MonekinSnackbar.error(
            SnackbarParams(
              t.assets.securities.classification.weight_over_100(
                taxonomy: state.taxonomy.name,
              ),
            ),
          );
          return;
        }
      }
    }

    setState(() => _saving = true);

    // The current price is only set on creation; while editing it is managed
    // from the price-history section, so it (and its date) are left untouched.
    final newPrice = double.tryParse(_priceController.text) ?? 0;

    final security = SecurityInDB(
      id: widget.securityToEdit?.id ?? generateUUID(),
      name: name,
      type: _type,
      currencyId: _currency!.code,
      ticker: _tickerController.text.trim().isEmpty
          ? null
          : _tickerController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      currentPrice: _isEditing ? widget.securityToEdit!.currentPrice : newPrice,
      priceDate: _isEditing ? widget.securityToEdit!.priceDate : DateTime.now(),
    );

    if (_isEditing) {
      await SecurityService.instance.updateSecurity(security);
    } else {
      // insertSecurity records the initial price point on its own.
      await SecurityService.instance.insertSecurity(security);

      // Store the taxonomy guesses inferred from the online pick (if any).
      if (_pendingOnlineClassification.isNotEmpty) {
        await _applyOnlineClassification(security.id);
      }
    }

    if (_isEditing && states != null) {
      for (final state in states) {
        final List<CategoryWeight> assignments;

        if (state.taxonomy.isSingleSelect) {
          assignments = state.singleSelected == null
              ? const []
              : [(categoryId: state.singleSelected!, weight: 10000)];
        } else {
          final merged = <String, int>{};
          for (final r in state.rows) {
            final id = r.categoryId;
            if (id == null) continue;
            final bps = (r.weightPercent * 100).round();
            if (bps <= 0) continue;
            merged[id] = ((merged[id] ?? 0) + bps).clamp(0, 10000);
          }
          assignments = [
            for (final e in merged.entries)
              (categoryId: e.key, weight: e.value),
          ];
        }

        await TaxonomyService.instance.replaceAssignments(
          securityId: security.id,
          taxonomyId: state.taxonomy.id,
          assignments: assignments,
        );
      }
    }

    if (!mounted) return;
    RouteUtils.popRoute(security);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final security = widget.securityToEdit;

    return PageFramework(
      title: _isEditing ? security!.name : t.assets.holdings.create_security,
      persistentFooterButtons: [
        PersistentFooterButton(
          child: FilledButton.icon(
            style: getMediumButtonStyle(context),
            onPressed: _saving ? null : _submit,
            icon: const Icon(Icons.save),
            label: Text(t.ui_actions.save),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(key: _formKey, child: _buildContent()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final t = Translations.of(context);

    // When creating, keep it simple: general details + the security type only.
    if (!_isEditing) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTab(),
          const SizedBox(height: 24),
          _buildTypeSection(),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandingSegmentedTabs<_FormTab>(
          items: [
            SegmentedTabItem(
              value: _FormTab.general,
              icon: Icons.tune_rounded,
              label: t.assets.securities.form.tab_general,
            ),
            SegmentedTabItem(
              value: _FormTab.classification,
              icon: Icons.category_outlined,
              label: t.assets.securities.form.tab_classification,
            ),
          ],
          selected: _tab,
          onSelected: (v) => setState(() => _tab = v),
        ),
        const SizedBox(height: 20),
        _tab == _FormTab.general
            ? _buildGeneralTab()
            : _buildClassificationTab(),
      ],
    );
  }

  Widget _buildGeneralTab() {
    final t = Translations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: '${t.assets.holdings.security_name} *',
            suffixIcon: (_onlineSearching || _onlineLoadingQuote)
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
          ),
          validator: (v) => fieldValidator(v, isRequired: true),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: _isEditing ? null : _onNameChanged,
        ),
        if (!_isEditing) _buildOnlineSearchArea(),
        const SizedBox(height: 12),
        TextFormField(
          controller: _tickerController,
          decoration: InputDecoration(labelText: t.assets.holdings.ticker),
        ),
        const SizedBox(height: 12),
        // The current price is only asked for on creation; while editing it is
        // changed from the price-history section, so we only expose the
        // currency here.
        if (_isEditing)
          CurrencyFormField(
            currency: _currency,
            onCurrencySelected: (newCurrency) {
              setState(() => _currency = newCurrency);
            },
          )
        else
          AmountAndCurrencyFormField(
            amountController: _priceController,
            currency: _currency,
            amountLabel: t.assets.holdings.current_price,
            isRequired: true,
            onCurrencySelected: (newCurrency) {
              setState(() => _currency = newCurrency);
            },
          ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _notesController,
          decoration: InputDecoration(
            labelText: t.assets.securities.form.notes,
            alignLabelWithHint: true,
          ),
          minLines: 2,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }

  /// The live online results shown under the name field while creating.
  Widget _buildOnlineSearchArea() {
    final theme = Theme.of(context);

    if (_onlineResults.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 264),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: _onlineResults.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final r = _onlineResults[index];
            final subtitleParts = [
              r.symbol,
              if (r.exchangeName != null) r.exchangeName!,
            ];

            return ListTile(
              dense: true,
              leading: SecurityAvatar.raw(
                name: r.name,
                ticker: r.symbol,
                size: 34,
              ),
              title: Text(r.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(
                subtitleParts.join(' · '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => _selectOnlineResult(r),
            );
          },
        ),
      ),
    );
  }

  Widget _buildClassificationTab() {
    final states = _taxStates;

    if (states == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTypeSection(),
        const SizedBox(height: 20),
        for (final state in states) ...[
          _buildTaxonomySection(state),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildTypeSection() {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(t.assets.holdings.security_type),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final type in SecurityType.values)
              ChoiceChip(
                avatar: Icon(type.icon(), size: 16),
                label: Text(type.displayName(context)),
                selected: _type == type,
                onSelected: (_) => setState(() => _type = type),
              ),
          ],
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, {Widget? trailing}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        ?trailing,
      ],
    );
  }

  Widget _buildTaxonomySection(_TaxonomyEditState state) {
    if (state.taxonomy.isSingleSelect) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(state.taxonomy.name),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final o in state.options)
                ChoiceChip(
                  avatar: _colorDot(o.category.color),
                  label: Text(o.category.name),
                  selected: state.singleSelected == o.category.id,
                  onSelected: (selected) => setState(() {
                    state.singleSelected = selected ? o.category.id : null;
                  }),
                ),
            ],
          ),
        ],
      );
    }

    return _buildMultiSelect(state);
  }

  Widget _buildMultiSelect(_TaxonomyEditState state) {
    final t = Translations.of(context);
    final total = state.rows.fold<double>(0, (s, r) => s + r.weightPercent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          state.taxonomy.name,
          trailing: TextButton.icon(
            onPressed: () => _addRow(state),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(t.assets.securities.classification.add_category),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (state.rows.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              t.assets.securities.classification.none,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        for (final row in state.rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(child: _buildCategoryButton(state, row)),
                const SizedBox(width: 8),
                SizedBox(
                  width: 78,
                  child: TextFormField(
                    controller: row.weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      suffixText: '%',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  tooltip: t.ui_actions.delete,
                  onPressed: () => setState(() {
                    row.weightController.dispose();
                    state.rows.remove(row);
                  }),
                ),
              ],
            ),
          ),
        if (state.rows.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_plainNumber(total)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: total > 100.0001
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryButton(_TaxonomyEditState state, _WeightRow row) {
    final t = Translations.of(context);
    final category = state.categoryById(row.categoryId);

    return InkWell(
      onTap: () => _pickCategory(state, row),
      borderRadius: BorderRadius.circular(6),
      child: InputDecorator(
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        child: Row(
          children: [
            if (category != null) ...[
              _colorDot(category.color),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                category?.name ??
                    t.assets.securities.classification.select_category,
                overflow: TextOverflow.ellipsis,
                style: category == null
                    ? TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )
                    : null,
              ),
            ),
            const Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }

  Widget _colorDot(String hex) {
    final color = ColorHex.get(hex);
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Future<void> _addRow(_TaxonomyEditState state) async {
    final id = await showTaxonomyCategoryPicker(
      context,
      title: state.taxonomy.name,
      categories: state.categories,
    );
    if (id == null || !mounted) return;

    final total = state.rows.fold<double>(0, (s, r) => s + r.weightPercent);
    final remaining = (100 - total).clamp(0, 100).toDouble();

    setState(() {
      state.rows.add(_WeightRow(categoryId: id, weightPercent: remaining));
    });
  }

  Future<void> _pickCategory(_TaxonomyEditState state, _WeightRow row) async {
    final id = await showTaxonomyCategoryPicker(
      context,
      title: state.taxonomy.name,
      categories: state.categories,
      selectedId: row.categoryId,
    );
    if (id == null || !mounted) return;
    setState(() => row.categoryId = id);
  }
}

import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/taxonomy/taxonomy_service.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Opens the classification editor for a security. Returns `true` when the
/// user saved changes.
Future<bool?> showSecurityClassificationEditor(
  BuildContext context,
  SecurityInDB security,
) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _SecurityClassificationEditor(security: security),
  );
}

/// A category option flattened from the taxonomy tree, with its nesting depth
/// so children can be visually indented in the dropdowns.
typedef _CategoryOption = ({TaxonomyCategoryInDB category, int depth});

/// The per-taxonomy editing state.
class _TaxonomyEditState {
  _TaxonomyEditState({required this.taxonomy, required this.options});

  final TaxonomyInDB taxonomy;
  final List<_CategoryOption> options;

  /// Single-select taxonomies keep one chosen category (nullable = none).
  String? singleSelected;

  /// Multi-select taxonomies keep a list of (categoryId, weight%) rows.
  final List<_WeightRow> rows = [];
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

class _SecurityClassificationEditor extends StatefulWidget {
  const _SecurityClassificationEditor({required this.security});

  final SecurityInDB security;

  @override
  State<_SecurityClassificationEditor> createState() =>
      _SecurityClassificationEditorState();
}

class _SecurityClassificationEditorState
    extends State<_SecurityClassificationEditor> {
  List<_TaxonomyEditState>? _states;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final s in _states ?? const <_TaxonomyEditState>[]) {
      for (final r in s.rows) {
        r.weightController.dispose();
      }
    }
    super.dispose();
  }

  Future<void> _load() async {
    final taxonomies = await TaxonomyService.instance.getTaxonomies().first;
    final assignments = await TaxonomyService.instance
        .getAssignmentsForSecurity(widget.security.id)
        .first;

    final states = <_TaxonomyEditState>[];

    for (final taxonomy in taxonomies) {
      final categories = await TaxonomyService.instance
          .getCategories(taxonomy.id)
          .first;

      final options = _flatten(categories);
      final state = _TaxonomyEditState(taxonomy: taxonomy, options: options);

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

    if (mounted) setState(() => _states = states);
  }

  /// Flattens the category tree (parents followed by their children) so the
  /// hierarchy can be rendered with indentation.
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

  Future<void> _save() async {
    final t = Translations.of(context);
    final states = _states;
    if (states == null) return;

    // Validate multi-select totals before touching the DB.
    for (final state in states) {
      if (state.taxonomy.isSingleSelect) continue;

      final total = state.rows.fold<double>(
        0,
        (sum, r) => sum + r.weightPercent,
      );
      if (total > 100.0001) {
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

    setState(() => _saving = true);

    for (final state in states) {
      final List<CategoryWeight> assignments;

      if (state.taxonomy.isSingleSelect) {
        assignments = state.singleSelected == null
            ? const []
            : [(categoryId: state.singleSelected!, weight: 10000)];
      } else {
        // Merge duplicate categories and drop empty rows.
        final merged = <String, int>{};
        for (final r in state.rows) {
          final id = r.categoryId;
          if (id == null) continue;
          final bps = (r.weightPercent * 100).round();
          if (bps <= 0) continue;
          merged[id] = ((merged[id] ?? 0) + bps).clamp(0, 10000);
        }
        assignments = [
          for (final e in merged.entries) (categoryId: e.key, weight: e.value),
        ];
      }

      await TaxonomyService.instance.replaceAssignments(
        securityId: widget.security.id,
        taxonomyId: state.taxonomy.id,
        assignments: assignments,
      );
    }

    if (!mounted) return;
    RouteUtils.popRoute(true);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final states = _states;

    return ModalContainer(
      title: t.assets.securities.classification.edit_title,
      footer: states == null
          ? null
          : BottomSheetFooter(
              submitText: t.ui_actions.save,
              onSaved: _saving ? null : _save,
            ),
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      body: states == null
          ? const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final state in states) ...[
                  _buildTaxonomySection(state),
                  const SizedBox(height: 20),
                ],
              ],
            ),
    );
  }

  Widget _buildTaxonomySection(_TaxonomyEditState state) {
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.taxonomy.name,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        if (state.taxonomy.isSingleSelect)
          DropdownButtonFormField<String?>(
            initialValue: state.singleSelected,
            isExpanded: true,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: [
              DropdownMenuItem<String?>(
                value: null,
                child: Text(t.assets.securities.classification.none),
              ),
              for (final o in state.options)
                DropdownMenuItem<String?>(
                  value: o.category.id,
                  child: Text('${'   ' * o.depth}${o.category.name}'),
                ),
            ],
            onChanged: (value) => setState(() => state.singleSelected = value),
          )
        else
          _buildMultiSelect(state),
      ],
    );
  }

  Widget _buildMultiSelect(_TaxonomyEditState state) {
    final t = Translations.of(context);
    final total = state.rows.fold<double>(0, (sum, r) => sum + r.weightPercent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final row in state.rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    initialValue: row.categoryId,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: [
                      for (final o in state.options)
                        DropdownMenuItem<String>(
                          value: o.category.id,
                          child: Text(
                            '${'   ' * o.depth}${o.category.name}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: (value) =>
                        setState(() => row.categoryId = value),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: row.weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () =>
                  setState(() => state.rows.add(_WeightRow(weightPercent: 0))),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(t.assets.securities.classification.add_category),
            ),
            if (state.rows.isNotEmpty)
              Text(
                '${_plainNumber(total)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: total > 100.0001
                      ? Theme.of(context).colorScheme.error
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

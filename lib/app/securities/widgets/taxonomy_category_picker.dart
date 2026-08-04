import 'package:flutter/material.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Opens a searchable, hierarchical picker for a taxonomy's categories. Each
/// item shows its color and (when it has children) the number of descendants.
/// Returns the chosen category id, or `null` when dismissed.
Future<String?> showTaxonomyCategoryPicker(
  BuildContext context, {
  required String title,
  required List<TaxonomyCategoryInDB> categories,
  String? selectedId,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _TaxonomyCategoryPicker(
      title: title,
      categories: categories,
      selectedId: selectedId,
    ),
  );
}

/// A flattened row of the category tree, keeping its nesting [depth] and the
/// number of direct [childCount] children (for the count badge).
typedef _PickerRow = ({
  TaxonomyCategoryInDB category,
  int depth,
  int childCount,
});

class _TaxonomyCategoryPicker extends StatefulWidget {
  const _TaxonomyCategoryPicker({
    required this.title,
    required this.categories,
    this.selectedId,
  });

  final String title;
  final List<TaxonomyCategoryInDB> categories;
  final String? selectedId;

  @override
  State<_TaxonomyCategoryPicker> createState() =>
      _TaxonomyCategoryPickerState();
}

class _TaxonomyCategoryPickerState extends State<_TaxonomyCategoryPicker> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// The full tree flattened depth-first (parents before their children).
  List<_PickerRow> _buildTreeRows() {
    final byParent = <String?, List<TaxonomyCategoryInDB>>{};
    for (final c in widget.categories) {
      byParent.putIfAbsent(c.parentID, () => []).add(c);
    }

    final result = <_PickerRow>[];
    void walk(String? parentId, int depth) {
      for (final c in byParent[parentId] ?? const <TaxonomyCategoryInDB>[]) {
        final children = byParent[c.id] ?? const <TaxonomyCategoryInDB>[];
        result.add((category: c, depth: depth, childCount: children.length));
        walk(c.id, depth + 1);
      }
    }

    walk(null, 0);
    return result;
  }

  /// When searching, a flat list of matches (no indentation, no badges).
  List<_PickerRow> _buildSearchRows(String query) {
    final q = query.toLowerCase();
    return [
      for (final c in widget.categories)
        if (c.name.toLowerCase().contains(q))
          (category: c, depth: 0, childCount: 0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final rows = _query.isEmpty ? _buildTreeRows() : _buildSearchRows(_query);

    return ModalContainer(
      title: widget.title,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            autofocus: false,
            decoration: InputDecoration(
              filled: false,
              isDense: false,
              hintText: t.assets.securities.classification.search_categories,
              labelText: t.general.tap_to_search,
              floatingLabelStyle: const TextStyle(height: -0.0005),
              prefixIcon: const Icon(Icons.search),
              border: const UnderlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _query = v.trim()),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.5,
            ),
            child: rows.isEmpty
                ? NoResults(description: t.general.search_no_results)
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: rows.length,
                    itemBuilder: (context, index) =>
                        _buildRow(context, rows[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, _PickerRow row) {
    final color = ColorHex.get(row.category.color);
    final isSelected = row.category.id == widget.selectedId;
    final isParent = row.childCount > 0;

    return ListTile(
      onTap: () => RouteUtils.popRoute(row.category.id),
      selected: isSelected,
      dense: true,
      contentPadding: EdgeInsets.fromLTRB(16 + row.depth * 20, 0, 12, 0),
      leading: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      title: Text(row.category.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isParent && _query.isEmpty)
            Text(
              '(${row.childCount})',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.check_rounded,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/database/services/filters/saved_filters_service.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/presentation/animations/animated_floating_button.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/column_with_reorderable_list_and_search.dart';
import 'package:monekin/core/presentation/widgets/monekin_reorderable_list.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/presentation/widgets/reorderable_drag_icon.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/saved_filter_form_page.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class SavedFiltersListPage extends StatefulWidget {
  const SavedFiltersListPage({super.key});

  @override
  State<SavedFiltersListPage> createState() => _SavedFiltersListPageState();
}

class _SavedFiltersListPageState extends State<SavedFiltersListPage> {
  String searchQuery = '';

  final ScrollController _scrollController = ScrollController();

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _goToEdit() {
    RouteUtils.pushRoute(const SavedFilterFormPage());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildList() {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: SavedFiltersService.instance.getSavedFilters(
        predicate: (savedFilter, filterSet) =>
            savedFilter.name.contains(searchQuery),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }

        if (snapshot.data!.isEmpty) {
          return NoResults(
            title: t.general.empty_warn,
            description: searchQuery.isNotEmpty
                ? t.general.search_no_results
                : "No saved filters found", // TODO: Add translation
          );
        }

        final filters = snapshot.data!;

        final isOrderEnabled = filters.length > 1 && searchQuery.isNullOrEmpty;

        return MonekinReorderableList(
          totalItemCount: filters.length,
          padding: ColumnWithReorderableListAndSearch.listPadding(context),
          scrollController: _scrollController,
          isOrderEnabled: isOrderEnabled,
          spaceBetween: 8,
          itemBuilder: (context, index, isOrdering) {
            final filter = filters.elementAt(index);

            return ReorderableListTileStyling(
              child: ListTile(
                onTap: () => RouteUtils.pushRoute(
                  SavedFilterFormPage(savedFilter: filter),
                ),
                trailing: filters.length > 1
                    ? ReorderableDragIcon(index: index, enabled: isOrderEnabled)
                    : null,
                leading: const Icon(Icons.filter_alt_outlined),
                title: Text(filter.name),
              ),
            );
          },
          onReorder: (from, to) async {
            if (to > from) to--;

            final item = filters.removeAt(from);
            filters.insert(to, item);

            await Future.wait(
              filters.mapIndexed(
                (index, element) => SavedFiltersService.instance
                    .updateSavedFilter(element.copyWith(displayOrder: index)),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final fab = BreakPoint.of(context).isLargerThan(BreakpointID.sm)
        ? null
        : AnimatedFloatingButtonBasedOnScroll(
            onPressed: _goToEdit,
            icon: const Icon(Icons.add_rounded),
            scrollController: _scrollController,
            text: t.ui_actions.add,
          );

    return PageFramework(
      title: "Saved filters", // TODO: Add translation
      floatingActionButton: fab,
      body: ColumnWithReorderableListAndSearch(
        onSearchChanged: _onSearchChanged,
        onAddPressed: _goToEdit,
        addText: t.ui_actions.add,
        child: buildList(),
      ),
    );
  }
}

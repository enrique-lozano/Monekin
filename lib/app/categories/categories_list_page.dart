import 'dart:async';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/form/category_form.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/monekin_reorderable_list.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../core/presentation/widgets/no_results.dart';
import '../../core/presentation/widgets/reorderable_drag_icon.dart';

class CategoriesListPage extends StatefulWidget {
  const CategoriesListPage({super.key});

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  Timer? _debounce;

  String searchQuery = '';

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 225), () {
      setState(() {
        searchQuery = query;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.general.categories)),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
        icon: const Icon(Icons.add_rounded),
        label: Text(t.categories.create),
        onPressed: () =>
            RouteUtils.pushRoute(context, const CategoryFormPage()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: t.general.tap_to_search,
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              onChanged: (q) => _onSearchChanged(q),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: CategoryService.instance.getCategories(
                predicate: (acc, curr) =>
                    acc.name.contains(searchQuery) &
                    acc.parentCategoryID.isNull(),
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const LinearProgressIndicator();
                }

                final categories = snapshot.data!;

                if (categories.isEmpty) {
                  return NoResults(
                    title: t.general.empty_warn,
                    description: t.account.no_accounts,
                  );
                }

                final isOrderEnabled =
                    categories.length > 1 && searchQuery.isNullOrEmpty;

                return MonekinReorderableList(
                  totalItemCount: categories.length,
                  isOrderEnabled: isOrderEnabled,
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  itemBuilder: (context, index) {
                    final category = categories.elementAt(index);

                    return Tappable(
                      onTap: () => RouteUtils.pushRoute(
                        context,
                        CategoryFormPage(categoryUUID: category.id),
                      ),
                      bgColor: AppColors.of(context).light,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 4),
                      borderRadius: BorderRadius.circular(12),
                      child: ListTile(
                        trailing: categories.length > 1
                            ? ReorderableDragIcon(
                                index: index,
                                enabled: isOrderEnabled,
                              )
                            : null,
                        title: Text(
                          category.name,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        leading: Hero(
                          tag: 'all-accounts-page__account-icon-${category.id}',
                          child: IconDisplayer.fromCategory(context,
                              category: category),
                        ),
                      ),
                    );
                  },
                  onReorder: (from, to) async {
                    if (to > from) to--;

                    final item = categories.removeAt(from);
                    categories.insert(to, item);

                    await Future.wait(
                      categories.mapIndexed(
                        (index, element) =>
                            CategoryService.instance.updateCategory(
                          element.copyWith(displayOrder: index),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

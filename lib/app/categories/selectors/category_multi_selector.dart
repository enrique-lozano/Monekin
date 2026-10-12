import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/selectors/draggableScrollableKeyboardAware.mixin.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/count_indicator.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<List<Category>?> showMultiCategoryListModal(
  BuildContext context,
  CategoryMultiSelectorModal modal,
) {
  return RouteUtils.showResponsiveModal<List<Category>>(
    context,
    builder: (context) => modal,
  );
}

class CategoryMultiSelectorModal extends StatefulWidget {
  const CategoryMultiSelectorModal({
    super.key,
    this.selectedCategories = const [],
  });

  final List<Category> selectedCategories;

  @override
  State<CategoryMultiSelectorModal> createState() =>
      _CategoryMultiSelectorModalState();
}

class _CategoryMultiSelectorModalState extends State<CategoryMultiSelectorModal>
    with DraggableScrollableKeyboardAware {
  late List<Category> selectedCategories;

  String searchValue = '';

  /// IDs of the category tiles that are expanded
  Set<String> expandedCategoriesTiles = {};

  @override
  void initState() {
    super.initState();

    selectedCategories = [...widget.selectedCategories];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final sheet = buildDraggableSheet(
      defaultSize: 0.65,
      minChildSize: 0.64,
      builder: (context, sc) {
        return ModalContainer(
          title: t.categories.select.title,
          titleBuilder: selectedCategories.isEmpty
              ? null
              : (title) {
                  return Row(
                    children: [
                      Text(title),
                      const SizedBox(width: 12),
                      CountIndicator(selectedCategories.length),
                    ],
                  );
                },
          body: StreamBuilder(
            stream: CategoryService.instance.getCategories(
              predicate: (c, pc) =>
                  c.name.contains(searchValue) | pc.name.contains(searchValue),
            ),
            builder: (context, snapshot) {
              return Column(
                children: [
                  TextField(
                    focusNode: searchFocusNode,
                    autofocus: ModalPresentation.isPopover(context),
                    decoration: InputDecoration(
                      filled: false,
                      isDense: false,
                      hintText: t.currencies.search,
                      labelText: t.general.tap_to_search,
                      floatingLabelStyle: const TextStyle(height: -0.0005),
                      prefixIcon: const Icon(Icons.search),
                      border: const UnderlineInputBorder(),
                    ),
                    onChanged: (value) {
                      searchValue = value;

                      rebuild();
                    },
                  ),
                  buildSelectAllButton(snapshot),
                  buildCategoryTree(snapshot, sc),
                ],
              );
            },
          ),
          footer: ModalPresentation.isPopover(context)
              ? null
              : BottomSheetFooter(
                  onSaved: selectedCategories.isNotEmpty
                      ? () => RouteUtils.popRoute(selectedCategories)
                      : null,
                ),
        );
      },
    );

    // Popovers have no save button: apply the current selection on dismiss.
    return PopoverCommitOnDismiss(
      onCommit: () => RouteUtils.popRoute(selectedCategories),
      child: sheet,
    );
  }

  Widget buildCategoryTree(
    AsyncSnapshot<List<Category>> snapshot,
    ScrollController sc,
  ) {
    if (!snapshot.hasData) {
      return const LinearProgressIndicator();
    }

    final allParentCategories = snapshot.data!.where(
      (c) => c.parentCategoryID.isNullOrEmpty,
    );

    if (allParentCategories.isEmpty) {
      //TODO: Improve this messages in all the app
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(t.account.no_accounts, textAlign: TextAlign.center),
      );
    }

    return Expanded(
      child: Stack(
        children: [
          ListView.builder(
            controller: sc,
            itemCount: allParentCategories.length,
            itemBuilder: (context, index) {
              final category = allParentCategories.elementAt(index);
              final subcategories = snapshot.data!.where(
                (cat) => cat.parentCategoryID == category.id,
              );

              final subcategoriesAndMainCategory = [category, ...subcategories];

              final selectedSubcategoriesInThisCat = selectedCategories.where(
                (sel) => subcategoriesAndMainCategory
                    .map((e) => e.id)
                    .contains(sel.id),
              );

              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value) {
                    expandedCategoriesTiles.add(category.id);
                  } else {
                    expandedCategoriesTiles.removeWhere(
                      (e) => e == category.id,
                    );
                  }

                  rebuild();
                },
                leading: IconDisplayer.fromCategory(
                  context,
                  category: category,
                  borderRadius: 10,
                ),
                trailing: Checkbox.adaptive(
                  value:
                      selectedSubcategoriesInThisCat.length ==
                          subcategories.length + 1
                      ? true
                      : selectedSubcategoriesInThisCat.isEmpty
                      ? false
                      : null,
                  tristate: true,
                  onChanged: (value) {
                    if (value == true) {
                      selectedCategories.addAll(subcategoriesAndMainCategory);
                    } else {
                      selectedCategories.removeWhere(
                        (e) => subcategoriesAndMainCategory
                            .map((s) => s.id)
                            .contains(e.id),
                      );
                    }

                    rebuild();
                  },
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(category.name),
                    if (subcategories.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      AnimatedRotation(
                        turns: expandedCategoriesTiles.contains(category.id)
                            ? 0.75
                            : 0.25,
                        duration: const Duration(milliseconds: 250),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                      ),
                    ],
                  ],
                ),
                subtitle: Text(
                  '${subcategories.length} ${t.categories.subcategories}',
                ),
                children: [
                  buildSubcategoryCheckboxTile(context, category: category),
                  ...subcategories.map(
                    (subcategory) => buildSubcategoryCheckboxTile(
                      context,
                      category: subcategory,
                    ),
                  ),
                ],
              );
            },
          ),
          ScrollableWithBottomGradient.buildPositionedGradient(
            AppColors.of(context).modalBackground,
          ),
        ],
      ),
    );
  }

  Widget buildSubcategoryCheckboxTile(
    BuildContext context, {
    required Category category,
  }) {
    // The main category tile acts as the "without subcategory" pseudo-item.
    final isWithoutSubcategoryTile = category.isMainCategory;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Nesting guide: a continuous vertical line that visually keeps the
          // subcategories tucked under their parent category.
          Container(
            margin: const EdgeInsets.only(left: 28, right: 4),
            width: 1,
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
          Expanded(
            child: CheckboxListTile.adaptive(
              contentPadding: const EdgeInsets.only(left: 4, right: 12),
              title: Text(
                isWithoutSubcategoryTile
                    ? t.categories.select.without_subcategory
                    : category.name,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: isWithoutSubcategoryTile
                    ? TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )
                    : null,
              ),
              secondary: isWithoutSubcategoryTile
                  ? buildWithoutSubcategoryIcon(
                      context,
                      ColorHex.get(category.color).lighten(
                        isAppInDarkBrightness(context)
                            ? IconDisplayer.darkLightenFactor
                            : 0,
                      ),
                    )
                  : IconDisplayer.fromCategory(
                      context,
                      category: category,
                      size: 20,
                      borderRadius: 9,
                    ).copyWith(secondaryColor: Colors.transparent),
              value: selectedCategories.map((e) => e.id).contains(category.id),
              onChanged: (value) {
                if (value == true) {
                  selectedCategories.add(category);
                } else {
                  selectedCategories.removeWhere((e) => e.id == category.id);
                }

                rebuild();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWithoutSubcategoryIcon(BuildContext context, Color color) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DottedBorder(
        options: CircularDottedBorderOptions(
          color: color,
          strokeWidth: 1.5,
          strokeCap: StrokeCap.round,
          dashPattern: const [2, 3],
          padding: EdgeInsets.zero,
        ),
        child: const SizedBox(width: 20, height: 20),
      ),
    );
  }

  Widget buildSelectAllButton(AsyncSnapshot<List<Category>> snapshot) {
    final filteredSelectedCategories = snapshot.data == null
        ? <Category>[]
        : selectedCategories
              .where(
                (selAcc) => snapshot.data!.map((e) => e.id).contains(selAcc.id),
              )
              .toList();

    return CheckboxListTile(
      value:
          snapshot.data == null ||
              snapshot.data!.isEmpty ||
              filteredSelectedCategories.isEmpty
          ? false
          : filteredSelectedCategories.length == snapshot.data!.length
          ? true
          : null,
      tristate: true,
      title: Text(
        t.ui_actions.select_all,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      enabled: snapshot.hasData && snapshot.data!.isNotEmpty,
      onChanged: (value) {
        if (value == true && snapshot.data != null) {
          selectedCategories.addAll(
            snapshot.data!.whereNot(
              (e) =>
                  selectedCategories.map((selAcc) => selAcc.id).contains(e.id),
            ),
          );
        } else {
          selectedCategories.removeWhere(
            (selAcc) => snapshot.data!.map((e) => e.id).contains(selAcc.id),
          );
        }

        rebuild();
      },
    );
  }
}

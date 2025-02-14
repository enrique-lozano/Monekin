import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/categories/selectors/category_button_selector.dart';
import 'package:monekin/app/categories/selectors/draggableScrollableKeyboardAware.mixin.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<Category?> showCategoryPickerModal(
  BuildContext context, {
  required CategoryPicker modal,
}) {
  return showModalBottomSheet<Category>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return modal;
    },
  );
}

class CategoryPicker extends StatefulWidget {
  CategoryPicker({
    super.key,
    required this.selectedCategory,
    required this.categoryType,
    this.showSubcategories = true,
  }) : assert(categoryType.isNotEmpty);

  final Category? selectedCategory;
  final List<CategoryType> categoryType;

  final bool showSubcategories;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker>
    with DraggableScrollableKeyboardAware {
  Category? selectedCategory;

  final searchContoller = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return buildDraggableSheet(
        minChildSize: 0.64,
        defaultSize: 0.65,
        builder: (context, scrollController) {
          return ModalContainer(
            title: t.categories.select.select_one,
            //subtitle: "Categoría seleccionada: Compras",
            titleBuilder: (title) {
              return Row(children: [
                Text(title),
                // if (selectedCategory != null) ...[
                //   const SizedBox(width: 8),
                //   IconDisplayer.fromCategory(context,
                //       category: selectedCategory!)
                // ]
              ]);
            },
            // endWidget:
            //     IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            body: StreamBuilder(
                stream: CategoryService.instance.getCategories(
                  predicate: (c, p) => AppDB.instance.buildExpr([
                    c.parentCategoryID.isNull(),
                    c.type.isInValues(widget.categoryType),
                    drift.Expression.or([
                      c.name.contains(searchContoller.text),
                      if (selectedCategory != null)
                        c.id.isValue(selectedCategory?.parentCategoryID ??
                            selectedCategory!.id)
                    ])
                  ]),
                ),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: searchContoller,
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
                          rebuild();
                        },
                      ),
                      //  buildSelectAllButton(snapshot),
                      Expanded(
                        child: ScrollableWithBottomGradient(
                          gradientColor: Theme.of(context)
                              .colorSchemeExtended
                              .modalBackground,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          controller: scrollController,
                          child: buildCategoryList(snapshot, scrollController),
                        ),
                      ),
                    ],
                  );
                }),
            footer: Column(
              children: [
                // ---- SUBCATEGORY SELECTOR ----

                if (selectedCategory != null && widget.showSubcategories)
                  StreamBuilder(
                    stream: CategoryService.instance.getCategories(
                        predicate: (catTable, parentCatTable) => catTable
                            .parentCategoryID
                            .isValue(selectedCategory!.parentCategoryID ??
                                selectedCategory!.id)),
                    builder: (context, snapshot) {
                      final subcategories = snapshot.data;

                      return AnimatedExpanded(
                        axis: Axis.vertical,
                        expand: snapshot.hasData && snapshot.data!.isNotEmpty,
                        duration: const Duration(milliseconds: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    '${t.categories.subcategories}:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                buildSubcategoryRow(context, subcategories)
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),

                //  -- End subcategory selector --

                BottomSheetFooter(
                    onSaved: selectedCategory == null
                        ? null
                        : () {
                            Navigator.pop(context, selectedCategory);
                          }),
              ],
            ),
          );
        });
  }

  SingleChildScrollView buildSubcategoryRow(
      BuildContext context, List<Category>? subcategories) {
    final isDarkMode = isAppInDarkBrightness(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (final subcat in subcategories ?? []) ...[
            ChoiceChip.elevated(
              selected: selectedCategory?.id == subcat.id,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: selectedCategory?.id == subcat.id
                      ? ColorHex.get(selectedCategory!.color)
                      : ColorHex.get(selectedCategory!.color).lighten(),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              label: Text(
                subcat.name,
                style: TextStyle(
                  color: selectedCategory?.id == subcat.id
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              showCheckmark: false,
              selectedColor: selectedCategory != null
                  ? ColorHex.get(selectedCategory!.color)
                  : null,
              avatar: IconDisplayer(
                supportedIcon: subcat.icon,
                mainColor: selectedCategory?.id == subcat.id
                    ? Colors.white
                    : ColorHex.get(subcat.color).lighten(
                        isDarkMode ? IconDisplayer.darkLightenFactor : 0),
                secondaryColor: Colors.transparent,
                padding: 0,
              ),
              onSelected: (selected) {
                if (selected) {
                  selectedCategory = subcat;
                } else {
                  selectedCategory = subcat.parentCategory;
                }

                rebuild();
              },
            ),
            const SizedBox(width: 4),
          ]
        ],
      ),
    );
  }

  Widget buildCategoryList(
      AsyncSnapshot<List<Category>> snapshot, ScrollController sc) {
    if (!snapshot.hasData) {
      return const LinearProgressIndicator();
    }

    return Align(
      alignment: Alignment.center,
      heightFactor: 1,
      child: Wrap(
        runAlignment: WrapAlignment.center,
        runSpacing: 20, // Vertical space
        spacing: 16, // Horizontal space
        children: snapshot.data!.map((category) {
          return CategoryButtonSelector(
            label: category.name,
            maxTextSize: 48 * 1.25,
            iconWidget: IconDisplayer.fromCategory(
              context,
              category: category,
              borderRadius: 99999,
              size: 38,
              isOutline: selectedCategory?.id == category.id ||
                  selectedCategory?.parentCategoryID == category.id,
              onTap: () {
                selectedCategory = category;
                HapticFeedback.lightImpact();

                if (searchContoller.text.isNotNullNorEmpty) {
                  searchContoller.text = '';
                }

                rebuild();
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

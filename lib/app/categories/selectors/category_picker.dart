import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/app/categories/selectors/category_button_selector.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/i18n/translations.g.dart';

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
  const CategoryPicker(
      {super.key,
      required this.selectedCategory,
      this.categoryType = CategoryType.B,
      this.showSubcategories = true});

  final Category? selectedCategory;
  final CategoryType categoryType;

  final bool showSubcategories;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  Category? selectedCategory;

  final searchContoller = TextEditingController();

  final DraggableScrollableController controller =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.selectedCategory;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  _moveSheetTo(double position) {
    if (controller.isAttached && mounted) {
      controller.jumpTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;

    if (bottomInsets > 0) {
      _moveSheetTo(1);
    } else {
      _moveSheetTo(0.65);
    }

    return DraggableScrollableSheet(
        controller: controller,
        expand: false,
        minChildSize: 0.64,
        initialChildSize: 0.65,
        snap: true,
        snapSizes: const [0.65],
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
                    drift.Expression.or([
                      c.type.isValue('B'),
                      c.type.isValue(widget.categoryType.name),
                    ]),
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
                          setState(() {});
                        },
                      ),
                      //  buildSelectAllButton(snapshot),
                      Expanded(
                        child: ScrollableWithBottomGradient(
                          gradientColor: AppColors.of(context).modalBackground,
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
                                buildSubcategoryRow(context, subcategories)
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              thickness: 4,
                              endIndent: 16,
                              indent: 16,
                            ),
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (final subcat in subcategories ?? []) ...[
            ChoiceChip.elevated(
              selected: selectedCategory?.id == subcat.id,
              label: Text(
                subcat.name,
                style: TextStyle(
                  color: selectedCategory?.id == subcat.id
                      ? Colors.white
                      : AppColors.of(context).onSurface,
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
                    : ColorHex.get(subcat.color),
                secondaryColor: Colors.transparent,
                padding: 0,
              ),
              onSelected: (selected) {
                if (selected) {
                  selectedCategory = subcat;
                } else {
                  selectedCategory = subcat.parentCategory;
                }

                setState(() {});
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

                setState(() {});
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monekin/app/categories/category_selector.dart';
import 'package:monekin/app/categories/form/category_form.dart';
import 'package:monekin/app/categories/subcategory_selector.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/presentation/widgets/icon_displayer_widgets.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/app_colors.dart';

enum CategoriesListMode {
  page,
  modalSelectSubcategory,
  modalSelectCategory;

  bool get isModal => this != page;
}

Future<List<Category>?> showCategoryListModal(
    BuildContext context, CategoriesList page) {
  return showModalBottomSheet<List<Category>>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.85,
          minChildSize: 0.5,
          initialChildSize: 0.5,
          builder: (context, scrollController) {
            return page.copyWith(scrollController: scrollController);
          });
    },
  );
}

class CategoriesListPage extends CategoriesList {
  const CategoriesListPage()
      : super(mode: CategoriesListMode.page, selectedCategories: const []);
}

class CategoriesList extends StatefulWidget {
  const CategoriesList(
      {super.key,
      required this.mode,
      this.selectedCategories = const [],
      this.scrollController});

  final CategoriesListMode mode;
  final ScrollController? scrollController;
  final List<Category> selectedCategories;

  CategoriesList copyWith({
    Key? key,
    CategoriesListMode? mode,
    List<Category>? selectedCategories,
    ScrollController? scrollController,
  }) {
    return CategoriesList(
      key: key ?? this.key,
      mode: mode ?? this.mode,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      scrollController: scrollController ?? this.scrollController,
    );
  }

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  /// Only used when multi-selection
  late List<Category> selectedCategories;

  @override
  void initState() {
    super.initState();

    selectedCategories = [...widget.selectedCategories];
  }

  Widget buildCategoryList(CategoryType type, List<Category> mainCategories) {
    if (type != CategoryType.E && type != CategoryType.I) {
      throw Exception('Incorrect category type');
    }

    final categoriesToDisplay = (type.isExpense
            ? mainCategories.where((cat) => cat.type.isExpense)
            : mainCategories.where((cat) => cat.type.isIncome))
        .toList();

    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        controller: widget.scrollController,
        scrollDirection: Axis.vertical,
        child: CategorySelector(
          IconDisplayerSelectorData(
            availableItems: categoriesToDisplay,
            selectedItems: selectedCategories,
            multiSelection: false,
            direction: Axis.vertical,
            onChange: (selectedItems) async {
              final category = selectedItems?.elementAtOrNull(0);

              if (category == null) {
                return;
              }

              goToCategoryForm() => RouteUtils.pushRoute(
                  context, CategoryFormPage(categoryUUID: category.id));

              if (widget.mode == CategoriesListMode.page) {
                await goToCategoryForm();
              } else if (widget.mode ==
                  CategoriesListMode.modalSelectCategory) {
                category.type = type;

                Navigator.of(context).pop([category]);
              } else if (widget.mode ==
                  CategoriesListMode.modalSelectSubcategory) {
                final modalRes = await showModalBottomSheet<Category?>(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    builder: (context) {
                      return SubcategorySelector(parentCategory: category);
                    });

                if (modalRes != null) {
                  if (modalRes.isChildCategory) {
                    modalRes.parentCategory!.type = type;
                  } else {
                    modalRes.type = type;
                  }

                  Navigator.of(context).pop([modalRes]);
                } else {
                  selectedCategories = [...widget.selectedCategories];
                }
              }

              setState(() {});
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: StreamBuilder(
          stream: CategoryService.instance.getMainCategories(),
          builder: (context, categoriesSnapshot) {
            if (widget.mode == CategoriesListMode.page) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  bottom: TabBar(tabs: [
                    Tab(text: t.transaction.types.income(n: 10)),
                    Tab(text: t.transaction.types.expense(n: 10)),
                  ]),
                  title: Text(t.general.categories),
                  automaticallyImplyLeading:
                      widget.mode == CategoriesListMode.page,
                  leading: Navigator.canPop(context) &&
                          widget.mode != CategoriesListMode.page
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      : null,
                ),
                persistentFooterButtons: [
                  PersistentFooterButton(
                    child: FilledButton.icon(
                      onPressed: () {
                        RouteUtils.pushRoute(context, const CategoryFormPage());
                      },
                      icon: const Icon(Icons.add),
                      label: Text(t.categories.create),
                    ),
                  )
                ],
                body: Column(
                  children: [
                    Builder(builder: (context) {
                      if (!categoriesSnapshot.hasData) {
                        return const LinearProgressIndicator();
                      } else {
                        return Expanded(
                          child: TabBarView(children: [
                            buildCategoryList(
                                CategoryType.I, categoriesSnapshot.data!),
                            buildCategoryList(
                                CategoryType.E, categoriesSnapshot.data!),
                          ]),
                        );
                      }
                    }),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        t.general.categories,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                TabBar(
                    labelColor:
                        Theme.of(context).brightness == Brightness.light &&
                                widget.mode.isModal
                            ? AppColors.of(context).primary
                            : null,
                    unselectedLabelColor:
                        Theme.of(context).brightness == Brightness.light &&
                                widget.mode.isModal
                            ? AppColors.of(context).onBackground.lighten(0.3)
                            : null,
                    indicatorColor:
                        Theme.of(context).brightness == Brightness.light &&
                                widget.mode.isModal
                            ? AppColors.of(context).primary
                            : null,
                    tabs: [
                      Tab(text: t.transaction.types.income(n: 10)),
                      Tab(text: t.transaction.types.expense(n: 10)),
                    ]),
                Expanded(
                  child: Stack(
                    children: [
                      Builder(builder: (context) {
                        if (!categoriesSnapshot.hasData) {
                          return const LinearProgressIndicator();
                        }

                        return TabBarView(children: [
                          buildCategoryList(
                              CategoryType.I, categoriesSnapshot.data!),
                          buildCategoryList(
                              CategoryType.E, categoriesSnapshot.data!),
                        ]);
                      }),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}

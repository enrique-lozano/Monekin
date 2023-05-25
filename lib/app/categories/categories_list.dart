import 'package:finlytics/app/categories/category_form.dart';
import 'package:finlytics/app/categories/subcategory_selector.dart';
import 'package:finlytics/core/database/services/category/category_service.dart';
import 'package:finlytics/core/models/category/category.dart';
import 'package:finlytics/core/presentation/widgets/persistent_footer_button.dart';
import 'package:flutter/material.dart';

enum CategoriesListMode {
  page,
  modalSelectSubcategory,
  modalSelectCategory,
  modalSelectMultiCategory
}

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key, required this.mode});

  final CategoriesListMode mode;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  Widget buildCategoryList(CategoryType type, List<Category> mainCategories) {
    if (type != CategoryType.E && type != CategoryType.I) {
      throw Exception('Incorrect category type');
    }

    final categoriesToDisplay = (type.isExpense
            ? mainCategories.where((cat) => cat.type.isExpense)
            : mainCategories.where((cat) => cat.type.isIncome))
        .toList();

    return ListView.builder(
        itemCount: categoriesToDisplay.length,
        itemBuilder: (context, index) {
          final category = categoriesToDisplay[index];

          return ListTile(
            title: Text(category.name),
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  category.icon.display(
                      size: 25,
                      color: Color(int.parse('0xff${category.color}')))
                ]),
            onTap: () async {
              if (widget.mode == CategoriesListMode.page) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryFormPage(
                              categoryUUID: category.id,
                            )));
              } else if (widget.mode ==
                  CategoriesListMode.modalSelectCategory) {
                category.type = type;

                Navigator.of(context).pop([category]);
              } else if (widget.mode ==
                  CategoriesListMode.modalSelectSubcategory) {
                final modalRes = await showModalBottomSheet<Category?>(
                    context: context,
                    isScrollControlled: true,
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
                }
              }
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          automaticallyImplyLeading: widget.mode == CategoriesListMode.page,
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
        persistentFooterButtons: widget.mode == CategoriesListMode.page
            ? [
                PersistentFooterButton(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryFormPage()));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Añadir categoría'),
                  ),
                )
              ]
            : null,
        body: Column(
          children: [
            const TabBar(tabs: [
              Tab(text: 'Incomes'),
              Tab(text: 'Expenses'),
            ]),
            StreamBuilder(
                stream: CategoryService.instance.getMainCategories(),
                builder: (context, categories) {
                  if (!categories.hasData) {
                    return const LinearProgressIndicator();
                  } else {
                    return Expanded(
                      child: TabBarView(children: [
                        buildCategoryList(CategoryType.I, categories.data!),
                        buildCategoryList(CategoryType.E, categories.data!),
                      ]),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

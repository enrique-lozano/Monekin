import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

class SubcategorySelector extends StatefulWidget {
  const SubcategorySelector({super.key, required this.parentCategory});

  final Category parentCategory;

  @override
  State<SubcategorySelector> createState() => _SubcategorySelectorState();
}

class _SubcategorySelectorState extends State<SubcategorySelector> {
  late Category selectedCategory;

  List<Category>? childCategories;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.parentCategory;

    CategoryService.instance
        .getChildCategories(parentId: widget.parentCategory.id)
        .first
        .then((value) {
      setState(() {
        childCategories = value;
      });
    });
  }

  Widget subcategoryChip(Category category) {
    final isSelected = selectedCategory.id == category.id;

    final isSubcategorySelected = category.id != widget.parentCategory.id;

    return ActionChip(
        avatar: isSubcategorySelected
            ? category.icon.display(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onBackground)
            : Icon(
                Icons.hide_source,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onBackground,
              ),
        backgroundColor:
            isSelected ? ColorHex.get(widget.parentCategory.color) : null,
        onPressed: () {
          if (!isSelected) {
            setState(() {
              selectedCategory = category;
            });
          }
        },
        label: Text(
          isSubcategorySelected
              ? category.name
              : t.categories.select.without_subcategory,
          style: isSelected ? const TextStyle(color: Colors.white) : null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.categories.select.select_subcategory,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 22),
                Builder(
                  builder: (_) {
                    if (childCategories == null) {
                      return const LinearProgressIndicator();
                    } else {
                      return Wrap(
                        runSpacing: 0,
                        spacing: 6,
                        children: [
                          subcategoryChip(widget.parentCategory),
                          ...List.generate(
                              childCategories!.length,
                              (index) =>
                                  subcategoryChip(childCategories![index]))
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          BottomSheetFooter(
              submitText: t.general.continue_text,
              submitIcon: Icons.arrow_forward_ios,
              onSaved: () {
                Navigator.of(context).pop(selectedCategory);
              })
        ]);
  }
}

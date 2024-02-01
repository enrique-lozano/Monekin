import 'package:flutter/material.dart';
import 'package:monekin/app/categories/category_selector.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
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

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color categoryColor = ColorHex.get(widget.parentCategory.color);

    return ModalContainer(
        title: t.categories.select.select_subcategory,
        footer: BottomSheetFooter(
            submitText: t.general.continue_text,
            submitIcon: Icons.arrow_forward_ios,
            onSaved: () {
              Navigator.of(context).pop(selectedCategory);
            }),
        bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        body: CategorySelector(
          selectedCategories: [selectedCategory],
          direction: Axis.vertical,
          multiSelection: false,
          availableCategories: childCategories,
          extraHeaderButtons: [
            CategoryButtonSelector(
                iconWidget: IconDisplayer(
                  icon: Icons.block,
                  isOutline: selectedCategory.id == widget.parentCategory.id,
                  secondaryColor:
                      isDark ? categoryColor : categoryColor.lighten(0.82),
                  mainColor:
                      isDark ? categoryColor.lighten(0.82) : categoryColor,
                  onTap: () {
                    setState(() {
                      selectedCategory = widget.parentCategory;
                    });
                  },
                ),
                label: t.categories.select.without_subcategory)
          ],
          onChange: (sel) {
            if (sel != null) {
              setState(() {
                selectedCategory = sel[0];
              });
            }
          },
        ));
  }
}

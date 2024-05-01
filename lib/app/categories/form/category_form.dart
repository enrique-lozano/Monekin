import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:monekin/app/categories/form/category_form_functions.dart';
import 'package:monekin/app/categories/form/icon_and_color_selector.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/lists.extensions.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/icon_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
import 'package:monekin/core/utils/constants.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/translations.g.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key, this.categoryUUID});

  /// Account UUID to edit (if any)
  final String? categoryUUID;

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final _formKey = GlobalKey<FormState>();

  Category? categoryToEdit;

  final TextEditingController _nameController = TextEditingController();

  SupportedIcon _icon = Category.unkown().icon;
  String _color = defaultColorPickerOptions.randomItem();
  CategoryType _type = CategoryType.E;

  @override
  void initState() {
    super.initState();

    if (widget.categoryUUID != null) {
      _fillForm();
    }
  }

  void _fillForm() {
    CategoryService.instance
        .getCategoryById(widget.categoryUUID!)
        .first
        .then((category) async {
      categoryToEdit = category;

      setState(() {
        _icon = categoryToEdit!.icon;
        _color = categoryToEdit!.color;
        _type = categoryToEdit!.type;
      });

      _nameController.value = TextEditingValue(text: categoryToEdit!.name);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  submitForm() async {
    final messager = ScaffoldMessenger.of(context);

    if (categoryToEdit != null) {
      categoryToEdit = Category(
          id: categoryToEdit!.id,
          name: _nameController.text,
          displayOrder: categoryToEdit!.displayOrder,
          iconId: _icon.id,
          color: _color,
          parentCategory: categoryToEdit!.parentCategory,
          type: categoryToEdit!.type);

      await CategoryService.instance
          .updateCategory(categoryToEdit!)
          .then((value) {
        messager
            .showSnackBar(SnackBar(content: Text(t.categories.edit_success)));
      }).catchError((error) {
        messager.showSnackBar(SnackBar(content: Text(error.toString())));
      });
    } else {
      final db = AppDB.instance;

      final query = db.select(db.categories)
        ..addColumns([db.categories.id.count()])
        ..where((tbl) => tbl.name.isValue(_nameController.text));

      if (await query.watchSingleOrNull().first != null) {
        messager.showSnackBar(SnackBar(
          content: Text(t.categories.already_exists),
        ));

        return;
      }

      await CategoryService.instance
          .insertCategory(CategoryInDB(
              id: generateUUID(),
              name: _nameController.text,
              iconId: _icon.id,
              displayOrder: 10,
              type: _type,
              color: _color))
          .then((value) {
        Navigator.pop(context);

        messager
            .showSnackBar(SnackBar(content: Text(t.categories.create_success)));
      }).catchError((error) {
        messager.showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
        persistentFooterButtons: [
          PersistentFooterButton(
            child: FilledButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  submitForm();
                }
              },
              icon: const Icon(Icons.check),
              label: Text(t.general.save_changes),
            ),
          )
        ],
        appBar: AppBar(
            title: Text(widget.categoryUUID != null
                ? t.categories.edit
                : t.categories.create),
            actions: [
              if (widget.categoryUUID != null)
                PopupMenuButton(
                  itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem(
                          value: 'to_subcategory',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.login),
                            minLeadingWidth: 26,
                            title: Text(t.categories.make_child),
                          )),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                          value: 'merge',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.merge_type_rounded),
                            minLeadingWidth: 26,
                            title: Text(t.categories.merge),
                          )),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.delete),
                            minLeadingWidth: 26,
                            title: Text(t.general.delete),
                          ))
                    ];
                  },
                  onSelected: (String value) {
                    if (value == 'delete') {
                      CategoryFormFunctions.deleteCategory(
                          context, widget.categoryUUID!);
                    } else if (value == 'to_subcategory') {
                      CategoryFormFunctions.makeSubcategory(
                          context, categoryToEdit!);
                    } else if (value == 'merge') {
                      CategoryFormFunctions.mergeCategory(
                          context, categoryToEdit!);
                    }
                  },
                ),
            ]),
        body: widget.categoryUUID != null && categoryToEdit == null
            ? const LinearProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconAndColorSelector(
                              iconSelectorModalSubtitle:
                                  t.icon_selector.select_category_icon,
                              iconDisplayer: IconDisplayer.fromCategory(
                                context,
                                category: Category.fromDB(
                                  Category.unkown().copyWith(
                                      iconId: _icon.id,
                                      color: drift.Value(_color)),
                                  null,
                                ),
                                isOutline: true,
                                size: 48,
                                padding: 6,
                              ),
                              onDataChange: ((data) {
                                setState(() {
                                  _icon = data.icon;
                                  _color = data.color.toHex();
                                });
                              }),
                              data: (
                                color: ColorHex.get(_color),
                                icon: _icon,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _nameController,
                              maxLength: maxLabelLenghtForDisplayNames,
                              decoration: InputDecoration(
                                labelText: '${t.categories.name} *',
                                hintText: 'Ex.: Food',
                              ),
                              validator: (value) =>
                                  fieldValidator(value, isRequired: true),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 14),
                            DropdownButtonFormField<CategoryType>(
                              decoration: InputDecoration(
                                  labelText: '${t.categories.type} *'),
                              items: [
                                DropdownMenuItem(
                                    value: CategoryType.I,
                                    child:
                                        Text(t.transaction.types.income(n: 1))),
                                DropdownMenuItem(
                                    value: CategoryType.E,
                                    child: Text(
                                        t.transaction.types.expense(n: 1))),
                                DropdownMenuItem(
                                    value: CategoryType.B,
                                    child: Text(t.categories.both_types))
                              ],
                              value: _type,
                              onChanged: widget.categoryUUID != null
                                  ? null
                                  : (value) {
                                      setState(() {
                                        if (value != null) {
                                          _type = value;
                                        }
                                      });
                                    },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    if (widget.categoryUUID != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(t.categories.subcategories),
                      ),
                      StreamBuilder(
                        stream: CategoryService.instance
                            .getChildCategories(parentId: widget.categoryUUID!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const LinearProgressIndicator();
                          }

                          final childCategories = snapshot.data!;

                          return Column(
                              children: List.generate(childCategories.length,
                                  (index) {
                            final subcategory = childCategories[index];

                            return ListTile(
                                leading: subcategory.icon
                                    .display(color: ColorHex.get(_color)),
                                trailing: PopupMenuButton(
                                  offset: const Offset(0, 48),
                                  itemBuilder: (context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem(
                                          value: 'to_category',
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: const Icon(Icons.login),
                                            minLeadingWidth: 26,
                                            title:
                                                Text(t.categories.make_parent),
                                          )),
                                      const PopupMenuDivider(),
                                      PopupMenuItem(
                                          value: 'merge',
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: const Icon(
                                                Icons.merge_type_rounded),
                                            minLeadingWidth: 26,
                                            title: Text(t.categories.merge),
                                          )),
                                      const PopupMenuDivider(),
                                      PopupMenuItem(
                                          value: 'edit',
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: const Icon(Icons.edit),
                                            minLeadingWidth: 26,
                                            title: Text(t.general.edit),
                                          )),
                                      const PopupMenuDivider(),
                                      PopupMenuItem(
                                          value: 'delete',
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: const Icon(Icons.delete),
                                            minLeadingWidth: 26,
                                            title: Text(t.general.delete),
                                          ))
                                    ];
                                  },
                                  onSelected: (String value) {
                                    if (value == 'delete') {
                                      CategoryFormFunctions.deleteCategory(
                                          context, subcategory.id);
                                    } else if (value == 'to_category') {
                                      CategoryFormFunctions.makeMainCategory(
                                          context, subcategory);
                                    } else if (value == 'edit') {
                                      CategoryFormFunctions.openSubcategoryForm(
                                          context,
                                          color: _color,
                                          subcategory: subcategory,
                                          onSubmit: (name, icon) {
                                        CategoryService.instance.updateCategory(
                                            CategoryInDB(
                                                id: subcategory.id,
                                                displayOrder: 10,
                                                name: name,
                                                iconId: icon.id,
                                                parentCategoryID:
                                                    widget.categoryUUID!));
                                      });
                                    } else if (value == 'merge') {
                                      CategoryFormFunctions.mergeCategory(
                                          context, subcategory);
                                    }
                                  },
                                ),
                                title: Text(subcategory.name));
                          }));
                        },
                      ),
                      ListTile(
                          leading: const Icon(Icons.add),
                          onTap: () {
                            CategoryFormFunctions.openSubcategoryForm(context,
                                color: _color, onSubmit: (name, icon) {
                              CategoryService.instance.insertCategory(
                                  CategoryInDB(
                                      id: generateUUID(),
                                      displayOrder: 10,
                                      name: name,
                                      iconId: icon.id,
                                      parentCategoryID: categoryToEdit!.id));
                            });
                          },
                          title: Text(t.categories.subcategories_add))
                    ]
                  ],
                ),
              ));
  }

  Container buildIconAndColorSelector(BuildContext context, Translations t) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.of(context).inputFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Builder(builder: (context) {
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return IconDisplayer(
                supportedIcon: _icon,
                size: 36,
                isOutline: true,
                outlineWidth: 1.5,
                mainColor: (isDark
                        ? AppColors.of(context).onPrimary
                        : AppColors.of(context).primary)
                    .lighten(isDark ? 0.82 : 0),
                secondaryColor: (isDark
                        ? AppColors.of(context).onPrimary
                        : AppColors.of(context).primary)
                    .lighten(isDark ? 0 : 0.82),
                displayMode: IconDisplayMode.polygon,
              );
            }),
          ),
          Flexible(
            child: Column(
              children: [
                Tappable(
                  onTap: () {
                    showIconSelectorModal(
                      context,
                      IconSelectorModal(
                        preselectedIconID: _icon.id,
                        subtitle: t.icon_selector.select_account_icon,
                        onIconSelected: (selectedIcon) {
                          setState(() {
                            _icon = selectedIcon;
                          });
                        },
                      ),
                    );
                  },
                  bgColor: AppColors.of(context).inputFill,
                  child: ListTile(
                    title: Text("Icon"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: 12),
                  ),
                ),
                Divider(color: AppColors.of(context).inputFill.darken()),
                Tappable(
                  onTap: () => true,
                  bgColor: AppColors.of(context).inputFill,
                  child: ListTile(
                    title: Text("Icon"),
                    trailing: Icon(
                      Icons.circle,
                      color: AppColors.of(context).primary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

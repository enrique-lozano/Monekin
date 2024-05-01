import 'package:monekin/core/database/app_db.dart';

import '../../services/supported_icon/supported_icon_service.dart';
import '../supported-icon/supported_icon.dart';

enum CategoryType {
  /// This type of category only supports expenses
  E,

  /// This type of category only supports incomes
  I,

  /// This type of category supports incomes and expenses
  B;

  /// True if you can create income transactions in this category type
  bool get isIncome => this == I || this == B;

  /// True if you can create expense transactions in this category type
  bool get isExpense => this == E || this == B;
}

class Category extends CategoryInDB {
  String? _color;
  CategoryType? _type;
  final Category? parentCategory;

  @override
  String get color => _color ?? parentCategory!.color;

  @override
  CategoryType get type => _type ?? parentCategory!.type;

  set color(String newColor) {
    if (isMainCategory) {
      _color = newColor;
    } else {
      throw Exception('You can not set the color of a subcategory');
    }
  }

  set type(CategoryType newType) {
    if (isMainCategory) {
      _type = newType;
    } else {
      throw Exception('You can not set the type of a subcategory');
    }
  }

  Category(
      {required super.id,
      required super.name,
      required super.iconId,
      required super.displayOrder,
      String? color,
      CategoryType? type,
      CategoryInDB? parentCategory})
      : _color = color,
        _type = type,
        parentCategory =
            parentCategory != null ? fromDB(parentCategory, null) : null,
        super(parentCategoryID: parentCategory?.id);

  /// Returns whether the category is a main (or root) category or not
  bool get isMainCategory => parentCategoryID == null;

  /// Returns whether the category is a child of another category or not
  bool get isChildCategory => !isMainCategory;

  SupportedIcon get icon => SupportedIconService.instance.getIconByID(iconId);

  static Category fromDB(CategoryInDB cat, CategoryInDB? parentCategory) =>
      Category(
          id: cat.id,
          displayOrder: cat.displayOrder,
          name: cat.name,
          iconId: cat.iconId,
          parentCategory: parentCategory,
          color: cat.color,
          type: cat.type);
}

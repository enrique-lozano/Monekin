import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  final AppDB db;

  CategoryService._(this.db);
  static final CategoryService instance = CategoryService._(AppDB.instance);

  Future<int> insertCategory(CategoryInDB category) {
    return db.into(db.categories).insert(category);
  }

  Future<bool> updateCategory(CategoryInDB category) {
    return db.update(db.categories).replace(category);
  }

  Future<int> deleteCategory(String categoryId) {
    return (db.delete(db.categories)..where((tbl) => tbl.id.equals(categoryId)))
        .go();
  }

  Stream<List<Category>> getCategories(
      {Expression<bool> Function(
              Categories catTable, Categories parentCatTable)?
          predicate,
      double? limit}) {
    limit ??= -1;

    return db
        .getCategoriesWithFullData(predicate: predicate, limit: limit)
        .watch();
  }

  Stream<List<Category>> getChildCategories(
      {required String parentId, double? limit}) {
    limit ??= -1;

    return getCategories(
        predicate: (p0, p1) => p0.parentCategoryID.equals(parentId),
        limit: limit);
  }

  Stream<List<Category>> getMainCategories({double? limit}) {
    limit ??= -1;

    return getCategories(
        predicate: (p0, p1) => p0.parentCategoryID.isNull(), limit: limit);
  }

  Stream<Category?> getCategoryById(String id) {
    return getCategories(predicate: (a, c) => a.id.equals(id), limit: 1)
        .map((res) => res.firstOrNull);
  }

  Future<void> initializeCategories(dynamic json) async {
    const uuid = Uuid();

    for (final category in json) {
      final categoryToPush = CategoryInDB(
          id: uuid.v4(),
          name: category['names']['es'],
          iconId: category['icon'],
          color: category['color'],
          type: CategoryType.values.byName(category['type']));

      await db.customStatement(
          "INSERT INTO categories(id, name, iconId, color, type) VALUES ('${categoryToPush.id}', '${categoryToPush.name}', '${categoryToPush.iconId}', '${categoryToPush.color}', '${categoryToPush.type?.name}')");

      if (category['subcategories'] != null) {
        for (final subcategory in category['subcategories']) {
          final subcategoryToPush = CategoryInDB(
              id: uuid.v4(),
              name: subcategory['names']['es'],
              iconId: subcategory['icon'],
              parentCategoryID: categoryToPush.id);

          await db.customStatement(
              "INSERT INTO categories(id, name, iconId, parentCategoryID) VALUES ('${subcategoryToPush.id}', '${subcategoryToPush.name}', '${subcategoryToPush.iconId}', '${subcategoryToPush.parentCategoryID}')");
        }
      }
    }
  }
}

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/category/category.dart';
import 'package:monekin/core/utils/uuid.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
    return (db.delete(
      db.categories,
    )..where((tbl) => tbl.id.equals(categoryId))).go();
  }

  Stream<List<Category>> getCategories({
    Expression<bool> Function(Categories catTable, Categories parentCatTable)?
    predicate,
    OrderBy Function(Categories catTable, Categories parentCatTable)? orderBy,
    double? limit,
  }) {
    limit ??= -1;

    return db
        .getCategoriesWithFullData(
          predicate: predicate,
          orderBy:
              orderBy ?? (c, pc) => OrderBy([OrderingTerm.asc(c.displayOrder)]),
          limit: limit,
        )
        .watch();
  }

  Stream<List<Category>> getChildCategories({
    required String parentId,
    double? limit,
  }) {
    limit ??= -1;

    return getCategories(
      predicate: (p0, p1) => p0.parentCategoryID.equals(parentId),
      limit: limit,
    );
  }

  Stream<List<Category>> getMainCategories({double? limit}) {
    limit ??= -1;

    return getCategories(
      predicate: (p0, p1) => p0.parentCategoryID.isNull(),
      limit: limit,
    );
  }

  Stream<Category?> getCategoryById(String id) {
    return getCategories(
      predicate: (a, c) => a.id.equals(id),
      limit: 1,
    ).map((res) => res.firstOrNull);
  }

  /// Get the `assets/sql/initial_categories.json` file and seed the user categories with its info, based
  /// on the current language of the device.
  ///
  /// This function is called only when the user database is created.
  Future<void> initializeCategories() async {
    String defaultCategories = await rootBundle.loadString(
      'assets/sql/initial_categories.json',
    );

    dynamic json = jsonDecode(defaultCategories);

    // The category initialization is done before the app language is set, so we need to trigger this:
    String systemLang = AppLocaleUtils.findDeviceLocale().languageCode;

    if (!AppLocaleUtils.supportedLocalesRaw.any((lang) => lang == systemLang)) {
      systemLang = 'en';
    }

    for (final category in json) {
      final parentCategoryID = category['id'] ?? generateUUID();

      final categoryToPush = CategoryInDB(
        id: parentCategoryID,
        displayOrder: 10,
        name: category['names'][systemLang] ?? category['names']['en'],
        iconId: category['icon'],
        color: category['color'],
        type: CategoryType.values.byName(category['type']),
      );

      await db.customStatement("""
          INSERT INTO categories(id, name, iconId, color, type, displayOrder) VALUES (
            '${categoryToPush.id}', 
            '${categoryToPush.name.replaceAll("'", "''")}', 
            '${categoryToPush.iconId}', 
            '${categoryToPush.color}', 
            '${categoryToPush.type?.name}', 
            ${categoryToPush.displayOrder}
          )
          """);

      if (category['subcategories'] != null) {
        for (final (index, subcategory)
            in (category['subcategories']! as List<dynamic>).indexed) {
          final subcategoryToPush = CategoryInDB(
            id: '${parentCategoryID}_${index + 1}',
            displayOrder: 10,
            name:
                subcategory['names'][systemLang] ?? subcategory['names']['en'],
            iconId: subcategory['icon'],
            parentCategoryID: categoryToPush.id,
          );

          await db.customStatement("""
              INSERT INTO categories(id, name, iconId, parentCategoryID, displayOrder) VALUES (
                '${subcategoryToPush.id}', 
                '${subcategoryToPush.name.replaceAll("'", "''")}', 
                '${subcategoryToPush.iconId}', 
                '${subcategoryToPush.parentCategoryID}', 
                ${subcategoryToPush.displayOrder}
              )
            """);
        }
      }
    }
  }
}

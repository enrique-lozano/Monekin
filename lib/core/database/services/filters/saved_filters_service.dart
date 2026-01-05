import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/filters/saved_filter.dart';

class SavedFiltersService {
  final AppDB db;

  SavedFiltersService._(this.db);
  static final SavedFiltersService instance = SavedFiltersService._(
    AppDB.instance,
  );

  Future<int> insertSavedFilter(SavedFilterInDB savedFilter) {
    return db.into(db.savedFilters).insert(savedFilter);
  }

  Future<bool> updateSavedFilter(SavedFilterInDB savedFilter) {
    return db.update(db.savedFilters).replace(savedFilter);
  }

  Future<int> deleteSavedFilter(String savedFilterId) {
    return (db.delete(
      db.savedFilters,
    )..where((tbl) => tbl.id.equals(savedFilterId))).go();
  }

  Stream<List<SavedFilter>> getSavedFilters({
    Expression<bool> Function(SavedFilters, TransactionFilterSets)? predicate,
    OrderBy Function(SavedFilters, TransactionFilterSets)? orderBy,
    int? limit,
    int? offset,
  }) {
    limit ??= -1;

    return db
        .getSavedFiltersWithFullData(
          predicate: predicate,
          orderBy:
              orderBy ??
              (acc, curr) => OrderBy([OrderingTerm.asc(acc.displayOrder)]),
          limit: (a, currency) => Limit(limit ?? -1, offset),
        )
        .watch();
  }

  Stream<SavedFilter?> getSavedFilterById(String id) {
    return getSavedFilters(
      predicate: (a, b) => a.id.equals(id),
      limit: 1,
    ).map((res) => res.firstOrNull);
  }
}

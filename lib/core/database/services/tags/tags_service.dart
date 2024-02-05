import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/tags/tag.dart';

class TagService {
  final AppDB db;

  TagService._(this.db);
  static final TagService instance = TagService._(AppDB.instance);

  Future<int> insertTag(TagInDB tag) {
    return db.into(db.tags).insert(tag);
  }

  Future<bool> updateTag(TagInDB tag) {
    return db.update(db.tags).replace(tag);
  }

  Future<int> deleteTag(String tagId) {
    return (db.delete(db.tags)..where((tbl) => tbl.id.equals(tagId))).go();
  }

  Stream<List<Tag>> getTags({
    Expression<bool> Function(Tags)? filter,
    int? limit,
    int? offset,
  }) {
    limit ??= -1;

    return (db.select(db.tags)
          ..where(filter ?? (tbl) => const CustomExpression('(TRUE)'))
          ..orderBy([(acc) => OrderingTerm.asc(acc.displayOrder)])
          ..limit(limit, offset: offset))
        .watch()
        .map(
          (event) => event.map((e) => Tag.fromTagInDB(e)).toList(),
        );
  }
}

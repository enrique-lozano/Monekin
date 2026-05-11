import 'package:drift/drift.dart' show TypeConverter;
import 'package:monekin/core/database/utils/database_enum.dart';

/// A Drift TypeConverter for storing enum values in the database using their `databaseValue`.
///
/// This converter maps enum instances to their database representations and vice versa,
/// ensuring type safety and efficient storage.
///
/// Usage example:
/// ```sql
/// type TEXT NOT NULL CHECK(type IN ('E', 'I', 'T', 'N')) MAPPED BY `CustomEnumConverter(TransactionType.values)`
/// ```
final class CustomEnumConverter<E extends DatabaseEnum<V>, V>
    extends TypeConverter<E, V> {
  final Map<V, E> _fromSql;

  CustomEnumConverter(List<E> values)
    : _fromSql = {for (final value in values) value.databaseValue: value};

  @override
  E fromSql(V fromDb) => _fromSql[fromDb]!;

  @override
  V toSql(E value) => value.databaseValue;
}

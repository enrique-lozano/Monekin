import 'package:drift/drift.dart' show TypeConverter;

abstract interface class DatabaseEnum<V> implements Enum {
  /// Getter to obtain the value to be stored in the database
  V get databaseValue;
}

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

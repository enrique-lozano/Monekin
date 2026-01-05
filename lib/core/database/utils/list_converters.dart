import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:monekin/core/database/utils/database_enum.dart';

/// Converter to store a list of strings as a JSON-encoded string in the database
class StringListTypeConverter extends TypeConverter<List<String>, String> {
  const StringListTypeConverter();

  @override
  List<String> fromSql(String fromDb) {
    return List<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

/// Converter to store a list of optional strings as a JSON-encoded string in the database
class OptStringListTypeConverter extends TypeConverter<List<String?>, String> {
  const OptStringListTypeConverter();

  @override
  List<String?> fromSql(String fromDb) {
    return List<String?>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<String?> value) {
    return json.encode(value);
  }
}

/// Converter to store a list of enum values as a JSON-encoded string in the database
class EnumListTypeConverter<E extends DatabaseEnum<V>, V>
    extends TypeConverter<List<E>, String> {
  final CustomEnumConverter<E, V> _enumConverter;

  EnumListTypeConverter(List<E> values)
    : _enumConverter = CustomEnumConverter<E, V>(values);

  @override
  List<E> fromSql(String fromDb) {
    final List<dynamic> decoded = json.decode(fromDb);
    return decoded.map((e) => _enumConverter.fromSql(e as V)).toList();
  }

  @override
  String toSql(List<E> value) {
    final List<V> dbValues = value.map((e) => _enumConverter.toSql(e)).toList();
    return json.encode(dbValues);
  }
}

/// Converter to store a list of optional enum values as a JSON-encoded string in the database
class OptEnumListTypeConverter<E extends DatabaseEnum<V>, V>
    extends TypeConverter<List<E?>, String> {
  final CustomEnumConverter<E, V> _enumConverter;

  OptEnumListTypeConverter(List<E> values)
    : _enumConverter = CustomEnumConverter<E, V>(values);

  @override
  List<E?> fromSql(String fromDb) {
    final List<dynamic> decoded = json.decode(fromDb);
    return decoded
        .map((e) => e == null ? null : _enumConverter.fromSql(e as V))
        .toList();
  }

  @override
  String toSql(List<E?> value) {
    final List<V?> dbValues = value
        .map((e) => e == null ? null : _enumConverter.toSql(e))
        .toList();
    return json.encode(dbValues);
  }
}

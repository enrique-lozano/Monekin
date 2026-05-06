import 'package:drift/drift.dart';

/// Converter to store DateTime as a 'YYYY-MM-DD' formatted string in the database
class DateTypeConverter extends TypeConverter<DateTime, String> {
  const DateTypeConverter();

  @override
  DateTime fromSql(String fromDb) {
    return DateTime.parse(fromDb);
  }

  @override
  String toSql(DateTime value) {
    return '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
  }
}

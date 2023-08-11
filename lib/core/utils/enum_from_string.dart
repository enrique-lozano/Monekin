import 'package:collection/collection.dart';

/// Get the enum element that match with a string
T? enumFromString<T>(Iterable<T> values, String value) {
  return values
      .firstWhereOrNull((type) => type.toString().split('.').last == value);
}

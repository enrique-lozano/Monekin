extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;

    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String? nullIfEmpty() {
    return isEmpty ? null : this;
  }
}

extension NullableStringExtensions<E> on String? {
  /// Returns `true` if this string is `null` or empty.
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }

  /// Returns `true` if this string is not `null` and not empty.
  bool get isNotNullNorEmpty {
    return this?.isNotEmpty ?? false;
  }

  /// Returns the string if it is not `null` and not empty, otherwise returns `null`.
  String? get notEmptyString {
    return this.isNotNullNorEmpty ? this : null;
  }
}

import 'dart:math';

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}

/// Extension to provide additional list operations such as intersection and union.
extension IntersectionExtension<T> on List<T> {
  /// Returns a new list containing the intersection of this list and [other].
  /// The intersection is a list of common elements present in both lists.
  ///
  /// Example:
  /// ```dart
  /// List<int> list1 = [1, 2, 3];
  /// List<int> list2 = [2, 3, 4];
  /// List<int> result = list1.intersectionWith(list2); // [2, 3]
  /// ```
  Iterable<T> intersectionWith(List<T> other) {
    return where((element) => other.contains(element));
  }

  /// Returns a new list containing the intersection of this list and [other].
  /// If [other] is null, returns the original list unmodified.
  ///
  /// Example:
  /// ```dart
  /// List<int> list1 = [1, 2, 3];
  /// List<int>? list2 = null;
  /// List<int> result = list1.intersectionWithNullable(list2); // [1, 2, 3]
  /// ```
  Iterable<T> intersectionWithNullable(List<T>? other) {
    if (other == null) {
      return this;
    }

    return intersectionWith(other);
  }
}

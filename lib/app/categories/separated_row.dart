import 'package:flutter/material.dart';

class SeparatedRow extends Row {
  const SeparatedRow({
    super.key,
    required this.separatorBuilder,
    super.children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
    this.includeOuterSeparators = false,
  });

  final bool includeOuterSeparators;

  /// A builder that creates separators to be placed between children in the row.
  ///
  /// The [separatorBuilder] is called with the `context` and the `index` of
  /// the separator to be built. It should return a widget that serves as the
  /// separator between two children. The `index` is based on the child's
  /// position in the [children] list.
  ///
  /// Example:
  /// ```dart
  /// separatorBuilder: (BuildContext context, int index) {
  ///   return Container(
  ///     width: 1,
  ///     color: Colors.grey,
  ///   );
  /// },
  /// ```
  ///
  /// The [separatorBuilder] is required and should not be null.
  final IndexedWidgetBuilder separatorBuilder;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final index = includeOuterSeparators ? 1 : 0;

    if (this.children.isNotEmpty) {
      if (includeOuterSeparators) {
        children.add(separatorBuilder(context, 0));
      }

      for (int i = 0; i < this.children.length; i++) {
        children.add(this.children[i]);

        if (this.children.length - i != 1) {
          children.add(separatorBuilder(context, i + index));
        }
      }

      if (includeOuterSeparators) {
        children.add(separatorBuilder(context, this.children.length));
      }
    }

    return Row(
      key: key,
      children: children,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}

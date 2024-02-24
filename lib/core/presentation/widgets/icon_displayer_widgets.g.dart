// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_displayer_widgets.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryButtonSelectorCWProxy {
  CategoryButtonSelector key(Key? key);

  CategoryButtonSelector iconWidget(IconDisplayer iconWidget);

  CategoryButtonSelector label(String label);

  CategoryButtonSelector maxTextSize(double maxTextSize);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryButtonSelector(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryButtonSelector(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryButtonSelector call({
    Key? key,
    IconDisplayer? iconWidget,
    String? label,
    double? maxTextSize,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategoryButtonSelector.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategoryButtonSelector.copyWith.fieldName(...)`
class _$CategoryButtonSelectorCWProxyImpl
    implements _$CategoryButtonSelectorCWProxy {
  const _$CategoryButtonSelectorCWProxyImpl(this._value);

  final CategoryButtonSelector _value;

  @override
  CategoryButtonSelector key(Key? key) => this(key: key);

  @override
  CategoryButtonSelector iconWidget(IconDisplayer iconWidget) =>
      this(iconWidget: iconWidget);

  @override
  CategoryButtonSelector label(String label) => this(label: label);

  @override
  CategoryButtonSelector maxTextSize(double maxTextSize) =>
      this(maxTextSize: maxTextSize);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryButtonSelector(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryButtonSelector(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryButtonSelector call({
    Object? key = const $CopyWithPlaceholder(),
    Object? iconWidget = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? maxTextSize = const $CopyWithPlaceholder(),
  }) {
    return CategoryButtonSelector(
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as Key?,
      iconWidget:
          iconWidget == const $CopyWithPlaceholder() || iconWidget == null
              ? _value.iconWidget
              // ignore: cast_nullable_to_non_nullable
              : iconWidget as IconDisplayer,
      label: label == const $CopyWithPlaceholder() || label == null
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      maxTextSize:
          maxTextSize == const $CopyWithPlaceholder() || maxTextSize == null
              ? _value.maxTextSize
              // ignore: cast_nullable_to_non_nullable
              : maxTextSize as double,
    );
  }
}

extension $CategoryButtonSelectorCopyWith on CategoryButtonSelector {
  /// Returns a callable class that can be used as follows: `instanceOfCategoryButtonSelector.copyWith(...)` or like so:`instanceOfCategoryButtonSelector.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryButtonSelectorCWProxy get copyWith =>
      _$CategoryButtonSelectorCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `CategoryButtonSelector(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryButtonSelector(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  CategoryButtonSelector copyWithNull({
    bool key = false,
  }) {
    return CategoryButtonSelector(
      key: key == true ? null : this.key,
      iconWidget: iconWidget,
      label: label,
      maxTextSize: maxTextSize,
    );
  }
}

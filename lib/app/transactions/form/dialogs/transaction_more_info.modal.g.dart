// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_more_info.modal.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionMoreInfoCWProxy {
  TransactionMoreInfo note(String? note);

  TransactionMoreInfo tags(List<Tag> tags);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionMoreInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionMoreInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionMoreInfo call({
    String? note,
    List<Tag>? tags,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionMoreInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionMoreInfo.copyWith.fieldName(...)`
class _$TransactionMoreInfoCWProxyImpl implements _$TransactionMoreInfoCWProxy {
  const _$TransactionMoreInfoCWProxyImpl(this._value);

  final TransactionMoreInfo _value;

  @override
  TransactionMoreInfo note(String? note) => this(note: note);

  @override
  TransactionMoreInfo tags(List<Tag> tags) => this(tags: tags);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionMoreInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionMoreInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionMoreInfo call({
    Object? note = const $CopyWithPlaceholder(),
    Object? tags = const $CopyWithPlaceholder(),
  }) {
    return TransactionMoreInfo(
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      tags: tags == const $CopyWithPlaceholder() || tags == null
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<Tag>,
    );
  }
}

extension $TransactionMoreInfoCopyWith on TransactionMoreInfo {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionMoreInfo.copyWith(...)` or like so:`instanceOfTransactionMoreInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionMoreInfoCWProxy get copyWith =>
      _$TransactionMoreInfoCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `TransactionMoreInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionMoreInfo(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  TransactionMoreInfo copyWithNull({
    bool note = false,
  }) {
    return TransactionMoreInfo(
      note: note == true ? null : this.note,
      tags: tags,
    );
  }
}

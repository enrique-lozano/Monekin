import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/transaction/transaction_form_field.enum.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:rxdart/rxdart.dart';

class DefaultTransactionValues {
  final String? categoryId;
  final String? rawStatus;
  final List<String>? tagIds;

  const DefaultTransactionValues({
    this.categoryId,
    this.rawStatus,
    this.tagIds,
  });

  TransactionStatus? get status {
    if (rawStatus == null) return null;
    return TransactionStatus.values.firstWhereOrNull(
      (e) => e.name == rawStatus,
    );
  }

  Map<String, dynamic> toJson() => {
    if (categoryId != null) 'category': categoryId,
    if (rawStatus != null) 'status': rawStatus,
    if (tagIds != null) 'tags': tagIds,
  };

  factory DefaultTransactionValues.fromJson(Map<String, dynamic> json) {
    return DefaultTransactionValues(
      categoryId: json['category'] as String?,
      rawStatus: json['status'] as String?,
      tagIds: json['tags'] != null
          ? (json['tags'] as List).map((e) => e.toString()).toList()
          : null,
    );
  }

  DefaultTransactionValues copyWith({
    String? categoryId,
    String? rawStatus,
    List<String>? tagIds,
    bool forceCategoryNull = false,
    bool forceStatusNull = false,
    bool forceTagsNull = false,
  }) {
    return DefaultTransactionValues(
      categoryId: forceCategoryNull ? null : (categoryId ?? this.categoryId),
      rawStatus: forceStatusNull ? null : rawStatus,
      tagIds: forceTagsNull ? null : (tagIds ?? this.tagIds),
    );
  }
}

class DefaultTransactionValuesService {
  static final DefaultTransactionValuesService _instance =
      DefaultTransactionValuesService._();
  static DefaultTransactionValuesService get instance => _instance;
  DefaultTransactionValuesService._();

  static final ValueNotifier<
    ({TransactionInDB transaction, List<String> tagIds})?
  >
  lastCreatedTransaction = ValueNotifier(null);

  Stream<DefaultTransactionValues> getValues() {
    return UserSettingService.instance
        .getSettingFromDB(SettingKey.defaultTransactionValues)
        .map((jsonStr) {
          if (jsonStr == null) return const DefaultTransactionValues();
          try {
            return DefaultTransactionValues.fromJson(jsonDecode(jsonStr));
          } catch (e) {
            return const DefaultTransactionValues();
          }
        });
  }

  Stream<List<TransactionFormField>> getFieldsToUseLastUsedValue() {
    return UserSettingService.instance
        .getSettingFromDB(SettingKey.fieldsToUseLastUsedValue)
        .map((jsonStr) {
          if (jsonStr == null) return [];
          try {
            final list = jsonDecode(jsonStr) as List;
            return list
                .map(
                  (e) => TransactionFormField.values.firstWhereOrNull(
                    (f) => f.id == e,
                  ),
                )
                .whereType<TransactionFormField>()
                .toList();
          } catch (e) {
            return [];
          }
        });
  }

  Stream<
    ({
      DefaultTransactionValues values,
      List<TransactionFormField> lastUsedFields,
    })
  >
  getAllSettings() {
    return Rx.combineLatest2(
      getValues(),
      getFieldsToUseLastUsedValue(),
      (values, lastUsedFields) =>
          (values: values, lastUsedFields: lastUsedFields),
    );
  }

  Future<void> updateValues(DefaultTransactionValues values) async {
    final jsonStr = jsonEncode(values.toJson());
    await UserSettingService.instance.setItem(
      SettingKey.defaultTransactionValues,
      jsonStr,
    );
  }

  Future<void> updateFieldsToUseLastUsedValue(
    List<TransactionFormField> fields,
  ) async {
    final jsonStr = jsonEncode(fields.map((e) => e.id).toList());
    await UserSettingService.instance.setItem(
      SettingKey.fieldsToUseLastUsedValue,
      jsonStr,
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

List<RecurrencyData> recurrencyOptionsForTranslationForm = [
  const RecurrencyData.noRepeat(),
  const RecurrencyData.withLimit(
      ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
      intervalPeriod: Periodicity.day),
  const RecurrencyData.withLimit(
      ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
      intervalPeriod: Periodicity.week),
  const RecurrencyData.withLimit(
      ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
      intervalPeriod: Periodicity.month),
  const RecurrencyData.withLimit(
      ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
      intervalPeriod: Periodicity.year),
];

DynamicSelectorModal<RecurrencyData?, RecurrencyData?>
    getTransactionFormIntervalSelector(
  BuildContext context,
  RecurrencyData recurrentRule,
) {
  final t = Translations.of(context);

  final isSelectedRuleInOptions = recurrencyOptionsForTranslationForm
          .firstWhereOrNull((element) => element == recurrentRule) !=
      null;

  return DynamicSelectorModal<RecurrencyData?, RecurrencyData?>(
    items: [
      ...recurrencyOptionsForTranslationForm,
      if (!isSelectedRuleInOptions) recurrentRule,
      null
    ],
    selectedValue: recurrentRule,
    displayNameGetter: (v) {
      if (v == null) {
        return t.general.time.periodicity.custom;
      }

      return v.formText(context);
    },
    valueGetter: (v) => v,
    trailingIconGetter: (v) => v == null ? Icons.open_in_new_rounded : null,
    title: t.general.time.periodicity.display,
  );
}

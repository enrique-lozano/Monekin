import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/models/transaction/transaction_periodicity.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/i18n/translations.g.dart';

class IntervalSelectorHelp extends StatefulWidget {
  const IntervalSelectorHelp({
    super.key,
    required this.selectedRecurrentRule,
    required this.onRecurrentRuleSelected,
  });

  final RecurrencyData selectedRecurrentRule;
  final void Function(RecurrencyData selectedRule) onRecurrentRuleSelected;

  @override
  State<IntervalSelectorHelp> createState() => _IntervalSelectorHelpState();
}

class _IntervalSelectorHelpState extends State<IntervalSelectorHelp> {
  List<RecurrencyData> options = [
    const RecurrencyData.noRepeat(),
    const RecurrencyData.withLimit(
        ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
        intervalPeriod: TransactionPeriodicity.day),
    const RecurrencyData.withLimit(
        ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
        intervalPeriod: TransactionPeriodicity.week),
    const RecurrencyData.withLimit(
        ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
        intervalPeriod: TransactionPeriodicity.month),
    const RecurrencyData.withLimit(
        ruleRecurrentLimit: RecurrentRuleLimit.infinite(),
        intervalPeriod: TransactionPeriodicity.year),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(options.length, (index) {
          final radioItem = options[index];

          return RadioListTile(
              value: radioItem,
              title: Text(radioItem.formText(context)),
              groupValue: widget.selectedRecurrentRule,
              onChanged: (value) {
                Navigator.of(context, rootNavigator: true).pop();
                widget.onRecurrentRuleSelected(radioItem);
              });
        }),
        if (options.firstWhereOrNull(
                (element) => element == widget.selectedRecurrentRule) ==
            null)
          RadioListTile(
              value: widget.selectedRecurrentRule,
              title: Text(widget.selectedRecurrentRule.formText(context)),
              groupValue: widget.selectedRecurrentRule,
              onChanged: (value) {
                Navigator.of(context, rootNavigator: true).pop();
                widget.onRecurrentRuleSelected(widget.selectedRecurrentRule);
              }),
        RadioListTile(
            value: null,
            title: Text(t.general.time.periodicity.custom),
            groupValue: widget.selectedRecurrentRule,
            onChanged: (value) {
              Navigator.of(context, rootNavigator: true).pop();

              context
                  .pushRoute(
                IntervalSelectorRoute(
                  preselectedRecurrentRule: widget.selectedRecurrentRule,
                ),
              )
                  .then((value) {
                if (value == null) return;

                widget.onRecurrentRuleSelected(value as RecurrencyData);
              });
            }),
      ],
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:parsa/core/routes/route_utils.dart';
import 'package:parsa/app/transactions/form/widgets/interval_selector.dart';
import 'package:parsa/core/models/date-utils/periodicity.dart';
import 'package:parsa/core/models/transaction/recurrency_data.dart';
import 'package:parsa/core/models/transaction/rule_recurrent_limit.dart';
import 'package:parsa/i18n/translations.g.dart';

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

              RouteUtils.pushRoute(
                context,
                IntervalSelectorPage(
                  preselectedRecurrentRule: widget.selectedRecurrentRule,
                ),
              ).then((value) {
                if (value == null) return;

                widget.onRecurrentRuleSelected(value as RecurrencyData);
              });
            }),
      ],
    );
  }
}

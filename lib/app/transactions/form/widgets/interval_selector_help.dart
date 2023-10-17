import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/transactions/form/widgets/interval_selector.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/i18n/translations.g.dart';

class RecurrencyData extends Equatable {
  final RecurrentRuleLimit? ruleRecurrentLimit;

  final int? intervalEach;
  final TransactionPeriodicity? intervalPeriod;

  const RecurrencyData({
    this.intervalEach,
    this.intervalPeriod,
    this.ruleRecurrentLimit,
  });

  const RecurrencyData.noRepeat()
      : ruleRecurrentLimit = null,
        intervalEach = null,
        intervalPeriod = null;

  const RecurrencyData.withLimit({
    required this.ruleRecurrentLimit,
    required this.intervalPeriod,
    this.intervalEach = 1,
  });

  const RecurrencyData.infinite({
    required this.intervalPeriod,
    this.intervalEach = 1,
  }) : ruleRecurrentLimit = const RecurrentRuleLimit.infinite();

  bool get isNoRecurrent => intervalEach == null;
  bool get isRecurrent => !isNoRecurrent;

  String formText(BuildContext context) {
    final t = Translations.of(context);

    if (isNoRecurrent) {
      return t.general.time.periodicity.no_repeat;
    } else if (ruleRecurrentLimit!.untilMode == RuleUntilMode.infinity &&
        intervalEach == 1) {
      return '${intervalPeriod?.allThePeriodsText(context)}';
    } else {
      if (ruleRecurrentLimit!.untilMode == RuleUntilMode.infinity) {
        return t.general.time.ranges.each_range(
          n: intervalEach!,
          range:
              intervalPeriod!.periodText(context, intervalEach!).toLowerCase(),
        );
      } else {
        if (ruleRecurrentLimit!.untilMode == RuleUntilMode.date) {
          return t.general.time.ranges.each_range_until_date(
            n: intervalEach!,
            day: DateFormat.yMMMd().format(ruleRecurrentLimit!.endDate!),
            range: intervalPeriod!
                .periodText(context, intervalEach!)
                .toLowerCase(),
          );
        } else {
          if (ruleRecurrentLimit!.remainingIterations! == 1) {
            return t.general.time.ranges.each_range_until_once(
              n: intervalEach!,
              range: intervalPeriod!
                  .periodText(context, intervalEach!)
                  .toLowerCase(),
            );
          } else {
            return t.general.time.ranges.each_range_until_times(
              n: intervalEach!,
              limit: ruleRecurrentLimit!.remainingIterations!,
              range: intervalPeriod!
                  .periodText(context, intervalEach!)
                  .toLowerCase(),
            );
          }
        }
      }
    }
  }

  @override
  List<dynamic> get props => [ruleRecurrentLimit, intervalEach, intervalPeriod];
}

Future<RecurrencyData?> showIntervalSelectoHelpDialog(BuildContext context,
    {required RecurrencyData selectedRecurrentRule}) async {
  return await showDialog<RecurrencyData?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        clipBehavior: Clip.hardEdge,
        content: IntervalSelectorHelp(
          selectedRecurrentRule: selectedRecurrentRule,
        ),
      );
    },
  );
}

class IntervalSelectorHelp extends StatefulWidget {
  const IntervalSelectorHelp({super.key, required this.selectedRecurrentRule});

  final RecurrencyData selectedRecurrentRule;

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
              onChanged: (value) => Navigator.pop(context, radioItem));
        }),
        if (options.firstWhereOrNull(
                (element) => element == widget.selectedRecurrentRule) ==
            null)
          RadioListTile(
              value: widget.selectedRecurrentRule,
              title: Text(widget.selectedRecurrentRule.formText(context)),
              groupValue: widget.selectedRecurrentRule,
              onChanged: (value) =>
                  Navigator.pop(context, widget.selectedRecurrentRule)),
        RadioListTile(
            value: null,
            title: Text(t.general.time.periodicity.custom),
            groupValue: widget.selectedRecurrentRule,
            onChanged: (value) {
              Navigator.push<RecurrencyData>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IntervalSelector(
                            preselectedRecurrentRule:
                                widget.selectedRecurrentRule,
                          ))).then((value) => Navigator.pop(context, value));
            }),
      ],
    );
  }
}

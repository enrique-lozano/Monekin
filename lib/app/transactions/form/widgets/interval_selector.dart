import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../../../core/utils/date_time_picker.dart';

class IntervalSelector extends StatefulWidget {
  const IntervalSelector({super.key, this.preselectedRecurrentRule});

  final RecurrencyData? preselectedRecurrentRule;

  @override
  State<IntervalSelector> createState() => _IntervalSelectorState();
}

class _IntervalSelectorState extends State<IntervalSelector> {
  final _formKey = GlobalKey<FormState>();

  TransactionPeriodicity intervalPeriod = TransactionPeriodicity.month;
  int intervalEach = 1;
  int remainingIterations = 1;
  DateTime endDate = DateTime.now();

  RuleUntilMode ruleUntilMode = RuleUntilMode.infinity;

  @override
  void initState() {
    super.initState();

    if (widget.preselectedRecurrentRule != null) {
      intervalEach = widget.preselectedRecurrentRule!.intervalEach ?? 1;
      intervalPeriod = widget.preselectedRecurrentRule!.intervalPeriod ??
          TransactionPeriodicity.month;

      remainingIterations = widget.preselectedRecurrentRule!.ruleRecurrentLimit
              ?.remainingIterations ??
          1;

      endDate = widget.preselectedRecurrentRule!.ruleRecurrentLimit?.endDate ??
          DateTime.now();

      ruleUntilMode =
          widget.preselectedRecurrentRule!.ruleRecurrentLimit?.untilMode ??
              RuleUntilMode.infinity;
    }
  }

  Widget buildRadioButton(RuleUntilMode item, Widget title) {
    return RadioListTile(
        value: item,
        groupValue: ruleUntilMode,
        title: title,
        onChanged: (value) {
          setState(() {
            if (value != null) {
              ruleUntilMode = value;
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.general.time.periodicity.display),
        elevation: 0,
      ),
      persistentFooterButtons: [
        PersistentFooterButton(
            child: FilledButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Navigator.pop(
                        context,
                        ruleUntilMode == RuleUntilMode.infinity
                            ? RecurrencyData.infinite(
                                intervalPeriod: intervalPeriod,
                                intervalEach: intervalEach)
                            : RecurrencyData.withLimit(
                                ruleRecurrentLimit: RecurrentRuleLimit(
                                    endDate: ruleUntilMode == RuleUntilMode.date
                                        ? endDate
                                        : null,
                                    remainingIterations:
                                        ruleUntilMode == RuleUntilMode.nTimes
                                            ? remainingIterations
                                            : null),
                                intervalPeriod: intervalPeriod,
                                intervalEach: intervalEach));
                  }
                },
                icon: const Icon(Icons.save_rounded),
                label: Text(t.general.continue_text)))
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 2, 0, 12),
              child: Text(t.general.time.ranges.it_repeat),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: TextFormField(
                          initialValue: intervalEach.toStringAsFixed(0),
                          decoration: InputDecoration(
                            labelText: '${t.general.time.each} *',
                            helperText: '',
                          ),
                          onChanged: (value) {
                            if (fieldValidator(value,
                                    validator: ValidatorType.int,
                                    isRequired: true) ==
                                null) {
                              setState(() {
                                intervalEach = int.parse(value);
                              });
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) => fieldValidator(value,
                              validator: ValidatorType.int, isRequired: true),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        )),
                    const SizedBox(width: 12),
                    Flexible(
                      flex: 2,
                      child: DropdownButtonFormField(
                        value: intervalPeriod,
                        decoration: InputDecoration(
                          labelText: '${t.general.time.periodicity.display} *',
                          helperText: '',
                        ),
                        items: List.generate(
                            TransactionPeriodicity.values.length,
                            (index) => DropdownMenuItem(
                                value: TransactionPeriodicity.values[index],
                                child: Text(TransactionPeriodicity.values[index]
                                    .periodText(context, intervalEach)))),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            intervalPeriod = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 0, 12),
              child: Text(t.general.time.ranges.it_ends),
            ),
            buildRadioButton(
                RuleUntilMode.infinity, Text(t.general.time.ranges.forever)),
            const Divider(height: 12, indent: 64),
            buildRadioButton(
                RuleUntilMode.date,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: const Text('Hasta el')),
                    const SizedBox(width: 8),
                    Flexible(
                      child: TextFormField(
                        controller: TextEditingController(
                            text: DateFormat.yMMMMd().add_Hm().format(endDate)),
                        decoration: InputDecoration(
                            labelText: '${t.general.time.datetime} *',
                            isDense: true),
                        readOnly: true,
                        enabled: ruleUntilMode == RuleUntilMode.date,
                        onTap: () async {
                          DateTime? pickedDate = await openDateTimePicker(
                            context,
                            initialDate: endDate,
                            showTimePickerAfterDate: false,
                          );

                          if (pickedDate == null) return;

                          setState(() {
                            endDate = pickedDate;
                          });
                        },
                      ),
                    ),
                  ],
                )),
            const Divider(height: 12, indent: 64),
            buildRadioButton(
                RuleUntilMode.nTimes,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Text(t.general.time.after)),
                    const SizedBox(width: 8),
                    Flexible(
                        child: TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText:
                            '${t.general.time.periodicity.repeat(n: remainingIterations)} *',
                      ),
                      initialValue: remainingIterations.toStringAsFixed(0),
                      enabled: ruleUntilMode == RuleUntilMode.nTimes,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        if (value.isNotEmpty && int.tryParse(value) != null) {
                          remainingIterations = int.parse(value);
                        }
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) => fieldValidator(value,
                          validator: ValidatorType.int,
                          isRequired: ruleUntilMode == RuleUntilMode.nTimes),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

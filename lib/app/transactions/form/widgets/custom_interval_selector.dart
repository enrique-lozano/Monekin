import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/recurrency_data.dart';
import 'package:monekin/core/models/transaction/rule_recurrent_limit.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class IntervalSelectorPage extends StatefulWidget {
  const IntervalSelectorPage({super.key, this.preselectedRecurrentRule});

  final RecurrencyData? preselectedRecurrentRule;

  @override
  State<IntervalSelectorPage> createState() => _IntervalSelectorPageState();
}

class _IntervalSelectorPageState extends State<IntervalSelectorPage> {
  final _formKey = GlobalKey<FormState>();

  Periodicity intervalPeriod = Periodicity.month;
  int intervalEach = 1;
  int remainingIterations = 1;
  DateTime endDate = DateTime.now();

  RuleUntilMode ruleUntilMode = RuleUntilMode.infinity;

  @override
  void initState() {
    super.initState();

    if (widget.preselectedRecurrentRule != null) {
      intervalEach = widget.preselectedRecurrentRule!.intervalEach ?? 1;
      intervalPeriod =
          widget.preselectedRecurrentRule!.intervalPeriod ?? Periodicity.month;

      remainingIterations =
          widget
              .preselectedRecurrentRule!
              .ruleRecurrentLimit
              ?.remainingIterations ??
          1;

      endDate =
          widget.preselectedRecurrentRule!.ruleRecurrentLimit?.endDate ??
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: Translations.of(context).general.time.periodicity.display,
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
                          intervalEach: intervalEach,
                        )
                      : RecurrencyData.withLimit(
                          ruleRecurrentLimit: RecurrentRuleLimit(
                            endDate: ruleUntilMode == RuleUntilMode.date
                                ? endDate
                                : null,
                            remainingIterations:
                                ruleUntilMode == RuleUntilMode.nTimes
                                ? remainingIterations
                                : null,
                          ),
                          intervalPeriod: intervalPeriod,
                          intervalEach: intervalEach,
                        ),
                );
              }
            },
            icon: const Icon(Icons.save_rounded),
            label: Text(t.ui_actions.continue_text),
          ),
        ),
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
                          if (fieldValidator(
                                value,
                                validator: ValidatorType.int,
                                isRequired: true,
                              ) ==
                              null) {
                            setState(() {
                              intervalEach = int.parse(value);
                            });
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) => fieldValidator(
                          value,
                          validator: ValidatorType.int,
                          isRequired: true,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
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
                          Periodicity.values.length,
                          (index) => DropdownMenuItem(
                            value: Periodicity.values[index],
                            child: Text(
                              Periodicity.values[index].periodText(
                                context,
                                isPlural: intervalEach > 1,
                              ),
                            ),
                          ),
                        ),
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
              RuleUntilMode.infinity,
              Text(t.general.time.ranges.forever),
            ),
            const Divider(height: 12, indent: 64),
            buildRadioButton(
              RuleUntilMode.date,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: Text(t.general.time.until_date)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: DateTimeFormField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.event),
                        labelText: '${t.general.time.datetime} *',
                        isDense: true,
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      initialDate: endDate,
                      enabled: ruleUntilMode == RuleUntilMode.date,
                      dateFormat: DateFormat.yMMMd(),
                      onDateSelected: (DateTime value) {
                        setState(() {
                          endDate = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
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
                      validator: (value) => fieldValidator(
                        value,
                        validator: ValidatorType.int,
                        isRequired: ruleUntilMode == RuleUntilMode.nTimes,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

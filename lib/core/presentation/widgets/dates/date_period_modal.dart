import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/dates/outlinedButtonStacked.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<DatePeriod?> openDatePeriodModal(
  BuildContext context,
  DatePeriodModal? modalComp,
) {
  return showModalBottomSheet<DatePeriod>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return modalComp ?? const DatePeriodModal();
    },
  );
}

class DatePeriodModal extends StatefulWidget {
  const DatePeriodModal({
    super.key,
    this.initialDatePeriod = const DatePeriod(periodType: PeriodType.cycle),
  });

  final DatePeriod initialDatePeriod;

  @override
  State<DatePeriodModal> createState() => _DatePeriodModalState();
}

class _DatePeriodModalState extends State<DatePeriodModal> {
  late DatePeriod toReturn;

  @override
  void initState() {
    super.initState();

    toReturn = widget.initialDatePeriod;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
        title: t.general.time.ranges.display,
        footer: BottomSheetFooter(
            submitText: t.general.continue_text,
            submitIcon: Icons.arrow_forward_ios,
            onSaved: () {
              Navigator.of(context).pop(toReturn);
            }),
        bodyPadding: const EdgeInsets.only(left: 16, right: 16),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (final periodType in PeriodType.values)
                PeriodTypeEntry(
                  onTap: () {
                    HapticFeedback.lightImpact();

                    setState(() {
                      toReturn = toReturn.copyWith(periodType: periodType);
                    });
                  },
                  periodType: periodType,
                  selectedCycle: toReturn.periodType,
                  extraWidget: Builder(builder: (context) {
                    if (periodType == PeriodType.cycle) {
                      return DropdownMenu(
                        initialSelection: toReturn.periodicity,
                        onSelected: (value) {
                          toReturn = toReturn.copyWith(periodicity: value);
                        },
                        inputDecorationTheme: const InputDecorationTheme(
                            border: UnderlineInputBorder()),
                        dropdownMenuEntries: Periodicity.values
                            .map(
                              (e) => DropdownMenuEntry(
                                value: e,
                                label: e.periodText(context, isPlural: true),
                              ),
                            )
                            .toList(),
                      );
                    } else if (periodType == PeriodType.lastDays) {
                      final textToTransformArray = t.general.time.ranges.types
                          .last_days_form(x: '***')
                          .split('***');

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (textToTransformArray[0].trim().isNotEmpty)
                            Text(textToTransformArray[0]),
                          SizedBox(
                            width: 72,
                            child: TextFormField(
                              initialValue: toReturn.lastDays.toString(),
                              keyboardType: TextInputType.number,
                              maxLength: 3,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                counterText: '',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) => fieldValidator(
                                value,
                                validator: ValidatorType.int,
                              ),
                              onChanged: (value) {
                                toReturn = toReturn.copyWith(
                                    lastDays: value.isEmpty
                                        ? null
                                        : int.parse(value));
                              },
                            ),
                          ),
                          if (textToTransformArray[1].trim().isNotEmpty)
                            Text(textToTransformArray[1]),
                        ],
                      );
                    } else if (periodType == PeriodType.dateRange) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          createDateSelectorRow(
                            context,
                            dateToSelect: toReturn.customDateRange.$1,
                            lastDate: toReturn.customDateRange.$2,
                            label: t.general.time.start_date,
                            onDateSelected: (value) {
                              toReturn = toReturn.copyWith(
                                customDateRange: (
                                  value,
                                  toReturn.customDateRange.$2,
                                ),
                              );

                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 6),
                          createDateSelectorRow(
                            context,
                            dateToSelect: toReturn.customDateRange.$2,
                            firstDate: toReturn.customDateRange.$1,
                            label: t.general.time.end_date,
                            onDateSelected: (value) {
                              toReturn = toReturn.copyWith(
                                customDateRange: (
                                  toReturn.customDateRange.$1,
                                  value,
                                ),
                              );

                              setState(() {});
                            },
                          ),
                        ],
                      );
                    }

                    return Container();
                  }),
                )
            ],
          ),
        ));
  }

  Row createDateSelectorRow(
    BuildContext context, {
    required String label,
    required DateTime? dateToSelect,
    DateTime? firstDate,
    DateTime? lastDate,
    required void Function(DateTime date) onDateSelected,
  }) {
    final t = Translations.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: TextEditingController(
                  text: dateToSelect != null
                      ? DateFormat.yMMMMd().format(dateToSelect)
                      : ''),
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                hintText: '-- ${t.general.unspecified} --',
              ),
              onTap: () {
                openDateTimePicker(
                  context,
                  initialDate: dateToSelect,
                  firstDate: firstDate,
                  lastDate: lastDate,
                  showTimePickerAfterDate: false,
                ).then((value) {
                  if (value == null) {
                    return;
                  }

                  onDateSelected(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

class PeriodTypeEntry extends StatelessWidget {
  const PeriodTypeEntry({
    super.key,
    this.extraWidget,
    required this.onTap,
    required this.periodType,
    required this.selectedCycle,
  });

  final Widget? extraWidget;
  final VoidCallback onTap;
  final PeriodType periodType;
  final PeriodType selectedCycle;

  @override
  Widget build(BuildContext context) {
    bool isSelected = periodType == selectedCycle;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isSelected ? 1 : 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButtonStacked(
                filled: isSelected,
                alignLeft: true,
                alignBeside: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                text: periodType.titleText(context),
                iconData: periodType.icon(),
                onTap: () {
                  onTap();
                },
                afterWidget: extraWidget == null
                    ? null
                    : IgnorePointer(
                        ignoring: !isSelected,
                        child: extraWidget,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

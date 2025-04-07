import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/models/date-utils/date_period.dart';
import 'package:monekin/core/models/date-utils/period_type.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/presentation/widgets/scrollable_with_bottom_gradient.dart';
import 'package:monekin/core/presentation/widgets/tappable-text-entry.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/core/utils/text_field_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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

  Widget? buildPeriodTypeCardContent(PeriodType periodType) {
    switch (periodType) {
      case PeriodType.allTime:
        return null;
      case PeriodType.cycle:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TappableTextEntry(
              title: toReturn.periodicity.periodText(
                context,
                isPlural: true,
              ),
              placeholder: t.general.time.periodicity.display,
              showSelectArrow: true,
              onTap: () {
                showDynamicSelectorBottomSheet(
                  context,
                  selectorWidget: DynamicSelectorModal(
                    items: Periodicity.values,
                    selectedValue: toReturn.periodicity,
                    displayNameGetter: (e) => e.periodText(
                      context,
                      isPlural: true,
                    ),
                    valueGetter: (p) => p,
                    title: t.general.time.periodicity.display,
                  ),
                ).then((value) {
                  if (value == null) return;

                  toReturn = toReturn.copyWith(periodicity: value.result);
                  setState(() {});
                });
              },
            ),
          ],
        );

      case PeriodType.lastDays:
        final textToTransformArray =
            t.general.time.ranges.types.last_days_form(x: '***').split('***');

        final inputBorder = UnderlineInputBorder(
          borderSide: TappableTextEntry.borderSide(context),
        );

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (textToTransformArray[0].trim().isNotEmpty)
              Text(
                textToTransformArray[0],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            SizedBox(
              width: 72,
              child: TextFormField(
                initialValue: toReturn.lastDays.toString(),
                keyboardType: TextInputType.number,
                maxLength: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  border: inputBorder,
                  enabledBorder: inputBorder,
                  filled: false,
                  counterText: '',
                  hintText: '7',
                  hintStyle: TextStyle(color: AppColors.of(context).textHint),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => fieldValidator(
                  value,
                  validator: ValidatorType.int,
                ),
                onChanged: (value) {
                  toReturn = toReturn.copyWith(
                    lastDays: value.isEmpty ? null : int.parse(value),
                  );
                },
              ),
            ),
            if (textToTransformArray[1].trim().isNotEmpty)
              Text(
                textToTransformArray[1],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ],
        );

      case PeriodType.dateRange:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            createDateSelectorRow(
              context,
              dateToSelect: toReturn.customDateRange.$1,
              lastDate: toReturn.customDateRange.$2,
              label: t.general.time.start_date,
              onDateSelected: (value) {
                toReturn = toReturn.copyWith(
                  customDateRange: (
                    value?.justDay(),
                    toReturn.customDateRange.$2,
                  ),
                );
                setState(() {});
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedExpanded(
                  expand: toReturn.periodType == PeriodType.dateRange,
                  child: const Padding(
                    padding: EdgeInsetsDirectional.only(top: 5, bottom: 0),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            createDateSelectorRow(
              context,
              dateToSelect: toReturn.customDateRange.$2,
              firstDate: toReturn.customDateRange.$1,
              label: t.general.time.end_date,
              onDateSelected: (value) {
                toReturn = toReturn.copyWith(
                  customDateRange: (
                    toReturn.customDateRange.$1,
                    value
                        ?.justDay(dayOffset: 1)
                        .subtract(const Duration(milliseconds: 1)),
                  ),
                );
                setState(() {});
              },
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.general.time.ranges.display,
      footer: BottomSheetFooter(
          submitText: t.ui_actions.continue_text,
          submitIcon: Icons.arrow_forward_ios,
          onSaved: () {
            Navigator.of(context).pop(toReturn);
          }),
      body: Stack(
        children: [
          SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
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
                      extraWidget: buildPeriodTypeCardContent(periodType),
                    )
                ],
              )),
          ScrollableWithBottomGradient.buildPositionedGradient(
              AppColors.of(context).modalBackground),
        ],
      ),
    );
  }

  Row createDateSelectorRow(
    BuildContext context, {
    required String label,
    required DateTime? dateToSelect,
    DateTime? firstDate,
    DateTime? lastDate,
    required void Function(DateTime? date) onDateSelected,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.center,
      textBaseline: TextBaseline.ideographic,
      children: [
        TappableTextEntry(
            title: dateToSelect != null
                ? DateFormat.yMMMMd().format(dateToSelect)
                : '',
            placeholder: '-- $label --',
            onTap: () {
              if (dateToSelect == null) {
                if (firstDate != null) {
                  dateToSelect = firstDate.add(const Duration(days: 1));
                }
                if (lastDate != null) {
                  dateToSelect = lastDate.subtract(const Duration(days: 1));
                }
              }

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
            }),
        AnimatedExpanded(
          expand: dateToSelect != null,
          axis: Axis.horizontal,
          child: Opacity(
            key: const ValueKey(1),
            opacity: 0.5,
            child: IconButton(
              icon: const Icon(Icons.close_rounded),
              iconSize: 16,
              onPressed: () {
                onDateSelected(null);
              },
            ),
          ),
        )
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
        child: OutlinedButtonStacked(
          filled: isSelected,
          alignLeft: false,
          alignBeside: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          text: periodType.titleText(context),
          iconData: periodType.icon(),
          onTap: () {
            onTap();
          },
          afterWidget: extraWidget == null
              ? null
              : Focus(
                  canRequestFocus: isSelected,
                  descendantsAreFocusable: isSelected,
                  child:
                      IgnorePointer(ignoring: !isSelected, child: extraWidget),
                ),
        ),
      ),
    );
  }
}

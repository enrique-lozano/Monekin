import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/models/date-utils/date_period_state.dart';
import 'package:monekin/core/presentation/widgets/dates/date_period_modal.dart';

class SegmentedCalendarButton extends StatefulWidget {
  const SegmentedCalendarButton({
    super.key,
    required this.onChanged,
    this.initialDatePeriodService = const DatePeriodState(),
    this.borderRadius = 12,
    this.buttonHeight = 48,
    this.maxDate,
    this.minDate,
    this.canChangePeriodType = true,
  });

  final double borderRadius;
  final double buttonHeight;

  final DateTime? maxDate;
  final DateTime? minDate;

  final bool canChangePeriodType;

  final void Function(DatePeriodState datePeriodService) onChanged;

  final DatePeriodState initialDatePeriodService;

  @override
  State<SegmentedCalendarButton> createState() =>
      _SegmentedCalendarButtonState();
}

class _SegmentedCalendarButtonState extends State<SegmentedCalendarButton> {
  late DatePeriodState datePeriodService;

  @override
  void initState() {
    super.initState();

    datePeriodService = widget.initialDatePeriodService;
  }

  Widget buildArrowButton({
    required IconData icon,
    required VoidCallback onPressed,
    required BorderRadiusGeometry borderRadius,
    bool disabled = false,
  }) {
    final padding = widget.buttonHeight * 0.225;

    return Expanded(
      child: Opacity(
        opacity: disabled ? 0.3 : 1,
        child: IconButton.outlined(
          onPressed: disabled ? null : onPressed,
          icon: Icon(icon),
          iconSize: widget.buttonHeight - padding * 2,
          disabledColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.primary,
          style: IconButton.styleFrom(
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2),
            fixedSize: Size.fromHeight(widget.buttonHeight),
            padding: EdgeInsets.all(padding),
            minimumSize: const Size.fromHeight(0),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildArrowButton(
            icon: Icons.arrow_back,
            disabled: datePeriodService.getNextDates().$2 == null ||
                widget.minDate != null &&
                    datePeriodService
                            .getPrevDates()
                            .$2!
                            .compareTo(widget.minDate!) <
                        0,
            onPressed: () {
              HapticFeedback.lightImpact();

              setState(() {
                datePeriodService = datePeriodService.copyWith(
                  periodModifier: datePeriodService.periodModifier - 1,
                );
              });

              widget.onChanged(datePeriodService);
            },
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(widget.borderRadius),
              right: Radius.zero,
            )),
        Expanded(
          flex: 4,
          child: FilledButton(
            onPressed: () {
              if (!widget.canChangePeriodType) return;

              openDatePeriodModal(
                context,
                DatePeriodModal(
                    initialDatePeriod: datePeriodService.datePeriod),
              ).then((value) {
                if (value == null) return;

                setState(() {
                  datePeriodService = datePeriodService.copyWith(
                    periodModifier: 0,
                    datePeriod: value,
                  );
                });

                widget.onChanged(datePeriodService);
              });
            },
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              fixedSize: Size.fromHeight(widget.buttonHeight),
              minimumSize: const Size.fromHeight(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(datePeriodService.getText(context)),
                if (widget.canChangePeriodType)
                  const Icon(Icons.arrow_drop_down_rounded)
              ],
            ),
          ),
        ),
        buildArrowButton(
            icon: Icons.arrow_forward,
            disabled: datePeriodService.getNextDates().$1 == null ||
                widget.maxDate != null &&
                    datePeriodService
                            .getNextDates()
                            .$1!
                            .compareTo(widget.maxDate!) >
                        0,
            onPressed: () {
              HapticFeedback.lightImpact();

              setState(() {
                datePeriodService = datePeriodService.copyWith(
                  periodModifier: datePeriodService.periodModifier + 1,
                );
              });

              widget.onChanged(datePeriodService);
            },
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(widget.borderRadius),
              left: Radius.zero,
            )),
      ],
    );
  }
}

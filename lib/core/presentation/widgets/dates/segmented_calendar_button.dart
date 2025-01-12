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
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    this.maxDate,
    this.minDate,
    this.canChangePeriodType = true,
    this.border,
    this.arrowButtonColor,
    this.arrowButtonBackgroundColor,
    this.mainButtonColor,
    this.mainButtonBackgroundColor,
  });

  /// Radius of the outer container element, the container of the 3 buttons (the two arrows and the central button)
  final double borderRadius;

  /// Height of the outer container element, the container of the 3 buttons (the two arrows and the central button)
  final double buttonHeight;

  /// If null, it will default to a 1px border in the app primary color
  final BoxBorder? border;

  /// The color of the arrow icons. If [null], the app primary color will be applied
  final Color? arrowButtonColor;

  /// The background color of the arrow buttons. If [null], [Colors.transparent] will be applied
  final Color? arrowButtonBackgroundColor;

  /// The foreground color of the main center selector button. If [null], the app onPrimary color will be applied
  final Color? mainButtonColor;

  /// The background color of the main center selector button. If [null], the app onPrimary color will be applied
  final Color? mainButtonBackgroundColor;

  /// The shape of the main center selector button
  final OutlinedBorder? shape;

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

    final color =
        widget.arrowButtonColor ?? Theme.of(context).colorScheme.primary;
    final bgColor = widget.arrowButtonBackgroundColor ?? Colors.transparent;

    return Expanded(
      child: IconButton(
        onPressed: disabled ? null : onPressed,
        icon: Icon(icon),
        iconSize: widget.buttonHeight - padding * 2.25,
        disabledColor: color.withOpacity(0.3),
        color: color,
        style: IconButton.styleFrom(
          backgroundColor: bgColor,
          fixedSize: Size.fromHeight(widget.buttonHeight),
          padding: EdgeInsets.all(padding),
          minimumSize: const Size.fromHeight(0),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        border: widget.border ??
            Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildArrowButton(
              icon: Icons.arrow_back_ios_rounded,
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
            child: Builder(builder: (context) {
              final buttonColor = widget.mainButtonColor ??
                  Theme.of(context).colorScheme.onPrimary;
              final buttonBgColor = widget.mainButtonBackgroundColor ??
                  Theme.of(context).colorScheme.primary;

              return FilledButton(
                onPressed: !widget.canChangePeriodType
                    ? null
                    : () {
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
                  backgroundColor: buttonBgColor,
                  disabledBackgroundColor: buttonBgColor,
                  disabledForegroundColor: buttonColor,
                  foregroundColor: buttonColor,
                  shape: widget.shape,
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
              );
            }),
          ),
          buildArrowButton(
              icon: Icons.arrow_forward_ios_rounded,
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
      ),
    );
  }
}

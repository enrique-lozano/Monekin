import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monekin/core/presentation/widgets/persistent_footer_button.dart';
import 'package:monekin/core/services/filters/date_range_service.dart';

class FooterSegmentedCalendarButton extends StatefulWidget {
  const FooterSegmentedCalendarButton(
      {super.key, required this.onDateRangeChanged});

  final void Function(
          DateTime? newStartDate, DateTime? newEndDate, DateRange dateRange)
      onDateRangeChanged;

  @override
  State<FooterSegmentedCalendarButton> createState() =>
      _FooterSegmentedCalendarButtonState();
}

class _FooterSegmentedCalendarButtonState
    extends State<FooterSegmentedCalendarButton> {
  final dateRangeService = DateRangeService();

  int multiplier = 0;

  Widget buildArrowButton(
      {required IconData icon,
      required void Function() onPressed,
      required BorderRadiusGeometry borderRadius}) {
    return Expanded(
      child: IconButton.outlined(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Theme.of(context).colorScheme.primary,
        style: ButtonStyle(
          side: MaterialStateProperty.all(
              BorderSide(color: Theme.of(context).colorScheme.primary)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
        ),
      ),
    );
  }

  sendNewDates() {
    final newRanges = dateRangeService.getDateRange(multiplier);
    widget.onDateRangeChanged(
        newRanges[0], newRanges[1], dateRangeService.selectedDateRange);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentFooterButton(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildArrowButton(
              icon: Icons.arrow_back,
              onPressed: () {
                HapticFeedback.lightImpact();
                multiplier -= 1;
                setState(() {});
                sendNewDates();
              },
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.zero,
              )),
          Expanded(
            flex: 3,
            child: FilledButton(
              onPressed: () =>
                  dateRangeService.openDateRangeModal(context).then((value) {
                setState(() {});
                sendNewDates();
              }),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    final dates = dateRangeService.getDateRange(multiplier);

                    return Text(dateRangeService.getTextOfRange(
                        startDate: dates[0], endDate: dates[1]));
                  }),
                  const Icon(Icons.arrow_drop_down_rounded)
                ],
              ),
            ),
          ),
          buildArrowButton(
              icon: Icons.arrow_forward,
              onPressed: () {
                HapticFeedback.lightImpact();
                multiplier += 1;
                setState(() {});
                sendNewDates();
              },
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10),
                left: Radius.zero,
              )),
        ],
      ),
    );
  }
}

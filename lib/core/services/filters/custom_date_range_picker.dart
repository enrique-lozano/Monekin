import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../utils/date_time_picker.dart';

class CustomDateRangePicker extends StatefulWidget {
  const CustomDateRangePicker(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.onConfirm});

  final DateTime startDate;
  final DateTime endDate;

  final Function((DateTime, DateTime) selectedDates) onConfirm;

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;

  Widget _buildSelector(
      {required String label, required DateTime date, void Function()? onTap}) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, size: 25),
            const SizedBox(height: 4),
            Text(label),
            Text(
              DateFormat.yMMMMd().format(date),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    selectedStartDate = widget.startDate;
    selectedEndDate = widget.endDate;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Align(
        child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: min(MediaQuery.of(context).size.width * 0.75, 450),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(t.general.time.ranges.display),
                centerTitle: true,
                automaticallyImplyLeading: false,
                elevation: 4,
              ),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSelector(
                    label: t.general.time.start_date,
                    date: selectedStartDate,
                    onTap: () async {
                      final dateResult = await openDateTimePicker(context,
                          showTimePickerAfterDate: false,
                          lastDate: selectedEndDate,
                          initialDate: selectedStartDate);

                      if (dateResult != null) {
                        setState(() {
                          selectedStartDate = dateResult;
                        });
                      }
                    },
                  ),
                  _buildSelector(
                      label: t.general.time.end_date,
                      date: selectedEndDate,
                      onTap: () async {
                        final dateResult = await openDateTimePicker(context,
                            showTimePickerAfterDate: false,
                            lastDate: selectedStartDate,
                            initialDate: selectedEndDate);

                        if (dateResult != null) {
                          setState(() {
                            selectedEndDate = dateResult;
                          });
                        }
                      }),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          widget
                              .onConfirm((selectedStartDate, selectedEndDate));
                        },
                        child: Text(t.general.confirm))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';

final DateTime kDefaultFirstSelectableDate = DateTime(1700);
final DateTime kDefaultLastSelectableDate = DateTime(2199);

Future<DateTime?> openDateTimePicker(
  BuildContext context, {
  required bool showTimePickerAfterDate,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  TimePickerEntryMode initialTimeEntryMode = TimePickerEntryMode.dial,
  DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= kDefaultFirstSelectableDate;
  lastDate ??= kDefaultLastSelectableDate;

  showTimePickerDef() {
    return showTimePicker(
      context: context,
      initialEntryMode: initialTimeEntryMode,
      initialTime: TimeOfDay(
        hour: initialDate!.hour,
        minute: initialDate.minute,
      ),
    );
  }

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    initialDatePickerMode: initialDatePickerMode,
    initialEntryMode: initialEntryMode,
    lastDate: lastDate,
  );

  if (pickedDate == null || !showTimePickerAfterDate) return pickedDate;

  final timePicked = await showTimePickerDef();

  if (timePicked == null) return null;

  return pickedDate.copyWith(hour: timePicked.hour, minute: timePicked.minute);
}

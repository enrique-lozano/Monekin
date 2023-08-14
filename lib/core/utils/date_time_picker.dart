import 'package:flutter/material.dart';

Future<DateTime?> openDateTimePicker(
  BuildContext context, {
  required bool showTimePickerAfterDate,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= DateTime(1700);
  lastDate ??= DateTime(2199);

  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate);

  if (pickedDate == null) return null;

  if (!showTimePickerAfterDate) {
    return pickedDate;
  }

  final timePicked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: initialDate.hour, minute: initialDate.minute));

  if (timePicked == null) return null;

  return pickedDate.copyWith(hour: timePicked.hour, minute: timePicked.minute);
}

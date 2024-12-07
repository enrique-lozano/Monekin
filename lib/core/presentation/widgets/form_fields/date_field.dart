// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/utils/date_time_picker.dart';
import 'package:monekin/i18n/translations.g.dart';

const double kCupertinoDatePickerHeight = 216;

/// Constructor tearoff definition that matches [DateTimeField.new]
// Note: This should match the definition of the [DateTimeField] constructor
typedef DateTimeFieldCreator = DateTimeField Function({
  Key? key,
  required ValueChanged<DateTime>? onDateSelected,
  required DateTime? selectedDate,
  DateFormat? dateFormat,
  TextStyle? dateTextStyle,
  InputDecoration? decoration,
  bool? enabled,
  DateTime? firstDate,
  DateTime? initialDate,
  DatePickerMode? initialDatePickerMode,
  DatePickerEntryMode initialEntryMode,
  DateTime? lastDate,
  DateTimeFieldPickerMode mode,
  bool use24hFormat,
  TimePickerEntryMode initialTimePickerEntryMode,
});

/// [DateTimeField]
///
/// Shows an [_InputDropdown] that'll trigger [DateTimeField._selectDate] whenever the user
/// clicks on it ! The date picker is **platform responsive** (ios date picker style for ios, ...)
class DateTimeField extends StatelessWidget {
  // Note: This should match the definition of the [DateTimeFieldCreator]
  DateTimeField({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.decoration,
    this.enabled = true,
    this.mode = DateTimeFieldPickerMode.dateAndTime,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.dateTextStyle,
    this.initialDate,
    this.use24hFormat = false,
    DateTime? firstDate,
    DateTime? lastDate,
    DateFormat? dateFormat,
    this.initialTimePickerEntryMode = TimePickerEntryMode.dial,
  })  : dateFormat = dateFormat ?? getDateFormatFromDateFieldPickerMode(mode),
        firstDate = firstDate ?? kDefaultFirstSelectableDate,
        lastDate = lastDate ?? kDefaultLastSelectableDate;

  DateTimeField.time({
    super.key,
    this.onDateSelected,
    this.selectedDate,
    this.decoration,
    this.enabled,
    this.initialDate,
    this.dateTextStyle,
    this.use24hFormat = false,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.initialTimePickerEntryMode = TimePickerEntryMode.dial,
    DateTime? firstDate,
    DateTime? lastDate,
  })  : initialDatePickerMode = null,
        mode = DateTimeFieldPickerMode.time,
        dateFormat = DateFormat.jm(),
        firstDate = firstDate ?? DateTime(2000),
        lastDate = lastDate ?? DateTime(2001);

  /// Callback for whenever the user selects a [DateTime]
  final ValueChanged<DateTime>? onDateSelected;

  /// The current selected date to display inside the field
  final DateTime? selectedDate;

  /// The first date that the user can select (default is 1900)
  final DateTime firstDate;

  /// The last date that the user can select (default is 2100)
  final DateTime lastDate;

  /// The date that will be selected by default in the calendar view.
  final DateTime? initialDate;

  /// Let you choose the [DatePickerMode] for the date picker! (default is [DatePickerMode.day]
  final DatePickerMode? initialDatePickerMode;

  /// Custom [InputDecoration] for the [InputDecorator] widget
  final InputDecoration? decoration;

  /// How to display the [DateTime] for the user (default is [DateFormat.yMMMD])
  final DateFormat dateFormat;

  /// Whether the field is usable. If false the user won't be able to select any date
  final bool? enabled;

  /// Whether to use the 24Hr Format
  final bool use24hFormat;

  /// Whether to ask the user to pick only the date, the time or both.
  final DateTimeFieldPickerMode mode;

  /// [TextStyle] of the selected date inside the field.
  final TextStyle? dateTextStyle;

  /// The initial entry mode for the material date picker dialog
  final DatePickerEntryMode initialEntryMode;

  // the initial entry mode for the material time picker dialog
  final TimePickerEntryMode initialTimePickerEntryMode;

  /// Shows a dialog asking the user to pick a date !
  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDateTime;

    if (selectedDate != null) {
      initialDateTime = selectedDate!;
    } else {
      final DateTime now = DateTime.now();
      if (firstDate.isAfter(now) || lastDate.isBefore(now)) {
        initialDateTime = initialDate ?? lastDate;
      } else {
        initialDateTime = initialDate ?? now;
      }
    }

    DateTime selectedDateTime = initialDateTime;

    if (mode.hasDate) {
      final datePickerRes = await openDateTimePicker(
        context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        initialEntryMode: initialEntryMode,
        initialTimeEntryMode: initialTimePickerEntryMode,
        initialDatePickerMode: initialDatePickerMode!,
        showTimePickerAfterDate: mode.hasTime,
      );
      if (datePickerRes == null) {
        return;
      }

      selectedDateTime = datePickerRes;
    } else {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialEntryMode: initialTimePickerEntryMode,
        initialTime:
            TimeOfDay(hour: initialDate!.hour, minute: initialDate!.minute),
      );

      if (selectedTime != null) {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      }
    }

    onDateSelected!(selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    String? text;

    if (selectedDate != null) {
      text = dateFormat.format(selectedDate!);
    }

    return TextFormField(
      controller: TextEditingController(text: text),
      decoration: (decoration ?? const InputDecoration()).copyWith(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '-- ${t.general.unspecified.toLowerCase()} --'),
      style: dateTextStyle,
      readOnly: true,
      mouseCursor: SystemMouseCursors.click,
      enabled: enabled,
      onTap: enabled! ? () => _selectDate(context) : null,
    );
  }
}

/// Those values are used by the [DateTimeField] widget to determine whether to ask
/// the user for the time, the date or both.
enum DateTimeFieldPickerMode {
  time,
  date,
  dateAndTime;

  bool get hasDate => this == date || this == dateAndTime;
  bool get hasTime => this == time || this == dateAndTime;
}

/// Returns the [CupertinoDatePickerMode] corresponding to the selected
/// [DateTimeFieldPickerMode]. This exists to prevent redundancy in the [DateTimeField]
/// widget parameters.
CupertinoDatePickerMode cupertinoModeFromPickerMode(
    DateTimeFieldPickerMode mode) {
  switch (mode) {
    case DateTimeFieldPickerMode.time:
      return CupertinoDatePickerMode.time;
    case DateTimeFieldPickerMode.date:
      return CupertinoDatePickerMode.date;
    default:
      return CupertinoDatePickerMode.dateAndTime;
  }
}

/// Returns the corresponding default [DateFormat] for the selected [DateTimeFieldPickerMode]
DateFormat getDateFormatFromDateFieldPickerMode(DateTimeFieldPickerMode mode) {
  switch (mode) {
    case DateTimeFieldPickerMode.time:
      return DateFormat.jm();
    case DateTimeFieldPickerMode.date:
      return DateFormat.yMMMMd();
    default:
      return DateFormat.yMd().add_jm();
  }
}

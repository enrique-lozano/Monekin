import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';

/// A [FormField] that contains a [DateTimeField].
///
/// This is a convenience widget that wraps a [DateTimeField] widget in a
/// [FormField].
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
class DateTimeFormField extends FormField<DateTime> {
  DateTimeFormField({
    super.key,
    super.onSaved,
    super.validator,
    DateTime? initialValue,
    super.autovalidateMode,
    super.enabled,
    bool use24hFormat = false,
    TextStyle? dateTextStyle,
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    ValueChanged<DateTime>? onDateSelected,
    InputDecoration? decoration,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    DateTimeFieldPickerMode mode = DateTimeFieldPickerMode.dateAndTime,
    TimePickerEntryMode initialTimePickerEntryMode = TimePickerEntryMode.dial,
    DateTimeFieldCreator fieldCreator = DateTimeField.new,
  }) : super(
         initialValue: initialValue ?? initialDate,
         builder: (FormFieldState<DateTime> field) {
           // Theme defaults are applied inside the _InputDropdown widget
           final InputDecoration _decorationWithThemeDefaults =
               decoration ?? const InputDecoration();

           final InputDecoration effectiveDecoration =
               _decorationWithThemeDefaults.copyWith(
                 errorText: field.errorText,
               );

           void onChangedHandler(DateTime value) {
             if (onDateSelected != null) {
               onDateSelected(value);
             }
             field.didChange(value);
           }

           return fieldCreator(
             firstDate: firstDate,
             initialDate: initialDate,
             lastDate: lastDate,
             decoration: effectiveDecoration,
             initialDatePickerMode: initialDatePickerMode,
             dateFormat: dateFormat,
             onDateSelected: onChangedHandler,
             selectedDate: field.value,
             enabled: enabled,
             use24hFormat: use24hFormat,
             mode: mode,
             initialEntryMode: initialEntryMode,
             dateTextStyle: dateTextStyle,
             initialTimePickerEntryMode: initialTimePickerEntryMode,
           );
         },
       );

  @override
  FormFieldState<DateTime> createState() => FormFieldState<DateTime>();
}

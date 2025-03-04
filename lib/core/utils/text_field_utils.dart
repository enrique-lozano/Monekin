import 'package:flutter/services.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A text input formatter that allows up to two decimal places,
/// replacing or disabling any invalid symbols
List<FilteringTextInputFormatter> get twoDecimalDigitFormatter =>
    decimalDigitFormatter(2);

/// A text input formatter that allows up to N decimal places,
/// replacing or disabling any invalid symbols
List<FilteringTextInputFormatter> decimalDigitFormatter(int decimalPlaces) {
  return [
    FilteringTextInputFormatter.deny(',', replacementString: '.'),
    FilteringTextInputFormatter.allow(
        RegExp(r'(^\d*\.?\d{0,' + decimalPlaces.toString() + r'})')),
  ];
}

enum ValidatorType {
  text,
  double,
  int;

  bool get isNumber => this == double || this == int;
}

String? fieldValidator(String? value,
    {bool isRequired = false, ValidatorType validator = ValidatorType.text}) {
  if (!isRequired && (value == null || value.isEmpty)) {
    // If the field is not required and is empty, we don't return any error
    return null;
  } else if (value == null || value.isEmpty) {
    return t.general.validations.required;
  }

  if (validator.isNumber && (double.tryParse(value) == null)) {
    if (value.contains(',')) {
      return 'Character "," is not valid. Split the decimal part by a "."';
    }

    if (validator == ValidatorType.int && int.tryParse(value) == null) {
      return 'Please enter an integer number';
    }

    return 'Please enter a valid number';
  }

  if (validator == ValidatorType.int && int.tryParse(value) == null) {
    return 'Please enter a valid number';
  }

  return null;
}

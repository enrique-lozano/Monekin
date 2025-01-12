import 'package:flutter/material.dart';

extension ColorHex on Color {
  /// Return a color instance from an hex string
  static Color get(String hex) {
    hex = hex.toUpperCase().replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    // Parser will return errors on invalid strings, so we don't need error catching here
    return Color(int.parse(hex, radix: 16));
  }

  String toHex({
    bool leadingHashSign = false,
    bool enableAlpha = false,
    bool toUpperCase = true,
  }) {
    final String hex = (leadingHashSign ? '#' : '') +
        (enableAlpha ? _padRadix(alpha) : '') +
        _padRadix(red) +
        _padRadix(green) +
        _padRadix(blue);
    return toUpperCase ? hex.toUpperCase() : hex;
  }

// Shorthand for padLeft of RadixString, DRY.
  String _padRadix(int value) => value.toRadixString(16).padLeft(2, '0');
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= -1 && amount <= 1);

    if (amount < 0) {
      return lighten(amount.abs());
    }

    var f = 1 - amount;

    return Color.fromARGB(
        alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  Color lighten([double amount = .1]) {
    assert(amount >= -1 && amount <= 1);

    if (amount < 0) {
      return darken(amount.abs());
    }

    return Color.fromARGB(
        alpha,
        red + ((255 - red) * amount).round(),
        green + ((255 - green) * amount).round(),
        blue + ((255 - blue) * amount).round());
  }
}

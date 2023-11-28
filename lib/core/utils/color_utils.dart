import 'package:flutter/material.dart';

extension ColorHex on Color {
  /// Return a color instance from an hex string
  static Color get(String hex) =>
      Color(int.parse("0xff${hex.replaceAll('#', '')}"));

  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${alpha.toRadixString(16).padLeft(2, '0')}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    var f = 1 - amount;

    return Color.fromARGB(
        alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    return Color.fromARGB(
        alpha,
        red + ((255 - red) * amount).round(),
        green + ((255 - green) * amount).round(),
        blue + ((255 - blue) * amount).round());
  }
}

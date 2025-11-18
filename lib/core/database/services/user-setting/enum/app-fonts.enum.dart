import 'package:monekin/core/extensions/string.extension.dart';

// To test the fonts, this link can be useful: https://fonts.google.com/?preview.text=Aa%20%CE%A9%CF%89%20%D0%96%D0%B6%20%D7%A7%D7%A7%20%D8%B9%D8%B1%D8%A8%D9%89%20%E8%89%B2%E8%89%B2%20%E6%97%A5%E6%9C%AC%20%ED%95%9C%EA%B8%80%20%C4%B1%C4%B0%20%C3%A7%C5%9F%20%C3%B1%20%C3%B8%20%C3%A6.

/// An enum with the supported fonts of the app.
enum AppFonts {
  nunito,
  jost,
  cairo,
  exo;

  static AppFonts? fromDB(String? fontStringIndex) {
    if (fontStringIndex.isNullOrEmpty) {
      return null;
    }

    return AppFonts.values.elementAtOrNull(int.parse(fontStringIndex!));
  }

  String toDB() {
    return index.toString();
  }

  /// Returns the font family name as defined in pubspec.yaml
  String get fontFamilyName {
    switch (this) {
      case AppFonts.nunito:
        return 'Nunito';
      case AppFonts.jost:
        return 'Jost';
      case AppFonts.cairo:
        return 'Cairo';
      case AppFonts.exo:
        return 'Exo';
    }
  }
}

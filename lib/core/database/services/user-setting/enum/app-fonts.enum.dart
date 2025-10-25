import 'package:monekin/core/extensions/string.extension.dart';

/// An enum with the supported fonts of the app.
enum AppFonts {
  // Each enum name should match with the font family name used in pubspec.yaml
  nunito,
  jost,
  chironHei,
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
      case AppFonts.chironHei:
        return 'Chiron Hei';
      case AppFonts.exo:
        return 'Exo';
    }
  }
}

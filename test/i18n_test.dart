import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void main() {
  group('i18n', () {
    test('should compile', () async {
      // The following test will fail if the i18n file is either not compiled
      // or there are compile-time errors.

      final enTranslations = await AppLocale.en.build();

      expect(enTranslations.general.account, 'Account');
    });

    test('All locales should be supported by Flutter', () {
      for (final locale in AppLocale.values) {
        // This will fail if the locale is not supported by Flutter
        expect(kMaterialSupportedLanguages, contains(locale.languageCode));
      }
    });
  });
}

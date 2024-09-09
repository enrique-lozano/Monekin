import 'package:flutter_test/flutter_test.dart';
import 'package:parsa/i18n/translations.g.dart';

void main() {
  group('i18n', () {
    test('should compile', () {
      // The following test will fail if the i18n file is either not compiled
      // or there are compile-time errors.
      expect(AppLocale.en.build().general.account, 'Account');
    });
  });
}

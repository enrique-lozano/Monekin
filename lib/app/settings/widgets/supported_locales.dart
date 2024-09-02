import 'package:monekin/i18n/translations.g.dart';

class SupportedLocale {
  final AppLocale locale;
  final String label;

  const SupportedLocale({required this.locale, required this.label});
}

const appSupportedLocales = [
  SupportedLocale(locale: AppLocale.es, label: 'Español'),
  SupportedLocale(locale: AppLocale.en, label: 'English'),
  SupportedLocale(locale: AppLocale.ptBr, label: 'Português Brasileiro'),
];

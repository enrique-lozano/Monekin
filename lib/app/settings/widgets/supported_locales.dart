import 'package:monekin/i18n/generated/translations.g.dart';

class SupportedLocale {
  final AppLocale locale;
  final String label;

  const SupportedLocale({required this.locale, required this.label});
}

const appSupportedLocales = [
  SupportedLocale(locale: AppLocale.es, label: 'Español'),
  SupportedLocale(locale: AppLocale.en, label: 'English'),
  SupportedLocale(locale: AppLocale.de, label: 'Deutsch'),
  SupportedLocale(locale: AppLocale.hu, label: 'Magyar'),
  SupportedLocale(locale: AppLocale.tr, label: 'Türkçe'),
  SupportedLocale(locale: AppLocale.uk, label: 'українська'),
  SupportedLocale(locale: AppLocale.zhTw, label: '繁體中文'),
  SupportedLocale(locale: AppLocale.zhCn, label: '简体中文'),
];

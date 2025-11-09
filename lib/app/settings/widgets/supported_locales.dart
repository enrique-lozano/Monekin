import 'package:monekin/app/settings/widgets/writing_system.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class SupportedLocale {
  final AppLocale locale;
  final String label;
  final WritingSystem writingSystem;

  const SupportedLocale({
    required this.locale,
    required this.label,
    required this.writingSystem,
  });
}

const appSupportedLocales = [
  SupportedLocale(
    locale: AppLocale.es,
    label: 'Español',
    writingSystem: WritingSystem.latin,
  ),
  SupportedLocale(
    locale: AppLocale.en,
    label: 'English',
    writingSystem: WritingSystem.latin,
  ),
  SupportedLocale(
    locale: AppLocale.de,
    label: 'Deutsch',
    writingSystem: WritingSystem.latin,
  ),
  SupportedLocale(
    locale: AppLocale.hu,
    label: 'Magyar',
    writingSystem: WritingSystem.latin,
  ),
  SupportedLocale(
    locale: AppLocale.it,
    label: 'Italiano',
    writingSystem: WritingSystem.latin,
  ),
  SupportedLocale(
    locale: AppLocale.tr,
    label: 'Türkçe',
    writingSystem: WritingSystem.latin,
  ),
  SupportedLocale(
    locale: AppLocale.uk,
    label: 'українська',
    writingSystem: WritingSystem.cyrillic,
  ),
  SupportedLocale(
    locale: AppLocale.zhTw,
    label: '繁體中文',
    writingSystem: WritingSystem.chinese,
  ),
  SupportedLocale(
    locale: AppLocale.zhCn,
    label: '简体中文',
    writingSystem: WritingSystem.chinese,
  ),
];

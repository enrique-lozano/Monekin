import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/supported_locales.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/translations.g.dart';

Future<String?> showLanguageSelectorBottomSheet(
    BuildContext context, LanguageSelector langSelector) {
  return showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return langSelector;
    },
  );
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key, required this.selectedLangTag});

  /// Lang ID of the selected locale ("en", "zh-TW"...)
  final String selectedLangTag;

  Widget _langRadioTile(BuildContext context,
      {required SupportedLocale supportedLocale}) {
    return RadioListTile(
      value: supportedLocale.locale.languageTag,
      title: Text(supportedLocale.label),
      groupValue: selectedLangTag,
      onChanged: (value) {
        if (value == null) {
          return;
        }

        Navigator.of(context).pop(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.settings.lang_title,
      subtitle: t.settings.lang_descr,
      responseToKeyboard: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...appSupportedLocales
                .map((e) => _langRadioTile(context, supportedLocale: e)),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}

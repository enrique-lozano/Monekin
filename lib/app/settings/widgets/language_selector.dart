import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/supported_locales.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

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
            SizedBox(
                width: double.infinity,
                child: Card(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceBright,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.translate_rounded),
                        const SizedBox(width: 12),
                        Flexible(
                          child: HTMLText(
                            htmlString: t.settings.lang_help,
                            tags: {
                              'a': TextStyle(
                                color: AppColors.of(context).link,
                              )
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            ...appSupportedLocales
                .map((e) => _langRadioTile(context, supportedLocale: e)),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}

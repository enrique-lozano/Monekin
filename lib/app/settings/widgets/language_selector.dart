import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/user-setting/enum/supported_locales.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<ModalResult<String?>?> showLanguageSelectorBottomSheet(
  BuildContext context,
  LanguageSelector langSelector,
) {
  return showModalBottomSheet<ModalResult<String?>>(
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

  /// Lang ID of the selected locale ("en", "zh-TW"...). If `null`, the app will use the device locale,
  /// or the fallback locale if the device locale is not supported.
  final String? selectedLangTag;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DynamicSelectorModal<SupportedLocale?, String?>(
      items: const [null, ...appSupportedLocales],
      selectedValue: selectedLangTag,
      displayNameGetter: (locale) => locale?.label ?? t.settings.locale_auto,
      valueGetter: (locale) => locale?.locale.languageTag,
      title: t.settings.lang_title,
      subtitle: t.settings.lang_descr,
      headerWidget: SizedBox(
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceBright,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.translate_rounded),
                const SizedBox(width: 12),
                Flexible(
                  child: HTMLText(
                    htmlString: t.settings.lang_help,
                    tags: {'a': TextStyle(color: AppColors.of(context).link)},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

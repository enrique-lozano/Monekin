import 'package:flutter/material.dart';
import 'package:parsa/app/settings/widgets/language_selector.dart';
import 'package:parsa/app/settings/widgets/supported_locales.dart';
import 'package:parsa/core/database/services/user-setting/private_mode_service.dart';
import 'package:parsa/core/database/services/user-setting/user_setting_service.dart';
import 'package:parsa/i18n/translations.g.dart';

import 'widgets/settings_list_separator.dart';

class AdvancedSettingsPage extends StatefulWidget {
  const AdvancedSettingsPage({super.key});

  @override
  State<AdvancedSettingsPage> createState() => _AdvancedSettingsPageState();
}

class SelectItem<T> {
  T value;
  String label;

  IconData? icon;

  SelectItem({
    required this.value,
    required this.label,
    this.icon,
  });
}

class _AdvancedSettingsPageState extends State<AdvancedSettingsPage> {
  Widget buildSelector<T>({
    required String title,
    String? dialogDescr,
    required List<SelectItem<T>> items,
    required T selected,
    required void Function(T newValue) onChanged,
  }) {
    SelectItem<T> selectedItem =
        items.firstWhere((element) => element.value == selected);

    return ListTile(
        title: Text(title),
        subtitle: Text(selectedItem.label),
        leading: Icon(Icons.light_mode),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  if (dialogDescr != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      dialogDescr,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ]
                ],
              ),
              contentPadding: const EdgeInsets.only(top: 12),
              content: SingleChildScrollView(
                  child: StatefulBuilder(builder: (context, alertState) {
                return Column(
                    children: items
                        .map(
                          (item) => RadioListTile(
                            title: Text(item.label),
                            value: item.value,
                            groupValue: selected,
                            onChanged: (newValue) {
                              if (newValue != null && newValue != selected) {
                                onChanged(newValue);
                                selected = newValue;
                              }
                            },
                          ),
                        )
                        .toList());
              })),
              actions: [
                TextButton(
                  child: Text(t.general.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.title_short),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(context, t.settings.lang_section),
            ListTile(
              title: Text(t.settings.lang_title),
              leading: const Icon(Icons.language),
              subtitle: Text(
                appSupportedLocales
                    .firstWhere((element) =>
                        element.locale.languageTag ==
                        LocaleSettings.currentLocale.languageTag)
                    .label,
              ),
              onTap: () async {
                final snackbarDisplayer =
                    ScaffoldMessenger.of(context).showSnackBar;

                final newLang = await showLanguageSelectorBottomSheet(
                  context,
                  LanguageSelector(
                      selectedLangTag:
                          LocaleSettings.currentLocale.languageTag),
                );

                if (newLang == null) {
                  return;
                }

                LocaleSettings.setLocaleRaw(newLang,
                    listenToDeviceLocale: true);

                try {
                  await UserSettingService.instance
                      .setSetting(SettingKey.appLanguage, newLang);
                } catch (e) {
                  snackbarDisplayer(const SnackBar(
                    content: Text(
                        'There was an error persisting this setting on your device. Contact the developers for more information'),
                  ));
                }
              },
            ),
            createListSeparator(context, t.settings.theme_and_colors),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.themeMode)
                    .map((event) => 'light'),
                initialData: 'light',
                builder: (context, snapshot) {
                  // Not rendering the widget, but keeping the stream active
                  return const SizedBox.shrink();
                }),
            // Removed AMOLED mode, dynamic colors, and accent color widgets
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.amoledMode)
                    .map((event) => 'light'),
                initialData: 'light',
                builder: (context, snapshot) {
                  // Not rendering the widget, but keeping the stream active
                  return const SizedBox.shrink();
                }),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.accentColor)
                    .map((event) => 'true'),
                initialData: 'true',
                builder: (context, snapshot) {
                  // Not rendering the widget, but keeping the stream active
                  return const SizedBox.shrink();
                }),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.accentColor)
                    .map((event) => 'MaterialBlue3.24'),
                initialData: 'MaterialBlue3.24',
                builder: (context, snapshot) {
                  // Not rendering the widget, but keeping the stream active
                  return const SizedBox.shrink();
                }),
            createListSeparator(context, t.settings.security.title),
            StreamBuilder(
              stream: PrivateModeService.instance.getPrivateModeAtLaunch(),
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: Text(t.settings.security.private_mode_at_launch),
                  subtitle:
                      Text(t.settings.security.private_mode_at_launch_descr),
                  secondary: const Icon(Icons.phonelink_lock_outlined),
                  value: snapshot.data ?? false,
                  onChanged: (bool value) {
                    PrivateModeService.instance
                        .setPrivateModeAtLaunch(value)
                        .then((i) {
                      setState(() {});
                    });
                  },
                );
              },
            ),
            StreamBuilder(
                stream: PrivateModeService.instance.privateModeStream,
                builder: (context, snapshot) {
                  return SwitchListTile(
                    title: Text(t.settings.security.private_mode),
                    subtitle: Text(t.settings.security.private_mode_descr),
                    secondary: const Icon(Icons.lock),
                    value: snapshot.data ?? false,
                    onChanged: (bool value) {
                      setState(() {
                        PrivateModeService.instance.setPrivateMode(value);
                      });
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}

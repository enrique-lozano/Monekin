import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/language_selector.dart';
import 'package:monekin/app/settings/widgets/monekin_tile_switch.dart';
import 'package:monekin/app/settings/widgets/supported_locales.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker_modal.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/app_colors.dart';
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
                    .getSetting(SettingKey.themeMode),
                builder: (context, snapshot) {
                  return buildSelector(
                    title: t.settings.theme,
                    items: [
                      SelectItem(value: 'system', label: t.settings.theme_auto),
                      SelectItem(value: 'light', label: t.settings.theme_light),
                      SelectItem(value: 'dark', label: t.settings.theme_dark)
                    ],
                    selected: snapshot.data ?? 'system',
                    onChanged: (value) {
                      UserSettingService.instance
                          .setSetting(SettingKey.themeMode, value)
                          .then((value) => null);
                    },
                  );
                }),
            MonekinTileSwitch(
              title: t.settings.amoled_mode,
              subtitle: t.settings.amoled_mode_descr,
              initialValue: appStateSettings[SettingKey.amoledMode] == '1',
              disabled: Theme.of(context).brightness == Brightness.light,
              onSwitched: (bool value) async {
                await UserSettingService.instance
                    .setSetting(SettingKey.amoledMode, value ? '1' : '0');
              },
            ),
            MonekinTileSwitch(
              title: t.settings.dynamic_colors,
              subtitle: t.settings.dynamic_colors_descr,
              initialValue: appStateSettings[SettingKey.accentColor] == 'auto',
              onSwitched: (bool value) async {
                await UserSettingService.instance.setSetting(
                    SettingKey.accentColor,
                    value ? 'auto' : brandBlue.toHex(leadingHashSign: false));
              },
            ),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.accentColor),
                initialData: 'auto',
                builder: (context, snapshot) {
                  late final Color color;

                  if (snapshot.data! == 'auto') {
                    color = Theme.of(context).colorScheme.primary;
                  } else {
                    color = ColorHex.get(snapshot.data!);
                  }

                  return ListTile(
                    onTap: snapshot.data! == 'auto'
                        ? null
                        : () => showColorPickerModal(
                              context,
                              ColorPickerModal(
                                colorOptions: [
                                  brandBlue.toHex(leadingHashSign: false),
                                  ...defaultColorPickerOptions
                                ],
                                selectedColor: color.toHex(),
                              ),
                            ).then((value) {
                              if (value == null) return;

                              setState(() {
                                UserSettingService.instance.setSetting(
                                    SettingKey.accentColor, value.toHex());
                              });
                            }),
                    title: Text(t.settings.accent_color),
                    subtitle: Text(t.settings.accent_color_descr),
                    enabled: snapshot.data! != 'auto',
                    trailing: SizedBox(
                      height: 46,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        clipBehavior: Clip.hardEdge,
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: color.withOpacity(
                            snapshot.data! != 'auto' ? 1 : 0.4,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  );
                }),
            createListSeparator(context, t.settings.security.title),
            MonekinTileSwitch(
              title: t.settings.security.private_mode_at_launch,
              subtitle: t.settings.security.private_mode_at_launch_descr,
              icon: Icons.phonelink_lock_outlined,
              initialValue:
                  appStateSettings[SettingKey.privateModeAtLaunch] == '1',
              onSwitched: (bool value) async {
                await PrivateModeService.instance.setPrivateModeAtLaunch(value);
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

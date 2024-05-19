import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker_modal.dart';
import 'package:monekin/core/presentation/widgets/tappable.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(context, t.settings.lang_section),
            buildSelector(
              title: t.settings.lang_title,
              dialogDescr: t.settings.lang_descr,
              items: [
                SelectItem(value: 'es', label: 'Español'),
                SelectItem(value: 'en', label: 'English'),
                SelectItem(value: 'uk', label: 'українська'),
              ],
              selected: LocaleSettings.currentLocale.languageTag,
              onChanged: (value) {
                LocaleSettings.setLocaleRaw(value, listenToDeviceLocale: true);

                UserSettingService.instance
                    .setSetting(SettingKey.appLanguage, value)
                    .then((value) => null);
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
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.amoledMode)
                    .map((event) => event == '1'),
                initialData: true,
                builder: (context, snapshot) {
                  return SwitchListTile(
                    title: Text(t.settings.amoled_mode),
                    subtitle: Text(t.settings.amoled_mode_descr),
                    value: snapshot.data!,
                    onChanged: Theme.of(context).brightness == Brightness.light
                        ? null
                        : (bool value) {
                            setState(() {
                              UserSettingService.instance.setSetting(
                                  SettingKey.amoledMode, value ? '1' : '0');
                            });
                          },
                  );
                }),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.accentColor)
                    .map((event) => event == 'auto'),
                initialData: true,
                builder: (context, snapshot) {
                  return SwitchListTile(
                    title: Text(t.settings.dynamic_colors),
                    subtitle: Text(t.settings.dynamic_colors_descr),
                    value: snapshot.data!,
                    onChanged: (bool value) {
                      setState(() {
                        UserSettingService.instance.setSetting(
                            SettingKey.accentColor,
                            value
                                ? 'auto'
                                : brandBlue.toHex(leadingHashSign: false));
                      });
                    },
                  );
                }),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.accentColor),
                initialData: 'auto',
                builder: (context, snapshot) {
                  late final Color color;

                  if (snapshot.data! == 'auto') {
                    color = AppColors.of(context).primary;
                  } else {
                    color = ColorHex.get(snapshot.data!);
                  }

                  return Tappable(
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
                    child: ListTile(
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
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

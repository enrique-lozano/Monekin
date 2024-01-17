import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/widgets/color_picker.dart';
import 'package:monekin/core/utils/color_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

import '../../core/presentation/app_colors.dart';

@RoutePage()
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

  final ExpansionTileController expTileController = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.general.appearance),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(context, t.settings.lang),
            buildSelector(
              title: t.settings.lang,
              dialogDescr: t.settings.lang_descr,
              items: [
                SelectItem(value: 'es', label: t.lang.es),
                SelectItem(value: 'en', label: t.lang.en)
              ],
              selected: LocaleSettings.currentLocale.languageTag,
              onChanged: (value) {
                LocaleSettings.setLocaleRaw(value, listenToDeviceLocale: true);

                UserSettingService.instance
                    .setSetting(SettingKey.appLanguage, value)
                    .then((value) => null);
              },
            ),
            createListSeparator(context, t.settings.general.app_colors),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSetting(SettingKey.themeMode),
                builder: (context, snapshot) {
                  return buildSelector(
                    title: t.settings.general.theme,
                    items: [
                      SelectItem(
                          value: 'system',
                          label: t.settings.general.theme_auto),
                      SelectItem(
                          value: 'light',
                          label: t.settings.general.theme_light),
                      SelectItem(
                          value: 'dark', label: t.settings.general.theme_dark)
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
                    title: Text(t.settings.general.amoled_mode),
                    subtitle: Text(t.settings.general.amoled_mode_descr),
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
                    title: Text(t.settings.general.dynamic_colors),
                    subtitle: Text(t.settings.general.dynamic_colors_descr),
                    value: snapshot.data!,
                    onChanged: (bool value) {
                      if (value) {
                        expTileController.collapse();
                      }

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

                  return IgnorePointer(
                    ignoring: snapshot.data! == 'auto',

                    // For some reason Flutter decided to put an enabled attribute in the
                    // ListTile but not in the ExpansionTile, so we have to do this to
                    // simulate this behaviour.

                    // TODO: Track issue https://github.com/flutter/flutter/issues/135770 to refactor this code

                    child: Opacity(
                      opacity: snapshot.data! == 'auto' ? 0.4 : 1,
                      child: ExpansionTile(
                        title: Text(t.settings.general.accent_color),
                        subtitle: Text(t.settings.general.accent_color_descr),
                        controller: expTileController,
                        trailing: SizedBox(
                          height: 46,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        children: [
                          ColorPicker(
                            colorOptions: [
                              brandBlue.toHex(leadingHashSign: false),
                              ...colorOptions
                            ],
                            selectedColor: color.toHex(),
                            onColorSelected: (selectedColor) {
                              setState(() {
                                UserSettingService.instance.setSetting(
                                    SettingKey.accentColor, selectedColor);
                              });
                            },
                          ),
                        ],
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

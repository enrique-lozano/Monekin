import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/i18n/translations.g.dart';

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
        title: Text(t.settings.general.other),
      ),
      body: Column(
        children: [
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
          const Divider(),
          StreamBuilder(
              stream:
                  UserSettingService.instance.getSetting(SettingKey.themeMode),
              builder: (context, snapshot) {
                return buildSelector(
                  title: t.settings.general.theme,
                  items: [
                    SelectItem(value: 'system', label: 'Auto'),
                    SelectItem(
                        value: 'light', label: t.settings.general.theme_light),
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
          const Divider(),
          StreamBuilder(
              stream: UserSettingService.instance
                  .getSetting(SettingKey.transactionMobileMode),
              builder: (context, snapshot) {
                bool isActive = snapshot.data == '1';

                return SwitchListTile(
                  title: Text(t.settings.general.prefer_calc),
                  subtitle: Text(t.settings.general.prefer_calc_descr),
                  value: isActive,
                  onChanged: (bool value) {
                    setState(() {
                      UserSettingService.instance.setSetting(
                          SettingKey.transactionMobileMode,
                          isActive ? '0' : '1');
                    });
                  },
                );
              })
        ],
      ),
    );
  }
}

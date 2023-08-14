import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/i18n/translations.g.dart';

class AdvancedSettingsPage extends StatefulWidget {
  const AdvancedSettingsPage({super.key});

  @override
  State<AdvancedSettingsPage> createState() => _AdvancedSettingsPageState();
}

class _AdvancedSettingsPageState extends State<AdvancedSettingsPage> {
  Widget buildSelector(
      {required String title, required DropdownButton dropdown}) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(title)),
          Flexible(
            child: DropdownButtonHideUnderline(
              child: dropdown,
            ),
          )
        ],
      ),
    );
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
              dropdown: DropdownButton(
                items: [
                  DropdownMenuItem(value: 'es', child: Text(t.lang.es)),
                  DropdownMenuItem(value: 'en', child: Text(t.lang.en))
                ],
                value: LocaleSettings.currentLocale.languageTag,
                underline: const SizedBox(),
                onChanged: (value) {
                  if (value == null) return;

                  LocaleSettings.setLocaleRaw(value,
                      listenToDeviceLocale: true);

                  UserSettingService.instance
                      .setSetting(SettingKey.appLanguage, value)
                      .then((value) => null);
                },
              )),
          const Divider(),
          StreamBuilder(
              stream:
                  UserSettingService.instance.getSetting(SettingKey.themeMode),
              builder: (context, snapshot) {
                return buildSelector(
                    title: t.settings.general.theme,
                    dropdown: DropdownButton(
                      items: [
                        const DropdownMenuItem(
                            value: 'system', child: Text('Auto')),
                        DropdownMenuItem(
                            value: 'light',
                            child: Text(t.settings.general.theme_light)),
                        DropdownMenuItem(
                            value: 'dark',
                            child: Text(t.settings.general.theme_dark))
                      ],
                      value: snapshot.data ?? 'system',
                      underline: const SizedBox(),
                      onChanged: (value) {
                        if (value == null) return;

                        UserSettingService.instance
                            .setSetting(SettingKey.themeMode, value)
                            .then((value) => null);
                      },
                    ));
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

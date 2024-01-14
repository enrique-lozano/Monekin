import 'package:drift/drift.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/routes/app_router.dart';
import 'package:monekin/core/utils/scroll_behavior_override.dart';
import 'package:monekin/i18n/translations.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MonekinAppEntryPoint());
}

class MonekinAppEntryPoint extends StatelessWidget {
  const MonekinAppEntryPoint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print("------------------ APP ENTRY POINT ------------------");

    return StreamBuilder(
        stream: UserSettingService.instance.getSettings((p0) =>
            p0.settingKey.equalsValue(SettingKey.appLanguage) |
            p0.settingKey.equalsValue(SettingKey.themeMode) |
            p0.settingKey.equalsValue(SettingKey.amoledMode) |
            p0.settingKey.equalsValue(SettingKey.accentColor)),
        builder: (context, snapshot) {
          print('Finding initial user settings...');

          if (!snapshot.hasData) {
            return Container();
          }

          final userSettings = snapshot.data!;

          final lang = userSettings
              .firstWhere(
                  (element) => element.settingKey == SettingKey.appLanguage)
              .settingValue;

          if (lang != null) {
            print('App language found. Setting the locale to `$lang`...');
            LocaleSettings.setLocaleRaw(lang);
          } else {
            print(
                'App language not found. Setting the user device language...');

            LocaleSettings.useDeviceLocale();

            // We have nothing to worry here since the useDeviceLocale() func will set the default lang (english in our case) if
            // the user is using a non-supported language in his device

            UserSettingService.instance
                .setSetting(
                  SettingKey.appLanguage,
                  LocaleSettings.currentLocale.languageTag,
                )
                .then((value) => null);
          }

          return TranslationProvider(
            child: MaterialAppContainer(
              amoledMode: userSettings
                      .firstWhere((element) =>
                          element.settingKey == SettingKey.amoledMode)
                      .settingValue! ==
                  '1',
              accentColor: userSettings
                  .firstWhere(
                      (element) => element.settingKey == SettingKey.accentColor)
                  .settingValue!,
              themeMode: ThemeMode.values.byName(userSettings
                  .firstWhere(
                      (element) => element.settingKey == SettingKey.themeMode)
                  .settingValue!),
            ),
          );
        });
  }
}

final _appRouter = AppRouter();

class MaterialAppContainer extends StatelessWidget {
  const MaterialAppContainer(
      {super.key,
      required this.themeMode,
      required this.accentColor,
      required this.amoledMode});

  final ThemeMode themeMode;
  final String accentColor;
  final bool amoledMode;

  @override
  Widget build(BuildContext context) {
    // Get the language of the Intl in each rebuild of the TranslationProvider:
    Intl.defaultLocale = LocaleSettings.currentLocale.languageTag;

    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp.router(
        title: 'Monekin',
        debugShowCheckedModeBanner: false,
        locale: TranslationProvider.of(context).flutterLocale,
        scrollBehavior: ScrollBehaviorOverride(),
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: getThemeData(context,
            isDark: false,
            amoledMode: amoledMode,
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            accentColor: accentColor),
        darkTheme: getThemeData(context,
            isDark: true,
            amoledMode: amoledMode,
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            accentColor: accentColor),
        themeMode: themeMode,
        routerConfig: _appRouter.config(),
      );
    });
  }
}

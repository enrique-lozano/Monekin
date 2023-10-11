import 'package:drift/drift.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/home/home.page.dart';
import 'package:monekin/app/onboarding/intro.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:rxdart/rxdart.dart';

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

    return ProviderScope(
      child: StreamBuilder(
          stream: Rx.combineLatest2(
              UserSettingService.instance.getSettings((p0) =>
                  p0.settingKey.equalsValue(SettingKey.appLanguage) |
                  p0.settingKey.equalsValue(SettingKey.themeMode) |
                  p0.settingKey.equalsValue(SettingKey.amoledMode) |
                  p0.settingKey.equalsValue(SettingKey.accentColor)),
              AppDataService.instance
                  .getAppDataItems((p0) => AppDB.instance.buildExpr([])),
              (a, b) => (a, b)),
          builder: (context, snapshot) {
            print('Finding initial user settings...');

            if (!snapshot.hasData) {
              return Container();
            }

            final userSettings = snapshot.data!.$1;
            final appDataItems = snapshot.data!.$2;

            final lang = userSettings
                .firstWhere(
                    (element) => element.settingKey == SettingKey.appLanguage)
                .settingValue;

            if (lang != null) {
              print('App language found. Setting the locale to `$lang`...');
              LocaleSettings.setLocaleRaw(lang);
            } else {
              print('App language found. Setting the user device language...');
              LocaleSettings.useDeviceLocale();
              UserSettingService.instance
                  .setSetting(
                    SettingKey.appLanguage,
                    LocaleSettings.currentLocale.languageTag,
                  )
                  .then((value) => null);
            }

            final userHasSeenIntro = appDataItems
                .firstWhere(
                  (element) => element.appDataKey == AppDataKey.introSeen,
                )
                .appDataValue;

            return TranslationProvider(
              child: MaterialAppContainer(
                goToIntro: userHasSeenIntro != '1',
                amoledMode: userSettings
                        .firstWhere((element) =>
                            element.settingKey == SettingKey.amoledMode)
                        .settingValue! ==
                    '1',
                accentColor: userSettings
                    .firstWhere((element) =>
                        element.settingKey == SettingKey.accentColor)
                    .settingValue!,
                themeMode: ThemeMode.values.byName(userSettings
                    .firstWhere(
                        (element) => element.settingKey == SettingKey.themeMode)
                    .settingValue!),
              ),
            );
          }),
    );
  }
}

class MaterialAppContainer extends StatelessWidget {
  const MaterialAppContainer(
      {super.key,
      required this.themeMode,
      required this.goToIntro,
      required this.accentColor,
      required this.amoledMode});

  final ThemeMode themeMode;
  final bool goToIntro;
  final String accentColor;
  final bool amoledMode;

  @override
  Widget build(BuildContext context) {
    // Get the language of the Intl in each rebuild of the TranslationProvider:
    Intl.defaultLocale = LocaleSettings.currentLocale.languageTag;

    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
          title: 'Monekin',
          debugShowCheckedModeBanner: false,
          locale: TranslationProvider.of(context).flutterLocale,
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
          home: Builder(builder: (context) {
            if (!goToIntro) {
              return const HomePage();
            } else {
              return const IntroPage();
            }
          }));
    });
  }
}

import 'package:drift/drift.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/layout/navigation_sidebar.dart';
import 'package:monekin/app/layout/tabs.dart';
import 'package:monekin/app/onboarding/intro.page.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/routes/root_navigator_observer.dart';
import 'package:monekin/core/utils/scroll_behavior_override.dart';
import 'package:monekin/i18n/translations.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrivateModeService.instance.initializePrivateMode();

  LocaleSettings.useDeviceLocale(); // and this

  runApp(const MonekinAppEntryPoint());
}

final GlobalKey<TabsPageState> tabsPageKey = GlobalKey();
final GlobalKey<NavigationSidebarState> navigationSidebarKey = GlobalKey();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
            child: StreamBuilder(
                stream: AppDataService.instance
                    .getAppDataItem(AppDataKey.introSeen)
                    .map((event) => event == '1'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  return MaterialAppContainer(
                    introSeen: snapshot.data!,
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
                        .firstWhere((element) =>
                            element.settingKey == SettingKey.themeMode)
                        .settingValue!),
                  );
                }),
          );
        });
  }
}

int refresh = 1;

class MaterialAppContainer extends StatelessWidget {
  const MaterialAppContainer(
      {super.key,
      required this.themeMode,
      required this.accentColor,
      required this.amoledMode,
      required this.introSeen});

  final ThemeMode themeMode;
  final String accentColor;
  final bool amoledMode;

  final bool introSeen;

  @override
  Widget build(BuildContext context) {
    // Get the language of the Intl in each rebuild of the TranslationProvider:
    Intl.defaultLocale = LocaleSettings.currentLocale.languageTag;

    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        title: 'Parsa',
        key: ValueKey(refresh),
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
        navigatorKey: navigatorKey,
        navigatorObservers: [MainLayoutNavObserver()],
        builder: (context, child) {
          return Overlay(initialEntries: [
            OverlayEntry(
              builder: (context) => Stack(
                children: [
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeInOutCubicEmphasized,
                        width:
                            introSeen ? getNavigationSidebarWidth(context) : 0,
                        color: Theme.of(context).canvasColor,
                      ),
                      if (BreakPoint.of(context).isLargerThan(BreakpointID.sm))
                        Container(
                          width: 2,
                          height: MediaQuery.of(context).size.height,
                          color: Theme.of(context).dividerColor,
                        ),
                      Expanded(child: child ?? const SizedBox.shrink()),
                    ],
                  ),
                  if (introSeen) NavigationSidebar(key: navigationSidebarKey)
                ],
              ),
            ),
          ]);
        },
        home: introSeen ? TabsPage(key: tabsPageKey) : const IntroPage(),
      );
    });
  }
}

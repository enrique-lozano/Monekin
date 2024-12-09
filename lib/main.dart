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
import 'package:monekin/core/database/services/user-setting/utils/get_theme_from_string.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/routes/root_navigator_observer.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/scroll_behavior_override.dart';
import 'package:monekin/i18n/translations.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSettingService.instance.initializeGlobalStateMap();
  await AppDataService.instance.initializeGlobalStateMap();

  PrivateModeService.instance
      .setPrivateMode(appStateSettings[SettingKey.privateModeAtLaunch] == '1');

  runApp(InitializeApp(key: appStateKey));
}

final GlobalKey<TabsPageState> tabsPageKey = GlobalKey();
final GlobalKey<NavigationSidebarState> navigationSidebarKey = GlobalKey();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ignore: library_private_types_in_public_api
GlobalKey<_InitializeAppState> appStateKey = GlobalKey();

class InitializeApp extends StatefulWidget {
  const InitializeApp({super.key});

  @override
  State<InitializeApp> createState() => _InitializeAppState();
}

class _InitializeAppState extends State<InitializeApp> {
  void refreshAppState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MonekinAppEntryPoint(key: const ValueKey('App Entry Point'));
  }
}

class MonekinAppEntryPoint extends StatelessWidget {
  const MonekinAppEntryPoint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Logger.printDebug('------------------ APP ENTRY POINT ------------------');

    final lang = appStateSettings[SettingKey.appLanguage];

    if (lang != null) {
      Logger.printDebug('App language found. Setting the locale to `$lang`...');
      LocaleSettings.setLocaleRaw(lang);
    } else {
      Logger.printDebug(
          'App language not found. Setting the user device language...');

      LocaleSettings.useDeviceLocale();

      // We have nothing to worry here since the useDeviceLocale() func will set the default lang (english in our case) if
      // the user is using a non-supported language in his device

      UserSettingService.instance
          .setItem(
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
              amoledMode: appStateSettings[SettingKey.amoledMode]! == '1',
              accentColor: appStateSettings[SettingKey.accentColor]!,
              themeMode:
                  getThemeFromString(appStateSettings[SettingKey.themeMode]!),
            );
          }),
    );
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
        title: 'Monekin',
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

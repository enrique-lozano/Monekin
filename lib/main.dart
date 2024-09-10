import 'package:drift/drift.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:parsa/app/layout/navigation_sidebar.dart';
import 'package:parsa/app/layout/tabs.dart';
import 'package:parsa/app/onboarding/intro.page.dart';
import 'package:parsa/core/database/services/app-data/app_data_service.dart';
import 'package:parsa/core/database/services/user-setting/private_mode_service.dart';
import 'package:parsa/core/database/services/user-setting/user_setting_service.dart';
import 'package:parsa/core/presentation/responsive/breakpoints.dart';
import 'package:parsa/core/presentation/theme.dart';
import 'package:parsa/core/routes/root_navigator_observer.dart';
import 'package:parsa/core/utils/scroll_behavior_override.dart';
import 'package:parsa/i18n/translations.g.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:parsa/core/services/auth/auth_service.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await PrivateModeService.instance.initializePrivateMode();

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
    print('------------------ APP ENTRY POINT ------------------');

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

class MaterialAppContainer extends StatefulWidget {
  const MaterialAppContainer({
    super.key,
    required this.themeMode,
    required this.accentColor,
    required this.amoledMode,
    required this.introSeen,
  });

  final ThemeMode themeMode;
  final String accentColor;
  final bool amoledMode;
  final bool introSeen;

  @override
  _MaterialAppContainerState createState() => _MaterialAppContainerState();
}

class _MaterialAppContainerState extends State<MaterialAppContainer> {
  late Auth0 auth0;
  bool isLoggedIn = false;
  bool isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    _initAuth0();
    _checkLoginStatus(); // Check if user is logged in
  }

  // Initialize Auth0
  void _initAuth0() {
    auth0 = Auth0(
      dotenv.env['AUTH0_DOMAIN']!,
      dotenv.env['AUTH0_CLIENT_ID']!,
    );
  }

  // Check if the user is logged in
  Future<void> _checkLoginStatus() async {
    try {
      // Check if the device is online
      final isOnline = await _checkInternetConnection();

      if (isOnline) {
        // If online, validate the token (or refresh it if necessary)
        final credentials =
            await auth0.credentialsManager.hasValidCredentials();
        final isValid = await _validateToken(credentials as String);

        if (isValid) {
          setState(() {
            isLoggedIn = true;
            isLoading = false;
          });
        } else {
          // Token invalid, need to re-login
          await _performLogout(); // Optionally log them out
          setState(() {
            isLoggedIn = false;
            isLoading = false;
          });
        }
      } else {
        // Offline: Let the user in if we have stored credentials
        final hasStoredCredentials =
            await auth0.credentialsManager.hasValidCredentials();
        setState(() {
          isLoggedIn = hasStoredCredentials;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });
      print('Error checking login status: $e');
    }
  }

  // Check internet connectivity
  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
          'example.com'); // Arbitrary address to check connectivity
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false; // No internet connection
    }
  }

  // Validate the access token (e.g., by checking expiration)
  Future<bool> _validateToken(String accessToken) async {
    try {
      // Example: You can decode the token and check expiration or make an API call to validate it.
      // You can make a call to Auth0's token introspection or a call to your backend to validate.
      // This is a simple token validation skeleton:
      final response = await auth0.credentialsManager.hasValidCredentials();
      return response != null;
    } catch (e) {
      print('Token validation failed: $e');
      return false; // Assume invalid if there's an error
    }
  }

  // Perform logout (if necessary)
  Future<void> _performLogout() async {
    try {
      await auth0.credentialsManager
          .clearCredentials(); // Clear stored credentials
      await auth0.webAuthentication().logout(); // Perform Auth0 logout
    } catch (e) {
      print('Logout failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = LocaleSettings.currentLocale.languageTag;

    // Return a loading indicator while checking login status
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
          theme: getThemeData(
            context,
            isDark: false,
            amoledMode: widget.amoledMode,
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            accentColor: widget.accentColor,
          ),
          darkTheme: getThemeData(
            context,
            isDark: true,
            amoledMode: widget.amoledMode,
            lightDynamic: lightDynamic,
            darkDynamic: darkDynamic,
            accentColor: widget.accentColor,
          ),
          themeMode: widget.themeMode,
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
                          width: widget.introSeen
                              ? getNavigationSidebarWidth(context)
                              : 0,
                          color: Theme.of(context).canvasColor,
                        ),
                        if (BreakPoint.of(context)
                            .isLargerThan(BreakpointID.sm))
                          Container(
                            width: 2,
                            height: MediaQuery.of(context).size.height,
                            color: Theme.of(context).dividerColor,
                          ),
                        Expanded(child: child ?? const SizedBox.shrink()),
                      ],
                    ),
                    if (widget.introSeen)
                      NavigationSidebar(key: navigationSidebarKey)
                  ],
                ),
              ),
            ]);
          },
          home: widget.introSeen
              ? (isLoggedIn
                  ? const TabsPage()
                  : Auth0LoginPage(
                      auth0:
                          auth0)) // Show home if logged in, otherwise show login
              : const IntroPage(),
        );
      },
    );
  }
}

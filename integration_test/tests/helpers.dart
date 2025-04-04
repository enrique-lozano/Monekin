import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:monekin/app/home/dashboard.page.dart';
import 'package:monekin/app/onboarding/onboarding.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:monekin/main.dart';

Future<void> setupMonekin() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await UserSettingService.instance.initializeGlobalStateMap();
  await AppDataService.instance.initializeGlobalStateMap();
}

Future<void> startMonekin(WidgetTester tester) async {
  await tester.pumpWidget(const MonekinAppEntryPoint());
  await tester.pumpAndSettle();
  expect(find.byType(MonekinAppEntryPoint), findsOneWidget);
  await tester.tap(find.text(t.intro.offline_start));

  await tester.pumpAndSettle();
  expect(find.byType(OnboardingPage), findsOneWidget);
  await tester.tap(find.text(t.intro.skip));

  await tester.pumpAndSettle();
  expect(find.byType(DashboardPage), findsOneWidget);

  await LocaleSettings.setLocale(AppLocale.en, listenToDeviceLocale: true);
}

Future<void> openMorePage(WidgetTester tester) async {
  await tester.tap(find.text(t.more.title));
  await tester.pumpAndSettle();

  expect(find.byType(SettingsPage), findsOneWidget);
}

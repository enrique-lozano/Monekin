import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/app_colors.dart';

/// Names of the generated images. The number sets the order in the stores.
enum ScreenshotName {
  dashboard('01_dashboard'),
  transactions('02_transactions'),
  stats('03_stats'),
  budgets('04_budgets'),
  budgetDetails('05_budget_details'),
  subscriptions('06_subscriptions'),
  exchangeRate('07_exchange_rate'),
  formIncome('08_form_income'),
  formExpense('09_form_expense'),
  formTransfer('10_form_transfer');

  const ScreenshotName(this.fileName);

  final String fileName;
}

/// Look of the app in a capture. [id] is appended to the file name.
class ScreenshotStyle {
  const ScreenshotStyle(
    this.id, {
    required this.themeMode,
    required this.accent,
    this.amoled = false,
  });

  final String id;

  /// `light` or `dark`.
  final String themeMode;

  /// Hex color. Never `auto`: dynamic colors depend on the device wallpaper.
  final String accent;

  final bool amoled;
}

/// Settings of the screenshot generation. Edit the values here.
abstract final class ScreenshotConfig {
  /// Comma-separated locale tags to capture. Set via
  /// `--dart-define=SCREENSHOT_LOCALES=en,es` from `generate_screenshots.bat`.
  static const localesArg = String.fromEnvironment(
    'SCREENSHOT_LOCALES',
    defaultValue: 'en',
  );

  /// Comma-separated style ids to capture, or `all`. Set via the `STYLES` env
  /// var of `generate_screenshots.bat`.
  static const stylesArg = String.fromEnvironment(
    'SCREENSHOT_STYLES',
    defaultValue: 'all',
  );

  /// Every screen is captured in these. The first one keeps the plain file
  /// name (`01_dashboard.png`), the rest get their id as suffix.
  static final fullSetStyles = [
    ScreenshotStyle('light', themeMode: 'light', accent: brandBlue.toHex()),
    // ScreenshotStyle('dark', themeMode: 'dark', accent: brandBlue.toHex()),
  ];

  /// Only the dashboard is captured in these, to show the accent colors.
  static const dashboardOnlyStyles = [
    ScreenshotStyle('light_green', themeMode: 'light', accent: '388E3C'),
    ScreenshotStyle('dark_purple', themeMode: 'dark', accent: '8E24AA'),
    ScreenshotStyle(
      'dark_amoled_orange',
      themeMode: 'dark',
      accent: 'FB8C00',
      amoled: true,
    ),
  ];

  /// Platform the app behaves as. `android` hides the desktop window bar and
  /// the scrollbars; `windows` shows them.
  static const simulatedPlatform = TargetPlatform.android;

  /// Phone viewport used when the host is a desktop (physical pixels).
  static const phoneSize = Size(1080, 2208);
  static const double phonePixelRatio = 3;
}

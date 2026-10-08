import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// Names of the generated images. The number sets the order in the stores.
enum ScreenshotName {
  dashboard('01_dashboard'),
  transactions('02_transactions'),
  stats('03_stats'),
  budgets('04_budgets'),
  budgetDetails('05_budget_details'),
  subscriptions('06_subscriptions'),
  exchangeRate('07_exchange_rate');

  const ScreenshotName(this.fileName);

  final String fileName;
}

/// Settings of the screenshot generation. Edit the values here.
abstract final class ScreenshotConfig {
  /// Comma-separated locale tags to capture. Set via
  /// `--dart-define=SCREENSHOT_LOCALES=en,es` from `generate_screenshots.bat`.
  static const localesArg = String.fromEnvironment(
    'SCREENSHOT_LOCALES',
    defaultValue: 'en',
  );

  /// Platform the app behaves as. `android` hides the desktop window bar and
  /// the scrollbars; `windows` shows them.
  static const simulatedPlatform = TargetPlatform.android;

  /// Phone viewport used when the host is a desktop (physical pixels).
  static const phoneSize = Size(1080, 2208);
  static const phonePixelRatio = 2.625;
}

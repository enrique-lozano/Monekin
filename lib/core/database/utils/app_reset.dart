import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/category/category_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/user-setting/default_transaction_values.service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/utils/demo_app_seeders.dart';

/// Leaves the app as in a fresh install: deletes all the user data, restores
/// the initial categories, currencies, settings and app data, so the onboarding
/// is shown again. The language and appearance settings are only restored if
/// [resetAppearance] is `true`.
Future<void> resetApp({required bool resetAppearance}) async {
  final db = AppDB.instance;

  await db.transaction(() async {
    await deleteAllUserData();

    await db.delete(db.categories).go();
    await db.delete(db.currencies).go();

    await CategoryService.instance.initializeCategories();
    await CurrencyService.instance.initializeCurrencies();
  });

  DefaultTransactionValuesService.lastCreatedTransaction.value = null;

  await UserSettingService.instance.resetSettings(
    includeAppearance: resetAppearance,
  );
  await AppDataService.instance.resetAppData();
}

import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/shared/key_value_pair.dart';
import 'package:monekin/core/database/services/shared/key_value_service.dart';

/// The keys of the avalaible settings of the app
enum SettingKey {
  preferredCurrency,
  userName,
  avatar,

  /// Text font to be used across the entire app. It's a string representing
  /// the font index in the font list, or `null` to use the platform font.
  font,

  /// User preferred language (locale) for the app. It's a string representing the locale languageTag, like "en", "zh-TW"...
  /// If `null`, the app will use the device locale, or the fallback locale if the device locale is not supported.
  appLanguage,

  /// Key to storage if the user will enter in the "private mode" when the app launches.
  privateModeAtLaunch,

  /// Key to storage the app theme. Could be 'system', 'light' or 'dark'
  themeMode,

  /// Key to storage the app accentColor. It's a string representing the color in HEX format (without the `#`) or the string 'auto' to apply dynamic colors if possible (if not possible will default to the Monekin blue brand color)
  accentColor,

  /// Key to storage if the user have the AMOLED mode activated. Could be '1' (true) or '0' (false)
  amoledMode,

  transactionSwipeLeftAction,
  transactionSwipeRightAction,

  /// Default transaction type, "E", "I" or "T" as defined in the [TransactionType] enum.
  /// The default is "E" (Expense)
  defaultTransactionType,

  /// Json string representing the default values to be used when creating a new transaction
  /// Each value could be `null` to use no default value for that field
  defaultTransactionValues,

  /// List of fields that should use the last used value when creating a new transaction.
  /// Stored as a JSON list of strings (names of [TransactionFormField] enum).
  fieldsToUseLastUsedValue,

  /// Whether to show all decimals places even if there are trailing zeros
  showAllDecimals,

  /// Whether to show the tags of the transaction in the transaction list tiles
  transactionTileShowTags,

  /// Wheter to show the time of the transaction in the transaction list tiles
  transactionTileShowTime,
}

final Map<SettingKey, String?> appStateSettings = {};

class UserSettingService
    extends KeyValueService<SettingKey, UserSettings, UserSetting> {
  UserSettingService._(AppDB db)
    : super(
        db: db,
        table: db.userSettings,
        globalStateMap: appStateSettings,
        rowToKeyPairInstance: (row) => KeyValuePairInDB.fromUserSetting(row),
        toDbRow: (x) => x.toUserSetting(),
      );

  static final UserSettingService _instance = UserSettingService._(
    AppDB.instance,
  );
  static UserSettingService get instance => _instance;

  Stream<String?> getSettingFromDB(SettingKey settingKey) {
    return (db.select(db.userSettings)
          ..where((tbl) => tbl.settingKey.equalsValue(settingKey)))
        .map((e) => e.settingValue)
        .watchSingleOrNull();
  }
}

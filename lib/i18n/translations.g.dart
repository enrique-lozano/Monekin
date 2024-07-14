/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 3
/// Strings: 1579 (526 per locale)
///
/// Built on 2024-05-02 at 14:20 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';

export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
  en(languageCode: 'en', build: Translations.build),
  es(languageCode: 'es', build: _TranslationsEs.build),
  uk(languageCode: 'uk', build: _TranslationsUk.build);

  const AppLocale(
      {required this.languageCode,
      this.scriptCode,
      this.countryCode,
      required this.build}); // ignore: unused_element

  @override
  final String languageCode;
  @override
  final String? scriptCode;
  @override
  final String? countryCode;
  @override
  final TranslationBuilder<AppLocale, Translations> build;

  /// Gets current instance managed by [LocaleSettings].
  Translations get translations =>
      LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider
    extends BaseTranslationProvider<AppLocale, Translations> {
  TranslationProvider({required super.child})
      : super(settings: LocaleSettings.instance);

  static InheritedLocaleData<AppLocale, Translations> of(
          BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
  Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings
    extends BaseFlutterLocaleSettings<AppLocale, Translations> {
  LocaleSettings._() : super(utils: AppLocaleUtils.instance);

  static final instance = LocaleSettings._();

  // static aliases (checkout base methods for documentation)
  static AppLocale get currentLocale => instance.currentLocale;
  static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
  static AppLocale setLocale(AppLocale locale,
          {bool? listenToDeviceLocale = false}) =>
      instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
  static AppLocale setLocaleRaw(String rawLocale,
          {bool? listenToDeviceLocale = false}) =>
      instance.setLocaleRaw(rawLocale,
          listenToDeviceLocale: listenToDeviceLocale);
  static AppLocale useDeviceLocale() => instance.useDeviceLocale();
  @Deprecated('Use [AppLocaleUtils.supportedLocales]')
  static List<Locale> get supportedLocales => instance.supportedLocales;
  @Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]')
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
  static void setPluralResolver(
          {String? language,
          AppLocale? locale,
          PluralResolver? cardinalResolver,
          PluralResolver? ordinalResolver}) =>
      instance.setPluralResolver(
        language: language,
        locale: locale,
        cardinalResolver: cardinalResolver,
        ordinalResolver: ordinalResolver,
      );
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
  AppLocaleUtils._()
      : super(baseLocale: _baseLocale, locales: AppLocale.values);

  static final instance = AppLocaleUtils._();

  // static aliases (checkout base methods for documentation)
  static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
  static AppLocale parseLocaleParts(
          {required String languageCode,
          String? scriptCode,
          String? countryCode}) =>
      instance.parseLocaleParts(
          languageCode: languageCode,
          scriptCode: scriptCode,
          countryCode: countryCode);
  static AppLocale findDeviceLocale() => instance.findDeviceLocale();
  static List<Locale> get supportedLocales => instance.supportedLocales;
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// context enums

enum GenderContext {
  male,
  female,
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations.build(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.en,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  // Translations
  late final _TranslationsGeneralEn general = _TranslationsGeneralEn._(_root);
  late final _TranslationsIntroEn intro = _TranslationsIntroEn._(_root);
  late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
  late final _TranslationsFinancialHealthEn financial_health =
      _TranslationsFinancialHealthEn._(_root);
  late final _TranslationsStatsEn stats = _TranslationsStatsEn._(_root);
  late final _TranslationsIconSelectorEn icon_selector =
      _TranslationsIconSelectorEn._(_root);
  late final _TranslationsTransactionEn transaction =
      _TranslationsTransactionEn._(_root);
  late final _TranslationsTransferEn transfer =
      _TranslationsTransferEn._(_root);
  late final _TranslationsRecurrentTransactionsEn recurrent_transactions =
      _TranslationsRecurrentTransactionsEn._(_root);
  late final _TranslationsAccountEn account = _TranslationsAccountEn._(_root);
  late final _TranslationsCurrenciesEn currencies =
      _TranslationsCurrenciesEn._(_root);
  late final _TranslationsTagsEn tags = _TranslationsTagsEn._(_root);
  late final _TranslationsCategoriesEn categories =
      _TranslationsCategoriesEn._(_root);
  late final _TranslationsBudgetsEn budgets = _TranslationsBudgetsEn._(_root);
  late final _TranslationsBackupEn backup = _TranslationsBackupEn._(_root);
  late final _TranslationsSettingsEn settings =
      _TranslationsSettingsEn._(_root);
  late final _TranslationsMoreEn more = _TranslationsMoreEn._(_root);
}

// Path: general
class _TranslationsGeneralEn {
  _TranslationsGeneralEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get cancel => 'Cancel';
  String get or => 'or';
  String get understood => 'Understood';
  String get unspecified => 'Unspecified';
  String get confirm => 'Confirm';
  String get continue_text => 'Continue';
  String get quick_actions => 'Quick actions';
  String get save => 'Save';
  String get save_changes => 'Save changes';
  String get close_and_save => 'Save and close';
  String get add => 'Add';
  String get edit => 'Edit';
  String get balance => 'Balance';
  String get delete => 'Delete';
  String get account => 'Account';
  String get accounts => 'Accounts';
  String get categories => 'Categories';
  String get category => 'Category';
  String get today => 'Today';
  String get yesterday => 'Yesterday';
  String get filters => 'Filters';
  String get select_all => 'Select all';
  String get deselect_all => 'Deselect all';
  String get empty_warn => 'Ops! This is very empty';
  String get insufficient_data => 'Insufficient data';
  String get show_more_fields => 'Show more fields';
  String get show_less_fields => 'Show less fields';
  late final _TranslationsGeneralClipboardEn clipboard =
      _TranslationsGeneralClipboardEn._(_root);
  late final _TranslationsGeneralTimeEn time =
      _TranslationsGeneralTimeEn._(_root);
  late final _TranslationsGeneralTransactionOrderEn transaction_order =
      _TranslationsGeneralTransactionOrderEn._(_root);
  late final _TranslationsGeneralValidationsEn validations =
      _TranslationsGeneralValidationsEn._(_root);
}

// Path: intro
class _TranslationsIntroEn {
  _TranslationsIntroEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get start => 'Start';
  String get skip => 'Skip';
  String get next => 'Next';
  String get select_your_currency => 'Select your currency';
  String get welcome_subtitle => 'Your personal finance manager';
  String get welcome_subtitle2 => '100% open, 100% free';
  String get welcome_footer =>
      'By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application';
  String get offline_descr_title => 'OFFLINE ACCOUNT:';
  String get offline_descr =>
      'Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';
  String get offline_start => 'Start session offline';
  String get sl1_title => 'Select your currency';
  String get sl1_descr =>
      'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings';
  String get sl2_title => 'Safe, private and reliable';
  String get sl2_descr =>
      'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet';
  String get sl2_descr2 =>
      'Also, the source code of the application is public, anyone can collaborate on it and see how it works';
  String get last_slide_title => 'All ready';
  String get last_slide_descr =>
      'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.';
  String get last_slide_descr2 =>
      'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...';
}

// Path: home
class _TranslationsHomeEn {
  _TranslationsHomeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Dashboard';
  String get filter_transactions => 'Filter transactions';
  String get hello_day => 'Good morning,';
  String get hello_night => 'Good night,';
  String get total_balance => 'Total balance';
  String get my_accounts => 'My accounts';
  String get active_accounts => 'Active accounts';
  String get no_accounts => 'No accounts created yet';
  String get no_accounts_descr =>
      'Start using all the magic of Monekin. Create at least one account to start adding transactions';
  String get last_transactions => 'Last transactions';
  String get should_create_account_header => 'Oops!';
  String get should_create_account_message =>
      'You must have at least one no-archived account before you can start creating transactions';
}

// Path: financial_health
class _TranslationsFinancialHealthEn {
  _TranslationsFinancialHealthEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Financial health';
  late final _TranslationsFinancialHealthReviewEn review =
      _TranslationsFinancialHealthReviewEn._(_root);
  late final _TranslationsFinancialHealthMonthsWithoutIncomeEn
      months_without_income =
      _TranslationsFinancialHealthMonthsWithoutIncomeEn._(_root);
  late final _TranslationsFinancialHealthSavingsPercentageEn
      savings_percentage =
      _TranslationsFinancialHealthSavingsPercentageEn._(_root);
}

// Path: stats
class _TranslationsStatsEn {
  _TranslationsStatsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Statistics';
  String get balance => 'Balance';
  String get final_balance => 'Final balance';
  String get balance_by_account => 'Balance by accounts';
  String get balance_by_currency => 'Balance by currency';
  String get cash_flow => 'Cash flow';
  String get balance_evolution => 'Balance evolution';
  String get compared_to_previous_period => 'Compared to the previous period';
  String get by_periods => 'By periods';
  String get by_categories => 'By categories';
  String get by_tags => 'By tags';
  String get distribution => 'Distribution';
  String get finance_health_resume => 'Resume';
  String get finance_health_breakdown => 'Breakdown';
}

// Path: icon_selector
class _TranslationsIconSelectorEn {
  _TranslationsIconSelectorEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get name => 'Name:';
  String get icon => 'Icon';
  String get color => 'Color';
  String get select_icon => 'Select an icon';
  String get select_color => 'Select a color';
  String get select_account_icon => 'Identify your account';
  String get select_category_icon => 'Identify your category';
  late final _TranslationsIconSelectorScopesEn scopes =
      _TranslationsIconSelectorScopesEn._(_root);
}

// Path: transaction
class _TranslationsTransactionEn {
  _TranslationsTransactionEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Transaction',
        other: 'Transactions',
      );
  String get create => 'New transaction';
  String get new_income => 'New income';
  String get new_expense => 'New expense';
  String get new_success => 'Transaction created successfully';
  String get edit => 'Edit transaction';
  String get edit_success => 'Transaction edited successfully';
  String get edit_multiple => 'Edit transactions';
  String edit_multiple_success({required Object x}) =>
      '${x} transactions edited successfully';
  String get duplicate => 'Clone transaction';
  String get duplicate_short => 'Clone';
  String get duplicate_warning_message =>
      'A transaction identical to this will be created with the same date, do you want to continue?';
  String get duplicate_success => 'Transaction cloned successfully';
  String get delete => 'Delete transaction';
  String get delete_warning_message =>
      'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';
  String get delete_success => 'Transaction deleted correctly';
  String get delete_multiple => 'Delete transactions';
  String delete_multiple_warning_message({required Object x}) =>
      'This action is irreversible and will remove ${x} transactions. The current balance of your accounts and all your statistics will be recalculated';
  String delete_multiple_success({required Object x}) =>
      '${x} transactions deleted correctly';
  String get details => 'Movement details';
  late final _TranslationsTransactionNextPaymentsEn next_payments =
      _TranslationsTransactionNextPaymentsEn._(_root);
  late final _TranslationsTransactionListEn list =
      _TranslationsTransactionListEn._(_root);
  late final _TranslationsTransactionFiltersEn filters =
      _TranslationsTransactionFiltersEn._(_root);
  late final _TranslationsTransactionFormEn form =
      _TranslationsTransactionFormEn._(_root);
  late final _TranslationsTransactionStatusEn status =
      _TranslationsTransactionStatusEn._(_root);
  late final _TranslationsTransactionTypesEn types =
      _TranslationsTransactionTypesEn._(_root);
}

// Path: transfer
class _TranslationsTransferEn {
  _TranslationsTransferEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Transfer';
  String get transfers => 'Transfers';
  String transfer_to({required Object account}) => 'Transfer to ${account}';
  String get create => 'New Transfer';
  String get need_two_accounts_warning_header => 'Ops!';
  String get need_two_accounts_warning_message =>
      'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
  late final _TranslationsTransferFormEn form =
      _TranslationsTransferFormEn._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsEn {
  _TranslationsRecurrentTransactionsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Recurrent transactions';
  String get title_short => 'Rec. transactions';
  String get empty =>
      'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
  String get total_expense_title => 'Total expense per period';
  String get total_expense_descr =>
      '* Without considering the start and end date of each recurrence';
  late final _TranslationsRecurrentTransactionsDetailsEn details =
      _TranslationsRecurrentTransactionsDetailsEn._(_root);
}

// Path: account
class _TranslationsAccountEn {
  _TranslationsAccountEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get details => 'Account details';
  String get date => 'Opening date';
  String get close_date => 'Closing date';
  String get reopen => 'Re-open account';
  String get reopen_short => 'Re-open';
  String get reopen_descr => 'Are you sure you want to reopen this account?';
  String get balance => 'Account balance';
  String get n_transactions => 'Number of transactions';
  String get add_money => 'Add money';
  String get withdraw_money => 'Withdraw money';
  String get no_accounts =>
      'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
  late final _TranslationsAccountTypesEn types =
      _TranslationsAccountTypesEn._(_root);
  late final _TranslationsAccountFormEn form =
      _TranslationsAccountFormEn._(_root);
  late final _TranslationsAccountDeleteEn delete =
      _TranslationsAccountDeleteEn._(_root);
  late final _TranslationsAccountCloseEn close =
      _TranslationsAccountCloseEn._(_root);
  late final _TranslationsAccountSelectEn select =
      _TranslationsAccountSelectEn._(_root);
}

// Path: currencies
class _TranslationsCurrenciesEn {
  _TranslationsCurrenciesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get currency_converter => 'Currency converter';
  String get currency => 'Currency';
  String get currency_manager => 'Currency manager';
  String get currency_manager_descr =>
      'Configure your currency and its exchange rates with others';
  String get preferred_currency => 'Preferred/base currency';
  String get change_preferred_currency_title => 'Change preferred currency';
  String get change_preferred_currency_msg =>
      'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?';
  late final _TranslationsCurrenciesFormEn form =
      _TranslationsCurrenciesFormEn._(_root);
  String get delete_all_success => 'Deleted exchange rates successfully';
  String get historical => 'Historical rates';
  String get exchange_rate => 'Exchange rate';
  String get exchange_rates => 'Exchange rates';
  String get empty =>
      'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate';
  String get select_a_currency => 'Select a currency';
  String get search_title => 'Tap to search';
  String get search_placeholder => 'Search by name or by currency code';
}

// Path: tags
class _TranslationsTagsEn {
  _TranslationsTagsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Label',
        other: 'Tags',
      );
  late final _TranslationsTagsFormEn form = _TranslationsTagsFormEn._(_root);
  String get empty_list =>
      'You haven\'t created any tags yet. Tags and categories are a great way to categorize your movements';
  String get without_tags => 'Without tags';
  String get select => 'Select tags';
  String get add => 'Add tag';
  String get create => 'Create label';
  String get create_success => 'Label created successfully';
  String get already_exists =>
      'This tag name already exists. You may want to edit it';
  String get edit => 'Edit tag';
  String get edit_success => 'Tag edited successfully';
  String get delete_success => 'Category deleted successfully';
  String get delete_warning_header => 'Delete tag?';
  String get delete_warning_message =>
      'This action will not delete transactions that have this tag.';
}

// Path: categories
class _TranslationsCategoriesEn {
  _TranslationsCategoriesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get unknown => 'Unknown category';
  String get create => 'Create category';
  String get create_success => 'Category created correctly';
  String get new_category => 'New category';
  String get already_exists =>
      'The name of this category already exists. Maybe you want to edit it';
  String get edit => 'Edit category';
  String get edit_success => 'Category edited correctly';
  String get name => 'Category name';
  String get type => 'Category type';
  String get both_types => 'Both types';
  String get subcategories => 'Subcategories';
  String get subcategories_add => 'Add subcategory';
  String get make_parent => 'Make to category';
  String get make_child => 'Make a subcategory';
  String make_child_warning1({required Object destiny}) =>
      'This category and its subcategories will become subcategories of <b>${destiny}</b>.';
  String make_child_warning2({required Object x, required Object destiny}) =>
      'Their transactions <b>(${x})</b> will be moved to the new subcategories created within the <b>${destiny}</b> category.';
  String get make_child_success => 'Subcategories created successfully';
  String get merge => 'Merge with another category';
  String merge_warning1(
          {required Object x, required Object from, required Object destiny}) =>
      'All transactions (${x}) associated with the category <b>${from}</b> will be moved to the category <b>${destiny}</b>';
  String merge_warning2({required Object from}) =>
      'The category <b>${from}</b> will be irreversibly deleted.';
  String get merge_success => 'Category merged successfully';
  String get delete_success => 'Category deleted correctly';
  String get delete_warning_header => 'Delete category?';
  String delete_warning_message({required Object x}) =>
      'This action will irreversibly delete all transactions <b>(${x})</b> related to this category.';
  late final _TranslationsCategoriesSelectEn select =
      _TranslationsCategoriesSelectEn._(_root);
}

// Path: budgets
class _TranslationsBudgetsEn {
  _TranslationsBudgetsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Budgets';
  String get repeated => 'Recurring';
  String get one_time => 'Once';
  String get annual => 'Annuals';
  String get week => 'Weekly';
  String get month => 'Monthly';
  String get actives => 'Actives';
  String get pending => 'Pending start';
  String get finish => 'Finished';
  String get from_budgeted => 'left of ';
  String get days_left => 'days left';
  String get days_to_start => 'days to start';
  String get since_expiration => 'days since expiration';
  String get no_budgets =>
      'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';
  String get delete => 'Delete budget';
  String get delete_warning =>
      'This action is irreversible. Categories and transactions referring to this quote will not be deleted';
  late final _TranslationsBudgetsFormEn form =
      _TranslationsBudgetsFormEn._(_root);
  late final _TranslationsBudgetsDetailsEn details =
      _TranslationsBudgetsDetailsEn._(_root);
}

// Path: backup
class _TranslationsBackupEn {
  _TranslationsBackupEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final _TranslationsBackupExportEn export =
      _TranslationsBackupExportEn._(_root);
  late final _TranslationsBackupImportEn import =
      _TranslationsBackupImportEn._(_root);
  late final _TranslationsBackupAboutEn about =
      _TranslationsBackupAboutEn._(_root);
}

// Path: settings
class _TranslationsSettingsEn {
  _TranslationsSettingsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title_long => 'Settings and appearance';
  String get title_short => 'Settings';
  String get description => 'App theme, texts and other general settings';
  String get edit_profile => 'Edit profile';
  String get lang_section => 'Language and texts';
  String get lang_title => 'App language';
  String get lang_descr =>
      'Language in which the texts will be displayed in the app';
  String get locale => 'Region';
  String get locale_descr => 'Set the format to use for dates, numbers...';
  String get locale_warn => 'When changing region the app will update';
  String get first_day_of_week => 'First day of week';
  String get theme_and_colors => 'Theme and colors';
  String get theme => 'Theme';
  String get theme_auto => 'Defined by the system';
  String get theme_light => 'Light';
  String get theme_dark => 'Dark';
  String get amoled_mode => 'AMOLED mode';
  String get amoled_mode_descr =>
      'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens';
  String get dynamic_colors => 'Dynamic colors';
  String get dynamic_colors_descr =>
      'Use your system accent color whenever possible';
  String get accent_color => 'Accent color';
  String get accent_color_descr =>
      'Choose the color the app will use to emphasize certain parts of the interface';
}

// Path: more
class _TranslationsMoreEn {
  _TranslationsMoreEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'More';
  String get title_long => 'More actions';
  late final _TranslationsMoreDataEn data = _TranslationsMoreDataEn._(_root);
  late final _TranslationsMoreAboutUsEn about_us =
      _TranslationsMoreAboutUsEn._(_root);
  late final _TranslationsMoreHelpUsEn help_us =
      _TranslationsMoreHelpUsEn._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardEn {
  _TranslationsGeneralClipboardEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String success({required Object x}) => '${x} copied to the clipboard';
  String get error => 'Error copying';
}

// Path: general.time
class _TranslationsGeneralTimeEn {
  _TranslationsGeneralTimeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get start_date => 'Start date';
  String get end_date => 'End date';
  String get from_date => 'From date';
  String get until_date => 'Until date';
  String get date => 'Date';
  String get datetime => 'Datetime';
  String get time => 'Time';
  String get each => 'Each';
  String get after => 'After';
  late final _TranslationsGeneralTimeRangesEn ranges =
      _TranslationsGeneralTimeRangesEn._(_root);
  late final _TranslationsGeneralTimePeriodicityEn periodicity =
      _TranslationsGeneralTimePeriodicityEn._(_root);
  late final _TranslationsGeneralTimeCurrentEn current =
      _TranslationsGeneralTimeCurrentEn._(_root);
  late final _TranslationsGeneralTimeAllEn all =
      _TranslationsGeneralTimeAllEn._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderEn {
  _TranslationsGeneralTransactionOrderEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Order transactions';
  String get category => 'By category';
  String get quantity => 'By quantity';
  String get date => 'By date';
}

// Path: general.validations
class _TranslationsGeneralValidationsEn {
  _TranslationsGeneralValidationsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get required => 'Required field';
  String get positive => 'Should be positive';
  String min_number({required Object x}) => 'Should be greater than ${x}';
  String max_number({required Object x}) => 'Should be less than ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewEn {
  _TranslationsFinancialHealthReviewEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String very_good({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Very good!';
      case GenderContext.female:
        return 'Very good!';
    }
  }

  String good({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Good';
      case GenderContext.female:
        return 'Good';
    }
  }

  String normal({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Average';
      case GenderContext.female:
        return 'Average';
    }
  }

  String bad({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Fair';
      case GenderContext.female:
        return 'Fair';
    }
  }

  String very_bad({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Very Bad';
      case GenderContext.female:
        return 'Very Bad';
    }
  }

  String insufficient_data({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Insufficient data';
      case GenderContext.female:
        return 'Insufficient data';
    }
  }

  late final _TranslationsFinancialHealthReviewDescrEn descr =
      _TranslationsFinancialHealthReviewDescrEn._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeEn {
  _TranslationsFinancialHealthMonthsWithoutIncomeEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Survival rate';
  String get subtitle =>
      'Given your balance, amount of time you could go without income';
  String get text_zero =>
      'You couldn\'t survive a month without income at this rate of expenses!';
  String get text_one =>
      'You could barely survive approximately a month without income at this rate of expenses!';
  String text_other({required Object n}) =>
      'You could survive approximately <b>${n} months</b> without income at this rate of spending.';
  String get text_infinite =>
      'You could survive approximately <b>all your life</b> without income at this rate of spending.';
  String get suggestion =>
      'Remember that it is advisable to always keep this ratio above 5 months at least. If you see that you do not have a sufficient savings cushion, reduce unnecessary expenses.';
  String get insufficient_data =>
      'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageEn {
  _TranslationsFinancialHealthSavingsPercentageEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Savings percentage';
  String get subtitle => 'What part of your income is not spent in this period';
  late final _TranslationsFinancialHealthSavingsPercentageTextEn text =
      _TranslationsFinancialHealthSavingsPercentageTextEn._(_root);
  String get suggestion =>
      'Remember that it is advisable to save at least 15-20% of what you earn.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesEn {
  _TranslationsIconSelectorScopesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get transport => 'Transport';
  String get money => 'Money';
  String get food => 'Food';
  String get medical => 'Health';
  String get entertainment => 'Leisure';
  String get technology => 'Technology';
  String get other => 'Others';
  String get logos_financial_institutions => 'Financial institutions';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsEn {
  _TranslationsTransactionNextPaymentsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get accept => 'Accept';
  String get skip => 'Skip';
  String get skip_success => 'Successfully skipped transaction';
  String get skip_dialog_title => 'Skip transaction';
  String skip_dialog_msg({required Object date}) =>
      'This action is irreversible. We will move the date of the next move to ${date}';
  String get accept_today => 'Accept today';
  String accept_in_required_date({required Object date}) =>
      'Accept in required date (${date})';
  String get accept_dialog_title => 'Accept transaction';
  String get accept_dialog_msg_single =>
      'The new status of the transaction will be null. You can re-edit the status of this transaction whenever you want';
  String accept_dialog_msg({required Object date}) =>
      'This action will create a new transaction with date ${date}. You will be able to check the details of this transaction on the transaction page';
  String get recurrent_rule_finished =>
      'The recurring rule has been completed, there are no more payments to make!';
}

// Path: transaction.list
class _TranslationsTransactionListEn {
  _TranslationsTransactionListEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get empty =>
      'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
  String get searcher_placeholder => 'Search by category, description...';
  String get searcher_no_results =>
      'No transactions found matching the search criteria';
  String get loading => 'Loading more transactions...';
  String selected_short({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} selected',
        other: '${n} selected',
      );
  String selected_long({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} transaction selected',
        other: '${n} transactions selected',
      );
  late final _TranslationsTransactionListBulkEditEn bulk_edit =
      _TranslationsTransactionListBulkEditEn._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersEn {
  _TranslationsTransactionFiltersEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get from_value => 'From amount';
  String get to_value => 'Up to amount';
  String from_value_def({required Object x}) => 'From ${x}';
  String to_value_def({required Object x}) => 'Up to ${x}';
  String from_date_def({required Object date}) => 'From the ${date}';
  String to_date_def({required Object date}) => 'Up to the ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormEn {
  _TranslationsTransactionFormEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final _TranslationsTransactionFormValidatorsEn validators =
      _TranslationsTransactionFormValidatorsEn._(_root);
  String get title => 'Transaction title';
  String get value => 'Value of the transaction';
  String get tap_to_see_more => 'Tap to see more details';
  String get description => 'Description';
  String get description_info =>
      'Adding a note will help you find this transaction faster in the future';
  String exchange_to_preferred_title({required Object currency}) =>
      'Exchnage rate to ${currency}';
  String get exchange_to_preferred_in_date => 'On transaction date';
}

// Path: transaction.status
class _TranslationsTransactionStatusEn {
  _TranslationsTransactionStatusEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Status',
        other: 'Statuses',
      );
  String tr_status({required Object status}) => '${status} transaction';
  String get none => 'Stateless';
  String get reconciled => 'Reconciled';
  String get reconciled_descr =>
      'This transaction has already been validated and corresponds to a real transaction from your bank';
  String get unreconciled => 'Unreconciled';
  String get unreconciled_descr =>
      'This transaction has not yet been validated and therefore does not yet appear in your real bank accounts. However, it counts for the calculation of balances and statistics in Monekin';
  String get pending => 'Pending';
  String get pending_descr =>
      'This transaction is pending and therefore it will not be taken into account when calculating balances and statistics';
  String get voided => 'Voided';
  String get voided_descr =>
      'Void/cancelled transaction due to payment error or any other reason. It will not be taken into account when calculating balances and statistics';
}

// Path: transaction.types
class _TranslationsTransactionTypesEn {
  _TranslationsTransactionTypesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Transaction type',
        other: 'Transaction types',
      );
  String income({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Income',
        other: 'Incomes',
      );
  String expense({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Expense',
        other: 'Expenses',
      );
  String transfer({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Transfer',
        other: 'Transfers',
      );
}

// Path: transfer.form
class _TranslationsTransferFormEn {
  _TranslationsTransferFormEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get from => 'Origin account';
  String get to => 'Destination account';
  String currency_info_add({required Object x}) =>
      '${x} will be transferred to the destination account';
  String currency_info_edit({required Object x}) =>
      '${x} have been transferred to the destination account';
  late final _TranslationsTransferFormCurrencyExchangeSelectorEn
      currency_exchange_selector =
      _TranslationsTransferFormCurrencyExchangeSelectorEn._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsEn {
  _TranslationsRecurrentTransactionsDetailsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Recurrent transaction';
  String get descr =>
      'The next moves for this transaction are shown below. You can accept the first move or skip this move';
  String get last_payment_info =>
      'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action';
  String get delete_header => 'Delete recurring transaction';
  String get delete_message =>
      'This action is irreversible and will not affect transactions you have already confirmed/paid for';
}

// Path: account.types
class _TranslationsAccountTypesEn {
  _TranslationsAccountTypesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Account type';
  String get warning =>
      'Once the type of account has been chosen, it cannot be changed in the future';
  String get normal => 'Normal account';
  String get normal_descr =>
      'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...';
  String get saving => 'Savings account';
  String get saving_descr =>
      'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money';
}

// Path: account.form
class _TranslationsAccountFormEn {
  _TranslationsAccountFormEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get name => 'Account name';
  String get name_placeholder => 'Ex: Savings account';
  String get notes => 'Notes';
  String get notes_placeholder =>
      'Type some notes/description about this account';
  String get initial_balance => 'Initial balance';
  String get current_balance => 'Current balance';
  String get create => 'Create account';
  String get edit => 'Edit account';
  String get currency_not_found_warn =>
      'You do not have information on exchange rates for this currency. 1.0 will be used as the default exchange rate. You can modify this in the settings';
  String get already_exists =>
      'There is already another one with the same name, please write another';
  String get tr_before_opening_date =>
      'There are transactions in this account with a date before the opening date';
  String get iban => 'IBAN';
  String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteEn {
  _TranslationsAccountDeleteEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get warning_header => 'Delete account?';
  String get warning_text =>
      'This action will delete this account and all its transactions';
  String get success => 'Account deleted successfully';
}

// Path: account.close
class _TranslationsAccountCloseEn {
  _TranslationsAccountCloseEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Close account';
  String get title_short => 'Close';
  String get warn =>
      'This account will no longer appear in certain listings and you will not be able to create transactions in it with a date later than the one specified below. This action does not affect any transactions or balance, and you can also reopen this account at any time. ';
  String get should_have_zero_balance =>
      'You must have a current balance of 0 in this account to close it. Please edit the account before continuing';
  String get should_have_no_transactions =>
      'This account has transactions after the specified close date. Delete them or edit the account close date before continuing';
  String get success => 'Account closed successfully';
  String get unarchive_succes => 'Account successfully re-opened';
}

// Path: account.select
class _TranslationsAccountSelectEn {
  _TranslationsAccountSelectEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get one => 'Select an account';
  String get all => 'All accounts';
  String get multiple => 'Select accounts';
}

// Path: currencies.form
class _TranslationsCurrenciesFormEn {
  _TranslationsCurrenciesFormEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get equal_to_preferred_warn =>
      'The currency cannot be equal to the user currency';
  String get specify_a_currency => 'Please specify a currency';
  String get add => 'Add exchange rate';
  String get add_success => 'Exchange rate added successfully';
  String get edit => 'Edit exchange rate';
  String get edit_success => 'Exchange rate edited successfully';
}

// Path: tags.form
class _TranslationsTagsFormEn {
  _TranslationsTagsFormEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get name => 'Tag name';
  String get description => 'Description';
}

// Path: categories.select
class _TranslationsCategoriesSelectEn {
  _TranslationsCategoriesSelectEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Select categories';
  String get select_one => 'Select a category';
  String get select_subcategory => 'Choose a subcategory';
  String get without_subcategory => 'Without subcategory';
  String get all => 'All categories';
  String get all_short => 'All';
}

// Path: budgets.form
class _TranslationsBudgetsFormEn {
  _TranslationsBudgetsFormEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Add a budget';
  String get name => 'Budget name';
  String get value => 'Limit quantity';
  String get create => 'Add budget';
  String get edit => 'Edit budget';
  String get negative_warn => 'The budgets can not have a negative amount';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsEn {
  _TranslationsBudgetsDetailsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Budget Details';
  String get statistics => 'Statistics';
  String get budget_value => 'Budgeted';
  String expend_diary_left(
          {required Object dailyAmount, required Object remainingDays}) =>
      'You can spend ${dailyAmount}/day for ${remainingDays} remaining days';
  String get expend_evolution => 'Expenditure evolution';
  String get no_transactions =>
      'It seems that you have not made any expenses related to this budget';
}

// Path: backup.export
class _TranslationsBackupExportEn {
  _TranslationsBackupExportEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Export your data';
  String get title_short => 'Export';
  String get all => 'Full backup';
  String get all_descr =>
      'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';
  String get transactions => 'Transactions backup';
  String get transactions_descr =>
      'Export your transactions in CSV so you can more easily analyze them in other programs or applications.';
  String get description => 'Download your data in different formats';
  String get dialog_title => 'Save/Send file';
  String success({required Object x}) =>
      'File saved/downloaded successfully in ${x}';
  String get error =>
      'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportEn {
  _TranslationsBackupImportEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Import your data';
  String get title_short => 'Import';
  String get restore_backup => 'Restore Backup';
  String get restore_backup_descr =>
      'Import a previously saved database from Monekin. This action will replace any current application data with the new data';
  String get restore_backup_warn_description =>
      'When importing a new database, you will lose all data currently saved in the app. It is recommended to make a backup before continuing. Do not upload here any file whose origin you do not know, upload only files that you have previously downloaded from Monekin';
  String get restore_backup_warn_title => 'Overwrite all data';
  String get select_other_file => 'Select other file';
  String get tap_to_select_file => 'Tap to select a file';
  late final _TranslationsBackupImportManualImportEn manual_import =
      _TranslationsBackupImportManualImportEn._(_root);
  String get success => 'Import performed successfully';
  String get cancelled => 'Import was cancelled by the user';
  String get error =>
      'Error importing file. Please contact developer via lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutEn {
  _TranslationsBackupAboutEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Information about your database';
  String get create_date => 'Creation date';
  String get modify_date => 'Last modified';
  String get last_backup => 'Last backup';
  String get size => 'Size';
}

// Path: more.data
class _TranslationsMoreDataEn {
  _TranslationsMoreDataEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Data';
  String get display_descr =>
      'Export and import your data so you don\'t lose anything';
  String get delete_all => 'Delete my data';
  String get delete_all_header1 => 'Stop right there padawan ⚠️⚠️';
  String get delete_all_message1 =>
      'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';
  String get delete_all_header2 => 'One last step ⚠️⚠️';
  String get delete_all_message2 =>
      'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsEn {
  _TranslationsMoreAboutUsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'App information';
  String get description =>
      'Check out the terms and other relevant information about Monekin. Get in touch with the community by reporting bugs, leaving suggestions...';
  late final _TranslationsMoreAboutUsLegalEn legal =
      _TranslationsMoreAboutUsLegalEn._(_root);
  late final _TranslationsMoreAboutUsProjectEn project =
      _TranslationsMoreAboutUsProjectEn._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsEn {
  _TranslationsMoreHelpUsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Help us';
  String get description =>
      'Find out how you can help Monekin become better and better';
  String get rate_us => 'Rate us';
  String get rate_us_descr => 'Any rate is welcome!';
  String get share => 'Share Monekin';
  String get share_descr => 'Share our app to friends and family';
  String get share_text =>
      'Monekin! The best personal finance app. Download it here';
  String get thanks => 'Thank you!';
  String get thanks_long =>
      'Your contributions to Monekin and other open source projects, big and small, make great projects like this possible. Thank you for taking the time to contribute.';
  String get donate => 'Make a donation';
  String get donate_descr =>
      'With your donation you will help the app continue receiving improvements. What better way than to thank the work done by inviting me to a coffee?';
  String get donate_success =>
      'Donation made. Thank you very much for your contribution! ❤️';
  String get donate_err =>
      'Oops! It seems there was an error receiving your payment';
  String get report => 'Report bugs, leave suggestions...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesEn {
  _TranslationsGeneralTimeRangesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Time range';
  String get it_repeat => 'Repeats';
  String get it_ends => 'Ends';
  String get forever => 'Forever';
  late final _TranslationsGeneralTimeRangesTypesEn types =
      _TranslationsGeneralTimeRangesTypesEn._(_root);
  String each_range({required num n, required Object range}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Every ${range}',
        other: 'Every ${n} ${range}',
      );
  String each_range_until_date(
          {required num n, required Object range, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Every ${range} until ${day}',
        other: 'Every ${n} ${range} until ${day}',
      );
  String each_range_until_times(
          {required num n, required Object range, required Object limit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Every ${range} ${limit} times',
        other: 'Every ${n} ${range} ${limit} times',
      );
  String each_range_until_once({required num n, required Object range}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Every ${range} once',
        other: 'Every ${n} ${range} once',
      );
  String month({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Month',
        other: 'Months',
      );
  String year({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Year',
        other: 'Years',
      );
  String day({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Day',
        other: 'Days',
      );
  String week({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Week',
        other: 'Weeks',
      );
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityEn {
  _TranslationsGeneralTimePeriodicityEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Recurrence';
  String get no_repeat => 'No repeat';
  String repeat({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: 'Repetition',
        other: 'Repetitions',
      );
  String get diary => 'Daily';
  String get monthly => 'Monthly';
  String get annually => 'Annually';
  String get quaterly => 'Quarterly';
  String get weekly => 'Weekly';
  String get custom => 'Custom';
  String get infinite => 'Always';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentEn {
  _TranslationsGeneralTimeCurrentEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get monthly => 'This month';
  String get annually => 'This year';
  String get quaterly => 'This quarter';
  String get weekly => 'This week';
  String get infinite => 'For ever';
  String get custom => 'Custom Range';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllEn {
  _TranslationsGeneralTimeAllEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get diary => 'Every day';
  String get monthly => 'Every month';
  String get annually => 'Every year';
  String get quaterly => 'Every quarterly';
  String get weekly => 'Every week';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrEn {
  _TranslationsFinancialHealthReviewDescrEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get insufficient_data =>
      'It looks like we don\'t have enough expenses to calculate your financial health. Add some expenses/incomes in this period to allow us to help you!';
  String get very_good =>
      'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';
  String get good =>
      'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';
  String get normal =>
      'Your financial health is more or less in the average of the rest of the population for this period';
  String get bad =>
      'It seems that your financial situation is not the best yet. Explore the rest of the charts to learn more about your finances';
  String get very_bad =>
      'Hmm, your financial health is far below what it should be. Explore the rest of the charts to learn more about your finances';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextEn {
  _TranslationsFinancialHealthSavingsPercentageTextEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String good({required Object value}) =>
      'Congratulations! You have managed to save <b>${value}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!';
  String normal({required Object value}) =>
      'Congratulations, you have managed to save <b>${value}%</b> of your income during this period.';
  String bad({required Object value}) =>
      'You have managed to save <b>${value}%</b> of your income during this period. However, we think you can still do much more!';
  String get very_bad =>
      'Wow, you haven\'t managed to save anything during this period.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditEn {
  _TranslationsTransactionListBulkEditEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get dates => 'Edit dates';
  String get categories => 'Edit categories';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsEn {
  _TranslationsTransactionFormValidatorsEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get zero => 'The value of a transaction cannot be equal to zero';
  String get date_max =>
      'The selected date is after the current one. The transaction will be added as pending';
  String get date_after_account_creation =>
      'You cannot create a transaction whose date is before the creation date of the account it belongs to';
  String get negative_transaction =>
      'Do not use negative amounts for your transaction. We will apply the sign depending on whether the selected category is expense/income';
  String get negative_transfer =>
      'The monetary value of a transfer cannot be negative';
}

// Path: transfer.form.currency_exchange_selector
class _TranslationsTransferFormCurrencyExchangeSelectorEn {
  _TranslationsTransferFormCurrencyExchangeSelectorEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Edit exchange between currencies';
  String get value_in_destiny => 'Amount transferred in destination';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportEn {
  _TranslationsBackupImportManualImportEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Manual import';
  String get descr => 'Import transactions from a .csv file manually';
  String get default_account => 'Default account';
  String get remove_default_account => 'Remove default account';
  String get default_category => 'Default Category';
  String get select_a_column => 'Select a column from the .csv';
  List<String> get steps => [
        'Select your file',
        'Column for quantity',
        'Column for account',
        'Column for category',
        'Column for date',
        'other columns',
      ];
  List<String> get steps_descr => [
        'Select a .csv file from your device. Make sure it has a first row that describes the name of each column',
        'Select the column where the value of each transaction is specified. Use negative values for expenses and positive values for income. Use a point as a decimal separator',
        'Select the column where the account to which each transaction belongs is specified. You can also select a default account in case we cannot find the account you want. If a default account is not specified, we will create one with the same name ',
        'Specify the column where the transaction category name is located. You must specify a default category so that we assign this category to transactions, in case the category cannot be found',
        'Select the column where the date of each transaction is specified. If not specified, transactions will be created with the current date',
        'Specifies the columns for other optional transaction attributes',
      ];
  String success({required Object x}) =>
      'Successfully imported ${x} transactions';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalEn {
  _TranslationsMoreAboutUsLegalEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Legal information';
  String get privacy => 'Privacy policy';
  String get terms => 'Terms of use';
  String get licenses => 'Licenses';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectEn {
  _TranslationsMoreAboutUsProjectEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get display => 'Project';
  String get contributors => 'Collaborators';
  String get contributors_descr =>
      'All the developers who have made Monekin grow';
  String get contact => 'Contact us';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesEn {
  _TranslationsGeneralTimeRangesTypesEn._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get cycle => 'Cycles';
  String get last_days => 'Last days';
  String last_days_form({required Object x}) => '${x} previous days';
  String get all => 'Always';
  String get date_range => 'Custom range';
}

// Path: <root>
class _TranslationsEs implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _TranslationsEs.build(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.es,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  @override
  late final _TranslationsEs _root = this; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGeneralEs general = _TranslationsGeneralEs._(_root);
  @override
  late final _TranslationsIntroEs intro = _TranslationsIntroEs._(_root);
  @override
  late final _TranslationsHomeEs home = _TranslationsHomeEs._(_root);
  @override
  late final _TranslationsFinancialHealthEs financial_health =
      _TranslationsFinancialHealthEs._(_root);
  @override
  late final _TranslationsStatsEs stats = _TranslationsStatsEs._(_root);
  @override
  late final _TranslationsIconSelectorEs icon_selector =
      _TranslationsIconSelectorEs._(_root);
  @override
  late final _TranslationsTransactionEs transaction =
      _TranslationsTransactionEs._(_root);
  @override
  late final _TranslationsTransferEs transfer =
      _TranslationsTransferEs._(_root);
  @override
  late final _TranslationsRecurrentTransactionsEs recurrent_transactions =
      _TranslationsRecurrentTransactionsEs._(_root);
  @override
  late final _TranslationsAccountEs account = _TranslationsAccountEs._(_root);
  @override
  late final _TranslationsCurrenciesEs currencies =
      _TranslationsCurrenciesEs._(_root);
  @override
  late final _TranslationsTagsEs tags = _TranslationsTagsEs._(_root);
  @override
  late final _TranslationsCategoriesEs categories =
      _TranslationsCategoriesEs._(_root);
  @override
  late final _TranslationsBudgetsEs budgets = _TranslationsBudgetsEs._(_root);
  @override
  late final _TranslationsBackupEs backup = _TranslationsBackupEs._(_root);
  @override
  late final _TranslationsSettingsEs settings =
      _TranslationsSettingsEs._(_root);
  @override
  late final _TranslationsMoreEs more = _TranslationsMoreEs._(_root);
}

// Path: general
class _TranslationsGeneralEs implements _TranslationsGeneralEn {
  _TranslationsGeneralEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'Cancelar';
  @override
  String get or => 'o';
  @override
  String get understood => 'Entendido';
  @override
  String get unspecified => 'Sin especificar';
  @override
  String get confirm => 'Confirmar';
  @override
  String get continue_text => 'Continuar';
  @override
  String get quick_actions => 'Acciones rápidas';
  @override
  String get save => 'Guardar';
  @override
  String get save_changes => 'Guardar cambios';
  @override
  String get close_and_save => 'Guardar y cerrar';
  @override
  String get add => 'Añadir';
  @override
  String get edit => 'Editar';
  @override
  String get delete => 'Eliminar';
  @override
  String get balance => 'Balance';
  @override
  String get account => 'Cuenta';
  @override
  String get accounts => 'Cuentas';
  @override
  String get categories => 'Categorías';
  @override
  String get category => 'Categoría';
  @override
  String get today => 'Hoy';
  @override
  String get yesterday => 'Ayer';
  @override
  String get filters => 'Filtros';
  @override
  String get select_all => 'Seleccionar todo';
  @override
  String get deselect_all => 'Deseleccionar todo';
  @override
  String get empty_warn => 'Ops! Esto esta muy vacio';
  @override
  String get insufficient_data => 'Datos insuficientes';
  @override
  String get show_more_fields => 'Show more fields';
  @override
  String get show_less_fields => 'Show less fields';
  @override
  late final _TranslationsGeneralClipboardEs clipboard =
      _TranslationsGeneralClipboardEs._(_root);
  @override
  late final _TranslationsGeneralTimeEs time =
      _TranslationsGeneralTimeEs._(_root);
  @override
  late final _TranslationsGeneralTransactionOrderEs transaction_order =
      _TranslationsGeneralTransactionOrderEs._(_root);
  @override
  late final _TranslationsGeneralValidationsEs validations =
      _TranslationsGeneralValidationsEs._(_root);
}

// Path: intro
class _TranslationsIntroEs implements _TranslationsIntroEn {
  _TranslationsIntroEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get start => 'Empecemos';
  @override
  String get skip => 'Saltar';
  @override
  String get next => 'Siguiente';
  @override
  String get select_your_currency => 'Selecciona tu divisa';
  @override
  String get welcome_subtitle => 'Tu gestor de finanzas personales';
  @override
  String get welcome_subtitle2 => '100% libre, 100% gratis';
  @override
  String get welcome_footer =>
      'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación';
  @override
  String get offline_descr_title => 'CUENTA SIN CONEXIÓN:';
  @override
  String get offline_descr =>
      'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
  @override
  String get offline_start => 'Iniciar sesión offline';
  @override
  String get sl1_title => 'Selecciona tu divisa';
  @override
  String get sl1_descr =>
      'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
  @override
  String get sl2_title => 'Seguro, privado y confiable';
  @override
  String get sl2_descr =>
      'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
  @override
  String get sl2_descr2 =>
      'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
  @override
  String get last_slide_title => 'Todo listo!';
  @override
  String get last_slide_descr =>
      'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
  @override
  String get last_slide_descr2 =>
      'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
}

// Path: home
class _TranslationsHomeEs implements _TranslationsHomeEn {
  _TranslationsHomeEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dashboard';
  @override
  String get filter_transactions => 'Filtrar transacciones';
  @override
  String get hello_day => 'Buenos días,';
  @override
  String get hello_night => 'Buenas noches,';
  @override
  String get total_balance => 'Saldo total';
  @override
  String get my_accounts => 'Mis cuentas';
  @override
  String get active_accounts => 'Cuentas activas';
  @override
  String get no_accounts => 'Aun no hay cuentas creadas';
  @override
  String get no_accounts_descr =>
      'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones';
  @override
  String get last_transactions => 'Últimas transacciones';
  @override
  String get should_create_account_header => 'Ops!';
  @override
  String get should_create_account_message =>
      'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones';
}

// Path: financial_health
class _TranslationsFinancialHealthEs implements _TranslationsFinancialHealthEn {
  _TranslationsFinancialHealthEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Salud financiera';
  @override
  late final _TranslationsFinancialHealthReviewEs review =
      _TranslationsFinancialHealthReviewEs._(_root);
  @override
  late final _TranslationsFinancialHealthMonthsWithoutIncomeEs
      months_without_income =
      _TranslationsFinancialHealthMonthsWithoutIncomeEs._(_root);
  @override
  late final _TranslationsFinancialHealthSavingsPercentageEs
      savings_percentage =
      _TranslationsFinancialHealthSavingsPercentageEs._(_root);
}

// Path: stats
class _TranslationsStatsEs implements _TranslationsStatsEn {
  _TranslationsStatsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Estadísticas';
  @override
  String get balance => 'Saldo';
  @override
  String get final_balance => 'Saldo final';
  @override
  String get balance_by_account => 'Saldo por cuentas';
  @override
  String get balance_by_currency => 'Saldo por divisas';
  @override
  String get balance_evolution => 'Tendencia de saldo';
  @override
  String get compared_to_previous_period => 'Frente al periodo anterior';
  @override
  String get cash_flow => 'Flujo de caja';
  @override
  String get by_periods => 'Por periodos';
  @override
  String get by_categories => 'Por categorías';
  @override
  String get by_tags => 'Por etiquetas';
  @override
  String get distribution => 'Distribución';
  @override
  String get finance_health_resume => 'Resumen';
  @override
  String get finance_health_breakdown => 'Desglose';
}

// Path: icon_selector
class _TranslationsIconSelectorEs implements _TranslationsIconSelectorEn {
  _TranslationsIconSelectorEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Nombre:';
  @override
  String get icon => 'Icono';
  @override
  String get color => 'Color';
  @override
  String get select_icon => 'Selecciona un icono';
  @override
  String get select_color => 'Selecciona un color';
  @override
  String get select_account_icon => 'Identifica tu cuenta';
  @override
  String get select_category_icon => 'Identifica tu categoría';
  @override
  late final _TranslationsIconSelectorScopesEs scopes =
      _TranslationsIconSelectorScopesEs._(_root);
}

// Path: transaction
class _TranslationsTransactionEs implements _TranslationsTransactionEn {
  _TranslationsTransactionEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Transacción',
        other: 'Transacciones',
      );
  @override
  String get create => 'Nueva transacción';
  @override
  String get new_income => 'Nuevo ingreso';
  @override
  String get new_expense => 'Nuevo gasto';
  @override
  String get new_success => 'Transacción creada correctamente';
  @override
  String get edit => 'Editar transacción';
  @override
  String get edit_success => 'Transacción editada correctamente';
  @override
  String get edit_multiple => 'Editar transacciones';
  @override
  String edit_multiple_success({required Object x}) =>
      '${x} transacciones editadas correctamente';
  @override
  String get duplicate => 'Clonar transacción';
  @override
  String get duplicate_short => 'Clonar';
  @override
  String get duplicate_warning_message =>
      'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?';
  @override
  String get duplicate_success => 'Transacción clonada con exito';
  @override
  String get delete => 'Eliminar transacción';
  @override
  String get delete_warning_message =>
      'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
  @override
  String get delete_success => 'Transacción eliminada correctamente';
  @override
  String get delete_multiple => 'Eliminar transacciones';
  @override
  String delete_multiple_warning_message({required Object x}) =>
      'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
  @override
  String delete_multiple_success({required Object x}) =>
      '${x} transacciones eliminadas correctamente';
  @override
  String get details => 'Detalles del movimiento';
  @override
  late final _TranslationsTransactionNextPaymentsEs next_payments =
      _TranslationsTransactionNextPaymentsEs._(_root);
  @override
  late final _TranslationsTransactionListEs list =
      _TranslationsTransactionListEs._(_root);
  @override
  late final _TranslationsTransactionFiltersEs filters =
      _TranslationsTransactionFiltersEs._(_root);
  @override
  late final _TranslationsTransactionFormEs form =
      _TranslationsTransactionFormEs._(_root);
  @override
  late final _TranslationsTransactionStatusEs status =
      _TranslationsTransactionStatusEs._(_root);
  @override
  late final _TranslationsTransactionTypesEs types =
      _TranslationsTransactionTypesEs._(_root);
}

// Path: transfer
class _TranslationsTransferEs implements _TranslationsTransferEn {
  _TranslationsTransferEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Transferencia';
  @override
  String get transfers => 'Transferencias';
  @override
  String transfer_to({required Object account}) =>
      'Transferencia hacia ${account}';
  @override
  String get create => 'Nueva transferencia';
  @override
  String get need_two_accounts_warning_header => 'Ops!';
  @override
  String get need_two_accounts_warning_message =>
      'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
  @override
  late final _TranslationsTransferFormEs form =
      _TranslationsTransferFormEs._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsEs
    implements _TranslationsRecurrentTransactionsEn {
  _TranslationsRecurrentTransactionsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Movimientos recurrentes';
  @override
  String get title_short => 'Mov. recurrentes';
  @override
  String get empty =>
      'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
  @override
  String get total_expense_title => 'Gasto total por periodo';
  @override
  String get total_expense_descr =>
      '* Sin considerar la fecha de inicio y fin de cada recurrencia';
  @override
  late final _TranslationsRecurrentTransactionsDetailsEs details =
      _TranslationsRecurrentTransactionsDetailsEs._(_root);
}

// Path: account
class _TranslationsAccountEs implements _TranslationsAccountEn {
  _TranslationsAccountEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get details => 'Detalles de la cuenta';
  @override
  String get date => 'Fecha de apertura';
  @override
  String get close_date => 'Fecha de cierre';
  @override
  String get reopen_short => 'Reabrir';
  @override
  String get reopen => 'Reabrir cuenta';
  @override
  String get reopen_descr => '¿Seguro que quieres volver a abrir esta cuenta?';
  @override
  String get balance => 'Saldo de la cuenta';
  @override
  String get n_transactions => 'Número de transacciones';
  @override
  String get add_money => 'Añadir dinero';
  @override
  String get withdraw_money => 'Retirar dinero';
  @override
  String get no_accounts =>
      'No se han encontrado cuentas que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
  @override
  late final _TranslationsAccountTypesEs types =
      _TranslationsAccountTypesEs._(_root);
  @override
  late final _TranslationsAccountFormEs form =
      _TranslationsAccountFormEs._(_root);
  @override
  late final _TranslationsAccountDeleteEs delete =
      _TranslationsAccountDeleteEs._(_root);
  @override
  late final _TranslationsAccountCloseEs close =
      _TranslationsAccountCloseEs._(_root);
  @override
  late final _TranslationsAccountSelectEs select =
      _TranslationsAccountSelectEs._(_root);
}

// Path: currencies
class _TranslationsCurrenciesEs implements _TranslationsCurrenciesEn {
  _TranslationsCurrenciesEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get currency_converter => 'Conversor de divisas';
  @override
  String get currency_manager => 'Administrador de divisas';
  @override
  String get currency_manager_descr =>
      'Configura tu divisa y sus tipos de cambio con otras';
  @override
  String get currency => 'Divisa';
  @override
  String get preferred_currency => 'Divisa predeterminada/base';
  @override
  String get change_preferred_currency_title => 'Cambiar divisa predeterminada';
  @override
  String get change_preferred_currency_msg =>
      'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
  @override
  late final _TranslationsCurrenciesFormEs form =
      _TranslationsCurrenciesFormEs._(_root);
  @override
  String get delete_all_success => 'Tipos de cambio borrados con exito';
  @override
  String get historical => 'Histórico de tasas';
  @override
  String get exchange_rate => 'Tipo de cambio';
  @override
  String get exchange_rates => 'Tipos de cambio';
  @override
  String get empty =>
      'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos';
  @override
  String get select_a_currency => 'Selecciona una divisa';
  @override
  String get search_title => 'Toca para buscar';
  @override
  String get search_placeholder => 'Busca por nombre o por código de la divisa';
}

// Path: tags
class _TranslationsTagsEs implements _TranslationsTagsEn {
  _TranslationsTagsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Etiqueta',
        other: 'Etiquetas',
      );
  @override
  late final _TranslationsTagsFormEs form = _TranslationsTagsFormEs._(_root);
  @override
  String get empty_list =>
      'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos';
  @override
  String get without_tags => 'Sin etiquetas';
  @override
  String get select => 'Selecionar etiquetas';
  @override
  String get create => 'Crear etiqueta';
  @override
  String get add => 'Añadir etiqueta';
  @override
  String get create_success => 'Etiqueta creada correctamente';
  @override
  String get already_exists =>
      'El nombre de esta etiqueta ya existe. Puede que quieras editarla';
  @override
  String get edit => 'Editar etiqueta';
  @override
  String get edit_success => 'Etiqueta editada correctamente';
  @override
  String get delete_success => 'Categoría eliminada correctamente';
  @override
  String get delete_warning_header => '¿Eliminar etiqueta?';
  @override
  String get delete_warning_message =>
      'Esta acción no borrará las transacciones que poseen esta etiqueta.';
}

// Path: categories
class _TranslationsCategoriesEs implements _TranslationsCategoriesEn {
  _TranslationsCategoriesEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get unknown => 'Categoría desconocida';
  @override
  String get create => 'Crear categoría';
  @override
  String get create_success => 'Categoría creada correctamente';
  @override
  String get new_category => 'Nueva categoría';
  @override
  String get already_exists =>
      'El nombre de esta categoría ya existe. Puede que quieras editarla';
  @override
  String get edit => 'Editar categoría';
  @override
  String get edit_success => 'Categoría editada correctamente';
  @override
  String get name => 'Nombre de la categoría';
  @override
  String get type => 'Tipo de categoría';
  @override
  String get both_types => 'Ambos tipos';
  @override
  String get subcategories => 'Subcategorías';
  @override
  String get subcategories_add => 'Añadir subcategoría';
  @override
  String get make_parent => 'Convertir en categoría';
  @override
  String get make_child => 'Convertir en subcategoría';
  @override
  String make_child_warning1({required Object destiny}) =>
      'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.';
  @override
  String make_child_warning2({required Object x, required Object destiny}) =>
      'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.';
  @override
  String get make_child_success => 'Subcategorías creadas con exito';
  @override
  String get merge => 'Fusionar con otra categoría';
  @override
  String merge_warning1(
          {required Object x, required Object from, required Object destiny}) =>
      'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.';
  @override
  String merge_warning2({required Object from}) =>
      'La categoría <b>${from}</b> será eliminada de forma irreversible.';
  @override
  String get merge_success => 'Categoría fusionada correctamente';
  @override
  String get delete_success => 'Categoría eliminada correctamente';
  @override
  String get delete_warning_header => '¿Eliminar categoría?';
  @override
  String delete_warning_message({required Object x}) =>
      'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.';
  @override
  late final _TranslationsCategoriesSelectEs select =
      _TranslationsCategoriesSelectEs._(_root);
}

// Path: budgets
class _TranslationsBudgetsEs implements _TranslationsBudgetsEn {
  _TranslationsBudgetsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Presupuestos';
  @override
  String get repeated => 'Periódicos';
  @override
  String get one_time => 'Una vez';
  @override
  String get annual => 'Anuales';
  @override
  String get week => 'Semanales';
  @override
  String get month => 'Mensuales';
  @override
  String get actives => 'Activos';
  @override
  String get pending => 'Pendientes de comenzar';
  @override
  String get finish => 'Finalizados';
  @override
  String get from_budgeted => 'De un total de ';
  @override
  String get days_left => 'días restantes';
  @override
  String get days_to_start => 'días para empezar';
  @override
  String get since_expiration => 'días desde su expiración';
  @override
  String get no_budgets =>
      'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
  @override
  String get delete => 'Eliminar presupuesto';
  @override
  String get delete_warning =>
      'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
  @override
  late final _TranslationsBudgetsFormEs form =
      _TranslationsBudgetsFormEs._(_root);
  @override
  late final _TranslationsBudgetsDetailsEs details =
      _TranslationsBudgetsDetailsEs._(_root);
}

// Path: backup
class _TranslationsBackupEs implements _TranslationsBackupEn {
  _TranslationsBackupEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsBackupExportEs export =
      _TranslationsBackupExportEs._(_root);
  @override
  late final _TranslationsBackupImportEs import =
      _TranslationsBackupImportEs._(_root);
  @override
  late final _TranslationsBackupAboutEs about =
      _TranslationsBackupAboutEs._(_root);
}

// Path: settings
class _TranslationsSettingsEs implements _TranslationsSettingsEn {
  _TranslationsSettingsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title_long => 'Configuración y apariencia';
  @override
  String get title_short => 'Configuración';
  @override
  String get description =>
      'Tema de la aplicación, textos y otras configuraciones generales';
  @override
  String get edit_profile => 'Editar perfil';
  @override
  String get lang_section => 'Idioma y textos';
  @override
  String get lang_title => 'Idioma de la aplicación';
  @override
  String get lang_descr =>
      'Idioma en el que se mostrarán los textos en la aplicación';
  @override
  String get locale => 'Región';
  @override
  String get locale_descr =>
      'Establecer el formato a utilizar para fechas, números...';
  @override
  String get locale_warn =>
      'Al cambiar la región, la aplicación se actualizará';
  @override
  String get first_day_of_week => 'Primer día de la semana';
  @override
  String get theme_and_colors => 'Tema y colores';
  @override
  String get theme => 'Tema';
  @override
  String get theme_auto => 'Definido por el sistema';
  @override
  String get theme_light => 'Claro';
  @override
  String get theme_dark => 'Oscuro';
  @override
  String get amoled_mode => 'Modo AMOLED';
  @override
  String get amoled_mode_descr =>
      'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
  @override
  String get dynamic_colors => 'Colores dinámicos';
  @override
  String get dynamic_colors_descr =>
      'Usar el color de acento de su sistema siempre que sea posible';
  @override
  String get accent_color => 'Color de acento';
  @override
  String get accent_color_descr =>
      'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
}

// Path: more
class _TranslationsMoreEs implements _TranslationsMoreEn {
  _TranslationsMoreEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Más';
  @override
  String get title_long => 'Más acciones';
  @override
  late final _TranslationsMoreDataEs data = _TranslationsMoreDataEs._(_root);
  @override
  late final _TranslationsMoreAboutUsEs about_us =
      _TranslationsMoreAboutUsEs._(_root);
  @override
  late final _TranslationsMoreHelpUsEs help_us =
      _TranslationsMoreHelpUsEs._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardEs
    implements _TranslationsGeneralClipboardEn {
  _TranslationsGeneralClipboardEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String success({required Object x}) => '${x} copiado al portapapeles';
  @override
  String get error => 'Error al copiar';
}

// Path: general.time
class _TranslationsGeneralTimeEs implements _TranslationsGeneralTimeEn {
  _TranslationsGeneralTimeEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get start_date => 'Fecha de inicio';
  @override
  String get end_date => 'Fecha de fin';
  @override
  String get from_date => 'Desde fecha';
  @override
  String get until_date => 'Hasta fecha';
  @override
  String get date => 'Fecha';
  @override
  String get datetime => 'Fecha y hora';
  @override
  String get time => 'Hora';
  @override
  String get each => 'Cada';
  @override
  String get after => 'Tras';
  @override
  late final _TranslationsGeneralTimeRangesEs ranges =
      _TranslationsGeneralTimeRangesEs._(_root);
  @override
  late final _TranslationsGeneralTimePeriodicityEs periodicity =
      _TranslationsGeneralTimePeriodicityEs._(_root);
  @override
  late final _TranslationsGeneralTimeCurrentEs current =
      _TranslationsGeneralTimeCurrentEs._(_root);
  @override
  late final _TranslationsGeneralTimeAllEs all =
      _TranslationsGeneralTimeAllEs._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderEs
    implements _TranslationsGeneralTransactionOrderEn {
  _TranslationsGeneralTransactionOrderEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Ordenar transacciones';
  @override
  String get category => 'Por categoría';
  @override
  String get quantity => 'Por cantidad';
  @override
  String get date => 'Por fecha';
}

// Path: general.validations
class _TranslationsGeneralValidationsEs
    implements _TranslationsGeneralValidationsEn {
  _TranslationsGeneralValidationsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get required => 'Campo obligatorio';
  @override
  String get positive => 'Debe ser positivo';
  @override
  String min_number({required Object x}) => 'Debe ser mayor que ${x}';
  @override
  String max_number({required Object x}) => 'Debe ser menor que ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewEs
    implements _TranslationsFinancialHealthReviewEn {
  _TranslationsFinancialHealthReviewEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String very_good({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Excelente!';
      case GenderContext.female:
        return 'Excelente!';
    }
  }

  @override
  String good({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Bueno';
      case GenderContext.female:
        return 'Buena';
    }
  }

  @override
  String normal({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'En la media';
      case GenderContext.female:
        return 'En la media';
    }
  }

  @override
  String bad({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Regular';
      case GenderContext.female:
        return 'Regular';
    }
  }

  @override
  String very_bad({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Muy malo';
      case GenderContext.female:
        return 'Muy mala';
    }
  }

  @override
  String insufficient_data({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Datos insuficientes';
      case GenderContext.female:
        return 'Datos insuficientes';
    }
  }

  @override
  late final _TranslationsFinancialHealthReviewDescrEs descr =
      _TranslationsFinancialHealthReviewDescrEs._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeEs
    implements _TranslationsFinancialHealthMonthsWithoutIncomeEn {
  _TranslationsFinancialHealthMonthsWithoutIncomeEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ratio de supervivencia';
  @override
  String get subtitle =>
      'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos';
  @override
  String get text_zero =>
      '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!';
  @override
  String get text_one =>
      '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!';
  @override
  String text_other({required Object n}) =>
      'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.';
  @override
  String get text_infinite =>
      'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.';
  @override
  String get suggestion =>
      'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.';
  @override
  String get insufficient_data =>
      'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageEs
    implements _TranslationsFinancialHealthSavingsPercentageEn {
  _TranslationsFinancialHealthSavingsPercentageEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Porcentaje de ahorro';
  @override
  String get subtitle =>
      'Que parte de tus ingresos no son gastados en este periodo';
  @override
  late final _TranslationsFinancialHealthSavingsPercentageTextEs text =
      _TranslationsFinancialHealthSavingsPercentageTextEs._(_root);
  @override
  String get suggestion =>
      'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesEs
    implements _TranslationsIconSelectorScopesEn {
  _TranslationsIconSelectorScopesEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get transport => 'Transporte';
  @override
  String get money => 'Dinero';
  @override
  String get food => 'Comida';
  @override
  String get medical => 'Salud';
  @override
  String get entertainment => 'Entretenimiento';
  @override
  String get technology => 'Technología';
  @override
  String get other => 'Otros';
  @override
  String get logos_financial_institutions => 'Financial institutions';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsEs
    implements _TranslationsTransactionNextPaymentsEn {
  _TranslationsTransactionNextPaymentsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get skip => 'Saltar';
  @override
  String get skip_success => 'Transacción saltada con exito';
  @override
  String get skip_dialog_title => 'Saltar transacción';
  @override
  String skip_dialog_msg({required Object date}) =>
      'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}';
  @override
  String get accept => 'Aceptar';
  @override
  String get accept_today => 'Aceptar hoy';
  @override
  String accept_in_required_date({required Object date}) =>
      'Aceptar en la fecha requerida (${date})';
  @override
  String get accept_dialog_title => 'Aceptar transacción';
  @override
  String get accept_dialog_msg_single =>
      'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees';
  @override
  String accept_dialog_msg({required Object date}) =>
      'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones';
  @override
  String get recurrent_rule_finished =>
      'La regla recurrente se ha completado, ya no hay mas pagos a realizar!';
}

// Path: transaction.list
class _TranslationsTransactionListEs implements _TranslationsTransactionListEn {
  _TranslationsTransactionListEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get empty =>
      'No se han encontrado transacciones que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
  @override
  String get searcher_placeholder => 'Busca por categoría, descripción...';
  @override
  String get searcher_no_results =>
      'No se han encontrado transacciones que coincidan con los criterios de busqueda';
  @override
  String get loading => 'Cargando más transacciones...';
  @override
  String selected_short({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: '${n} seleccionada',
        other: '${n} seleccionadas',
      );
  @override
  String selected_long({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: '${n} transacción seleccionada',
        other: '${n} transacciones seleccionadas',
      );
  @override
  late final _TranslationsTransactionListBulkEditEs bulk_edit =
      _TranslationsTransactionListBulkEditEs._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersEs
    implements _TranslationsTransactionFiltersEn {
  _TranslationsTransactionFiltersEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get from_value => 'Desde monto';
  @override
  String get to_value => 'Hasta monto';
  @override
  String from_value_def({required Object x}) => 'Desde ${x}';
  @override
  String to_value_def({required Object x}) => 'Hasta ${x}';
  @override
  String from_date_def({required Object date}) => 'Desde el ${date}';
  @override
  String to_date_def({required Object date}) => 'Hasta el ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormEs implements _TranslationsTransactionFormEn {
  _TranslationsTransactionFormEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTransactionFormValidatorsEs validators =
      _TranslationsTransactionFormValidatorsEs._(_root);
  @override
  String get title => 'Título de la transacción';
  @override
  String get value => 'Valor de la transacción';
  @override
  String get tap_to_see_more => 'Toca para ver más detalles';
  @override
  String get description => 'Descripción';
  @override
  String get description_info =>
      'Añadir una nota te ayudará a encontrar más rapidamente esta transacción en un futuro';
  @override
  String exchange_to_preferred_title({required Object currency}) =>
      'Cambio a ${currency}';
  @override
  String get exchange_to_preferred_in_date => 'El día de la transacción';
}

// Path: transaction.status
class _TranslationsTransactionStatusEs
    implements _TranslationsTransactionStatusEn {
  _TranslationsTransactionStatusEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Estado',
        other: 'Estados',
      );
  @override
  String tr_status({required Object status}) => 'Transacción ${status}';
  @override
  String get none => 'Sin estado';
  @override
  String get reconciled => 'Reconciliada';
  @override
  String get reconciled_descr =>
      'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco';
  @override
  String get unreconciled => 'No reconciliada';
  @override
  String get unreconciled_descr =>
      'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin';
  @override
  String get pending => 'Pendiente';
  @override
  String get pending_descr =>
      'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas';
  @override
  String get voided => 'Nula';
  @override
  String get voided_descr =>
      'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas';
}

// Path: transaction.types
class _TranslationsTransactionTypesEs
    implements _TranslationsTransactionTypesEn {
  _TranslationsTransactionTypesEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Tipo de transacción',
        other: 'Tipos de transacción',
      );
  @override
  String income({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Ingreso',
        other: 'Ingresos',
      );
  @override
  String expense({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Gasto',
        other: 'Gastos',
      );
  @override
  String transfer({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Transferencia',
        other: 'Transferencias',
      );
}

// Path: transfer.form
class _TranslationsTransferFormEs implements _TranslationsTransferFormEn {
  _TranslationsTransferFormEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get from => 'Cuenta origen';
  @override
  String get to => 'Cuenta destino';
  @override
  String currency_info_add({required Object x}) =>
      'Se transpasarán ${x} a la cuenta de destino';
  @override
  String currency_info_edit({required Object x}) =>
      'Se han transpasado ${x} a la cuenta de destino';
  @override
  late final _TranslationsTransferFormCurrencyExchangeSelectorEs
      currency_exchange_selector =
      _TranslationsTransferFormCurrencyExchangeSelectorEs._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsEs
    implements _TranslationsRecurrentTransactionsDetailsEn {
  _TranslationsRecurrentTransactionsDetailsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Transaccion recurrente';
  @override
  String get descr =>
      'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento';
  @override
  String get last_payment_info =>
      'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción';
  @override
  String get delete_header => 'Eliminar transacción recurrente';
  @override
  String get delete_message =>
      'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado';
}

// Path: account.types
class _TranslationsAccountTypesEs implements _TranslationsAccountTypesEn {
  _TranslationsAccountTypesEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Tipo de cuenta';
  @override
  String get warning =>
      'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
  @override
  String get normal => 'Cuenta corriente';
  @override
  String get normal_descr =>
      'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
  @override
  String get saving => 'Cuenta de ahorros';
  @override
  String get saving_descr =>
      'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
}

// Path: account.form
class _TranslationsAccountFormEs implements _TranslationsAccountFormEn {
  _TranslationsAccountFormEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Nombre de la cuenta';
  @override
  String get name_placeholder => 'Ej: Cuenta de ahorros';
  @override
  String get notes => 'Notas';
  @override
  String get notes_placeholder =>
      'Escribe algunas notas/descripciones sobre esta cuenta';
  @override
  String get initial_balance => 'Balance inicial';
  @override
  String get current_balance => 'Balance actual';
  @override
  String get create => 'Crear cuenta';
  @override
  String get edit => 'Editar cuenta';
  @override
  String get tr_before_opening_date =>
      'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura';
  @override
  String get currency_not_found_warn =>
      'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes';
  @override
  String get already_exists =>
      'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
  @override
  String get iban => 'IBAN';
  @override
  String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteEs implements _TranslationsAccountDeleteEn {
  _TranslationsAccountDeleteEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get warning_header => '¿Eliminar cuenta?';
  @override
  String get warning_text =>
      'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.';
  @override
  String get success => 'Cuenta eliminada correctamente';
}

// Path: account.close
class _TranslationsAccountCloseEs implements _TranslationsAccountCloseEn {
  _TranslationsAccountCloseEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Cerrar cuenta';
  @override
  String get title_short => 'Cerrar';
  @override
  String get warn =>
      'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras';
  @override
  String get should_have_zero_balance =>
      'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar';
  @override
  String get should_have_no_transactions =>
      'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar';
  @override
  String get success => 'Cuenta cerrada exitosamente';
  @override
  String get unarchive_succes => 'Cuenta re-abierta exitosamente';
}

// Path: account.select
class _TranslationsAccountSelectEs implements _TranslationsAccountSelectEn {
  _TranslationsAccountSelectEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get one => 'Selecciona una cuenta';
  @override
  String get multiple => 'Selecciona cuentas';
  @override
  String get all => 'Todas las cuentas';
}

// Path: currencies.form
class _TranslationsCurrenciesFormEs implements _TranslationsCurrenciesFormEn {
  _TranslationsCurrenciesFormEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get equal_to_preferred_warn =>
      'The currency can not be equal to the user currency';
  @override
  String get specify_a_currency => 'Por favor, especifica una divisa';
  @override
  String get add => 'Añadir tipo de cambio';
  @override
  String get add_success => 'Tipo de cambio añadido correctamente';
  @override
  String get edit => 'Editar tipo de cambio';
  @override
  String get edit_success => 'Tipo de cambio editado correctamente';
}

// Path: tags.form
class _TranslationsTagsFormEs implements _TranslationsTagsFormEn {
  _TranslationsTagsFormEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Nombre de la etiqueta';
  @override
  String get description => 'Descripción';
}

// Path: categories.select
class _TranslationsCategoriesSelectEs
    implements _TranslationsCategoriesSelectEn {
  _TranslationsCategoriesSelectEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Selecciona categorías';
  @override
  String get select_one => 'Selecciona una categoría';
  @override
  String get select_subcategory => 'Elige una subcategoría';
  @override
  String get without_subcategory => 'Sin subcategoría';
  @override
  String get all => 'Todas las categorías';
  @override
  String get all_short => 'Todas';
}

// Path: budgets.form
class _TranslationsBudgetsFormEs implements _TranslationsBudgetsFormEn {
  _TranslationsBudgetsFormEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Añade un presupuesto';
  @override
  String get name => 'Nombre del presupuesto';
  @override
  String get value => 'Cantidad límite';
  @override
  String get create => 'Añade el presupuesto';
  @override
  String get edit => 'Editar presupuesto';
  @override
  String get negative_warn =>
      'Los presupuestos no pueden tener un valor límite negativo';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsEs implements _TranslationsBudgetsDetailsEn {
  _TranslationsBudgetsDetailsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Detalles del presupuesto';
  @override
  String get budget_value => 'Presupuestado';
  @override
  String get statistics => 'Estadísticas';
  @override
  String expend_diary_left(
          {required Object dailyAmount, required Object remainingDays}) =>
      'Puedes gastar ${dailyAmount}/día por los ${remainingDays} días restantes';
  @override
  String get expend_evolution => 'Evolución del gasto';
  @override
  String get no_transactions =>
      'Parece que no has realizado ningún gasto relativo a este presupuesto';
}

// Path: backup.export
class _TranslationsBackupExportEs implements _TranslationsBackupExportEn {
  _TranslationsBackupExportEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Exportar datos';
  @override
  String get title_short => 'Exportar';
  @override
  String get all => 'Respaldo total';
  @override
  String get all_descr =>
      'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
  @override
  String get transactions => 'Respaldo de transacciones';
  @override
  String get transactions_descr =>
      'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
  @override
  String get description => 'Exporta tus datos en diferentes formatos';
  @override
  String get dialog_title => 'Guardar/Enviar archivo';
  @override
  String success({required Object x}) =>
      'Archivo guardado/enviado correctamente en ${x}';
  @override
  String get error =>
      'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportEs implements _TranslationsBackupImportEn {
  _TranslationsBackupImportEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Importar tus datos';
  @override
  String get title_short => 'Importar';
  @override
  String get restore_backup => 'Restaurar copia de seguridad';
  @override
  String get restore_backup_descr =>
      'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos';
  @override
  String get restore_backup_warn_title => 'Sobreescribir todos los datos';
  @override
  String get restore_backup_warn_description =>
      'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin';
  @override
  String get tap_to_select_file => 'Pulsa para seleccionar un archivo';
  @override
  String get select_other_file => 'Selecciona otro fichero';
  @override
  late final _TranslationsBackupImportManualImportEs manual_import =
      _TranslationsBackupImportManualImportEs._(_root);
  @override
  String get success => 'Importación realizada con exito';
  @override
  String get cancelled => 'La importación fue cancelada por el usuario';
  @override
  String get error =>
      'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutEs implements _TranslationsBackupAboutEn {
  _TranslationsBackupAboutEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Información sobre tu base de datos';
  @override
  String get create_date => 'Fecha de creación';
  @override
  String get modify_date => 'Última modificación';
  @override
  String get last_backup => 'Última copia de seguridad';
  @override
  String get size => 'Tamaño';
}

// Path: more.data
class _TranslationsMoreDataEs implements _TranslationsMoreDataEn {
  _TranslationsMoreDataEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Datos';
  @override
  String get display_descr => 'Exporta y importa tus datos para no perder nada';
  @override
  String get delete_all => 'Eliminar mis datos';
  @override
  String get delete_all_header1 => 'Alto ahí padawan ⚠️⚠️';
  @override
  String get delete_all_message1 =>
      '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
  @override
  String get delete_all_header2 => 'Un último paso ⚠️⚠️';
  @override
  String get delete_all_message2 =>
      'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsEs implements _TranslationsMoreAboutUsEn {
  _TranslationsMoreAboutUsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Información de la app';
  @override
  String get description =>
      'Consulta los terminos y otra información relevante sobre Monekin. Ponte en contacto con la comunidad reportando errores, dejando sugerencias...';
  @override
  late final _TranslationsMoreAboutUsLegalEs legal =
      _TranslationsMoreAboutUsLegalEs._(_root);
  @override
  late final _TranslationsMoreAboutUsProjectEs project =
      _TranslationsMoreAboutUsProjectEs._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsEs implements _TranslationsMoreHelpUsEn {
  _TranslationsMoreHelpUsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Ayúdanos';
  @override
  String get description =>
      'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor';
  @override
  String get rate_us => 'Califícanos';
  @override
  String get rate_us_descr => '¡Cualquier valoración es bienvenida!';
  @override
  String get share => 'Comparte Monekin';
  @override
  String get share_descr => 'Comparte nuestra app a amigos y familiares';
  @override
  String get share_text =>
      'Monekin! La mejor app de finanzas personales. Descargala aquí';
  @override
  String get thanks => '¡Gracias!';
  @override
  String get thanks_long =>
      'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.';
  @override
  String get donate => 'Haz una donación';
  @override
  String get donate_descr =>
      'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?';
  @override
  String get donate_success =>
      'Donación realizada. Muchas gracias por tu contribución! ❤️';
  @override
  String get donate_err =>
      'Ups! Parece que ha habido un error a la hora de recibir tu pago';
  @override
  String get report => 'Reporta errores, deja sugerencias...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesEs
    implements _TranslationsGeneralTimeRangesEn {
  _TranslationsGeneralTimeRangesEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Rango temporal';
  @override
  String get it_repeat => 'Se repite';
  @override
  String get it_ends => 'Termina';
  @override
  late final _TranslationsGeneralTimeRangesTypesEs types =
      _TranslationsGeneralTimeRangesTypesEs._(_root);
  @override
  String each_range({required num n, required Object range}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Cada ${range}',
        other: 'Cada ${n} ${range}',
      );
  @override
  String each_range_until_date(
          {required num n, required Object range, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Cada ${range} hasta el ${day}',
        other: 'Cada ${n} ${range} hasta el ${day}',
      );
  @override
  String each_range_until_times(
          {required num n, required Object range, required Object limit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Cada ${range} ${limit} veces',
        other: 'Cada ${n} ${range} ${limit} veces',
      );
  @override
  String each_range_until_once({required num n, required Object range}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Cada ${range} una vez',
        other: 'Cada ${n} ${range} una vez',
      );
  @override
  String get forever => 'Para siempre';
  @override
  String month({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Mes',
        other: 'Meses',
      );
  @override
  String year({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Año',
        other: 'Años',
      );
  @override
  String day({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Día',
        other: 'Días',
      );
  @override
  String week({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Semana',
        other: 'Semanas',
      );
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityEs
    implements _TranslationsGeneralTimePeriodicityEn {
  _TranslationsGeneralTimePeriodicityEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Periodicidad';
  @override
  String get no_repeat => 'Sin repetición';
  @override
  String repeat({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        one: 'Repetición',
        other: 'Repeticiones',
      );
  @override
  String get diary => 'Diaría';
  @override
  String get monthly => 'Mensual';
  @override
  String get annually => 'Anual';
  @override
  String get quaterly => 'Trimestral';
  @override
  String get weekly => 'Semanal';
  @override
  String get custom => 'Personalizado';
  @override
  String get infinite => 'Siempre';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentEs
    implements _TranslationsGeneralTimeCurrentEn {
  _TranslationsGeneralTimeCurrentEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get diary => 'Este día';
  @override
  String get monthly => 'Este mes';
  @override
  String get annually => 'Este año';
  @override
  String get quaterly => 'Este trimestre';
  @override
  String get weekly => 'Esta semana';
  @override
  String get infinite => 'Desde siempre';
  @override
  String get custom => 'Rango personalizado';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllEs implements _TranslationsGeneralTimeAllEn {
  _TranslationsGeneralTimeAllEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get diary => 'Todos los días';
  @override
  String get monthly => 'Todos los meses';
  @override
  String get annually => 'Todos los años';
  @override
  String get quaterly => 'Todos los trimestres';
  @override
  String get weekly => 'Todas las semanas';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrEs
    implements _TranslationsFinancialHealthReviewDescrEn {
  _TranslationsFinancialHealthReviewDescrEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get insufficient_data =>
      'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!';
  @override
  String get very_good =>
      'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
  @override
  String get good =>
      'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
  @override
  String get normal =>
      'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
  @override
  String get bad =>
      'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas';
  @override
  String get very_bad =>
      'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextEs
    implements _TranslationsFinancialHealthSavingsPercentageTextEn {
  _TranslationsFinancialHealthSavingsPercentageTextEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String good({required Object value}) =>
      'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!';
  @override
  String normal({required Object value}) =>
      'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.';
  @override
  String bad({required Object value}) =>
      'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!';
  @override
  String get very_bad =>
      'Vaya, no has conseguido ahorrar nada durante este periodo.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditEs
    implements _TranslationsTransactionListBulkEditEn {
  _TranslationsTransactionListBulkEditEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get dates => 'Editar fechas';
  @override
  String get categories => 'Editar categorías';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsEs
    implements _TranslationsTransactionFormValidatorsEn {
  _TranslationsTransactionFormValidatorsEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get zero => 'El valor de una transacción no puede ser igual a cero';
  @override
  String get date_max =>
      'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente';
  @override
  String get date_after_account_creation =>
      'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece';
  @override
  String get negative_transaction =>
      'No uses cantidades negativas para tu transaccion. Aplicaremos el signo en función de si la categoría seleccionada es de tipo gasto/ingreso';
  @override
  String get negative_transfer =>
      'El valor monetario de una transferencia no puede ser negativo';
}

// Path: transfer.form.currency_exchange_selector
class _TranslationsTransferFormCurrencyExchangeSelectorEs
    implements _TranslationsTransferFormCurrencyExchangeSelectorEn {
  _TranslationsTransferFormCurrencyExchangeSelectorEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Editar cambio entre divisas';
  @override
  String get value_in_destiny => 'Cantidad transferida en destino';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportEs
    implements _TranslationsBackupImportManualImportEn {
  _TranslationsBackupImportManualImportEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Importación manual';
  @override
  String get descr =>
      'Importa transacciones desde un fichero .csv de forma manual';
  @override
  String get default_account => 'Cuenta por defecto';
  @override
  String get remove_default_account => 'Eliminar cuenta por defecto';
  @override
  String get default_category => 'Categoría por defecto';
  @override
  String get select_a_column => 'Selecciona una columna del .csv';
  @override
  String success({required Object x}) =>
      'Se han importado correctamente ${x} transacciones';
  @override
  List<String> get steps => [
        'Selecciona tu fichero',
        'Columna para la cantidad',
        'Columna para la cuenta',
        'Columna para la categoría',
        'Columna para la fecha',
        'Otras columnas',
      ];
  @override
  List<String> get steps_descr => [
        'Selecciona un fichero .csv de tu dispositivo. Asegurate de que este tenga una primera fila que describa el nombre de cada columna',
        'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos. Usa un punto como separador decimal',
        'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre',
        'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar',
        'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual',
        'Especifica las columnas para otros atributos optativos de las transacciones',
      ];
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalEs
    implements _TranslationsMoreAboutUsLegalEn {
  _TranslationsMoreAboutUsLegalEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Información legal';
  @override
  String get privacy => 'Política de privacidad';
  @override
  String get terms => 'Términos de uso';
  @override
  String get licenses => 'Licencias';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectEs
    implements _TranslationsMoreAboutUsProjectEn {
  _TranslationsMoreAboutUsProjectEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Proyecto';
  @override
  String get contributors => 'Colaboradores';
  @override
  String get contributors_descr =>
      'Todos los desarrolladores que han hecho que Monekin crezca';
  @override
  String get contact => 'Contacta con nosotros';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesEs
    implements _TranslationsGeneralTimeRangesTypesEn {
  _TranslationsGeneralTimeRangesTypesEs._(this._root);

  @override
  final _TranslationsEs _root; // ignore: unused_field

  // Translations
  @override
  String get cycle => 'Ciclos';
  @override
  String get last_days => 'Últimos días';
  @override
  String last_days_form({required Object x}) => '${x} días anteriores';
  @override
  String get all => 'Siempre';
  @override
  String get date_range => 'Rango personalizado';
}

// Path: <root>
class _TranslationsUk implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _TranslationsUk.build(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.uk,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <uk>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  @override
  late final _TranslationsUk _root = this; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsGeneralUk general = _TranslationsGeneralUk._(_root);
  @override
  late final _TranslationsIntroUk intro = _TranslationsIntroUk._(_root);
  @override
  late final _TranslationsHomeUk home = _TranslationsHomeUk._(_root);
  @override
  late final _TranslationsFinancialHealthUk financial_health =
      _TranslationsFinancialHealthUk._(_root);
  @override
  late final _TranslationsStatsUk stats = _TranslationsStatsUk._(_root);
  @override
  late final _TranslationsIconSelectorUk icon_selector =
      _TranslationsIconSelectorUk._(_root);
  @override
  late final _TranslationsTransactionUk transaction =
      _TranslationsTransactionUk._(_root);
  @override
  late final _TranslationsTransferUk transfer =
      _TranslationsTransferUk._(_root);
  @override
  late final _TranslationsRecurrentTransactionsUk recurrent_transactions =
      _TranslationsRecurrentTransactionsUk._(_root);
  @override
  late final _TranslationsAccountUk account = _TranslationsAccountUk._(_root);
  @override
  late final _TranslationsCurrenciesUk currencies =
      _TranslationsCurrenciesUk._(_root);
  @override
  late final _TranslationsTagsUk tags = _TranslationsTagsUk._(_root);
  @override
  late final _TranslationsCategoriesUk categories =
      _TranslationsCategoriesUk._(_root);
  @override
  late final _TranslationsBudgetsUk budgets = _TranslationsBudgetsUk._(_root);
  @override
  late final _TranslationsBackupUk backup = _TranslationsBackupUk._(_root);
  @override
  late final _TranslationsSettingsUk settings =
      _TranslationsSettingsUk._(_root);
  @override
  late final _TranslationsMoreUk more = _TranslationsMoreUk._(_root);
}

// Path: general
class _TranslationsGeneralUk implements _TranslationsGeneralEn {
  _TranslationsGeneralUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'Скасувати';
  @override
  String get or => 'або';
  @override
  String get understood => 'Зрозуміло';
  @override
  String get unspecified => 'Не вказано';
  @override
  String get confirm => 'Підтвердити';
  @override
  String get continue_text => 'Продовжити';
  @override
  String get quick_actions => 'Швидкі дії';
  @override
  String get save => 'Зберегти';
  @override
  String get save_changes => 'Зберегти зміни';
  @override
  String get close_and_save => 'Закрити та зберегти';
  @override
  String get add => 'Додати';
  @override
  String get edit => 'Редагувати';
  @override
  String get balance => 'Баланс';
  @override
  String get delete => 'Видалити';
  @override
  String get account => 'Рахунок';
  @override
  String get accounts => 'Рахунки';
  @override
  String get categories => 'Категорії';
  @override
  String get category => 'Категорія';
  @override
  String get today => 'Сьогодні';
  @override
  String get yesterday => 'Вчора';
  @override
  String get filters => 'Фільтри';
  @override
  String get select_all => 'Вибрати всі';
  @override
  String get deselect_all => 'Скасувати вибір усіх';
  @override
  String get empty_warn => 'Ой! Тут порожньо';
  @override
  String get insufficient_data => 'Недостатньо даних';
  @override
  String get show_more_fields => 'Показати більше полів';
  @override
  String get show_less_fields => 'Показати менше полів';
  @override
  late final _TranslationsGeneralClipboardUk clipboard =
      _TranslationsGeneralClipboardUk._(_root);
  @override
  late final _TranslationsGeneralTimeUk time =
      _TranslationsGeneralTimeUk._(_root);
  @override
  late final _TranslationsGeneralTransactionOrderUk transaction_order =
      _TranslationsGeneralTransactionOrderUk._(_root);
  @override
  late final _TranslationsGeneralValidationsUk validations =
      _TranslationsGeneralValidationsUk._(_root);
}

// Path: intro
class _TranslationsIntroUk implements _TranslationsIntroEn {
  _TranslationsIntroUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get start => 'Початок';
  @override
  String get skip => 'Пропустити';
  @override
  String get next => 'Далі';
  @override
  String get select_your_currency => 'Виберіть вашу валюту';
  @override
  String get welcome_subtitle => 'Ваш особистий фінансовий менеджер';
  @override
  String get welcome_subtitle2 => '100% відкритий, 100% безкоштовний';
  @override
  String get welcome_footer =>
      'Увійшовши в систему, ви погоджуєтеся з <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Політикою конфіденційності</a> та <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Умовами використання</a> додатка';
  @override
  String get offline_descr_title => 'ОФЛАЙН-РЕЖИМ:';
  @override
  String get offline_descr =>
      'Ваші дані будуть збережені тільки на вашому пристрої, поки ви не видалите програму або не зміните телефон. Щоб запобігти втраті даних, рекомендується регулярно робити резервні копії з налаштувань програми.';
  @override
  String get offline_start => 'Почати сеанс офлайн';
  @override
  String get sl1_title => 'Виберіть вашу валюту';
  @override
  String get sl1_descr =>
      'Ваша основна валюта буде використовуватися в звітах та загальних діаграмах. Ви зможете змінити валюту та мову програми пізніше в будь-який час у налаштуваннях додатка';
  @override
  String get sl2_title => 'Безпечно, приватно і надійно';
  @override
  String get sl2_descr =>
      'Ваші дані належать тільки вам. Інформація зберігається безпосередньо на вашому пристрої, без пропуску через зовнішні сервери. Це дозволяє використовувати додаток навіть без Інтернету';
  @override
  String get sl2_descr2 =>
      'Крім того, вихідний код програми є відкритим, будь-хто може вносити свої правки та переглядати, як він працює';
  @override
  String get last_slide_title => 'Все готово';
  @override
  String get last_slide_descr =>
      'З Monekin ви нарешті можете досягти фінансової незалежності, яку так багато хочете. У вас будуть графіки, бюджети, поради, статистика та багато іншого про ваші фінанси.';
  @override
  String get last_slide_descr2 =>
      'Сподіваємося, вам сподобається користуватись додатком! Не соромтеся зв\'язатися з нами у разі сумнівів або пропозицій...';
}

// Path: home
class _TranslationsHomeUk implements _TranslationsHomeEn {
  _TranslationsHomeUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Панель керування';
  @override
  String get filter_transactions => 'Фільтрувати транзакції';
  @override
  String get hello_day => 'Доброго ранку,';
  @override
  String get hello_night => 'Доброї ночі,';
  @override
  String get total_balance => 'Загальний баланс';
  @override
  String get my_accounts => 'Мої рахунки';
  @override
  String get active_accounts => 'Активні рахунки';
  @override
  String get no_accounts => 'Рахунки ще не створені';
  @override
  String get no_accounts_descr =>
      'Почніть використовувати всю магію Monekin. Створіть принаймні один рахунок, щоб почати додавати транзакції';
  @override
  String get last_transactions => 'Останні транзакції';
  @override
  String get should_create_account_header => 'Ой!';
  @override
  String get should_create_account_message =>
      'Перш ніж почати створювати транзакції, вам потрібно мати принаймні один неархівований рахунок';
}

// Path: financial_health
class _TranslationsFinancialHealthUk implements _TranslationsFinancialHealthEn {
  _TranslationsFinancialHealthUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Фінансове здоров\'я';
  @override
  late final _TranslationsFinancialHealthReviewUk review =
      _TranslationsFinancialHealthReviewUk._(_root);
  @override
  late final _TranslationsFinancialHealthMonthsWithoutIncomeUk
      months_without_income =
      _TranslationsFinancialHealthMonthsWithoutIncomeUk._(_root);
  @override
  late final _TranslationsFinancialHealthSavingsPercentageUk
      savings_percentage =
      _TranslationsFinancialHealthSavingsPercentageUk._(_root);
}

// Path: stats
class _TranslationsStatsUk implements _TranslationsStatsEn {
  _TranslationsStatsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Статистика';
  @override
  String get balance => 'Баланс';
  @override
  String get final_balance => 'Кінцевий баланс';
  @override
  String get balance_by_account => 'Баланс за рахунками';
  @override
  String get balance_by_currency => 'Баланс за валютами';
  @override
  String get cash_flow => 'Грошовий потік';
  @override
  String get balance_evolution => 'Еволюція балансу';
  @override
  String get compared_to_previous_period => 'Порівняно з попереднім періодом';
  @override
  String get by_periods => 'За періодами';
  @override
  String get by_categories => 'За категоріями';
  @override
  String get by_tags => 'За тегами';
  @override
  String get distribution => 'Розподіл';
  @override
  String get finance_health_resume => 'Підсумок фінансового здоров\'я';
  @override
  String get finance_health_breakdown =>
      'Детальний аналіз фінансового здоров\'я';
}

// Path: icon_selector
class _TranslationsIconSelectorUk implements _TranslationsIconSelectorEn {
  _TranslationsIconSelectorUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Назва:';
  @override
  String get icon => 'Іконка';
  @override
  String get color => 'Колір';
  @override
  String get select_color => 'Виберіть колір';
  @override
  String get select_icon => 'Виберіть іконку';
  @override
  String get select_account_icon => 'Ідентифікуйте ваш рахунок';
  @override
  String get select_category_icon => 'Ідентифікуйте вашу категорію';
  @override
  late final _TranslationsIconSelectorScopesUk scopes =
      _TranslationsIconSelectorScopesUk._(_root);
}

// Path: transaction
class _TranslationsTransactionUk implements _TranslationsTransactionEn {
  _TranslationsTransactionUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Транзакція',
        other: 'Транзакції',
      );
  @override
  String get create => 'Нова транзакція';
  @override
  String get new_income => 'Новий дохід';
  @override
  String get new_expense => 'Новий витрати';
  @override
  String get new_success => 'Транзакція успішно створена';
  @override
  String get edit => 'Редагувати транзакцію';
  @override
  String get edit_success => 'Транзакція успішно відредагована';
  @override
  String get edit_multiple => 'редагувати транзакції';
  @override
  String edit_multiple_success({required Object x}) =>
      '${x} належним чином відредаговані транзакції';
  @override
  String get duplicate => 'Клонувати транзакцію';
  @override
  String get duplicate_short => 'Клон';
  @override
  String get duplicate_warning_message =>
      'Транзакція, ідентична цій, буде створена з такою ж датою. Бажаєте продовжити?';
  @override
  String get duplicate_success => 'Транзакція успішно склонована';
  @override
  String get delete => 'Видалити транзакцію';
  @override
  String get delete_warning_message =>
      'Ця дія незворотня. Поточний баланс ваших рахунків і всі ваші статистичні дані будуть перераховані';
  @override
  String get delete_success => 'Транзакцію успішно видалено';
  @override
  String get delete_multiple => 'Усунути транзакції';
  @override
  String delete_multiple_warning_message({required Object x}) =>
      'Ця дія незворотна і безумовно стерть ${x} транзакції. Поточний баланс ваших рахунків та вся ваша статистика будуть перенесені';
  @override
  String delete_multiple_success({required Object x}) =>
      '${x} належним чином усунути транзакції';
  @override
  String get details => 'Деталі руху коштів';
  @override
  late final _TranslationsTransactionNextPaymentsUk next_payments =
      _TranslationsTransactionNextPaymentsUk._(_root);
  @override
  late final _TranslationsTransactionListUk list =
      _TranslationsTransactionListUk._(_root);
  @override
  late final _TranslationsTransactionFiltersUk filters =
      _TranslationsTransactionFiltersUk._(_root);
  @override
  late final _TranslationsTransactionFormUk form =
      _TranslationsTransactionFormUk._(_root);
  @override
  late final _TranslationsTransactionStatusUk status =
      _TranslationsTransactionStatusUk._(_root);
  @override
  late final _TranslationsTransactionTypesUk types =
      _TranslationsTransactionTypesUk._(_root);
}

// Path: transfer
class _TranslationsTransferUk implements _TranslationsTransferEn {
  _TranslationsTransferUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Переказ';
  @override
  String get transfers => 'Перекази';
  @override
  String transfer_to({required Object account}) => 'Переказ на ${account}';
  @override
  String get create => 'Новий переказ';
  @override
  String get need_two_accounts_warning_header => 'Увага!';
  @override
  String get need_two_accounts_warning_message =>
      'Для виконання цієї дії потрібно щонайменше два рахунки. Якщо вам потрібно відредагувати поточний баланс цього рахунку, натисніть кнопку редагування';
  @override
  late final _TranslationsTransferFormUk form =
      _TranslationsTransferFormUk._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsUk
    implements _TranslationsRecurrentTransactionsEn {
  _TranslationsRecurrentTransactionsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Повторювані транзакції';
  @override
  String get title_short => 'Повт. транзакції';
  @override
  String get empty =>
      'Схоже, у вас немає жодних повторюваних транзакцій. Створіть щомісячну, щорічну або щотижневу повторювану транзакцію, і вона з\'явиться тут';
  @override
  String get total_expense_title => 'Загальні витрати за період';
  @override
  String get total_expense_descr =>
      '* Без урахування початкової та кінцевої дати кожної повторюваної транзакції';
  @override
  late final _TranslationsRecurrentTransactionsDetailsUk details =
      _TranslationsRecurrentTransactionsDetailsUk._(_root);
}

// Path: account
class _TranslationsAccountUk implements _TranslationsAccountEn {
  _TranslationsAccountUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get details => 'Деталі рахунку';
  @override
  String get date => 'Дата відкриття';
  @override
  String get close_date => 'Дата закриття';
  @override
  String get reopen => 'Повторно відкрити рахунок';
  @override
  String get reopen_short => 'Повторно відкрити';
  @override
  String get reopen_descr =>
      'Ви впевнені, що хочете повторно відкрити цей рахунок?';
  @override
  String get balance => 'Баланс рахунку';
  @override
  String get n_transactions => 'Кількість транзакцій';
  @override
  String get add_money => 'Додати кошти';
  @override
  String get withdraw_money => 'Зняти кошти';
  @override
  String get no_accounts =>
      'Тут не знайдено жодних транзакцій для відображення. Додайте транзакцію, натиснувши кнопку \'+\' внизу';
  @override
  late final _TranslationsAccountTypesUk types =
      _TranslationsAccountTypesUk._(_root);
  @override
  late final _TranslationsAccountFormUk form =
      _TranslationsAccountFormUk._(_root);
  @override
  late final _TranslationsAccountDeleteUk delete =
      _TranslationsAccountDeleteUk._(_root);
  @override
  late final _TranslationsAccountCloseUk close =
      _TranslationsAccountCloseUk._(_root);
  @override
  late final _TranslationsAccountSelectUk select =
      _TranslationsAccountSelectUk._(_root);
}

// Path: currencies
class _TranslationsCurrenciesUk implements _TranslationsCurrenciesEn {
  _TranslationsCurrenciesUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get currency_converter => 'Конвертер валют';
  @override
  String get currency => 'Валюта';
  @override
  String get currency_manager => 'Менеджер валют';
  @override
  String get currency_manager_descr =>
      'Налаштуйте вашу валюту та її обмінні курси з іншими';
  @override
  String get preferred_currency => 'Перевагова/базова валюта';
  @override
  String get change_preferred_currency_title => 'Змінити перевагову валюту';
  @override
  String get change_preferred_currency_msg =>
      'Усі статистичні дані та бюджети будуть відображатися в цій валюті відтепер. Рахунки та транзакції залишаться у тій валюті, яку вони мали. Усі збережені обмінні курси будуть видалені, якщо ви виконаєте цю дію. Ви хочете продовжити?';
  @override
  late final _TranslationsCurrenciesFormUk form =
      _TranslationsCurrenciesFormUk._(_root);
  @override
  String get delete_all_success => 'Обмінні курси успішно видалено';
  @override
  String get historical => 'Історичні курси';
  @override
  String get exchange_rate => 'Обмінний курс';
  @override
  String get exchange_rates => 'Обмінні курси';
  @override
  String get empty =>
      'Додайте тут обмінні курси, щоб, якщо у вас є рахунки в інших валютах, наші графіки були б точнішими';
  @override
  String get select_a_currency => 'Виберіть валюту';
  @override
  String get search_title => 'Натисніть для пошуку';
  @override
  String get search_placeholder => 'Пошук за назвою або кодом валюти';
}

// Path: tags
class _TranslationsTagsUk implements _TranslationsTagsEn {
  _TranslationsTagsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Мітка',
        other: 'Теги',
      );
  @override
  late final _TranslationsTagsFormUk form = _TranslationsTagsFormUk._(_root);
  @override
  String get empty_list =>
      'Ви ще не створили жодних тегів. Теги та категорії - це відмінний спосіб категоризувати ваші рухи';
  @override
  String get without_tags => 'Без тегів';
  @override
  String get select => 'Вибрати теги';
  @override
  String get add => 'Додати тег';
  @override
  String get create => 'Створити мітку';
  @override
  String get create_success => 'Мітка успішно створена';
  @override
  String get already_exists =>
      'Ця назва тегу вже існує. Ви можете відредагувати її';
  @override
  String get edit => 'Редагувати тег';
  @override
  String get edit_success => 'Тег успішно відредаговано';
  @override
  String get delete_success => 'Тег успішно видалено';
  @override
  String get delete_warning_header => 'Видалити тег?';
  @override
  String get delete_warning_message =>
      'Ця дія не призведе до видалення транзакцій, які мають цей тег.';
}

// Path: categories
class _TranslationsCategoriesUk implements _TranslationsCategoriesEn {
  _TranslationsCategoriesUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get unknown => 'Невідома категорія';
  @override
  String get create => 'Створити категорію';
  @override
  String get create_success => 'Категорія успішно створена';
  @override
  String get new_category => 'Нова категорія';
  @override
  String get already_exists =>
      'Така назва категорії вже існує. Можливо, ви хочете відредагувати її';
  @override
  String get edit => 'Редагувати категорію';
  @override
  String get edit_success => 'Категорію успішно відредаговано';
  @override
  String get name => 'Назва категорії';
  @override
  String get type => 'Тип категорії';
  @override
  String get both_types => 'Обидва типи';
  @override
  String get subcategories => 'Підкатегорії';
  @override
  String get subcategories_add => 'Додати підкатегорію';
  @override
  String get make_parent => 'Зробити батьківською категорією';
  @override
  String get make_child => 'Зробити підкатегорією';
  @override
  String make_child_warning1({required Object destiny}) =>
      'Ця категорія та її підкатегорії стануть підкатегоріями <b>${destiny}</b>.';
  @override
  String make_child_warning2({required Object x, required Object destiny}) =>
      'Їх транзакції <b>(${x})</b> будуть перенесені до нових підкатегорій, створених всередині категорії <b>${destiny}</b>.';
  @override
  String get make_child_success => 'Підкатегорії успішно створено';
  @override
  String get merge => 'Об\'єднати з іншою категорією';
  @override
  String merge_warning1(
          {required Object x, required Object from, required Object destiny}) =>
      'Всі транзакції (${x}), пов\'язані з категорією <b>${from}</b>, будуть перенесені до категорії <b>${destiny}</b>';
  @override
  String merge_warning2({required Object from}) =>
      'Категорія <b>${from}</b> буде безповоротно видалена.';
  @override
  String get merge_success => 'Категорії успішно об\'єднані';
  @override
  String get delete_success => 'Категорію видалено коректно';
  @override
  String get delete_warning_header => 'Видалити категорію?';
  @override
  String delete_warning_message({required Object x}) =>
      'Ця дія незворотно видалить всі транзакції <b>(${x})</b>, пов\'язані з цією категорією.';
  @override
  late final _TranslationsCategoriesSelectUk select =
      _TranslationsCategoriesSelectUk._(_root);
}

// Path: budgets
class _TranslationsBudgetsUk implements _TranslationsBudgetsEn {
  _TranslationsBudgetsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Бюджети';
  @override
  String get repeated => 'Повторювані';
  @override
  String get one_time => 'Одноразові';
  @override
  String get annual => 'Щорічні';
  @override
  String get week => 'Щотижневі';
  @override
  String get month => 'Щомісячні';
  @override
  String get actives => 'Активні';
  @override
  String get pending => 'Очікує початку';
  @override
  String get finish => 'Завершені';
  @override
  String get from_budgeted => 'з ';
  @override
  String get days_left => 'днів залишилось';
  @override
  String get days_to_start => 'днів до початку';
  @override
  String get since_expiration => 'днів після закінчення терміну';
  @override
  String get no_budgets =>
      'Здається, що в цьому розділі немає жодних бюджетів для відображення. Розпочніть з створення бюджету, натиснувши кнопку нижче';
  @override
  String get delete => 'Видалити бюджет';
  @override
  String get delete_warning =>
      'Ця дія незворотня. Категорії та транзакції, що стосуються цитати, не будуть видалені';
  @override
  late final _TranslationsBudgetsFormUk form =
      _TranslationsBudgetsFormUk._(_root);
  @override
  late final _TranslationsBudgetsDetailsUk details =
      _TranslationsBudgetsDetailsUk._(_root);
}

// Path: backup
class _TranslationsBackupUk implements _TranslationsBackupEn {
  _TranslationsBackupUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsBackupExportUk export =
      _TranslationsBackupExportUk._(_root);
  @override
  late final _TranslationsBackupImportUk import =
      _TranslationsBackupImportUk._(_root);
  @override
  late final _TranslationsBackupAboutUk about =
      _TranslationsBackupAboutUk._(_root);
}

// Path: settings
class _TranslationsSettingsUk implements _TranslationsSettingsEn {
  _TranslationsSettingsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title_long => 'Налаштування та вигляд';
  @override
  String get title_short => 'Налаштування';
  @override
  String get description =>
      'Тема додатку, тексти та інші загальні налаштування';
  @override
  String get edit_profile => 'Редагувати профіль';
  @override
  String get lang_section => 'Мова та тексти';
  @override
  String get lang_title => 'Мова додатку';
  @override
  String get lang_descr => 'Мова, в якій будуть відображатися тексти в додатку';
  @override
  String get locale => 'Регіон';
  @override
  String get locale_descr =>
      'Встановіть формат, який буде використовуватися для дат, чисел...';
  @override
  String get locale_warn => 'Після зміни регіону додаток оновиться';
  @override
  String get first_day_of_week => 'Перший день тижня';
  @override
  String get theme_and_colors => 'Тема та кольори';
  @override
  String get theme => 'Тема';
  @override
  String get theme_auto => 'Визначено системою';
  @override
  String get theme_light => 'Світла';
  @override
  String get theme_dark => 'Темна';
  @override
  String get amoled_mode => 'Режим AMOLED';
  @override
  String get amoled_mode_descr =>
      'Використовуйте чисто чорний шпалери, якщо це можливо. Це трохи допоможе акумулятору пристроїв з екранами AMOLED';
  @override
  String get dynamic_colors => 'Динамічні кольори';
  @override
  String get dynamic_colors_descr =>
      'Використовуйте колір акценту вашої системи, коли це можливо';
  @override
  String get accent_color => 'Колір акценту';
  @override
  String get accent_color_descr =>
      'Виберіть колір, який додаток буде використовувати для виділення певних частин інтерфейсу';
}

// Path: more
class _TranslationsMoreUk implements _TranslationsMoreEn {
  _TranslationsMoreUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Більше';
  @override
  String get title_long => 'Більше дій';
  @override
  late final _TranslationsMoreDataUk data = _TranslationsMoreDataUk._(_root);
  @override
  late final _TranslationsMoreAboutUsUk about_us =
      _TranslationsMoreAboutUsUk._(_root);
  @override
  late final _TranslationsMoreHelpUsUk help_us =
      _TranslationsMoreHelpUsUk._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardUk
    implements _TranslationsGeneralClipboardEn {
  _TranslationsGeneralClipboardUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String success({required Object x}) => '${x} скопійовано в буфер обміну';
  @override
  String get error => 'Помилка копіювання';
}

// Path: general.time
class _TranslationsGeneralTimeUk implements _TranslationsGeneralTimeEn {
  _TranslationsGeneralTimeUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get start_date => 'Початкова дата';
  @override
  String get end_date => 'Кінцева дата';
  @override
  String get from_date => 'З дати';
  @override
  String get until_date => 'До дати';
  @override
  String get date => 'Дата';
  @override
  String get datetime => 'Дата та час';
  @override
  String get time => 'Час';
  @override
  String get each => 'Кожний';
  @override
  String get after => 'Після';
  @override
  late final _TranslationsGeneralTimeRangesUk ranges =
      _TranslationsGeneralTimeRangesUk._(_root);
  @override
  late final _TranslationsGeneralTimePeriodicityUk periodicity =
      _TranslationsGeneralTimePeriodicityUk._(_root);
  @override
  late final _TranslationsGeneralTimeCurrentUk current =
      _TranslationsGeneralTimeCurrentUk._(_root);
  @override
  late final _TranslationsGeneralTimeAllUk all =
      _TranslationsGeneralTimeAllUk._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderUk
    implements _TranslationsGeneralTransactionOrderEn {
  _TranslationsGeneralTransactionOrderUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Сортувати транзакції';
  @override
  String get category => 'За категорією';
  @override
  String get quantity => 'За кількістю';
  @override
  String get date => 'За датою';
}

// Path: general.validations
class _TranslationsGeneralValidationsUk
    implements _TranslationsGeneralValidationsEn {
  _TranslationsGeneralValidationsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get required => 'Обов\'язкове поле';
  @override
  String get positive => 'Повинно бути позитивним';
  @override
  String min_number({required Object x}) => 'Повинно бути більшим, ніж ${x}';
  @override
  String max_number({required Object x}) => 'Повинно бути меншим, ніж ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewUk
    implements _TranslationsFinancialHealthReviewEn {
  _TranslationsFinancialHealthReviewUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String very_good({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Дуже добре!';
      case GenderContext.female:
        return 'Дуже добре!';
    }
  }

  @override
  String good({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Добре';
      case GenderContext.female:
        return 'Добре';
    }
  }

  @override
  String normal({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Середнє';
      case GenderContext.female:
        return 'Середнє';
    }
  }

  @override
  String bad({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Прийнятно';
      case GenderContext.female:
        return 'Прийнятно';
    }
  }

  @override
  String very_bad({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Дуже погано';
      case GenderContext.female:
        return 'Дуже погано';
    }
  }

  @override
  String insufficient_data({required GenderContext context}) {
    switch (context) {
      case GenderContext.male:
        return 'Недостатньо даних';
      case GenderContext.female:
        return 'Недостатньо даних';
    }
  }

  @override
  late final _TranslationsFinancialHealthReviewDescrUk descr =
      _TranslationsFinancialHealthReviewDescrUk._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeUk
    implements _TranslationsFinancialHealthMonthsWithoutIncomeEn {
  _TranslationsFinancialHealthMonthsWithoutIncomeUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Шанси на виживання';
  @override
  String get subtitle =>
      'З урахуванням вашого балансу, час, на який ви можете обійтися без доходу';
  @override
  String get text_zero =>
      'Ви не могли б прожити місяць без доходу з такою швидкістю витрат!';
  @override
  String get text_one =>
      'Ви ледве могли б прожити близько місяця без доходу з такою швидкістю витрат!';
  @override
  String text_other({required Object n}) =>
      'Ви могли б прожити приблизно <b>${n} місяців</b> без доходу з такою швидкістю витрат.';
  @override
  String get text_infinite =>
      'Ви могли б прожити приблизно <b>майже все своє життя</b> без доходу з такою швидкістю витрат.';
  @override
  String get suggestion =>
      'Пам\'ятайте, що рекомендується завжди тримати цей відсоток не менше 5 місяців. Якщо ви бачите, що у вас недостатньо збережень, зменште непотрібні витрати.';
  @override
  String get insufficient_data =>
      'Схоже, у нас недостатньо витрат, щоб розрахувати, на скільки місяців ви можете вижити без доходу. Введіть кілька транзакцій і повертайтесь сюди, щоб перевірити ваше фінансове здоров\'я';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageUk
    implements _TranslationsFinancialHealthSavingsPercentageEn {
  _TranslationsFinancialHealthSavingsPercentageUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Відсоток заощаджень';
  @override
  String get subtitle => 'Яка частина вашого доходу не витрачена за цей період';
  @override
  late final _TranslationsFinancialHealthSavingsPercentageTextUk text =
      _TranslationsFinancialHealthSavingsPercentageTextUk._(_root);
  @override
  String get suggestion =>
      'Пам\'ятайте, що рекомендується заощаджувати принаймні 15-20% від вашого доходу.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesUk
    implements _TranslationsIconSelectorScopesEn {
  _TranslationsIconSelectorScopesUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get transport => 'Транспорт';
  @override
  String get money => 'Гроші';
  @override
  String get food => 'Їжа';
  @override
  String get medical => 'Медицина';
  @override
  String get entertainment => 'Розваги';
  @override
  String get technology => 'Технології';
  @override
  String get other => 'Інше';
  @override
  String get logos_financial_institutions => 'Фінансові установи';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsUk
    implements _TranslationsTransactionNextPaymentsEn {
  _TranslationsTransactionNextPaymentsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get accept => 'Прийняти';
  @override
  String get skip => 'Пропустити';
  @override
  String get skip_success => 'Транзакцію успішно пропущено';
  @override
  String get skip_dialog_title => 'Пропустити транзакцію';
  @override
  String skip_dialog_msg({required Object date}) =>
      'Ця дія незворотня. Ми перемістимо дату наступного переходу до ${date}';
  @override
  String get accept_today => 'Прийняти сьогодні';
  @override
  String accept_in_required_date({required Object date}) =>
      'Прийняти в потрібну дату (${date})';
  @override
  String get accept_dialog_title => 'Прийняти транзакцію';
  @override
  String get accept_dialog_msg_single =>
      'Новий статус транзакції буде нульовим. Ви можете знову редагувати статус цієї транзакції в будь-який момент';
  @override
  String accept_dialog_msg({required Object date}) =>
      'Ця дія створить нову транзакцію з датою ${date}. Ви зможете переглянути деталі цієї транзакції на сторінці транзакцій';
  @override
  String get recurrent_rule_finished =>
      'Правило періодичності було завершено, більше немає платежів!';
}

// Path: transaction.list
class _TranslationsTransactionListUk implements _TranslationsTransactionListEn {
  _TranslationsTransactionListUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get empty =>
      'Тут не знайдено жодних транзакцій для відображення. Додайте транзакцію, натиснувши кнопку \'+\' внизу';
  @override
  String get searcher_placeholder => 'Шукати за категорією, описом...';
  @override
  String get searcher_no_results =>
      'Не знайдено транзакцій, що відповідають критеріям пошуку';
  @override
  String get loading => 'Завантаження додаткових транзакцій...';
  @override
  String selected_short({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: '${n} вибрано',
        other: 'вибрано ${n}',
      );
  @override
  String selected_long({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: '${n} вибрана транзакція',
        other: '${n} вибраних транзакцій',
      );
  @override
  late final _TranslationsTransactionListBulkEditUk bulk_edit =
      _TranslationsTransactionListBulkEditUk._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersUk
    implements _TranslationsTransactionFiltersEn {
  _TranslationsTransactionFiltersUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get from_value => 'Від суми';
  @override
  String get to_value => 'До суми';
  @override
  String from_value_def({required Object x}) => 'Від ${x}';
  @override
  String to_value_def({required Object x}) => 'До ${x}';
  @override
  String from_date_def({required Object date}) => 'З ${date}';
  @override
  String to_date_def({required Object date}) => 'До ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormUk implements _TranslationsTransactionFormEn {
  _TranslationsTransactionFormUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTransactionFormValidatorsUk validators =
      _TranslationsTransactionFormValidatorsUk._(_root);
  @override
  String get title => 'Назва транзакції';
  @override
  String get value => 'Сума транзакції';
  @override
  String get tap_to_see_more => 'Натисніть, щоб побачити більше деталей';
  @override
  String get description => 'Опис';
  @override
  String get description_info =>
      'Додавання примітки допоможе вам швидше знайти цю транзакцію у майбутньому';
  @override
  String exchange_to_preferred_title({required Object currency}) =>
      'Обмінний курс на ${currency}';
  @override
  String get exchange_to_preferred_in_date => 'На дату транзакції';
}

// Path: transaction.status
class _TranslationsTransactionStatusUk
    implements _TranslationsTransactionStatusEn {
  _TranslationsTransactionStatusUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Статус',
        other: 'Статуси',
      );
  @override
  String tr_status({required Object status}) => '${status} транзакція';
  @override
  String get none => 'Без статусу';
  @override
  String get reconciled => 'Узгоджений';
  @override
  String get reconciled_descr =>
      'Ця транзакція вже підтверджена і відповідає реальній транзакції з вашого банку';
  @override
  String get unreconciled => 'Не узгоджений';
  @override
  String get unreconciled_descr =>
      'Ця транзакція ще не підтверджена і тому ще не відображається у ваших реальних банківських рахунках. Однак вона враховується при розрахунку балансів і статистики в Monekin';
  @override
  String get pending => 'Очікується';
  @override
  String get pending_descr =>
      'Ця транзакція очікується і тому не буде враховуватися при розрахунку балансів і статистики';
  @override
  String get voided => 'Скасований';
  @override
  String get voided_descr =>
      'Скасована транзакція через помилку в платежі або будь-яку іншу причину. Вона не буде враховуватися при розрахунку балансів і статистики';
}

// Path: transaction.types
class _TranslationsTransactionTypesUk
    implements _TranslationsTransactionTypesEn {
  _TranslationsTransactionTypesUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Тип транзакції',
        other: 'Типи транзакцій',
      );
  @override
  String income({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Дохід',
        other: 'Доходи',
      );
  @override
  String expense({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Витрата',
        other: 'Витрати',
      );
  @override
  String transfer({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Переказ',
        other: 'Перекази',
      );
}

// Path: transfer.form
class _TranslationsTransferFormUk implements _TranslationsTransferFormEn {
  _TranslationsTransferFormUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get from => 'Початковий рахунок';
  @override
  String get to => 'Цільовий рахунок';
  @override
  String currency_info_add({required Object x}) =>
      '${x} буде перекладено на цільовий рахунок';
  @override
  String currency_info_edit({required Object x}) =>
      '${x} було перекладено на цільовий рахунок';
  @override
  late final _TranslationsTransferFormCurrencyExchangeSelectorUk
      currency_exchange_selector =
      _TranslationsTransferFormCurrencyExchangeSelectorUk._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsUk
    implements _TranslationsRecurrentTransactionsDetailsEn {
  _TranslationsRecurrentTransactionsDetailsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Повторювана транзакція';
  @override
  String get descr =>
      'Наступні переміщення для цієї транзакції показані нижче. Ви можете прийняти перший рух або пропустити цей рух';
  @override
  String get last_payment_info =>
      'Цей рух є останнім за повторюваною правилою, тому це правило буде автоматично видалено при підтвердженні цієї дії';
  @override
  String get delete_header => 'Видалити повторювану транзакцію';
  @override
  String get delete_message =>
      'Ця дія є незворотньою і не вплине на транзакції, які ви вже підтвердили/оплатили';
}

// Path: account.types
class _TranslationsAccountTypesUk implements _TranslationsAccountTypesEn {
  _TranslationsAccountTypesUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Тип рахунку';
  @override
  String get warning =>
      'Після вибору типу рахунку його не можна буде змінити в майбутньому';
  @override
  String get normal => 'Звичайний рахунок';
  @override
  String get normal_descr =>
      'Використовується для фіксації вашої повсякденної фінансової діяльності. Це найбільш поширений рахунок, який дозволяє додавати витрати, доходи...';
  @override
  String get saving => 'Зберігаючий рахунок';
  @override
  String get saving_descr =>
      'З нього можна тільки додавати та знімати гроші з інших рахунків. Ідеально підходить для початку збереження грошей';
}

// Path: account.form
class _TranslationsAccountFormUk implements _TranslationsAccountFormEn {
  _TranslationsAccountFormUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Назва рахунку';
  @override
  String get name_placeholder => 'Наприклад: Зберігаючий рахунок';
  @override
  String get notes => 'Примітки';
  @override
  String get notes_placeholder => 'Введіть примітки/опис про цей рахунок';
  @override
  String get initial_balance => 'Початковий баланс';
  @override
  String get current_balance => 'Поточний баланс';
  @override
  String get create => 'Створити рахунок';
  @override
  String get edit => 'Редагувати рахунок';
  @override
  String get currency_not_found_warn =>
      'У вас немає інформації про обмінні курси для цієї валюти. За замовчуванням буде використано 1.0 як курс обміну. Ви можете змінити це в налаштуваннях';
  @override
  String get already_exists =>
      'Вже існує інший з такою самою назвою, будь ласка, введіть іншу';
  @override
  String get tr_before_opening_date =>
      'В цьому рахунку є транзакції з датою перед датою відкриття';
  @override
  String get iban => 'IBAN';
  @override
  String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteUk implements _TranslationsAccountDeleteEn {
  _TranslationsAccountDeleteUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get warning_header => 'Видалити рахунок?';
  @override
  String get warning_text =>
      'Ця дія видалить цей рахунок і всі його транзакції';
  @override
  String get success => 'Рахунок успішно видалено';
}

// Path: account.close
class _TranslationsAccountCloseUk implements _TranslationsAccountCloseEn {
  _TranslationsAccountCloseUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Закрити рахунок';
  @override
  String get title_short => 'Закрити';
  @override
  String get warn =>
      'Цей рахунок більше не буде відображатися у певних списках, і ви не зможете створювати транзакції в ньому з датою пізніше, ніж вказана нижче. Ця дія не впливає на жодні транзакції або баланс, і ви також можете повторно відкрити цей рахунок у будь-який час. ';
  @override
  String get should_have_zero_balance =>
      'Баланс цього рахунку повинен бути 0, щоб його закрити. Будь ласка, відредагуйте рахунок перед продовженням';
  @override
  String get should_have_no_transactions =>
      'У цього рахунку є транзакції після вказаної дати закриття. Видаліть їх або відредагуйте дату закриття рахунку перед продовженням';
  @override
  String get success => 'Рахунок успішно закрито';
  @override
  String get unarchive_succes => 'Рахунок успішно повторно відкрито';
}

// Path: account.select
class _TranslationsAccountSelectUk implements _TranslationsAccountSelectEn {
  _TranslationsAccountSelectUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get one => 'Виберіть рахунок';
  @override
  String get all => 'Всі рахунки';
  @override
  String get multiple => 'Вибрати рахунки';
}

// Path: currencies.form
class _TranslationsCurrenciesFormUk implements _TranslationsCurrenciesFormEn {
  _TranslationsCurrenciesFormUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get equal_to_preferred_warn =>
      'Валюта не може бути однаковою з валютою користувача';
  @override
  String get specify_a_currency => 'Будь ласка, вкажіть валюту';
  @override
  String get add => 'Додати обмінний курс';
  @override
  String get add_success => 'Обмінний курс успішно додано';
  @override
  String get edit => 'Редагувати обмінний курс';
  @override
  String get edit_success => 'Обмінний курс успішно відредаговано';
}

// Path: tags.form
class _TranslationsTagsFormUk implements _TranslationsTagsFormEn {
  _TranslationsTagsFormUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Назва тегу';
  @override
  String get description => 'Опис';
}

// Path: categories.select
class _TranslationsCategoriesSelectUk
    implements _TranslationsCategoriesSelectEn {
  _TranslationsCategoriesSelectUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Вибрати категорії';
  @override
  String get select_one => 'Виберіть категорію';
  @override
  String get select_subcategory => 'Оберіть підкатегорію';
  @override
  String get without_subcategory => 'Без підкатегорії';
  @override
  String get all => 'Усі категорії';
  @override
  String get all_short => 'Усі';
}

// Path: budgets.form
class _TranslationsBudgetsFormUk implements _TranslationsBudgetsFormEn {
  _TranslationsBudgetsFormUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Додати бюджет';
  @override
  String get name => 'Назва бюджету';
  @override
  String get value => 'Обмежена кількість';
  @override
  String get create => 'Додати бюджет';
  @override
  String get edit => 'Редагувати бюджет';
  @override
  String get negative_warn => 'Бюджети не можуть мати від\'ємну суму';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsUk implements _TranslationsBudgetsDetailsEn {
  _TranslationsBudgetsDetailsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Деталі бюджету';
  @override
  String get statistics => 'Статистика';
  @override
  String get budget_value => 'Заплановано';
  @override
  String expend_diary_left(
          {required Object dailyAmount, required Object remainingDays}) =>
      'Ви можете витрачати ${dailyAmount} на день ще ${remainingDays} днів';
  @override
  String get expend_evolution => 'Еволюція витрат';
  @override
  String get no_transactions =>
      'Здається, ви не здійснили жодних витрат, пов\'язаних з цим бюджетом';
}

// Path: backup.export
class _TranslationsBackupExportUk implements _TranslationsBackupExportEn {
  _TranslationsBackupExportUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Експорт ваших даних';
  @override
  String get title_short => 'Експорт';
  @override
  String get all => 'Повне резервне копіювання';
  @override
  String get all_descr =>
      'Експортувати всі ваші дані (рахунки, транзакції, бюджети, налаштування...). Імпортуйте їх знову у будь-який момент, щоб нічого не втратити.';
  @override
  String get transactions => 'Резервне копіювання транзакцій';
  @override
  String get transactions_descr =>
      'Експортуйте ваші транзакції у форматі CSV, щоб ви могли зручніше їх аналізувати в інших програмах або застосунках.';
  @override
  String get description => 'Завантажте ваші дані у різних форматах';
  @override
  String get dialog_title => 'Зберегти/Відправити файл';
  @override
  String success({required Object x}) =>
      'Файл успішно збережено/завантажено у ${x}';
  @override
  String get error =>
      'Помилка при завантаженні файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportUk implements _TranslationsBackupImportEn {
  _TranslationsBackupImportUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Імпорт ваших даних';
  @override
  String get title_short => 'Імпорт';
  @override
  String get restore_backup => 'Відновити резервну копію';
  @override
  String get restore_backup_descr =>
      'Імпортуйте раніше збережену базу даних з Monekin. Ця дія замінить будь-які поточні дані програми новими даними';
  @override
  String get restore_backup_warn_description =>
      'При імпорті нової бази даних ви втратите всі дані, які вже збережено в програмі. Рекомендується зробити резервну копію перед продовженням. Не завантажуйте сюди будь-який файл, походження якого ви не знаєте, завантажуйте лише файли, які ви раніше завантажили з Monekin';
  @override
  String get restore_backup_warn_title => 'Перезаписати всі дані';
  @override
  String get select_other_file => 'Вибрати інший файл';
  @override
  String get tap_to_select_file => 'Торкніться, щоб вибрати файл';
  @override
  late final _TranslationsBackupImportManualImportUk manual_import =
      _TranslationsBackupImportManualImportUk._(_root);
  @override
  String get success => 'Імпорт виконано успішно';
  @override
  String get cancelled => 'Імпорт скасовано користувачем';
  @override
  String get error =>
      'Помилка імпорту файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutUk implements _TranslationsBackupAboutEn {
  _TranslationsBackupAboutUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Інформація про вашу базу даних';
  @override
  String get create_date => 'Дата створення';
  @override
  String get modify_date => 'Останнє змінено';
  @override
  String get last_backup => 'Остання резервна копія';
  @override
  String get size => 'Розмір';
}

// Path: more.data
class _TranslationsMoreDataUk implements _TranslationsMoreDataEn {
  _TranslationsMoreDataUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Дані';
  @override
  String get display_descr =>
      'Експортуйте та імпортуйте свої дані, щоб нічого не втратити';
  @override
  String get delete_all => 'Видалити мої дані';
  @override
  String get delete_all_header1 => 'Зупиніться, молодий падаване ⚠️⚠️';
  @override
  String get delete_all_message1 =>
      'Ви впевнені, що хочете продовжити? Всі ваші дані буде остаточно видалено і не може бути відновлено';
  @override
  String get delete_all_header2 => 'Останній крок ⚠️⚠️';
  @override
  String get delete_all_message2 =>
      'Видаляючи обліковий запис, ви видалите всі ваші збережені особисті дані. Ваші облікові записи, транзакції, бюджети та категорії будуть видалені і не можуть бути відновлені. Ви згодні?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsUk implements _TranslationsMoreAboutUsEn {
  _TranslationsMoreAboutUsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Інформація про додаток';
  @override
  String get description =>
      'Перегляньте умови та іншу важливу інформацію про Monekin. Зв\'яжіться зі спільнотою, повідомте про помилки, залиште пропозиції ...';
  @override
  late final _TranslationsMoreAboutUsLegalUk legal =
      _TranslationsMoreAboutUsLegalUk._(_root);
  @override
  late final _TranslationsMoreAboutUsProjectUk project =
      _TranslationsMoreAboutUsProjectUk._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsUk implements _TranslationsMoreHelpUsEn {
  _TranslationsMoreHelpUsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Допоможіть нам';
  @override
  String get description =>
      'Дізнайтеся, як ви можете допомогти Monekin ставати кращим і кращим';
  @override
  String get rate_us => 'Оцініть нас';
  @override
  String get rate_us_descr => 'Будь-яка оцінка вітається!';
  @override
  String get share => 'Поділіться Monekin';
  @override
  String get share_descr => 'Поділіться нашим додатком з друзями та родиною';
  @override
  String get share_text =>
      'Monekin! Найкращий додаток для особистих фінансів. Завантажте його тут';
  @override
  String get thanks => 'Дякуємо!';
  @override
  String get thanks_long =>
      'Ваші внески в Monekin та інші відкриті проекти, великі та малі, роблять великі проекти, подібні до цього, можливими. Дякуємо вам за час, витрачений на внесок.';
  @override
  String get donate => 'Зробіть пожертву';
  @override
  String get donate_descr =>
      'З вашою пожертвою ви допоможете додатку продовжувати отримувати вдосконалення. Що може бути краще, ніж подякувати за виконану роботу, запрошуючи мене на каву?';
  @override
  String get donate_success =>
      'Пожертва зроблена. Дуже вдячний за ваш внесок! ❤️';
  @override
  String get donate_err =>
      'Ой! Здається, виникла помилка при отриманні вашого платежу';
  @override
  String get report => 'Повідомити про помилки, залишити пропозиції...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesUk
    implements _TranslationsGeneralTimeRangesEn {
  _TranslationsGeneralTimeRangesUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Часовий діапазон';
  @override
  String get it_repeat => 'Повторюється';
  @override
  String get it_ends => 'Закінчується';
  @override
  String get forever => 'Назавжди';
  @override
  late final _TranslationsGeneralTimeRangesTypesUk types =
      _TranslationsGeneralTimeRangesTypesUk._(_root);
  @override
  String each_range({required num n, required Object range}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Кожного ${range}',
        other: 'Кожних ${n} ${range}',
      );
  @override
  String each_range_until_date(
          {required num n, required Object range, required Object day}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Кожного ${range} до ${day}',
        other: 'Кожних ${n} ${range} до ${day}',
      );
  @override
  String each_range_until_times(
          {required num n, required Object range, required Object limit}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Кожного ${range} ${limit} раз',
        other: 'Кожних ${n} ${range} ${limit} раз',
      );
  @override
  String each_range_until_once({required num n, required Object range}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Кожного ${range} один раз',
        other: 'Кожних ${n} ${range} один раз',
      );
  @override
  String month({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Місяць',
        other: 'Місяці',
      );
  @override
  String year({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Рік',
        other: 'Роки',
      );
  @override
  String day({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'День',
        other: 'Дні',
      );
  @override
  String week({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Тиждень',
        other: 'Тижні',
      );
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityUk
    implements _TranslationsGeneralTimePeriodicityEn {
  _TranslationsGeneralTimePeriodicityUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Повторення';
  @override
  String get no_repeat => 'Без повторень';
  @override
  String repeat({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Повторення',
        other: 'Повторень',
      );
  @override
  String get diary => 'Щоденно';
  @override
  String get monthly => 'Щомісяця';
  @override
  String get annually => 'Щороку';
  @override
  String get quaterly => 'Щокварталу';
  @override
  String get weekly => 'Щотижня';
  @override
  String get custom => 'Власний';
  @override
  String get infinite => 'Завжди';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentUk
    implements _TranslationsGeneralTimeCurrentEn {
  _TranslationsGeneralTimeCurrentUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get monthly => 'Цього місяця';
  @override
  String get annually => 'Цього року';
  @override
  String get quaterly => 'Цього кварталу';
  @override
  String get weekly => 'На цьому тижні';
  @override
  String get infinite => 'Назавжди';
  @override
  String get custom => 'Власний діапазон';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllUk implements _TranslationsGeneralTimeAllEn {
  _TranslationsGeneralTimeAllUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get diary => 'Щоденно';
  @override
  String get monthly => 'Щомісяця';
  @override
  String get annually => 'Щороку';
  @override
  String get quaterly => 'Щокварталу';
  @override
  String get weekly => 'Щотижня';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrUk
    implements _TranslationsFinancialHealthReviewDescrEn {
  _TranslationsFinancialHealthReviewDescrUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get insufficient_data =>
      'Схоже, у нас недостатньо витрат, щоб розрахувати ваше фінансове здоров\'я. Додайте деякі витрати/доходи за цей період, щоб дозволити нам допомогти вам!';
  @override
  String get very_good =>
      'Вітаємо! Ваше фінансове здоров\'я прекрасне. Сподіваємося, ви продовжите свою успішну хвилю і будете навчатися разом з Monekin';
  @override
  String get good =>
      'Чудово! Ваше фінансове здоров\'я гарне. Відвідайте вкладку аналізу, щоб побачити, як зберегти ще більше!';
  @override
  String get normal =>
      'Ваше фінансове здоров\'я більш-менш в середньому залишку населення за цей період';
  @override
  String get bad =>
      'Схоже, що ваша фінансова ситуація ще не найкраща. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
  @override
  String get very_bad =>
      'Хмм, ваше фінансове здоров\'я далеко не відповідає тому, що воно повинно бути. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextUk
    implements _TranslationsFinancialHealthSavingsPercentageTextEn {
  _TranslationsFinancialHealthSavingsPercentageTextUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String good({required Object value}) =>
      'Вітаємо! Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Схоже, ви вже професіонал, продовжуйте в тому ж дусі!';
  @override
  String normal({required Object value}) =>
      'Вітаємо, ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду.';
  @override
  String bad({required Object value}) =>
      'Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Проте ми вважаємо, що ви все ще можете зробити набагато більше!';
  @override
  String get very_bad =>
      'Вау, ви не змогли заощадити нічого протягом цього періоду.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditUk
    implements _TranslationsTransactionListBulkEditEn {
  _TranslationsTransactionListBulkEditUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get dates => 'Редагувати дати';
  @override
  String get categories => 'Редагувати категорії';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsUk
    implements _TranslationsTransactionFormValidatorsEn {
  _TranslationsTransactionFormValidatorsUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get zero => 'Значення транзакції не може бути рівним нулю';
  @override
  String get date_max =>
      'Обрана дата після поточної. Транзакція буде додана як очікувана';
  @override
  String get date_after_account_creation =>
      'Ви не можете створити транзакцію з датою до створення рахунку, до якого вона належить';
  @override
  String get negative_transaction =>
      'Не використовуйте від\'ємні суми для вашої транзакції. Ми застосуємо знак в залежності від того, чи є обрана категорія витратою/доходом';
  @override
  String get negative_transfer =>
      'Монетарна вартість переказу не може бути від\'ємною';
}

// Path: transfer.form.currency_exchange_selector
class _TranslationsTransferFormCurrencyExchangeSelectorUk
    implements _TranslationsTransferFormCurrencyExchangeSelectorEn {
  _TranslationsTransferFormCurrencyExchangeSelectorUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Редагувати обмін між валютами';
  @override
  String get value_in_destiny => 'Сума, перекладена на цільовий рахунок';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportUk
    implements _TranslationsBackupImportManualImportEn {
  _TranslationsBackupImportManualImportUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ручний імпорт';
  @override
  String get descr => 'Імпортуйте транзакції з файлу .csv вручну';
  @override
  String get default_account => 'Типовий рахунок';
  @override
  String get remove_default_account => 'Видалити типовий рахунок';
  @override
  String get default_category => 'Типова категорія';
  @override
  String get select_a_column => 'Виберіть стовпець з файлу .csv';
  @override
  List<String> get steps => [
        'Виберіть ваш файл',
        'Стовпець для суми',
        'Стовпець для рахунку',
        'Стовпець для категорії',
        'Стовпець для дати',
        'інші стовпці',
      ];
  @override
  List<String> get steps_descr => [
        'Виберіть файл .csv з вашого пристрою. Переконайтеся, що в ньому є перший рядок, який описує назву кожного стовпця',
        'Виберіть стовпець, де вказано значення кожної транзакції. Використовуйте від\'ємні значення для витрат та позитивні значення для доходів. Використовуйте крапку як десятковий роздільник',
        'Виберіть стовпець, де вказано рахунок, до якого належить кожна транзакція. Ви також можете вибрати типовий рахунок у випадку, якщо ми не зможемо знайти рахунок, який вам потрібен. Якщо типовий рахунок не вказано, ми створимо його з такою самою назвою',
        'Вкажіть стовпець, де знаходиться назва категорії транзакції. Ви повинні вказати типову категорію, щоб ми призначили цю категорію транзакціям, у випадку, якщо категорія не може бути знайдена',
        'Виберіть стовпець, де вказано дату кожної транзакції. Якщо не вказано, транзакції будуть створені з поточною датою',
        'Вкажіть стовпці для інших необов\'язкових атрибутів транзакцій',
      ];
  @override
  String success({required Object x}) => 'Успішно імпортовано ${x} транзакцій';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalUk
    implements _TranslationsMoreAboutUsLegalEn {
  _TranslationsMoreAboutUsLegalUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Юридична інформація';
  @override
  String get privacy => 'Політика конфіденційності';
  @override
  String get terms => 'Умови використання';
  @override
  String get licenses => 'Ліцензії';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectUk
    implements _TranslationsMoreAboutUsProjectEn {
  _TranslationsMoreAboutUsProjectUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Проект';
  @override
  String get contributors => 'Співробітники';
  @override
  String get contributors_descr => 'Усі розробники, які зробили Monekin краще';
  @override
  String get contact => 'Зв\'яжіться з нами';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesUk
    implements _TranslationsGeneralTimeRangesTypesEn {
  _TranslationsGeneralTimeRangesTypesUk._(this._root);

  @override
  final _TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get cycle => 'Цикли';
  @override
  String get last_days => 'Останні дні';
  @override
  String last_days_form({required Object x}) => '${x} попередніх днів';
  @override
  String get all => 'Завжди';
  @override
  String get date_range => 'Власний діапазон';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'general.cancel':
        return 'Cancel';
      case 'general.or':
        return 'or';
      case 'general.understood':
        return 'Understood';
      case 'general.unspecified':
        return 'Unspecified';
      case 'general.confirm':
        return 'Confirm';
      case 'general.continue_text':
        return 'Continue';
      case 'general.quick_actions':
        return 'Quick actions';
      case 'general.save':
        return 'Save';
      case 'general.save_changes':
        return 'Save changes';
      case 'general.close_and_save':
        return 'Save and close';
      case 'general.add':
        return 'Add';
      case 'general.edit':
        return 'Edit';
      case 'general.balance':
        return 'Balance';
      case 'general.delete':
        return 'Delete';
      case 'general.account':
        return 'Account';
      case 'general.accounts':
        return 'Accounts';
      case 'general.categories':
        return 'Categories';
      case 'general.category':
        return 'Category';
      case 'general.today':
        return 'Today';
      case 'general.yesterday':
        return 'Yesterday';
      case 'general.filters':
        return 'Filters';
      case 'general.select_all':
        return 'Select all';
      case 'general.deselect_all':
        return 'Deselect all';
      case 'general.empty_warn':
        return 'Ops! This is very empty';
      case 'general.insufficient_data':
        return 'Insufficient data';
      case 'general.show_more_fields':
        return 'Show more fields';
      case 'general.show_less_fields':
        return 'Show less fields';
      case 'general.clipboard.success':
        return ({required Object x}) => '${x} copied to the clipboard';
      case 'general.clipboard.error':
        return 'Error copying';
      case 'general.time.start_date':
        return 'Start date';
      case 'general.time.end_date':
        return 'End date';
      case 'general.time.from_date':
        return 'From date';
      case 'general.time.until_date':
        return 'Until date';
      case 'general.time.date':
        return 'Date';
      case 'general.time.datetime':
        return 'Datetime';
      case 'general.time.time':
        return 'Time';
      case 'general.time.each':
        return 'Each';
      case 'general.time.after':
        return 'After';
      case 'general.time.ranges.display':
        return 'Time range';
      case 'general.time.ranges.it_repeat':
        return 'Repeats';
      case 'general.time.ranges.it_ends':
        return 'Ends';
      case 'general.time.ranges.forever':
        return 'Forever';
      case 'general.time.ranges.types.cycle':
        return 'Cycles';
      case 'general.time.ranges.types.last_days':
        return 'Last days';
      case 'general.time.ranges.types.last_days_form':
        return ({required Object x}) => '${x} previous days';
      case 'general.time.ranges.types.all':
        return 'Always';
      case 'general.time.ranges.types.date_range':
        return 'Custom range';
      case 'general.time.ranges.each_range':
        return ({required num n, required Object range}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Every ${range}',
              other: 'Every ${n} ${range}',
            );
      case 'general.time.ranges.each_range_until_date':
        return ({required num n, required Object range, required Object day}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Every ${range} until ${day}',
              other: 'Every ${n} ${range} until ${day}',
            );
      case 'general.time.ranges.each_range_until_times':
        return (
                {required num n,
                required Object range,
                required Object limit}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Every ${range} ${limit} times',
              other: 'Every ${n} ${range} ${limit} times',
            );
      case 'general.time.ranges.each_range_until_once':
        return ({required num n, required Object range}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Every ${range} once',
              other: 'Every ${n} ${range} once',
            );
      case 'general.time.ranges.month':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Month',
              other: 'Months',
            );
      case 'general.time.ranges.year':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Year',
              other: 'Years',
            );
      case 'general.time.ranges.day':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Day',
              other: 'Days',
            );
      case 'general.time.ranges.week':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Week',
              other: 'Weeks',
            );
      case 'general.time.periodicity.display':
        return 'Recurrence';
      case 'general.time.periodicity.no_repeat':
        return 'No repeat';
      case 'general.time.periodicity.repeat':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Repetition',
              other: 'Repetitions',
            );
      case 'general.time.periodicity.diary':
        return 'Daily';
      case 'general.time.periodicity.monthly':
        return 'Monthly';
      case 'general.time.periodicity.annually':
        return 'Annually';
      case 'general.time.periodicity.quaterly':
        return 'Quarterly';
      case 'general.time.periodicity.weekly':
        return 'Weekly';
      case 'general.time.periodicity.custom':
        return 'Custom';
      case 'general.time.periodicity.infinite':
        return 'Always';
      case 'general.time.current.monthly':
        return 'This month';
      case 'general.time.current.annually':
        return 'This year';
      case 'general.time.current.quaterly':
        return 'This quarter';
      case 'general.time.current.weekly':
        return 'This week';
      case 'general.time.current.infinite':
        return 'For ever';
      case 'general.time.current.custom':
        return 'Custom Range';
      case 'general.time.all.diary':
        return 'Every day';
      case 'general.time.all.monthly':
        return 'Every month';
      case 'general.time.all.annually':
        return 'Every year';
      case 'general.time.all.quaterly':
        return 'Every quarterly';
      case 'general.time.all.weekly':
        return 'Every week';
      case 'general.transaction_order.display':
        return 'Order transactions';
      case 'general.transaction_order.category':
        return 'By category';
      case 'general.transaction_order.quantity':
        return 'By quantity';
      case 'general.transaction_order.date':
        return 'By date';
      case 'general.validations.required':
        return 'Required field';
      case 'general.validations.positive':
        return 'Should be positive';
      case 'general.validations.min_number':
        return ({required Object x}) => 'Should be greater than ${x}';
      case 'general.validations.max_number':
        return ({required Object x}) => 'Should be less than ${x}';
      case 'intro.start':
        return 'Start';
      case 'intro.skip':
        return 'Skip';
      case 'intro.next':
        return 'Next';
      case 'intro.select_your_currency':
        return 'Select your currency';
      case 'intro.welcome_subtitle':
        return 'Your personal finance manager';
      case 'intro.welcome_subtitle2':
        return '100% open, 100% free';
      case 'intro.welcome_footer':
        return 'By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application';
      case 'intro.offline_descr_title':
        return 'OFFLINE ACCOUNT:';
      case 'intro.offline_descr':
        return 'Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';
      case 'intro.offline_start':
        return 'Start session offline';
      case 'intro.sl1_title':
        return 'Select your currency';
      case 'intro.sl1_descr':
        return 'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings';
      case 'intro.sl2_title':
        return 'Safe, private and reliable';
      case 'intro.sl2_descr':
        return 'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet';
      case 'intro.sl2_descr2':
        return 'Also, the source code of the application is public, anyone can collaborate on it and see how it works';
      case 'intro.last_slide_title':
        return 'All ready';
      case 'intro.last_slide_descr':
        return 'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.';
      case 'intro.last_slide_descr2':
        return 'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...';
      case 'home.title':
        return 'Dashboard';
      case 'home.filter_transactions':
        return 'Filter transactions';
      case 'home.hello_day':
        return 'Good morning,';
      case 'home.hello_night':
        return 'Good night,';
      case 'home.total_balance':
        return 'Total balance';
      case 'home.my_accounts':
        return 'My accounts';
      case 'home.active_accounts':
        return 'Active accounts';
      case 'home.no_accounts':
        return 'No accounts created yet';
      case 'home.no_accounts_descr':
        return 'Start using all the magic of Monekin. Create at least one account to start adding transactions';
      case 'home.last_transactions':
        return 'Last transactions';
      case 'home.should_create_account_header':
        return 'Oops!';
      case 'home.should_create_account_message':
        return 'You must have at least one no-archived account before you can start creating transactions';
      case 'financial_health.display':
        return 'Financial health';
      case 'financial_health.review.very_good':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Very good!';
            case GenderContext.female:
              return 'Very good!';
          }
        };
      case 'financial_health.review.good':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Good';
            case GenderContext.female:
              return 'Good';
          }
        };
      case 'financial_health.review.normal':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Average';
            case GenderContext.female:
              return 'Average';
          }
        };
      case 'financial_health.review.bad':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Fair';
            case GenderContext.female:
              return 'Fair';
          }
        };
      case 'financial_health.review.very_bad':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Very Bad';
            case GenderContext.female:
              return 'Very Bad';
          }
        };
      case 'financial_health.review.insufficient_data':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Insufficient data';
            case GenderContext.female:
              return 'Insufficient data';
          }
        };
      case 'financial_health.review.descr.insufficient_data':
        return 'It looks like we don\'t have enough expenses to calculate your financial health. Add some expenses/incomes in this period to allow us to help you!';
      case 'financial_health.review.descr.very_good':
        return 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';
      case 'financial_health.review.descr.good':
        return 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';
      case 'financial_health.review.descr.normal':
        return 'Your financial health is more or less in the average of the rest of the population for this period';
      case 'financial_health.review.descr.bad':
        return 'It seems that your financial situation is not the best yet. Explore the rest of the charts to learn more about your finances';
      case 'financial_health.review.descr.very_bad':
        return 'Hmm, your financial health is far below what it should be. Explore the rest of the charts to learn more about your finances';
      case 'financial_health.months_without_income.title':
        return 'Survival rate';
      case 'financial_health.months_without_income.subtitle':
        return 'Given your balance, amount of time you could go without income';
      case 'financial_health.months_without_income.text_zero':
        return 'You couldn\'t survive a month without income at this rate of expenses!';
      case 'financial_health.months_without_income.text_one':
        return 'You could barely survive approximately a month without income at this rate of expenses!';
      case 'financial_health.months_without_income.text_other':
        return ({required Object n}) =>
            'You could survive approximately <b>${n} months</b> without income at this rate of spending.';
      case 'financial_health.months_without_income.text_infinite':
        return 'You could survive approximately <b>all your life</b> without income at this rate of spending.';
      case 'financial_health.months_without_income.suggestion':
        return 'Remember that it is advisable to always keep this ratio above 5 months at least. If you see that you do not have a sufficient savings cushion, reduce unnecessary expenses.';
      case 'financial_health.months_without_income.insufficient_data':
        return 'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
      case 'financial_health.savings_percentage.title':
        return 'Savings percentage';
      case 'financial_health.savings_percentage.subtitle':
        return 'What part of your income is not spent in this period';
      case 'financial_health.savings_percentage.text.good':
        return ({required Object value}) =>
            'Congratulations! You have managed to save <b>${value}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!';
      case 'financial_health.savings_percentage.text.normal':
        return ({required Object value}) =>
            'Congratulations, you have managed to save <b>${value}%</b> of your income during this period.';
      case 'financial_health.savings_percentage.text.bad':
        return ({required Object value}) =>
            'You have managed to save <b>${value}%</b> of your income during this period. However, we think you can still do much more!';
      case 'financial_health.savings_percentage.text.very_bad':
        return 'Wow, you haven\'t managed to save anything during this period.';
      case 'financial_health.savings_percentage.suggestion':
        return 'Remember that it is advisable to save at least 15-20% of what you earn.';
      case 'stats.title':
        return 'Statistics';
      case 'stats.balance':
        return 'Balance';
      case 'stats.final_balance':
        return 'Final balance';
      case 'stats.balance_by_account':
        return 'Balance by accounts';
      case 'stats.balance_by_currency':
        return 'Balance by currency';
      case 'stats.cash_flow':
        return 'Cash flow';
      case 'stats.balance_evolution':
        return 'Balance evolution';
      case 'stats.compared_to_previous_period':
        return 'Compared to the previous period';
      case 'stats.by_periods':
        return 'By periods';
      case 'stats.by_categories':
        return 'By categories';
      case 'stats.by_tags':
        return 'By tags';
      case 'stats.distribution':
        return 'Distribution';
      case 'stats.finance_health_resume':
        return 'Resume';
      case 'stats.finance_health_breakdown':
        return 'Breakdown';
      case 'icon_selector.name':
        return 'Name:';
      case 'icon_selector.icon':
        return 'Icon';
      case 'icon_selector.color':
        return 'Color';
      case 'icon_selector.select_icon':
        return 'Select an icon';
      case 'icon_selector.select_color':
        return 'Select a color';
      case 'icon_selector.select_account_icon':
        return 'Identify your account';
      case 'icon_selector.select_category_icon':
        return 'Identify your category';
      case 'icon_selector.scopes.transport':
        return 'Transport';
      case 'icon_selector.scopes.money':
        return 'Money';
      case 'icon_selector.scopes.food':
        return 'Food';
      case 'icon_selector.scopes.medical':
        return 'Health';
      case 'icon_selector.scopes.entertainment':
        return 'Leisure';
      case 'icon_selector.scopes.technology':
        return 'Technology';
      case 'icon_selector.scopes.other':
        return 'Others';
      case 'icon_selector.scopes.logos_financial_institutions':
        return 'Financial institutions';
      case 'transaction.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Transaction',
              other: 'Transactions',
            );
      case 'transaction.create':
        return 'New transaction';
      case 'transaction.new_income':
        return 'New income';
      case 'transaction.new_expense':
        return 'New expense';
      case 'transaction.new_success':
        return 'Transaction created successfully';
      case 'transaction.edit':
        return 'Edit transaction';
      case 'transaction.edit_success':
        return 'Transaction edited successfully';
      case 'transaction.edit_multiple':
        return 'Edit transactions';
      case 'transaction.edit_multiple_success':
        return ({required Object x}) => '${x} transactions edited successfully';
      case 'transaction.duplicate':
        return 'Clone transaction';
      case 'transaction.duplicate_short':
        return 'Clone';
      case 'transaction.duplicate_warning_message':
        return 'A transaction identical to this will be created with the same date, do you want to continue?';
      case 'transaction.duplicate_success':
        return 'Transaction cloned successfully';
      case 'transaction.delete':
        return 'Delete transaction';
      case 'transaction.delete_warning_message':
        return 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';
      case 'transaction.delete_success':
        return 'Transaction deleted correctly';
      case 'transaction.delete_multiple':
        return 'Delete transactions';
      case 'transaction.delete_multiple_warning_message':
        return ({required Object x}) =>
            'This action is irreversible and will remove ${x} transactions. The current balance of your accounts and all your statistics will be recalculated';
      case 'transaction.delete_multiple_success':
        return ({required Object x}) => '${x} transactions deleted correctly';
      case 'transaction.details':
        return 'Movement details';
      case 'transaction.next_payments.accept':
        return 'Accept';
      case 'transaction.next_payments.skip':
        return 'Skip';
      case 'transaction.next_payments.skip_success':
        return 'Successfully skipped transaction';
      case 'transaction.next_payments.skip_dialog_title':
        return 'Skip transaction';
      case 'transaction.next_payments.skip_dialog_msg':
        return ({required Object date}) =>
            'This action is irreversible. We will move the date of the next move to ${date}';
      case 'transaction.next_payments.accept_today':
        return 'Accept today';
      case 'transaction.next_payments.accept_in_required_date':
        return ({required Object date}) => 'Accept in required date (${date})';
      case 'transaction.next_payments.accept_dialog_title':
        return 'Accept transaction';
      case 'transaction.next_payments.accept_dialog_msg_single':
        return 'The new status of the transaction will be null. You can re-edit the status of this transaction whenever you want';
      case 'transaction.next_payments.accept_dialog_msg':
        return ({required Object date}) =>
            'This action will create a new transaction with date ${date}. You will be able to check the details of this transaction on the transaction page';
      case 'transaction.next_payments.recurrent_rule_finished':
        return 'The recurring rule has been completed, there are no more payments to make!';
      case 'transaction.list.empty':
        return 'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
      case 'transaction.list.searcher_placeholder':
        return 'Search by category, description...';
      case 'transaction.list.searcher_no_results':
        return 'No transactions found matching the search criteria';
      case 'transaction.list.loading':
        return 'Loading more transactions...';
      case 'transaction.list.selected_short':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: '${n} selected',
              other: '${n} selected',
            );
      case 'transaction.list.selected_long':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: '${n} transaction selected',
              other: '${n} transactions selected',
            );
      case 'transaction.list.bulk_edit.dates':
        return 'Edit dates';
      case 'transaction.list.bulk_edit.categories':
        return 'Edit categories';
      case 'transaction.filters.from_value':
        return 'From amount';
      case 'transaction.filters.to_value':
        return 'Up to amount';
      case 'transaction.filters.from_value_def':
        return ({required Object x}) => 'From ${x}';
      case 'transaction.filters.to_value_def':
        return ({required Object x}) => 'Up to ${x}';
      case 'transaction.filters.from_date_def':
        return ({required Object date}) => 'From the ${date}';
      case 'transaction.filters.to_date_def':
        return ({required Object date}) => 'Up to the ${date}';
      case 'transaction.form.validators.zero':
        return 'The value of a transaction cannot be equal to zero';
      case 'transaction.form.validators.date_max':
        return 'The selected date is after the current one. The transaction will be added as pending';
      case 'transaction.form.validators.date_after_account_creation':
        return 'You cannot create a transaction whose date is before the creation date of the account it belongs to';
      case 'transaction.form.validators.negative_transaction':
        return 'Do not use negative amounts for your transaction. We will apply the sign depending on whether the selected category is expense/income';
      case 'transaction.form.validators.negative_transfer':
        return 'The monetary value of a transfer cannot be negative';
      case 'transaction.form.title':
        return 'Transaction title';
      case 'transaction.form.value':
        return 'Value of the transaction';
      case 'transaction.form.tap_to_see_more':
        return 'Tap to see more details';
      case 'transaction.form.description':
        return 'Description';
      case 'transaction.form.description_info':
        return 'Adding a note will help you find this transaction faster in the future';
      case 'transaction.form.exchange_to_preferred_title':
        return ({required Object currency}) => 'Exchnage rate to ${currency}';
      case 'transaction.form.exchange_to_preferred_in_date':
        return 'On transaction date';
      case 'transaction.status.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Status',
              other: 'Statuses',
            );
      case 'transaction.status.tr_status':
        return ({required Object status}) => '${status} transaction';
      case 'transaction.status.none':
        return 'Stateless';
      case 'transaction.status.reconciled':
        return 'Reconciled';
      case 'transaction.status.reconciled_descr':
        return 'This transaction has already been validated and corresponds to a real transaction from your bank';
      case 'transaction.status.unreconciled':
        return 'Unreconciled';
      case 'transaction.status.unreconciled_descr':
        return 'This transaction has not yet been validated and therefore does not yet appear in your real bank accounts. However, it counts for the calculation of balances and statistics in Monekin';
      case 'transaction.status.pending':
        return 'Pending';
      case 'transaction.status.pending_descr':
        return 'This transaction is pending and therefore it will not be taken into account when calculating balances and statistics';
      case 'transaction.status.voided':
        return 'Voided';
      case 'transaction.status.voided_descr':
        return 'Void/cancelled transaction due to payment error or any other reason. It will not be taken into account when calculating balances and statistics';
      case 'transaction.types.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Transaction type',
              other: 'Transaction types',
            );
      case 'transaction.types.income':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Income',
              other: 'Incomes',
            );
      case 'transaction.types.expense':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Expense',
              other: 'Expenses',
            );
      case 'transaction.types.transfer':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Transfer',
              other: 'Transfers',
            );
      case 'transfer.display':
        return 'Transfer';
      case 'transfer.transfers':
        return 'Transfers';
      case 'transfer.transfer_to':
        return ({required Object account}) => 'Transfer to ${account}';
      case 'transfer.create':
        return 'New Transfer';
      case 'transfer.need_two_accounts_warning_header':
        return 'Ops!';
      case 'transfer.need_two_accounts_warning_message':
        return 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
      case 'transfer.form.from':
        return 'Origin account';
      case 'transfer.form.to':
        return 'Destination account';
      case 'transfer.form.currency_info_add':
        return ({required Object x}) =>
            '${x} will be transferred to the destination account';
      case 'transfer.form.currency_info_edit':
        return ({required Object x}) =>
            '${x} have been transferred to the destination account';
      case 'transfer.form.currency_exchange_selector.title':
        return 'Edit exchange between currencies';
      case 'transfer.form.currency_exchange_selector.value_in_destiny':
        return 'Amount transferred in destination';
      case 'recurrent_transactions.title':
        return 'Recurrent transactions';
      case 'recurrent_transactions.title_short':
        return 'Rec. transactions';
      case 'recurrent_transactions.empty':
        return 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
      case 'recurrent_transactions.total_expense_title':
        return 'Total expense per period';
      case 'recurrent_transactions.total_expense_descr':
        return '* Without considering the start and end date of each recurrence';
      case 'recurrent_transactions.details.title':
        return 'Recurrent transaction';
      case 'recurrent_transactions.details.descr':
        return 'The next moves for this transaction are shown below. You can accept the first move or skip this move';
      case 'recurrent_transactions.details.last_payment_info':
        return 'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action';
      case 'recurrent_transactions.details.delete_header':
        return 'Delete recurring transaction';
      case 'recurrent_transactions.details.delete_message':
        return 'This action is irreversible and will not affect transactions you have already confirmed/paid for';
      case 'account.details':
        return 'Account details';
      case 'account.date':
        return 'Opening date';
      case 'account.close_date':
        return 'Closing date';
      case 'account.reopen':
        return 'Re-open account';
      case 'account.reopen_short':
        return 'Re-open';
      case 'account.reopen_descr':
        return 'Are you sure you want to reopen this account?';
      case 'account.balance':
        return 'Account balance';
      case 'account.n_transactions':
        return 'Number of transactions';
      case 'account.add_money':
        return 'Add money';
      case 'account.withdraw_money':
        return 'Withdraw money';
      case 'account.no_accounts':
        return 'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
      case 'account.types.title':
        return 'Account type';
      case 'account.types.warning':
        return 'Once the type of account has been chosen, it cannot be changed in the future';
      case 'account.types.normal':
        return 'Normal account';
      case 'account.types.normal_descr':
        return 'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...';
      case 'account.types.saving':
        return 'Savings account';
      case 'account.types.saving_descr':
        return 'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money';
      case 'account.form.name':
        return 'Account name';
      case 'account.form.name_placeholder':
        return 'Ex: Savings account';
      case 'account.form.notes':
        return 'Notes';
      case 'account.form.notes_placeholder':
        return 'Type some notes/description about this account';
      case 'account.form.initial_balance':
        return 'Initial balance';
      case 'account.form.current_balance':
        return 'Current balance';
      case 'account.form.create':
        return 'Create account';
      case 'account.form.edit':
        return 'Edit account';
      case 'account.form.currency_not_found_warn':
        return 'You do not have information on exchange rates for this currency. 1.0 will be used as the default exchange rate. You can modify this in the settings';
      case 'account.form.already_exists':
        return 'There is already another one with the same name, please write another';
      case 'account.form.tr_before_opening_date':
        return 'There are transactions in this account with a date before the opening date';
      case 'account.form.iban':
        return 'IBAN';
      case 'account.form.swift':
        return 'SWIFT';
      case 'account.delete.warning_header':
        return 'Delete account?';
      case 'account.delete.warning_text':
        return 'This action will delete this account and all its transactions';
      case 'account.delete.success':
        return 'Account deleted successfully';
      case 'account.close.title':
        return 'Close account';
      case 'account.close.title_short':
        return 'Close';
      case 'account.close.warn':
        return 'This account will no longer appear in certain listings and you will not be able to create transactions in it with a date later than the one specified below. This action does not affect any transactions or balance, and you can also reopen this account at any time. ';
      case 'account.close.should_have_zero_balance':
        return 'You must have a current balance of 0 in this account to close it. Please edit the account before continuing';
      case 'account.close.should_have_no_transactions':
        return 'This account has transactions after the specified close date. Delete them or edit the account close date before continuing';
      case 'account.close.success':
        return 'Account closed successfully';
      case 'account.close.unarchive_succes':
        return 'Account successfully re-opened';
      case 'account.select.one':
        return 'Select an account';
      case 'account.select.all':
        return 'All accounts';
      case 'account.select.multiple':
        return 'Select accounts';
      case 'currencies.currency_converter':
        return 'Currency converter';
      case 'currencies.currency':
        return 'Currency';
      case 'currencies.currency_manager':
        return 'Currency manager';
      case 'currencies.currency_manager_descr':
        return 'Configure your currency and its exchange rates with others';
      case 'currencies.preferred_currency':
        return 'Preferred/base currency';
      case 'currencies.change_preferred_currency_title':
        return 'Change preferred currency';
      case 'currencies.change_preferred_currency_msg':
        return 'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?';
      case 'currencies.form.equal_to_preferred_warn':
        return 'The currency cannot be equal to the user currency';
      case 'currencies.form.specify_a_currency':
        return 'Please specify a currency';
      case 'currencies.form.add':
        return 'Add exchange rate';
      case 'currencies.form.add_success':
        return 'Exchange rate added successfully';
      case 'currencies.form.edit':
        return 'Edit exchange rate';
      case 'currencies.form.edit_success':
        return 'Exchange rate edited successfully';
      case 'currencies.delete_all_success':
        return 'Deleted exchange rates successfully';
      case 'currencies.historical':
        return 'Historical rates';
      case 'currencies.exchange_rate':
        return 'Exchange rate';
      case 'currencies.exchange_rates':
        return 'Exchange rates';
      case 'currencies.empty':
        return 'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate';
      case 'currencies.select_a_currency':
        return 'Select a currency';
      case 'currencies.search_title':
        return 'Tap to search';
      case 'currencies.search_placeholder':
        return 'Search by name or by currency code';
      case 'tags.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              one: 'Label',
              other: 'Tags',
            );
      case 'tags.form.name':
        return 'Tag name';
      case 'tags.form.description':
        return 'Description';
      case 'tags.empty_list':
        return 'You haven\'t created any tags yet. Tags and categories are a great way to categorize your movements';
      case 'tags.without_tags':
        return 'Without tags';
      case 'tags.select':
        return 'Select tags';
      case 'tags.add':
        return 'Add tag';
      case 'tags.create':
        return 'Create label';
      case 'tags.create_success':
        return 'Label created successfully';
      case 'tags.already_exists':
        return 'This tag name already exists. You may want to edit it';
      case 'tags.edit':
        return 'Edit tag';
      case 'tags.edit_success':
        return 'Tag edited successfully';
      case 'tags.delete_success':
        return 'Category deleted successfully';
      case 'tags.delete_warning_header':
        return 'Delete tag?';
      case 'tags.delete_warning_message':
        return 'This action will not delete transactions that have this tag.';
      case 'categories.unknown':
        return 'Unknown category';
      case 'categories.create':
        return 'Create category';
      case 'categories.create_success':
        return 'Category created correctly';
      case 'categories.new_category':
        return 'New category';
      case 'categories.already_exists':
        return 'The name of this category already exists. Maybe you want to edit it';
      case 'categories.edit':
        return 'Edit category';
      case 'categories.edit_success':
        return 'Category edited correctly';
      case 'categories.name':
        return 'Category name';
      case 'categories.type':
        return 'Category type';
      case 'categories.both_types':
        return 'Both types';
      case 'categories.subcategories':
        return 'Subcategories';
      case 'categories.subcategories_add':
        return 'Add subcategory';
      case 'categories.make_parent':
        return 'Make to category';
      case 'categories.make_child':
        return 'Make a subcategory';
      case 'categories.make_child_warning1':
        return ({required Object destiny}) =>
            'This category and its subcategories will become subcategories of <b>${destiny}</b>.';
      case 'categories.make_child_warning2':
        return ({required Object x, required Object destiny}) =>
            'Their transactions <b>(${x})</b> will be moved to the new subcategories created within the <b>${destiny}</b> category.';
      case 'categories.make_child_success':
        return 'Subcategories created successfully';
      case 'categories.merge':
        return 'Merge with another category';
      case 'categories.merge_warning1':
        return (
                {required Object x,
                required Object from,
                required Object destiny}) =>
            'All transactions (${x}) associated with the category <b>${from}</b> will be moved to the category <b>${destiny}</b>';
      case 'categories.merge_warning2':
        return ({required Object from}) =>
            'The category <b>${from}</b> will be irreversibly deleted.';
      case 'categories.merge_success':
        return 'Category merged successfully';
      case 'categories.delete_success':
        return 'Category deleted correctly';
      case 'categories.delete_warning_header':
        return 'Delete category?';
      case 'categories.delete_warning_message':
        return ({required Object x}) =>
            'This action will irreversibly delete all transactions <b>(${x})</b> related to this category.';
      case 'categories.select.title':
        return 'Select categories';
      case 'categories.select.select_one':
        return 'Select a category';
      case 'categories.select.select_subcategory':
        return 'Choose a subcategory';
      case 'categories.select.without_subcategory':
        return 'Without subcategory';
      case 'categories.select.all':
        return 'All categories';
      case 'categories.select.all_short':
        return 'All';
      case 'budgets.title':
        return 'Budgets';
      case 'budgets.repeated':
        return 'Recurring';
      case 'budgets.one_time':
        return 'Once';
      case 'budgets.annual':
        return 'Annuals';
      case 'budgets.week':
        return 'Weekly';
      case 'budgets.month':
        return 'Monthly';
      case 'budgets.actives':
        return 'Actives';
      case 'budgets.pending':
        return 'Pending start';
      case 'budgets.finish':
        return 'Finished';
      case 'budgets.from_budgeted':
        return 'left of ';
      case 'budgets.days_left':
        return 'days left';
      case 'budgets.days_to_start':
        return 'days to start';
      case 'budgets.since_expiration':
        return 'days since expiration';
      case 'budgets.no_budgets':
        return 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';
      case 'budgets.delete':
        return 'Delete budget';
      case 'budgets.delete_warning':
        return 'This action is irreversible. Categories and transactions referring to this quote will not be deleted';
      case 'budgets.form.title':
        return 'Add a budget';
      case 'budgets.form.name':
        return 'Budget name';
      case 'budgets.form.value':
        return 'Limit quantity';
      case 'budgets.form.create':
        return 'Add budget';
      case 'budgets.form.edit':
        return 'Edit budget';
      case 'budgets.form.negative_warn':
        return 'The budgets can not have a negative amount';
      case 'budgets.details.title':
        return 'Budget Details';
      case 'budgets.details.statistics':
        return 'Statistics';
      case 'budgets.details.budget_value':
        return 'Budgeted';
      case 'budgets.details.expend_diary_left':
        return ({required Object dailyAmount, required Object remainingDays}) =>
            'You can spend ${dailyAmount}/day for ${remainingDays} remaining days';
      case 'budgets.details.expend_evolution':
        return 'Expenditure evolution';
      case 'budgets.details.no_transactions':
        return 'It seems that you have not made any expenses related to this budget';
      case 'backup.export.title':
        return 'Export your data';
      case 'backup.export.title_short':
        return 'Export';
      case 'backup.export.all':
        return 'Full backup';
      case 'backup.export.all_descr':
        return 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';
      case 'backup.export.transactions':
        return 'Transactions backup';
      case 'backup.export.transactions_descr':
        return 'Export your transactions in CSV so you can more easily analyze them in other programs or applications.';
      case 'backup.export.description':
        return 'Download your data in different formats';
      case 'backup.export.dialog_title':
        return 'Save/Send file';
      case 'backup.export.success':
        return ({required Object x}) =>
            'File saved/downloaded successfully in ${x}';
      case 'backup.export.error':
        return 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
      case 'backup.import.title':
        return 'Import your data';
      case 'backup.import.title_short':
        return 'Import';
      case 'backup.import.restore_backup':
        return 'Restore Backup';
      case 'backup.import.restore_backup_descr':
        return 'Import a previously saved database from Monekin. This action will replace any current application data with the new data';
      case 'backup.import.restore_backup_warn_description':
        return 'When importing a new database, you will lose all data currently saved in the app. It is recommended to make a backup before continuing. Do not upload here any file whose origin you do not know, upload only files that you have previously downloaded from Monekin';
      case 'backup.import.restore_backup_warn_title':
        return 'Overwrite all data';
      case 'backup.import.select_other_file':
        return 'Select other file';
      case 'backup.import.tap_to_select_file':
        return 'Tap to select a file';
      case 'backup.import.manual_import.title':
        return 'Manual import';
      case 'backup.import.manual_import.descr':
        return 'Import transactions from a .csv file manually';
      case 'backup.import.manual_import.default_account':
        return 'Default account';
      case 'backup.import.manual_import.remove_default_account':
        return 'Remove default account';
      case 'backup.import.manual_import.default_category':
        return 'Default Category';
      case 'backup.import.manual_import.select_a_column':
        return 'Select a column from the .csv';
      case 'backup.import.manual_import.steps.0':
        return 'Select your file';
      case 'backup.import.manual_import.steps.1':
        return 'Column for quantity';
      case 'backup.import.manual_import.steps.2':
        return 'Column for account';
      case 'backup.import.manual_import.steps.3':
        return 'Column for category';
      case 'backup.import.manual_import.steps.4':
        return 'Column for date';
      case 'backup.import.manual_import.steps.5':
        return 'other columns';
      case 'backup.import.manual_import.steps_descr.0':
        return 'Select a .csv file from your device. Make sure it has a first row that describes the name of each column';
      case 'backup.import.manual_import.steps_descr.1':
        return 'Select the column where the value of each transaction is specified. Use negative values for expenses and positive values for income. Use a point as a decimal separator';
      case 'backup.import.manual_import.steps_descr.2':
        return 'Select the column where the account to which each transaction belongs is specified. You can also select a default account in case we cannot find the account you want. If a default account is not specified, we will create one with the same name ';
      case 'backup.import.manual_import.steps_descr.3':
        return 'Specify the column where the transaction category name is located. You must specify a default category so that we assign this category to transactions, in case the category cannot be found';
      case 'backup.import.manual_import.steps_descr.4':
        return 'Select the column where the date of each transaction is specified. If not specified, transactions will be created with the current date';
      case 'backup.import.manual_import.steps_descr.5':
        return 'Specifies the columns for other optional transaction attributes';
      case 'backup.import.manual_import.success':
        return ({required Object x}) =>
            'Successfully imported ${x} transactions';
      case 'backup.import.success':
        return 'Import performed successfully';
      case 'backup.import.cancelled':
        return 'Import was cancelled by the user';
      case 'backup.import.error':
        return 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
      case 'backup.about.title':
        return 'Information about your database';
      case 'backup.about.create_date':
        return 'Creation date';
      case 'backup.about.modify_date':
        return 'Last modified';
      case 'backup.about.last_backup':
        return 'Last backup';
      case 'backup.about.size':
        return 'Size';
      case 'settings.title_long':
        return 'Settings and appearance';
      case 'settings.title_short':
        return 'Settings';
      case 'settings.description':
        return 'App theme, texts and other general settings';
      case 'settings.edit_profile':
        return 'Edit profile';
      case 'settings.lang_section':
        return 'Language and texts';
      case 'settings.lang_title':
        return 'App language';
      case 'settings.lang_descr':
        return 'Language in which the texts will be displayed in the app';
      case 'settings.locale':
        return 'Region';
      case 'settings.locale_descr':
        return 'Set the format to use for dates, numbers...';
      case 'settings.locale_warn':
        return 'When changing region the app will update';
      case 'settings.first_day_of_week':
        return 'First day of week';
      case 'settings.theme_and_colors':
        return 'Theme and colors';
      case 'settings.theme':
        return 'Theme';
      case 'settings.theme_auto':
        return 'Defined by the system';
      case 'settings.theme_light':
        return 'Light';
      case 'settings.theme_dark':
        return 'Dark';
      case 'settings.amoled_mode':
        return 'AMOLED mode';
      case 'settings.amoled_mode_descr':
        return 'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens';
      case 'settings.dynamic_colors':
        return 'Dynamic colors';
      case 'settings.dynamic_colors_descr':
        return 'Use your system accent color whenever possible';
      case 'settings.accent_color':
        return 'Accent color';
      case 'settings.accent_color_descr':
        return 'Choose the color the app will use to emphasize certain parts of the interface';
      case 'more.title':
        return 'More';
      case 'more.title_long':
        return 'More actions';
      case 'more.data.display':
        return 'Data';
      case 'more.data.display_descr':
        return 'Export and import your data so you don\'t lose anything';
      case 'more.data.delete_all':
        return 'Delete my data';
      case 'more.data.delete_all_header1':
        return 'Stop right there padawan ⚠️⚠️';
      case 'more.data.delete_all_message1':
        return 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';
      case 'more.data.delete_all_header2':
        return 'One last step ⚠️⚠️';
      case 'more.data.delete_all_message2':
        return 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
      case 'more.about_us.display':
        return 'App information';
      case 'more.about_us.description':
        return 'Check out the terms and other relevant information about Monekin. Get in touch with the community by reporting bugs, leaving suggestions...';
      case 'more.about_us.legal.display':
        return 'Legal information';
      case 'more.about_us.legal.privacy':
        return 'Privacy policy';
      case 'more.about_us.legal.terms':
        return 'Terms of use';
      case 'more.about_us.legal.licenses':
        return 'Licenses';
      case 'more.about_us.project.display':
        return 'Project';
      case 'more.about_us.project.contributors':
        return 'Collaborators';
      case 'more.about_us.project.contributors_descr':
        return 'All the developers who have made Monekin grow';
      case 'more.about_us.project.contact':
        return 'Contact us';
      case 'more.help_us.display':
        return 'Help us';
      case 'more.help_us.description':
        return 'Find out how you can help Monekin become better and better';
      case 'more.help_us.rate_us':
        return 'Rate us';
      case 'more.help_us.rate_us_descr':
        return 'Any rate is welcome!';
      case 'more.help_us.share':
        return 'Share Monekin';
      case 'more.help_us.share_descr':
        return 'Share our app to friends and family';
      case 'more.help_us.share_text':
        return 'Monekin! The best personal finance app. Download it here';
      case 'more.help_us.thanks':
        return 'Thank you!';
      case 'more.help_us.thanks_long':
        return 'Your contributions to Monekin and other open source projects, big and small, make great projects like this possible. Thank you for taking the time to contribute.';
      case 'more.help_us.donate':
        return 'Make a donation';
      case 'more.help_us.donate_descr':
        return 'With your donation you will help the app continue receiving improvements. What better way than to thank the work done by inviting me to a coffee?';
      case 'more.help_us.donate_success':
        return 'Donation made. Thank you very much for your contribution! ❤️';
      case 'more.help_us.donate_err':
        return 'Oops! It seems there was an error receiving your payment';
      case 'more.help_us.report':
        return 'Report bugs, leave suggestions...';
      default:
        return null;
    }
  }
}

extension on _TranslationsEs {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'general.cancel':
        return 'Cancelar';
      case 'general.or':
        return 'o';
      case 'general.understood':
        return 'Entendido';
      case 'general.unspecified':
        return 'Sin especificar';
      case 'general.confirm':
        return 'Confirmar';
      case 'general.continue_text':
        return 'Continuar';
      case 'general.quick_actions':
        return 'Acciones rápidas';
      case 'general.save':
        return 'Guardar';
      case 'general.save_changes':
        return 'Guardar cambios';
      case 'general.close_and_save':
        return 'Guardar y cerrar';
      case 'general.add':
        return 'Añadir';
      case 'general.edit':
        return 'Editar';
      case 'general.delete':
        return 'Eliminar';
      case 'general.balance':
        return 'Balance';
      case 'general.account':
        return 'Cuenta';
      case 'general.accounts':
        return 'Cuentas';
      case 'general.categories':
        return 'Categorías';
      case 'general.category':
        return 'Categoría';
      case 'general.today':
        return 'Hoy';
      case 'general.yesterday':
        return 'Ayer';
      case 'general.filters':
        return 'Filtros';
      case 'general.select_all':
        return 'Seleccionar todo';
      case 'general.deselect_all':
        return 'Deseleccionar todo';
      case 'general.empty_warn':
        return 'Ops! Esto esta muy vacio';
      case 'general.insufficient_data':
        return 'Datos insuficientes';
      case 'general.show_more_fields':
        return 'Show more fields';
      case 'general.show_less_fields':
        return 'Show less fields';
      case 'general.clipboard.success':
        return ({required Object x}) => '${x} copiado al portapapeles';
      case 'general.clipboard.error':
        return 'Error al copiar';
      case 'general.time.start_date':
        return 'Fecha de inicio';
      case 'general.time.end_date':
        return 'Fecha de fin';
      case 'general.time.from_date':
        return 'Desde fecha';
      case 'general.time.until_date':
        return 'Hasta fecha';
      case 'general.time.date':
        return 'Fecha';
      case 'general.time.datetime':
        return 'Fecha y hora';
      case 'general.time.time':
        return 'Hora';
      case 'general.time.each':
        return 'Cada';
      case 'general.time.after':
        return 'Tras';
      case 'general.time.ranges.display':
        return 'Rango temporal';
      case 'general.time.ranges.it_repeat':
        return 'Se repite';
      case 'general.time.ranges.it_ends':
        return 'Termina';
      case 'general.time.ranges.types.cycle':
        return 'Ciclos';
      case 'general.time.ranges.types.last_days':
        return 'Últimos días';
      case 'general.time.ranges.types.last_days_form':
        return ({required Object x}) => '${x} días anteriores';
      case 'general.time.ranges.types.all':
        return 'Siempre';
      case 'general.time.ranges.types.date_range':
        return 'Rango personalizado';
      case 'general.time.ranges.each_range':
        return ({required num n, required Object range}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Cada ${range}',
              other: 'Cada ${n} ${range}',
            );
      case 'general.time.ranges.each_range_until_date':
        return ({required num n, required Object range, required Object day}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Cada ${range} hasta el ${day}',
              other: 'Cada ${n} ${range} hasta el ${day}',
            );
      case 'general.time.ranges.each_range_until_times':
        return (
                {required num n,
                required Object range,
                required Object limit}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Cada ${range} ${limit} veces',
              other: 'Cada ${n} ${range} ${limit} veces',
            );
      case 'general.time.ranges.each_range_until_once':
        return ({required num n, required Object range}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Cada ${range} una vez',
              other: 'Cada ${n} ${range} una vez',
            );
      case 'general.time.ranges.forever':
        return 'Para siempre';
      case 'general.time.ranges.month':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Mes',
              other: 'Meses',
            );
      case 'general.time.ranges.year':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Año',
              other: 'Años',
            );
      case 'general.time.ranges.day':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Día',
              other: 'Días',
            );
      case 'general.time.ranges.week':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Semana',
              other: 'Semanas',
            );
      case 'general.time.periodicity.display':
        return 'Periodicidad';
      case 'general.time.periodicity.no_repeat':
        return 'Sin repetición';
      case 'general.time.periodicity.repeat':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Repetición',
              other: 'Repeticiones',
            );
      case 'general.time.periodicity.diary':
        return 'Diaría';
      case 'general.time.periodicity.monthly':
        return 'Mensual';
      case 'general.time.periodicity.annually':
        return 'Anual';
      case 'general.time.periodicity.quaterly':
        return 'Trimestral';
      case 'general.time.periodicity.weekly':
        return 'Semanal';
      case 'general.time.periodicity.custom':
        return 'Personalizado';
      case 'general.time.periodicity.infinite':
        return 'Siempre';
      case 'general.time.current.diary':
        return 'Este día';
      case 'general.time.current.monthly':
        return 'Este mes';
      case 'general.time.current.annually':
        return 'Este año';
      case 'general.time.current.quaterly':
        return 'Este trimestre';
      case 'general.time.current.weekly':
        return 'Esta semana';
      case 'general.time.current.infinite':
        return 'Desde siempre';
      case 'general.time.current.custom':
        return 'Rango personalizado';
      case 'general.time.all.diary':
        return 'Todos los días';
      case 'general.time.all.monthly':
        return 'Todos los meses';
      case 'general.time.all.annually':
        return 'Todos los años';
      case 'general.time.all.quaterly':
        return 'Todos los trimestres';
      case 'general.time.all.weekly':
        return 'Todas las semanas';
      case 'general.transaction_order.display':
        return 'Ordenar transacciones';
      case 'general.transaction_order.category':
        return 'Por categoría';
      case 'general.transaction_order.quantity':
        return 'Por cantidad';
      case 'general.transaction_order.date':
        return 'Por fecha';
      case 'general.validations.required':
        return 'Campo obligatorio';
      case 'general.validations.positive':
        return 'Debe ser positivo';
      case 'general.validations.min_number':
        return ({required Object x}) => 'Debe ser mayor que ${x}';
      case 'general.validations.max_number':
        return ({required Object x}) => 'Debe ser menor que ${x}';
      case 'intro.start':
        return 'Empecemos';
      case 'intro.skip':
        return 'Saltar';
      case 'intro.next':
        return 'Siguiente';
      case 'intro.select_your_currency':
        return 'Selecciona tu divisa';
      case 'intro.welcome_subtitle':
        return 'Tu gestor de finanzas personales';
      case 'intro.welcome_subtitle2':
        return '100% libre, 100% gratis';
      case 'intro.welcome_footer':
        return 'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación';
      case 'intro.offline_descr_title':
        return 'CUENTA SIN CONEXIÓN:';
      case 'intro.offline_descr':
        return 'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
      case 'intro.offline_start':
        return 'Iniciar sesión offline';
      case 'intro.sl1_title':
        return 'Selecciona tu divisa';
      case 'intro.sl1_descr':
        return 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
      case 'intro.sl2_title':
        return 'Seguro, privado y confiable';
      case 'intro.sl2_descr':
        return 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
      case 'intro.sl2_descr2':
        return 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
      case 'intro.last_slide_title':
        return 'Todo listo!';
      case 'intro.last_slide_descr':
        return 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
      case 'intro.last_slide_descr2':
        return 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
      case 'home.title':
        return 'Dashboard';
      case 'home.filter_transactions':
        return 'Filtrar transacciones';
      case 'home.hello_day':
        return 'Buenos días,';
      case 'home.hello_night':
        return 'Buenas noches,';
      case 'home.total_balance':
        return 'Saldo total';
      case 'home.my_accounts':
        return 'Mis cuentas';
      case 'home.active_accounts':
        return 'Cuentas activas';
      case 'home.no_accounts':
        return 'Aun no hay cuentas creadas';
      case 'home.no_accounts_descr':
        return 'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones';
      case 'home.last_transactions':
        return 'Últimas transacciones';
      case 'home.should_create_account_header':
        return 'Ops!';
      case 'home.should_create_account_message':
        return 'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones';
      case 'financial_health.display':
        return 'Salud financiera';
      case 'financial_health.review.very_good':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Excelente!';
            case GenderContext.female:
              return 'Excelente!';
          }
        };
      case 'financial_health.review.good':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Bueno';
            case GenderContext.female:
              return 'Buena';
          }
        };
      case 'financial_health.review.normal':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'En la media';
            case GenderContext.female:
              return 'En la media';
          }
        };
      case 'financial_health.review.bad':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Regular';
            case GenderContext.female:
              return 'Regular';
          }
        };
      case 'financial_health.review.very_bad':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Muy malo';
            case GenderContext.female:
              return 'Muy mala';
          }
        };
      case 'financial_health.review.insufficient_data':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Datos insuficientes';
            case GenderContext.female:
              return 'Datos insuficientes';
          }
        };
      case 'financial_health.review.descr.insufficient_data':
        return 'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!';
      case 'financial_health.review.descr.very_good':
        return 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
      case 'financial_health.review.descr.good':
        return 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
      case 'financial_health.review.descr.normal':
        return 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
      case 'financial_health.review.descr.bad':
        return 'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas';
      case 'financial_health.review.descr.very_bad':
        return 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos';
      case 'financial_health.months_without_income.title':
        return 'Ratio de supervivencia';
      case 'financial_health.months_without_income.subtitle':
        return 'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos';
      case 'financial_health.months_without_income.text_zero':
        return '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!';
      case 'financial_health.months_without_income.text_one':
        return '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!';
      case 'financial_health.months_without_income.text_other':
        return ({required Object n}) =>
            'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.';
      case 'financial_health.months_without_income.text_infinite':
        return 'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.';
      case 'financial_health.months_without_income.suggestion':
        return 'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.';
      case 'financial_health.months_without_income.insufficient_data':
        return 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
      case 'financial_health.savings_percentage.title':
        return 'Porcentaje de ahorro';
      case 'financial_health.savings_percentage.subtitle':
        return 'Que parte de tus ingresos no son gastados en este periodo';
      case 'financial_health.savings_percentage.text.good':
        return ({required Object value}) =>
            'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!';
      case 'financial_health.savings_percentage.text.normal':
        return ({required Object value}) =>
            'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.';
      case 'financial_health.savings_percentage.text.bad':
        return ({required Object value}) =>
            'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!';
      case 'financial_health.savings_percentage.text.very_bad':
        return 'Vaya, no has conseguido ahorrar nada durante este periodo.';
      case 'financial_health.savings_percentage.suggestion':
        return 'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.';
      case 'stats.title':
        return 'Estadísticas';
      case 'stats.balance':
        return 'Saldo';
      case 'stats.final_balance':
        return 'Saldo final';
      case 'stats.balance_by_account':
        return 'Saldo por cuentas';
      case 'stats.balance_by_currency':
        return 'Saldo por divisas';
      case 'stats.balance_evolution':
        return 'Tendencia de saldo';
      case 'stats.compared_to_previous_period':
        return 'Frente al periodo anterior';
      case 'stats.cash_flow':
        return 'Flujo de caja';
      case 'stats.by_periods':
        return 'Por periodos';
      case 'stats.by_categories':
        return 'Por categorías';
      case 'stats.by_tags':
        return 'Por etiquetas';
      case 'stats.distribution':
        return 'Distribución';
      case 'stats.finance_health_resume':
        return 'Resumen';
      case 'stats.finance_health_breakdown':
        return 'Desglose';
      case 'icon_selector.name':
        return 'Nombre:';
      case 'icon_selector.icon':
        return 'Icono';
      case 'icon_selector.color':
        return 'Color';
      case 'icon_selector.select_icon':
        return 'Selecciona un icono';
      case 'icon_selector.select_color':
        return 'Selecciona un color';
      case 'icon_selector.select_account_icon':
        return 'Identifica tu cuenta';
      case 'icon_selector.select_category_icon':
        return 'Identifica tu categoría';
      case 'icon_selector.scopes.transport':
        return 'Transporte';
      case 'icon_selector.scopes.money':
        return 'Dinero';
      case 'icon_selector.scopes.food':
        return 'Comida';
      case 'icon_selector.scopes.medical':
        return 'Salud';
      case 'icon_selector.scopes.entertainment':
        return 'Entretenimiento';
      case 'icon_selector.scopes.technology':
        return 'Technología';
      case 'icon_selector.scopes.other':
        return 'Otros';
      case 'icon_selector.scopes.logos_financial_institutions':
        return 'Financial institutions';
      case 'transaction.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Transacción',
              other: 'Transacciones',
            );
      case 'transaction.create':
        return 'Nueva transacción';
      case 'transaction.new_income':
        return 'Nuevo ingreso';
      case 'transaction.new_expense':
        return 'Nuevo gasto';
      case 'transaction.new_success':
        return 'Transacción creada correctamente';
      case 'transaction.edit':
        return 'Editar transacción';
      case 'transaction.edit_success':
        return 'Transacción editada correctamente';
      case 'transaction.edit_multiple':
        return 'Editar transacciones';
      case 'transaction.edit_multiple_success':
        return ({required Object x}) =>
            '${x} transacciones editadas correctamente';
      case 'transaction.duplicate':
        return 'Clonar transacción';
      case 'transaction.duplicate_short':
        return 'Clonar';
      case 'transaction.duplicate_warning_message':
        return 'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?';
      case 'transaction.duplicate_success':
        return 'Transacción clonada con exito';
      case 'transaction.delete':
        return 'Eliminar transacción';
      case 'transaction.delete_warning_message':
        return 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
      case 'transaction.delete_success':
        return 'Transacción eliminada correctamente';
      case 'transaction.delete_multiple':
        return 'Eliminar transacciones';
      case 'transaction.delete_multiple_warning_message':
        return ({required Object x}) =>
            'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
      case 'transaction.delete_multiple_success':
        return ({required Object x}) =>
            '${x} transacciones eliminadas correctamente';
      case 'transaction.details':
        return 'Detalles del movimiento';
      case 'transaction.next_payments.skip':
        return 'Saltar';
      case 'transaction.next_payments.skip_success':
        return 'Transacción saltada con exito';
      case 'transaction.next_payments.skip_dialog_title':
        return 'Saltar transacción';
      case 'transaction.next_payments.skip_dialog_msg':
        return ({required Object date}) =>
            'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}';
      case 'transaction.next_payments.accept':
        return 'Aceptar';
      case 'transaction.next_payments.accept_today':
        return 'Aceptar hoy';
      case 'transaction.next_payments.accept_in_required_date':
        return ({required Object date}) =>
            'Aceptar en la fecha requerida (${date})';
      case 'transaction.next_payments.accept_dialog_title':
        return 'Aceptar transacción';
      case 'transaction.next_payments.accept_dialog_msg_single':
        return 'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees';
      case 'transaction.next_payments.accept_dialog_msg':
        return ({required Object date}) =>
            'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones';
      case 'transaction.next_payments.recurrent_rule_finished':
        return 'La regla recurrente se ha completado, ya no hay mas pagos a realizar!';
      case 'transaction.list.empty':
        return 'No se han encontrado transacciones que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
      case 'transaction.list.searcher_placeholder':
        return 'Busca por categoría, descripción...';
      case 'transaction.list.searcher_no_results':
        return 'No se han encontrado transacciones que coincidan con los criterios de busqueda';
      case 'transaction.list.loading':
        return 'Cargando más transacciones...';
      case 'transaction.list.selected_short':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: '${n} seleccionada',
              other: '${n} seleccionadas',
            );
      case 'transaction.list.selected_long':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: '${n} transacción seleccionada',
              other: '${n} transacciones seleccionadas',
            );
      case 'transaction.list.bulk_edit.dates':
        return 'Editar fechas';
      case 'transaction.list.bulk_edit.categories':
        return 'Editar categorías';
      case 'transaction.filters.from_value':
        return 'Desde monto';
      case 'transaction.filters.to_value':
        return 'Hasta monto';
      case 'transaction.filters.from_value_def':
        return ({required Object x}) => 'Desde ${x}';
      case 'transaction.filters.to_value_def':
        return ({required Object x}) => 'Hasta ${x}';
      case 'transaction.filters.from_date_def':
        return ({required Object date}) => 'Desde el ${date}';
      case 'transaction.filters.to_date_def':
        return ({required Object date}) => 'Hasta el ${date}';
      case 'transaction.form.validators.zero':
        return 'El valor de una transacción no puede ser igual a cero';
      case 'transaction.form.validators.date_max':
        return 'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente';
      case 'transaction.form.validators.date_after_account_creation':
        return 'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece';
      case 'transaction.form.validators.negative_transaction':
        return 'No uses cantidades negativas para tu transaccion. Aplicaremos el signo en función de si la categoría seleccionada es de tipo gasto/ingreso';
      case 'transaction.form.validators.negative_transfer':
        return 'El valor monetario de una transferencia no puede ser negativo';
      case 'transaction.form.title':
        return 'Título de la transacción';
      case 'transaction.form.value':
        return 'Valor de la transacción';
      case 'transaction.form.tap_to_see_more':
        return 'Toca para ver más detalles';
      case 'transaction.form.description':
        return 'Descripción';
      case 'transaction.form.description_info':
        return 'Añadir una nota te ayudará a encontrar más rapidamente esta transacción en un futuro';
      case 'transaction.form.exchange_to_preferred_title':
        return ({required Object currency}) => 'Cambio a ${currency}';
      case 'transaction.form.exchange_to_preferred_in_date':
        return 'El día de la transacción';
      case 'transaction.status.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Estado',
              other: 'Estados',
            );
      case 'transaction.status.tr_status':
        return ({required Object status}) => 'Transacción ${status}';
      case 'transaction.status.none':
        return 'Sin estado';
      case 'transaction.status.reconciled':
        return 'Reconciliada';
      case 'transaction.status.reconciled_descr':
        return 'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco';
      case 'transaction.status.unreconciled':
        return 'No reconciliada';
      case 'transaction.status.unreconciled_descr':
        return 'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin';
      case 'transaction.status.pending':
        return 'Pendiente';
      case 'transaction.status.pending_descr':
        return 'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas';
      case 'transaction.status.voided':
        return 'Nula';
      case 'transaction.status.voided_descr':
        return 'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas';
      case 'transaction.types.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Tipo de transacción',
              other: 'Tipos de transacción',
            );
      case 'transaction.types.income':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Ingreso',
              other: 'Ingresos',
            );
      case 'transaction.types.expense':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Gasto',
              other: 'Gastos',
            );
      case 'transaction.types.transfer':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Transferencia',
              other: 'Transferencias',
            );
      case 'transfer.display':
        return 'Transferencia';
      case 'transfer.transfers':
        return 'Transferencias';
      case 'transfer.transfer_to':
        return ({required Object account}) => 'Transferencia hacia ${account}';
      case 'transfer.create':
        return 'Nueva transferencia';
      case 'transfer.need_two_accounts_warning_header':
        return 'Ops!';
      case 'transfer.need_two_accounts_warning_message':
        return 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
      case 'transfer.form.from':
        return 'Cuenta origen';
      case 'transfer.form.to':
        return 'Cuenta destino';
      case 'transfer.form.currency_info_add':
        return ({required Object x}) =>
            'Se transpasarán ${x} a la cuenta de destino';
      case 'transfer.form.currency_info_edit':
        return ({required Object x}) =>
            'Se han transpasado ${x} a la cuenta de destino';
      case 'transfer.form.currency_exchange_selector.title':
        return 'Editar cambio entre divisas';
      case 'transfer.form.currency_exchange_selector.value_in_destiny':
        return 'Cantidad transferida en destino';
      case 'recurrent_transactions.title':
        return 'Movimientos recurrentes';
      case 'recurrent_transactions.title_short':
        return 'Mov. recurrentes';
      case 'recurrent_transactions.empty':
        return 'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
      case 'recurrent_transactions.total_expense_title':
        return 'Gasto total por periodo';
      case 'recurrent_transactions.total_expense_descr':
        return '* Sin considerar la fecha de inicio y fin de cada recurrencia';
      case 'recurrent_transactions.details.title':
        return 'Transaccion recurrente';
      case 'recurrent_transactions.details.descr':
        return 'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento';
      case 'recurrent_transactions.details.last_payment_info':
        return 'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción';
      case 'recurrent_transactions.details.delete_header':
        return 'Eliminar transacción recurrente';
      case 'recurrent_transactions.details.delete_message':
        return 'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado';
      case 'account.details':
        return 'Detalles de la cuenta';
      case 'account.date':
        return 'Fecha de apertura';
      case 'account.close_date':
        return 'Fecha de cierre';
      case 'account.reopen_short':
        return 'Reabrir';
      case 'account.reopen':
        return 'Reabrir cuenta';
      case 'account.reopen_descr':
        return '¿Seguro que quieres volver a abrir esta cuenta?';
      case 'account.balance':
        return 'Saldo de la cuenta';
      case 'account.n_transactions':
        return 'Número de transacciones';
      case 'account.add_money':
        return 'Añadir dinero';
      case 'account.withdraw_money':
        return 'Retirar dinero';
      case 'account.no_accounts':
        return 'No se han encontrado cuentas que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
      case 'account.types.title':
        return 'Tipo de cuenta';
      case 'account.types.warning':
        return 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
      case 'account.types.normal':
        return 'Cuenta corriente';
      case 'account.types.normal_descr':
        return 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
      case 'account.types.saving':
        return 'Cuenta de ahorros';
      case 'account.types.saving_descr':
        return 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
      case 'account.form.name':
        return 'Nombre de la cuenta';
      case 'account.form.name_placeholder':
        return 'Ej: Cuenta de ahorros';
      case 'account.form.notes':
        return 'Notas';
      case 'account.form.notes_placeholder':
        return 'Escribe algunas notas/descripciones sobre esta cuenta';
      case 'account.form.initial_balance':
        return 'Balance inicial';
      case 'account.form.current_balance':
        return 'Balance actual';
      case 'account.form.create':
        return 'Crear cuenta';
      case 'account.form.edit':
        return 'Editar cuenta';
      case 'account.form.tr_before_opening_date':
        return 'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura';
      case 'account.form.currency_not_found_warn':
        return 'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes';
      case 'account.form.already_exists':
        return 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
      case 'account.form.iban':
        return 'IBAN';
      case 'account.form.swift':
        return 'SWIFT';
      case 'account.delete.warning_header':
        return '¿Eliminar cuenta?';
      case 'account.delete.warning_text':
        return 'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.';
      case 'account.delete.success':
        return 'Cuenta eliminada correctamente';
      case 'account.close.title':
        return 'Cerrar cuenta';
      case 'account.close.title_short':
        return 'Cerrar';
      case 'account.close.warn':
        return 'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras';
      case 'account.close.should_have_zero_balance':
        return 'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar';
      case 'account.close.should_have_no_transactions':
        return 'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar';
      case 'account.close.success':
        return 'Cuenta cerrada exitosamente';
      case 'account.close.unarchive_succes':
        return 'Cuenta re-abierta exitosamente';
      case 'account.select.one':
        return 'Selecciona una cuenta';
      case 'account.select.multiple':
        return 'Selecciona cuentas';
      case 'account.select.all':
        return 'Todas las cuentas';
      case 'currencies.currency_converter':
        return 'Conversor de divisas';
      case 'currencies.currency_manager':
        return 'Administrador de divisas';
      case 'currencies.currency_manager_descr':
        return 'Configura tu divisa y sus tipos de cambio con otras';
      case 'currencies.currency':
        return 'Divisa';
      case 'currencies.preferred_currency':
        return 'Divisa predeterminada/base';
      case 'currencies.change_preferred_currency_title':
        return 'Cambiar divisa predeterminada';
      case 'currencies.change_preferred_currency_msg':
        return 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
      case 'currencies.form.equal_to_preferred_warn':
        return 'The currency can not be equal to the user currency';
      case 'currencies.form.specify_a_currency':
        return 'Por favor, especifica una divisa';
      case 'currencies.form.add':
        return 'Añadir tipo de cambio';
      case 'currencies.form.add_success':
        return 'Tipo de cambio añadido correctamente';
      case 'currencies.form.edit':
        return 'Editar tipo de cambio';
      case 'currencies.form.edit_success':
        return 'Tipo de cambio editado correctamente';
      case 'currencies.delete_all_success':
        return 'Tipos de cambio borrados con exito';
      case 'currencies.historical':
        return 'Histórico de tasas';
      case 'currencies.exchange_rate':
        return 'Tipo de cambio';
      case 'currencies.exchange_rates':
        return 'Tipos de cambio';
      case 'currencies.empty':
        return 'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos';
      case 'currencies.select_a_currency':
        return 'Selecciona una divisa';
      case 'currencies.search_title':
        return 'Toca para buscar';
      case 'currencies.search_placeholder':
        return 'Busca por nombre o por código de la divisa';
      case 'tags.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              one: 'Etiqueta',
              other: 'Etiquetas',
            );
      case 'tags.form.name':
        return 'Nombre de la etiqueta';
      case 'tags.form.description':
        return 'Descripción';
      case 'tags.empty_list':
        return 'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos';
      case 'tags.without_tags':
        return 'Sin etiquetas';
      case 'tags.select':
        return 'Selecionar etiquetas';
      case 'tags.create':
        return 'Crear etiqueta';
      case 'tags.add':
        return 'Añadir etiqueta';
      case 'tags.create_success':
        return 'Etiqueta creada correctamente';
      case 'tags.already_exists':
        return 'El nombre de esta etiqueta ya existe. Puede que quieras editarla';
      case 'tags.edit':
        return 'Editar etiqueta';
      case 'tags.edit_success':
        return 'Etiqueta editada correctamente';
      case 'tags.delete_success':
        return 'Categoría eliminada correctamente';
      case 'tags.delete_warning_header':
        return '¿Eliminar etiqueta?';
      case 'tags.delete_warning_message':
        return 'Esta acción no borrará las transacciones que poseen esta etiqueta.';
      case 'categories.unknown':
        return 'Categoría desconocida';
      case 'categories.create':
        return 'Crear categoría';
      case 'categories.create_success':
        return 'Categoría creada correctamente';
      case 'categories.new_category':
        return 'Nueva categoría';
      case 'categories.already_exists':
        return 'El nombre de esta categoría ya existe. Puede que quieras editarla';
      case 'categories.edit':
        return 'Editar categoría';
      case 'categories.edit_success':
        return 'Categoría editada correctamente';
      case 'categories.name':
        return 'Nombre de la categoría';
      case 'categories.type':
        return 'Tipo de categoría';
      case 'categories.both_types':
        return 'Ambos tipos';
      case 'categories.subcategories':
        return 'Subcategorías';
      case 'categories.subcategories_add':
        return 'Añadir subcategoría';
      case 'categories.make_parent':
        return 'Convertir en categoría';
      case 'categories.make_child':
        return 'Convertir en subcategoría';
      case 'categories.make_child_warning1':
        return ({required Object destiny}) =>
            'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.';
      case 'categories.make_child_warning2':
        return ({required Object x, required Object destiny}) =>
            'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.';
      case 'categories.make_child_success':
        return 'Subcategorías creadas con exito';
      case 'categories.merge':
        return 'Fusionar con otra categoría';
      case 'categories.merge_warning1':
        return (
                {required Object x,
                required Object from,
                required Object destiny}) =>
            'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.';
      case 'categories.merge_warning2':
        return ({required Object from}) =>
            'La categoría <b>${from}</b> será eliminada de forma irreversible.';
      case 'categories.merge_success':
        return 'Categoría fusionada correctamente';
      case 'categories.delete_success':
        return 'Categoría eliminada correctamente';
      case 'categories.delete_warning_header':
        return '¿Eliminar categoría?';
      case 'categories.delete_warning_message':
        return ({required Object x}) =>
            'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.';
      case 'categories.select.title':
        return 'Selecciona categorías';
      case 'categories.select.select_one':
        return 'Selecciona una categoría';
      case 'categories.select.select_subcategory':
        return 'Elige una subcategoría';
      case 'categories.select.without_subcategory':
        return 'Sin subcategoría';
      case 'categories.select.all':
        return 'Todas las categorías';
      case 'categories.select.all_short':
        return 'Todas';
      case 'budgets.title':
        return 'Presupuestos';
      case 'budgets.repeated':
        return 'Periódicos';
      case 'budgets.one_time':
        return 'Una vez';
      case 'budgets.annual':
        return 'Anuales';
      case 'budgets.week':
        return 'Semanales';
      case 'budgets.month':
        return 'Mensuales';
      case 'budgets.actives':
        return 'Activos';
      case 'budgets.pending':
        return 'Pendientes de comenzar';
      case 'budgets.finish':
        return 'Finalizados';
      case 'budgets.from_budgeted':
        return 'De un total de ';
      case 'budgets.days_left':
        return 'días restantes';
      case 'budgets.days_to_start':
        return 'días para empezar';
      case 'budgets.since_expiration':
        return 'días desde su expiración';
      case 'budgets.no_budgets':
        return 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
      case 'budgets.delete':
        return 'Eliminar presupuesto';
      case 'budgets.delete_warning':
        return 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
      case 'budgets.form.title':
        return 'Añade un presupuesto';
      case 'budgets.form.name':
        return 'Nombre del presupuesto';
      case 'budgets.form.value':
        return 'Cantidad límite';
      case 'budgets.form.create':
        return 'Añade el presupuesto';
      case 'budgets.form.edit':
        return 'Editar presupuesto';
      case 'budgets.form.negative_warn':
        return 'Los presupuestos no pueden tener un valor límite negativo';
      case 'budgets.details.title':
        return 'Detalles del presupuesto';
      case 'budgets.details.budget_value':
        return 'Presupuestado';
      case 'budgets.details.statistics':
        return 'Estadísticas';
      case 'budgets.details.expend_diary_left':
        return ({required Object dailyAmount, required Object remainingDays}) =>
            'Puedes gastar ${dailyAmount}/día por los ${remainingDays} días restantes';
      case 'budgets.details.expend_evolution':
        return 'Evolución del gasto';
      case 'budgets.details.no_transactions':
        return 'Parece que no has realizado ningún gasto relativo a este presupuesto';
      case 'backup.export.title':
        return 'Exportar datos';
      case 'backup.export.title_short':
        return 'Exportar';
      case 'backup.export.all':
        return 'Respaldo total';
      case 'backup.export.all_descr':
        return 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
      case 'backup.export.transactions':
        return 'Respaldo de transacciones';
      case 'backup.export.transactions_descr':
        return 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
      case 'backup.export.description':
        return 'Exporta tus datos en diferentes formatos';
      case 'backup.export.dialog_title':
        return 'Guardar/Enviar archivo';
      case 'backup.export.success':
        return ({required Object x}) =>
            'Archivo guardado/enviado correctamente en ${x}';
      case 'backup.export.error':
        return 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
      case 'backup.import.title':
        return 'Importar tus datos';
      case 'backup.import.title_short':
        return 'Importar';
      case 'backup.import.restore_backup':
        return 'Restaurar copia de seguridad';
      case 'backup.import.restore_backup_descr':
        return 'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos';
      case 'backup.import.restore_backup_warn_title':
        return 'Sobreescribir todos los datos';
      case 'backup.import.restore_backup_warn_description':
        return 'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin';
      case 'backup.import.tap_to_select_file':
        return 'Pulsa para seleccionar un archivo';
      case 'backup.import.select_other_file':
        return 'Selecciona otro fichero';
      case 'backup.import.manual_import.title':
        return 'Importación manual';
      case 'backup.import.manual_import.descr':
        return 'Importa transacciones desde un fichero .csv de forma manual';
      case 'backup.import.manual_import.default_account':
        return 'Cuenta por defecto';
      case 'backup.import.manual_import.remove_default_account':
        return 'Eliminar cuenta por defecto';
      case 'backup.import.manual_import.default_category':
        return 'Categoría por defecto';
      case 'backup.import.manual_import.select_a_column':
        return 'Selecciona una columna del .csv';
      case 'backup.import.manual_import.success':
        return ({required Object x}) =>
            'Se han importado correctamente ${x} transacciones';
      case 'backup.import.manual_import.steps.0':
        return 'Selecciona tu fichero';
      case 'backup.import.manual_import.steps.1':
        return 'Columna para la cantidad';
      case 'backup.import.manual_import.steps.2':
        return 'Columna para la cuenta';
      case 'backup.import.manual_import.steps.3':
        return 'Columna para la categoría';
      case 'backup.import.manual_import.steps.4':
        return 'Columna para la fecha';
      case 'backup.import.manual_import.steps.5':
        return 'Otras columnas';
      case 'backup.import.manual_import.steps_descr.0':
        return 'Selecciona un fichero .csv de tu dispositivo. Asegurate de que este tenga una primera fila que describa el nombre de cada columna';
      case 'backup.import.manual_import.steps_descr.1':
        return 'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos. Usa un punto como separador decimal';
      case 'backup.import.manual_import.steps_descr.2':
        return 'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre';
      case 'backup.import.manual_import.steps_descr.3':
        return 'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar';
      case 'backup.import.manual_import.steps_descr.4':
        return 'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual';
      case 'backup.import.manual_import.steps_descr.5':
        return 'Especifica las columnas para otros atributos optativos de las transacciones';
      case 'backup.import.success':
        return 'Importación realizada con exito';
      case 'backup.import.cancelled':
        return 'La importación fue cancelada por el usuario';
      case 'backup.import.error':
        return 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
      case 'backup.about.title':
        return 'Información sobre tu base de datos';
      case 'backup.about.create_date':
        return 'Fecha de creación';
      case 'backup.about.modify_date':
        return 'Última modificación';
      case 'backup.about.last_backup':
        return 'Última copia de seguridad';
      case 'backup.about.size':
        return 'Tamaño';
      case 'settings.title_long':
        return 'Configuración y apariencia';
      case 'settings.title_short':
        return 'Configuración';
      case 'settings.description':
        return 'Tema de la aplicación, textos y otras configuraciones generales';
      case 'settings.edit_profile':
        return 'Editar perfil';
      case 'settings.lang_section':
        return 'Idioma y textos';
      case 'settings.lang_title':
        return 'Idioma de la aplicación';
      case 'settings.lang_descr':
        return 'Idioma en el que se mostrarán los textos en la aplicación';
      case 'settings.locale':
        return 'Región';
      case 'settings.locale_descr':
        return 'Establecer el formato a utilizar para fechas, números...';
      case 'settings.locale_warn':
        return 'Al cambiar la región, la aplicación se actualizará';
      case 'settings.first_day_of_week':
        return 'Primer día de la semana';
      case 'settings.theme_and_colors':
        return 'Tema y colores';
      case 'settings.theme':
        return 'Tema';
      case 'settings.theme_auto':
        return 'Definido por el sistema';
      case 'settings.theme_light':
        return 'Claro';
      case 'settings.theme_dark':
        return 'Oscuro';
      case 'settings.amoled_mode':
        return 'Modo AMOLED';
      case 'settings.amoled_mode_descr':
        return 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
      case 'settings.dynamic_colors':
        return 'Colores dinámicos';
      case 'settings.dynamic_colors_descr':
        return 'Usar el color de acento de su sistema siempre que sea posible';
      case 'settings.accent_color':
        return 'Color de acento';
      case 'settings.accent_color_descr':
        return 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
      case 'more.title':
        return 'Más';
      case 'more.title_long':
        return 'Más acciones';
      case 'more.data.display':
        return 'Datos';
      case 'more.data.display_descr':
        return 'Exporta y importa tus datos para no perder nada';
      case 'more.data.delete_all':
        return 'Eliminar mis datos';
      case 'more.data.delete_all_header1':
        return 'Alto ahí padawan ⚠️⚠️';
      case 'more.data.delete_all_message1':
        return '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
      case 'more.data.delete_all_header2':
        return 'Un último paso ⚠️⚠️';
      case 'more.data.delete_all_message2':
        return 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
      case 'more.about_us.display':
        return 'Información de la app';
      case 'more.about_us.description':
        return 'Consulta los terminos y otra información relevante sobre Monekin. Ponte en contacto con la comunidad reportando errores, dejando sugerencias...';
      case 'more.about_us.legal.display':
        return 'Información legal';
      case 'more.about_us.legal.privacy':
        return 'Política de privacidad';
      case 'more.about_us.legal.terms':
        return 'Términos de uso';
      case 'more.about_us.legal.licenses':
        return 'Licencias';
      case 'more.about_us.project.display':
        return 'Proyecto';
      case 'more.about_us.project.contributors':
        return 'Colaboradores';
      case 'more.about_us.project.contributors_descr':
        return 'Todos los desarrolladores que han hecho que Monekin crezca';
      case 'more.about_us.project.contact':
        return 'Contacta con nosotros';
      case 'more.help_us.display':
        return 'Ayúdanos';
      case 'more.help_us.description':
        return 'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor';
      case 'more.help_us.rate_us':
        return 'Califícanos';
      case 'more.help_us.rate_us_descr':
        return '¡Cualquier valoración es bienvenida!';
      case 'more.help_us.share':
        return 'Comparte Monekin';
      case 'more.help_us.share_descr':
        return 'Comparte nuestra app a amigos y familiares';
      case 'more.help_us.share_text':
        return 'Monekin! La mejor app de finanzas personales. Descargala aquí';
      case 'more.help_us.thanks':
        return '¡Gracias!';
      case 'more.help_us.thanks_long':
        return 'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.';
      case 'more.help_us.donate':
        return 'Haz una donación';
      case 'more.help_us.donate_descr':
        return 'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?';
      case 'more.help_us.donate_success':
        return 'Donación realizada. Muchas gracias por tu contribución! ❤️';
      case 'more.help_us.donate_err':
        return 'Ups! Parece que ha habido un error a la hora de recibir tu pago';
      case 'more.help_us.report':
        return 'Reporta errores, deja sugerencias...';
      default:
        return null;
    }
  }
}

extension on _TranslationsUk {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'general.cancel':
        return 'Скасувати';
      case 'general.or':
        return 'або';
      case 'general.understood':
        return 'Зрозуміло';
      case 'general.unspecified':
        return 'Не вказано';
      case 'general.confirm':
        return 'Підтвердити';
      case 'general.continue_text':
        return 'Продовжити';
      case 'general.quick_actions':
        return 'Швидкі дії';
      case 'general.save':
        return 'Зберегти';
      case 'general.save_changes':
        return 'Зберегти зміни';
      case 'general.close_and_save':
        return 'Закрити та зберегти';
      case 'general.add':
        return 'Додати';
      case 'general.edit':
        return 'Редагувати';
      case 'general.balance':
        return 'Баланс';
      case 'general.delete':
        return 'Видалити';
      case 'general.account':
        return 'Рахунок';
      case 'general.accounts':
        return 'Рахунки';
      case 'general.categories':
        return 'Категорії';
      case 'general.category':
        return 'Категорія';
      case 'general.today':
        return 'Сьогодні';
      case 'general.yesterday':
        return 'Вчора';
      case 'general.filters':
        return 'Фільтри';
      case 'general.select_all':
        return 'Вибрати всі';
      case 'general.deselect_all':
        return 'Скасувати вибір усіх';
      case 'general.empty_warn':
        return 'Ой! Тут порожньо';
      case 'general.insufficient_data':
        return 'Недостатньо даних';
      case 'general.show_more_fields':
        return 'Показати більше полів';
      case 'general.show_less_fields':
        return 'Показати менше полів';
      case 'general.clipboard.success':
        return ({required Object x}) => '${x} скопійовано в буфер обміну';
      case 'general.clipboard.error':
        return 'Помилка копіювання';
      case 'general.time.start_date':
        return 'Початкова дата';
      case 'general.time.end_date':
        return 'Кінцева дата';
      case 'general.time.from_date':
        return 'З дати';
      case 'general.time.until_date':
        return 'До дати';
      case 'general.time.date':
        return 'Дата';
      case 'general.time.datetime':
        return 'Дата та час';
      case 'general.time.time':
        return 'Час';
      case 'general.time.each':
        return 'Кожний';
      case 'general.time.after':
        return 'Після';
      case 'general.time.ranges.display':
        return 'Часовий діапазон';
      case 'general.time.ranges.it_repeat':
        return 'Повторюється';
      case 'general.time.ranges.it_ends':
        return 'Закінчується';
      case 'general.time.ranges.forever':
        return 'Назавжди';
      case 'general.time.ranges.types.cycle':
        return 'Цикли';
      case 'general.time.ranges.types.last_days':
        return 'Останні дні';
      case 'general.time.ranges.types.last_days_form':
        return ({required Object x}) => '${x} попередніх днів';
      case 'general.time.ranges.types.all':
        return 'Завжди';
      case 'general.time.ranges.types.date_range':
        return 'Власний діапазон';
      case 'general.time.ranges.each_range':
        return ({required num n, required Object range}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Кожного ${range}',
              other: 'Кожних ${n} ${range}',
            );
      case 'general.time.ranges.each_range_until_date':
        return ({required num n, required Object range, required Object day}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Кожного ${range} до ${day}',
              other: 'Кожних ${n} ${range} до ${day}',
            );
      case 'general.time.ranges.each_range_until_times':
        return (
                {required num n,
                required Object range,
                required Object limit}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Кожного ${range} ${limit} раз',
              other: 'Кожних ${n} ${range} ${limit} раз',
            );
      case 'general.time.ranges.each_range_until_once':
        return ({required num n, required Object range}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Кожного ${range} один раз',
              other: 'Кожних ${n} ${range} один раз',
            );
      case 'general.time.ranges.month':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Місяць',
              other: 'Місяці',
            );
      case 'general.time.ranges.year':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Рік',
              other: 'Роки',
            );
      case 'general.time.ranges.day':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'День',
              other: 'Дні',
            );
      case 'general.time.ranges.week':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Тиждень',
              other: 'Тижні',
            );
      case 'general.time.periodicity.display':
        return 'Повторення';
      case 'general.time.periodicity.no_repeat':
        return 'Без повторень';
      case 'general.time.periodicity.repeat':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Повторення',
              other: 'Повторень',
            );
      case 'general.time.periodicity.diary':
        return 'Щоденно';
      case 'general.time.periodicity.monthly':
        return 'Щомісяця';
      case 'general.time.periodicity.annually':
        return 'Щороку';
      case 'general.time.periodicity.quaterly':
        return 'Щокварталу';
      case 'general.time.periodicity.weekly':
        return 'Щотижня';
      case 'general.time.periodicity.custom':
        return 'Власний';
      case 'general.time.periodicity.infinite':
        return 'Завжди';
      case 'general.time.current.monthly':
        return 'Цього місяця';
      case 'general.time.current.annually':
        return 'Цього року';
      case 'general.time.current.quaterly':
        return 'Цього кварталу';
      case 'general.time.current.weekly':
        return 'На цьому тижні';
      case 'general.time.current.infinite':
        return 'Назавжди';
      case 'general.time.current.custom':
        return 'Власний діапазон';
      case 'general.time.all.diary':
        return 'Щоденно';
      case 'general.time.all.monthly':
        return 'Щомісяця';
      case 'general.time.all.annually':
        return 'Щороку';
      case 'general.time.all.quaterly':
        return 'Щокварталу';
      case 'general.time.all.weekly':
        return 'Щотижня';
      case 'general.transaction_order.display':
        return 'Сортувати транзакції';
      case 'general.transaction_order.category':
        return 'За категорією';
      case 'general.transaction_order.quantity':
        return 'За кількістю';
      case 'general.transaction_order.date':
        return 'За датою';
      case 'general.validations.required':
        return 'Обов\'язкове поле';
      case 'general.validations.positive':
        return 'Повинно бути позитивним';
      case 'general.validations.min_number':
        return ({required Object x}) => 'Повинно бути більшим, ніж ${x}';
      case 'general.validations.max_number':
        return ({required Object x}) => 'Повинно бути меншим, ніж ${x}';
      case 'intro.start':
        return 'Початок';
      case 'intro.skip':
        return 'Пропустити';
      case 'intro.next':
        return 'Далі';
      case 'intro.select_your_currency':
        return 'Виберіть вашу валюту';
      case 'intro.welcome_subtitle':
        return 'Ваш особистий фінансовий менеджер';
      case 'intro.welcome_subtitle2':
        return '100% відкритий, 100% безкоштовний';
      case 'intro.welcome_footer':
        return 'Увійшовши в систему, ви погоджуєтеся з <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Політикою конфіденційності</a> та <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Умовами використання</a> додатка';
      case 'intro.offline_descr_title':
        return 'ОФЛАЙН-РЕЖИМ:';
      case 'intro.offline_descr':
        return 'Ваші дані будуть збережені тільки на вашому пристрої, поки ви не видалите програму або не зміните телефон. Щоб запобігти втраті даних, рекомендується регулярно робити резервні копії з налаштувань програми.';
      case 'intro.offline_start':
        return 'Почати сеанс офлайн';
      case 'intro.sl1_title':
        return 'Виберіть вашу валюту';
      case 'intro.sl1_descr':
        return 'Ваша основна валюта буде використовуватися в звітах та загальних діаграмах. Ви зможете змінити валюту та мову програми пізніше в будь-який час у налаштуваннях додатка';
      case 'intro.sl2_title':
        return 'Безпечно, приватно і надійно';
      case 'intro.sl2_descr':
        return 'Ваші дані належать тільки вам. Інформація зберігається безпосередньо на вашому пристрої, без пропуску через зовнішні сервери. Це дозволяє використовувати додаток навіть без Інтернету';
      case 'intro.sl2_descr2':
        return 'Крім того, вихідний код програми є відкритим, будь-хто може вносити свої правки та переглядати, як він працює';
      case 'intro.last_slide_title':
        return 'Все готово';
      case 'intro.last_slide_descr':
        return 'З Monekin ви нарешті можете досягти фінансової незалежності, яку так багато хочете. У вас будуть графіки, бюджети, поради, статистика та багато іншого про ваші фінанси.';
      case 'intro.last_slide_descr2':
        return 'Сподіваємося, вам сподобається користуватись додатком! Не соромтеся зв\'язатися з нами у разі сумнівів або пропозицій...';
      case 'home.title':
        return 'Панель керування';
      case 'home.filter_transactions':
        return 'Фільтрувати транзакції';
      case 'home.hello_day':
        return 'Доброго ранку,';
      case 'home.hello_night':
        return 'Доброї ночі,';
      case 'home.total_balance':
        return 'Загальний баланс';
      case 'home.my_accounts':
        return 'Мої рахунки';
      case 'home.active_accounts':
        return 'Активні рахунки';
      case 'home.no_accounts':
        return 'Рахунки ще не створені';
      case 'home.no_accounts_descr':
        return 'Почніть використовувати всю магію Monekin. Створіть принаймні один рахунок, щоб почати додавати транзакції';
      case 'home.last_transactions':
        return 'Останні транзакції';
      case 'home.should_create_account_header':
        return 'Ой!';
      case 'home.should_create_account_message':
        return 'Перш ніж почати створювати транзакції, вам потрібно мати принаймні один неархівований рахунок';
      case 'financial_health.display':
        return 'Фінансове здоров\'я';
      case 'financial_health.review.very_good':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Дуже добре!';
            case GenderContext.female:
              return 'Дуже добре!';
          }
        };
      case 'financial_health.review.good':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Добре';
            case GenderContext.female:
              return 'Добре';
          }
        };
      case 'financial_health.review.normal':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Середнє';
            case GenderContext.female:
              return 'Середнє';
          }
        };
      case 'financial_health.review.bad':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Прийнятно';
            case GenderContext.female:
              return 'Прийнятно';
          }
        };
      case 'financial_health.review.very_bad':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Дуже погано';
            case GenderContext.female:
              return 'Дуже погано';
          }
        };
      case 'financial_health.review.insufficient_data':
        return ({required GenderContext context}) {
          switch (context) {
            case GenderContext.male:
              return 'Недостатньо даних';
            case GenderContext.female:
              return 'Недостатньо даних';
          }
        };
      case 'financial_health.review.descr.insufficient_data':
        return 'Схоже, у нас недостатньо витрат, щоб розрахувати ваше фінансове здоров\'я. Додайте деякі витрати/доходи за цей період, щоб дозволити нам допомогти вам!';
      case 'financial_health.review.descr.very_good':
        return 'Вітаємо! Ваше фінансове здоров\'я прекрасне. Сподіваємося, ви продовжите свою успішну хвилю і будете навчатися разом з Monekin';
      case 'financial_health.review.descr.good':
        return 'Чудово! Ваше фінансове здоров\'я гарне. Відвідайте вкладку аналізу, щоб побачити, як зберегти ще більше!';
      case 'financial_health.review.descr.normal':
        return 'Ваше фінансове здоров\'я більш-менш в середньому залишку населення за цей період';
      case 'financial_health.review.descr.bad':
        return 'Схоже, що ваша фінансова ситуація ще не найкраща. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
      case 'financial_health.review.descr.very_bad':
        return 'Хмм, ваше фінансове здоров\'я далеко не відповідає тому, що воно повинно бути. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
      case 'financial_health.months_without_income.title':
        return 'Шанси на виживання';
      case 'financial_health.months_without_income.subtitle':
        return 'З урахуванням вашого балансу, час, на який ви можете обійтися без доходу';
      case 'financial_health.months_without_income.text_zero':
        return 'Ви не могли б прожити місяць без доходу з такою швидкістю витрат!';
      case 'financial_health.months_without_income.text_one':
        return 'Ви ледве могли б прожити близько місяця без доходу з такою швидкістю витрат!';
      case 'financial_health.months_without_income.text_other':
        return ({required Object n}) =>
            'Ви могли б прожити приблизно <b>${n} місяців</b> без доходу з такою швидкістю витрат.';
      case 'financial_health.months_without_income.text_infinite':
        return 'Ви могли б прожити приблизно <b>майже все своє життя</b> без доходу з такою швидкістю витрат.';
      case 'financial_health.months_without_income.suggestion':
        return 'Пам\'ятайте, що рекомендується завжди тримати цей відсоток не менше 5 місяців. Якщо ви бачите, що у вас недостатньо збережень, зменште непотрібні витрати.';
      case 'financial_health.months_without_income.insufficient_data':
        return 'Схоже, у нас недостатньо витрат, щоб розрахувати, на скільки місяців ви можете вижити без доходу. Введіть кілька транзакцій і повертайтесь сюди, щоб перевірити ваше фінансове здоров\'я';
      case 'financial_health.savings_percentage.title':
        return 'Відсоток заощаджень';
      case 'financial_health.savings_percentage.subtitle':
        return 'Яка частина вашого доходу не витрачена за цей період';
      case 'financial_health.savings_percentage.text.good':
        return ({required Object value}) =>
            'Вітаємо! Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Схоже, ви вже професіонал, продовжуйте в тому ж дусі!';
      case 'financial_health.savings_percentage.text.normal':
        return ({required Object value}) =>
            'Вітаємо, ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду.';
      case 'financial_health.savings_percentage.text.bad':
        return ({required Object value}) =>
            'Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Проте ми вважаємо, що ви все ще можете зробити набагато більше!';
      case 'financial_health.savings_percentage.text.very_bad':
        return 'Вау, ви не змогли заощадити нічого протягом цього періоду.';
      case 'financial_health.savings_percentage.suggestion':
        return 'Пам\'ятайте, що рекомендується заощаджувати принаймні 15-20% від вашого доходу.';
      case 'stats.title':
        return 'Статистика';
      case 'stats.balance':
        return 'Баланс';
      case 'stats.final_balance':
        return 'Кінцевий баланс';
      case 'stats.balance_by_account':
        return 'Баланс за рахунками';
      case 'stats.balance_by_currency':
        return 'Баланс за валютами';
      case 'stats.cash_flow':
        return 'Грошовий потік';
      case 'stats.balance_evolution':
        return 'Еволюція балансу';
      case 'stats.compared_to_previous_period':
        return 'Порівняно з попереднім періодом';
      case 'stats.by_periods':
        return 'За періодами';
      case 'stats.by_categories':
        return 'За категоріями';
      case 'stats.by_tags':
        return 'За тегами';
      case 'stats.distribution':
        return 'Розподіл';
      case 'stats.finance_health_resume':
        return 'Підсумок фінансового здоров\'я';
      case 'stats.finance_health_breakdown':
        return 'Детальний аналіз фінансового здоров\'я';
      case 'icon_selector.name':
        return 'Назва:';
      case 'icon_selector.icon':
        return 'Іконка';
      case 'icon_selector.color':
        return 'Колір';
      case 'icon_selector.select_color':
        return 'Виберіть колір';
      case 'icon_selector.select_icon':
        return 'Виберіть іконку';
      case 'icon_selector.select_account_icon':
        return 'Ідентифікуйте ваш рахунок';
      case 'icon_selector.select_category_icon':
        return 'Ідентифікуйте вашу категорію';
      case 'icon_selector.scopes.transport':
        return 'Транспорт';
      case 'icon_selector.scopes.money':
        return 'Гроші';
      case 'icon_selector.scopes.food':
        return 'Їжа';
      case 'icon_selector.scopes.medical':
        return 'Медицина';
      case 'icon_selector.scopes.entertainment':
        return 'Розваги';
      case 'icon_selector.scopes.technology':
        return 'Технології';
      case 'icon_selector.scopes.other':
        return 'Інше';
      case 'icon_selector.scopes.logos_financial_institutions':
        return 'Фінансові установи';
      case 'transaction.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Транзакція',
              other: 'Транзакції',
            );
      case 'transaction.create':
        return 'Нова транзакція';
      case 'transaction.new_income':
        return 'Новий дохід';
      case 'transaction.new_expense':
        return 'Новий витрати';
      case 'transaction.new_success':
        return 'Транзакція успішно створена';
      case 'transaction.edit':
        return 'Редагувати транзакцію';
      case 'transaction.edit_success':
        return 'Транзакція успішно відредагована';
      case 'transaction.edit_multiple':
        return 'редагувати транзакції';
      case 'transaction.edit_multiple_success':
        return ({required Object x}) =>
            '${x} належним чином відредаговані транзакції';
      case 'transaction.duplicate':
        return 'Клонувати транзакцію';
      case 'transaction.duplicate_short':
        return 'Клон';
      case 'transaction.duplicate_warning_message':
        return 'Транзакція, ідентична цій, буде створена з такою ж датою. Бажаєте продовжити?';
      case 'transaction.duplicate_success':
        return 'Транзакція успішно склонована';
      case 'transaction.delete':
        return 'Видалити транзакцію';
      case 'transaction.delete_warning_message':
        return 'Ця дія незворотня. Поточний баланс ваших рахунків і всі ваші статистичні дані будуть перераховані';
      case 'transaction.delete_success':
        return 'Транзакцію успішно видалено';
      case 'transaction.delete_multiple':
        return 'Усунути транзакції';
      case 'transaction.delete_multiple_warning_message':
        return ({required Object x}) =>
            'Ця дія незворотна і безумовно стерть ${x} транзакції. Поточний баланс ваших рахунків та вся ваша статистика будуть перенесені';
      case 'transaction.delete_multiple_success':
        return ({required Object x}) =>
            '${x} належним чином усунути транзакції';
      case 'transaction.details':
        return 'Деталі руху коштів';
      case 'transaction.next_payments.accept':
        return 'Прийняти';
      case 'transaction.next_payments.skip':
        return 'Пропустити';
      case 'transaction.next_payments.skip_success':
        return 'Транзакцію успішно пропущено';
      case 'transaction.next_payments.skip_dialog_title':
        return 'Пропустити транзакцію';
      case 'transaction.next_payments.skip_dialog_msg':
        return ({required Object date}) =>
            'Ця дія незворотня. Ми перемістимо дату наступного переходу до ${date}';
      case 'transaction.next_payments.accept_today':
        return 'Прийняти сьогодні';
      case 'transaction.next_payments.accept_in_required_date':
        return ({required Object date}) => 'Прийняти в потрібну дату (${date})';
      case 'transaction.next_payments.accept_dialog_title':
        return 'Прийняти транзакцію';
      case 'transaction.next_payments.accept_dialog_msg_single':
        return 'Новий статус транзакції буде нульовим. Ви можете знову редагувати статус цієї транзакції в будь-який момент';
      case 'transaction.next_payments.accept_dialog_msg':
        return ({required Object date}) =>
            'Ця дія створить нову транзакцію з датою ${date}. Ви зможете переглянути деталі цієї транзакції на сторінці транзакцій';
      case 'transaction.next_payments.recurrent_rule_finished':
        return 'Правило періодичності було завершено, більше немає платежів!';
      case 'transaction.list.empty':
        return 'Тут не знайдено жодних транзакцій для відображення. Додайте транзакцію, натиснувши кнопку \'+\' внизу';
      case 'transaction.list.searcher_placeholder':
        return 'Шукати за категорією, описом...';
      case 'transaction.list.searcher_no_results':
        return 'Не знайдено транзакцій, що відповідають критеріям пошуку';
      case 'transaction.list.loading':
        return 'Завантаження додаткових транзакцій...';
      case 'transaction.list.selected_short':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: '${n} вибрано',
              other: 'вибрано ${n}',
            );
      case 'transaction.list.selected_long':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: '${n} вибрана транзакція',
              other: '${n} вибраних транзакцій',
            );
      case 'transaction.list.bulk_edit.dates':
        return 'Редагувати дати';
      case 'transaction.list.bulk_edit.categories':
        return 'Редагувати категорії';
      case 'transaction.filters.from_value':
        return 'Від суми';
      case 'transaction.filters.to_value':
        return 'До суми';
      case 'transaction.filters.from_value_def':
        return ({required Object x}) => 'Від ${x}';
      case 'transaction.filters.to_value_def':
        return ({required Object x}) => 'До ${x}';
      case 'transaction.filters.from_date_def':
        return ({required Object date}) => 'З ${date}';
      case 'transaction.filters.to_date_def':
        return ({required Object date}) => 'До ${date}';
      case 'transaction.form.validators.zero':
        return 'Значення транзакції не може бути рівним нулю';
      case 'transaction.form.validators.date_max':
        return 'Обрана дата після поточної. Транзакція буде додана як очікувана';
      case 'transaction.form.validators.date_after_account_creation':
        return 'Ви не можете створити транзакцію з датою до створення рахунку, до якого вона належить';
      case 'transaction.form.validators.negative_transaction':
        return 'Не використовуйте від\'ємні суми для вашої транзакції. Ми застосуємо знак в залежності від того, чи є обрана категорія витратою/доходом';
      case 'transaction.form.validators.negative_transfer':
        return 'Монетарна вартість переказу не може бути від\'ємною';
      case 'transaction.form.title':
        return 'Назва транзакції';
      case 'transaction.form.value':
        return 'Сума транзакції';
      case 'transaction.form.tap_to_see_more':
        return 'Натисніть, щоб побачити більше деталей';
      case 'transaction.form.description':
        return 'Опис';
      case 'transaction.form.description_info':
        return 'Додавання примітки допоможе вам швидше знайти цю транзакцію у майбутньому';
      case 'transaction.form.exchange_to_preferred_title':
        return ({required Object currency}) => 'Обмінний курс на ${currency}';
      case 'transaction.form.exchange_to_preferred_in_date':
        return 'На дату транзакції';
      case 'transaction.status.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Статус',
              other: 'Статуси',
            );
      case 'transaction.status.tr_status':
        return ({required Object status}) => '${status} транзакція';
      case 'transaction.status.none':
        return 'Без статусу';
      case 'transaction.status.reconciled':
        return 'Узгоджений';
      case 'transaction.status.reconciled_descr':
        return 'Ця транзакція вже підтверджена і відповідає реальній транзакції з вашого банку';
      case 'transaction.status.unreconciled':
        return 'Не узгоджений';
      case 'transaction.status.unreconciled_descr':
        return 'Ця транзакція ще не підтверджена і тому ще не відображається у ваших реальних банківських рахунках. Однак вона враховується при розрахунку балансів і статистики в Monekin';
      case 'transaction.status.pending':
        return 'Очікується';
      case 'transaction.status.pending_descr':
        return 'Ця транзакція очікується і тому не буде враховуватися при розрахунку балансів і статистики';
      case 'transaction.status.voided':
        return 'Скасований';
      case 'transaction.status.voided_descr':
        return 'Скасована транзакція через помилку в платежі або будь-яку іншу причину. Вона не буде враховуватися при розрахунку балансів і статистики';
      case 'transaction.types.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Тип транзакції',
              other: 'Типи транзакцій',
            );
      case 'transaction.types.income':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Дохід',
              other: 'Доходи',
            );
      case 'transaction.types.expense':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Витрата',
              other: 'Витрати',
            );
      case 'transaction.types.transfer':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Переказ',
              other: 'Перекази',
            );
      case 'transfer.display':
        return 'Переказ';
      case 'transfer.transfers':
        return 'Перекази';
      case 'transfer.transfer_to':
        return ({required Object account}) => 'Переказ на ${account}';
      case 'transfer.create':
        return 'Новий переказ';
      case 'transfer.need_two_accounts_warning_header':
        return 'Увага!';
      case 'transfer.need_two_accounts_warning_message':
        return 'Для виконання цієї дії потрібно щонайменше два рахунки. Якщо вам потрібно відредагувати поточний баланс цього рахунку, натисніть кнопку редагування';
      case 'transfer.form.from':
        return 'Початковий рахунок';
      case 'transfer.form.to':
        return 'Цільовий рахунок';
      case 'transfer.form.currency_info_add':
        return ({required Object x}) =>
            '${x} буде перекладено на цільовий рахунок';
      case 'transfer.form.currency_info_edit':
        return ({required Object x}) =>
            '${x} було перекладено на цільовий рахунок';
      case 'transfer.form.currency_exchange_selector.title':
        return 'Редагувати обмін між валютами';
      case 'transfer.form.currency_exchange_selector.value_in_destiny':
        return 'Сума, перекладена на цільовий рахунок';
      case 'recurrent_transactions.title':
        return 'Повторювані транзакції';
      case 'recurrent_transactions.title_short':
        return 'Повт. транзакції';
      case 'recurrent_transactions.empty':
        return 'Схоже, у вас немає жодних повторюваних транзакцій. Створіть щомісячну, щорічну або щотижневу повторювану транзакцію, і вона з\'явиться тут';
      case 'recurrent_transactions.total_expense_title':
        return 'Загальні витрати за період';
      case 'recurrent_transactions.total_expense_descr':
        return '* Без урахування початкової та кінцевої дати кожної повторюваної транзакції';
      case 'recurrent_transactions.details.title':
        return 'Повторювана транзакція';
      case 'recurrent_transactions.details.descr':
        return 'Наступні переміщення для цієї транзакції показані нижче. Ви можете прийняти перший рух або пропустити цей рух';
      case 'recurrent_transactions.details.last_payment_info':
        return 'Цей рух є останнім за повторюваною правилою, тому це правило буде автоматично видалено при підтвердженні цієї дії';
      case 'recurrent_transactions.details.delete_header':
        return 'Видалити повторювану транзакцію';
      case 'recurrent_transactions.details.delete_message':
        return 'Ця дія є незворотньою і не вплине на транзакції, які ви вже підтвердили/оплатили';
      case 'account.details':
        return 'Деталі рахунку';
      case 'account.date':
        return 'Дата відкриття';
      case 'account.close_date':
        return 'Дата закриття';
      case 'account.reopen':
        return 'Повторно відкрити рахунок';
      case 'account.reopen_short':
        return 'Повторно відкрити';
      case 'account.reopen_descr':
        return 'Ви впевнені, що хочете повторно відкрити цей рахунок?';
      case 'account.balance':
        return 'Баланс рахунку';
      case 'account.n_transactions':
        return 'Кількість транзакцій';
      case 'account.add_money':
        return 'Додати кошти';
      case 'account.withdraw_money':
        return 'Зняти кошти';
      case 'account.no_accounts':
        return 'Тут не знайдено жодних транзакцій для відображення. Додайте транзакцію, натиснувши кнопку \'+\' внизу';
      case 'account.types.title':
        return 'Тип рахунку';
      case 'account.types.warning':
        return 'Після вибору типу рахунку його не можна буде змінити в майбутньому';
      case 'account.types.normal':
        return 'Звичайний рахунок';
      case 'account.types.normal_descr':
        return 'Використовується для фіксації вашої повсякденної фінансової діяльності. Це найбільш поширений рахунок, який дозволяє додавати витрати, доходи...';
      case 'account.types.saving':
        return 'Зберігаючий рахунок';
      case 'account.types.saving_descr':
        return 'З нього можна тільки додавати та знімати гроші з інших рахунків. Ідеально підходить для початку збереження грошей';
      case 'account.form.name':
        return 'Назва рахунку';
      case 'account.form.name_placeholder':
        return 'Наприклад: Зберігаючий рахунок';
      case 'account.form.notes':
        return 'Примітки';
      case 'account.form.notes_placeholder':
        return 'Введіть примітки/опис про цей рахунок';
      case 'account.form.initial_balance':
        return 'Початковий баланс';
      case 'account.form.current_balance':
        return 'Поточний баланс';
      case 'account.form.create':
        return 'Створити рахунок';
      case 'account.form.edit':
        return 'Редагувати рахунок';
      case 'account.form.currency_not_found_warn':
        return 'У вас немає інформації про обмінні курси для цієї валюти. За замовчуванням буде використано 1.0 як курс обміну. Ви можете змінити це в налаштуваннях';
      case 'account.form.already_exists':
        return 'Вже існує інший з такою самою назвою, будь ласка, введіть іншу';
      case 'account.form.tr_before_opening_date':
        return 'В цьому рахунку є транзакції з датою перед датою відкриття';
      case 'account.form.iban':
        return 'IBAN';
      case 'account.form.swift':
        return 'SWIFT';
      case 'account.delete.warning_header':
        return 'Видалити рахунок?';
      case 'account.delete.warning_text':
        return 'Ця дія видалить цей рахунок і всі його транзакції';
      case 'account.delete.success':
        return 'Рахунок успішно видалено';
      case 'account.close.title':
        return 'Закрити рахунок';
      case 'account.close.title_short':
        return 'Закрити';
      case 'account.close.warn':
        return 'Цей рахунок більше не буде відображатися у певних списках, і ви не зможете створювати транзакції в ньому з датою пізніше, ніж вказана нижче. Ця дія не впливає на жодні транзакції або баланс, і ви також можете повторно відкрити цей рахунок у будь-який час. ';
      case 'account.close.should_have_zero_balance':
        return 'Баланс цього рахунку повинен бути 0, щоб його закрити. Будь ласка, відредагуйте рахунок перед продовженням';
      case 'account.close.should_have_no_transactions':
        return 'У цього рахунку є транзакції після вказаної дати закриття. Видаліть їх або відредагуйте дату закриття рахунку перед продовженням';
      case 'account.close.success':
        return 'Рахунок успішно закрито';
      case 'account.close.unarchive_succes':
        return 'Рахунок успішно повторно відкрито';
      case 'account.select.one':
        return 'Виберіть рахунок';
      case 'account.select.all':
        return 'Всі рахунки';
      case 'account.select.multiple':
        return 'Вибрати рахунки';
      case 'currencies.currency_converter':
        return 'Конвертер валют';
      case 'currencies.currency':
        return 'Валюта';
      case 'currencies.currency_manager':
        return 'Менеджер валют';
      case 'currencies.currency_manager_descr':
        return 'Налаштуйте вашу валюту та її обмінні курси з іншими';
      case 'currencies.preferred_currency':
        return 'Перевагова/базова валюта';
      case 'currencies.change_preferred_currency_title':
        return 'Змінити перевагову валюту';
      case 'currencies.change_preferred_currency_msg':
        return 'Усі статистичні дані та бюджети будуть відображатися в цій валюті відтепер. Рахунки та транзакції залишаться у тій валюті, яку вони мали. Усі збережені обмінні курси будуть видалені, якщо ви виконаєте цю дію. Ви хочете продовжити?';
      case 'currencies.form.equal_to_preferred_warn':
        return 'Валюта не може бути однаковою з валютою користувача';
      case 'currencies.form.specify_a_currency':
        return 'Будь ласка, вкажіть валюту';
      case 'currencies.form.add':
        return 'Додати обмінний курс';
      case 'currencies.form.add_success':
        return 'Обмінний курс успішно додано';
      case 'currencies.form.edit':
        return 'Редагувати обмінний курс';
      case 'currencies.form.edit_success':
        return 'Обмінний курс успішно відредаговано';
      case 'currencies.delete_all_success':
        return 'Обмінні курси успішно видалено';
      case 'currencies.historical':
        return 'Історичні курси';
      case 'currencies.exchange_rate':
        return 'Обмінний курс';
      case 'currencies.exchange_rates':
        return 'Обмінні курси';
      case 'currencies.empty':
        return 'Додайте тут обмінні курси, щоб, якщо у вас є рахунки в інших валютах, наші графіки були б точнішими';
      case 'currencies.select_a_currency':
        return 'Виберіть валюту';
      case 'currencies.search_title':
        return 'Натисніть для пошуку';
      case 'currencies.search_placeholder':
        return 'Пошук за назвою або кодом валюти';
      case 'tags.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Мітка',
              other: 'Теги',
            );
      case 'tags.form.name':
        return 'Назва тегу';
      case 'tags.form.description':
        return 'Опис';
      case 'tags.empty_list':
        return 'Ви ще не створили жодних тегів. Теги та категорії - це відмінний спосіб категоризувати ваші рухи';
      case 'tags.without_tags':
        return 'Без тегів';
      case 'tags.select':
        return 'Вибрати теги';
      case 'tags.add':
        return 'Додати тег';
      case 'tags.create':
        return 'Створити мітку';
      case 'tags.create_success':
        return 'Мітка успішно створена';
      case 'tags.already_exists':
        return 'Ця назва тегу вже існує. Ви можете відредагувати її';
      case 'tags.edit':
        return 'Редагувати тег';
      case 'tags.edit_success':
        return 'Тег успішно відредаговано';
      case 'tags.delete_success':
        return 'Тег успішно видалено';
      case 'tags.delete_warning_header':
        return 'Видалити тег?';
      case 'tags.delete_warning_message':
        return 'Ця дія не призведе до видалення транзакцій, які мають цей тег.';
      case 'categories.unknown':
        return 'Невідома категорія';
      case 'categories.create':
        return 'Створити категорію';
      case 'categories.create_success':
        return 'Категорія успішно створена';
      case 'categories.new_category':
        return 'Нова категорія';
      case 'categories.already_exists':
        return 'Така назва категорії вже існує. Можливо, ви хочете відредагувати її';
      case 'categories.edit':
        return 'Редагувати категорію';
      case 'categories.edit_success':
        return 'Категорію успішно відредаговано';
      case 'categories.name':
        return 'Назва категорії';
      case 'categories.type':
        return 'Тип категорії';
      case 'categories.both_types':
        return 'Обидва типи';
      case 'categories.subcategories':
        return 'Підкатегорії';
      case 'categories.subcategories_add':
        return 'Додати підкатегорію';
      case 'categories.make_parent':
        return 'Зробити батьківською категорією';
      case 'categories.make_child':
        return 'Зробити підкатегорією';
      case 'categories.make_child_warning1':
        return ({required Object destiny}) =>
            'Ця категорія та її підкатегорії стануть підкатегоріями <b>${destiny}</b>.';
      case 'categories.make_child_warning2':
        return ({required Object x, required Object destiny}) =>
            'Їх транзакції <b>(${x})</b> будуть перенесені до нових підкатегорій, створених всередині категорії <b>${destiny}</b>.';
      case 'categories.make_child_success':
        return 'Підкатегорії успішно створено';
      case 'categories.merge':
        return 'Об\'єднати з іншою категорією';
      case 'categories.merge_warning1':
        return (
                {required Object x,
                required Object from,
                required Object destiny}) =>
            'Всі транзакції (${x}), пов\'язані з категорією <b>${from}</b>, будуть перенесені до категорії <b>${destiny}</b>';
      case 'categories.merge_warning2':
        return ({required Object from}) =>
            'Категорія <b>${from}</b> буде безповоротно видалена.';
      case 'categories.merge_success':
        return 'Категорії успішно об\'єднані';
      case 'categories.delete_success':
        return 'Категорію видалено коректно';
      case 'categories.delete_warning_header':
        return 'Видалити категорію?';
      case 'categories.delete_warning_message':
        return ({required Object x}) =>
            'Ця дія незворотно видалить всі транзакції <b>(${x})</b>, пов\'язані з цією категорією.';
      case 'categories.select.title':
        return 'Вибрати категорії';
      case 'categories.select.select_one':
        return 'Виберіть категорію';
      case 'categories.select.select_subcategory':
        return 'Оберіть підкатегорію';
      case 'categories.select.without_subcategory':
        return 'Без підкатегорії';
      case 'categories.select.all':
        return 'Усі категорії';
      case 'categories.select.all_short':
        return 'Усі';
      case 'budgets.title':
        return 'Бюджети';
      case 'budgets.repeated':
        return 'Повторювані';
      case 'budgets.one_time':
        return 'Одноразові';
      case 'budgets.annual':
        return 'Щорічні';
      case 'budgets.week':
        return 'Щотижневі';
      case 'budgets.month':
        return 'Щомісячні';
      case 'budgets.actives':
        return 'Активні';
      case 'budgets.pending':
        return 'Очікує початку';
      case 'budgets.finish':
        return 'Завершені';
      case 'budgets.from_budgeted':
        return 'з ';
      case 'budgets.days_left':
        return 'днів залишилось';
      case 'budgets.days_to_start':
        return 'днів до початку';
      case 'budgets.since_expiration':
        return 'днів після закінчення терміну';
      case 'budgets.no_budgets':
        return 'Здається, що в цьому розділі немає жодних бюджетів для відображення. Розпочніть з створення бюджету, натиснувши кнопку нижче';
      case 'budgets.delete':
        return 'Видалити бюджет';
      case 'budgets.delete_warning':
        return 'Ця дія незворотня. Категорії та транзакції, що стосуються цитати, не будуть видалені';
      case 'budgets.form.title':
        return 'Додати бюджет';
      case 'budgets.form.name':
        return 'Назва бюджету';
      case 'budgets.form.value':
        return 'Обмежена кількість';
      case 'budgets.form.create':
        return 'Додати бюджет';
      case 'budgets.form.edit':
        return 'Редагувати бюджет';
      case 'budgets.form.negative_warn':
        return 'Бюджети не можуть мати від\'ємну суму';
      case 'budgets.details.title':
        return 'Деталі бюджету';
      case 'budgets.details.statistics':
        return 'Статистика';
      case 'budgets.details.budget_value':
        return 'Заплановано';
      case 'budgets.details.expend_diary_left':
        return ({required Object dailyAmount, required Object remainingDays}) =>
            'Ви можете витрачати ${dailyAmount} на день ще ${remainingDays} днів';
      case 'budgets.details.expend_evolution':
        return 'Еволюція витрат';
      case 'budgets.details.no_transactions':
        return 'Здається, ви не здійснили жодних витрат, пов\'язаних з цим бюджетом';
      case 'backup.export.title':
        return 'Експорт ваших даних';
      case 'backup.export.title_short':
        return 'Експорт';
      case 'backup.export.all':
        return 'Повне резервне копіювання';
      case 'backup.export.all_descr':
        return 'Експортувати всі ваші дані (рахунки, транзакції, бюджети, налаштування...). Імпортуйте їх знову у будь-який момент, щоб нічого не втратити.';
      case 'backup.export.transactions':
        return 'Резервне копіювання транзакцій';
      case 'backup.export.transactions_descr':
        return 'Експортуйте ваші транзакції у форматі CSV, щоб ви могли зручніше їх аналізувати в інших програмах або застосунках.';
      case 'backup.export.description':
        return 'Завантажте ваші дані у різних форматах';
      case 'backup.export.dialog_title':
        return 'Зберегти/Відправити файл';
      case 'backup.export.success':
        return ({required Object x}) =>
            'Файл успішно збережено/завантажено у ${x}';
      case 'backup.export.error':
        return 'Помилка при завантаженні файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
      case 'backup.import.title':
        return 'Імпорт ваших даних';
      case 'backup.import.title_short':
        return 'Імпорт';
      case 'backup.import.restore_backup':
        return 'Відновити резервну копію';
      case 'backup.import.restore_backup_descr':
        return 'Імпортуйте раніше збережену базу даних з Monekin. Ця дія замінить будь-які поточні дані програми новими даними';
      case 'backup.import.restore_backup_warn_description':
        return 'При імпорті нової бази даних ви втратите всі дані, які вже збережено в програмі. Рекомендується зробити резервну копію перед продовженням. Не завантажуйте сюди будь-який файл, походження якого ви не знаєте, завантажуйте лише файли, які ви раніше завантажили з Monekin';
      case 'backup.import.restore_backup_warn_title':
        return 'Перезаписати всі дані';
      case 'backup.import.select_other_file':
        return 'Вибрати інший файл';
      case 'backup.import.tap_to_select_file':
        return 'Торкніться, щоб вибрати файл';
      case 'backup.import.manual_import.title':
        return 'Ручний імпорт';
      case 'backup.import.manual_import.descr':
        return 'Імпортуйте транзакції з файлу .csv вручну';
      case 'backup.import.manual_import.default_account':
        return 'Типовий рахунок';
      case 'backup.import.manual_import.remove_default_account':
        return 'Видалити типовий рахунок';
      case 'backup.import.manual_import.default_category':
        return 'Типова категорія';
      case 'backup.import.manual_import.select_a_column':
        return 'Виберіть стовпець з файлу .csv';
      case 'backup.import.manual_import.steps.0':
        return 'Виберіть ваш файл';
      case 'backup.import.manual_import.steps.1':
        return 'Стовпець для суми';
      case 'backup.import.manual_import.steps.2':
        return 'Стовпець для рахунку';
      case 'backup.import.manual_import.steps.3':
        return 'Стовпець для категорії';
      case 'backup.import.manual_import.steps.4':
        return 'Стовпець для дати';
      case 'backup.import.manual_import.steps.5':
        return 'інші стовпці';
      case 'backup.import.manual_import.steps_descr.0':
        return 'Виберіть файл .csv з вашого пристрою. Переконайтеся, що в ньому є перший рядок, який описує назву кожного стовпця';
      case 'backup.import.manual_import.steps_descr.1':
        return 'Виберіть стовпець, де вказано значення кожної транзакції. Використовуйте від\'ємні значення для витрат та позитивні значення для доходів. Використовуйте крапку як десятковий роздільник';
      case 'backup.import.manual_import.steps_descr.2':
        return 'Виберіть стовпець, де вказано рахунок, до якого належить кожна транзакція. Ви також можете вибрати типовий рахунок у випадку, якщо ми не зможемо знайти рахунок, який вам потрібен. Якщо типовий рахунок не вказано, ми створимо його з такою самою назвою';
      case 'backup.import.manual_import.steps_descr.3':
        return 'Вкажіть стовпець, де знаходиться назва категорії транзакції. Ви повинні вказати типову категорію, щоб ми призначили цю категорію транзакціям, у випадку, якщо категорія не може бути знайдена';
      case 'backup.import.manual_import.steps_descr.4':
        return 'Виберіть стовпець, де вказано дату кожної транзакції. Якщо не вказано, транзакції будуть створені з поточною датою';
      case 'backup.import.manual_import.steps_descr.5':
        return 'Вкажіть стовпці для інших необов\'язкових атрибутів транзакцій';
      case 'backup.import.manual_import.success':
        return ({required Object x}) => 'Успішно імпортовано ${x} транзакцій';
      case 'backup.import.success':
        return 'Імпорт виконано успішно';
      case 'backup.import.cancelled':
        return 'Імпорт скасовано користувачем';
      case 'backup.import.error':
        return 'Помилка імпорту файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
      case 'backup.about.title':
        return 'Інформація про вашу базу даних';
      case 'backup.about.create_date':
        return 'Дата створення';
      case 'backup.about.modify_date':
        return 'Останнє змінено';
      case 'backup.about.last_backup':
        return 'Остання резервна копія';
      case 'backup.about.size':
        return 'Розмір';
      case 'settings.title_long':
        return 'Налаштування та вигляд';
      case 'settings.title_short':
        return 'Налаштування';
      case 'settings.description':
        return 'Тема додатку, тексти та інші загальні налаштування';
      case 'settings.edit_profile':
        return 'Редагувати профіль';
      case 'settings.lang_section':
        return 'Мова та тексти';
      case 'settings.lang_title':
        return 'Мова додатку';
      case 'settings.lang_descr':
        return 'Мова, в якій будуть відображатися тексти в додатку';
      case 'settings.locale':
        return 'Регіон';
      case 'settings.locale_descr':
        return 'Встановіть формат, який буде використовуватися для дат, чисел...';
      case 'settings.locale_warn':
        return 'Після зміни регіону додаток оновиться';
      case 'settings.first_day_of_week':
        return 'Перший день тижня';
      case 'settings.theme_and_colors':
        return 'Тема та кольори';
      case 'settings.theme':
        return 'Тема';
      case 'settings.theme_auto':
        return 'Визначено системою';
      case 'settings.theme_light':
        return 'Світла';
      case 'settings.theme_dark':
        return 'Темна';
      case 'settings.amoled_mode':
        return 'Режим AMOLED';
      case 'settings.amoled_mode_descr':
        return 'Використовуйте чисто чорний шпалери, якщо це можливо. Це трохи допоможе акумулятору пристроїв з екранами AMOLED';
      case 'settings.dynamic_colors':
        return 'Динамічні кольори';
      case 'settings.dynamic_colors_descr':
        return 'Використовуйте колір акценту вашої системи, коли це можливо';
      case 'settings.accent_color':
        return 'Колір акценту';
      case 'settings.accent_color_descr':
        return 'Виберіть колір, який додаток буде використовувати для виділення певних частин інтерфейсу';
      case 'more.title':
        return 'Більше';
      case 'more.title_long':
        return 'Більше дій';
      case 'more.data.display':
        return 'Дані';
      case 'more.data.display_descr':
        return 'Експортуйте та імпортуйте свої дані, щоб нічого не втратити';
      case 'more.data.delete_all':
        return 'Видалити мої дані';
      case 'more.data.delete_all_header1':
        return 'Зупиніться, молодий падаване ⚠️⚠️';
      case 'more.data.delete_all_message1':
        return 'Ви впевнені, що хочете продовжити? Всі ваші дані буде остаточно видалено і не може бути відновлено';
      case 'more.data.delete_all_header2':
        return 'Останній крок ⚠️⚠️';
      case 'more.data.delete_all_message2':
        return 'Видаляючи обліковий запис, ви видалите всі ваші збережені особисті дані. Ваші облікові записи, транзакції, бюджети та категорії будуть видалені і не можуть бути відновлені. Ви згодні?';
      case 'more.about_us.display':
        return 'Інформація про додаток';
      case 'more.about_us.description':
        return 'Перегляньте умови та іншу важливу інформацію про Monekin. Зв\'яжіться зі спільнотою, повідомте про помилки, залиште пропозиції ...';
      case 'more.about_us.legal.display':
        return 'Юридична інформація';
      case 'more.about_us.legal.privacy':
        return 'Політика конфіденційності';
      case 'more.about_us.legal.terms':
        return 'Умови використання';
      case 'more.about_us.legal.licenses':
        return 'Ліцензії';
      case 'more.about_us.project.display':
        return 'Проект';
      case 'more.about_us.project.contributors':
        return 'Співробітники';
      case 'more.about_us.project.contributors_descr':
        return 'Усі розробники, які зробили Monekin краще';
      case 'more.about_us.project.contact':
        return 'Зв\'яжіться з нами';
      case 'more.help_us.display':
        return 'Допоможіть нам';
      case 'more.help_us.description':
        return 'Дізнайтеся, як ви можете допомогти Monekin ставати кращим і кращим';
      case 'more.help_us.rate_us':
        return 'Оцініть нас';
      case 'more.help_us.rate_us_descr':
        return 'Будь-яка оцінка вітається!';
      case 'more.help_us.share':
        return 'Поділіться Monekin';
      case 'more.help_us.share_descr':
        return 'Поділіться нашим додатком з друзями та родиною';
      case 'more.help_us.share_text':
        return 'Monekin! Найкращий додаток для особистих фінансів. Завантажте його тут';
      case 'more.help_us.thanks':
        return 'Дякуємо!';
      case 'more.help_us.thanks_long':
        return 'Ваші внески в Monekin та інші відкриті проекти, великі та малі, роблять великі проекти, подібні до цього, можливими. Дякуємо вам за час, витрачений на внесок.';
      case 'more.help_us.donate':
        return 'Зробіть пожертву';
      case 'more.help_us.donate_descr':
        return 'З вашою пожертвою ви допоможете додатку продовжувати отримувати вдосконалення. Що може бути краще, ніж подякувати за виконану роботу, запрошуючи мене на каву?';
      case 'more.help_us.donate_success':
        return 'Пожертва зроблена. Дуже вдячний за ваш внесок! ❤️';
      case 'more.help_us.donate_err':
        return 'Ой! Здається, виникла помилка при отриманні вашого платежу';
      case 'more.help_us.report':
        return 'Повідомити про помилки, залишити пропозиції...';
      default:
        return null;
    }
  }
}

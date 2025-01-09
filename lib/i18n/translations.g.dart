/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 6
/// Strings: 3313 (552 per locale)
///
/// Built on 2025-01-09 at 14:29 UTC

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
	de(languageCode: 'de', build: _TranslationsDe.build),
	es(languageCode: 'es', build: _TranslationsEs.build),
	hu(languageCode: 'hu', build: _TranslationsHu.build),
	uk(languageCode: 'uk', build: _TranslationsUk.build),
	zhTw(languageCode: 'zh', countryCode: 'TW', build: _TranslationsZhTw.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
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
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
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
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
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
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsGeneralEn general = _TranslationsGeneralEn._(_root);
	late final _TranslationsIntroEn intro = _TranslationsIntroEn._(_root);
	late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
	late final _TranslationsFinancialHealthEn financial_health = _TranslationsFinancialHealthEn._(_root);
	late final _TranslationsStatsEn stats = _TranslationsStatsEn._(_root);
	late final _TranslationsIconSelectorEn icon_selector = _TranslationsIconSelectorEn._(_root);
	late final _TranslationsTransactionEn transaction = _TranslationsTransactionEn._(_root);
	late final _TranslationsTransferEn transfer = _TranslationsTransferEn._(_root);
	late final _TranslationsRecurrentTransactionsEn recurrent_transactions = _TranslationsRecurrentTransactionsEn._(_root);
	late final _TranslationsAccountEn account = _TranslationsAccountEn._(_root);
	late final _TranslationsCurrenciesEn currencies = _TranslationsCurrenciesEn._(_root);
	late final _TranslationsTagsEn tags = _TranslationsTagsEn._(_root);
	late final _TranslationsCategoriesEn categories = _TranslationsCategoriesEn._(_root);
	late final _TranslationsBudgetsEn budgets = _TranslationsBudgetsEn._(_root);
	late final _TranslationsBackupEn backup = _TranslationsBackupEn._(_root);
	late final _TranslationsSettingsEn settings = _TranslationsSettingsEn._(_root);
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
	String get see_more => 'See more';
	String get select_all => 'Select all';
	String get deselect_all => 'Deselect all';
	String get empty_warn => 'Ops! This is very empty';
	String get insufficient_data => 'Insufficient data';
	String get show_more_fields => 'Show more fields';
	String get show_less_fields => 'Show less fields';
	String get tap_to_search => 'Tap to search';
	late final _TranslationsGeneralClipboardEn clipboard = _TranslationsGeneralClipboardEn._(_root);
	late final _TranslationsGeneralTimeEn time = _TranslationsGeneralTimeEn._(_root);
	late final _TranslationsGeneralTransactionOrderEn transaction_order = _TranslationsGeneralTransactionOrderEn._(_root);
	late final _TranslationsGeneralValidationsEn validations = _TranslationsGeneralValidationsEn._(_root);
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
	String get welcome_footer => 'By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application';
	String get offline_descr_title => 'OFFLINE ACCOUNT:';
	String get offline_descr => 'Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';
	String get offline_start => 'Start session offline';
	String get sl1_title => 'Select your currency';
	String get sl1_descr => 'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings';
	String get sl2_title => 'Safe, private and reliable';
	String get sl2_descr => 'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet';
	String get sl2_descr2 => 'Also, the source code of the application is public, anyone can collaborate on it and see how it works';
	String get last_slide_title => 'All ready';
	String get last_slide_descr => 'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.';
	String get last_slide_descr2 => 'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...';
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
	String get no_accounts_descr => 'Start using all the magic of Monekin. Create at least one account to start adding transactions';
	String get last_transactions => 'Last transactions';
	String get should_create_account_header => 'Oops!';
	String get should_create_account_message => 'You must have at least one no-archived account before you can start creating transactions';
}

// Path: financial_health
class _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'Financial health';
	late final _TranslationsFinancialHealthReviewEn review = _TranslationsFinancialHealthReviewEn._(_root);
	late final _TranslationsFinancialHealthMonthsWithoutIncomeEn months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeEn._(_root);
	late final _TranslationsFinancialHealthSavingsPercentageEn savings_percentage = _TranslationsFinancialHealthSavingsPercentageEn._(_root);
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
	String get balance_by_account_subtitle => 'Where do I have most of my money?';
	String get balance_by_currency => 'Balance by currency';
	String get balance_by_currency_subtitle => 'How much money do I have in foreign currency?';
	String get balance_evolution => 'Balance trend';
	String get balance_evolution_subtitle => 'Do I have more money than before?';
	String get compared_to_previous_period => 'Compared to the previous period';
	String get cash_flow => 'Cash flow';
	String get cash_flow_subtitle => 'Am I spending less than I earn?';
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
	String get custom_color => 'Custom color';
	String get current_color_selection => 'Current selection';
	String get select_account_icon => 'Identify your account';
	String get select_category_icon => 'Identify your category';
	late final _TranslationsIconSelectorScopesEn scopes = _TranslationsIconSelectorScopesEn._(_root);
}

// Path: transaction
class _TranslationsTransactionEn {
	_TranslationsTransactionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
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
	String edit_multiple_success({required Object x}) => '${x} transactions edited successfully';
	String get duplicate => 'Clone transaction';
	String get duplicate_short => 'Clone';
	String get duplicate_warning_message => 'A transaction identical to this will be created with the same date, do you want to continue?';
	String get duplicate_success => 'Transaction cloned successfully';
	String get delete => 'Delete transaction';
	String get delete_warning_message => 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';
	String get delete_success => 'Transaction deleted correctly';
	String get delete_multiple => 'Delete transactions';
	String delete_multiple_warning_message({required Object x}) => 'This action is irreversible and will remove ${x} transactions. The current balance of your accounts and all your statistics will be recalculated';
	String delete_multiple_success({required Object x}) => '${x} transactions deleted correctly';
	String get details => 'Movement details';
	late final _TranslationsTransactionNextPaymentsEn next_payments = _TranslationsTransactionNextPaymentsEn._(_root);
	late final _TranslationsTransactionListEn list = _TranslationsTransactionListEn._(_root);
	late final _TranslationsTransactionFiltersEn filters = _TranslationsTransactionFiltersEn._(_root);
	late final _TranslationsTransactionFormEn form = _TranslationsTransactionFormEn._(_root);
	late final _TranslationsTransactionReversedEn reversed = _TranslationsTransactionReversedEn._(_root);
	late final _TranslationsTransactionStatusEn status = _TranslationsTransactionStatusEn._(_root);
	late final _TranslationsTransactionTypesEn types = _TranslationsTransactionTypesEn._(_root);
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
	String get need_two_accounts_warning_message => 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
	late final _TranslationsTransferFormEn form = _TranslationsTransferFormEn._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Recurrent transactions';
	String get title_short => 'Rec. transactions';
	String get empty => 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
	String get total_expense_title => 'Total expense per period';
	String get total_expense_descr => '* Without considering the start and end date of each recurrence';
	late final _TranslationsRecurrentTransactionsDetailsEn details = _TranslationsRecurrentTransactionsDetailsEn._(_root);
	late final _TranslationsRecurrentTransactionsStatusEn status = _TranslationsRecurrentTransactionsStatusEn._(_root);
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
	String get no_accounts => 'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
	late final _TranslationsAccountTypesEn types = _TranslationsAccountTypesEn._(_root);
	late final _TranslationsAccountFormEn form = _TranslationsAccountFormEn._(_root);
	late final _TranslationsAccountDeleteEn delete = _TranslationsAccountDeleteEn._(_root);
	late final _TranslationsAccountCloseEn close = _TranslationsAccountCloseEn._(_root);
	late final _TranslationsAccountSelectEn select = _TranslationsAccountSelectEn._(_root);
}

// Path: currencies
class _TranslationsCurrenciesEn {
	_TranslationsCurrenciesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get currency_converter => 'Currency converter';
	String get currency => 'Currency';
	String get currency_manager => 'Currency manager';
	String get currency_manager_descr => 'Configure your currency and its exchange rates with others';
	String get preferred_currency => 'Preferred/base currency';
	String get change_preferred_currency_title => 'Change preferred currency';
	String get change_preferred_currency_msg => 'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?';
	late final _TranslationsCurrenciesFormEn form = _TranslationsCurrenciesFormEn._(_root);
	String get delete_all_success => 'Deleted exchange rates successfully';
	String get historical => 'Historical rates';
	String get exchange_rate => 'Exchange rate';
	String get exchange_rates => 'Exchange rates';
	String get empty => 'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate';
	String get select_a_currency => 'Select a currency';
	String get search => 'Search by name or by currency code';
}

// Path: tags
class _TranslationsTagsEn {
	_TranslationsTagsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Label',
		other: 'Tags',
	);
	late final _TranslationsTagsFormEn form = _TranslationsTagsFormEn._(_root);
	late final _TranslationsTagsSelectEn select = _TranslationsTagsSelectEn._(_root);
	String get empty_list => 'You haven\'t created any tags yet. Tags and categories are a great way to categorize your movements';
	String get without_tags => 'Without tags';
	String get add => 'Add tag';
	String get create => 'Create label';
	String get create_success => 'Label created successfully';
	String get already_exists => 'This tag name already exists. You may want to edit it';
	String get edit => 'Edit tag';
	String get edit_success => 'Tag edited successfully';
	String get delete_success => 'Category deleted successfully';
	String get delete_warning_header => 'Delete tag?';
	String get delete_warning_message => 'This action will not delete transactions that have this tag.';
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
	String get already_exists => 'The name of this category already exists. Maybe you want to edit it';
	String get edit => 'Edit category';
	String get edit_success => 'Category edited correctly';
	String get name => 'Category name';
	String get type => 'Category type';
	String get both_types => 'Both types';
	String get subcategories => 'Subcategories';
	String get subcategories_add => 'Add subcategory';
	String get make_parent => 'Make to category';
	String get make_child => 'Make a subcategory';
	String make_child_warning1({required Object destiny}) => 'This category and its subcategories will become subcategories of <b>${destiny}</b>.';
	String make_child_warning2({required Object x, required Object destiny}) => 'Their transactions <b>(${x})</b> will be moved to the new subcategories created within the <b>${destiny}</b> category.';
	String get make_child_success => 'Subcategories created successfully';
	String get merge => 'Merge with another category';
	String merge_warning1({required Object x, required Object from, required Object destiny}) => 'All transactions (${x}) associated with the category <b>${from}</b> will be moved to the category <b>${destiny}</b>';
	String merge_warning2({required Object from}) => 'The category <b>${from}</b> will be irreversibly deleted.';
	String get merge_success => 'Category merged successfully';
	String get delete_success => 'Category deleted correctly';
	String get delete_warning_header => 'Delete category?';
	String delete_warning_message({required Object x}) => 'This action will irreversibly delete all transactions <b>(${x})</b> related to this category.';
	late final _TranslationsCategoriesSelectEn select = _TranslationsCategoriesSelectEn._(_root);
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
	String get no_budgets => 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';
	String get delete => 'Delete budget';
	String get delete_warning => 'This action is irreversible. Categories and transactions referring to this quote will not be deleted';
	late final _TranslationsBudgetsFormEn form = _TranslationsBudgetsFormEn._(_root);
	late final _TranslationsBudgetsDetailsEn details = _TranslationsBudgetsDetailsEn._(_root);
}

// Path: backup
class _TranslationsBackupEn {
	_TranslationsBackupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsBackupExportEn export = _TranslationsBackupExportEn._(_root);
	late final _TranslationsBackupImportEn import = _TranslationsBackupImportEn._(_root);
	late final _TranslationsBackupAboutEn about = _TranslationsBackupAboutEn._(_root);
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
	String get lang_descr => 'Language in which the texts will be displayed in the app';
	String get lang_help => 'If you want to collaborate with the translations of this app, you can consult <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>our guide</a>';
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
	String get amoled_mode_descr => 'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens';
	String get dynamic_colors => 'Dynamic colors';
	String get dynamic_colors_descr => 'Use your system accent color whenever possible';
	String get accent_color => 'Accent color';
	String get accent_color_descr => 'Choose the color the app will use to emphasize certain parts of the interface';
	late final _TranslationsSettingsSecurityEn security = _TranslationsSettingsSecurityEn._(_root);
}

// Path: more
class _TranslationsMoreEn {
	_TranslationsMoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'More';
	String get title_long => 'More actions';
	late final _TranslationsMoreDataEn data = _TranslationsMoreDataEn._(_root);
	late final _TranslationsMoreAboutUsEn about_us = _TranslationsMoreAboutUsEn._(_root);
	late final _TranslationsMoreHelpUsEn help_us = _TranslationsMoreHelpUsEn._(_root);
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
	late final _TranslationsGeneralTimeRangesEn ranges = _TranslationsGeneralTimeRangesEn._(_root);
	late final _TranslationsGeneralTimePeriodicityEn periodicity = _TranslationsGeneralTimePeriodicityEn._(_root);
	late final _TranslationsGeneralTimeCurrentEn current = _TranslationsGeneralTimeCurrentEn._(_root);
	late final _TranslationsGeneralTimeAllEn all = _TranslationsGeneralTimeAllEn._(_root);
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
	String get form_error => 'Fix the indicated fields to continue';
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
	late final _TranslationsFinancialHealthReviewDescrEn descr = _TranslationsFinancialHealthReviewDescrEn._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Survival rate';
	String get subtitle => 'Given your balance, amount of time you could go without income';
	String get text_zero => 'You couldn\'t survive a month without income at this rate of expenses!';
	String get text_one => 'You could barely survive approximately a month without income at this rate of expenses!';
	String text_other({required Object n}) => 'You could survive approximately <b>${n} months</b> without income at this rate of spending.';
	String get text_infinite => 'You could survive approximately <b>all your life</b> without income at this rate of spending.';
	String get suggestion => 'Remember that it is advisable to always keep this ratio above 5 months at least. If you see that you do not have a sufficient savings cushion, reduce unnecessary expenses.';
	String get insufficient_data => 'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Savings percentage';
	String get subtitle => 'What part of your income is not spent in this period';
	late final _TranslationsFinancialHealthSavingsPercentageTextEn text = _TranslationsFinancialHealthSavingsPercentageTextEn._(_root);
	String get suggestion => 'Remember that it is advisable to save at least 15-20% of what you earn.';
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
	String skip_dialog_msg({required Object date}) => 'This action is irreversible. We will move the date of the next move to ${date}';
	String get accept_today => 'Accept today';
	String accept_in_required_date({required Object date}) => 'Accept in required date (${date})';
	String get accept_dialog_title => 'Accept transaction';
	String get accept_dialog_msg_single => 'The new status of the transaction will be null. You can re-edit the status of this transaction whenever you want';
	String accept_dialog_msg({required Object date}) => 'This action will create a new transaction with date ${date}. You will be able to check the details of this transaction on the transaction page';
	String get recurrent_rule_finished => 'The recurring rule has been completed, there are no more payments to make!';
}

// Path: transaction.list
class _TranslationsTransactionListEn {
	_TranslationsTransactionListEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty => 'No transactions found to display here. Add a few transactions in the app and maybe you\'ll have better luck next time.';
	String get searcher_placeholder => 'Search by category, description...';
	String get searcher_no_results => 'No transactions found matching the search criteria';
	String get loading => 'Loading more transactions...';
	String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} selected',
		other: '${n} selected',
	);
	String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} transaction selected',
		other: '${n} transactions selected',
	);
	late final _TranslationsTransactionListBulkEditEn bulk_edit = _TranslationsTransactionListBulkEditEn._(_root);
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
	late final _TranslationsTransactionFormValidatorsEn validators = _TranslationsTransactionFormValidatorsEn._(_root);
	String get title => 'Transaction title';
	String get title_short => 'Title';
	String get value => 'Value of the transaction';
	String get tap_to_see_more => 'Tap to see more details';
	String get no_tags => '-- No tags --';
	String get description => 'Description';
	String get description_info => 'Tap here to enter a more detailed description about this transaction';
	String exchange_to_preferred_title({required Object currency}) => 'Exchnage rate to ${currency}';
	String get exchange_to_preferred_in_date => 'On transaction date';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Inverse transaction';
	String get title_short => 'Inverse tr.';
	String get description_for_expenses => 'Despite being an expense transaction, it has a positive amount. These types of transactions can be used to represent the return of a previously recorded expense, such as a refund or having the payment of a debt.';
	String get description_for_incomes => 'Despite being an income transaction, it has a negative amount. These types of transactions can be used to void or correct an income that was incorrectly recorded, to reflect a return or refund of money or to record payment of debts.';
}

// Path: transaction.status
class _TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Status',
		other: 'Statuses',
	);
	String get display_long => 'Transaction status';
	String tr_status({required Object status}) => '${status} transaction';
	String get none => 'Stateless';
	String get none_descr => 'Transaction without a specific state';
	String get reconciled => 'Reconciled';
	String get reconciled_descr => 'This transaction has already been validated and corresponds to a real transaction from your bank';
	String get unreconciled => 'Unreconciled';
	String get unreconciled_descr => 'This transaction has not yet been validated and therefore does not yet appear in your real bank accounts. However, it counts for the calculation of balances and statistics in Monekin';
	String get pending => 'Pending';
	String get pending_descr => 'This transaction is pending and therefore it will not be taken into account when calculating balances and statistics';
	String get voided => 'Voided';
	String get voided_descr => 'Void/cancelled transaction due to payment error or any other reason. It will not be taken into account when calculating balances and statistics';
}

// Path: transaction.types
class _TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Transaction type',
		other: 'Transaction types',
	);
	String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Income',
		other: 'Incomes',
	);
	String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Expense',
		other: 'Expenses',
	);
	String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
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
	late final _TranslationsTransferFormValueInDestinyEn value_in_destiny = _TranslationsTransferFormValueInDestinyEn._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Recurrent transaction';
	String get descr => 'The next moves for this transaction are shown below. You can accept the first move or skip this move';
	String get last_payment_info => 'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action';
	String get delete_header => 'Delete recurring transaction';
	String get delete_message => 'This action is irreversible and will not affect transactions you have already confirmed/paid for';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String delayed_by({required Object x}) => 'Delayed by ${x}d';
	String coming_in({required Object x}) => 'In ${x} days';
}

// Path: account.types
class _TranslationsAccountTypesEn {
	_TranslationsAccountTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Account type';
	String get warning => 'Once the type of account has been chosen, it cannot be changed in the future';
	String get normal => 'Normal account';
	String get normal_descr => 'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...';
	String get saving => 'Savings account';
	String get saving_descr => 'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money';
}

// Path: account.form
class _TranslationsAccountFormEn {
	_TranslationsAccountFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Account name';
	String get name_placeholder => 'Ex: Savings account';
	String get notes => 'Notes';
	String get notes_placeholder => 'Type some notes/description about this account';
	String get initial_balance => 'Initial balance';
	String get current_balance => 'Current balance';
	String get create => 'Create account';
	String get edit => 'Edit account';
	String get currency_not_found_warn => 'You do not have information on exchange rates for this currency. 1.0 will be used as the default exchange rate. You can modify this in the settings';
	String get already_exists => 'There is already another one with the same name, please write another';
	String get tr_before_opening_date => 'There are transactions in this account with a date before the opening date';
	String get iban => 'IBAN';
	String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get warning_header => 'Delete account?';
	String get warning_text => 'This action will delete this account and all its transactions';
	String get success => 'Account deleted successfully';
}

// Path: account.close
class _TranslationsAccountCloseEn {
	_TranslationsAccountCloseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Close account';
	String get title_short => 'Close';
	String get warn => 'This account will no longer appear in certain listings and you will not be able to create transactions in it with a date later than the one specified below. This action does not affect any transactions or balance, and you can also reopen this account at any time. ';
	String get should_have_zero_balance => 'You must have a current balance of 0 in this account to close it. Please edit the account before continuing';
	String get should_have_no_transactions => 'This account has transactions after the specified close date. Delete them or edit the account close date before continuing';
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
	String get equal_to_preferred_warn => 'The currency cannot be equal to the user currency';
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

// Path: tags.select
class _TranslationsTagsSelectEn {
	_TranslationsTagsSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Select tags';
	String get all => 'All the tags';
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
	String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'You can spend ${dailyAmount}/day for ${remainingDays} remaining days';
	String get expend_evolution => 'Expenditure evolution';
	String get no_transactions => 'It seems that you have not made any expenses related to this budget';
}

// Path: backup.export
class _TranslationsBackupExportEn {
	_TranslationsBackupExportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Export your data';
	String get title_short => 'Export';
	String get all => 'Full backup';
	String get all_descr => 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';
	String get transactions => 'Transactions backup';
	String get transactions_descr => 'Export your transactions in CSV so you can more easily analyze them in other programs or applications.';
	String get description => 'Download your data in different formats';
	String get dialog_title => 'Save/Send file';
	String success({required Object x}) => 'File saved/downloaded successfully in ${x}';
	String get error => 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportEn {
	_TranslationsBackupImportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Import your data';
	String get title_short => 'Import';
	String get restore_backup => 'Restore Backup';
	String get restore_backup_descr => 'Import a previously saved database from Monekin. This action will replace any current application data with the new data';
	String get restore_backup_warn_description => 'When importing a new database, you will lose all data currently saved in the app. It is recommended to make a backup before continuing. Do not upload here any file whose origin you do not know, upload only files that you have previously downloaded from Monekin';
	String get restore_backup_warn_title => 'Overwrite all data';
	String get select_other_file => 'Select other file';
	String get tap_to_select_file => 'Tap to select a file';
	late final _TranslationsBackupImportManualImportEn manual_import = _TranslationsBackupImportManualImportEn._(_root);
	String get success => 'Import performed successfully';
	String get cancelled => 'Import was cancelled by the user';
	String get error => 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
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

// Path: settings.security
class _TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Seguridad';
	String get private_mode_at_launch => 'Private mode at launch';
	String get private_mode_at_launch_descr => 'Launch the app in private mode by default';
	String get private_mode => 'Private mode';
	String get private_mode_descr => 'Hide all monetary values';
	String get private_mode_activated => 'Private mode activated';
	String get private_mode_deactivated => 'Private mode disabled';
}

// Path: more.data
class _TranslationsMoreDataEn {
	_TranslationsMoreDataEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'Data';
	String get display_descr => 'Export and import your data so you don\'t lose anything';
	String get delete_all => 'Delete my data';
	String get delete_all_header1 => 'Stop right there padawan ⚠️⚠️';
	String get delete_all_message1 => 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';
	String get delete_all_header2 => 'One last step ⚠️⚠️';
	String get delete_all_message2 => 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'App information';
	String get description => 'Check out the terms and other relevant information about Monekin. Get in touch with the community by reporting bugs, leaving suggestions...';
	late final _TranslationsMoreAboutUsLegalEn legal = _TranslationsMoreAboutUsLegalEn._(_root);
	late final _TranslationsMoreAboutUsProjectEn project = _TranslationsMoreAboutUsProjectEn._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'Help us';
	String get description => 'Find out how you can help Monekin become better and better';
	String get rate_us => 'Rate us';
	String get rate_us_descr => 'Any rate is welcome!';
	String get share => 'Share Monekin';
	String get share_descr => 'Share our app to friends and family';
	String get share_text => 'Monekin! The best personal finance app. Download it here';
	String get thanks => 'Thank you!';
	String get thanks_long => 'Your contributions to Monekin and other open source projects, big and small, make great projects like this possible. Thank you for taking the time to contribute.';
	String get donate => 'Make a donation';
	String get donate_descr => 'With your donation you will help the app continue receiving improvements. What better way than to thank the work done by inviting me to a coffee?';
	String get donate_success => 'Donation made. Thank you very much for your contribution! ❤️';
	String get donate_err => 'Oops! It seems there was an error receiving your payment';
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
	late final _TranslationsGeneralTimeRangesTypesEn types = _TranslationsGeneralTimeRangesTypesEn._(_root);
	String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range}',
		other: 'Every ${n} ${range}',
	);
	String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range} until ${day}',
		other: 'Every ${n} ${range} until ${day}',
	);
	String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range} ${limit} times',
		other: 'Every ${n} ${range} ${limit} times',
	);
	String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range} once',
		other: 'Every ${n} ${range} once',
	);
	String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Month',
		other: 'Months',
	);
	String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Year',
		other: 'Years',
	);
	String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Day',
		other: 'Days',
	);
	String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
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
	String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
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
	String get insufficient_data => 'It looks like we don\'t have enough expenses to calculate your financial health. Add some expenses/incomes in this period to allow us to help you!';
	String get very_good => 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';
	String get good => 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';
	String get normal => 'Your financial health is more or less in the average of the rest of the population for this period';
	String get bad => 'It seems that your financial situation is not the best yet. Explore the rest of the charts to learn more about your finances';
	String get very_bad => 'Hmm, your financial health is far below what it should be. Explore the rest of the charts to learn more about your finances';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String good({required Object value}) => 'Congratulations! You have managed to save <b>${value}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!';
	String normal({required Object value}) => 'Congratulations, you have managed to save <b>${value}%</b> of your income during this period.';
	String bad({required Object value}) => 'You have managed to save <b>${value}%</b> of your income during this period. However, we think you can still do much more!';
	String get very_bad => 'Wow, you haven\'t managed to save anything during this period.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get dates => 'Edit dates';
	String get categories => 'Edit categories';
	String get status => 'Edit statuses';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get zero => 'The value of a transaction cannot be equal to zero';
	String get date_max => 'The selected date is after the current one. The transaction will be added as pending';
	String get date_after_account_creation => 'You cannot create a transaction whose date is before the creation date of the account it belongs to';
	String get negative_transfer => 'The monetary value of a transfer cannot be negative';
	String get transfer_between_same_accounts => 'The origin and the destination account cannot be the same';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Amount transferred at destination';
	String amount_short({required Object amount}) => '${amount} to target account';
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
	String success({required Object x}) => 'Successfully imported ${x} transactions';
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
	String get contributors_descr => 'All the developers who have made Monekin grow';
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
class _TranslationsDe implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsDe.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsDe _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsGeneralDe general = _TranslationsGeneralDe._(_root);
	@override late final _TranslationsIntroDe intro = _TranslationsIntroDe._(_root);
	@override late final _TranslationsHomeDe home = _TranslationsHomeDe._(_root);
	@override late final _TranslationsFinancialHealthDe financial_health = _TranslationsFinancialHealthDe._(_root);
	@override late final _TranslationsStatsDe stats = _TranslationsStatsDe._(_root);
	@override late final _TranslationsIconSelectorDe icon_selector = _TranslationsIconSelectorDe._(_root);
	@override late final _TranslationsTransactionDe transaction = _TranslationsTransactionDe._(_root);
	@override late final _TranslationsTransferDe transfer = _TranslationsTransferDe._(_root);
	@override late final _TranslationsRecurrentTransactionsDe recurrent_transactions = _TranslationsRecurrentTransactionsDe._(_root);
	@override late final _TranslationsAccountDe account = _TranslationsAccountDe._(_root);
	@override late final _TranslationsCurrenciesDe currencies = _TranslationsCurrenciesDe._(_root);
	@override late final _TranslationsTagsDe tags = _TranslationsTagsDe._(_root);
	@override late final _TranslationsCategoriesDe categories = _TranslationsCategoriesDe._(_root);
	@override late final _TranslationsBudgetsDe budgets = _TranslationsBudgetsDe._(_root);
	@override late final _TranslationsBackupDe backup = _TranslationsBackupDe._(_root);
	@override late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
	@override late final _TranslationsMoreDe more = _TranslationsMoreDe._(_root);
}

// Path: general
class _TranslationsGeneralDe implements _TranslationsGeneralEn {
	_TranslationsGeneralDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Abbruch';
	@override String get or => 'oder';
	@override String get understood => 'Verstanden';
	@override String get unspecified => 'Nicht spezifiziert';
	@override String get confirm => 'Bestätigen';
	@override String get continue_text => 'Weiter';
	@override String get quick_actions => 'Schnelle Aktionen';
	@override String get save => 'Speichern';
	@override String get save_changes => 'Änderungen speichern';
	@override String get close_and_save => 'Speichern und schließen';
	@override String get add => 'Hinzufügen';
	@override String get edit => 'Bearbeiten';
	@override String get balance => 'Kontostand';
	@override String get delete => 'Löschen';
	@override String get account => 'Konto';
	@override String get accounts => 'Konten';
	@override String get categories => 'Kategorien';
	@override String get category => 'Kategorie';
	@override String get today => 'Heute';
	@override String get yesterday => 'Gestern';
	@override String get filters => 'Filter';
	@override String get see_more => 'Mehr sehen';
	@override String get select_all => 'Alles auswählen';
	@override String get deselect_all => 'Alle abwählen';
	@override String get empty_warn => 'Ops! Das ist sehr leer';
	@override String get insufficient_data => 'Unzureichende Daten';
	@override String get show_more_fields => 'Weitere Felder anzeigen';
	@override String get show_less_fields => 'Weniger Felder anzeigen';
	@override String get tap_to_search => 'Zum Suchen tippen';
	@override late final _TranslationsGeneralClipboardDe clipboard = _TranslationsGeneralClipboardDe._(_root);
	@override late final _TranslationsGeneralTimeDe time = _TranslationsGeneralTimeDe._(_root);
	@override late final _TranslationsGeneralTransactionOrderDe transaction_order = _TranslationsGeneralTransactionOrderDe._(_root);
	@override late final _TranslationsGeneralValidationsDe validations = _TranslationsGeneralValidationsDe._(_root);
}

// Path: intro
class _TranslationsIntroDe implements _TranslationsIntroEn {
	_TranslationsIntroDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get start => 'Start';
	@override String get skip => 'Überspringen';
	@override String get next => 'Nächste';
	@override String get select_your_currency => 'Wähle Deine Währung aus';
	@override String get welcome_subtitle => 'Dein persönlicher Finanzmanager';
	@override String get welcome_subtitle2 => '100 % geöffnet, 100 % kostenlos';
	@override String get welcome_footer => 'Mit der Anmeldung stimmst Du der <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Datenschutzrichtlinie</a> und den <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Nutzungsbedingungen</a> der App zu';
	@override String get offline_descr_title => 'OFFLINE-KONTO:';
	@override String get offline_descr => 'Deine Daten werden nur auf Deinem Gerät gespeichert und sind sicher, solange Du die App nicht deinstallieren oder das Telefon wechselst. ';
	@override String get offline_start => 'Sitzung offline starten';
	@override String get sl1_title => 'Wähle Deine Währung aus';
	@override String get sl1_descr => 'Deine Standardwährung wird in Berichten und allgemeinen Diagrammen verwendet. ';
	@override String get sl2_title => 'Sicher, privat und zuverlässig';
	@override String get sl2_descr => 'Deine Daten gehören nur Dir. ';
	@override String get sl2_descr2 => 'Außerdem ist der Quellcode der Anwendung öffentlich, jeder kann daran mitarbeiten und sehen, wie es funktioniert';
	@override String get last_slide_title => 'Alles bereit';
	@override String get last_slide_descr => 'Mit Monekin kannst Du endlich die finanzielle Unabhängigkeit erreichen, die Du dir so sehr wünschst. ';
	@override String get last_slide_descr2 => 'Wir hoffen, dass Du Deine Erfahrung genießet! Zögerne nicht, uns im Falle von Fragen oder Vorschlägen zu kontaktieren...';
}

// Path: home
class _TranslationsHomeDe implements _TranslationsHomeEn {
	_TranslationsHomeDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Übersicht';
	@override String get filter_transactions => 'Transaktionen filtern';
	@override String get hello_day => 'Guten Morgen,';
	@override String get hello_night => 'Gute Nacht,';
	@override String get total_balance => 'Gesamtbilanz';
	@override String get my_accounts => 'Meine Konten';
	@override String get active_accounts => 'Aktive Konten';
	@override String get no_accounts => 'Es wurden noch keine Konten erstellt';
	@override String get no_accounts_descr => 'Beginne, die ganze Magie von Monekin zu nutzen. ';
	@override String get last_transactions => 'Letzte Transaktionen';
	@override String get should_create_account_header => 'Hoppla!';
	@override String get should_create_account_message => 'Du musst über mindestens ein nicht archiviertes Konto verfügen, bevor Du mit der Erstellung von Transaktionen beginnen kannst';
}

// Path: financial_health
class _TranslationsFinancialHealthDe implements _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Finanzielle Lage';
	@override late final _TranslationsFinancialHealthReviewDe review = _TranslationsFinancialHealthReviewDe._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeDe months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeDe._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageDe savings_percentage = _TranslationsFinancialHealthSavingsPercentageDe._(_root);
}

// Path: stats
class _TranslationsStatsDe implements _TranslationsStatsEn {
	_TranslationsStatsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiken';
	@override String get balance => 'Kontostand';
	@override String get final_balance => 'Schlussstand';
	@override String get balance_by_account => 'Saldo nach Konten';
	@override String get balance_by_account_subtitle => 'Wo habe ich das meiste Geld?';
	@override String get balance_by_currency => 'Saldo nach Währung';
	@override String get balance_by_currency_subtitle => 'Wie viel Geld habe ich in Fremdwährung?';
	@override String get balance_evolution => 'Trend';
	@override String get balance_evolution_subtitle => 'Habe ich mehr Geld als vorher?';
	@override String get compared_to_previous_period => 'Im Vergleich zur Vorperiode';
	@override String get cash_flow => 'Cashflow';
	@override String get cash_flow_subtitle => 'Gebe ich weniger aus, als ich verdiene?';
	@override String get by_periods => 'Nach Perioden';
	@override String get by_categories => 'Nach Kategorien';
	@override String get by_tags => 'Nach Tags';
	@override String get distribution => 'Verteilung';
	@override String get finance_health_resume => 'Zusammenfassung';
	@override String get finance_health_breakdown => 'Auflüsselung';
}

// Path: icon_selector
class _TranslationsIconSelectorDe implements _TranslationsIconSelectorEn {
	_TranslationsIconSelectorDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Name:';
	@override String get icon => 'Symbol';
	@override String get color => 'Farbe';
	@override String get select_icon => 'Wähle ein Symbol aus';
	@override String get select_color => 'Wähle eine Farbe';
	@override String get custom_color => 'Benutzerdefinierte Farbe';
	@override String get current_color_selection => 'Aktuelle Auswahl';
	@override String get select_account_icon => 'Identifiziere Dein Konto';
	@override String get select_category_icon => 'Identifiziere Deine Kategorie';
	@override late final _TranslationsIconSelectorScopesDe scopes = _TranslationsIconSelectorScopesDe._(_root);
}

// Path: transaction
class _TranslationsTransactionDe implements _TranslationsTransactionEn {
	_TranslationsTransactionDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Transaktion',
		other: 'Transaktionen',
	);
	@override String get create => 'Neue Transaktion';
	@override String get new_income => 'Neues Einkommen';
	@override String get new_expense => 'Neue Ausgabe';
	@override String get new_success => 'Transaktion erfolgreich erstellt';
	@override String get edit => 'Transaktion bearbeiten';
	@override String get edit_success => 'Transaktion erfolgreich bearbeitet';
	@override String get edit_multiple => 'Bearbeite Deine Transaktionen';
	@override String edit_multiple_success({required Object x}) => '${x} Transaktionen erfolgreich bearbeitet';
	@override String get duplicate => 'Transaktion klonen';
	@override String get duplicate_short => 'Klon';
	@override String get duplicate_warning_message => 'Eine mit dieser identische Transaktion wird mit demselben Datum erstellt. Möchtest Du fortfahren?';
	@override String get duplicate_success => 'Transaktion erfolgreich geklont';
	@override String get delete => 'Transaktion löschen';
	@override String get delete_warning_message => 'Diese Aktion ist irreversibel. ';
	@override String get delete_success => 'Transaktion korrekt gelöscht';
	@override String get delete_multiple => 'Transaktionen löschen';
	@override String delete_multiple_warning_message({required Object x}) => 'Diese Aktion ist irreversibel und wird entfernt ${x} Transaktionen. ';
	@override String delete_multiple_success({required Object x}) => '${x} Transaktionen korrekt gelöscht';
	@override String get details => 'Bewegungsdetails';
	@override late final _TranslationsTransactionNextPaymentsDe next_payments = _TranslationsTransactionNextPaymentsDe._(_root);
	@override late final _TranslationsTransactionListDe list = _TranslationsTransactionListDe._(_root);
	@override late final _TranslationsTransactionFiltersDe filters = _TranslationsTransactionFiltersDe._(_root);
	@override late final _TranslationsTransactionFormDe form = _TranslationsTransactionFormDe._(_root);
	@override late final _TranslationsTransactionReversedDe reversed = _TranslationsTransactionReversedDe._(_root);
	@override late final _TranslationsTransactionStatusDe status = _TranslationsTransactionStatusDe._(_root);
	@override late final _TranslationsTransactionTypesDe types = _TranslationsTransactionTypesDe._(_root);
}

// Path: transfer
class _TranslationsTransferDe implements _TranslationsTransferEn {
	_TranslationsTransferDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Überweisen';
	@override String get transfers => 'Überweisungen';
	@override String transfer_to({required Object account}) => 'Überweisen an ${account}';
	@override String get create => 'Neue Überweisung';
	@override String get need_two_accounts_warning_header => 'Ops!';
	@override String get need_two_accounts_warning_message => 'Um diese Aktion auszuführen, sind mindestens zwei Konten erforderlich. Wenn Du den aktuellen Saldo dieses Kontos anpassen oder bearbeiten möchtest, klicke auf die Schaltfläche Bearbeiten';
	@override late final _TranslationsTransferFormDe form = _TranslationsTransferFormDe._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsDe implements _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wiederkehrende Transaktionen';
	@override String get title_short => 'Wiederk. Transakt.';
	@override String get empty => 'Anscheinend hast Du keine wiederkehrenden Transaktionen. Erstelle eine monatliche, jährliche oder wöchentliche wiederkehrende Transaktion, die hier angezeigt wird.';
	@override String get total_expense_title => 'Gesamtausgaben pro Periode';
	@override String get total_expense_descr => '* Ohne Berücksichtigung des Start- und Enddatums jeder Wiederholung';
	@override late final _TranslationsRecurrentTransactionsDetailsDe details = _TranslationsRecurrentTransactionsDetailsDe._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusDe status = _TranslationsRecurrentTransactionsStatusDe._(_root);
}

// Path: account
class _TranslationsAccountDe implements _TranslationsAccountEn {
	_TranslationsAccountDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get details => 'Kontodaten';
	@override String get date => 'Eröffnungsdatum';
	@override String get close_date => 'Einsendeschluss';
	@override String get reopen => 'Konto erneut eröffnen';
	@override String get reopen_short => 'Wieder öffnen';
	@override String get reopen_descr => 'Möchtest Du dieses Konto wirklich wieder eröffnen?';
	@override String get balance => 'Kontostand';
	@override String get n_transactions => 'Anzahl der Transaktionen';
	@override String get add_money => 'Geld hinzufügen';
	@override String get withdraw_money => 'Geld abheben';
	@override String get no_accounts => 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. Füge eine Transaktion hinzu, indem Du auf die Schaltfläche „+“ am unteren Rand klickst.';
	@override late final _TranslationsAccountTypesDe types = _TranslationsAccountTypesDe._(_root);
	@override late final _TranslationsAccountFormDe form = _TranslationsAccountFormDe._(_root);
	@override late final _TranslationsAccountDeleteDe delete = _TranslationsAccountDeleteDe._(_root);
	@override late final _TranslationsAccountCloseDe close = _TranslationsAccountCloseDe._(_root);
	@override late final _TranslationsAccountSelectDe select = _TranslationsAccountSelectDe._(_root);
}

// Path: currencies
class _TranslationsCurrenciesDe implements _TranslationsCurrenciesEn {
	_TranslationsCurrenciesDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Währungsrechner';
	@override String get currency => 'Währung';
	@override String get currency_manager => 'Währungsmanager';
	@override String get currency_manager_descr => 'Konfiguriere Deine Währung und deren Wechselkurse mit anderen';
	@override String get preferred_currency => 'Bevorzugte/Basis Währung';
	@override String get change_preferred_currency_title => 'Änder die bevorzugte Währung';
	@override String get change_preferred_currency_msg => 'Alle Statistiken und Budgets werden ab sofort in dieser Währung angezeigt. Konten und Transaktionen behalten die Währung, die sie hatten. Alle gespeicherten Wechselkurse werden gelöscht, wenn Du diese Aktion ausführst. Möchtest Du fortfahren?';
	@override late final _TranslationsCurrenciesFormDe form = _TranslationsCurrenciesFormDe._(_root);
	@override String get delete_all_success => 'Wechselkurse erfolgreich gelöscht';
	@override String get historical => 'Historische Kurse';
	@override String get exchange_rate => 'Wechselkurs';
	@override String get exchange_rates => 'Wechselkurse';
	@override String get empty => 'Füge hier Wechselkurse hinzu, damit unsere Diagramme genauer sind, wenn Du Konten in anderen Währungen als Deiner Basiswährung hast';
	@override String get select_a_currency => 'Wähle eine Währung aus';
	@override String get search => 'Suche nach Name oder Währungscode';
}

// Path: tags
class _TranslationsTagsDe implements _TranslationsTagsEn {
	_TranslationsTagsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Label',
		other: 'Schlagworte',
	);
	@override late final _TranslationsTagsFormDe form = _TranslationsTagsFormDe._(_root);
	@override late final _TranslationsTagsSelectDe select = _TranslationsTagsSelectDe._(_root);
	@override String get empty_list => 'Du hast noch keine Schlagworte erstellt. Schlagworte und Kategorien sind eine gute Möglichkeit, Deine Bewegungen zu kategorisieren';
	@override String get without_tags => 'Ohne Schlagworte';
	@override String get add => 'Schlagwort hinzufügen';
	@override String get create => 'Label erstellen';
	@override String get create_success => 'Label erfolgreich erstellt';
	@override String get already_exists => 'Dieser Schlagwort-Name existiert bereits. ';
	@override String get edit => 'Schlagwort bearbeiten';
	@override String get edit_success => 'Schlagwort erfolgreich bearbeitet';
	@override String get delete_success => 'Kategorie erfolgreich gelöscht';
	@override String get delete_warning_header => 'Schlagwort löschen?';
	@override String get delete_warning_message => 'Durch diese Aktion werden keine Transaktionen gelöscht, die dieses Schlagwort haben.';
}

// Path: categories
class _TranslationsCategoriesDe implements _TranslationsCategoriesEn {
	_TranslationsCategoriesDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Unbekannte Kategorie';
	@override String get create => 'Kategorie erstellen';
	@override String get create_success => 'Kategorie korrekt erstellt';
	@override String get new_category => 'Neue Kategorie';
	@override String get already_exists => 'Der Name dieser Kategorie existiert bereits. Willst du es verändern?';
	@override String get edit => 'Kategorie bearbeiten';
	@override String get edit_success => 'Kategorie korrekt bearbeitet';
	@override String get name => 'Kategoriename';
	@override String get type => 'Kategorietyp';
	@override String get both_types => 'Beide Typen';
	@override String get subcategories => 'Unterkategorien';
	@override String get subcategories_add => 'Unterkategorie hinzufügen';
	@override String get make_parent => 'Zur Kategorie hinzufügen';
	@override String get make_child => 'Erstelle eine Unterkategorie';
	@override String make_child_warning1({required Object destiny}) => 'Diese Kategorie und ihre Unterkategorien werden zu Unterkategorien von <b>${destiny}</b>.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'Deine Transaktionen <b>(${x})</b> werden in die neuen Unterkategorien verschoben, die innerhalb der Kategorie <b>${destiny}</b> erstellt wurden.';
	@override String get make_child_success => 'Unterkategorien erfolgreich erstellt';
	@override String get merge => 'Mit einer anderen Kategorie zusammenführen';
	@override String merge_warning1({required Object x, required Object from, required Object destiny}) => 'Alle Transaktionen (${x}), die mit der Kategorie <b>${from}</b> verknüpft sind werden in die Kategorie <b>${destiny}</b> verschoben';
	@override String merge_warning2({required Object from}) => 'Die Kategorie <b>${from}</b> werden unwiderruflich gelöscht.';
	@override String get merge_success => 'Die Kategorie wurde erfolgreich zusammengeführt';
	@override String get delete_success => 'Kategorie wurde korrekt gelöscht';
	@override String get delete_warning_header => 'Kategorie löschen?';
	@override String delete_warning_message({required Object x}) => 'Durch diese Aktion werden alle Transaktionen unwiderruflich gelöscht <b>(${x})</b> im Zusammenhang mit dieser Kategorie.';
	@override late final _TranslationsCategoriesSelectDe select = _TranslationsCategoriesSelectDe._(_root);
}

// Path: budgets
class _TranslationsBudgetsDe implements _TranslationsBudgetsEn {
	_TranslationsBudgetsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budgets';
	@override String get repeated => 'Wiederkehrend';
	@override String get one_time => 'Einmalig';
	@override String get annual => 'Jährlich';
	@override String get week => 'Wöchentlich';
	@override String get month => 'Monatlich';
	@override String get actives => 'Aktive';
	@override String get pending => 'Ausstehender Start';
	@override String get finish => 'Fertig';
	@override String get from_budgeted => 'übrig von ';
	@override String get days_left => 'Tage übrig';
	@override String get days_to_start => 'Tage bis Start';
	@override String get since_expiration => 'Tage seit Ablauf';
	@override String get no_budgets => 'Es scheint, dass in diesem Abschnitt keine Budgets angezeigt werden können. Beginne mit der Erstellung eines Budgets, indem Du auf die Schaltfläche unten klickst';
	@override String get delete => 'Budget löschen';
	@override String get delete_warning => 'Diese Aktion ist irreversibel. ';
	@override late final _TranslationsBudgetsFormDe form = _TranslationsBudgetsFormDe._(_root);
	@override late final _TranslationsBudgetsDetailsDe details = _TranslationsBudgetsDetailsDe._(_root);
}

// Path: backup
class _TranslationsBackupDe implements _TranslationsBackupEn {
	_TranslationsBackupDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportDe export = _TranslationsBackupExportDe._(_root);
	@override late final _TranslationsBackupImportDe import = _TranslationsBackupImportDe._(_root);
	@override late final _TranslationsBackupAboutDe about = _TranslationsBackupAboutDe._(_root);
}

// Path: settings
class _TranslationsSettingsDe implements _TranslationsSettingsEn {
	_TranslationsSettingsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Einstellungen und Aussehen';
	@override String get title_short => 'Einstellungen';
	@override String get description => 'App-Theme, Texte und andere allgemeine Einstellungen';
	@override String get edit_profile => 'Profil bearbeiten';
	@override String get lang_section => 'Sprache und Texte';
	@override String get lang_title => 'App-Sprache';
	@override String get lang_descr => 'Sprache, in der die Texte in der App angezeigt werden';
	@override String get lang_help => 'Wenn an den Übersetzungen dieser App mitarbeiten möchten, kannst du dich an <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>unser Beschreibung</a> wenden';
	@override String get locale => 'Region';
	@override String get locale_descr => 'Lege das für Datumsangaben, Zahlen usw. zu verwendende Format fest.';
	@override String get locale_warn => 'Wenn Du die Region änderst, wird die App aktualisiert';
	@override String get first_day_of_week => 'Erster Tag der Woche';
	@override String get theme_and_colors => 'Thema und Farben';
	@override String get theme => 'Thema';
	@override String get theme_auto => 'Vom System definiert';
	@override String get theme_light => 'Hell';
	@override String get theme_dark => 'Dunkel';
	@override String get amoled_mode => 'AMOLED-Modus';
	@override String get amoled_mode_descr => 'Verwende nach Möglichkeit einn rein schwarzen Hintergrund. Das wird den Akku von Geräten mit AMOLED-Bildschirmen etwas schonen.';
	@override String get dynamic_colors => 'Dynamische Farben';
	@override String get dynamic_colors_descr => 'Verwende wann immer möglich die Akzentfarbe des Systems';
	@override String get accent_color => 'Akzentfarbe';
	@override String get accent_color_descr => 'Wähle die Farbe aus, mit der die App bestimmte Teile der Benutzeroberfläche hervorhebt';
	@override late final _TranslationsSettingsSecurityDe security = _TranslationsSettingsSecurityDe._(_root);
}

// Path: more
class _TranslationsMoreDe implements _TranslationsMoreEn {
	_TranslationsMoreDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mehr';
	@override String get title_long => 'Weitere Aktionen';
	@override late final _TranslationsMoreDataDe data = _TranslationsMoreDataDe._(_root);
	@override late final _TranslationsMoreAboutUsDe about_us = _TranslationsMoreAboutUsDe._(_root);
	@override late final _TranslationsMoreHelpUsDe help_us = _TranslationsMoreHelpUsDe._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardDe implements _TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} in die Zwischenablage kopiert';
	@override String get error => 'Fehler beim Kopieren';
}

// Path: general.time
class _TranslationsGeneralTimeDe implements _TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Startdatum';
	@override String get end_date => 'Enddatum';
	@override String get from_date => 'Ab Datum';
	@override String get until_date => 'Bis heute';
	@override String get date => 'Datum';
	@override String get datetime => 'Datum/Uhrzeit';
	@override String get time => 'Zeit';
	@override String get each => 'Jede';
	@override String get after => 'Nach';
	@override late final _TranslationsGeneralTimeRangesDe ranges = _TranslationsGeneralTimeRangesDe._(_root);
	@override late final _TranslationsGeneralTimePeriodicityDe periodicity = _TranslationsGeneralTimePeriodicityDe._(_root);
	@override late final _TranslationsGeneralTimeCurrentDe current = _TranslationsGeneralTimeCurrentDe._(_root);
	@override late final _TranslationsGeneralTimeAllDe all = _TranslationsGeneralTimeAllDe._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderDe implements _TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Bestellvorgänge';
	@override String get category => 'Nach Kategorie';
	@override String get quantity => 'Nach Menge';
	@override String get date => 'Nach Datum';
}

// Path: general.validations
class _TranslationsGeneralValidationsDe implements _TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Korrigiere die angegebenen Felder, um fortzufahren';
	@override String get required => 'Erforderliches Feld';
	@override String get positive => 'Sollte positiv sein';
	@override String min_number({required Object x}) => 'Sollte größer sein als ${x}';
	@override String max_number({required Object x}) => 'Sollte kleiner sein als ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewDe implements _TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Sehr gut!';
			case GenderContext.female:
				return 'Sehr gut!';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Gut';
			case GenderContext.female:
				return 'Gut';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Durchschnitt';
			case GenderContext.female:
				return 'Durchschnitt';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Mäßig';
			case GenderContext.female:
				return 'Mäßig';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Sehr schlecht';
			case GenderContext.female:
				return 'Sehr schlecht';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Unzureichende Daten';
			case GenderContext.female:
				return 'Unzureichende Daten';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrDe descr = _TranslationsFinancialHealthReviewDescrDe._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeDe implements _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Überlebensrate';
	@override String get subtitle => 'Angesichts Deines Guthabens, wie viel Zeit kannst Du ohne Einkommen auskommen?';
	@override String get text_zero => 'Bei diesem Ausgabenniveau kannst Du keinen Monat ohne Einkommen überleben!';
	@override String get text_one => 'Bei diesem Ausgabenniveau kannst Du kaum etwa einen Monat ohne Einkommen überleben!';
	@override String text_other({required Object n}) => 'Du könntest ungefähr <b>${n} Monate</b> ohne Einkommen bei dieser Ausgabenrate überleben.';
	@override String get text_infinite => 'Du könntest ungefähr <b>Dein ganzes Leben lang</b> ohne Einkommen bei dieser Ausgabenrate überleben.';
	@override String get suggestion => 'Denke daran, dass es ratsam ist, dieses Verhältnis immer mindestens über 5 Monate zu halten. Wenn Du feststellst, dass Du nicht über ein ausreichendes Sparpolster verfügst, solltest Du unnötige Ausgaben reduzieren.';
	@override String get insufficient_data => 'Offenbar haben wir nicht genügend Ausgaben, um zu berechnen, wie viele Monate Du ohne Einkommen überleben könntest. Gib ein paar Transaktionen ein und komme hierher zurück, um Deine Finanzen zu überprüfen.';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageDe implements _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sparprozentsatz';
	@override String get subtitle => 'Welcher Teil Deines Einkommens wird in diesem Zeitraum nicht ausgegeben?';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextDe text = _TranslationsFinancialHealthSavingsPercentageTextDe._(_root);
	@override String get suggestion => 'Denk daran, dass es ratsam ist, mindestens 15-20 % Deines Einkommens zu sparen.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesDe implements _TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Transport';
	@override String get money => 'Geld';
	@override String get food => 'Essen';
	@override String get medical => 'Gesundheit';
	@override String get entertainment => 'Freizeit';
	@override String get technology => 'Technologie';
	@override String get other => 'Andere';
	@override String get logos_financial_institutions => 'Finanzinstitute';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsDe implements _TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get accept => 'Akzeptieren';
	@override String get skip => 'Überspringen';
	@override String get skip_success => 'Transaktion erfolgreich übersprungen';
	@override String get skip_dialog_title => 'Transaktion überspringen';
	@override String skip_dialog_msg({required Object date}) => 'Diese Aktion ist irreversibel.  ${date}';
	@override String get accept_today => 'Akzeptiere noch heute';
	@override String accept_in_required_date({required Object date}) => 'Akzeptierst Du das gewünschte Datum (${date})';
	@override String get accept_dialog_title => 'Akzeptierst Du die Transaktion';
	@override String get accept_dialog_msg_single => 'Der neue Status der Transaktion ist null. ';
	@override String accept_dialog_msg({required Object date}) => 'Diese Aktion erstellt eine neue Transaktion mit Datum ${date}. Du kannst die Details dieser Transaktion auf der Transaktionsseite überprüfen';
	@override String get recurrent_rule_finished => 'Die wiederkehrende Regel ist abgeschlossen, es sind keine weiteren Zahlungen mehr zu leisten!';
}

// Path: transaction.list
class _TranslationsTransactionListDe implements _TranslationsTransactionListEn {
	_TranslationsTransactionListDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. ';
	@override String get searcher_placeholder => 'Suche nach Kategorie, Beschreibung...';
	@override String get searcher_no_results => 'Es wurden keine Transaktionen gefunden, die den Suchkriterien entsprechen';
	@override String get loading => 'Weitere Transaktionen werden geladen...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} ausgewählt',
		other: '${n} ausgewählt',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Transaktion ausgewählt',
		other: '${n} Transaktionen ausgewählt',
	);
	@override late final _TranslationsTransactionListBulkEditDe bulk_edit = _TranslationsTransactionListBulkEditDe._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersDe implements _TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get from_value => 'Ab Betrag';
	@override String get to_value => 'Bis zum Betrag';
	@override String from_value_def({required Object x}) => 'Von ${x}';
	@override String to_value_def({required Object x}) => 'Bis zu ${x}';
	@override String from_date_def({required Object date}) => 'Von der ${date}';
	@override String to_date_def({required Object date}) => 'Bis zum ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormDe implements _TranslationsTransactionFormEn {
	_TranslationsTransactionFormDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsDe validators = _TranslationsTransactionFormValidatorsDe._(_root);
	@override String get title => 'Transaktionstitel';
	@override String get title_short => 'Titel';
	@override String get value => 'Wert der Transaktion';
	@override String get tap_to_see_more => 'Tippen, um weitere Details anzuzeigen';
	@override String get no_tags => '– Keine Tags –';
	@override String get description => 'Beschreibung';
	@override String get description_info => 'Tippe hier, um eine detailliertere Beschreibung dieser Transaktion einzugeben';
	@override String exchange_to_preferred_title({required Object currency}) => 'Wechselkurs zu ${currency}';
	@override String get exchange_to_preferred_in_date => 'Am Transaktionsdatum';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedDe implements _TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Umgekehrte Transaktion';
	@override String get title_short => 'Umgekehrte Tr.';
	@override String get description_for_expenses => 'Obwohl es sich um eine Spesentransaktion handelt, weist sie einen positiven Betrag auf. ';
	@override String get description_for_incomes => 'Obwohl es sich um eine Einkommenstransaktion handelt, weist sie einen negativen Betrag auf. ';
}

// Path: transaction.status
class _TranslationsTransactionStatusDe implements _TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Status',
		other: 'Status',
	);
	@override String get display_long => 'Transaktionsstatus';
	@override String tr_status({required Object status}) => '${status} Transaktion';
	@override String get none => 'Ohne Status';
	@override String get none_descr => 'Transaktion ohne bestimmten Status';
	@override String get reconciled => 'Ausgeglichen';
	@override String get reconciled_descr => 'Diese Transaktion wurde bereits validiert und entspricht einer echten Transaktion Deiner Bank';
	@override String get unreconciled => 'Unausgeglichen';
	@override String get unreconciled_descr => 'Diese Transaktion wurde noch nicht validiert und erscheint daher noch nicht auf Deinem echten Bankkonten. ';
	@override String get pending => 'Ausstehend';
	@override String get pending_descr => 'Diese Transaktion steht noch aus und wird daher bei der Berechnung von Salden und Statistiken nicht berücksichtigt';
	@override String get voided => 'Entwertet';
	@override String get voided_descr => 'Transaktion aufgrund eines Zahlungsfehlers oder aus einem anderen Grund ungültig/storniert. ';
}

// Path: transaction.types
class _TranslationsTransactionTypesDe implements _TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Transaktionstyp',
		other: 'Transaktiontypen',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Einkommen',
		other: 'Einkommen',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Ausgaben',
		other: 'Ausgaben',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Überweisen',
		other: 'Überweisungen',
	);
}

// Path: transfer.form
class _TranslationsTransferFormDe implements _TranslationsTransferFormEn {
	_TranslationsTransferFormDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get from => 'Origin-Konto';
	@override String get to => 'Zielkonto';
	@override late final _TranslationsTransferFormValueInDestinyDe value_in_destiny = _TranslationsTransferFormValueInDestinyDe._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsDe implements _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wiederkehrende Transaktion';
	@override String get descr => 'Die nächsten Schritte für diese Transaktion werden unten angezeigt. Du kannst den ersten Schritt akzeptieren oder diesen Schritt auslassen';
	@override String get last_payment_info => 'Diese Bewegung ist die letzte der wiederkehrenden Regel, daher wird diese Regel beim Bestätigen dieser Aktion automatisch gelöscht';
	@override String get delete_header => 'Wiederkehrende Transaktion löschen';
	@override String get delete_message => 'Diese Aktion ist unumkehrbar und hat keinen Einfluss auf Transaktionen, die Du bereits bestätigt/bezahlt habst';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusDe implements _TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Verzögert um ${x}d';
	@override String coming_in({required Object x}) => 'In ${x} Tagen';
}

// Path: account.types
class _TranslationsAccountTypesDe implements _TranslationsAccountTypesEn {
	_TranslationsAccountTypesDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontotyp';
	@override String get warning => 'Sobald der Kontotyp ausgewählt wurde, kann er in Zukunft nicht mehr geändert werden';
	@override String get normal => 'Normales Konto';
	@override String get normal_descr => 'Nützlich, um Deine täglichen Finanzen aufzuzeichnen. Es ist das gebräuchlichste Konto, das es Dir ermöglicht, Ausgaben, Einnahmen hinzuzufügen';
	@override String get saving => 'Sparkonto';
	@override String get saving_descr => 'Du kannst nur Geld von anderen Konten einzahlen und abheben. Perfekt geignet, um Geld zu sparen';
}

// Path: account.form
class _TranslationsAccountFormDe implements _TranslationsAccountFormEn {
	_TranslationsAccountFormDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Kontoname';
	@override String get name_placeholder => 'Beispiel: Sparkonto';
	@override String get notes => 'Notizen';
	@override String get notes_placeholder => 'Gebe einige Notizen/Beschreibungen zu diesem Konto ein';
	@override String get initial_balance => 'Anfangssaldo';
	@override String get current_balance => 'Aktueller Kontostand';
	@override String get create => 'Konto erstellen';
	@override String get edit => 'Konto bearbeiten';
	@override String get currency_not_found_warn => 'Du hast keine Informationen zu den Wechselkursen für diese Währung. Als Standardwechselkurs wird 1,0 verwendet. Du kannst das in den Einstellungen ändern';
	@override String get already_exists => 'Es gibt bereits ein Konto mit demselben Namen, bitte nutze einen anderen';
	@override String get tr_before_opening_date => 'Auf diesem Konto liegen Transaktionen vor, deren Datum vor dem Eröffnungsdatum liegt';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteDe implements _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Konto löschen?';
	@override String get warning_text => 'Durch diese Aktion werden dieses Konto und alle seine Transaktionen gelöscht';
	@override String get success => 'Konto erfolgreich gelöscht';
}

// Path: account.close
class _TranslationsAccountCloseDe implements _TranslationsAccountCloseEn {
	_TranslationsAccountCloseDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konto schließen';
	@override String get title_short => 'Schließen';
	@override String get warn => 'Dieses Konto wird in bestimmten Einträgen nicht mehr angezeigt und Du kannst darin keine Transaktionen mit einem späteren als dem unten angegebenen Datum erstellen. Diese Aktion hat keine Auswirkungen auf Transaktionen oder Guthaben, und Du kannst dieses Konto auch jederzeit wieder eröffnen.';
	@override String get should_have_zero_balance => 'Um das Konto schließen zu können, muss der aktuelle Kontostand 0 betragen.  Bitte bearbeite das Konto, bevor du fortfährst';
	@override String get should_have_no_transactions => 'Auf diesem Konto liegen Transaktionen nach dem angegebenen Schlussdatum vor. Lösche sie oder bearbeite das Datum der Kontoschließung, bevor Du fortfährst';
	@override String get success => 'Konto erfolgreich geschlossen';
	@override String get unarchive_succes => 'Konto erfolgreich wiedereröffnet';
}

// Path: account.select
class _TranslationsAccountSelectDe implements _TranslationsAccountSelectEn {
	_TranslationsAccountSelectDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get one => 'Wähle ein Konto aus';
	@override String get all => 'Alle Konten';
	@override String get multiple => 'Wähle Konten aus';
}

// Path: currencies.form
class _TranslationsCurrenciesFormDe implements _TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'Die Währung darf nicht mit der Benutzerwährung übereinstimmen';
	@override String get specify_a_currency => 'Bitte gib eine Währung an';
	@override String get add => 'Wechselkurs hinzufügen';
	@override String get add_success => 'Wechselkurs erfolgreich hinzugefügt';
	@override String get edit => 'Wechselkurs bearbeiten';
	@override String get edit_success => 'Wechselkurs erfolgreich bearbeitet';
}

// Path: tags.form
class _TranslationsTagsFormDe implements _TranslationsTagsFormEn {
	_TranslationsTagsFormDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Schlagworte-Name';
	@override String get description => 'Beschreibung';
}

// Path: tags.select
class _TranslationsTagsSelectDe implements _TranslationsTagsSelectEn {
	_TranslationsTagsSelectDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Schlagworte auswählen';
	@override String get all => 'Alle Schlagworte';
}

// Path: categories.select
class _TranslationsCategoriesSelectDe implements _TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kategorien auswählen';
	@override String get select_one => 'Wähle eine Kategorie aus';
	@override String get select_subcategory => 'Wähle eine Unterkategorie';
	@override String get without_subcategory => 'Ohne Unterkategorie';
	@override String get all => 'Alle Kategorien';
	@override String get all_short => 'Alle';
}

// Path: budgets.form
class _TranslationsBudgetsFormDe implements _TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budget hinzufügen';
	@override String get name => 'Budgetname';
	@override String get value => 'Menge begrenzen';
	@override String get create => 'Budget hinzufügen';
	@override String get edit => 'Budget bearbeiten';
	@override String get negative_warn => 'Die Budgets dürfen keinen negativen Betrag haben';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsDe implements _TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budgetdetails';
	@override String get statistics => 'Statistiken';
	@override String get budget_value => 'Budgetiert';
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Du kannst ${dailyAmount}/Tag für ${remainingDays} verbleibende Tage ausgeben';
	@override String get expend_evolution => 'Ausgabenentwicklung';
	@override String get no_transactions => 'Es scheint, dass Du im Zusammenhang mit diesem Budget keine Ausgaben getätigt hast';
}

// Path: backup.export
class _TranslationsBackupExportDe implements _TranslationsBackupExportEn {
	_TranslationsBackupExportDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Daten exportieren';
	@override String get title_short => 'Export';
	@override String get all => 'Vollständige Sicherung';
	@override String get all_descr => 'Exportiere alle Deine Daten (Konten, Transaktionen, Budgets, Einstellungen...). ';
	@override String get transactions => 'Sicherung der Transaktionen';
	@override String get transactions_descr => 'Exportiere Deine Transaktionen im CSV-Format, damit Du sie einfacher in anderen Programmen oder Anwendungen analysieren kannst.';
	@override String get description => 'Lade Deine Daten in verschiedenen Formaten herunter';
	@override String get dialog_title => 'Datei speichern/senden';
	@override String success({required Object x}) => 'Datei erfolgreich gespeichert/heruntergeladen in ${x}';
	@override String get error => 'Fehler beim Herunterladen der Datei. ';
}

// Path: backup.import
class _TranslationsBackupImportDe implements _TranslationsBackupImportEn {
	_TranslationsBackupImportDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Daten importieren';
	@override String get title_short => 'Import';
	@override String get restore_backup => 'Sicherung wiederherstellen';
	@override String get restore_backup_descr => 'Importiere eine zuvor gespeicherte Datenbank von Monekin. Diese Aktion ersetzt alle aktuellen Anwendungsdaten durch die neuen Daten';
	@override String get restore_backup_warn_description => 'Beim Importieren einer neuen Datenbank gehen alle derzeit in der App gespeicherten Daten verloren. Es wird empfohlen, eine Sicherungskopie zu erstellen, bevor Du fortfährst. Lade hier keine Dateien hoch, deren Herkunft Du nicht kennst. Lade nur Dateien hoch, die Du zuvor von Monekin heruntergeladen hast.';
	@override String get restore_backup_warn_title => 'Alle Daten überschreiben';
	@override String get select_other_file => 'Andere Datei auswählen';
	@override String get tap_to_select_file => 'Tippe, um eine Datei auszuwählen';
	@override late final _TranslationsBackupImportManualImportDe manual_import = _TranslationsBackupImportManualImportDe._(_root);
	@override String get success => 'Der Import wurde erfolgreich durchgeführt';
	@override String get cancelled => 'Der Import wurde vom Benutzer abgebrochen';
	@override String get error => 'Fehler beim Importieren der Datei. Bitte kontaktiere den Entwickler lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutDe implements _TranslationsBackupAboutEn {
	_TranslationsBackupAboutDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informationen zu Deiner Datenbank';
	@override String get create_date => 'Erstellungsdatum';
	@override String get modify_date => 'Zuletzt geändert';
	@override String get last_backup => 'Letzte Sicherung';
	@override String get size => 'Größe';
}

// Path: settings.security
class _TranslationsSettingsSecurityDe implements _TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sicherheit';
	@override String get private_mode_at_launch => 'Privatmodus beim Start';
	@override String get private_mode_at_launch_descr => 'Starte die App standardmäßig im privaten Modus';
	@override String get private_mode => 'Privatmodus';
	@override String get private_mode_descr => 'Alle Geldwerte ausblenden';
	@override String get private_mode_activated => 'Privatmodus aktiviert';
	@override String get private_mode_deactivated => 'Privatmodus deaktiviert';
}

// Path: more.data
class _TranslationsMoreDataDe implements _TranslationsMoreDataEn {
	_TranslationsMoreDataDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Daten';
	@override String get display_descr => 'Exportiere und importiere Deine Daten, damit Du nichts verlierst';
	@override String get delete_all => 'Meine Daten löschen';
	@override String get delete_all_header1 => 'Höre genau dort auf, Padawan ⚠️⚠️';
	@override String get delete_all_message1 => 'Bist Du sicher, dass Du fortfahren möchtest? Alle Daten werden endgültig gelöscht und können nicht wiederhergestellt werden.';
	@override String get delete_all_header2 => 'Ein letzter Schritt ⚠️⚠️';
	@override String get delete_all_message2 => 'Durch das Löschen eines Kontos löschst Du alle Deine gespeicherten persönlichen Daten. Deine Konten, Transaktionen, Budgets und Kategorien werden gelöscht und können nicht wiederhergestellt werden. Bist Du damit einverstanden?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsDe implements _TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'App-Informationen';
	@override String get description => 'Schaue Dir die Bedingungen und andere relevante Informationen über Monekin an. Treten mit der Community in Kontakt, indem Du Fehler meldest, Vorschläge machst...';
	@override late final _TranslationsMoreAboutUsLegalDe legal = _TranslationsMoreAboutUsLegalDe._(_root);
	@override late final _TranslationsMoreAboutUsProjectDe project = _TranslationsMoreAboutUsProjectDe._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsDe implements _TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Hilf uns';
	@override String get description => 'Finde heraus, wie Du Monekin dabei helfen kannst, immer besser zu werden';
	@override String get rate_us => 'Bewerte uns';
	@override String get rate_us_descr => 'Jede Hilfe ist willkommen!';
	@override String get share => 'Teile  Monekin';
	@override String get share_descr => 'Teile  unsere App mit Freunden und Familie';
	@override String get share_text => 'Monekin! ';
	@override String get thanks => 'Danke schön!';
	@override String get thanks_long => 'Deine Beiträge zu Monekin und anderen großen und kleinen Open-Source-Projekten machen großartige Projekte wie dieses möglich. Danke, dass Du dir die Zeit nimmst teilzunehmen';
	@override String get donate => 'Mache eine Spende';
	@override String get donate_descr => 'Mit Deiner Spende trägst dazu bei, dass die App weiterhin verbessert wird. Was gibt es Schöneres, als sich für die geleistete Arbeit zu bedanken, indem man mich zu einem Kaffee einlädt?';
	@override String get donate_success => 'Spende erfolgt. Herzlichen Dank für Deine Beitrag! ❤️';
	@override String get donate_err => 'Hoppla! Es scheint ein Fehler beim Empfang Deiner Zahlung aufgetreten zu sein';
	@override String get report => 'Melde Fehler, hinterlasse Vorschläge ...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesDe implements _TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Zeitbereich';
	@override String get it_repeat => 'Wiederholt';
	@override String get it_ends => 'Endet';
	@override String get forever => 'Für immer';
	@override late final _TranslationsGeneralTimeRangesTypesDe types = _TranslationsGeneralTimeRangesTypesDe._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Jeder ${range}',
		other: 'Jeder ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Jeder ${range} bis ${day}',
		other: 'Jeder ${n} ${range} bis ${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Jeder ${range} ${limit} mal',
		other: 'Jeder ${n} ${range} ${limit} mal',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Jeder ${range} einmal',
		other: 'Jeder ${n} ${range} einmal',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Monat',
		other: 'Monate',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Jahr',
		other: 'Jahre',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Tag',
		other: 'Tage',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Woche',
		other: 'Wochen',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityDe implements _TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Wiederholung';
	@override String get no_repeat => 'Keine Wiederholung';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Wiederholung',
		other: 'Wiederholungen',
	);
	@override String get diary => 'Täglich';
	@override String get monthly => 'Monatlich';
	@override String get annually => 'Jährlich';
	@override String get quaterly => 'Vierteljährlich';
	@override String get weekly => 'Wöchentlich';
	@override String get custom => 'Brauch';
	@override String get infinite => 'Stets';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentDe implements _TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Diesen Monat';
	@override String get annually => 'Dieses Jahr';
	@override String get quaterly => 'Dieses Quartal';
	@override String get weekly => 'Diese Woche';
	@override String get infinite => 'Für immer';
	@override String get custom => 'Benutzerdefinierter Zeitraum';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllDe implements _TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Täglich';
	@override String get monthly => 'Jeden Monat';
	@override String get annually => 'Jährlich';
	@override String get quaterly => 'Vierteljährlich';
	@override String get weekly => 'Jede Woche';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrDe implements _TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Es sieht so aus, als hätten wir nicht genügend Ausgaben, um Deine finanzielle Lage zu berechnen. Füge in diesem Zeitraum einige Ausgaben/Einnahmen hinzu, damit wir Dir helfen können!';
	@override String get very_good => 'Glückwunsch! ';
	@override String get good => 'Großartig! ';
	@override String get normal => 'Deine finanzielle Lage entspricht in diesem Zeitraum mehr oder weniger dem Durchschnitt der übrigen Bevölkerung';
	@override String get bad => 'Es scheint, dass Deine finanzielle Situation noch nicht die beste ist. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
	@override String get very_bad => 'Hmm, Deine finanzielle Lage ist weit unter dem, was sie sein sollte. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextDe implements _TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen. Es scheint, dass Du bereits ein Experte sind, mache weiter so! ';
	@override String normal({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen';
	@override String bad({required Object value}) => 'Du hast es geschafft <b>${value}%</b> Deines Einkommens in diesem Zeitraum zu sparen . ';
	@override String get very_bad => 'Wow, du hast es in dieser Zeit nicht geschafft, etwas zu sparen.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditDe implements _TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Daten bearbeiten';
	@override String get categories => 'Kategorien bearbeiten';
	@override String get status => 'Status bearbeiten';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsDe implements _TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get zero => 'Der Wert einer Transaktion kann nicht gleich Null sein';
	@override String get date_max => 'Das ausgewählte Datum liegt nach dem aktuellen. ';
	@override String get date_after_account_creation => 'Du kannst keine Transaktion erstellen, deren Datum vor dem Erstellungsdatum des Kontos liegt, zu dem sie gehört';
	@override String get negative_transfer => 'Der Geldwert einer Überweisung darf nicht negativ sein';
	@override String get transfer_between_same_accounts => 'Das Ursprungs- und das Zielkonto dürfen nicht identisch sein';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyDe implements _TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Am Zielkonto überwiesener Betrag';
	@override String amount_short({required Object amount}) => '${amount} zum Zielkonto';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportDe implements _TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Manueller Import';
	@override String get descr => 'Importiere Transaktionen manuell aus einer CSV-Datei';
	@override String get default_account => 'Standardkonto';
	@override String get remove_default_account => 'Standardkonto entfernen';
	@override String get default_category => 'Standardkategorie';
	@override String get select_a_column => 'Wählen eine Spalte aus der CSV-Datei aus';
	@override List<String> get steps => [
		'Wähle Deine Datei aus',
		'Spalte für Menge',
		'Spalte für Konto',
		'Spalte für Kategorie',
		'Spalte für Datum',
		'andere Spalten',
	];
	@override List<String> get steps_descr => [
		'Wähle eine CSV-Datei von Deinem Gerät aus. Stelle sicher, dass die erste Zeile den Namen der einzelnen Spalten enthält',
		'Wählen die Spalte aus, in der der Wert jeder Transaktion angegeben ist. Verwende negative Werte für Ausgaben und positive Werte für Einnahmen. Verwende einen Punkt als Dezimaltrennzeichen',
		'Wähle die Spalte aus, in der das Konto angegeben ist, zu dem jede Transaktion gehört. Du kannst auch ein Standardkonto auswählen, falls wir das von Dir gewünschte Konto nicht finden können. Wenn Du kein Standardkonto angibst, wird eines mit demselben Namen erstellt ',
		'Gebe die Spalte an, in der sich der Name der Transaktionskategorie befindet. Du musst eine Standardkategorie angeben, damit wir diese Kategorie den Transaktionen zuordnen können, falls die Kategorie nicht gefunden werden kann.',
		'Wähle die Spalte aus, in der das Datum jeder Transaktion angegeben ist. Wird nichts angegeben, werden die Transaktionen mit dem aktuellen Datum erstellt.',
		'Gibt die Spalten für andere optionale Transaktionsattribute an',
	];
	@override String success({required Object x}) => 'Erfolgreich ${x} Transaktionen importiert';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalDe implements _TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Rechtliche Informationen';
	@override String get privacy => 'Datenschutzrichtlinie';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get licenses => 'Lizenzen';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectDe implements _TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Projekt';
	@override String get contributors => 'Mitarbeiter';
	@override String get contributors_descr => 'Alle Entwickler, die Monekin wachsen lassen haben';
	@override String get contact => 'Kontaktiere uns';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesDe implements _TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Zyklen';
	@override String get last_days => 'Letzte Tage';
	@override String last_days_form({required Object x}) => '${x} Vortage';
	@override String get all => 'Immer';
	@override String get date_range => 'Benutzerdefinierter Zeitraum';
}

// Path: <root>
class _TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsEs _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsGeneralEs general = _TranslationsGeneralEs._(_root);
	@override late final _TranslationsIntroEs intro = _TranslationsIntroEs._(_root);
	@override late final _TranslationsHomeEs home = _TranslationsHomeEs._(_root);
	@override late final _TranslationsFinancialHealthEs financial_health = _TranslationsFinancialHealthEs._(_root);
	@override late final _TranslationsStatsEs stats = _TranslationsStatsEs._(_root);
	@override late final _TranslationsIconSelectorEs icon_selector = _TranslationsIconSelectorEs._(_root);
	@override late final _TranslationsTransactionEs transaction = _TranslationsTransactionEs._(_root);
	@override late final _TranslationsTransferEs transfer = _TranslationsTransferEs._(_root);
	@override late final _TranslationsRecurrentTransactionsEs recurrent_transactions = _TranslationsRecurrentTransactionsEs._(_root);
	@override late final _TranslationsAccountEs account = _TranslationsAccountEs._(_root);
	@override late final _TranslationsCurrenciesEs currencies = _TranslationsCurrenciesEs._(_root);
	@override late final _TranslationsTagsEs tags = _TranslationsTagsEs._(_root);
	@override late final _TranslationsCategoriesEs categories = _TranslationsCategoriesEs._(_root);
	@override late final _TranslationsBudgetsEs budgets = _TranslationsBudgetsEs._(_root);
	@override late final _TranslationsBackupEs backup = _TranslationsBackupEs._(_root);
	@override late final _TranslationsSettingsEs settings = _TranslationsSettingsEs._(_root);
	@override late final _TranslationsMoreEs more = _TranslationsMoreEs._(_root);
}

// Path: general
class _TranslationsGeneralEs implements _TranslationsGeneralEn {
	_TranslationsGeneralEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get or => 'o';
	@override String get understood => 'Entendido';
	@override String get unspecified => 'Sin especificar';
	@override String get confirm => 'Confirmar';
	@override String get continue_text => 'Continuar';
	@override String get quick_actions => 'Acciones rápidas';
	@override String get save => 'Guardar';
	@override String get save_changes => 'Guardar cambios';
	@override String get close_and_save => 'Guardar y cerrar';
	@override String get add => 'Añadir';
	@override String get edit => 'Editar';
	@override String get delete => 'Eliminar';
	@override String get balance => 'Balance';
	@override String get account => 'Cuenta';
	@override String get accounts => 'Cuentas';
	@override String get categories => 'Categorías';
	@override String get category => 'Categoría';
	@override String get today => 'Hoy';
	@override String get yesterday => 'Ayer';
	@override String get filters => 'Filtros';
	@override String get see_more => 'Ver más';
	@override String get select_all => 'Seleccionar todo';
	@override String get deselect_all => 'Deseleccionar todo';
	@override String get empty_warn => 'Ops! Esto esta muy vacio';
	@override String get insufficient_data => 'Datos insuficientes';
	@override String get show_more_fields => 'Show more fields';
	@override String get show_less_fields => 'Show less fields';
	@override String get tap_to_search => 'Toca para buscar';
	@override late final _TranslationsGeneralClipboardEs clipboard = _TranslationsGeneralClipboardEs._(_root);
	@override late final _TranslationsGeneralTimeEs time = _TranslationsGeneralTimeEs._(_root);
	@override late final _TranslationsGeneralTransactionOrderEs transaction_order = _TranslationsGeneralTransactionOrderEs._(_root);
	@override late final _TranslationsGeneralValidationsEs validations = _TranslationsGeneralValidationsEs._(_root);
}

// Path: intro
class _TranslationsIntroEs implements _TranslationsIntroEn {
	_TranslationsIntroEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get start => 'Empecemos';
	@override String get skip => 'Saltar';
	@override String get next => 'Siguiente';
	@override String get select_your_currency => 'Selecciona tu divisa';
	@override String get welcome_subtitle => 'Tu gestor de finanzas personales';
	@override String get welcome_subtitle2 => '100% libre, 100% gratis';
	@override String get welcome_footer => 'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación';
	@override String get offline_descr_title => 'CUENTA SIN CONEXIÓN:';
	@override String get offline_descr => 'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
	@override String get offline_start => 'Iniciar sesión offline';
	@override String get sl1_title => 'Selecciona tu divisa';
	@override String get sl1_descr => 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
	@override String get sl2_title => 'Seguro, privado y confiable';
	@override String get sl2_descr => 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
	@override String get sl2_descr2 => 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
	@override String get last_slide_title => 'Todo listo!';
	@override String get last_slide_descr => 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
	@override String get last_slide_descr2 => 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
}

// Path: home
class _TranslationsHomeEs implements _TranslationsHomeEn {
	_TranslationsHomeEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inicio';
	@override String get filter_transactions => 'Filtrar transacciones';
	@override String get hello_day => 'Buenos días,';
	@override String get hello_night => 'Buenas noches,';
	@override String get total_balance => 'Saldo total';
	@override String get my_accounts => 'Mis cuentas';
	@override String get active_accounts => 'Cuentas activas';
	@override String get no_accounts => 'Aun no hay cuentas creadas';
	@override String get no_accounts_descr => 'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones';
	@override String get last_transactions => 'Últimas transacciones';
	@override String get should_create_account_header => 'Ops!';
	@override String get should_create_account_message => 'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones';
}

// Path: financial_health
class _TranslationsFinancialHealthEs implements _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Salud financiera';
	@override late final _TranslationsFinancialHealthReviewEs review = _TranslationsFinancialHealthReviewEs._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeEs months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeEs._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageEs savings_percentage = _TranslationsFinancialHealthSavingsPercentageEs._(_root);
}

// Path: stats
class _TranslationsStatsEs implements _TranslationsStatsEn {
	_TranslationsStatsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estadísticas';
	@override String get balance => 'Saldo';
	@override String get final_balance => 'Saldo final';
	@override String get balance_by_account => 'Saldo por cuentas';
	@override String get balance_by_account_subtitle => '¿Donde tengo la mayor parte de mi dinero?';
	@override String get balance_by_currency => 'Saldo por divisas';
	@override String get balance_by_currency_subtitle => '¿Cuanto dinero tengo en moneda extranjera?';
	@override String get balance_evolution => 'Tendencia de saldo';
	@override String get balance_evolution_subtitle => '¿Tengo más dinero que antes?';
	@override String get compared_to_previous_period => 'Frente al periodo anterior';
	@override String get cash_flow => 'Flujo de caja';
	@override String get cash_flow_subtitle => '¿Estoy gastando menos de lo que gano?';
	@override String get by_periods => 'Por periodos';
	@override String get by_categories => 'Por categorías';
	@override String get by_tags => 'Por etiquetas';
	@override String get distribution => 'Distribución';
	@override String get finance_health_resume => 'Resumen';
	@override String get finance_health_breakdown => 'Desglose';
}

// Path: icon_selector
class _TranslationsIconSelectorEs implements _TranslationsIconSelectorEn {
	_TranslationsIconSelectorEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre:';
	@override String get icon => 'Icono';
	@override String get color => 'Color';
	@override String get select_icon => 'Selecciona un icono';
	@override String get select_color => 'Selecciona un color';
	@override String get custom_color => 'Color personalizado';
	@override String get current_color_selection => 'Selección actual';
	@override String get select_account_icon => 'Identifica tu cuenta';
	@override String get select_category_icon => 'Identifica tu categoría';
	@override late final _TranslationsIconSelectorScopesEs scopes = _TranslationsIconSelectorScopesEs._(_root);
}

// Path: transaction
class _TranslationsTransactionEs implements _TranslationsTransactionEn {
	_TranslationsTransactionEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Transacción',
		other: 'Transacciones',
	);
	@override String get create => 'Nueva transacción';
	@override String get new_income => 'Nuevo ingreso';
	@override String get new_expense => 'Nuevo gasto';
	@override String get new_success => 'Transacción creada correctamente';
	@override String get edit => 'Editar transacción';
	@override String get edit_success => 'Transacción editada correctamente';
	@override String get edit_multiple => 'Editar transacciones';
	@override String edit_multiple_success({required Object x}) => '${x} transacciones editadas correctamente';
	@override String get duplicate => 'Clonar transacción';
	@override String get duplicate_short => 'Clonar';
	@override String get duplicate_warning_message => 'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?';
	@override String get duplicate_success => 'Transacción clonada con exito';
	@override String get delete => 'Eliminar transacción';
	@override String get delete_warning_message => 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
	@override String get delete_success => 'Transacción eliminada correctamente';
	@override String get delete_multiple => 'Eliminar transacciones';
	@override String delete_multiple_warning_message({required Object x}) => 'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
	@override String delete_multiple_success({required Object x}) => '${x} transacciones eliminadas correctamente';
	@override String get details => 'Detalles del movimiento';
	@override late final _TranslationsTransactionNextPaymentsEs next_payments = _TranslationsTransactionNextPaymentsEs._(_root);
	@override late final _TranslationsTransactionListEs list = _TranslationsTransactionListEs._(_root);
	@override late final _TranslationsTransactionFiltersEs filters = _TranslationsTransactionFiltersEs._(_root);
	@override late final _TranslationsTransactionFormEs form = _TranslationsTransactionFormEs._(_root);
	@override late final _TranslationsTransactionReversedEs reversed = _TranslationsTransactionReversedEs._(_root);
	@override late final _TranslationsTransactionStatusEs status = _TranslationsTransactionStatusEs._(_root);
	@override late final _TranslationsTransactionTypesEs types = _TranslationsTransactionTypesEs._(_root);
}

// Path: transfer
class _TranslationsTransferEs implements _TranslationsTransferEn {
	_TranslationsTransferEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Transferencia';
	@override String get transfers => 'Transferencias';
	@override String transfer_to({required Object account}) => 'Transferencia hacia ${account}';
	@override String get create => 'Nueva transferencia';
	@override String get need_two_accounts_warning_header => 'Ops!';
	@override String get need_two_accounts_warning_message => 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
	@override late final _TranslationsTransferFormEs form = _TranslationsTransferFormEs._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsEs implements _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Movimientos recurrentes';
	@override String get title_short => 'Mov. recurrentes';
	@override String get empty => 'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
	@override String get total_expense_title => 'Gasto total por periodo';
	@override String get total_expense_descr => '* Sin considerar la fecha de inicio y fin de cada recurrencia';
	@override late final _TranslationsRecurrentTransactionsDetailsEs details = _TranslationsRecurrentTransactionsDetailsEs._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusEs status = _TranslationsRecurrentTransactionsStatusEs._(_root);
}

// Path: account
class _TranslationsAccountEs implements _TranslationsAccountEn {
	_TranslationsAccountEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get details => 'Detalles de la cuenta';
	@override String get date => 'Fecha de apertura';
	@override String get close_date => 'Fecha de cierre';
	@override String get reopen_short => 'Reabrir';
	@override String get reopen => 'Reabrir cuenta';
	@override String get reopen_descr => '¿Seguro que quieres volver a abrir esta cuenta?';
	@override String get balance => 'Saldo de la cuenta';
	@override String get n_transactions => 'Número de transacciones';
	@override String get add_money => 'Añadir dinero';
	@override String get withdraw_money => 'Retirar dinero';
	@override String get no_accounts => 'No se han encontrado cuentas que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
	@override late final _TranslationsAccountTypesEs types = _TranslationsAccountTypesEs._(_root);
	@override late final _TranslationsAccountFormEs form = _TranslationsAccountFormEs._(_root);
	@override late final _TranslationsAccountDeleteEs delete = _TranslationsAccountDeleteEs._(_root);
	@override late final _TranslationsAccountCloseEs close = _TranslationsAccountCloseEs._(_root);
	@override late final _TranslationsAccountSelectEs select = _TranslationsAccountSelectEs._(_root);
}

// Path: currencies
class _TranslationsCurrenciesEs implements _TranslationsCurrenciesEn {
	_TranslationsCurrenciesEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Conversor de divisas';
	@override String get currency_manager => 'Administrador de divisas';
	@override String get currency_manager_descr => 'Configura tu divisa y sus tipos de cambio con otras';
	@override String get currency => 'Divisa';
	@override String get preferred_currency => 'Divisa predeterminada/base';
	@override String get change_preferred_currency_title => 'Cambiar divisa predeterminada';
	@override String get change_preferred_currency_msg => 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
	@override late final _TranslationsCurrenciesFormEs form = _TranslationsCurrenciesFormEs._(_root);
	@override String get delete_all_success => 'Tipos de cambio borrados con exito';
	@override String get historical => 'Histórico de tasas';
	@override String get exchange_rate => 'Tipo de cambio';
	@override String get exchange_rates => 'Tipos de cambio';
	@override String get empty => 'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos';
	@override String get select_a_currency => 'Selecciona una divisa';
	@override String get search => 'Busca por nombre o por código de la divisa';
}

// Path: tags
class _TranslationsTagsEs implements _TranslationsTagsEn {
	_TranslationsTagsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Etiqueta',
		other: 'Etiquetas',
	);
	@override late final _TranslationsTagsFormEs form = _TranslationsTagsFormEs._(_root);
	@override late final _TranslationsTagsSelectEs select = _TranslationsTagsSelectEs._(_root);
	@override String get empty_list => 'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos';
	@override String get without_tags => 'Sin etiquetas';
	@override String get create => 'Crear etiqueta';
	@override String get add => 'Añadir etiqueta';
	@override String get create_success => 'Etiqueta creada correctamente';
	@override String get already_exists => 'El nombre de esta etiqueta ya existe. Puede que quieras editarla';
	@override String get edit => 'Editar etiqueta';
	@override String get edit_success => 'Etiqueta editada correctamente';
	@override String get delete_success => 'Categoría eliminada correctamente';
	@override String get delete_warning_header => '¿Eliminar etiqueta?';
	@override String get delete_warning_message => 'Esta acción no borrará las transacciones que poseen esta etiqueta.';
}

// Path: categories
class _TranslationsCategoriesEs implements _TranslationsCategoriesEn {
	_TranslationsCategoriesEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Categoría desconocida';
	@override String get create => 'Crear categoría';
	@override String get create_success => 'Categoría creada correctamente';
	@override String get new_category => 'Nueva categoría';
	@override String get already_exists => 'El nombre de esta categoría ya existe. Puede que quieras editarla';
	@override String get edit => 'Editar categoría';
	@override String get edit_success => 'Categoría editada correctamente';
	@override String get name => 'Nombre de la categoría';
	@override String get type => 'Tipo de categoría';
	@override String get both_types => 'Ambos tipos';
	@override String get subcategories => 'Subcategorías';
	@override String get subcategories_add => 'Añadir subcategoría';
	@override String get make_parent => 'Convertir en categoría';
	@override String get make_child => 'Convertir en subcategoría';
	@override String make_child_warning1({required Object destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.';
	@override String get make_child_success => 'Subcategorías creadas con exito';
	@override String get merge => 'Fusionar con otra categoría';
	@override String merge_warning1({required Object x, required Object from, required Object destiny}) => 'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.';
	@override String merge_warning2({required Object from}) => 'La categoría <b>${from}</b> será eliminada de forma irreversible.';
	@override String get merge_success => 'Categoría fusionada correctamente';
	@override String get delete_success => 'Categoría eliminada correctamente';
	@override String get delete_warning_header => '¿Eliminar categoría?';
	@override String delete_warning_message({required Object x}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.';
	@override late final _TranslationsCategoriesSelectEs select = _TranslationsCategoriesSelectEs._(_root);
}

// Path: budgets
class _TranslationsBudgetsEs implements _TranslationsBudgetsEn {
	_TranslationsBudgetsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Presupuestos';
	@override String get repeated => 'Periódicos';
	@override String get one_time => 'Una vez';
	@override String get annual => 'Anuales';
	@override String get week => 'Semanales';
	@override String get month => 'Mensuales';
	@override String get actives => 'Activos';
	@override String get pending => 'Pendientes de comenzar';
	@override String get finish => 'Finalizados';
	@override String get from_budgeted => 'De un total de ';
	@override String get days_left => 'días restantes';
	@override String get days_to_start => 'días para empezar';
	@override String get since_expiration => 'días desde su expiración';
	@override String get no_budgets => 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
	@override String get delete => 'Eliminar presupuesto';
	@override String get delete_warning => 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
	@override late final _TranslationsBudgetsFormEs form = _TranslationsBudgetsFormEs._(_root);
	@override late final _TranslationsBudgetsDetailsEs details = _TranslationsBudgetsDetailsEs._(_root);
}

// Path: backup
class _TranslationsBackupEs implements _TranslationsBackupEn {
	_TranslationsBackupEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportEs export = _TranslationsBackupExportEs._(_root);
	@override late final _TranslationsBackupImportEs import = _TranslationsBackupImportEs._(_root);
	@override late final _TranslationsBackupAboutEs about = _TranslationsBackupAboutEs._(_root);
}

// Path: settings
class _TranslationsSettingsEs implements _TranslationsSettingsEn {
	_TranslationsSettingsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Configuración y apariencia';
	@override String get title_short => 'Configuración';
	@override String get description => 'Tema de la aplicación, textos y otras configuraciones generales';
	@override String get edit_profile => 'Editar perfil';
	@override String get lang_section => 'Idioma y textos';
	@override String get lang_title => 'Idioma de la aplicación';
	@override String get lang_descr => 'Idioma en el que se mostrarán los textos en la aplicación';
	@override String get lang_help => 'Si quieres colaborar con las traducciones de esta app puedes consultar <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>nuestra guía</a> ';
	@override String get locale => 'Región';
	@override String get locale_descr => 'Establecer el formato a utilizar para fechas, números...';
	@override String get locale_warn => 'Al cambiar la región, la aplicación se actualizará';
	@override String get first_day_of_week => 'Primer día de la semana';
	@override String get theme_and_colors => 'Tema y colores';
	@override String get theme => 'Tema';
	@override String get theme_auto => 'Definido por el sistema';
	@override String get theme_light => 'Claro';
	@override String get theme_dark => 'Oscuro';
	@override String get amoled_mode => 'Modo AMOLED';
	@override String get amoled_mode_descr => 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
	@override String get dynamic_colors => 'Colores dinámicos';
	@override String get dynamic_colors_descr => 'Usar el color de acento de su sistema siempre que sea posible';
	@override String get accent_color => 'Color de acento';
	@override String get accent_color_descr => 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
	@override late final _TranslationsSettingsSecurityEs security = _TranslationsSettingsSecurityEs._(_root);
}

// Path: more
class _TranslationsMoreEs implements _TranslationsMoreEn {
	_TranslationsMoreEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Más';
	@override String get title_long => 'Más acciones';
	@override late final _TranslationsMoreDataEs data = _TranslationsMoreDataEs._(_root);
	@override late final _TranslationsMoreAboutUsEs about_us = _TranslationsMoreAboutUsEs._(_root);
	@override late final _TranslationsMoreHelpUsEs help_us = _TranslationsMoreHelpUsEs._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardEs implements _TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} copiado al portapapeles';
	@override String get error => 'Error al copiar';
}

// Path: general.time
class _TranslationsGeneralTimeEs implements _TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Fecha de inicio';
	@override String get end_date => 'Fecha de fin';
	@override String get from_date => 'Desde fecha';
	@override String get until_date => 'Hasta fecha';
	@override String get date => 'Fecha';
	@override String get datetime => 'Fecha y hora';
	@override String get time => 'Hora';
	@override String get each => 'Cada';
	@override String get after => 'Tras';
	@override late final _TranslationsGeneralTimeRangesEs ranges = _TranslationsGeneralTimeRangesEs._(_root);
	@override late final _TranslationsGeneralTimePeriodicityEs periodicity = _TranslationsGeneralTimePeriodicityEs._(_root);
	@override late final _TranslationsGeneralTimeCurrentEs current = _TranslationsGeneralTimeCurrentEs._(_root);
	@override late final _TranslationsGeneralTimeAllEs all = _TranslationsGeneralTimeAllEs._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderEs implements _TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ordenar transacciones';
	@override String get category => 'Por categoría';
	@override String get quantity => 'Por cantidad';
	@override String get date => 'Por fecha';
}

// Path: general.validations
class _TranslationsGeneralValidationsEs implements _TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Corrije los campos indicados en el formulario para continuar';
	@override String get required => 'Campo obligatorio';
	@override String get positive => 'Debe ser positivo';
	@override String min_number({required Object x}) => 'Debe ser mayor que ${x}';
	@override String max_number({required Object x}) => 'Debe ser menor que ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewEs implements _TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Excelente!';
			case GenderContext.female:
				return 'Excelente!';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Bueno';
			case GenderContext.female:
				return 'Buena';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'En la media';
			case GenderContext.female:
				return 'En la media';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Regular';
			case GenderContext.female:
				return 'Regular';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Muy malo';
			case GenderContext.female:
				return 'Muy mala';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Datos insuficientes';
			case GenderContext.female:
				return 'Datos insuficientes';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrEs descr = _TranslationsFinancialHealthReviewDescrEs._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeEs implements _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ratio de supervivencia';
	@override String get subtitle => 'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos';
	@override String get text_zero => '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!';
	@override String get text_one => '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!';
	@override String text_other({required Object n}) => 'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.';
	@override String get text_infinite => 'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.';
	@override String get suggestion => 'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.';
	@override String get insufficient_data => 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageEs implements _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Porcentaje de ahorro';
	@override String get subtitle => 'Que parte de tus ingresos no son gastados en este periodo';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextEs text = _TranslationsFinancialHealthSavingsPercentageTextEs._(_root);
	@override String get suggestion => 'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesEs implements _TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Transporte';
	@override String get money => 'Dinero';
	@override String get food => 'Comida';
	@override String get medical => 'Salud';
	@override String get entertainment => 'Entretenimiento';
	@override String get technology => 'Technología';
	@override String get other => 'Otros';
	@override String get logos_financial_institutions => 'Financial institutions';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsEs implements _TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Saltar';
	@override String get skip_success => 'Transacción saltada con exito';
	@override String get skip_dialog_title => 'Saltar transacción';
	@override String skip_dialog_msg({required Object date}) => 'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}';
	@override String get accept => 'Aceptar';
	@override String get accept_today => 'Aceptar hoy';
	@override String accept_in_required_date({required Object date}) => 'Aceptar en la fecha requerida (${date})';
	@override String get accept_dialog_title => 'Aceptar transacción';
	@override String get accept_dialog_msg_single => 'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees';
	@override String accept_dialog_msg({required Object date}) => 'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones';
	@override String get recurrent_rule_finished => 'La regla recurrente se ha completado, ya no hay mas pagos a realizar!';
}

// Path: transaction.list
class _TranslationsTransactionListEs implements _TranslationsTransactionListEn {
	_TranslationsTransactionListEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get empty => 'No se han encontrado transacciones que mostrar aquí. Añade unas cuantas transacciones en la app y quizas tengas más suerte la proxima vez';
	@override String get searcher_placeholder => 'Busca por categoría, descripción...';
	@override String get searcher_no_results => 'No se han encontrado transacciones que coincidan con los criterios de busqueda';
	@override String get loading => 'Cargando más transacciones...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} seleccionada',
		other: '${n} seleccionadas',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} transacción seleccionada',
		other: '${n} transacciones seleccionadas',
	);
	@override late final _TranslationsTransactionListBulkEditEs bulk_edit = _TranslationsTransactionListBulkEditEs._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersEs implements _TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get from_value => 'Desde monto';
	@override String get to_value => 'Hasta monto';
	@override String from_value_def({required Object x}) => 'Desde ${x}';
	@override String to_value_def({required Object x}) => 'Hasta ${x}';
	@override String from_date_def({required Object date}) => 'Desde el ${date}';
	@override String to_date_def({required Object date}) => 'Hasta el ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormEs implements _TranslationsTransactionFormEn {
	_TranslationsTransactionFormEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsEs validators = _TranslationsTransactionFormValidatorsEs._(_root);
	@override String get title => 'Título de la transacción';
	@override String get title_short => 'Título';
	@override String get no_tags => '-- Sin etiquetas --';
	@override String get value => 'Valor de la transacción';
	@override String get tap_to_see_more => 'Toca para ver más detalles';
	@override String get description => 'Descripción';
	@override String get description_info => 'Toca aquí para escribir una descripción mas detallada sobre esta transacción';
	@override String exchange_to_preferred_title({required Object currency}) => 'Cambio a ${currency}';
	@override String get exchange_to_preferred_in_date => 'El día de la transacción';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedEs implements _TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transacción invertida';
	@override String get title_short => 'Tr. invertida';
	@override String get description_for_expenses => 'A pesar de ser una transacción de tipo gasto, esta transacción tiene un monto positivo. Este tipo de transacciones pueden usarse para representar la devolución de un gasto previamente registrado, como un reembolso o que te realicen el pago de una deuda.';
	@override String get description_for_incomes => 'A pesar de ser una transacción de tipo ingreso, esta transacción tiene un monto negativo. Este tipo de transacciones pueden usarse para anular o corregir un ingreso que fue registrado incorrectamente, para reflejar una devolución o reembolso de dinero o para registrar el pago de deudas.';
}

// Path: transaction.status
class _TranslationsTransactionStatusEs implements _TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Estado',
		other: 'Estados',
	);
	@override String get display_long => 'Estado de la transacción';
	@override String tr_status({required Object status}) => 'Transacción ${status}';
	@override String get none => 'Sin estado';
	@override String get none_descr => 'Transacción sin un estado concreto';
	@override String get reconciled => 'Reconciliada';
	@override String get reconciled_descr => 'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco';
	@override String get unreconciled => 'No reconciliada';
	@override String get unreconciled_descr => 'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin';
	@override String get pending => 'Pendiente';
	@override String get pending_descr => 'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas';
	@override String get voided => 'Nula';
	@override String get voided_descr => 'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas';
}

// Path: transaction.types
class _TranslationsTransactionTypesEs implements _TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Tipo de transacción',
		other: 'Tipos de transacción',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Ingreso',
		other: 'Ingresos',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Gasto',
		other: 'Gastos',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Transferencia',
		other: 'Transferencias',
	);
}

// Path: transfer.form
class _TranslationsTransferFormEs implements _TranslationsTransferFormEn {
	_TranslationsTransferFormEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get from => 'Cuenta origen';
	@override String get to => 'Cuenta destino';
	@override late final _TranslationsTransferFormValueInDestinyEs value_in_destiny = _TranslationsTransferFormValueInDestinyEs._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsEs implements _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaccion recurrente';
	@override String get descr => 'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento';
	@override String get last_payment_info => 'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción';
	@override String get delete_header => 'Eliminar transacción recurrente';
	@override String get delete_message => 'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusEs implements _TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Atrasado por ${x}d';
	@override String coming_in({required Object x}) => 'En ${x} días';
}

// Path: account.types
class _TranslationsAccountTypesEs implements _TranslationsAccountTypesEn {
	_TranslationsAccountTypesEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tipo de cuenta';
	@override String get warning => 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
	@override String get normal => 'Cuenta corriente';
	@override String get normal_descr => 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
	@override String get saving => 'Cuenta de ahorros';
	@override String get saving_descr => 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
}

// Path: account.form
class _TranslationsAccountFormEs implements _TranslationsAccountFormEn {
	_TranslationsAccountFormEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre de la cuenta';
	@override String get name_placeholder => 'Ej: Cuenta de ahorros';
	@override String get notes => 'Notas';
	@override String get notes_placeholder => 'Escribe algunas notas/descripciones sobre esta cuenta';
	@override String get initial_balance => 'Balance inicial';
	@override String get current_balance => 'Balance actual';
	@override String get create => 'Crear cuenta';
	@override String get edit => 'Editar cuenta';
	@override String get tr_before_opening_date => 'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura';
	@override String get currency_not_found_warn => 'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes';
	@override String get already_exists => 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteEs implements _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get warning_header => '¿Eliminar cuenta?';
	@override String get warning_text => 'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.';
	@override String get success => 'Cuenta eliminada correctamente';
}

// Path: account.close
class _TranslationsAccountCloseEs implements _TranslationsAccountCloseEn {
	_TranslationsAccountCloseEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cerrar cuenta';
	@override String get title_short => 'Cerrar';
	@override String get warn => 'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras';
	@override String get should_have_zero_balance => 'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar';
	@override String get should_have_no_transactions => 'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar';
	@override String get success => 'Cuenta cerrada exitosamente';
	@override String get unarchive_succes => 'Cuenta re-abierta exitosamente';
}

// Path: account.select
class _TranslationsAccountSelectEs implements _TranslationsAccountSelectEn {
	_TranslationsAccountSelectEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get one => 'Selecciona una cuenta';
	@override String get multiple => 'Selecciona cuentas';
	@override String get all => 'Todas las cuentas';
}

// Path: currencies.form
class _TranslationsCurrenciesFormEs implements _TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'The currency can not be equal to the user currency';
	@override String get specify_a_currency => 'Por favor, especifica una divisa';
	@override String get add => 'Añadir tipo de cambio';
	@override String get add_success => 'Tipo de cambio añadido correctamente';
	@override String get edit => 'Editar tipo de cambio';
	@override String get edit_success => 'Tipo de cambio editado correctamente';
}

// Path: tags.form
class _TranslationsTagsFormEs implements _TranslationsTagsFormEn {
	_TranslationsTagsFormEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre de la etiqueta';
	@override String get description => 'Descripción';
}

// Path: tags.select
class _TranslationsTagsSelectEs implements _TranslationsTagsSelectEn {
	_TranslationsTagsSelectEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecciona etiquetas';
	@override String get all => 'Todas las etiquetas';
}

// Path: categories.select
class _TranslationsCategoriesSelectEs implements _TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecciona categorías';
	@override String get select_one => 'Selecciona una categoría';
	@override String get select_subcategory => 'Elige una subcategoría';
	@override String get without_subcategory => 'Sin subcategoría';
	@override String get all => 'Todas las categorías';
	@override String get all_short => 'Todas';
}

// Path: budgets.form
class _TranslationsBudgetsFormEs implements _TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Añade un presupuesto';
	@override String get name => 'Nombre del presupuesto';
	@override String get value => 'Cantidad límite';
	@override String get create => 'Añade el presupuesto';
	@override String get edit => 'Editar presupuesto';
	@override String get negative_warn => 'Los presupuestos no pueden tener un valor límite negativo';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsEs implements _TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles del presupuesto';
	@override String get budget_value => 'Presupuestado';
	@override String get statistics => 'Estadísticas';
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Puedes gastar ${dailyAmount}/día por los ${remainingDays} días restantes';
	@override String get expend_evolution => 'Evolución del gasto';
	@override String get no_transactions => 'Parece que no has realizado ningún gasto relativo a este presupuesto';
}

// Path: backup.export
class _TranslationsBackupExportEs implements _TranslationsBackupExportEn {
	_TranslationsBackupExportEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exportar datos';
	@override String get title_short => 'Exportar';
	@override String get all => 'Respaldo total';
	@override String get all_descr => 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
	@override String get transactions => 'Respaldo de transacciones';
	@override String get transactions_descr => 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
	@override String get description => 'Exporta tus datos en diferentes formatos';
	@override String get dialog_title => 'Guardar/Enviar archivo';
	@override String success({required Object x}) => 'Archivo guardado/enviado correctamente en ${x}';
	@override String get error => 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportEs implements _TranslationsBackupImportEn {
	_TranslationsBackupImportEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importar tus datos';
	@override String get title_short => 'Importar';
	@override String get restore_backup => 'Restaurar copia de seguridad';
	@override String get restore_backup_descr => 'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos';
	@override String get restore_backup_warn_title => 'Sobreescribir todos los datos';
	@override String get restore_backup_warn_description => 'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin';
	@override String get tap_to_select_file => 'Pulsa para seleccionar un archivo';
	@override String get select_other_file => 'Selecciona otro fichero';
	@override late final _TranslationsBackupImportManualImportEs manual_import = _TranslationsBackupImportManualImportEs._(_root);
	@override String get success => 'Importación realizada con exito';
	@override String get cancelled => 'La importación fue cancelada por el usuario';
	@override String get error => 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutEs implements _TranslationsBackupAboutEn {
	_TranslationsBackupAboutEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Información sobre tu base de datos';
	@override String get create_date => 'Fecha de creación';
	@override String get modify_date => 'Última modificación';
	@override String get last_backup => 'Última copia de seguridad';
	@override String get size => 'Tamaño';
}

// Path: settings.security
class _TranslationsSettingsSecurityEs implements _TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seguridad';
	@override String get private_mode_at_launch => 'Modo privado al arrancar';
	@override String get private_mode_at_launch_descr => 'Arranca la app en modo privado por defecto';
	@override String get private_mode => 'Modo privado';
	@override String get private_mode_descr => 'Oculta todos los valores monetarios';
	@override String get private_mode_activated => 'Modo privado activado';
	@override String get private_mode_deactivated => 'Modo privado desactivado';
}

// Path: more.data
class _TranslationsMoreDataEs implements _TranslationsMoreDataEn {
	_TranslationsMoreDataEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Datos';
	@override String get display_descr => 'Exporta y importa tus datos para no perder nada';
	@override String get delete_all => 'Eliminar mis datos';
	@override String get delete_all_header1 => 'Alto ahí padawan ⚠️⚠️';
	@override String get delete_all_message1 => '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
	@override String get delete_all_header2 => 'Un último paso ⚠️⚠️';
	@override String get delete_all_message2 => 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsEs implements _TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Información de la app';
	@override String get description => 'Consulta los terminos y otra información relevante sobre Monekin. Ponte en contacto con la comunidad reportando errores, dejando sugerencias...';
	@override late final _TranslationsMoreAboutUsLegalEs legal = _TranslationsMoreAboutUsLegalEs._(_root);
	@override late final _TranslationsMoreAboutUsProjectEs project = _TranslationsMoreAboutUsProjectEs._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsEs implements _TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ayúdanos';
	@override String get description => 'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor';
	@override String get rate_us => 'Califícanos';
	@override String get rate_us_descr => '¡Cualquier valoración es bienvenida!';
	@override String get share => 'Comparte Monekin';
	@override String get share_descr => 'Comparte nuestra app a amigos y familiares';
	@override String get share_text => 'Monekin! La mejor app de finanzas personales. Descargala aquí';
	@override String get thanks => '¡Gracias!';
	@override String get thanks_long => 'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.';
	@override String get donate => 'Haz una donación';
	@override String get donate_descr => 'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?';
	@override String get donate_success => 'Donación realizada. Muchas gracias por tu contribución! ❤️';
	@override String get donate_err => 'Ups! Parece que ha habido un error a la hora de recibir tu pago';
	@override String get report => 'Reporta errores, deja sugerencias...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesEs implements _TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Rango temporal';
	@override String get it_repeat => 'Se repite';
	@override String get it_ends => 'Termina';
	@override late final _TranslationsGeneralTimeRangesTypesEs types = _TranslationsGeneralTimeRangesTypesEs._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range}',
		other: 'Cada ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range} hasta el ${day}',
		other: 'Cada ${n} ${range} hasta el ${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range} ${limit} veces',
		other: 'Cada ${n} ${range} ${limit} veces',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range} una vez',
		other: 'Cada ${n} ${range} una vez',
	);
	@override String get forever => 'Para siempre';
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Mes',
		other: 'Meses',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Año',
		other: 'Años',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Día',
		other: 'Días',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Semana',
		other: 'Semanas',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityEs implements _TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Periodicidad';
	@override String get no_repeat => 'Sin repetición';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Repetición',
		other: 'Repeticiones',
	);
	@override String get diary => 'Diaría';
	@override String get monthly => 'Mensual';
	@override String get annually => 'Anual';
	@override String get quaterly => 'Trimestral';
	@override String get weekly => 'Semanal';
	@override String get custom => 'Personalizado';
	@override String get infinite => 'Siempre';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentEs implements _TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Este día';
	@override String get monthly => 'Este mes';
	@override String get annually => 'Este año';
	@override String get quaterly => 'Este trimestre';
	@override String get weekly => 'Esta semana';
	@override String get infinite => 'Desde siempre';
	@override String get custom => 'Rango personalizado';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllEs implements _TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Todos los días';
	@override String get monthly => 'Todos los meses';
	@override String get annually => 'Todos los años';
	@override String get quaterly => 'Todos los trimestres';
	@override String get weekly => 'Todas las semanas';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrEs implements _TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!';
	@override String get very_good => 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
	@override String get good => 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
	@override String get normal => 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
	@override String get bad => 'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas';
	@override String get very_bad => 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextEs implements _TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!';
	@override String normal({required Object value}) => 'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.';
	@override String bad({required Object value}) => 'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!';
	@override String get very_bad => 'Vaya, no has conseguido ahorrar nada durante este periodo.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditEs implements _TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Editar fechas';
	@override String get categories => 'Editar categorías';
	@override String get status => 'Editar estados';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsEs implements _TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get zero => 'El valor de una transacción no puede ser igual a cero';
	@override String get date_max => 'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente';
	@override String get date_after_account_creation => 'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece';
	@override String get negative_transfer => 'El valor monetario de una transferencia no puede ser negativo';
	@override String get transfer_between_same_accounts => 'Las cuentas de origen y destino no pueden coincidir';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyEs implements _TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cantidad transferida en destino';
	@override String amount_short({required Object amount}) => '${amount} a cuenta de destino';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportEs implements _TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importación manual';
	@override String get descr => 'Importa transacciones desde un fichero .csv de forma manual';
	@override String get default_account => 'Cuenta por defecto';
	@override String get remove_default_account => 'Eliminar cuenta por defecto';
	@override String get default_category => 'Categoría por defecto';
	@override String get select_a_column => 'Selecciona una columna del .csv';
	@override String success({required Object x}) => 'Se han importado correctamente ${x} transacciones';
	@override List<String> get steps => [
		'Selecciona tu fichero',
		'Columna para la cantidad',
		'Columna para la cuenta',
		'Columna para la categoría',
		'Columna para la fecha',
		'Otras columnas',
	];
	@override List<String> get steps_descr => [
		'Selecciona un fichero .csv de tu dispositivo. Asegurate de que este tenga una primera fila que describa el nombre de cada columna',
		'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos. Usa un punto como separador decimal',
		'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre',
		'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar',
		'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual',
		'Especifica las columnas para otros atributos optativos de las transacciones',
	];
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalEs implements _TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Información legal';
	@override String get privacy => 'Política de privacidad';
	@override String get terms => 'Términos de uso';
	@override String get licenses => 'Licencias';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectEs implements _TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Proyecto';
	@override String get contributors => 'Colaboradores';
	@override String get contributors_descr => 'Todos los desarrolladores que han hecho que Monekin crezca';
	@override String get contact => 'Contacta con nosotros';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesEs implements _TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesEs._(this._root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Ciclos';
	@override String get last_days => 'Últimos días';
	@override String last_days_form({required Object x}) => '${x} días anteriores';
	@override String get all => 'Siempre';
	@override String get date_range => 'Rango personalizado';
}

// Path: <root>
class _TranslationsHu implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsHu.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.hu,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <hu>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsHu _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsGeneralHu general = _TranslationsGeneralHu._(_root);
	@override late final _TranslationsIntroHu intro = _TranslationsIntroHu._(_root);
	@override late final _TranslationsHomeHu home = _TranslationsHomeHu._(_root);
	@override late final _TranslationsFinancialHealthHu financial_health = _TranslationsFinancialHealthHu._(_root);
	@override late final _TranslationsStatsHu stats = _TranslationsStatsHu._(_root);
	@override late final _TranslationsIconSelectorHu icon_selector = _TranslationsIconSelectorHu._(_root);
	@override late final _TranslationsTransactionHu transaction = _TranslationsTransactionHu._(_root);
	@override late final _TranslationsTransferHu transfer = _TranslationsTransferHu._(_root);
	@override late final _TranslationsRecurrentTransactionsHu recurrent_transactions = _TranslationsRecurrentTransactionsHu._(_root);
	@override late final _TranslationsAccountHu account = _TranslationsAccountHu._(_root);
	@override late final _TranslationsCurrenciesHu currencies = _TranslationsCurrenciesHu._(_root);
	@override late final _TranslationsTagsHu tags = _TranslationsTagsHu._(_root);
	@override late final _TranslationsCategoriesHu categories = _TranslationsCategoriesHu._(_root);
	@override late final _TranslationsBudgetsHu budgets = _TranslationsBudgetsHu._(_root);
	@override late final _TranslationsBackupHu backup = _TranslationsBackupHu._(_root);
	@override late final _TranslationsSettingsHu settings = _TranslationsSettingsHu._(_root);
	@override late final _TranslationsMoreHu more = _TranslationsMoreHu._(_root);
}

// Path: general
class _TranslationsGeneralHu implements _TranslationsGeneralEn {
	_TranslationsGeneralHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Magyar';
	@override String get or => 'vagy';
	@override String get understood => 'Megértve';
	@override String get unspecified => 'Meghatározatlan';
	@override String get confirm => 'Megerősítés';
	@override String get continue_text => 'Folytatás';
	@override String get quick_actions => 'Gyorsműveletek';
	@override String get save => 'Mentés';
	@override String get save_changes => 'Módosítások mentése';
	@override String get close_and_save => 'Mentés és bezárás';
	@override String get add => 'Hozzáad';
	@override String get edit => 'Szerkesztés';
	@override String get balance => 'Egyenleg';
	@override String get delete => 'Törlés';
	@override String get account => 'Számla';
	@override String get accounts => 'Számlák';
	@override String get categories => 'Kategóriák';
	@override String get category => 'Kategória';
	@override String get today => 'Ma';
	@override String get yesterday => 'Tegnap';
	@override String get filters => 'Szűrők';
	@override String get see_more => 'Továbbiak';
	@override String get select_all => 'Összes kijelölése';
	@override String get deselect_all => 'Egyiket sem';
	@override String get empty_warn => 'Hoppá! Ez nagyon üres.';
	@override String get insufficient_data => 'Hiányos adatok';
	@override String get show_more_fields => 'Több mező mutatása';
	@override String get show_less_fields => 'Kevesebb mező mutatása';
	@override String get tap_to_search => 'Koppintson a kereséshez';
	@override late final _TranslationsGeneralClipboardHu clipboard = _TranslationsGeneralClipboardHu._(_root);
	@override late final _TranslationsGeneralTimeHu time = _TranslationsGeneralTimeHu._(_root);
	@override late final _TranslationsGeneralTransactionOrderHu transaction_order = _TranslationsGeneralTransactionOrderHu._(_root);
	@override late final _TranslationsGeneralValidationsHu validations = _TranslationsGeneralValidationsHu._(_root);
}

// Path: intro
class _TranslationsIntroHu implements _TranslationsIntroEn {
	_TranslationsIntroHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get start => 'Kezdés';
	@override String get skip => 'Kihagyás';
	@override String get next => 'Tovább';
	@override String get select_your_currency => 'Válassza ki a pénznemet';
	@override String get welcome_subtitle => 'Az Ön személyes pénzügyi menedzsere';
	@override String get welcome_subtitle2 => '100% -ban nyitott, és 100% -ban ingyenes';
	@override String get welcome_footer => 'A bejelentkezéssel elfogadja az <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Adatvédelmi irányelveket</a> és az alkalmazás <a href=\' https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Felhasználási feltételeit</a>';
	@override String get offline_descr_title => 'OFFLINE SZÁMLA:';
	@override String get offline_descr => 'Az Ön adatai csak az Ön készülékén tárolódnak, és biztonságban lesznek, amíg nem távolítja el az alkalmazást, vagy nem cseréli le a telefont. Az adatvesztés megelőzése érdekében ajánlott rendszeresen biztonsági mentést készíteni az alkalmazás beállításaiból.';
	@override String get offline_start => 'Offline munkamenet indítása';
	@override String get sl1_title => 'Válassza ki a pénznemet';
	@override String get sl1_descr => 'Az alapértelmezett pénznemet a jelentésekben és az általános diagramokban használjuk. A pénznemet és az alkalmazás nyelvét később bármikor megváltoztathatja az alkalmazás beállításaiban.';
	@override String get sl2_title => 'Biztonságos, privát és megbízható';
	@override String get sl2_descr => 'Az Ön adatai csak az Önéi. Az adatokat közvetlenül az Ön eszközén tároljuk, anélkül, hogy azok külső szervereken keresztül mennének át. Ez lehetővé teszi az alkalmazás használatát internet nélkül is.';
	@override String get sl2_descr2 => 'Az alkalmazás forráskódja is nyilvános, így bárki közreműködhet benne, és megnézheti, hogyan is működik.';
	@override String get last_slide_title => 'Minden kész';
	@override String get last_slide_descr => 'A Monekin segítségével végre elérheti azt az anyagi függetlenséget, amelyre annyira vágyik. Grafikonok, költségvetések, tippek, statisztikák és még sok minden más lesz megtalálható a pénzével kapcsolatban.';
	@override String get last_slide_descr2 => 'Reméljük, hogy élvezni fogja az élményt! Ne habozzon kapcsolatba lépni velünk, ha kétségei, javaslatai vannak...';
}

// Path: home
class _TranslationsHomeHu implements _TranslationsHomeEn {
	_TranslationsHomeHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kezdőlap';
	@override String get filter_transactions => 'Tranzakciók szűrése';
	@override String get hello_day => 'Jó reggelt,';
	@override String get hello_night => 'Jó éjszakát,';
	@override String get total_balance => 'Teljes egyenleg';
	@override String get my_accounts => 'Saját számláim';
	@override String get active_accounts => 'Aktív számlák';
	@override String get no_accounts => 'Még nincsenek számlák létrehozva';
	@override String get no_accounts_descr => 'Kezdje el élvezni a Monekin összes varázsát. A tranzakciók hozzáadásához legalább egy számlát hozzon létre.';
	@override String get last_transactions => 'Legutóbbi tranzakciók';
	@override String get should_create_account_header => 'Hoppá!';
	@override String get should_create_account_message => 'A tranzakciók létrehozásához legalább egy nem archivált számlával kell rendelkeznie';
}

// Path: financial_health
class _TranslationsFinancialHealthHu implements _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Pénzügyi állapot';
	@override late final _TranslationsFinancialHealthReviewHu review = _TranslationsFinancialHealthReviewHu._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeHu months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeHu._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageHu savings_percentage = _TranslationsFinancialHealthSavingsPercentageHu._(_root);
}

// Path: stats
class _TranslationsStatsHu implements _TranslationsStatsEn {
	_TranslationsStatsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statisztika';
	@override String get balance => 'Egyenleg';
	@override String get final_balance => 'Végső egyenleg';
	@override String get balance_by_account => 'Számlák szerinti egyenleg';
	@override String get balance_by_account_subtitle => 'Hol van a legtöbb pénzem?';
	@override String get balance_by_currency => 'Egyenleg pénznemenként';
	@override String get balance_by_currency_subtitle => 'Mennyi pénzem van devizában?';
	@override String get balance_evolution => 'Egyenleg alakulása';
	@override String get balance_evolution_subtitle => 'Több pénzem van, mint korábban?';
	@override String get compared_to_previous_period => 'Az előző időszakhoz képest';
	@override String get cash_flow => 'Pénzforgalom';
	@override String get cash_flow_subtitle => 'Kevesebbet költök, mint amennyit megkeresek?';
	@override String get by_periods => 'Időszakonként';
	@override String get by_categories => 'Kategóriánként';
	@override String get by_tags => 'Címkék szerint';
	@override String get distribution => 'Megoszlás';
	@override String get finance_health_resume => 'Folytatás';
	@override String get finance_health_breakdown => 'Csőd';
}

// Path: icon_selector
class _TranslationsIconSelectorHu implements _TranslationsIconSelectorEn {
	_TranslationsIconSelectorHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Név:';
	@override String get icon => 'Ikon';
	@override String get color => 'Szín';
	@override String get select_icon => 'Ikon kiválasztása';
	@override String get select_color => 'Szín kiválasztása';
	@override String get custom_color => 'Egyedi szín';
	@override String get current_color_selection => 'Jelenlegi kiválasztás';
	@override String get select_account_icon => 'Számla azonosítása';
	@override String get select_category_icon => 'Kategória azonosítása';
	@override late final _TranslationsIconSelectorScopesHu scopes = _TranslationsIconSelectorScopesHu._(_root);
}

// Path: transaction
class _TranslationsTransactionHu implements _TranslationsTransactionEn {
	_TranslationsTransactionHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Tranzakció',
		other: 'Tranzakciók',
	);
	@override String get create => 'Új tranzakció';
	@override String get new_income => 'Új bevétel';
	@override String get new_expense => 'Új kiadás';
	@override String get new_success => 'A tranzakció sikeresen létrehozva';
	@override String get edit => 'Tranzakció szerkesztése';
	@override String get edit_success => 'A tranzakció sikeresen szerkesztve';
	@override String get edit_multiple => 'Tranzakciók szerkesztése';
	@override String edit_multiple_success({required Object x}) => '${x} tranzakció sikeresen szerkesztve';
	@override String get duplicate => 'Tranzakció klónozása';
	@override String get duplicate_short => 'Klónozás';
	@override String get duplicate_warning_message => 'Egy ezzel megegyező tranzakció jön létre ugyanazzal a dátummal, folytatni szeretné?';
	@override String get duplicate_success => 'A tranzakció sikeresen klónozva';
	@override String get delete => 'Tranzakció törlése';
	@override String get delete_warning_message => 'Ez a művelet visszafordíthatatlan. A számlák aktuális egyenlege és az összes statisztikája újraszámításra kerül.';
	@override String get delete_success => 'A tranzakció sikeresen törölve';
	@override String get delete_multiple => 'Tranzakciók törlése';
	@override String delete_multiple_warning_message({required Object x}) => 'Ez a művelet visszafordíthatatlan, és eltávolít ${x} tranzakciót. A számlái aktuális egyenlege és minden statisztikája újraszámításra kerül.';
	@override String delete_multiple_success({required Object x}) => '${x} tranzakció megfelelően törölve';
	@override String get details => 'A mozgás részletei';
	@override late final _TranslationsTransactionNextPaymentsHu next_payments = _TranslationsTransactionNextPaymentsHu._(_root);
	@override late final _TranslationsTransactionListHu list = _TranslationsTransactionListHu._(_root);
	@override late final _TranslationsTransactionFiltersHu filters = _TranslationsTransactionFiltersHu._(_root);
	@override late final _TranslationsTransactionFormHu form = _TranslationsTransactionFormHu._(_root);
	@override late final _TranslationsTransactionReversedHu reversed = _TranslationsTransactionReversedHu._(_root);
	@override late final _TranslationsTransactionStatusHu status = _TranslationsTransactionStatusHu._(_root);
	@override late final _TranslationsTransactionTypesHu types = _TranslationsTransactionTypesHu._(_root);
}

// Path: transfer
class _TranslationsTransferHu implements _TranslationsTransferEn {
	_TranslationsTransferHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Áthelyezés';
	@override String get transfers => 'Áthelyezések';
	@override String transfer_to({required Object account}) => 'Áthelyezés ide: ${account}';
	@override String get create => 'Új átvitel';
	@override String get need_two_accounts_warning_header => 'Hoppá!';
	@override String get need_two_accounts_warning_message => 'A művelet végrehajtásához legalább kettő számlára van szükség. Ha módosítani vagy szerkeszteni szeretné a számla aktuális egyenlegét, kattintson a szerkesztés gombra.';
	@override late final _TranslationsTransferFormHu form = _TranslationsTransferFormHu._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsHu implements _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ismétlődő tranzakciók';
	@override String get title_short => 'Ism. tranzakciók';
	@override String get empty => 'Úgy tűnik, hogy nincsenek ismétlődő tranzakciói. Hozzon létre havi, éves vagy heti ismétlődő tranzakciót, és az itt fog megjelenni.';
	@override String get total_expense_title => 'Összes kiadás periódusonként';
	@override String get total_expense_descr => '* Az egyes ismétlődések kezdő és befejező időpontjának figyelembevétele nélkül';
	@override late final _TranslationsRecurrentTransactionsDetailsHu details = _TranslationsRecurrentTransactionsDetailsHu._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusHu status = _TranslationsRecurrentTransactionsStatusHu._(_root);
}

// Path: account
class _TranslationsAccountHu implements _TranslationsAccountEn {
	_TranslationsAccountHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get details => 'Számlaadatok';
	@override String get date => 'Megnyitás dátuma';
	@override String get close_date => 'Lezárás dátuma';
	@override String get reopen => 'Számla újranyitása';
	@override String get reopen_short => 'Újranyitás';
	@override String get reopen_descr => 'Biztos, hogy újra meg akarja nyitni ezt a számlát?';
	@override String get balance => 'Számlaegyenleg';
	@override String get n_transactions => 'Tranzakciók száma';
	@override String get add_money => 'Hozzáadás';
	@override String get withdraw_money => 'Pénzfelvétel';
	@override String get no_accounts => 'Nem található itt megjeleníthető tranzakció. Adjon hozzá egy tranzakciót az alul található „+” gombra kattintva.';
	@override late final _TranslationsAccountTypesHu types = _TranslationsAccountTypesHu._(_root);
	@override late final _TranslationsAccountFormHu form = _TranslationsAccountFormHu._(_root);
	@override late final _TranslationsAccountDeleteHu delete = _TranslationsAccountDeleteHu._(_root);
	@override late final _TranslationsAccountCloseHu close = _TranslationsAccountCloseHu._(_root);
	@override late final _TranslationsAccountSelectHu select = _TranslationsAccountSelectHu._(_root);
}

// Path: currencies
class _TranslationsCurrenciesHu implements _TranslationsCurrenciesEn {
	_TranslationsCurrenciesHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Valutaváltó';
	@override String get currency => 'Pénznem';
	@override String get currency_manager => 'Valutakezelő';
	@override String get currency_manager_descr => 'Konfigurálja a pénznemet és annak árfolyamait másokkal együtt';
	@override String get preferred_currency => 'Kedvelt/alap pénznem';
	@override String get change_preferred_currency_title => 'Kedvelt pénznem módosítása';
	@override String get change_preferred_currency_msg => 'Mostantól minden statisztika és költségvetés ebben a pénznemben jelenik meg. A számlák és tranzakciók megtartják a korábbi pénznemet. Minden elmentett árfolyam törlődik, ha ezt a műveletet végrehajtja. Szeretné folytatni?';
	@override late final _TranslationsCurrenciesFormHu form = _TranslationsCurrenciesFormHu._(_root);
	@override String get delete_all_success => 'Az árfolyamok sikeresen törlésre kerültek';
	@override String get historical => 'Árfolyamtörténetek';
	@override String get exchange_rate => 'Árfolyam';
	@override String get exchange_rates => 'Árfolyamok';
	@override String get empty => 'Adja hozzá az árfolyamokat, hogy ha az alapvalutától eltérő valutában vezetett számlái vannak, és így a grafikonok pontosabbak legyenek.';
	@override String get select_a_currency => 'Válasszon ki egy pénznemet';
	@override String get search => 'Keresés név vagy pénznemkód alapján';
}

// Path: tags
class _TranslationsTagsHu implements _TranslationsTagsEn {
	_TranslationsTagsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Felirat',
		other: 'Címkék',
	);
	@override late final _TranslationsTagsFormHu form = _TranslationsTagsFormHu._(_root);
	@override late final _TranslationsTagsSelectHu select = _TranslationsTagsSelectHu._(_root);
	@override String get empty_list => 'Még nem hozott létre címkéket. A címkék és kategóriák nagyszerű lehetőséget kínálnak a pénzmozgások kategorizálására.';
	@override String get without_tags => 'Címkék nélkül';
	@override String get add => 'Hozzáadás';
	@override String get create => 'Felirat készítése';
	@override String get create_success => 'A felirat sikeresen létrehozva';
	@override String get already_exists => 'Ez a címkenév már létezik. Érdemes lehet átszerkeszteni';
	@override String get edit => 'Címke szerkesztése';
	@override String get edit_success => 'A címke sikeresen szerkesztésre került';
	@override String get delete_success => 'A kategória sikeresen törölve';
	@override String get delete_warning_header => 'Törli a címkét?';
	@override String get delete_warning_message => 'Ez a művelet nem törli az ezzel a címkével rendelkező tranzakciókat.';
}

// Path: categories
class _TranslationsCategoriesHu implements _TranslationsCategoriesEn {
	_TranslationsCategoriesHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Ismeretlen kategória';
	@override String get create => 'Kategória létrehozása';
	@override String get create_success => 'A kategória sikeresen létrehozva';
	@override String get new_category => 'Új kategória';
	@override String get already_exists => 'Ez a kategórianév már létezik. Talán szeretné szerkeszteni?';
	@override String get edit => 'Kategória szerkesztése';
	@override String get edit_success => 'A kategória sikeresen szerkesztve lett';
	@override String get name => 'Kategória neve';
	@override String get type => 'Kategória típusa';
	@override String get both_types => 'Mindkét típus';
	@override String get subcategories => 'Alkategóriák';
	@override String get subcategories_add => 'Hozzáadás';
	@override String get make_parent => 'Kategória létrehozása';
	@override String get make_child => 'Alkategória létrehozása';
	@override String make_child_warning1({required Object destiny}) => 'Ez a kategória és alkategóriái a(z) <b>${destiny}</b> alkategóriái lesznek.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'A tranzakcióik <b>(${x})</b> átkerülnek a(z) <b>${destiny}</b> kategóriában létrehozott új alkategóriákba.';
	@override String get make_child_success => 'Az alkategóriák sikeresen létrehozva';
	@override String get merge => 'Összevonás másik kategóriával';
	@override String merge_warning1({required Object from, required Object x, required Object destiny}) => 'A(z) <b>${from}</b> kategóriához tartozó összes tranzakció (${x}) átkerül a(z) <b>${destiny}</b> kategóriába.';
	@override String merge_warning2({required Object from}) => 'A(z) <b>${from}</b> kategória visszafordíthatatlanul törlésre kerül.';
	@override String get merge_success => 'A kategória sikeresen egyesítve';
	@override String get delete_success => 'A kategória sikeresen törölve';
	@override String get delete_warning_header => 'Törli a kategóriát?';
	@override String delete_warning_message({required Object x}) => 'Ez a művelet visszafordíthatatlanul törli az összes <b>(${x})</b> tranzakciót, amely ehhez a kategóriához kapcsolódik.';
	@override late final _TranslationsCategoriesSelectHu select = _TranslationsCategoriesSelectHu._(_root);
}

// Path: budgets
class _TranslationsBudgetsHu implements _TranslationsBudgetsEn {
	_TranslationsBudgetsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Költségvetések';
	@override String get repeated => 'Ismétlődő';
	@override String get one_time => 'Egyszer';
	@override String get annual => 'Éves';
	@override String get week => 'Hetente';
	@override String get month => 'Havonta';
	@override String get actives => 'Aktívok';
	@override String get pending => 'Függőben lévő kezdés';
	@override String get finish => 'Kész';
	@override String get from_budgeted => 'maradt ';
	@override String get days_left => 'nap van hátra';
	@override String get days_to_start => 'nap van a kezdésig';
	@override String get since_expiration => 'napja lejárt';
	@override String get no_budgets => 'Úgy tűnik, hogy ebben a szakaszban nincs megjelenítendő költségvetés. Kezdje a költségvetés létrehozásával az alábbi gombra kattintva.';
	@override String get delete => 'Költségvetés törlése';
	@override String get delete_warning => 'Ez a művelet visszafordíthatatlan. Az erre az ajánlatra hivatkozó kategóriák és tranzakciók nem törlődnek.';
	@override late final _TranslationsBudgetsFormHu form = _TranslationsBudgetsFormHu._(_root);
	@override late final _TranslationsBudgetsDetailsHu details = _TranslationsBudgetsDetailsHu._(_root);
}

// Path: backup
class _TranslationsBackupHu implements _TranslationsBackupEn {
	_TranslationsBackupHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportHu export = _TranslationsBackupExportHu._(_root);
	@override late final _TranslationsBackupImportHu import = _TranslationsBackupImportHu._(_root);
	@override late final _TranslationsBackupAboutHu about = _TranslationsBackupAboutHu._(_root);
}

// Path: settings
class _TranslationsSettingsHu implements _TranslationsSettingsEn {
	_TranslationsSettingsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Beállítások és megjelenés';
	@override String get title_short => 'Beállítások';
	@override String get description => 'Alkalmazás témája, szövegek és egyéb általános beállítások';
	@override String get edit_profile => 'Profil szerkesztése';
	@override String get lang_section => 'Nyelv és szövegek';
	@override String get lang_title => 'Alkalmazás nyelve';
	@override String get lang_descr => 'Nyelv, amelyen a szövegek megjelennek az alkalmazásban';
	@override String get lang_help => 'Ha együttműködni szeretne ennek az alkalmazásnak a fordításával, tekintse meg a <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'> útmutatónk</a>';
	@override String get locale => 'Régió';
	@override String get locale_descr => 'Dátumok, számformátumok beállítása...';
	@override String get locale_warn => 'Régióváltáskor az alkalmazás frissülni fog';
	@override String get first_day_of_week => 'A hét első napja';
	@override String get theme_and_colors => 'Témák és színek';
	@override String get theme => 'Téma';
	@override String get theme_auto => 'A rendszer határozza meg';
	@override String get theme_light => 'Világos';
	@override String get theme_dark => 'Sötét';
	@override String get amoled_mode => 'AMOLED mód';
	@override String get amoled_mode_descr => 'Ha lehetséges, használjon tiszta fekete háttérképet. Ez némileg segíti az AMOLED képernyővel rendelkező készülékek akkumulátorát.';
	@override String get dynamic_colors => 'Dinamikus színek';
	@override String get dynamic_colors_descr => 'Amikor csak lehetséges, használja a rendszer kiemelő színét';
	@override String get accent_color => 'Kiemelő szín';
	@override String get accent_color_descr => 'Válassza ki, hogy az alkalmazás milyen színnel emelje ki a felület bizonyos részeit';
	@override late final _TranslationsSettingsSecurityHu security = _TranslationsSettingsSecurityHu._(_root);
}

// Path: more
class _TranslationsMoreHu implements _TranslationsMoreEn {
	_TranslationsMoreHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Továbbiak';
	@override String get title_long => 'További műveletek';
	@override late final _TranslationsMoreDataHu data = _TranslationsMoreDataHu._(_root);
	@override late final _TranslationsMoreAboutUsHu about_us = _TranslationsMoreAboutUsHu._(_root);
	@override late final _TranslationsMoreHelpUsHu help_us = _TranslationsMoreHelpUsHu._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardHu implements _TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} a vágólapra másolva';
	@override String get error => 'Másolási hiba';
}

// Path: general.time
class _TranslationsGeneralTimeHu implements _TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Kezdő dátum';
	@override String get end_date => 'Befejezés dátuma';
	@override String get from_date => 'Ettől kezdve';
	@override String get until_date => 'Dátumig';
	@override String get date => 'Dátum';
	@override String get datetime => 'Időpont';
	@override String get time => 'Idő';
	@override String get each => 'Minden';
	@override String get after => 'Után';
	@override late final _TranslationsGeneralTimeRangesHu ranges = _TranslationsGeneralTimeRangesHu._(_root);
	@override late final _TranslationsGeneralTimePeriodicityHu periodicity = _TranslationsGeneralTimePeriodicityHu._(_root);
	@override late final _TranslationsGeneralTimeCurrentHu current = _TranslationsGeneralTimeCurrentHu._(_root);
	@override late final _TranslationsGeneralTimeAllHu all = _TranslationsGeneralTimeAllHu._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderHu implements _TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Tranzakciók rendezése';
	@override String get category => 'Kategóriánként';
	@override String get quantity => 'Mennyiség szerint';
	@override String get date => 'Dátum szerint';
}

// Path: general.validations
class _TranslationsGeneralValidationsHu implements _TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'A folytatáshoz javítsa ki a megadott mezőket';
	@override String get required => 'Kötelező mező';
	@override String get positive => 'Pozitívnak kell lennie';
	@override String min_number({required Object x}) => 'Nagyobbnak kell lennie, mint ${x}';
	@override String max_number({required Object x}) => 'Kevesebbnek kell lennie, mint ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewHu implements _TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Nagyon jó!';
			case GenderContext.female:
				return 'Nagyon jó!';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Jó';
			case GenderContext.female:
				return 'Jó';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Átlagos';
			case GenderContext.female:
				return 'Átlagos';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Korrekt';
			case GenderContext.female:
				return 'Korrekt';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Nagyon rossz';
			case GenderContext.female:
				return 'Nagyon rossz';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Hiányos adatok';
			case GenderContext.female:
				return 'Hiányos adatok';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrHu descr = _TranslationsFinancialHealthReviewDescrHu._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeHu implements _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Túlélési arány';
	@override String get subtitle => 'Egyenlegét tekintve, mennyi ideig maradhat bevétel nélkül';
	@override String get text_zero => 'Ilyen kiadás mellett egy hónapot sem bírna ki bevétel nélkül!';
	@override String get text_one => 'Ilyen mértékű kiadások mellett aligha tudna akár egy hónapot is túlélni bevétel nélkül!';
	@override String text_other({required Object n}) => 'Ezzel a költési aránnyal körülbelül <b>${n} hónapot</b> tudna túlélni jövedelem nélkül.';
	@override String get text_infinite => 'Ezzel a költési aránnyal nagyjából <b>az egész életében</b> meg tudna élni jövedelem nélkül.';
	@override String get suggestion => 'Ne feledje, hogy célszerű ezt az arányt mindig legalább 5 hónap felett tartani. Ha úgy látja, hogy nem rendelkezik elegendő megtakarítási tartalékkal, csökkentse a felesleges kiadásokat.';
	@override String get insufficient_data => 'Úgy tűnik, nincs elég rögzített kiadásunk ahhoz, hogy kiszámolhassuk, hány hónapig tudna bevétel nélkül megélni. Adjon meg néhány tranzakciót, és térjen vissza ide, hogy ellenőrizze a pénzügyi helyzetét.';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageHu implements _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Megtakarítási százalék';
	@override String get subtitle => 'A jövedelmének mekkora részét nem költi el ebben az időszakban';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextHu text = _TranslationsFinancialHealthSavingsPercentageTextHu._(_root);
	@override String get suggestion => 'Ne feledje, hogy a jövedelmének legalább 15-20%-át célszerű megtakarítani.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesHu implements _TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Közlekedés';
	@override String get money => 'Pénz';
	@override String get food => 'Élelmiszer';
	@override String get medical => 'Egészség';
	@override String get entertainment => 'Szabadidő';
	@override String get technology => 'Technológia';
	@override String get other => 'Egyebek';
	@override String get logos_financial_institutions => 'Pénzintézetek';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsHu implements _TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get accept => 'Elfogadás';
	@override String get skip => 'Kihagyás';
	@override String get skip_success => 'A tranzakció sikeresen kihagyásra került';
	@override String get skip_dialog_title => 'Tranzakció kihagyása';
	@override String skip_dialog_msg({required Object date}) => 'Ez a művelet visszafordíthatatlan. A következő átvitel dátumát módosítjuk erre: ${date}';
	@override String get accept_today => 'Elfogadom ma';
	@override String accept_in_required_date({required Object date}) => 'Elfogadás a szükséges időpontban: (${date})';
	@override String get accept_dialog_title => 'Tranzakció elfogadása';
	@override String get accept_dialog_msg_single => 'A tranzakció új állapota nulla lesz. A tranzakció státuszát bármikor újra módosíthatja, amikor csak akarja.';
	@override String accept_dialog_msg({required Object date}) => 'Ez a művelet egy új tranzakciót hoz létre ${date} dátummal. A tranzakció részleteit a tranzakciós oldalon ellenőrizheti.';
	@override String get recurrent_rule_finished => 'Az ismétlődő szabály teljesült, nincs több kifizetés!';
}

// Path: transaction.list
class _TranslationsTransactionListHu implements _TranslationsTransactionListEn {
	_TranslationsTransactionListHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Nem található itt megjeleníthető tranzakció. Adjon hozzá néhány tranzakciót az alkalmazásban, és talán legközelebb több szerencséje lesz.';
	@override String get searcher_placeholder => 'Keresés kategória, leírás alapján...';
	@override String get searcher_no_results => 'Nincs a keresési feltételeknek megfelelő tranzakció';
	@override String get loading => 'További tranzakciók betöltése...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: '${n} kiválasztva',
		other: '${n} kiválasztva',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: '${n} tranzakció kiválasztva',
		other: '${n} tranzakció kiválasztva',
	);
	@override late final _TranslationsTransactionListBulkEditHu bulk_edit = _TranslationsTransactionListBulkEditHu._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersHu implements _TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get from_value => 'Ebből az összegből';
	@override String get to_value => 'Eddig az összegig';
	@override String from_value_def({required Object x}) => 'Innen: ${x}';
	@override String to_value_def({required Object x}) => 'Ide: ${x}';
	@override String from_date_def({required Object date}) => 'Ettől: ${date}';
	@override String to_date_def({required Object date}) => 'Eddig: ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormHu implements _TranslationsTransactionFormEn {
	_TranslationsTransactionFormHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsHu validators = _TranslationsTransactionFormValidatorsHu._(_root);
	@override String get title => 'Tranzakció megnevezése';
	@override String get title_short => 'Cím';
	@override String get value => 'A tranzakció értéke';
	@override String get tap_to_see_more => 'Koppintson a további részletek megtekintéséhez';
	@override String get no_tags => '-- Nincsenek címkék --';
	@override String get description => 'Leírás';
	@override String get description_info => 'Koppintson ide a tranzakció részletesebb leírásának megadásához.';
	@override String exchange_to_preferred_title({required Object currency}) => '${currency} átváltási árfolyam';
	@override String get exchange_to_preferred_in_date => 'A tranzakció napján';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedHu implements _TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Megfordított tranzakció';
	@override String get title_short => 'Megfordított';
	@override String get description_for_expenses => 'Annak ellenére, hogy költségtranzakció, pozitív összegű. Az ilyen típusú tranzakciókat egy korábban elszámolt kiadás visszatérülésének, például visszatérítésnek vagy egy tartozás kifizetésének megjelenítésére lehet használni.';
	@override String get description_for_incomes => 'Annak ellenére, hogy bevételi tranzakció, negatív összegű. Az ilyen típusú tranzakciók felhasználhatók a helytelenül elszámolt bevétel érvénytelenítésére vagy helyesbítésére, pénzvisszatérítés vagy pénzvisszatérítés tükrözésére, illetve tartozások kifizetésének rögzítésére.';
}

// Path: transaction.status
class _TranslationsTransactionStatusHu implements _TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Állapot',
		other: 'Állapotok',
	);
	@override String get display_long => 'Tranzakció állapota';
	@override String tr_status({required Object status}) => '${status} tranzakció';
	@override String get none => 'Állapot nélküli';
	@override String get none_descr => 'Konkrét állapot nélküli tranzakció';
	@override String get reconciled => 'Egyeztetett';
	@override String get reconciled_descr => 'Ezt a tranzakciót már érvényesítették, és megfelel a bankja valós tranzakciójának.';
	@override String get unreconciled => 'Nem egyeztetett';
	@override String get unreconciled_descr => 'Ezt a tranzakciót még nem ellenőrizték, ezért még nem jelenik meg a valódi bankszámláin. Ez azonban szükséges a Monekin egyenlegeinek és statisztikáinak kiszámításához.';
	@override String get pending => 'Függőben';
	@override String get pending_descr => 'Ez a tranzakció függőben van, ezért az egyenlegek és statisztikák kiszámításakor nem kerül figyelembevételbe.';
	@override String get voided => 'Érvénytelenítve';
	@override String get voided_descr => 'Fizetési hiba vagy bármilyen más ok miatt érvénytelenített/törölt tranzakció. Ezt nem vesszük figyelembe az egyenlegek és statisztikák kiszámításakor.';
}

// Path: transaction.types
class _TranslationsTransactionTypesHu implements _TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Tranzakció típusa',
		other: 'Tranzakciótípusok',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Bevétel',
		other: 'Bevételek',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Kiadás',
		other: 'Kiadások',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Áthelyezés',
		other: 'Áthelyezések',
	);
}

// Path: transfer.form
class _TranslationsTransferFormHu implements _TranslationsTransferFormEn {
	_TranslationsTransferFormHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get from => 'Eredeti számla';
	@override String get to => 'Célszámla';
	@override late final _TranslationsTransferFormValueInDestinyHu value_in_destiny = _TranslationsTransferFormValueInDestinyHu._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsHu implements _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ismétlődő tranzakció';
	@override String get descr => 'A tranzakció következő lépései az alábbiakban láthatók. Elfogadhatja az első lépést, vagy kihagyhatja ezt a lépést.';
	@override String get last_payment_info => 'Ez a mozgatás az utolsó az ismétlődő szabályban, így ez a szabály automatikusan törlődik a művelet megerősítésekor.';
	@override String get delete_header => 'Ismétlődő tranzakció törlése';
	@override String get delete_message => 'Ez a művelet visszafordíthatatlan, és nem érinti a már visszaigazolt/befizetett tranzakciókat.';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusHu implements _TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Késés: ${x}d';
	@override String coming_in({required Object x}) => '${x} napon belül';
}

// Path: account.types
class _TranslationsAccountTypesHu implements _TranslationsAccountTypesEn {
	_TranslationsAccountTypesHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Számlatípus';
	@override String get warning => 'A számlatípus kiválasztása után az a jövőben nem változtatható meg.';
	@override String get normal => 'Normál számla';
	@override String get normal_descr => 'Hasznos a napi pénzügyek rögzítéséhez. Ez a leggyakoribb számla, amely lehetővé teszi kiadások, bevételek hozzáadását...';
	@override String get saving => 'Megtakarítási számla';
	@override String get saving_descr => 'Csak más számlákról tud pénzt hozzáadni és kivenni belőle. Tökéletes a megtakarítás megkezdéséhez.';
}

// Path: account.form
class _TranslationsAccountFormHu implements _TranslationsAccountFormEn {
	_TranslationsAccountFormHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Számla neve';
	@override String get name_placeholder => 'Pl.: Megtakarítási számla';
	@override String get notes => 'Megjegyzések';
	@override String get notes_placeholder => 'Írjon néhány megjegyzést/leírást erről a számláról.';
	@override String get initial_balance => 'Kezdőegyenleg';
	@override String get current_balance => 'Aktuális egyenleg';
	@override String get create => 'Számla létrehozása';
	@override String get edit => 'Számla szerkesztése';
	@override String get currency_not_found_warn => 'Nincs információja ennek a pénznemnek az árfolyamairól. 1,0 lesz az alapértelmezett átváltási árfolyam. Ezt a beállításokban tudja majd módosítani.';
	@override String get already_exists => 'Ugyanezzel a névvel már van egy másik is. Kérjük, adjon meg egy másikat.';
	@override String get tr_before_opening_date => 'A számlán a nyitási dátumot megelőző dátumú tranzakciók vannak.';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteHu implements _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Törli a számlát?';
	@override String get warning_text => 'Ez a művelet törli ezt a számlát és annak az összes tranzakcióját.';
	@override String get success => 'A számla sikeresen törlésre került';
}

// Path: account.close
class _TranslationsAccountCloseHu implements _TranslationsAccountCloseEn {
	_TranslationsAccountCloseHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Számla lezárása';
	@override String get title_short => 'Lezárás';
	@override String get warn => 'Ez a számla többé nem jelenik meg bizonyos listákban, és nem tud benne tranzakciókat létrehozni az alább megadott dátumnál későbbi dátummal. Ez a művelet semmilyen tranzakciót vagy egyenleget nem érint, és ezt a számlát bármikor újra megnyithatja. ';
	@override String get should_have_zero_balance => 'A számla lezárásához 0-nak kell lennie az aktuális egyenlegnek. Kérjük, a folytatás előtt szerkessze át a számlát.';
	@override String get should_have_no_transactions => 'Ez a számla a megadott zárási dátumot követő tranzakciókat tartalmaz. Törölje őket, vagy szerkessze a számla zárási dátumát, mielőtt folytatná.';
	@override String get success => 'A számla sikeresen lezárva';
	@override String get unarchive_succes => 'A számla sikeresen újranyitásra került';
}

// Path: account.select
class _TranslationsAccountSelectHu implements _TranslationsAccountSelectEn {
	_TranslationsAccountSelectHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get one => 'Egy számla kiválasztása';
	@override String get all => 'Összes számla';
	@override String get multiple => 'Számlák kiválasztása';
}

// Path: currencies.form
class _TranslationsCurrenciesFormHu implements _TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'A pénznem nem lehet azonos a felhasználói pénznemmel';
	@override String get specify_a_currency => 'Kérjük, adjon meg egy pénznemet';
	@override String get add => 'Árfolyam hozzáadása';
	@override String get add_success => 'Az árfolyam sikeresen hozzáadva';
	@override String get edit => 'Árfolyam szerkesztése';
	@override String get edit_success => 'Az árfolyam szerkesztése sikerült';
}

// Path: tags.form
class _TranslationsTagsFormHu implements _TranslationsTagsFormEn {
	_TranslationsTagsFormHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Címke neve';
	@override String get description => 'Leírás';
}

// Path: tags.select
class _TranslationsTagsSelectHu implements _TranslationsTagsSelectEn {
	_TranslationsTagsSelectHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Címke kiválasztása';
	@override String get all => 'Minden címke';
}

// Path: categories.select
class _TranslationsCategoriesSelectHu implements _TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kategóriák kiválasztása';
	@override String get select_one => 'Kategória kiválasztása';
	@override String get select_subcategory => 'Alkategória kiválasztása';
	@override String get without_subcategory => 'Alkategória nélkül';
	@override String get all => 'Összes kategória';
	@override String get all_short => 'Mind';
}

// Path: budgets.form
class _TranslationsBudgetsFormHu implements _TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hozzáadás';
	@override String get name => 'Költségvetés neve';
	@override String get value => 'Mennyiségkorlátozás';
	@override String get create => 'Hozzáadás';
	@override String get edit => 'Szerkesztés';
	@override String get negative_warn => 'A költségvetések nem lehetnek negatív összegűek.';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsHu implements _TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Költségvetés részletei';
	@override String get statistics => 'Statisztika';
	@override String get budget_value => 'Költségvetésben';
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Naponta ${dailyAmount} -ot költhet el, még ${remainingDays} napig';
	@override String get expend_evolution => 'Költségek alakulása';
	@override String get no_transactions => 'Úgy tűnik, hogy ezzel a költségvetéssel kapcsolatban semmilyen kiadást nem teljesített.';
}

// Path: backup.export
class _TranslationsBackupExportHu implements _TranslationsBackupExportEn {
	_TranslationsBackupExportHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Adatok exportálása';
	@override String get title_short => 'Exportálás';
	@override String get all => 'Teljes mentés';
	@override String get all_descr => 'Exportálja az összes adatát (számlák, tranzakciók, költségvetések, beállítások...). Bármikor újra importálhatja őket, így semmit sem veszíthet el.';
	@override String get transactions => 'Tranzakciók mentése';
	@override String get transactions_descr => 'Exportálja tranzakcióit CSV formátumban, így könnyebben elemezheti azokat más programokban vagy alkalmazásokban.';
	@override String get description => 'Adatok letöltése különböző formátumokban';
	@override String get dialog_title => 'Fájl mentése/küldése';
	@override String success({required Object x}) => 'A fájl sikeresen mentve/letöltve ide: ${x}';
	@override String get error => 'Hiba a fájl letöltésében. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
}

// Path: backup.import
class _TranslationsBackupImportHu implements _TranslationsBackupImportEn {
	_TranslationsBackupImportHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Adatok importálása';
	@override String get title_short => 'Importálás';
	@override String get restore_backup => 'Mentés visszaállítása';
	@override String get restore_backup_descr => 'Importáljon egy korábban mentett adatbázist a Monekinből. Ez a művelet minden jelenlegi alkalmazásadatot lecseréli az új adatokra.';
	@override String get restore_backup_warn_description => 'Új adatbázis importálásakor az alkalmazásban jelenleg mentett összes adat elveszik. A folytatás előtt ajánlatos biztonsági másolatot készíteni. Ne töltsön fel ide olyan fájlt, amelynek eredetét nem ismeri, csak azokat a fájlokat töltse fel, amelyeket korábban letöltött a Monekin oldaláról.';
	@override String get restore_backup_warn_title => 'Az összes adat felülírása';
	@override String get select_other_file => 'Másik fájl kiválasztása';
	@override String get tap_to_select_file => 'Koppintson a fájl kiválasztásához';
	@override late final _TranslationsBackupImportManualImportHu manual_import = _TranslationsBackupImportManualImportHu._(_root);
	@override String get success => 'Az importálás sikeresen végrehajtva';
	@override String get cancelled => 'Az importálást a felhasználó megszakította';
	@override String get error => 'Hiba történt importálásakor. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
}

// Path: backup.about
class _TranslationsBackupAboutHu implements _TranslationsBackupAboutEn {
	_TranslationsBackupAboutHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Információk az adatbázisról';
	@override String get create_date => 'Létrehozás dátuma';
	@override String get modify_date => 'Utolsó módosítása';
	@override String get last_backup => 'Utolsó mentés';
	@override String get size => 'Méret';
}

// Path: settings.security
class _TranslationsSettingsSecurityHu implements _TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Biztonság';
	@override String get private_mode_at_launch => 'Privát mód indításkor';
	@override String get private_mode_at_launch_descr => 'Az alkalmazás alapértelmezés szerinti indítása privát módban';
	@override String get private_mode => 'Privát mód';
	@override String get private_mode_descr => 'Minden pénzösszeg elrejtése';
	@override String get private_mode_activated => 'Privát mód aktiválva';
	@override String get private_mode_deactivated => 'Privát mód letiltva';
}

// Path: more.data
class _TranslationsMoreDataHu implements _TranslationsMoreDataEn {
	_TranslationsMoreDataHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Adatok';
	@override String get display_descr => 'Exportálja és importálja az adatait, hogy ne veszítsen el semmit se';
	@override String get delete_all => 'Adataim törlése';
	@override String get delete_all_header1 => 'Álljon meg ⚠️⚠️';
	@override String get delete_all_message1 => 'Biztosan benne, hogy folytatja? Minden adata véglegesen törlődik, és nem állítható vissza';
	@override String get delete_all_header2 => 'Még egy utolsó lépés ⚠️⚠️';
	@override String get delete_all_message2 => 'A fiók törlésével törli az összes tárolt személyes adatát. A számlái, tranzakciói, költségvetései és kategóriái törlődnek, és nem állíthatók helyre. Egyetért ezzel?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsHu implements _TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Alkalmazásinformációk';
	@override String get description => 'Nézze meg a Monekinre vonatkozó feltételeket és egyéb fontos információkat. Lépjen kapcsolatba a közösséggel a hibák bejelentésével, javaslatok megtételével...';
	@override late final _TranslationsMoreAboutUsLegalHu legal = _TranslationsMoreAboutUsLegalHu._(_root);
	@override late final _TranslationsMoreAboutUsProjectHu project = _TranslationsMoreAboutUsProjectHu._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsHu implements _TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Segítsen nekünk';
	@override String get description => 'Tudja meg, hogyan segíthet a Monekinnek abban, hogy egyre jobb és jobb legyen';
	@override String get rate_us => 'Értékeljen minket';
	@override String get rate_us_descr => 'Bármilyen értékelést szívesen fogadunk!';
	@override String get share => 'Monekin megosztása';
	@override String get share_descr => 'Ossza meg alkalmazásunkat a barátaival és a családtagjaival';
	@override String get share_text => 'Monekin! A legjobb személyes pénzügyi alkalmazás. Töltse le innen';
	@override String get thanks => 'Köszönjük!';
	@override String get thanks_long => 'Az Ön hozzájárulása a Monekinhez és más nyílt forráskódú projektekhez, legyen az kicsi vagy nagy, lehetővé teszi az ehhez hasonló nagyszerű projekteket. Köszönjük, hogy időt szán a közreműködésre.';
	@override String get donate => 'Adományozás';
	@override String get donate_descr => 'Az adományával segít az alkalmazás további fejlesztésében. Mi lehetne jobb módja, mint megköszönni az elvégzett munkát egy kávéra való meghívással?';
	@override String get donate_success => 'Az adományozás megtörtént. Köszönöm szépen a közreműködését! ❤️';
	@override String get donate_err => 'Hoppá! Úgy tűnik, hiba történt a fizetés fogadásakor';
	@override String get report => 'Hibák jelentése, javaslatok...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesHu implements _TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Időtartomány';
	@override String get it_repeat => 'Ismétlések';
	@override String get it_ends => 'Vége';
	@override String get forever => 'Mindig';
	@override late final _TranslationsGeneralTimeRangesTypesHu types = _TranslationsGeneralTimeRangesTypesHu._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Minden ${range}',
		other: 'Minden ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Minden ${range} ${day} -ig',
		other: 'Minden ${n} ${range} ${day} -ig',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Minden ${range} ${limit} alkalommal',
		other: 'Minden ${n} ${range} ${limit} alkalommal',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Minden ${range} egyszer',
		other: 'Minden ${n} ${range} egyszer',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Hónap',
		other: 'Hónap',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Év',
		other: 'Év',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Nap',
		other: 'Nap',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Hét',
		other: 'Hét',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityHu implements _TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ismétlődés';
	@override String get no_repeat => 'Nem ismétlődik';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: 'Ismétlés',
		other: 'Ismétlések',
	);
	@override String get diary => 'Naponta';
	@override String get monthly => 'Havonta';
	@override String get annually => 'Évente';
	@override String get quaterly => 'Negyedévente';
	@override String get weekly => 'Hetente';
	@override String get custom => 'Egyéni';
	@override String get infinite => 'Mindig';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentHu implements _TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Ebben a hónapban';
	@override String get annually => 'Ebben az évben';
	@override String get quaterly => 'Ebben a negyedévben';
	@override String get weekly => 'Ezen a héten';
	@override String get infinite => 'Mindig';
	@override String get custom => 'Egyéni tartomány';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllHu implements _TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Minden nap';
	@override String get monthly => 'Minden hónapban';
	@override String get annually => 'Minden évben';
	@override String get quaterly => 'Minden negyedévben';
	@override String get weekly => 'Minden héten';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrHu implements _TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Úgy tűnik, nincs elég rögzített kiadásunk ahhoz, hogy kiszámítsuk a pénzügyi állapotát. Adjon hozzá néhány kiadást/bevételt ebben az időszakban, hogy tudjunk segíteni Önnek!';
	@override String get very_good => 'Gratulálunk! Az Ön pénzügyi helyzete nagyon rendben van. Reméljük, hogy folytatódik a jó szériája, és továbbra is tanulni fog a Monekin-nel.';
	@override String get good => 'Nagyszerű! Az Ön pénzügyi helyzete rendben van. Látogasson el az elemzés fülre, hogy megtudja, hogyan takaríthat meg még többet!';
	@override String get normal => 'Az Ön pénzügyi állapota nagyjából a lakosság többi részének átlagában van ebben az időszakban.';
	@override String get bad => 'Úgy tűnik, hogy az Ön pénzügyi helyzete még nem a legjobb. Tekintse át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
	@override String get very_bad => 'Hmm, a pénzügyi helyzete messze elmarad attól, aminek lennie kellene. Nézze át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextHu implements _TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Gratulálunk! Ebben az időszakban a bevételének <b>${value}%</b>-át sikerült megtakarítania. Úgy tűnik, már rendelkezik hozzáértéssel, csak így tovább!';
	@override String normal({required Object value}) => 'Gratulálunk, a bevételének <b>${value}%</b>-át sikerült megtakarítania ebben az időszakban.';
	@override String bad({required Object value}) => 'Ebben az időszakban sikerült megtakarítania a jövedelmének <b>${value}%-át</b>. Úgy gondoljuk azonban, hogy ennél még sokkal többet is tehet!';
	@override String get very_bad => 'Hűha, sajnos ebben az időszakban semmit sem sikerült megtakarítania.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditHu implements _TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Dátumok szerkesztése';
	@override String get categories => 'Kategóriák szerkesztése';
	@override String get status => 'Állapotok szerkesztése';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsHu implements _TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get zero => 'A tranzakció értéke nem lehet nulla.';
	@override String get date_max => 'A kiválasztott dátum az aktuális dátum után van. A tranzakció függő tranzakcióként kerül hozzáadásra.';
	@override String get date_after_account_creation => 'Nem hozhat létre olyan tranzakciót, amelynek a dátuma megelőzi a hozzá tartozó számla létrehozásának a dátumát.';
	@override String get negative_transfer => 'Az átutalás pénzbeli értéke nem lehet negatív.';
	@override String get transfer_between_same_accounts => 'A kiindulási és a célszámla nem lehet ugyanaz.';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyHu implements _TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'A rendeltetési helyre átutalt összeg';
	@override String amount_short({required Object amount}) => '${amount} a célszámlához';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportHu implements _TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kézi importálás';
	@override String get descr => 'Tranzakciók kézi importálása egy .csv fájlból';
	@override String get default_account => 'Alapértelm. számla';
	@override String get remove_default_account => 'Alapértelmezett számla törlése';
	@override String get default_category => 'Alapértelm. kategória';
	@override String get select_a_column => 'Válasszon ki egy oszlopot a .csv fájlból';
	@override List<String> get steps => [
		'Fájl kiválasztása',
		'Mennyiség oszlop',
		'Számlaoszlop',
		'Kategória oszlop',
		'Dátum oszlop',
		'egyéb oszlopok',
	];
	@override List<String> get steps_descr => [
		'Válasszon ki egy .csv fájlt az eszközről. Győződjön meg arról, hogy van egy első sora, amely leírja az egyes oszlopok nevét.',
		'Válassza ki azt az oszlopot, amelyben az egyes tranzakciók dátuma meg van adva. Ha nincs megadva, a tranzakciók az aktuális dátummal jönnek létre. Válassza ki azt az oszlopot, ahol az egyes tranzakciók értéke meg van adva. Használjon negatív értékeket a kiadásokhoz és pozitív értékeket a bevételekhez. Használjon pontot tizedeselválasztóként.',
		'Válassza ki azt az oszlopot, amelyben meg van adva az a számla, amelyhez az egyes tranzakciók tartoznak. Kiválaszthat egy alapértelmezett fiókot is arra az esetre, ha nem találnánk a kívánt fiókot. Ha nincs megadva alapértelmezett fiók, akkor létrehozunk egyet ugyanazzal a névvel. ',
		'Adja meg azt az oszlopot, ahol a tranzakciókategória neve található. Meg kell adnia egy alapértelmezett kategóriát, hogy ezt a kategóriát rendeljük hozzá a tranzakciókhoz, ha a kategória nem található.',
		'Válassza ki azt az oszlopot, amelyben az egyes tranzakciók dátuma meg van adva. Ha nincs megadva, a tranzakciók az aktuális dátummal jönnek létre.',
		'Az egyéb opcionális tranzakciós attribútumok oszlopainak meghatározása',
	];
	@override String success({required Object x}) => '${x} tranzakció sikeresen importálva';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalHu implements _TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Jogi információk';
	@override String get privacy => 'Adatvédelem';
	@override String get terms => 'Használati feltételek';
	@override String get licenses => 'Licencek';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectHu implements _TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Projekt';
	@override String get contributors => 'Közreműködők';
	@override String get contributors_descr => 'Az összes fejlesztő, akik hozzájárultak a Monekin létrehozásához';
	@override String get contact => 'Kapcsolatfelvétel';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesHu implements _TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesHu._(this._root);

	@override final _TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Ciklusok';
	@override String get last_days => 'Utolsó nap';
	@override String last_days_form({required Object x}) => '${x} előző nap';
	@override String get all => 'Mindig';
	@override String get date_range => 'Egyéni tartomány';
}

// Path: <root>
class _TranslationsUk implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsUk.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.uk,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <uk>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsUk _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsGeneralUk general = _TranslationsGeneralUk._(_root);
	@override late final _TranslationsIntroUk intro = _TranslationsIntroUk._(_root);
	@override late final _TranslationsHomeUk home = _TranslationsHomeUk._(_root);
	@override late final _TranslationsFinancialHealthUk financial_health = _TranslationsFinancialHealthUk._(_root);
	@override late final _TranslationsStatsUk stats = _TranslationsStatsUk._(_root);
	@override late final _TranslationsIconSelectorUk icon_selector = _TranslationsIconSelectorUk._(_root);
	@override late final _TranslationsTransactionUk transaction = _TranslationsTransactionUk._(_root);
	@override late final _TranslationsTransferUk transfer = _TranslationsTransferUk._(_root);
	@override late final _TranslationsRecurrentTransactionsUk recurrent_transactions = _TranslationsRecurrentTransactionsUk._(_root);
	@override late final _TranslationsAccountUk account = _TranslationsAccountUk._(_root);
	@override late final _TranslationsCurrenciesUk currencies = _TranslationsCurrenciesUk._(_root);
	@override late final _TranslationsTagsUk tags = _TranslationsTagsUk._(_root);
	@override late final _TranslationsCategoriesUk categories = _TranslationsCategoriesUk._(_root);
	@override late final _TranslationsBudgetsUk budgets = _TranslationsBudgetsUk._(_root);
	@override late final _TranslationsBackupUk backup = _TranslationsBackupUk._(_root);
	@override late final _TranslationsSettingsUk settings = _TranslationsSettingsUk._(_root);
	@override late final _TranslationsMoreUk more = _TranslationsMoreUk._(_root);
}

// Path: general
class _TranslationsGeneralUk implements _TranslationsGeneralEn {
	_TranslationsGeneralUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Скасувати';
	@override String get or => 'або';
	@override String get understood => 'Зрозуміло';
	@override String get unspecified => 'Не вказано';
	@override String get confirm => 'Підтвердити';
	@override String get continue_text => 'Продовжити';
	@override String get quick_actions => 'Швидкі дії';
	@override String get save => 'Зберегти';
	@override String get save_changes => 'Зберегти зміни';
	@override String get close_and_save => 'Закрити та зберегти';
	@override String get add => 'Додати';
	@override String get edit => 'Редагувати';
	@override String get balance => 'Баланс';
	@override String get delete => 'Видалити';
	@override String get account => 'Рахунок';
	@override String get accounts => 'Рахунки';
	@override String get categories => 'Категорії';
	@override String get category => 'Категорія';
	@override String get today => 'Сьогодні';
	@override String get yesterday => 'Вчора';
	@override String get filters => 'Фільтри';
	@override String get see_more => 'Побачити більше';
	@override String get select_all => 'Вибрати всі';
	@override String get deselect_all => 'Скасувати вибір усіх';
	@override String get empty_warn => 'Ой! Тут порожньо';
	@override String get insufficient_data => 'Недостатньо даних';
	@override String get show_more_fields => 'Показати більше полів';
	@override String get show_less_fields => 'Показати менше полів';
	@override String get tap_to_search => 'Натисніть для пошуку';
	@override late final _TranslationsGeneralClipboardUk clipboard = _TranslationsGeneralClipboardUk._(_root);
	@override late final _TranslationsGeneralTimeUk time = _TranslationsGeneralTimeUk._(_root);
	@override late final _TranslationsGeneralTransactionOrderUk transaction_order = _TranslationsGeneralTransactionOrderUk._(_root);
	@override late final _TranslationsGeneralValidationsUk validations = _TranslationsGeneralValidationsUk._(_root);
}

// Path: intro
class _TranslationsIntroUk implements _TranslationsIntroEn {
	_TranslationsIntroUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get start => 'Початок';
	@override String get skip => 'Пропустити';
	@override String get next => 'Далі';
	@override String get select_your_currency => 'Виберіть вашу валюту';
	@override String get welcome_subtitle => 'Ваш особистий фінансовий менеджер';
	@override String get welcome_subtitle2 => '100% відкритий, 100% безкоштовний';
	@override String get welcome_footer => 'Увійшовши в систему, ви погоджуєтеся з <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Політикою конфіденційності</a> та <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Умовами використання</a> додатка';
	@override String get offline_descr_title => 'ОФЛАЙН-РЕЖИМ:';
	@override String get offline_descr => 'Ваші дані будуть збережені тільки на вашому пристрої, поки ви не видалите програму або не зміните телефон. Щоб запобігти втраті даних, рекомендується регулярно робити резервні копії з налаштувань програми.';
	@override String get offline_start => 'Почати сеанс офлайн';
	@override String get sl1_title => 'Виберіть вашу валюту';
	@override String get sl1_descr => 'Ваша основна валюта буде використовуватися в звітах та загальних діаграмах. Ви зможете змінити валюту та мову програми пізніше в будь-який час у налаштуваннях додатка';
	@override String get sl2_title => 'Безпечно, приватно і надійно';
	@override String get sl2_descr => 'Ваші дані належать тільки вам. Інформація зберігається безпосередньо на вашому пристрої, без пропуску через зовнішні сервери. Це дозволяє використовувати додаток навіть без Інтернету';
	@override String get sl2_descr2 => 'Крім того, вихідний код програми є відкритим, будь-хто може вносити свої правки та переглядати, як він працює';
	@override String get last_slide_title => 'Все готово';
	@override String get last_slide_descr => 'З Monekin ви нарешті можете досягти фінансової незалежності, яку так багато хочете. У вас будуть графіки, бюджети, поради, статистика та багато іншого про ваші фінанси.';
	@override String get last_slide_descr2 => 'Сподіваємося, вам сподобається користуватись додатком! Не соромтеся зв\'язатися з нами у разі сумнівів або пропозицій...';
}

// Path: home
class _TranslationsHomeUk implements _TranslationsHomeEn {
	_TranslationsHomeUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Панель керування';
	@override String get filter_transactions => 'Фільтрувати транзакції';
	@override String get hello_day => 'Доброго ранку,';
	@override String get hello_night => 'Доброї ночі,';
	@override String get total_balance => 'Загальний баланс';
	@override String get my_accounts => 'Мої рахунки';
	@override String get active_accounts => 'Активні рахунки';
	@override String get no_accounts => 'Рахунки ще не створені';
	@override String get no_accounts_descr => 'Почніть використовувати всю магію Monekin. Створіть принаймні один рахунок, щоб почати додавати транзакції';
	@override String get last_transactions => 'Останні транзакції';
	@override String get should_create_account_header => 'Ой!';
	@override String get should_create_account_message => 'Перш ніж почати створювати транзакції, вам потрібно мати принаймні один неархівований рахунок';
}

// Path: financial_health
class _TranslationsFinancialHealthUk implements _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Фінансове здоров\'я';
	@override late final _TranslationsFinancialHealthReviewUk review = _TranslationsFinancialHealthReviewUk._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeUk months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeUk._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageUk savings_percentage = _TranslationsFinancialHealthSavingsPercentageUk._(_root);
}

// Path: stats
class _TranslationsStatsUk implements _TranslationsStatsEn {
	_TranslationsStatsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Статистика';
	@override String get balance => 'Баланс';
	@override String get final_balance => 'Кінцевий баланс';
	@override String get balance_by_account => 'Баланс за рахунками';
	@override String get balance_by_account_subtitle => 'Де я маю більшість грошей?';
	@override String get balance_by_currency => 'Баланс за валютою';
	@override String get balance_by_currency_subtitle => 'Скільки я маю грошей в іноземній валюті?';
	@override String get balance_evolution => 'Тенденція балансу';
	@override String get balance_evolution_subtitle => 'У мене більше грошей, ніж раніше?';
	@override String get compared_to_previous_period => 'Порівняно з попереднім періодом';
	@override String get cash_flow => 'Грошовий потік';
	@override String get cash_flow_subtitle => 'Я витрачаю менше, ніж заробляю?';
	@override String get by_periods => 'За періодами';
	@override String get by_categories => 'За категоріями';
	@override String get by_tags => 'За тегами';
	@override String get distribution => 'Розподіл';
	@override String get finance_health_resume => 'Підсумок фінансового здоров\'я';
	@override String get finance_health_breakdown => 'Детальний аналіз фінансового здоров\'я';
}

// Path: icon_selector
class _TranslationsIconSelectorUk implements _TranslationsIconSelectorEn {
	_TranslationsIconSelectorUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get name => 'Назва:';
	@override String get icon => 'Іконка';
	@override String get color => 'Колір';
	@override String get select_color => 'Виберіть колір';
	@override String get custom_color => 'Користувацький колір';
	@override String get current_color_selection => 'Поточний вибір';
	@override String get select_icon => 'Виберіть іконку';
	@override String get select_account_icon => 'Ідентифікуйте ваш рахунок';
	@override String get select_category_icon => 'Ідентифікуйте вашу категорію';
	@override late final _TranslationsIconSelectorScopesUk scopes = _TranslationsIconSelectorScopesUk._(_root);
}

// Path: transaction
class _TranslationsTransactionUk implements _TranslationsTransactionEn {
	_TranslationsTransactionUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Транзакція',
		other: 'Транзакції',
	);
	@override String get create => 'Нова транзакція';
	@override String get new_income => 'Новий дохід';
	@override String get new_expense => 'Новий витрати';
	@override String get new_success => 'Транзакція успішно створена';
	@override String get edit => 'Редагувати транзакцію';
	@override String get edit_success => 'Транзакція успішно відредагована';
	@override String get edit_multiple => 'редагувати транзакції';
	@override String edit_multiple_success({required Object x}) => '${x} належним чином відредаговані транзакції';
	@override String get duplicate => 'Клонувати транзакцію';
	@override String get duplicate_short => 'Клон';
	@override String get duplicate_warning_message => 'Транзакція, ідентична цій, буде створена з такою ж датою. Бажаєте продовжити?';
	@override String get duplicate_success => 'Транзакція успішно склонована';
	@override String get delete => 'Видалити транзакцію';
	@override String get delete_warning_message => 'Ця дія незворотня. Поточний баланс ваших рахунків і всі ваші статистичні дані будуть перераховані';
	@override String get delete_success => 'Транзакцію успішно видалено';
	@override String get delete_multiple => 'Усунути транзакції';
	@override String delete_multiple_warning_message({required Object x}) => 'Ця дія незворотна і безумовно стерть ${x} транзакції. Поточний баланс ваших рахунків та вся ваша статистика будуть перенесені';
	@override String delete_multiple_success({required Object x}) => '${x} належним чином усунути транзакції';
	@override String get details => 'Деталі руху коштів';
	@override late final _TranslationsTransactionNextPaymentsUk next_payments = _TranslationsTransactionNextPaymentsUk._(_root);
	@override late final _TranslationsTransactionListUk list = _TranslationsTransactionListUk._(_root);
	@override late final _TranslationsTransactionFiltersUk filters = _TranslationsTransactionFiltersUk._(_root);
	@override late final _TranslationsTransactionFormUk form = _TranslationsTransactionFormUk._(_root);
	@override late final _TranslationsTransactionReversedUk reversed = _TranslationsTransactionReversedUk._(_root);
	@override late final _TranslationsTransactionStatusUk status = _TranslationsTransactionStatusUk._(_root);
	@override late final _TranslationsTransactionTypesUk types = _TranslationsTransactionTypesUk._(_root);
}

// Path: transfer
class _TranslationsTransferUk implements _TranslationsTransferEn {
	_TranslationsTransferUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Переказ';
	@override String get transfers => 'Перекази';
	@override String transfer_to({required Object account}) => 'Переказ на ${account}';
	@override String get create => 'Новий переказ';
	@override String get need_two_accounts_warning_header => 'Увага!';
	@override String get need_two_accounts_warning_message => 'Для виконання цієї дії потрібно щонайменше два рахунки. Якщо вам потрібно відредагувати поточний баланс цього рахунку, натисніть кнопку редагування';
	@override late final _TranslationsTransferFormUk form = _TranslationsTransferFormUk._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsUk implements _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Повторювані транзакції';
	@override String get title_short => 'Повт. транзакції';
	@override String get empty => 'Схоже, у вас немає жодних повторюваних транзакцій. Створіть щомісячну, щорічну або щотижневу повторювану транзакцію, і вона з\'явиться тут';
	@override String get total_expense_title => 'Загальні витрати за період';
	@override String get total_expense_descr => '* Без урахування початкової та кінцевої дати кожної повторюваної транзакції';
	@override late final _TranslationsRecurrentTransactionsDetailsUk details = _TranslationsRecurrentTransactionsDetailsUk._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusUk status = _TranslationsRecurrentTransactionsStatusUk._(_root);
}

// Path: account
class _TranslationsAccountUk implements _TranslationsAccountEn {
	_TranslationsAccountUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get details => 'Деталі рахунку';
	@override String get date => 'Дата відкриття';
	@override String get close_date => 'Дата закриття';
	@override String get reopen => 'Повторно відкрити рахунок';
	@override String get reopen_short => 'Повторно відкрити';
	@override String get reopen_descr => 'Ви впевнені, що хочете повторно відкрити цей рахунок?';
	@override String get balance => 'Баланс рахунку';
	@override String get n_transactions => 'Кількість транзакцій';
	@override String get add_money => 'Додати кошти';
	@override String get withdraw_money => 'Зняти кошти';
	@override String get no_accounts => 'Тут не знайдено жодних транзакцій для відображення. Додайте транзакцію, натиснувши кнопку \'+\' внизу';
	@override late final _TranslationsAccountTypesUk types = _TranslationsAccountTypesUk._(_root);
	@override late final _TranslationsAccountFormUk form = _TranslationsAccountFormUk._(_root);
	@override late final _TranslationsAccountDeleteUk delete = _TranslationsAccountDeleteUk._(_root);
	@override late final _TranslationsAccountCloseUk close = _TranslationsAccountCloseUk._(_root);
	@override late final _TranslationsAccountSelectUk select = _TranslationsAccountSelectUk._(_root);
}

// Path: currencies
class _TranslationsCurrenciesUk implements _TranslationsCurrenciesEn {
	_TranslationsCurrenciesUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Конвертер валют';
	@override String get currency => 'Валюта';
	@override String get currency_manager => 'Менеджер валют';
	@override String get currency_manager_descr => 'Налаштуйте вашу валюту та її обмінні курси з іншими';
	@override String get preferred_currency => 'Перевагова/базова валюта';
	@override String get change_preferred_currency_title => 'Змінити перевагову валюту';
	@override String get change_preferred_currency_msg => 'Усі статистичні дані та бюджети будуть відображатися в цій валюті відтепер. Рахунки та транзакції залишаться у тій валюті, яку вони мали. Усі збережені обмінні курси будуть видалені, якщо ви виконаєте цю дію. Ви хочете продовжити?';
	@override late final _TranslationsCurrenciesFormUk form = _TranslationsCurrenciesFormUk._(_root);
	@override String get delete_all_success => 'Обмінні курси успішно видалено';
	@override String get historical => 'Історичні курси';
	@override String get exchange_rate => 'Обмінний курс';
	@override String get exchange_rates => 'Обмінні курси';
	@override String get empty => 'Додайте тут обмінні курси, щоб, якщо у вас є рахунки в інших валютах, наші графіки були б точнішими';
	@override String get select_a_currency => 'Виберіть валюту';
	@override String get search => 'Пошук за назвою або кодом валюти';
}

// Path: tags
class _TranslationsTagsUk implements _TranslationsTagsEn {
	_TranslationsTagsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Мітка',
		other: 'Теги',
	);
	@override late final _TranslationsTagsFormUk form = _TranslationsTagsFormUk._(_root);
	@override late final _TranslationsTagsSelectUk select = _TranslationsTagsSelectUk._(_root);
	@override String get empty_list => 'Ви ще не створили жодних тегів. Теги та категорії - це відмінний спосіб категоризувати ваші рухи';
	@override String get without_tags => 'Без тегів';
	@override String get add => 'Додати тег';
	@override String get create => 'Створити мітку';
	@override String get create_success => 'Мітка успішно створена';
	@override String get already_exists => 'Ця назва тегу вже існує. Ви можете відредагувати її';
	@override String get edit => 'Редагувати тег';
	@override String get edit_success => 'Тег успішно відредаговано';
	@override String get delete_success => 'Тег успішно видалено';
	@override String get delete_warning_header => 'Видалити тег?';
	@override String get delete_warning_message => 'Ця дія не призведе до видалення транзакцій, які мають цей тег.';
}

// Path: categories
class _TranslationsCategoriesUk implements _TranslationsCategoriesEn {
	_TranslationsCategoriesUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Невідома категорія';
	@override String get create => 'Створити категорію';
	@override String get create_success => 'Категорія успішно створена';
	@override String get new_category => 'Нова категорія';
	@override String get already_exists => 'Така назва категорії вже існує. Можливо, ви хочете відредагувати її';
	@override String get edit => 'Редагувати категорію';
	@override String get edit_success => 'Категорію успішно відредаговано';
	@override String get name => 'Назва категорії';
	@override String get type => 'Тип категорії';
	@override String get both_types => 'Обидва типи';
	@override String get subcategories => 'Підкатегорії';
	@override String get subcategories_add => 'Додати підкатегорію';
	@override String get make_parent => 'Зробити батьківською категорією';
	@override String get make_child => 'Зробити підкатегорією';
	@override String make_child_warning1({required Object destiny}) => 'Ця категорія та її підкатегорії стануть підкатегоріями <b>${destiny}</b>.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'Їх транзакції <b>(${x})</b> будуть перенесені до нових підкатегорій, створених всередині категорії <b>${destiny}</b>.';
	@override String get make_child_success => 'Підкатегорії успішно створено';
	@override String get merge => 'Об\'єднати з іншою категорією';
	@override String merge_warning1({required Object x, required Object from, required Object destiny}) => 'Всі транзакції (${x}), пов\'язані з категорією <b>${from}</b>, будуть перенесені до категорії <b>${destiny}</b>';
	@override String merge_warning2({required Object from}) => 'Категорія <b>${from}</b> буде безповоротно видалена.';
	@override String get merge_success => 'Категорії успішно об\'єднані';
	@override String get delete_success => 'Категорію видалено коректно';
	@override String get delete_warning_header => 'Видалити категорію?';
	@override String delete_warning_message({required Object x}) => 'Ця дія незворотно видалить всі транзакції <b>(${x})</b>, пов\'язані з цією категорією.';
	@override late final _TranslationsCategoriesSelectUk select = _TranslationsCategoriesSelectUk._(_root);
}

// Path: budgets
class _TranslationsBudgetsUk implements _TranslationsBudgetsEn {
	_TranslationsBudgetsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Бюджети';
	@override String get repeated => 'Повторювані';
	@override String get one_time => 'Одноразові';
	@override String get annual => 'Щорічні';
	@override String get week => 'Щотижневі';
	@override String get month => 'Щомісячні';
	@override String get actives => 'Активні';
	@override String get pending => 'Очікує початку';
	@override String get finish => 'Завершені';
	@override String get from_budgeted => 'з ';
	@override String get days_left => 'днів залишилось';
	@override String get days_to_start => 'днів до початку';
	@override String get since_expiration => 'днів після закінчення терміну';
	@override String get no_budgets => 'Здається, що в цьому розділі немає жодних бюджетів для відображення. Розпочніть з створення бюджету, натиснувши кнопку нижче';
	@override String get delete => 'Видалити бюджет';
	@override String get delete_warning => 'Ця дія незворотня. Категорії та транзакції, що стосуються цитати, не будуть видалені';
	@override late final _TranslationsBudgetsFormUk form = _TranslationsBudgetsFormUk._(_root);
	@override late final _TranslationsBudgetsDetailsUk details = _TranslationsBudgetsDetailsUk._(_root);
}

// Path: backup
class _TranslationsBackupUk implements _TranslationsBackupEn {
	_TranslationsBackupUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportUk export = _TranslationsBackupExportUk._(_root);
	@override late final _TranslationsBackupImportUk import = _TranslationsBackupImportUk._(_root);
	@override late final _TranslationsBackupAboutUk about = _TranslationsBackupAboutUk._(_root);
}

// Path: settings
class _TranslationsSettingsUk implements _TranslationsSettingsEn {
	_TranslationsSettingsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Налаштування та вигляд';
	@override String get title_short => 'Налаштування';
	@override String get description => 'Тема додатку, тексти та інші загальні налаштування';
	@override String get edit_profile => 'Редагувати профіль';
	@override String get lang_section => 'Мова та тексти';
	@override String get lang_title => 'Мова додатку';
	@override String get lang_descr => 'Мова, в якій будуть відображатися тексти в додатку';
	@override String get lang_help => 'Якщо ви хочете співпрацювати з перекладами цієї програми, ви можете звернутися до <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>нашого посібник</ a>';
	@override String get locale => 'Регіон';
	@override String get locale_descr => 'Встановіть формат, який буде використовуватися для дат, чисел...';
	@override String get locale_warn => 'Після зміни регіону додаток оновиться';
	@override String get first_day_of_week => 'Перший день тижня';
	@override String get theme_and_colors => 'Тема та кольори';
	@override String get theme => 'Тема';
	@override String get theme_auto => 'Визначено системою';
	@override String get theme_light => 'Світла';
	@override String get theme_dark => 'Темна';
	@override String get amoled_mode => 'Режим AMOLED';
	@override String get amoled_mode_descr => 'Використовуйте чисто чорний шпалери, якщо це можливо. Це трохи допоможе акумулятору пристроїв з екранами AMOLED';
	@override String get dynamic_colors => 'Динамічні кольори';
	@override String get dynamic_colors_descr => 'Використовуйте колір акценту вашої системи, коли це можливо';
	@override String get accent_color => 'Колір акценту';
	@override String get accent_color_descr => 'Виберіть колір, який додаток буде використовувати для виділення певних частин інтерфейсу';
	@override late final _TranslationsSettingsSecurityUk security = _TranslationsSettingsSecurityUk._(_root);
}

// Path: more
class _TranslationsMoreUk implements _TranslationsMoreEn {
	_TranslationsMoreUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Більше';
	@override String get title_long => 'Більше дій';
	@override late final _TranslationsMoreDataUk data = _TranslationsMoreDataUk._(_root);
	@override late final _TranslationsMoreAboutUsUk about_us = _TranslationsMoreAboutUsUk._(_root);
	@override late final _TranslationsMoreHelpUsUk help_us = _TranslationsMoreHelpUsUk._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardUk implements _TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} скопійовано в буфер обміну';
	@override String get error => 'Помилка копіювання';
}

// Path: general.time
class _TranslationsGeneralTimeUk implements _TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Початкова дата';
	@override String get end_date => 'Кінцева дата';
	@override String get from_date => 'З дати';
	@override String get until_date => 'До дати';
	@override String get date => 'Дата';
	@override String get datetime => 'Дата та час';
	@override String get time => 'Час';
	@override String get each => 'Кожний';
	@override String get after => 'Після';
	@override late final _TranslationsGeneralTimeRangesUk ranges = _TranslationsGeneralTimeRangesUk._(_root);
	@override late final _TranslationsGeneralTimePeriodicityUk periodicity = _TranslationsGeneralTimePeriodicityUk._(_root);
	@override late final _TranslationsGeneralTimeCurrentUk current = _TranslationsGeneralTimeCurrentUk._(_root);
	@override late final _TranslationsGeneralTimeAllUk all = _TranslationsGeneralTimeAllUk._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderUk implements _TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Сортувати транзакції';
	@override String get category => 'За категорією';
	@override String get quantity => 'За кількістю';
	@override String get date => 'За датою';
}

// Path: general.validations
class _TranslationsGeneralValidationsUk implements _TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Виправте поля, зазначені у формі, щоб продовжити';
	@override String get required => 'Обов\'язкове поле';
	@override String get positive => 'Повинно бути позитивним';
	@override String min_number({required Object x}) => 'Повинно бути більшим, ніж ${x}';
	@override String max_number({required Object x}) => 'Повинно бути меншим, ніж ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewUk implements _TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Дуже добре!';
			case GenderContext.female:
				return 'Дуже добре!';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Добре';
			case GenderContext.female:
				return 'Добре';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Середнє';
			case GenderContext.female:
				return 'Середнє';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Прийнятно';
			case GenderContext.female:
				return 'Прийнятно';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Дуже погано';
			case GenderContext.female:
				return 'Дуже погано';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Недостатньо даних';
			case GenderContext.female:
				return 'Недостатньо даних';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrUk descr = _TranslationsFinancialHealthReviewDescrUk._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeUk implements _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Шанси на виживання';
	@override String get subtitle => 'З урахуванням вашого балансу, час, на який ви можете обійтися без доходу';
	@override String get text_zero => 'Ви не могли б прожити місяць без доходу з такою швидкістю витрат!';
	@override String get text_one => 'Ви ледве могли б прожити близько місяця без доходу з такою швидкістю витрат!';
	@override String text_other({required Object n}) => 'Ви могли б прожити приблизно <b>${n} місяців</b> без доходу з такою швидкістю витрат.';
	@override String get text_infinite => 'Ви могли б прожити приблизно <b>майже все своє життя</b> без доходу з такою швидкістю витрат.';
	@override String get suggestion => 'Пам\'ятайте, що рекомендується завжди тримати цей відсоток не менше 5 місяців. Якщо ви бачите, що у вас недостатньо збережень, зменште непотрібні витрати.';
	@override String get insufficient_data => 'Схоже, у нас недостатньо витрат, щоб розрахувати, на скільки місяців ви можете вижити без доходу. Введіть кілька транзакцій і повертайтесь сюди, щоб перевірити ваше фінансове здоров\'я';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageUk implements _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Відсоток заощаджень';
	@override String get subtitle => 'Яка частина вашого доходу не витрачена за цей період';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextUk text = _TranslationsFinancialHealthSavingsPercentageTextUk._(_root);
	@override String get suggestion => 'Пам\'ятайте, що рекомендується заощаджувати принаймні 15-20% від вашого доходу.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesUk implements _TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Транспорт';
	@override String get money => 'Гроші';
	@override String get food => 'Їжа';
	@override String get medical => 'Медицина';
	@override String get entertainment => 'Розваги';
	@override String get technology => 'Технології';
	@override String get other => 'Інше';
	@override String get logos_financial_institutions => 'Фінансові установи';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsUk implements _TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get accept => 'Прийняти';
	@override String get skip => 'Пропустити';
	@override String get skip_success => 'Транзакцію успішно пропущено';
	@override String get skip_dialog_title => 'Пропустити транзакцію';
	@override String skip_dialog_msg({required Object date}) => 'Ця дія незворотня. Ми перемістимо дату наступного переходу до ${date}';
	@override String get accept_today => 'Прийняти сьогодні';
	@override String accept_in_required_date({required Object date}) => 'Прийняти в потрібну дату (${date})';
	@override String get accept_dialog_title => 'Прийняти транзакцію';
	@override String get accept_dialog_msg_single => 'Новий статус транзакції буде нульовим. Ви можете знову редагувати статус цієї транзакції в будь-який момент';
	@override String accept_dialog_msg({required Object date}) => 'Ця дія створить нову транзакцію з датою ${date}. Ви зможете переглянути деталі цієї транзакції на сторінці транзакцій';
	@override String get recurrent_rule_finished => 'Правило періодичності було завершено, більше немає платежів!';
}

// Path: transaction.list
class _TranslationsTransactionListUk implements _TranslationsTransactionListEn {
	_TranslationsTransactionListUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Тут не знайдено жодних транзакцій для відображення. Додайте кілька транзакцій у додаток, і, можливо, наступного разу вам пощастить більше';
	@override String get searcher_placeholder => 'Шукати за категорією, описом...';
	@override String get searcher_no_results => 'Не знайдено транзакцій, що відповідають критеріям пошуку';
	@override String get loading => 'Завантаження додаткових транзакцій...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: '${n} вибрано',
		other: 'вибрано ${n}',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: '${n} вибрана транзакція',
		other: '${n} вибраних транзакцій',
	);
	@override late final _TranslationsTransactionListBulkEditUk bulk_edit = _TranslationsTransactionListBulkEditUk._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersUk implements _TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get from_value => 'Від суми';
	@override String get to_value => 'До суми';
	@override String from_value_def({required Object x}) => 'Від ${x}';
	@override String to_value_def({required Object x}) => 'До ${x}';
	@override String from_date_def({required Object date}) => 'З ${date}';
	@override String to_date_def({required Object date}) => 'До ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormUk implements _TranslationsTransactionFormEn {
	_TranslationsTransactionFormUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsUk validators = _TranslationsTransactionFormValidatorsUk._(_root);
	@override String get title => 'Назва транзакції';
	@override String get title_short => 'Назва';
	@override String get value => 'Сума транзакції';
	@override String get tap_to_see_more => 'Натисніть, щоб побачити більше деталей';
	@override String get no_tags => '-- Немає тегів --';
	@override String get description => 'Опис';
	@override String get description_info => 'Натисніть тут, щоб ввести детальніший опис цієї транзакції';
	@override String exchange_to_preferred_title({required Object currency}) => 'Обмінний курс на ${currency}';
	@override String get exchange_to_preferred_in_date => 'На дату транзакції';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedUk implements _TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Скасована транзакція';
	@override String get title_short => 'Перевернутий тр.';
	@override String get description_for_expenses => 'Незважаючи на те, що транзакція типу витрат, ця транзакція має додатну суму. Ці типи транзакцій можна використовувати для представлення повернення раніше зареєстрованих витрат, таких як відшкодування або оплата борг.';
	@override String get description_for_incomes => 'Незважаючи на те, що транзакція є дохідною, ця транзакція має від’ємну суму. Ці типи транзакцій можна використовувати ля анулювання або виправлення неправильно зареєстрованого доходу, для відображення повернення або відшкодування грошей або для обліку сплати боргів».';
}

// Path: transaction.status
class _TranslationsTransactionStatusUk implements _TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Статус',
		other: 'Статуси',
	);
	@override String get display_long => 'Статус транзакції';
	@override String tr_status({required Object status}) => '${status} транзакція';
	@override String get none => 'Без статусу';
	@override String get none_descr => 'Транзакція без певного стану';
	@override String get reconciled => 'Узгоджений';
	@override String get reconciled_descr => 'Ця транзакція вже підтверджена і відповідає реальній транзакції з вашого банку';
	@override String get unreconciled => 'Не узгоджений';
	@override String get unreconciled_descr => 'Ця транзакція ще не підтверджена і тому ще не відображається у ваших реальних банківських рахунках. Однак вона враховується при розрахунку балансів і статистики в Monekin';
	@override String get pending => 'Очікується';
	@override String get pending_descr => 'Ця транзакція очікується і тому не буде враховуватися при розрахунку балансів і статистики';
	@override String get voided => 'Скасований';
	@override String get voided_descr => 'Скасована транзакція через помилку в платежі або будь-яку іншу причину. Вона не буде враховуватися при розрахунку балансів і статистики';
}

// Path: transaction.types
class _TranslationsTransactionTypesUk implements _TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Тип транзакції',
		other: 'Типи транзакцій',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Дохід',
		other: 'Доходи',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Витрата',
		other: 'Витрати',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Переказ',
		other: 'Перекази',
	);
}

// Path: transfer.form
class _TranslationsTransferFormUk implements _TranslationsTransferFormEn {
	_TranslationsTransferFormUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get from => 'Початковий рахунок';
	@override String get to => 'Цільовий рахунок';
	@override late final _TranslationsTransferFormValueInDestinyUk value_in_destiny = _TranslationsTransferFormValueInDestinyUk._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsUk implements _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Повторювана транзакція';
	@override String get descr => 'Наступні переміщення для цієї транзакції показані нижче. Ви можете прийняти перший рух або пропустити цей рух';
	@override String get last_payment_info => 'Цей рух є останнім за повторюваною правилою, тому це правило буде автоматично видалено при підтвердженні цієї дії';
	@override String get delete_header => 'Видалити повторювану транзакцію';
	@override String get delete_message => 'Ця дія є незворотньою і не вплине на транзакції, які ви вже підтвердили/оплатили';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusUk implements _TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Затримано на ${x}d';
	@override String coming_in({required Object x}) => 'Через ${x} днів';
}

// Path: account.types
class _TranslationsAccountTypesUk implements _TranslationsAccountTypesEn {
	_TranslationsAccountTypesUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Тип рахунку';
	@override String get warning => 'Після вибору типу рахунку його не можна буде змінити в майбутньому';
	@override String get normal => 'Звичайний рахунок';
	@override String get normal_descr => 'Використовується для фіксації вашої повсякденної фінансової діяльності. Це найбільш поширений рахунок, який дозволяє додавати витрати, доходи...';
	@override String get saving => 'Зберігаючий рахунок';
	@override String get saving_descr => 'З нього можна тільки додавати та знімати гроші з інших рахунків. Ідеально підходить для початку збереження грошей';
}

// Path: account.form
class _TranslationsAccountFormUk implements _TranslationsAccountFormEn {
	_TranslationsAccountFormUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get name => 'Назва рахунку';
	@override String get name_placeholder => 'Наприклад: Зберігаючий рахунок';
	@override String get notes => 'Примітки';
	@override String get notes_placeholder => 'Введіть примітки/опис про цей рахунок';
	@override String get initial_balance => 'Початковий баланс';
	@override String get current_balance => 'Поточний баланс';
	@override String get create => 'Створити рахунок';
	@override String get edit => 'Редагувати рахунок';
	@override String get currency_not_found_warn => 'У вас немає інформації про обмінні курси для цієї валюти. За замовчуванням буде використано 1.0 як курс обміну. Ви можете змінити це в налаштуваннях';
	@override String get already_exists => 'Вже існує інший з такою самою назвою, будь ласка, введіть іншу';
	@override String get tr_before_opening_date => 'В цьому рахунку є транзакції з датою перед датою відкриття';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteUk implements _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Видалити рахунок?';
	@override String get warning_text => 'Ця дія видалить цей рахунок і всі його транзакції';
	@override String get success => 'Рахунок успішно видалено';
}

// Path: account.close
class _TranslationsAccountCloseUk implements _TranslationsAccountCloseEn {
	_TranslationsAccountCloseUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Закрити рахунок';
	@override String get title_short => 'Закрити';
	@override String get warn => 'Цей рахунок більше не буде відображатися у певних списках, і ви не зможете створювати транзакції в ньому з датою пізніше, ніж вказана нижче. Ця дія не впливає на жодні транзакції або баланс, і ви також можете повторно відкрити цей рахунок у будь-який час. ';
	@override String get should_have_zero_balance => 'Баланс цього рахунку повинен бути 0, щоб його закрити. Будь ласка, відредагуйте рахунок перед продовженням';
	@override String get should_have_no_transactions => 'У цього рахунку є транзакції після вказаної дати закриття. Видаліть їх або відредагуйте дату закриття рахунку перед продовженням';
	@override String get success => 'Рахунок успішно закрито';
	@override String get unarchive_succes => 'Рахунок успішно повторно відкрито';
}

// Path: account.select
class _TranslationsAccountSelectUk implements _TranslationsAccountSelectEn {
	_TranslationsAccountSelectUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get one => 'Виберіть рахунок';
	@override String get all => 'Всі рахунки';
	@override String get multiple => 'Вибрати рахунки';
}

// Path: currencies.form
class _TranslationsCurrenciesFormUk implements _TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'Валюта не може бути однаковою з валютою користувача';
	@override String get specify_a_currency => 'Будь ласка, вкажіть валюту';
	@override String get add => 'Додати обмінний курс';
	@override String get add_success => 'Обмінний курс успішно додано';
	@override String get edit => 'Редагувати обмінний курс';
	@override String get edit_success => 'Обмінний курс успішно відредаговано';
}

// Path: tags.form
class _TranslationsTagsFormUk implements _TranslationsTagsFormEn {
	_TranslationsTagsFormUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get name => 'Назва тегу';
	@override String get description => 'Опис';
}

// Path: tags.select
class _TranslationsTagsSelectUk implements _TranslationsTagsSelectEn {
	_TranslationsTagsSelectUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Вибрати теги';
	@override String get all => 'Усі теги';
}

// Path: categories.select
class _TranslationsCategoriesSelectUk implements _TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Вибрати категорії';
	@override String get select_one => 'Виберіть категорію';
	@override String get select_subcategory => 'Оберіть підкатегорію';
	@override String get without_subcategory => 'Без підкатегорії';
	@override String get all => 'Усі категорії';
	@override String get all_short => 'Усі';
}

// Path: budgets.form
class _TranslationsBudgetsFormUk implements _TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Додати бюджет';
	@override String get name => 'Назва бюджету';
	@override String get value => 'Обмежена кількість';
	@override String get create => 'Додати бюджет';
	@override String get edit => 'Редагувати бюджет';
	@override String get negative_warn => 'Бюджети не можуть мати від\'ємну суму';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsUk implements _TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Деталі бюджету';
	@override String get statistics => 'Статистика';
	@override String get budget_value => 'Заплановано';
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Ви можете витрачати ${dailyAmount} на день ще ${remainingDays} днів';
	@override String get expend_evolution => 'Еволюція витрат';
	@override String get no_transactions => 'Здається, ви не здійснили жодних витрат, пов\'язаних з цим бюджетом';
}

// Path: backup.export
class _TranslationsBackupExportUk implements _TranslationsBackupExportEn {
	_TranslationsBackupExportUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Експорт ваших даних';
	@override String get title_short => 'Експорт';
	@override String get all => 'Повне резервне копіювання';
	@override String get all_descr => 'Експортувати всі ваші дані (рахунки, транзакції, бюджети, налаштування...). Імпортуйте їх знову у будь-який момент, щоб нічого не втратити.';
	@override String get transactions => 'Резервне копіювання транзакцій';
	@override String get transactions_descr => 'Експортуйте ваші транзакції у форматі CSV, щоб ви могли зручніше їх аналізувати в інших програмах або застосунках.';
	@override String get description => 'Завантажте ваші дані у різних форматах';
	@override String get dialog_title => 'Зберегти/Відправити файл';
	@override String success({required Object x}) => 'Файл успішно збережено/завантажено у ${x}';
	@override String get error => 'Помилка при завантаженні файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportUk implements _TranslationsBackupImportEn {
	_TranslationsBackupImportUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Імпорт ваших даних';
	@override String get title_short => 'Імпорт';
	@override String get restore_backup => 'Відновити резервну копію';
	@override String get restore_backup_descr => 'Імпортуйте раніше збережену базу даних з Monekin. Ця дія замінить будь-які поточні дані програми новими даними';
	@override String get restore_backup_warn_description => 'При імпорті нової бази даних ви втратите всі дані, які вже збережено в програмі. Рекомендується зробити резервну копію перед продовженням. Не завантажуйте сюди будь-який файл, походження якого ви не знаєте, завантажуйте лише файли, які ви раніше завантажили з Monekin';
	@override String get restore_backup_warn_title => 'Перезаписати всі дані';
	@override String get select_other_file => 'Вибрати інший файл';
	@override String get tap_to_select_file => 'Торкніться, щоб вибрати файл';
	@override late final _TranslationsBackupImportManualImportUk manual_import = _TranslationsBackupImportManualImportUk._(_root);
	@override String get success => 'Імпорт виконано успішно';
	@override String get cancelled => 'Імпорт скасовано користувачем';
	@override String get error => 'Помилка імпорту файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutUk implements _TranslationsBackupAboutEn {
	_TranslationsBackupAboutUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Інформація про вашу базу даних';
	@override String get create_date => 'Дата створення';
	@override String get modify_date => 'Останнє змінено';
	@override String get last_backup => 'Остання резервна копія';
	@override String get size => 'Розмір';
}

// Path: settings.security
class _TranslationsSettingsSecurityUk implements _TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Безпека';
	@override String get private_mode_at_launch => 'Приватний режим під час запуску';
	@override String get private_mode_at_launch_descr => 'За замовчуванням запускати програму в приватному режимі';
	@override String get private_mode => 'Приватний режим';
	@override String get private_mode_descr => 'Приховати всі грошові значення';
	@override String get private_mode_activated => 'Приватний режим активовано';
	@override String get private_mode_deactivated => 'Приватний режим вимкнено';
}

// Path: more.data
class _TranslationsMoreDataUk implements _TranslationsMoreDataEn {
	_TranslationsMoreDataUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Дані';
	@override String get display_descr => 'Експортуйте та імпортуйте свої дані, щоб нічого не втратити';
	@override String get delete_all => 'Видалити мої дані';
	@override String get delete_all_header1 => 'Зупиніться, молодий падаване ⚠️⚠️';
	@override String get delete_all_message1 => 'Ви впевнені, що хочете продовжити? Всі ваші дані буде остаточно видалено і не може бути відновлено';
	@override String get delete_all_header2 => 'Останній крок ⚠️⚠️';
	@override String get delete_all_message2 => 'Видаляючи обліковий запис, ви видалите всі ваші збережені особисті дані. Ваші облікові записи, транзакції, бюджети та категорії будуть видалені і не можуть бути відновлені. Ви згодні?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsUk implements _TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Інформація про додаток';
	@override String get description => 'Перегляньте умови та іншу важливу інформацію про Monekin. Зв\'яжіться зі спільнотою, повідомте про помилки, залиште пропозиції ...';
	@override late final _TranslationsMoreAboutUsLegalUk legal = _TranslationsMoreAboutUsLegalUk._(_root);
	@override late final _TranslationsMoreAboutUsProjectUk project = _TranslationsMoreAboutUsProjectUk._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsUk implements _TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Допоможіть нам';
	@override String get description => 'Дізнайтеся, як ви можете допомогти Monekin ставати кращим і кращим';
	@override String get rate_us => 'Оцініть нас';
	@override String get rate_us_descr => 'Будь-яка оцінка вітається!';
	@override String get share => 'Поділіться Monekin';
	@override String get share_descr => 'Поділіться нашим додатком з друзями та родиною';
	@override String get share_text => 'Monekin! Найкращий додаток для особистих фінансів. Завантажте його тут';
	@override String get thanks => 'Дякуємо!';
	@override String get thanks_long => 'Ваші внески в Monekin та інші відкриті проекти, великі та малі, роблять великі проекти, подібні до цього, можливими. Дякуємо вам за час, витрачений на внесок.';
	@override String get donate => 'Зробіть пожертву';
	@override String get donate_descr => 'З вашою пожертвою ви допоможете додатку продовжувати отримувати вдосконалення. Що може бути краще, ніж подякувати за виконану роботу, запрошуючи мене на каву?';
	@override String get donate_success => 'Пожертва зроблена. Дуже вдячний за ваш внесок! ❤️';
	@override String get donate_err => 'Ой! Здається, виникла помилка при отриманні вашого платежу';
	@override String get report => 'Повідомити про помилки, залишити пропозиції...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesUk implements _TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Часовий діапазон';
	@override String get it_repeat => 'Повторюється';
	@override String get it_ends => 'Закінчується';
	@override String get forever => 'Назавжди';
	@override late final _TranslationsGeneralTimeRangesTypesUk types = _TranslationsGeneralTimeRangesTypesUk._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Кожного ${range}',
		other: 'Кожних ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Кожного ${range} до ${day}',
		other: 'Кожних ${n} ${range} до ${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Кожного ${range} ${limit} раз',
		other: 'Кожних ${n} ${range} ${limit} раз',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Кожного ${range} один раз',
		other: 'Кожних ${n} ${range} один раз',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Місяць',
		other: 'Місяці',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Рік',
		other: 'Роки',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'День',
		other: 'Дні',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Тиждень',
		other: 'Тижні',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityUk implements _TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Повторення';
	@override String get no_repeat => 'Без повторень';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: 'Повторення',
		other: 'Повторень',
	);
	@override String get diary => 'Щоденно';
	@override String get monthly => 'Щомісяця';
	@override String get annually => 'Щороку';
	@override String get quaterly => 'Щокварталу';
	@override String get weekly => 'Щотижня';
	@override String get custom => 'Власний';
	@override String get infinite => 'Завжди';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentUk implements _TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Цього місяця';
	@override String get annually => 'Цього року';
	@override String get quaterly => 'Цього кварталу';
	@override String get weekly => 'На цьому тижні';
	@override String get infinite => 'Назавжди';
	@override String get custom => 'Власний діапазон';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllUk implements _TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Щоденно';
	@override String get monthly => 'Щомісяця';
	@override String get annually => 'Щороку';
	@override String get quaterly => 'Щокварталу';
	@override String get weekly => 'Щотижня';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrUk implements _TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Схоже, у нас недостатньо витрат, щоб розрахувати ваше фінансове здоров\'я. Додайте деякі витрати/доходи за цей період, щоб дозволити нам допомогти вам!';
	@override String get very_good => 'Вітаємо! Ваше фінансове здоров\'я прекрасне. Сподіваємося, ви продовжите свою успішну хвилю і будете навчатися разом з Monekin';
	@override String get good => 'Чудово! Ваше фінансове здоров\'я гарне. Відвідайте вкладку аналізу, щоб побачити, як зберегти ще більше!';
	@override String get normal => 'Ваше фінансове здоров\'я більш-менш в середньому залишку населення за цей період';
	@override String get bad => 'Схоже, що ваша фінансова ситуація ще не найкраща. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
	@override String get very_bad => 'Хмм, ваше фінансове здоров\'я далеко не відповідає тому, що воно повинно бути. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextUk implements _TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Вітаємо! Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Схоже, ви вже професіонал, продовжуйте в тому ж дусі!';
	@override String normal({required Object value}) => 'Вітаємо, ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду.';
	@override String bad({required Object value}) => 'Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Проте ми вважаємо, що ви все ще можете зробити набагато більше!';
	@override String get very_bad => 'Вау, ви не змогли заощадити нічого протягом цього періоду.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditUk implements _TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Редагувати дати';
	@override String get categories => 'Редагувати категорії';
	@override String get status => 'Редагувати статуси';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsUk implements _TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get zero => 'Значення транзакції не може бути рівним нулю';
	@override String get date_max => 'Обрана дата після поточної. Транзакція буде додана як очікувана';
	@override String get date_after_account_creation => 'Ви не можете створити транзакцію з датою до створення рахунку, до якого вона належить';
	@override String get negative_transfer => 'Монетарна вартість переказу не може бути від\'ємною';
	@override String get transfer_between_same_accounts => 'Облікові записи джерела та призначення не збігаються';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyUk implements _TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Сума переказу в пункті призначення';
	@override String amount_short({required Object amount}) => '${amount} на цільовий рахунок';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportUk implements _TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ручний імпорт';
	@override String get descr => 'Імпортуйте транзакції з файлу .csv вручну';
	@override String get default_account => 'Типовий рахунок';
	@override String get remove_default_account => 'Видалити типовий рахунок';
	@override String get default_category => 'Типова категорія';
	@override String get select_a_column => 'Виберіть стовпець з файлу .csv';
	@override List<String> get steps => [
		'Виберіть ваш файл',
		'Стовпець для суми',
		'Стовпець для рахунку',
		'Стовпець для категорії',
		'Стовпець для дати',
		'інші стовпці',
	];
	@override List<String> get steps_descr => [
		'Виберіть файл .csv з вашого пристрою. Переконайтеся, що в ньому є перший рядок, який описує назву кожного стовпця',
		'Виберіть стовпець, де вказано значення кожної транзакції. Використовуйте від\'ємні значення для витрат та позитивні значення для доходів. Використовуйте крапку як десятковий роздільник',
		'Виберіть стовпець, де вказано рахунок, до якого належить кожна транзакція. Ви також можете вибрати типовий рахунок у випадку, якщо ми не зможемо знайти рахунок, який вам потрібен. Якщо типовий рахунок не вказано, ми створимо його з такою самою назвою',
		'Вкажіть стовпець, де знаходиться назва категорії транзакції. Ви повинні вказати типову категорію, щоб ми призначили цю категорію транзакціям, у випадку, якщо категорія не може бути знайдена',
		'Виберіть стовпець, де вказано дату кожної транзакції. Якщо не вказано, транзакції будуть створені з поточною датою',
		'Вкажіть стовпці для інших необов\'язкових атрибутів транзакцій',
	];
	@override String success({required Object x}) => 'Успішно імпортовано ${x} транзакцій';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalUk implements _TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Юридична інформація';
	@override String get privacy => 'Політика конфіденційності';
	@override String get terms => 'Умови використання';
	@override String get licenses => 'Ліцензії';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectUk implements _TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Проект';
	@override String get contributors => 'Співробітники';
	@override String get contributors_descr => 'Усі розробники, які зробили Monekin краще';
	@override String get contact => 'Зв\'яжіться з нами';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesUk implements _TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesUk._(this._root);

	@override final _TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Цикли';
	@override String get last_days => 'Останні дні';
	@override String last_days_form({required Object x}) => '${x} попередніх днів';
	@override String get all => 'Завжди';
	@override String get date_range => 'Власний діапазон';
}

// Path: <root>
class _TranslationsZhTw implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsZhTw.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhTw,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-TW>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _TranslationsZhTw _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsGeneralZhTw general = _TranslationsGeneralZhTw._(_root);
	@override late final _TranslationsIntroZhTw intro = _TranslationsIntroZhTw._(_root);
	@override late final _TranslationsHomeZhTw home = _TranslationsHomeZhTw._(_root);
	@override late final _TranslationsFinancialHealthZhTw financial_health = _TranslationsFinancialHealthZhTw._(_root);
	@override late final _TranslationsStatsZhTw stats = _TranslationsStatsZhTw._(_root);
	@override late final _TranslationsIconSelectorZhTw icon_selector = _TranslationsIconSelectorZhTw._(_root);
	@override late final _TranslationsTransactionZhTw transaction = _TranslationsTransactionZhTw._(_root);
	@override late final _TranslationsTransferZhTw transfer = _TranslationsTransferZhTw._(_root);
	@override late final _TranslationsRecurrentTransactionsZhTw recurrent_transactions = _TranslationsRecurrentTransactionsZhTw._(_root);
	@override late final _TranslationsAccountZhTw account = _TranslationsAccountZhTw._(_root);
	@override late final _TranslationsCurrenciesZhTw currencies = _TranslationsCurrenciesZhTw._(_root);
	@override late final _TranslationsTagsZhTw tags = _TranslationsTagsZhTw._(_root);
	@override late final _TranslationsCategoriesZhTw categories = _TranslationsCategoriesZhTw._(_root);
	@override late final _TranslationsBudgetsZhTw budgets = _TranslationsBudgetsZhTw._(_root);
	@override late final _TranslationsBackupZhTw backup = _TranslationsBackupZhTw._(_root);
	@override late final _TranslationsSettingsZhTw settings = _TranslationsSettingsZhTw._(_root);
	@override late final _TranslationsMoreZhTw more = _TranslationsMoreZhTw._(_root);
}

// Path: general
class _TranslationsGeneralZhTw implements _TranslationsGeneralEn {
	_TranslationsGeneralZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get cancel => '取消';
	@override String get or => '或';
	@override String get understood => '明白了';
	@override String get unspecified => '未指定';
	@override String get confirm => '確認';
	@override String get continue_text => '繼續';
	@override String get quick_actions => '快速行動';
	@override String get save => '保存';
	@override String get save_changes => '儲存變更';
	@override String get close_and_save => '儲存並關閉';
	@override String get add => '添加';
	@override String get edit => '編輯';
	@override String get balance => '平衡';
	@override String get delete => '刪除';
	@override String get account => '帳戶';
	@override String get accounts => '帳戶';
	@override String get categories => '類別';
	@override String get category => '類別';
	@override String get today => '今天';
	@override String get yesterday => '昨天';
	@override String get filters => '過濾器';
	@override String get see_more => '查看更多';
	@override String get select_all => '全選';
	@override String get deselect_all => '取消全選';
	@override String get empty_warn => '哦！這裡非常空';
	@override String get insufficient_data => '數據不足';
	@override String get show_more_fields => '顯示更多欄位';
	@override String get show_less_fields => '顯示較少的欄位';
	@override String get tap_to_search => '點擊即可搜尋';
	@override late final _TranslationsGeneralClipboardZhTw clipboard = _TranslationsGeneralClipboardZhTw._(_root);
	@override late final _TranslationsGeneralTimeZhTw time = _TranslationsGeneralTimeZhTw._(_root);
	@override late final _TranslationsGeneralTransactionOrderZhTw transaction_order = _TranslationsGeneralTransactionOrderZhTw._(_root);
	@override late final _TranslationsGeneralValidationsZhTw validations = _TranslationsGeneralValidationsZhTw._(_root);
}

// Path: intro
class _TranslationsIntroZhTw implements _TranslationsIntroEn {
	_TranslationsIntroZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get start => '開始';
	@override String get skip => '跳過';
	@override String get next => '下一個';
	@override String get select_your_currency => '選擇您的貨幣';
	@override String get welcome_subtitle => '您的個人財務管家';
	@override String get welcome_subtitle2 => '100% 開放，100% 免費';
	@override String get welcome_footer => '登入即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隱私權政策</a>和<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>應用程式的使用條款</a>';
	@override String get offline_descr_title => '離線帳戶：';
	@override String get offline_descr => '您的資料只會儲存在您的裝置上，只要您不卸載應用程式或更換手機，資料就安全。為防止資料遺失，建議定期從應用程式設定中進行備份。';
	@override String get offline_start => '離線啟動會話';
	@override String get sl1_title => '選擇您的貨幣';
	@override String get sl1_descr => '您的預設貨幣將用於報告和一般圖表。您以後可以隨時在應用程式設定中更改貨幣和應用程式語言';
	@override String get sl2_title => '安全、隱私、可靠';
	@override String get sl2_descr => '您的資料只屬於您。我們將資訊直接儲存在您的設備上，無需通過外部伺服器。這使得即使沒有互聯網也可以使用該應用程式';
	@override String get sl2_descr2 => '此外，該應用程式的源代碼是公開的，任何人都可以對其進行協作並查看它是如何工作的';
	@override String get last_slide_title => '一切準備就緒';
	@override String get last_slide_descr => '有了 Monekin，您終於可以實現您想要的財務獨立。您將擁有圖表、預算、提示、統計數據以及更多有關您的資金的信息。';
	@override String get last_slide_descr2 => '我們希望您享受這次體驗！如有疑問、建議，請隨時與我們聯繫......';
}

// Path: home
class _TranslationsHomeZhTw implements _TranslationsHomeEn {
	_TranslationsHomeZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '儀表板';
	@override String get filter_transactions => '過濾交易';
	@override String get hello_day => '早安，';
	@override String get hello_night => '晚安，';
	@override String get total_balance => '總餘額';
	@override String get my_accounts => '我的帳戶';
	@override String get active_accounts => '活躍帳戶';
	@override String get no_accounts => '尚未建立帳戶';
	@override String get no_accounts_descr => '開始使用 Monekin 的所有魔力。創建至少一個帳戶以開始添加交易';
	@override String get last_transactions => '最後的交易';
	@override String get should_create_account_header => '哎呀！';
	@override String get should_create_account_message => '您必須至少擁有一個非存檔帳戶才能開始創建交易';
}

// Path: financial_health
class _TranslationsFinancialHealthZhTw implements _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '財務健康';
	@override late final _TranslationsFinancialHealthReviewZhTw review = _TranslationsFinancialHealthReviewZhTw._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeZhTw months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeZhTw._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageZhTw savings_percentage = _TranslationsFinancialHealthSavingsPercentageZhTw._(_root);
}

// Path: stats
class _TranslationsStatsZhTw implements _TranslationsStatsEn {
	_TranslationsStatsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '統計數據';
	@override String get balance => '平衡';
	@override String get final_balance => '最終餘額';
	@override String get balance_by_account => '帳戶餘額';
	@override String get balance_by_account_subtitle => '我的大部分錢都在哪裡？';
	@override String get balance_by_currency => '按貨幣餘额';
	@override String get balance_by_currency_subtitle => '我有多少錢的外幣？';
	@override String get balance_evolution => '平衡趨勢';
	@override String get balance_evolution_subtitle => '我的錢比以前多了嗎？';
	@override String get compared_to_previous_period => '與上一时期相比';
	@override String get cash_flow => '現金流';
	@override String get cash_flow_subtitle => '我的支出是否少于我的收入？';
	@override String get by_periods => '按時期';
	@override String get by_categories => '按類別';
	@override String get by_tags => '按標籤';
	@override String get distribution => '分配';
	@override String get finance_health_resume => '恢復';
	@override String get finance_health_breakdown => '分解';
}

// Path: icon_selector
class _TranslationsIconSelectorZhTw implements _TranslationsIconSelectorEn {
	_TranslationsIconSelectorZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '姓名：';
	@override String get icon => '圖示';
	@override String get color => '顏色';
	@override String get select_icon => '選擇一個圖示';
	@override String get select_color => '選擇一種顏色';
	@override String get current_color_selection => '目前選擇';
	@override String get custom_color => '自訂顏色';
	@override String get select_account_icon => '識別您的帳戶';
	@override String get select_category_icon => '確定您的類別';
	@override late final _TranslationsIconSelectorScopesZhTw scopes = _TranslationsIconSelectorScopesZhTw._(_root);
}

// Path: transaction
class _TranslationsTransactionZhTw implements _TranslationsTransactionEn {
	_TranslationsTransactionZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '交易',
		other: '交易',
	);
	@override String get create => '新交易';
	@override String get new_income => '新收入';
	@override String get new_expense => '新開支';
	@override String get new_success => '交易創造成功';
	@override String get edit => '編輯交易';
	@override String get edit_success => '交易編輯成功';
	@override String get edit_multiple => '編輯交易';
	@override String edit_multiple_success({required Object x}) => '${x}筆交易已成功編輯';
	@override String get duplicate => '複製交易';
	@override String get duplicate_short => '複製';
	@override String get duplicate_warning_message => '將在同一日期創建與此相同的交易，您想繼續嗎？';
	@override String get duplicate_success => '交易複製成功';
	@override String get delete => '刪除交易';
	@override String get delete_warning_message => '此操作不可逆轉。您的帳戶當前餘額和所有統計資料都將重新計算';
	@override String get delete_success => '交易已正確刪除';
	@override String get delete_multiple => '刪除交易';
	@override String delete_multiple_warning_message({required Object x}) => '此操作不可逆轉，將刪除${x}筆交易。您帳戶的當前餘額和所有統計資料都將重新計算';
	@override String delete_multiple_success({required Object x}) => '正確刪除了${x}筆交易';
	@override String get details => '動作詳情';
	@override late final _TranslationsTransactionNextPaymentsZhTw next_payments = _TranslationsTransactionNextPaymentsZhTw._(_root);
	@override late final _TranslationsTransactionListZhTw list = _TranslationsTransactionListZhTw._(_root);
	@override late final _TranslationsTransactionFiltersZhTw filters = _TranslationsTransactionFiltersZhTw._(_root);
	@override late final _TranslationsTransactionFormZhTw form = _TranslationsTransactionFormZhTw._(_root);
	@override late final _TranslationsTransactionReversedZhTw reversed = _TranslationsTransactionReversedZhTw._(_root);
	@override late final _TranslationsTransactionStatusZhTw status = _TranslationsTransactionStatusZhTw._(_root);
	@override late final _TranslationsTransactionTypesZhTw types = _TranslationsTransactionTypesZhTw._(_root);
}

// Path: transfer
class _TranslationsTransferZhTw implements _TranslationsTransferEn {
	_TranslationsTransferZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '轉移';
	@override String get transfers => '轉移';
	@override String transfer_to({required Object account}) => '轉移至${account}';
	@override String get create => '轉移';
	@override String get need_two_accounts_warning_header => 'Ops!';
	@override String get need_two_accounts_warning_message => '至少需要兩個帳戶才能執行此操作。如果您需要調整或編輯該帳戶的當前餘額，請點擊編輯按鈕';
	@override late final _TranslationsTransferFormZhTw form = _TranslationsTransferFormZhTw._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsZhTw implements _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '經常交易';
	@override String get title_short => '經常交易';
	@override String get empty => '您似乎沒有任何經常交易。創建每月、每年或每週的經常交易，它將顯示在此處';
	@override String get total_expense_title => '每個期間的總收入';
	@override String get total_expense_descr => '*不考慮每次重複的開始和結束日期';
	@override late final _TranslationsRecurrentTransactionsDetailsZhTw details = _TranslationsRecurrentTransactionsDetailsZhTw._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusZhTw status = _TranslationsRecurrentTransactionsStatusZhTw._(_root);
}

// Path: account
class _TranslationsAccountZhTw implements _TranslationsAccountEn {
	_TranslationsAccountZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get details => '帳戶詳細資料';
	@override String get date => '開業日期';
	@override String get close_date => '截止日期';
	@override String get reopen => '重新開立帳戶';
	@override String get reopen_short => '重新開放';
	@override String get reopen_descr => '您確定要重新開啟此帳戶嗎？';
	@override String get balance => '帳戶餘額';
	@override String get n_transactions => '交易數量';
	@override String get add_money => '增加金額';
	@override String get withdraw_money => '取出金額';
	@override String get no_accounts => '未發現此處顯示的交易。請點選底部的 \'+\' 按鈕新增交易';
	@override late final _TranslationsAccountTypesZhTw types = _TranslationsAccountTypesZhTw._(_root);
	@override late final _TranslationsAccountFormZhTw form = _TranslationsAccountFormZhTw._(_root);
	@override late final _TranslationsAccountDeleteZhTw delete = _TranslationsAccountDeleteZhTw._(_root);
	@override late final _TranslationsAccountCloseZhTw close = _TranslationsAccountCloseZhTw._(_root);
	@override late final _TranslationsAccountSelectZhTw select = _TranslationsAccountSelectZhTw._(_root);
}

// Path: currencies
class _TranslationsCurrenciesZhTw implements _TranslationsCurrenciesEn {
	_TranslationsCurrenciesZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => '貨幣換算';
	@override String get currency => '貨幣';
	@override String get currency_manager => '貨幣管理';
	@override String get currency_manager_descr => '配置您的貨幣及其與其他貨幣的匯率';
	@override String get preferred_currency => '首選/基礎貨幣';
	@override String get change_preferred_currency_title => '更改首選貨幣';
	@override String get change_preferred_currency_msg => '從現在開始，所有統計數據和預算都將以該貨幣顯示。帳戶和交易將保留其所擁有的貨幣。如果您執行此操作，所有保存的匯率都將被刪除。您想繼續嗎？';
	@override late final _TranslationsCurrenciesFormZhTw form = _TranslationsCurrenciesFormZhTw._(_root);
	@override String get delete_all_success => '刪除匯率成功';
	@override String get historical => '歷史利率';
	@override String get exchange_rate => '匯率';
	@override String get exchange_rates => '匯率';
	@override String get empty => '在此處添加匯率，以便如果您的帳戶使用基礎貨幣以外的貨幣，我們的圖表會更加準確';
	@override String get select_a_currency => '選擇貨幣';
	@override String get search => '按名稱或貨幣代碼搜尋';
}

// Path: tags
class _TranslationsTagsZhTw implements _TranslationsTagsEn {
	_TranslationsTagsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '標籤',
		other: '標籤',
	);
	@override late final _TranslationsTagsFormZhTw form = _TranslationsTagsFormZhTw._(_root);
	@override late final _TranslationsTagsSelectZhTw select = _TranslationsTagsSelectZhTw._(_root);
	@override String get empty_list => '您還沒有創建任何標籤。標籤和類別是對您的動作進行分類的好方法';
	@override String get without_tags => '沒有標籤';
	@override String get add => '添加標籤';
	@override String get create => '建立標籤';
	@override String get create_success => '標籤創建成功';
	@override String get already_exists => '此標籤名稱已存在。您可能需要編輯它';
	@override String get edit => '編輯標籤';
	@override String get edit_success => '標籤編輯成功';
	@override String get delete_success => '類別刪除成功';
	@override String get delete_warning_header => '刪除標籤？';
	@override String get delete_warning_message => '此操作不會刪除具有此標籤的交易。';
}

// Path: categories
class _TranslationsCategoriesZhTw implements _TranslationsCategoriesEn {
	_TranslationsCategoriesZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get unknown => '未知類別';
	@override String get create => '創建類別';
	@override String get create_success => '類別創建正確';
	@override String get new_category => '新類別';
	@override String get already_exists => '該類別的名稱已存在。也許您可以編輯';
	@override String get edit => '編輯類別';
	@override String get edit_success => '類別編輯正確';
	@override String get name => '分類名稱';
	@override String get type => '類別類型';
	@override String get both_types => '兩種類型';
	@override String get subcategories => '子類別';
	@override String get subcategories_add => '新增子類別';
	@override String get make_parent => '按類別製作';
	@override String get make_child => '建立一個子類別';
	@override String make_child_warning1({required Object destiny}) => '此類別及其子類別將成為<b>${destiny}</b>的子類別。';
	@override String make_child_warning2({required Object x, required Object destiny}) => '他們的交易<b>(${x})</b>將被移至<b>${destiny}</b>類別中創建的新子類別。';
	@override String get make_child_success => '子類別創建成功';
	@override String get merge => '與另一個類別合併';
	@override String merge_warning1({required Object from, required Object x, required Object destiny}) => '與類別<b>${from}</b>相關的所有交易 (${x}) 將移至類別<b>${destiny}</b>';
	@override String merge_warning2({required Object from}) => '類別<b>${from}</b>將被不可逆轉地刪除。 ';
	@override String get merge_success => '類別合併成功';
	@override String get delete_success => '類別已正確刪除';
	@override String get delete_warning_header => '刪除類別？';
	@override String delete_warning_message({required Object x}) => '此操作將不可逆轉地刪除與此類別相關的所有交易<b>(${x})</b>。';
	@override late final _TranslationsCategoriesSelectZhTw select = _TranslationsCategoriesSelectZhTw._(_root);
}

// Path: budgets
class _TranslationsBudgetsZhTw implements _TranslationsBudgetsEn {
	_TranslationsBudgetsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '預算';
	@override String get repeated => '重複';
	@override String get one_time => '一次';
	@override String get annual => '年度';
	@override String get week => '每週';
	@override String get month => '每月';
	@override String get actives => '活躍';
	@override String get pending => '等待開始';
	@override String get finish => '完成的';
	@override String get from_budgeted => '從預算';
	@override String get days_left => '還剩幾天';
	@override String get days_to_start => '開始的日子';
	@override String get since_expiration => '自到期日起的天數';
	@override String get no_budgets => '此部分中似乎沒有可顯示的預算。首先單擊下面的按鈕以建立預算';
	@override String get delete => '刪除預算';
	@override String get delete_warning => '此操作不可逆轉。引用此報價的類別和交易不會被刪除';
	@override late final _TranslationsBudgetsFormZhTw form = _TranslationsBudgetsFormZhTw._(_root);
	@override late final _TranslationsBudgetsDetailsZhTw details = _TranslationsBudgetsDetailsZhTw._(_root);
}

// Path: backup
class _TranslationsBackupZhTw implements _TranslationsBackupEn {
	_TranslationsBackupZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportZhTw export = _TranslationsBackupExportZhTw._(_root);
	@override late final _TranslationsBackupImportZhTw import = _TranslationsBackupImportZhTw._(_root);
	@override late final _TranslationsBackupAboutZhTw about = _TranslationsBackupAboutZhTw._(_root);
}

// Path: settings
class _TranslationsSettingsZhTw implements _TranslationsSettingsEn {
	_TranslationsSettingsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title_long => '設定和外觀';
	@override String get title_short => '設定';
	@override String get description => '應用程式主題、文字和其他常規設定';
	@override String get edit_profile => '編輯個人資料';
	@override String get lang_section => '語言和文本';
	@override String get lang_title => '應用程式語言';
	@override String get lang_descr => '應用程式中顯示文字的語言';
	@override String get lang_help => '如果您想與此應用程式的翻譯合作，您可以參考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我們的指南</a>';
	@override String get locale => '地區';
	@override String get locale_descr => '設定用於日期、數字的格式...';
	@override String get locale_warn => '更改區域時應用程式將更新';
	@override String get first_day_of_week => '一週的第一天';
	@override String get theme_and_colors => '主題和顏色';
	@override String get theme => '主題';
	@override String get theme_auto => '由系統定義';
	@override String get theme_light => '明亮主題';
	@override String get theme_dark => '黑暗主題';
	@override String get amoled_mode => 'amoled mode';
	@override String get amoled_mode_descr => '盡可能使用純黑色壁紙。這對 AMOLED 螢幕設備的電池略有幫助';
	@override String get dynamic_colors => '動態色彩';
	@override String get dynamic_colors_descr => '盡可能使用系統強調色';
	@override String get accent_color => '強調色';
	@override String get accent_color_descr => '選擇應用程式用來強調介面某些部分的顏色';
	@override late final _TranslationsSettingsSecurityZhTw security = _TranslationsSettingsSecurityZhTw._(_root);
}

// Path: more
class _TranslationsMoreZhTw implements _TranslationsMoreEn {
	_TranslationsMoreZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '更多';
	@override String get title_long => '更多';
	@override late final _TranslationsMoreDataZhTw data = _TranslationsMoreDataZhTw._(_root);
	@override late final _TranslationsMoreAboutUsZhTw about_us = _TranslationsMoreAboutUsZhTw._(_root);
	@override late final _TranslationsMoreHelpUsZhTw help_us = _TranslationsMoreHelpUsZhTw._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardZhTw implements _TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x}已複製到剪貼簿';
	@override String get error => '複製錯誤';
}

// Path: general.time
class _TranslationsGeneralTimeZhTw implements _TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get start_date => '開始日期';
	@override String get end_date => '結束日期';
	@override String get from_date => '從日期';
	@override String get until_date => '截止日期';
	@override String get date => '日期';
	@override String get datetime => '約會時間';
	@override String get time => '時間';
	@override String get each => '每個';
	@override String get after => '後';
	@override late final _TranslationsGeneralTimeRangesZhTw ranges = _TranslationsGeneralTimeRangesZhTw._(_root);
	@override late final _TranslationsGeneralTimePeriodicityZhTw periodicity = _TranslationsGeneralTimePeriodicityZhTw._(_root);
	@override late final _TranslationsGeneralTimeCurrentZhTw current = _TranslationsGeneralTimeCurrentZhTw._(_root);
	@override late final _TranslationsGeneralTimeAllZhTw all = _TranslationsGeneralTimeAllZhTw._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderZhTw implements _TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '訂單交易';
	@override String get category => '按類別';
	@override String get quantity => '按數量';
	@override String get date => '按日期';
}

// Path: general.validations
class _TranslationsGeneralValidationsZhTw implements _TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get form_error => '修正表單中指示的欄位以繼續';
	@override String get required => '必填項目';
	@override String get positive => '應該是積極的';
	@override String min_number({required Object x}) => '應該大於${x}';
	@override String max_number({required Object x}) => '應小於${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewZhTw implements _TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '很好！';
			case GenderContext.female:
				return '很好！';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '好';
			case GenderContext.female:
				return '好';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '平均';
			case GenderContext.female:
				return '平均';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '一般';
			case GenderContext.female:
				return '一般';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '非常糟糕';
			case GenderContext.female:
				return '非常糟糕';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '數據不足';
			case GenderContext.female:
				return '數據不足';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrZhTw descr = _TranslationsFinancialHealthReviewDescrZhTw._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeZhTw implements _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '存活率';
	@override String get subtitle => '考慮到您的餘額，您可以在沒有收入的情況下度過多長時間';
	@override String get text_zero => '按照這樣的開支，沒有收入你一個月都活不下去！';
	@override String get text_one => '按照這樣的收入，如果沒有收入，你幾乎無法生存大約一個月！';
	@override String text_other({required Object n}) => '以這樣的支出速度，如果沒有收入，您大約可以生存 <b>${n}個月</b>。';
	@override String get text_infinite => '以這樣的支出速度，如果沒有收入，您大約可以<b>一生</b>生存。';
	@override String get suggestion => '請記住，建議始終將此比率保持在至少 5 個月以上。如果您發現自己沒有足夠的儲蓄緩衝，請減少不必要的開支。';
	@override String get insufficient_data => '看來我們沒有足夠的開支來計算您在沒有收入的情況下可以生存多少個月。輸入幾筆交易，然後回到這裡檢查您的財務狀況';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageZhTw implements _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '儲蓄百分比';
	@override String get subtitle => '你的收入中有哪一部分沒有在這段時間花掉';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextZhTw text = _TranslationsFinancialHealthSavingsPercentageTextZhTw._(_root);
	@override String get suggestion => '請記住，建議將收入的至少 15-20% 存起來。';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesZhTw implements _TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get transport => '運輸';
	@override String get money => '錢';
	@override String get food => '食物';
	@override String get medical => '健康';
	@override String get entertainment => '閒暇';
	@override String get technology => '技術';
	@override String get other => '其他的';
	@override String get logos_financial_institutions => '金融機構';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsZhTw implements _TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get accept => '接受';
	@override String get skip => '跳過';
	@override String get skip_success => '成功跳過交易';
	@override String get skip_dialog_title => '跳過交易';
	@override String skip_dialog_msg({required Object date}) => '此操作不可逆轉。我們會將下次移動的日期移至${date}';
	@override String get accept_today => '今天接受';
	@override String accept_in_required_date({required Object date}) => '在要求的日期 (${date}) 接受';
	@override String get accept_dialog_title => '接受交易';
	@override String get accept_dialog_msg_single => '該交易的新狀態將為空。您可以隨時重新編輯該交易的狀態';
	@override String accept_dialog_msg({required Object date}) => '此操作將建立日期為${date}的新交易。您將能夠在交易頁面上查看此交易的詳細資訊';
	@override String get recurrent_rule_finished => '循環規則已完成，無需再支付！';
}

// Path: transaction.list
class _TranslationsTransactionListZhTw implements _TranslationsTransactionListEn {
	_TranslationsTransactionListZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get empty => '未發現此處顯示的交易。在應用程式中添加一些交易，也許您下次會有更好的運氣';
	@override String get searcher_placeholder => '按類別、描述搜尋...';
	@override String get searcher_no_results => '未找到符合搜尋條件的交易';
	@override String get loading => '正在加載更多交易...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '${n} 已選取',
		other: '${n} 已選取',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '已選擇 ${n} 筆交易',
		other: '選擇 ${n} 筆交易',
	);
	@override late final _TranslationsTransactionListBulkEditZhTw bulk_edit = _TranslationsTransactionListBulkEditZhTw._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersZhTw implements _TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get from_value => '從金額';
	@override String get to_value => '最多金額';
	@override String from_value_def({required Object x}) => '來自 ${x}';
	@override String to_value_def({required Object x}) => '最多 ${x}';
	@override String from_date_def({required Object date}) => '從${date}開始';
	@override String to_date_def({required Object date}) => '截至 ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormZhTw implements _TranslationsTransactionFormEn {
	_TranslationsTransactionFormZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsZhTw validators = _TranslationsTransactionFormValidatorsZhTw._(_root);
	@override String get title => '交易標題';
	@override String get title_short => '資質';
	@override String get value => '交易價值';
	@override String get tap_to_see_more => '點擊查看更多詳細資訊';
	@override String get no_tags => '-- 無標籤 --';
	@override String get description => '描述';
	@override String get description_info => '點擊此處輸入有關此交易的更詳細描述';
	@override String exchange_to_preferred_title({required Object currency}) => '匯率為${currency}';
	@override String get exchange_to_preferred_in_date => '交易日';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedZhTw implements _TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '逆向交易';
	@override String get title_short => '逆向交易';
	@override String get description_for_expenses => '儘管是收入交易，但它的金額為正數。這些類型的交易可用於表示先前記錄的收入的返還，例如退款或償還債務。';
	@override String get description_for_incomes => '儘管是一項收入交易，但其金額為負數。這些類型的交易可用於作廢或更正錯誤記錄的收入，反映資金的返還或退款或記錄債務的支付。';
}

// Path: transaction.status
class _TranslationsTransactionStatusZhTw implements _TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '地位',
		other: '狀態',
	);
	@override String get display_long => '交易狀態';
	@override String tr_status({required Object status}) => '${status}交易';
	@override String get none => '無國籍';
	@override String get none_descr => '沒有特定狀態的交易';
	@override String get reconciled => '和好了';
	@override String get reconciled_descr => '此交易已經過驗證，並且與您銀行的真實交易相對應';
	@override String get unreconciled => '不甘心';
	@override String get unreconciled_descr => '此交易尚未經過驗證，因此尚未出現在您的真實銀行帳戶中。但是，它將計算 Monekin 中的餘額和統計數據';
	@override String get pending => '待辦的';
	@override String get pending_descr => '此交易正在等待處理，因此在計算餘額和統計數據時不會考慮它';
	@override String get voided => '作廢';
	@override String get voided_descr => '由於付款錯誤或任何其他原因導致的交易無效/取消。在計算餘額和統計時不會考慮該交易';
}

// Path: transaction.types
class _TranslationsTransactionTypesZhTw implements _TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '交易類型',
		other: '交易類型',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '收入',
		other: '收入',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '支出',
		other: '支出',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '轉移',
		other: '轉移',
	);
}

// Path: transfer.form
class _TranslationsTransferFormZhTw implements _TranslationsTransferFormEn {
	_TranslationsTransferFormZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get from => '原始帳戶';
	@override String get to => '目的地帳戶';
	@override late final _TranslationsTransferFormValueInDestinyZhTw value_in_destiny = _TranslationsTransferFormValueInDestinyZhTw._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsZhTw implements _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '經常交易';
	@override String get descr => '此交易的下一步動作如下所示。您可以接受第一步動作或跳過此動作';
	@override String get last_payment_info => '此動作是循環規則的最後一個，因此當確認此動作時，該規則將自動刪除';
	@override String get delete_header => '刪除重複交易';
	@override String get delete_message => '此操作不可逆轉，不會影響您已確認/付款的交易';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusZhTw implements _TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => '延遲了 ${x}d';
	@override String coming_in({required Object x}) => '${x} 天後';
}

// Path: account.types
class _TranslationsAccountTypesZhTw implements _TranslationsAccountTypesEn {
	_TranslationsAccountTypesZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '帳戶類型';
	@override String get warning => '帳戶類型一旦選擇，以後將無法更改';
	@override String get normal => '普通帳戶';
	@override String get normal_descr => '對於記錄您的日常財務很有用。這是最常見的帳戶，它可以讓您添加支出、收入......';
	@override String get saving => '儲蓄帳戶';
	@override String get saving_descr => '您只能從其他帳戶中添加和提取資金。非常適合開始存錢';
}

// Path: account.form
class _TranslationsAccountFormZhTw implements _TranslationsAccountFormEn {
	_TranslationsAccountFormZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '帳戶名稱';
	@override String get name_placeholder => '例如：儲蓄帳戶';
	@override String get notes => '筆記';
	@override String get notes_placeholder => '輸入有關此帳戶的一些註釋/描述';
	@override String get initial_balance => '初始餘額';
	@override String get current_balance => '當前餘額';
	@override String get create => '創建帳戶';
	@override String get edit => '編輯帳戶';
	@override String get currency_not_found_warn => '您沒有該貨幣的匯率資訊。1.0 將用作預設匯率。您可以在設定中修改';
	@override String get already_exists => '已經有另一個同名，請再寫一個';
	@override String get tr_before_opening_date => '該帳戶中有日期早於開戶日期的交易';
	@override String get iban => 'iban';
	@override String get swift => 'swift';
}

// Path: account.delete
class _TranslationsAccountDeleteZhTw implements _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get warning_header => '刪除帳戶？';
	@override String get warning_text => '此操作將刪除該帳戶及其所有交易';
	@override String get success => '帳號刪除成功';
}

// Path: account.close
class _TranslationsAccountCloseZhTw implements _TranslationsAccountCloseEn {
	_TranslationsAccountCloseZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '關閉帳戶';
	@override String get title_short => '關閉';
	@override String get warn => '此帳戶將不再出現在某些清單中，您將無法在其中建立日期晚於下面指定的日期的交易。此操作不會影響任何交易或餘額，您也可以隨時重新開啟此帳戶時間。 ';
	@override String get should_have_zero_balance => '此帳戶中的當前餘額必須為 0 才能關閉它。請在繼續之前編輯帳戶';
	@override String get should_have_no_transactions => '此帳戶在指定的關閉日期之後有交易。請刪除它們或編輯帳戶關閉日期，然後再繼續';
	@override String get success => '帳戶關閉成功';
	@override String get unarchive_succes => '帳戶已成功重新開設';
}

// Path: account.select
class _TranslationsAccountSelectZhTw implements _TranslationsAccountSelectEn {
	_TranslationsAccountSelectZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get one => '選擇一個帳戶';
	@override String get all => '所有帳戶';
	@override String get multiple => '選擇帳戶';
}

// Path: currencies.form
class _TranslationsCurrenciesFormZhTw implements _TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => '幣種不能等於用戶幣種';
	@override String get specify_a_currency => '請指定貨幣';
	@override String get add => '添加匯率';
	@override String get add_success => '匯率新增成功';
	@override String get edit => '編輯匯率';
	@override String get edit_success => '匯率編輯成功';
}

// Path: tags.form
class _TranslationsTagsFormZhTw implements _TranslationsTagsFormEn {
	_TranslationsTagsFormZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '標籤名';
	@override String get description => '描述';
}

// Path: tags.select
class _TranslationsTagsSelectZhTw implements _TranslationsTagsSelectEn {
	_TranslationsTagsSelectZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '選擇標籤';
	@override String get all => '所有標籤';
}

// Path: categories.select
class _TranslationsCategoriesSelectZhTw implements _TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '選擇類別';
	@override String get select_one => '選擇一個類別';
	@override String get select_subcategory => '選擇一個子類別';
	@override String get without_subcategory => '沒有子類別';
	@override String get all => '所有類別';
	@override String get all_short => '全部';
}

// Path: budgets.form
class _TranslationsBudgetsFormZhTw implements _TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '添加預算';
	@override String get name => '預算名稱';
	@override String get value => '數量限制';
	@override String get create => '添加預算';
	@override String get edit => '編輯預算';
	@override String get negative_warn => '預算不能有負數';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsZhTw implements _TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '預算詳情';
	@override String get statistics => '統計數據';
	@override String get budget_value => '預算';
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => '您每天可以花費${dailyAmount}/天，持續${remainingDays}天';
	@override String get expend_evolution => '支出變化';
	@override String get no_transactions => '看來您還沒有做出與此預算相關的任何收入';
}

// Path: backup.export
class _TranslationsBackupExportZhTw implements _TranslationsBackupExportEn {
	_TranslationsBackupExportZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '匯出您的資料';
	@override String get title_short => '匯出';
	@override String get all => '完整備份';
	@override String get all_descr => '匯出您的所有資料（帳戶、交易、預算、設定...）。隨時重新匯入它們，這樣您就不會丟失任何內容。';
	@override String get transactions => '交易備份';
	@override String get transactions_descr => '以 CSV 格式匯出您的交易，以便您可以在其他程式或應用程式中更輕鬆地分析它們。';
	@override String get description => '以不同格式下載資料';
	@override String get dialog_title => '儲存/傳送文件';
	@override String success({required Object x}) => '檔案已在${x}中成功儲存/下載';
	@override String get error => '下載檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員';
}

// Path: backup.import
class _TranslationsBackupImportZhTw implements _TranslationsBackupImportEn {
	_TranslationsBackupImportZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '匯入您的資料';
	@override String get title_short => '匯入';
	@override String get restore_backup => '恢復備份';
	@override String get restore_backup_descr => '從 Monekin 匯入先前儲存的資料庫。此操作將用新資料取代任何當前應用程式資料';
	@override String get restore_backup_warn_description => '導入新資料庫時，您將丟失應用程式中當前保存的所有資料。建議在繼續之前進行備份。請勿在此處上傳任何來源不明的文件，僅上傳您之前從其下載的文件 Monekin';
	@override String get restore_backup_warn_title => '覆蓋所有數據';
	@override String get select_other_file => '選擇其他文件';
	@override String get tap_to_select_file => '點選選擇檔案';
	@override late final _TranslationsBackupImportManualImportZhTw manual_import = _TranslationsBackupImportManualImportZhTw._(_root);
	@override String get success => '導入成功';
	@override String get cancelled => '導入已被用戶取消';
	@override String get error => '匯入檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員。';
}

// Path: backup.about
class _TranslationsBackupAboutZhTw implements _TranslationsBackupAboutEn {
	_TranslationsBackupAboutZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '有關您的資料庫的資訊';
	@override String get create_date => '創建日期';
	@override String get modify_date => '上一次更改';
	@override String get last_backup => '上次備份';
	@override String get size => '檔案大小';
}

// Path: settings.security
class _TranslationsSettingsSecurityZhTw implements _TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '安全';
	@override String get private_mode_at_launch => '啟動時啟用的隱私模式';
	@override String get private_mode_at_launch_descr => '默認以隱私模式啟動應用程序';
	@override String get private_mode => '隱私模式';
	@override String get private_mode_descr => '隱藏所有貨幣值';
	@override String get private_mode_activated => '隱私模式已啟用';
	@override String get private_mode_deactivated => '隱私模式已禁用';
}

// Path: more.data
class _TranslationsMoreDataZhTw implements _TranslationsMoreDataEn {
	_TranslationsMoreDataZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '數據';
	@override String get display_descr => '匯出和匯入您的數據，這樣您就不會丟失任何東西';
	@override String get delete_all => '刪除我的資料';
	@override String get delete_all_header1 => 'Stop right there padawan ⚠️⚠️';
	@override String get delete_all_message1 => '您確定要繼續嗎？您的所有資料將永久刪除且無法恢復';
	@override String get delete_all_header2 => '最後一步⚠️⚠️';
	@override String get delete_all_message2 => '刪除帳戶後，您將刪除所有儲存的個人資料。您的帳戶、交易、預算和類別將被刪除且無法恢復。您同意嗎？';
}

// Path: more.about_us
class _TranslationsMoreAboutUsZhTw implements _TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '應用程式資訊';
	@override String get description => '查看有關 Monekin 的條款和其他相關資訊。透過報告錯誤、留下建議與社區取得聯繫......';
	@override late final _TranslationsMoreAboutUsLegalZhTw legal = _TranslationsMoreAboutUsLegalZhTw._(_root);
	@override late final _TranslationsMoreAboutUsProjectZhTw project = _TranslationsMoreAboutUsProjectZhTw._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsZhTw implements _TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '幫助我們';
	@override String get description => '了解如何幫助 Monekin 變得越來越好';
	@override String get rate_us => '評價我們';
	@override String get rate_us_descr => '歡迎任何價格！';
	@override String get share => '分享 Monekin';
	@override String get share_descr => '與朋友和家人分享我們的應用程式';
	@override String get share_text => 'Monekin！最好的個人理財應用程式。在這裡下載';
	@override String get thanks => '謝謝你！';
	@override String get thanks_long => '您對 Monekin 和其他大大小小的開源專案的貢獻使得這樣偉大的專案成為可能。感謝您花時間做出貢獻。';
	@override String get donate => '做捐贈';
	@override String get donate_descr => '透過您的捐款，您將幫助該應用程式繼續改進。還有什麼比邀請我喝咖啡來感謝所做的工作更好的方式呢？';
	@override String get donate_success => '捐款已完成。非常感謝您的貢獻！❤️';
	@override String get donate_err => '糟糕！接收您的付款時出現錯誤';
	@override String get report => '報告錯誤、留下建議…';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesZhTw implements _TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '時間範圍';
	@override String get it_repeat => '重複';
	@override String get it_ends => '結束';
	@override String get forever => '永遠';
	@override late final _TranslationsGeneralTimeRangesTypesZhTw types = _TranslationsGeneralTimeRangesTypesZhTw._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每個${range}',
		other: '每${n}${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每${range}直到${day}',
		other: '每 ${n}${range}直到${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每${range}${limit}次',
		other: '每${n}${range}${limit}次',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每${range}一次',
		other: '每${n}${range}一次',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '月',
		other: '月',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '年',
		other: '年',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '天',
		other: '天',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '星期',
		other: '幾週',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityZhTw implements _TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '週期性';
	@override String get no_repeat => '不再重複';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '重複',
		other: '重複',
	);
	@override String get diary => '日常的';
	@override String get monthly => '每月';
	@override String get annually => '每年';
	@override String get quaterly => '季刊';
	@override String get weekly => '每週';
	@override String get custom => '風俗';
	@override String get infinite => '總是';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentZhTw implements _TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get monthly => '這個月';
	@override String get annually => '今年';
	@override String get quaterly => '本季';
	@override String get weekly => '本星期';
	@override String get infinite => '永遠';
	@override String get custom => '自訂範圍';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllZhTw implements _TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get diary => '每天';
	@override String get monthly => '每月';
	@override String get annually => '每年';
	@override String get quaterly => '每季';
	@override String get weekly => '每週';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrZhTw implements _TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => '看起來我們沒有足夠的收入來計算您的財務健康狀況。添加這段時間的一些收入/收入，以便我們能夠幫助您！';
	@override String get very_good => '恭喜！您的財務狀況非常好。我們希望您繼續保持良好的勢頭，並繼續與 Monekin 一起學習';
	@override String get good => '太棒了！您的財務狀況良好。請訪問分析選項卡，了解如何節省更多！';
	@override String get normal => '您的財務健康狀況或多或少處於這一時期其他人口的平均水平';
	@override String get bad => '看來您的財務狀況還不是最好的。探索其餘圖表以了解更多有關您財務狀況的信息';
	@override String get very_bad => '嗯，您的財務健康狀況遠低於應有的水平。探索其餘圖表以了解有關您財務狀況的更多信息';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextZhTw implements _TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => '恭喜您！您在這段時間裡成功節省了收入的<b>${value}%</b>。看來您已經是專家了，繼續努力吧！';
	@override String normal({required Object value}) => '恭喜您，在此期間您已成功節省收入的 <b>${value}%</b>。';
	@override String bad({required Object value}) => '在此期間，您已成功節省了收入的 <b>${value}%</b>。但是，我們認為您還可以做得更多！';
	@override String get very_bad => '哇哦，這段時間你什麼都沒保存下來。';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditZhTw implements _TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get dates => '編輯日期';
	@override String get categories => '編輯類別';
	@override String get status => '編輯狀態';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsZhTw implements _TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get zero => '一筆交易的價值不能等於零';
	@override String get date_max => '所選日期晚於當前日期。交易將新增為待處理';
	@override String get date_after_account_creation => '您無法建立日期早於所屬帳戶建立日期的交易';
	@override String get negative_transfer => '轉帳的貨幣價值不能為負數';
	@override String get transfer_between_same_accounts => '來源帳號與目標帳號不能符合';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyZhTw implements _TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '目的地轉帳金额';
	@override String amount_short({required Object amount}) => '${amount}至目標帳户';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportZhTw implements _TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '手動導入';
	@override String get descr => '手動從 .csv 檔案匯入交易';
	@override String get default_account => '預設帳戶';
	@override String get remove_default_account => '刪除預設帳戶';
	@override String get default_category => '預設類別';
	@override String get select_a_column => '從 .csv 中選擇一列';
	@override List<String> get steps => [
		'選擇您的文件',
		'數量欄位',
		'帳戶欄位',
		'類別欄位',
		'日期欄位',
		'其他欄位',
	];
	@override List<String> get steps_descr => [
		'從您的裝置中選擇一個 .csv 檔案。確保它的第一行描述了每列的名稱。',
		'選擇每筆交易價值的欄位。使用負值表示支出，使用正值表示收入。使用點作為小數點分隔符號。',
		'選擇每筆交易所屬帳戶的列。您也可以選擇預設帳戶，以防我們找不到您想要的帳戶。如果未指定預設帳戶，我們將建立一個同名帳戶。',
		'選擇交易類別名稱所在的欄位。您必須指定一個預設類別，以便我們將此類別指派給交易，以防找不到該類別。',
		'選擇每筆交易日期的欄位。如果未指定，交易將使用當前日期建立。',
		'選擇其他交易屬性的資料列',
	];
	@override String success({required Object x}) => '已成功導入${x}筆交易';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalZhTw implements _TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '法律資訊';
	@override String get privacy => '隱私權政策';
	@override String get terms => '使用條款';
	@override String get licenses => '許可證';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectZhTw implements _TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '專案';
	@override String get contributors => '合作者';
	@override String get contributors_descr => '所有讓 Monekin 成長的開發者';
	@override String get contact => '聯絡我們';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesZhTw implements _TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesZhTw._(this._root);

	@override final _TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get cycle => '循環';
	@override String get last_days => '最後一天';
	@override String last_days_form({required Object x}) => '前${x}天';
	@override String get all => '總是';
	@override String get date_range => '自訂範圍';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'general.cancel': return 'Cancel';
			case 'general.or': return 'or';
			case 'general.understood': return 'Understood';
			case 'general.unspecified': return 'Unspecified';
			case 'general.confirm': return 'Confirm';
			case 'general.continue_text': return 'Continue';
			case 'general.quick_actions': return 'Quick actions';
			case 'general.save': return 'Save';
			case 'general.save_changes': return 'Save changes';
			case 'general.close_and_save': return 'Save and close';
			case 'general.add': return 'Add';
			case 'general.edit': return 'Edit';
			case 'general.balance': return 'Balance';
			case 'general.delete': return 'Delete';
			case 'general.account': return 'Account';
			case 'general.accounts': return 'Accounts';
			case 'general.categories': return 'Categories';
			case 'general.category': return 'Category';
			case 'general.today': return 'Today';
			case 'general.yesterday': return 'Yesterday';
			case 'general.filters': return 'Filters';
			case 'general.see_more': return 'See more';
			case 'general.select_all': return 'Select all';
			case 'general.deselect_all': return 'Deselect all';
			case 'general.empty_warn': return 'Ops! This is very empty';
			case 'general.insufficient_data': return 'Insufficient data';
			case 'general.show_more_fields': return 'Show more fields';
			case 'general.show_less_fields': return 'Show less fields';
			case 'general.tap_to_search': return 'Tap to search';
			case 'general.clipboard.success': return ({required Object x}) => '${x} copied to the clipboard';
			case 'general.clipboard.error': return 'Error copying';
			case 'general.time.start_date': return 'Start date';
			case 'general.time.end_date': return 'End date';
			case 'general.time.from_date': return 'From date';
			case 'general.time.until_date': return 'Until date';
			case 'general.time.date': return 'Date';
			case 'general.time.datetime': return 'Datetime';
			case 'general.time.time': return 'Time';
			case 'general.time.each': return 'Each';
			case 'general.time.after': return 'After';
			case 'general.time.ranges.display': return 'Time range';
			case 'general.time.ranges.it_repeat': return 'Repeats';
			case 'general.time.ranges.it_ends': return 'Ends';
			case 'general.time.ranges.forever': return 'Forever';
			case 'general.time.ranges.types.cycle': return 'Cycles';
			case 'general.time.ranges.types.last_days': return 'Last days';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '${x} previous days';
			case 'general.time.ranges.types.all': return 'Always';
			case 'general.time.ranges.types.date_range': return 'Custom range';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range}',
				other: 'Every ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range} until ${day}',
				other: 'Every ${n} ${range} until ${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range} ${limit} times',
				other: 'Every ${n} ${range} ${limit} times',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range} once',
				other: 'Every ${n} ${range} once',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Month',
				other: 'Months',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Year',
				other: 'Years',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Day',
				other: 'Days',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Week',
				other: 'Weeks',
			);
			case 'general.time.periodicity.display': return 'Recurrence';
			case 'general.time.periodicity.no_repeat': return 'No repeat';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Repetition',
				other: 'Repetitions',
			);
			case 'general.time.periodicity.diary': return 'Daily';
			case 'general.time.periodicity.monthly': return 'Monthly';
			case 'general.time.periodicity.annually': return 'Annually';
			case 'general.time.periodicity.quaterly': return 'Quarterly';
			case 'general.time.periodicity.weekly': return 'Weekly';
			case 'general.time.periodicity.custom': return 'Custom';
			case 'general.time.periodicity.infinite': return 'Always';
			case 'general.time.current.monthly': return 'This month';
			case 'general.time.current.annually': return 'This year';
			case 'general.time.current.quaterly': return 'This quarter';
			case 'general.time.current.weekly': return 'This week';
			case 'general.time.current.infinite': return 'For ever';
			case 'general.time.current.custom': return 'Custom Range';
			case 'general.time.all.diary': return 'Every day';
			case 'general.time.all.monthly': return 'Every month';
			case 'general.time.all.annually': return 'Every year';
			case 'general.time.all.quaterly': return 'Every quarterly';
			case 'general.time.all.weekly': return 'Every week';
			case 'general.transaction_order.display': return 'Order transactions';
			case 'general.transaction_order.category': return 'By category';
			case 'general.transaction_order.quantity': return 'By quantity';
			case 'general.transaction_order.date': return 'By date';
			case 'general.validations.form_error': return 'Fix the indicated fields to continue';
			case 'general.validations.required': return 'Required field';
			case 'general.validations.positive': return 'Should be positive';
			case 'general.validations.min_number': return ({required Object x}) => 'Should be greater than ${x}';
			case 'general.validations.max_number': return ({required Object x}) => 'Should be less than ${x}';
			case 'intro.start': return 'Start';
			case 'intro.skip': return 'Skip';
			case 'intro.next': return 'Next';
			case 'intro.select_your_currency': return 'Select your currency';
			case 'intro.welcome_subtitle': return 'Your personal finance manager';
			case 'intro.welcome_subtitle2': return '100% open, 100% free';
			case 'intro.welcome_footer': return 'By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application';
			case 'intro.offline_descr_title': return 'OFFLINE ACCOUNT:';
			case 'intro.offline_descr': return 'Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';
			case 'intro.offline_start': return 'Start session offline';
			case 'intro.sl1_title': return 'Select your currency';
			case 'intro.sl1_descr': return 'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings';
			case 'intro.sl2_title': return 'Safe, private and reliable';
			case 'intro.sl2_descr': return 'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet';
			case 'intro.sl2_descr2': return 'Also, the source code of the application is public, anyone can collaborate on it and see how it works';
			case 'intro.last_slide_title': return 'All ready';
			case 'intro.last_slide_descr': return 'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.';
			case 'intro.last_slide_descr2': return 'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...';
			case 'home.title': return 'Dashboard';
			case 'home.filter_transactions': return 'Filter transactions';
			case 'home.hello_day': return 'Good morning,';
			case 'home.hello_night': return 'Good night,';
			case 'home.total_balance': return 'Total balance';
			case 'home.my_accounts': return 'My accounts';
			case 'home.active_accounts': return 'Active accounts';
			case 'home.no_accounts': return 'No accounts created yet';
			case 'home.no_accounts_descr': return 'Start using all the magic of Monekin. Create at least one account to start adding transactions';
			case 'home.last_transactions': return 'Last transactions';
			case 'home.should_create_account_header': return 'Oops!';
			case 'home.should_create_account_message': return 'You must have at least one no-archived account before you can start creating transactions';
			case 'financial_health.display': return 'Financial health';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Very good!';
					case GenderContext.female:
						return 'Very good!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Good';
					case GenderContext.female:
						return 'Good';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Average';
					case GenderContext.female:
						return 'Average';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Fair';
					case GenderContext.female:
						return 'Fair';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Very Bad';
					case GenderContext.female:
						return 'Very Bad';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Insufficient data';
					case GenderContext.female:
						return 'Insufficient data';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'It looks like we don\'t have enough expenses to calculate your financial health. Add some expenses/incomes in this period to allow us to help you!';
			case 'financial_health.review.descr.very_good': return 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';
			case 'financial_health.review.descr.good': return 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';
			case 'financial_health.review.descr.normal': return 'Your financial health is more or less in the average of the rest of the population for this period';
			case 'financial_health.review.descr.bad': return 'It seems that your financial situation is not the best yet. Explore the rest of the charts to learn more about your finances';
			case 'financial_health.review.descr.very_bad': return 'Hmm, your financial health is far below what it should be. Explore the rest of the charts to learn more about your finances';
			case 'financial_health.months_without_income.title': return 'Survival rate';
			case 'financial_health.months_without_income.subtitle': return 'Given your balance, amount of time you could go without income';
			case 'financial_health.months_without_income.text_zero': return 'You couldn\'t survive a month without income at this rate of expenses!';
			case 'financial_health.months_without_income.text_one': return 'You could barely survive approximately a month without income at this rate of expenses!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'You could survive approximately <b>${n} months</b> without income at this rate of spending.';
			case 'financial_health.months_without_income.text_infinite': return 'You could survive approximately <b>all your life</b> without income at this rate of spending.';
			case 'financial_health.months_without_income.suggestion': return 'Remember that it is advisable to always keep this ratio above 5 months at least. If you see that you do not have a sufficient savings cushion, reduce unnecessary expenses.';
			case 'financial_health.months_without_income.insufficient_data': return 'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
			case 'financial_health.savings_percentage.title': return 'Savings percentage';
			case 'financial_health.savings_percentage.subtitle': return 'What part of your income is not spent in this period';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Congratulations! You have managed to save <b>${value}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Congratulations, you have managed to save <b>${value}%</b> of your income during this period.';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'You have managed to save <b>${value}%</b> of your income during this period. However, we think you can still do much more!';
			case 'financial_health.savings_percentage.text.very_bad': return 'Wow, you haven\'t managed to save anything during this period.';
			case 'financial_health.savings_percentage.suggestion': return 'Remember that it is advisable to save at least 15-20% of what you earn.';
			case 'stats.title': return 'Statistics';
			case 'stats.balance': return 'Balance';
			case 'stats.final_balance': return 'Final balance';
			case 'stats.balance_by_account': return 'Balance by accounts';
			case 'stats.balance_by_account_subtitle': return 'Where do I have most of my money?';
			case 'stats.balance_by_currency': return 'Balance by currency';
			case 'stats.balance_by_currency_subtitle': return 'How much money do I have in foreign currency?';
			case 'stats.balance_evolution': return 'Balance trend';
			case 'stats.balance_evolution_subtitle': return 'Do I have more money than before?';
			case 'stats.compared_to_previous_period': return 'Compared to the previous period';
			case 'stats.cash_flow': return 'Cash flow';
			case 'stats.cash_flow_subtitle': return 'Am I spending less than I earn?';
			case 'stats.by_periods': return 'By periods';
			case 'stats.by_categories': return 'By categories';
			case 'stats.by_tags': return 'By tags';
			case 'stats.distribution': return 'Distribution';
			case 'stats.finance_health_resume': return 'Resume';
			case 'stats.finance_health_breakdown': return 'Breakdown';
			case 'icon_selector.name': return 'Name:';
			case 'icon_selector.icon': return 'Icon';
			case 'icon_selector.color': return 'Color';
			case 'icon_selector.select_icon': return 'Select an icon';
			case 'icon_selector.select_color': return 'Select a color';
			case 'icon_selector.custom_color': return 'Custom color';
			case 'icon_selector.current_color_selection': return 'Current selection';
			case 'icon_selector.select_account_icon': return 'Identify your account';
			case 'icon_selector.select_category_icon': return 'Identify your category';
			case 'icon_selector.scopes.transport': return 'Transport';
			case 'icon_selector.scopes.money': return 'Money';
			case 'icon_selector.scopes.food': return 'Food';
			case 'icon_selector.scopes.medical': return 'Health';
			case 'icon_selector.scopes.entertainment': return 'Leisure';
			case 'icon_selector.scopes.technology': return 'Technology';
			case 'icon_selector.scopes.other': return 'Others';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Financial institutions';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Transaction',
				other: 'Transactions',
			);
			case 'transaction.create': return 'New transaction';
			case 'transaction.new_income': return 'New income';
			case 'transaction.new_expense': return 'New expense';
			case 'transaction.new_success': return 'Transaction created successfully';
			case 'transaction.edit': return 'Edit transaction';
			case 'transaction.edit_success': return 'Transaction edited successfully';
			case 'transaction.edit_multiple': return 'Edit transactions';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} transactions edited successfully';
			case 'transaction.duplicate': return 'Clone transaction';
			case 'transaction.duplicate_short': return 'Clone';
			case 'transaction.duplicate_warning_message': return 'A transaction identical to this will be created with the same date, do you want to continue?';
			case 'transaction.duplicate_success': return 'Transaction cloned successfully';
			case 'transaction.delete': return 'Delete transaction';
			case 'transaction.delete_warning_message': return 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';
			case 'transaction.delete_success': return 'Transaction deleted correctly';
			case 'transaction.delete_multiple': return 'Delete transactions';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'This action is irreversible and will remove ${x} transactions. The current balance of your accounts and all your statistics will be recalculated';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} transactions deleted correctly';
			case 'transaction.details': return 'Movement details';
			case 'transaction.next_payments.accept': return 'Accept';
			case 'transaction.next_payments.skip': return 'Skip';
			case 'transaction.next_payments.skip_success': return 'Successfully skipped transaction';
			case 'transaction.next_payments.skip_dialog_title': return 'Skip transaction';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'This action is irreversible. We will move the date of the next move to ${date}';
			case 'transaction.next_payments.accept_today': return 'Accept today';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Accept in required date (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'Accept transaction';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'The new status of the transaction will be null. You can re-edit the status of this transaction whenever you want';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'This action will create a new transaction with date ${date}. You will be able to check the details of this transaction on the transaction page';
			case 'transaction.next_payments.recurrent_rule_finished': return 'The recurring rule has been completed, there are no more payments to make!';
			case 'transaction.list.empty': return 'No transactions found to display here. Add a few transactions in the app and maybe you\'ll have better luck next time.';
			case 'transaction.list.searcher_placeholder': return 'Search by category, description...';
			case 'transaction.list.searcher_no_results': return 'No transactions found matching the search criteria';
			case 'transaction.list.loading': return 'Loading more transactions...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} selected',
				other: '${n} selected',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} transaction selected',
				other: '${n} transactions selected',
			);
			case 'transaction.list.bulk_edit.dates': return 'Edit dates';
			case 'transaction.list.bulk_edit.categories': return 'Edit categories';
			case 'transaction.list.bulk_edit.status': return 'Edit statuses';
			case 'transaction.filters.from_value': return 'From amount';
			case 'transaction.filters.to_value': return 'Up to amount';
			case 'transaction.filters.from_value_def': return ({required Object x}) => 'From ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => 'Up to ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => 'From the ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => 'Up to the ${date}';
			case 'transaction.form.validators.zero': return 'The value of a transaction cannot be equal to zero';
			case 'transaction.form.validators.date_max': return 'The selected date is after the current one. The transaction will be added as pending';
			case 'transaction.form.validators.date_after_account_creation': return 'You cannot create a transaction whose date is before the creation date of the account it belongs to';
			case 'transaction.form.validators.negative_transfer': return 'The monetary value of a transfer cannot be negative';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'The origin and the destination account cannot be the same';
			case 'transaction.form.title': return 'Transaction title';
			case 'transaction.form.title_short': return 'Title';
			case 'transaction.form.value': return 'Value of the transaction';
			case 'transaction.form.tap_to_see_more': return 'Tap to see more details';
			case 'transaction.form.no_tags': return '-- No tags --';
			case 'transaction.form.description': return 'Description';
			case 'transaction.form.description_info': return 'Tap here to enter a more detailed description about this transaction';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => 'Exchnage rate to ${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return 'On transaction date';
			case 'transaction.reversed.title': return 'Inverse transaction';
			case 'transaction.reversed.title_short': return 'Inverse tr.';
			case 'transaction.reversed.description_for_expenses': return 'Despite being an expense transaction, it has a positive amount. These types of transactions can be used to represent the return of a previously recorded expense, such as a refund or having the payment of a debt.';
			case 'transaction.reversed.description_for_incomes': return 'Despite being an income transaction, it has a negative amount. These types of transactions can be used to void or correct an income that was incorrectly recorded, to reflect a return or refund of money or to record payment of debts.';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Status',
				other: 'Statuses',
			);
			case 'transaction.status.display_long': return 'Transaction status';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status} transaction';
			case 'transaction.status.none': return 'Stateless';
			case 'transaction.status.none_descr': return 'Transaction without a specific state';
			case 'transaction.status.reconciled': return 'Reconciled';
			case 'transaction.status.reconciled_descr': return 'This transaction has already been validated and corresponds to a real transaction from your bank';
			case 'transaction.status.unreconciled': return 'Unreconciled';
			case 'transaction.status.unreconciled_descr': return 'This transaction has not yet been validated and therefore does not yet appear in your real bank accounts. However, it counts for the calculation of balances and statistics in Monekin';
			case 'transaction.status.pending': return 'Pending';
			case 'transaction.status.pending_descr': return 'This transaction is pending and therefore it will not be taken into account when calculating balances and statistics';
			case 'transaction.status.voided': return 'Voided';
			case 'transaction.status.voided_descr': return 'Void/cancelled transaction due to payment error or any other reason. It will not be taken into account when calculating balances and statistics';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Transaction type',
				other: 'Transaction types',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Income',
				other: 'Incomes',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Expense',
				other: 'Expenses',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Transfer',
				other: 'Transfers',
			);
			case 'transfer.display': return 'Transfer';
			case 'transfer.transfers': return 'Transfers';
			case 'transfer.transfer_to': return ({required Object account}) => 'Transfer to ${account}';
			case 'transfer.create': return 'New Transfer';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
			case 'transfer.form.from': return 'Origin account';
			case 'transfer.form.to': return 'Destination account';
			case 'transfer.form.value_in_destiny.title': return 'Amount transferred at destination';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} to target account';
			case 'recurrent_transactions.title': return 'Recurrent transactions';
			case 'recurrent_transactions.title_short': return 'Rec. transactions';
			case 'recurrent_transactions.empty': return 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
			case 'recurrent_transactions.total_expense_title': return 'Total expense per period';
			case 'recurrent_transactions.total_expense_descr': return '* Without considering the start and end date of each recurrence';
			case 'recurrent_transactions.details.title': return 'Recurrent transaction';
			case 'recurrent_transactions.details.descr': return 'The next moves for this transaction are shown below. You can accept the first move or skip this move';
			case 'recurrent_transactions.details.last_payment_info': return 'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action';
			case 'recurrent_transactions.details.delete_header': return 'Delete recurring transaction';
			case 'recurrent_transactions.details.delete_message': return 'This action is irreversible and will not affect transactions you have already confirmed/paid for';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => 'Delayed by ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => 'In ${x} days';
			case 'account.details': return 'Account details';
			case 'account.date': return 'Opening date';
			case 'account.close_date': return 'Closing date';
			case 'account.reopen': return 'Re-open account';
			case 'account.reopen_short': return 'Re-open';
			case 'account.reopen_descr': return 'Are you sure you want to reopen this account?';
			case 'account.balance': return 'Account balance';
			case 'account.n_transactions': return 'Number of transactions';
			case 'account.add_money': return 'Add money';
			case 'account.withdraw_money': return 'Withdraw money';
			case 'account.no_accounts': return 'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
			case 'account.types.title': return 'Account type';
			case 'account.types.warning': return 'Once the type of account has been chosen, it cannot be changed in the future';
			case 'account.types.normal': return 'Normal account';
			case 'account.types.normal_descr': return 'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...';
			case 'account.types.saving': return 'Savings account';
			case 'account.types.saving_descr': return 'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money';
			case 'account.form.name': return 'Account name';
			case 'account.form.name_placeholder': return 'Ex: Savings account';
			case 'account.form.notes': return 'Notes';
			case 'account.form.notes_placeholder': return 'Type some notes/description about this account';
			case 'account.form.initial_balance': return 'Initial balance';
			case 'account.form.current_balance': return 'Current balance';
			case 'account.form.create': return 'Create account';
			case 'account.form.edit': return 'Edit account';
			case 'account.form.currency_not_found_warn': return 'You do not have information on exchange rates for this currency. 1.0 will be used as the default exchange rate. You can modify this in the settings';
			case 'account.form.already_exists': return 'There is already another one with the same name, please write another';
			case 'account.form.tr_before_opening_date': return 'There are transactions in this account with a date before the opening date';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return 'Delete account?';
			case 'account.delete.warning_text': return 'This action will delete this account and all its transactions';
			case 'account.delete.success': return 'Account deleted successfully';
			case 'account.close.title': return 'Close account';
			case 'account.close.title_short': return 'Close';
			case 'account.close.warn': return 'This account will no longer appear in certain listings and you will not be able to create transactions in it with a date later than the one specified below. This action does not affect any transactions or balance, and you can also reopen this account at any time. ';
			case 'account.close.should_have_zero_balance': return 'You must have a current balance of 0 in this account to close it. Please edit the account before continuing';
			case 'account.close.should_have_no_transactions': return 'This account has transactions after the specified close date. Delete them or edit the account close date before continuing';
			case 'account.close.success': return 'Account closed successfully';
			case 'account.close.unarchive_succes': return 'Account successfully re-opened';
			case 'account.select.one': return 'Select an account';
			case 'account.select.all': return 'All accounts';
			case 'account.select.multiple': return 'Select accounts';
			case 'currencies.currency_converter': return 'Currency converter';
			case 'currencies.currency': return 'Currency';
			case 'currencies.currency_manager': return 'Currency manager';
			case 'currencies.currency_manager_descr': return 'Configure your currency and its exchange rates with others';
			case 'currencies.preferred_currency': return 'Preferred/base currency';
			case 'currencies.change_preferred_currency_title': return 'Change preferred currency';
			case 'currencies.change_preferred_currency_msg': return 'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?';
			case 'currencies.form.equal_to_preferred_warn': return 'The currency cannot be equal to the user currency';
			case 'currencies.form.specify_a_currency': return 'Please specify a currency';
			case 'currencies.form.add': return 'Add exchange rate';
			case 'currencies.form.add_success': return 'Exchange rate added successfully';
			case 'currencies.form.edit': return 'Edit exchange rate';
			case 'currencies.form.edit_success': return 'Exchange rate edited successfully';
			case 'currencies.delete_all_success': return 'Deleted exchange rates successfully';
			case 'currencies.historical': return 'Historical rates';
			case 'currencies.exchange_rate': return 'Exchange rate';
			case 'currencies.exchange_rates': return 'Exchange rates';
			case 'currencies.empty': return 'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate';
			case 'currencies.select_a_currency': return 'Select a currency';
			case 'currencies.search': return 'Search by name or by currency code';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Label',
				other: 'Tags',
			);
			case 'tags.form.name': return 'Tag name';
			case 'tags.form.description': return 'Description';
			case 'tags.select.title': return 'Select tags';
			case 'tags.select.all': return 'All the tags';
			case 'tags.empty_list': return 'You haven\'t created any tags yet. Tags and categories are a great way to categorize your movements';
			case 'tags.without_tags': return 'Without tags';
			case 'tags.add': return 'Add tag';
			case 'tags.create': return 'Create label';
			case 'tags.create_success': return 'Label created successfully';
			case 'tags.already_exists': return 'This tag name already exists. You may want to edit it';
			case 'tags.edit': return 'Edit tag';
			case 'tags.edit_success': return 'Tag edited successfully';
			case 'tags.delete_success': return 'Category deleted successfully';
			case 'tags.delete_warning_header': return 'Delete tag?';
			case 'tags.delete_warning_message': return 'This action will not delete transactions that have this tag.';
			case 'categories.unknown': return 'Unknown category';
			case 'categories.create': return 'Create category';
			case 'categories.create_success': return 'Category created correctly';
			case 'categories.new_category': return 'New category';
			case 'categories.already_exists': return 'The name of this category already exists. Maybe you want to edit it';
			case 'categories.edit': return 'Edit category';
			case 'categories.edit_success': return 'Category edited correctly';
			case 'categories.name': return 'Category name';
			case 'categories.type': return 'Category type';
			case 'categories.both_types': return 'Both types';
			case 'categories.subcategories': return 'Subcategories';
			case 'categories.subcategories_add': return 'Add subcategory';
			case 'categories.make_parent': return 'Make to category';
			case 'categories.make_child': return 'Make a subcategory';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'This category and its subcategories will become subcategories of <b>${destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'Their transactions <b>(${x})</b> will be moved to the new subcategories created within the <b>${destiny}</b> category.';
			case 'categories.make_child_success': return 'Subcategories created successfully';
			case 'categories.merge': return 'Merge with another category';
			case 'categories.merge_warning1': return ({required Object x, required Object from, required Object destiny}) => 'All transactions (${x}) associated with the category <b>${from}</b> will be moved to the category <b>${destiny}</b>';
			case 'categories.merge_warning2': return ({required Object from}) => 'The category <b>${from}</b> will be irreversibly deleted.';
			case 'categories.merge_success': return 'Category merged successfully';
			case 'categories.delete_success': return 'Category deleted correctly';
			case 'categories.delete_warning_header': return 'Delete category?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'This action will irreversibly delete all transactions <b>(${x})</b> related to this category.';
			case 'categories.select.title': return 'Select categories';
			case 'categories.select.select_one': return 'Select a category';
			case 'categories.select.select_subcategory': return 'Choose a subcategory';
			case 'categories.select.without_subcategory': return 'Without subcategory';
			case 'categories.select.all': return 'All categories';
			case 'categories.select.all_short': return 'All';
			case 'budgets.title': return 'Budgets';
			case 'budgets.repeated': return 'Recurring';
			case 'budgets.one_time': return 'Once';
			case 'budgets.annual': return 'Annuals';
			case 'budgets.week': return 'Weekly';
			case 'budgets.month': return 'Monthly';
			case 'budgets.actives': return 'Actives';
			case 'budgets.pending': return 'Pending start';
			case 'budgets.finish': return 'Finished';
			case 'budgets.from_budgeted': return 'left of ';
			case 'budgets.days_left': return 'days left';
			case 'budgets.days_to_start': return 'days to start';
			case 'budgets.since_expiration': return 'days since expiration';
			case 'budgets.no_budgets': return 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';
			case 'budgets.delete': return 'Delete budget';
			case 'budgets.delete_warning': return 'This action is irreversible. Categories and transactions referring to this quote will not be deleted';
			case 'budgets.form.title': return 'Add a budget';
			case 'budgets.form.name': return 'Budget name';
			case 'budgets.form.value': return 'Limit quantity';
			case 'budgets.form.create': return 'Add budget';
			case 'budgets.form.edit': return 'Edit budget';
			case 'budgets.form.negative_warn': return 'The budgets can not have a negative amount';
			case 'budgets.details.title': return 'Budget Details';
			case 'budgets.details.statistics': return 'Statistics';
			case 'budgets.details.budget_value': return 'Budgeted';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => 'You can spend ${dailyAmount}/day for ${remainingDays} remaining days';
			case 'budgets.details.expend_evolution': return 'Expenditure evolution';
			case 'budgets.details.no_transactions': return 'It seems that you have not made any expenses related to this budget';
			case 'backup.export.title': return 'Export your data';
			case 'backup.export.title_short': return 'Export';
			case 'backup.export.all': return 'Full backup';
			case 'backup.export.all_descr': return 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';
			case 'backup.export.transactions': return 'Transactions backup';
			case 'backup.export.transactions_descr': return 'Export your transactions in CSV so you can more easily analyze them in other programs or applications.';
			case 'backup.export.description': return 'Download your data in different formats';
			case 'backup.export.dialog_title': return 'Save/Send file';
			case 'backup.export.success': return ({required Object x}) => 'File saved/downloaded successfully in ${x}';
			case 'backup.export.error': return 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
			case 'backup.import.title': return 'Import your data';
			case 'backup.import.title_short': return 'Import';
			case 'backup.import.restore_backup': return 'Restore Backup';
			case 'backup.import.restore_backup_descr': return 'Import a previously saved database from Monekin. This action will replace any current application data with the new data';
			case 'backup.import.restore_backup_warn_description': return 'When importing a new database, you will lose all data currently saved in the app. It is recommended to make a backup before continuing. Do not upload here any file whose origin you do not know, upload only files that you have previously downloaded from Monekin';
			case 'backup.import.restore_backup_warn_title': return 'Overwrite all data';
			case 'backup.import.select_other_file': return 'Select other file';
			case 'backup.import.tap_to_select_file': return 'Tap to select a file';
			case 'backup.import.manual_import.title': return 'Manual import';
			case 'backup.import.manual_import.descr': return 'Import transactions from a .csv file manually';
			case 'backup.import.manual_import.default_account': return 'Default account';
			case 'backup.import.manual_import.remove_default_account': return 'Remove default account';
			case 'backup.import.manual_import.default_category': return 'Default Category';
			case 'backup.import.manual_import.select_a_column': return 'Select a column from the .csv';
			case 'backup.import.manual_import.steps.0': return 'Select your file';
			case 'backup.import.manual_import.steps.1': return 'Column for quantity';
			case 'backup.import.manual_import.steps.2': return 'Column for account';
			case 'backup.import.manual_import.steps.3': return 'Column for category';
			case 'backup.import.manual_import.steps.4': return 'Column for date';
			case 'backup.import.manual_import.steps.5': return 'other columns';
			case 'backup.import.manual_import.steps_descr.0': return 'Select a .csv file from your device. Make sure it has a first row that describes the name of each column';
			case 'backup.import.manual_import.steps_descr.1': return 'Select the column where the value of each transaction is specified. Use negative values for expenses and positive values for income. Use a point as a decimal separator';
			case 'backup.import.manual_import.steps_descr.2': return 'Select the column where the account to which each transaction belongs is specified. You can also select a default account in case we cannot find the account you want. If a default account is not specified, we will create one with the same name ';
			case 'backup.import.manual_import.steps_descr.3': return 'Specify the column where the transaction category name is located. You must specify a default category so that we assign this category to transactions, in case the category cannot be found';
			case 'backup.import.manual_import.steps_descr.4': return 'Select the column where the date of each transaction is specified. If not specified, transactions will be created with the current date';
			case 'backup.import.manual_import.steps_descr.5': return 'Specifies the columns for other optional transaction attributes';
			case 'backup.import.manual_import.success': return ({required Object x}) => 'Successfully imported ${x} transactions';
			case 'backup.import.success': return 'Import performed successfully';
			case 'backup.import.cancelled': return 'Import was cancelled by the user';
			case 'backup.import.error': return 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
			case 'backup.about.title': return 'Information about your database';
			case 'backup.about.create_date': return 'Creation date';
			case 'backup.about.modify_date': return 'Last modified';
			case 'backup.about.last_backup': return 'Last backup';
			case 'backup.about.size': return 'Size';
			case 'settings.title_long': return 'Settings and appearance';
			case 'settings.title_short': return 'Settings';
			case 'settings.description': return 'App theme, texts and other general settings';
			case 'settings.edit_profile': return 'Edit profile';
			case 'settings.lang_section': return 'Language and texts';
			case 'settings.lang_title': return 'App language';
			case 'settings.lang_descr': return 'Language in which the texts will be displayed in the app';
			case 'settings.lang_help': return 'If you want to collaborate with the translations of this app, you can consult <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>our guide</a>';
			case 'settings.locale': return 'Region';
			case 'settings.locale_descr': return 'Set the format to use for dates, numbers...';
			case 'settings.locale_warn': return 'When changing region the app will update';
			case 'settings.first_day_of_week': return 'First day of week';
			case 'settings.theme_and_colors': return 'Theme and colors';
			case 'settings.theme': return 'Theme';
			case 'settings.theme_auto': return 'Defined by the system';
			case 'settings.theme_light': return 'Light';
			case 'settings.theme_dark': return 'Dark';
			case 'settings.amoled_mode': return 'AMOLED mode';
			case 'settings.amoled_mode_descr': return 'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens';
			case 'settings.dynamic_colors': return 'Dynamic colors';
			case 'settings.dynamic_colors_descr': return 'Use your system accent color whenever possible';
			case 'settings.accent_color': return 'Accent color';
			case 'settings.accent_color_descr': return 'Choose the color the app will use to emphasize certain parts of the interface';
			case 'settings.security.title': return 'Seguridad';
			case 'settings.security.private_mode_at_launch': return 'Private mode at launch';
			case 'settings.security.private_mode_at_launch_descr': return 'Launch the app in private mode by default';
			case 'settings.security.private_mode': return 'Private mode';
			case 'settings.security.private_mode_descr': return 'Hide all monetary values';
			case 'settings.security.private_mode_activated': return 'Private mode activated';
			case 'settings.security.private_mode_deactivated': return 'Private mode disabled';
			case 'more.title': return 'More';
			case 'more.title_long': return 'More actions';
			case 'more.data.display': return 'Data';
			case 'more.data.display_descr': return 'Export and import your data so you don\'t lose anything';
			case 'more.data.delete_all': return 'Delete my data';
			case 'more.data.delete_all_header1': return 'Stop right there padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';
			case 'more.data.delete_all_header2': return 'One last step ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
			case 'more.about_us.display': return 'App information';
			case 'more.about_us.description': return 'Check out the terms and other relevant information about Monekin. Get in touch with the community by reporting bugs, leaving suggestions...';
			case 'more.about_us.legal.display': return 'Legal information';
			case 'more.about_us.legal.privacy': return 'Privacy policy';
			case 'more.about_us.legal.terms': return 'Terms of use';
			case 'more.about_us.legal.licenses': return 'Licenses';
			case 'more.about_us.project.display': return 'Project';
			case 'more.about_us.project.contributors': return 'Collaborators';
			case 'more.about_us.project.contributors_descr': return 'All the developers who have made Monekin grow';
			case 'more.about_us.project.contact': return 'Contact us';
			case 'more.help_us.display': return 'Help us';
			case 'more.help_us.description': return 'Find out how you can help Monekin become better and better';
			case 'more.help_us.rate_us': return 'Rate us';
			case 'more.help_us.rate_us_descr': return 'Any rate is welcome!';
			case 'more.help_us.share': return 'Share Monekin';
			case 'more.help_us.share_descr': return 'Share our app to friends and family';
			case 'more.help_us.share_text': return 'Monekin! The best personal finance app. Download it here';
			case 'more.help_us.thanks': return 'Thank you!';
			case 'more.help_us.thanks_long': return 'Your contributions to Monekin and other open source projects, big and small, make great projects like this possible. Thank you for taking the time to contribute.';
			case 'more.help_us.donate': return 'Make a donation';
			case 'more.help_us.donate_descr': return 'With your donation you will help the app continue receiving improvements. What better way than to thank the work done by inviting me to a coffee?';
			case 'more.help_us.donate_success': return 'Donation made. Thank you very much for your contribution! ❤️';
			case 'more.help_us.donate_err': return 'Oops! It seems there was an error receiving your payment';
			case 'more.help_us.report': return 'Report bugs, leave suggestions...';
			default: return null;
		}
	}
}

extension on _TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'general.cancel': return 'Abbruch';
			case 'general.or': return 'oder';
			case 'general.understood': return 'Verstanden';
			case 'general.unspecified': return 'Nicht spezifiziert';
			case 'general.confirm': return 'Bestätigen';
			case 'general.continue_text': return 'Weiter';
			case 'general.quick_actions': return 'Schnelle Aktionen';
			case 'general.save': return 'Speichern';
			case 'general.save_changes': return 'Änderungen speichern';
			case 'general.close_and_save': return 'Speichern und schließen';
			case 'general.add': return 'Hinzufügen';
			case 'general.edit': return 'Bearbeiten';
			case 'general.balance': return 'Kontostand';
			case 'general.delete': return 'Löschen';
			case 'general.account': return 'Konto';
			case 'general.accounts': return 'Konten';
			case 'general.categories': return 'Kategorien';
			case 'general.category': return 'Kategorie';
			case 'general.today': return 'Heute';
			case 'general.yesterday': return 'Gestern';
			case 'general.filters': return 'Filter';
			case 'general.see_more': return 'Mehr sehen';
			case 'general.select_all': return 'Alles auswählen';
			case 'general.deselect_all': return 'Alle abwählen';
			case 'general.empty_warn': return 'Ops! Das ist sehr leer';
			case 'general.insufficient_data': return 'Unzureichende Daten';
			case 'general.show_more_fields': return 'Weitere Felder anzeigen';
			case 'general.show_less_fields': return 'Weniger Felder anzeigen';
			case 'general.tap_to_search': return 'Zum Suchen tippen';
			case 'general.clipboard.success': return ({required Object x}) => '${x} in die Zwischenablage kopiert';
			case 'general.clipboard.error': return 'Fehler beim Kopieren';
			case 'general.time.start_date': return 'Startdatum';
			case 'general.time.end_date': return 'Enddatum';
			case 'general.time.from_date': return 'Ab Datum';
			case 'general.time.until_date': return 'Bis heute';
			case 'general.time.date': return 'Datum';
			case 'general.time.datetime': return 'Datum/Uhrzeit';
			case 'general.time.time': return 'Zeit';
			case 'general.time.each': return 'Jede';
			case 'general.time.after': return 'Nach';
			case 'general.time.ranges.display': return 'Zeitbereich';
			case 'general.time.ranges.it_repeat': return 'Wiederholt';
			case 'general.time.ranges.it_ends': return 'Endet';
			case 'general.time.ranges.forever': return 'Für immer';
			case 'general.time.ranges.types.cycle': return 'Zyklen';
			case 'general.time.ranges.types.last_days': return 'Letzte Tage';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '${x} Vortage';
			case 'general.time.ranges.types.all': return 'Immer';
			case 'general.time.ranges.types.date_range': return 'Benutzerdefinierter Zeitraum';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range}',
				other: 'Jeder ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range} bis ${day}',
				other: 'Jeder ${n} ${range} bis ${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range} ${limit} mal',
				other: 'Jeder ${n} ${range} ${limit} mal',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range} einmal',
				other: 'Jeder ${n} ${range} einmal',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Monat',
				other: 'Monate',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jahr',
				other: 'Jahre',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Tag',
				other: 'Tage',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Woche',
				other: 'Wochen',
			);
			case 'general.time.periodicity.display': return 'Wiederholung';
			case 'general.time.periodicity.no_repeat': return 'Keine Wiederholung';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Wiederholung',
				other: 'Wiederholungen',
			);
			case 'general.time.periodicity.diary': return 'Täglich';
			case 'general.time.periodicity.monthly': return 'Monatlich';
			case 'general.time.periodicity.annually': return 'Jährlich';
			case 'general.time.periodicity.quaterly': return 'Vierteljährlich';
			case 'general.time.periodicity.weekly': return 'Wöchentlich';
			case 'general.time.periodicity.custom': return 'Brauch';
			case 'general.time.periodicity.infinite': return 'Stets';
			case 'general.time.current.monthly': return 'Diesen Monat';
			case 'general.time.current.annually': return 'Dieses Jahr';
			case 'general.time.current.quaterly': return 'Dieses Quartal';
			case 'general.time.current.weekly': return 'Diese Woche';
			case 'general.time.current.infinite': return 'Für immer';
			case 'general.time.current.custom': return 'Benutzerdefinierter Zeitraum';
			case 'general.time.all.diary': return 'Täglich';
			case 'general.time.all.monthly': return 'Jeden Monat';
			case 'general.time.all.annually': return 'Jährlich';
			case 'general.time.all.quaterly': return 'Vierteljährlich';
			case 'general.time.all.weekly': return 'Jede Woche';
			case 'general.transaction_order.display': return 'Bestellvorgänge';
			case 'general.transaction_order.category': return 'Nach Kategorie';
			case 'general.transaction_order.quantity': return 'Nach Menge';
			case 'general.transaction_order.date': return 'Nach Datum';
			case 'general.validations.form_error': return 'Korrigiere die angegebenen Felder, um fortzufahren';
			case 'general.validations.required': return 'Erforderliches Feld';
			case 'general.validations.positive': return 'Sollte positiv sein';
			case 'general.validations.min_number': return ({required Object x}) => 'Sollte größer sein als ${x}';
			case 'general.validations.max_number': return ({required Object x}) => 'Sollte kleiner sein als ${x}';
			case 'intro.start': return 'Start';
			case 'intro.skip': return 'Überspringen';
			case 'intro.next': return 'Nächste';
			case 'intro.select_your_currency': return 'Wähle Deine Währung aus';
			case 'intro.welcome_subtitle': return 'Dein persönlicher Finanzmanager';
			case 'intro.welcome_subtitle2': return '100 % geöffnet, 100 % kostenlos';
			case 'intro.welcome_footer': return 'Mit der Anmeldung stimmst Du der <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Datenschutzrichtlinie</a> und den <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Nutzungsbedingungen</a> der App zu';
			case 'intro.offline_descr_title': return 'OFFLINE-KONTO:';
			case 'intro.offline_descr': return 'Deine Daten werden nur auf Deinem Gerät gespeichert und sind sicher, solange Du die App nicht deinstallieren oder das Telefon wechselst. ';
			case 'intro.offline_start': return 'Sitzung offline starten';
			case 'intro.sl1_title': return 'Wähle Deine Währung aus';
			case 'intro.sl1_descr': return 'Deine Standardwährung wird in Berichten und allgemeinen Diagrammen verwendet. ';
			case 'intro.sl2_title': return 'Sicher, privat und zuverlässig';
			case 'intro.sl2_descr': return 'Deine Daten gehören nur Dir. ';
			case 'intro.sl2_descr2': return 'Außerdem ist der Quellcode der Anwendung öffentlich, jeder kann daran mitarbeiten und sehen, wie es funktioniert';
			case 'intro.last_slide_title': return 'Alles bereit';
			case 'intro.last_slide_descr': return 'Mit Monekin kannst Du endlich die finanzielle Unabhängigkeit erreichen, die Du dir so sehr wünschst. ';
			case 'intro.last_slide_descr2': return 'Wir hoffen, dass Du Deine Erfahrung genießet! Zögerne nicht, uns im Falle von Fragen oder Vorschlägen zu kontaktieren...';
			case 'home.title': return 'Übersicht';
			case 'home.filter_transactions': return 'Transaktionen filtern';
			case 'home.hello_day': return 'Guten Morgen,';
			case 'home.hello_night': return 'Gute Nacht,';
			case 'home.total_balance': return 'Gesamtbilanz';
			case 'home.my_accounts': return 'Meine Konten';
			case 'home.active_accounts': return 'Aktive Konten';
			case 'home.no_accounts': return 'Es wurden noch keine Konten erstellt';
			case 'home.no_accounts_descr': return 'Beginne, die ganze Magie von Monekin zu nutzen. ';
			case 'home.last_transactions': return 'Letzte Transaktionen';
			case 'home.should_create_account_header': return 'Hoppla!';
			case 'home.should_create_account_message': return 'Du musst über mindestens ein nicht archiviertes Konto verfügen, bevor Du mit der Erstellung von Transaktionen beginnen kannst';
			case 'financial_health.display': return 'Finanzielle Lage';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Sehr gut!';
					case GenderContext.female:
						return 'Sehr gut!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Gut';
					case GenderContext.female:
						return 'Gut';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Durchschnitt';
					case GenderContext.female:
						return 'Durchschnitt';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Mäßig';
					case GenderContext.female:
						return 'Mäßig';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Sehr schlecht';
					case GenderContext.female:
						return 'Sehr schlecht';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Unzureichende Daten';
					case GenderContext.female:
						return 'Unzureichende Daten';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'Es sieht so aus, als hätten wir nicht genügend Ausgaben, um Deine finanzielle Lage zu berechnen. Füge in diesem Zeitraum einige Ausgaben/Einnahmen hinzu, damit wir Dir helfen können!';
			case 'financial_health.review.descr.very_good': return 'Glückwunsch! ';
			case 'financial_health.review.descr.good': return 'Großartig! ';
			case 'financial_health.review.descr.normal': return 'Deine finanzielle Lage entspricht in diesem Zeitraum mehr oder weniger dem Durchschnitt der übrigen Bevölkerung';
			case 'financial_health.review.descr.bad': return 'Es scheint, dass Deine finanzielle Situation noch nicht die beste ist. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
			case 'financial_health.review.descr.very_bad': return 'Hmm, Deine finanzielle Lage ist weit unter dem, was sie sein sollte. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
			case 'financial_health.months_without_income.title': return 'Überlebensrate';
			case 'financial_health.months_without_income.subtitle': return 'Angesichts Deines Guthabens, wie viel Zeit kannst Du ohne Einkommen auskommen?';
			case 'financial_health.months_without_income.text_zero': return 'Bei diesem Ausgabenniveau kannst Du keinen Monat ohne Einkommen überleben!';
			case 'financial_health.months_without_income.text_one': return 'Bei diesem Ausgabenniveau kannst Du kaum etwa einen Monat ohne Einkommen überleben!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'Du könntest ungefähr <b>${n} Monate</b> ohne Einkommen bei dieser Ausgabenrate überleben.';
			case 'financial_health.months_without_income.text_infinite': return 'Du könntest ungefähr <b>Dein ganzes Leben lang</b> ohne Einkommen bei dieser Ausgabenrate überleben.';
			case 'financial_health.months_without_income.suggestion': return 'Denke daran, dass es ratsam ist, dieses Verhältnis immer mindestens über 5 Monate zu halten. Wenn Du feststellst, dass Du nicht über ein ausreichendes Sparpolster verfügst, solltest Du unnötige Ausgaben reduzieren.';
			case 'financial_health.months_without_income.insufficient_data': return 'Offenbar haben wir nicht genügend Ausgaben, um zu berechnen, wie viele Monate Du ohne Einkommen überleben könntest. Gib ein paar Transaktionen ein und komme hierher zurück, um Deine Finanzen zu überprüfen.';
			case 'financial_health.savings_percentage.title': return 'Sparprozentsatz';
			case 'financial_health.savings_percentage.subtitle': return 'Welcher Teil Deines Einkommens wird in diesem Zeitraum nicht ausgegeben?';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen. Es scheint, dass Du bereits ein Experte sind, mache weiter so! ';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'Du hast es geschafft <b>${value}%</b> Deines Einkommens in diesem Zeitraum zu sparen . ';
			case 'financial_health.savings_percentage.text.very_bad': return 'Wow, du hast es in dieser Zeit nicht geschafft, etwas zu sparen.';
			case 'financial_health.savings_percentage.suggestion': return 'Denk daran, dass es ratsam ist, mindestens 15-20 % Deines Einkommens zu sparen.';
			case 'stats.title': return 'Statistiken';
			case 'stats.balance': return 'Kontostand';
			case 'stats.final_balance': return 'Schlussstand';
			case 'stats.balance_by_account': return 'Saldo nach Konten';
			case 'stats.balance_by_account_subtitle': return 'Wo habe ich das meiste Geld?';
			case 'stats.balance_by_currency': return 'Saldo nach Währung';
			case 'stats.balance_by_currency_subtitle': return 'Wie viel Geld habe ich in Fremdwährung?';
			case 'stats.balance_evolution': return 'Trend';
			case 'stats.balance_evolution_subtitle': return 'Habe ich mehr Geld als vorher?';
			case 'stats.compared_to_previous_period': return 'Im Vergleich zur Vorperiode';
			case 'stats.cash_flow': return 'Cashflow';
			case 'stats.cash_flow_subtitle': return 'Gebe ich weniger aus, als ich verdiene?';
			case 'stats.by_periods': return 'Nach Perioden';
			case 'stats.by_categories': return 'Nach Kategorien';
			case 'stats.by_tags': return 'Nach Tags';
			case 'stats.distribution': return 'Verteilung';
			case 'stats.finance_health_resume': return 'Zusammenfassung';
			case 'stats.finance_health_breakdown': return 'Auflüsselung';
			case 'icon_selector.name': return 'Name:';
			case 'icon_selector.icon': return 'Symbol';
			case 'icon_selector.color': return 'Farbe';
			case 'icon_selector.select_icon': return 'Wähle ein Symbol aus';
			case 'icon_selector.select_color': return 'Wähle eine Farbe';
			case 'icon_selector.custom_color': return 'Benutzerdefinierte Farbe';
			case 'icon_selector.current_color_selection': return 'Aktuelle Auswahl';
			case 'icon_selector.select_account_icon': return 'Identifiziere Dein Konto';
			case 'icon_selector.select_category_icon': return 'Identifiziere Deine Kategorie';
			case 'icon_selector.scopes.transport': return 'Transport';
			case 'icon_selector.scopes.money': return 'Geld';
			case 'icon_selector.scopes.food': return 'Essen';
			case 'icon_selector.scopes.medical': return 'Gesundheit';
			case 'icon_selector.scopes.entertainment': return 'Freizeit';
			case 'icon_selector.scopes.technology': return 'Technologie';
			case 'icon_selector.scopes.other': return 'Andere';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Finanzinstitute';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Transaktion',
				other: 'Transaktionen',
			);
			case 'transaction.create': return 'Neue Transaktion';
			case 'transaction.new_income': return 'Neues Einkommen';
			case 'transaction.new_expense': return 'Neue Ausgabe';
			case 'transaction.new_success': return 'Transaktion erfolgreich erstellt';
			case 'transaction.edit': return 'Transaktion bearbeiten';
			case 'transaction.edit_success': return 'Transaktion erfolgreich bearbeitet';
			case 'transaction.edit_multiple': return 'Bearbeite Deine Transaktionen';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} Transaktionen erfolgreich bearbeitet';
			case 'transaction.duplicate': return 'Transaktion klonen';
			case 'transaction.duplicate_short': return 'Klon';
			case 'transaction.duplicate_warning_message': return 'Eine mit dieser identische Transaktion wird mit demselben Datum erstellt. Möchtest Du fortfahren?';
			case 'transaction.duplicate_success': return 'Transaktion erfolgreich geklont';
			case 'transaction.delete': return 'Transaktion löschen';
			case 'transaction.delete_warning_message': return 'Diese Aktion ist irreversibel. ';
			case 'transaction.delete_success': return 'Transaktion korrekt gelöscht';
			case 'transaction.delete_multiple': return 'Transaktionen löschen';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'Diese Aktion ist irreversibel und wird entfernt ${x} Transaktionen. ';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} Transaktionen korrekt gelöscht';
			case 'transaction.details': return 'Bewegungsdetails';
			case 'transaction.next_payments.accept': return 'Akzeptieren';
			case 'transaction.next_payments.skip': return 'Überspringen';
			case 'transaction.next_payments.skip_success': return 'Transaktion erfolgreich übersprungen';
			case 'transaction.next_payments.skip_dialog_title': return 'Transaktion überspringen';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'Diese Aktion ist irreversibel.  ${date}';
			case 'transaction.next_payments.accept_today': return 'Akzeptiere noch heute';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Akzeptierst Du das gewünschte Datum (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'Akzeptierst Du die Transaktion';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'Der neue Status der Transaktion ist null. ';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'Diese Aktion erstellt eine neue Transaktion mit Datum ${date}. Du kannst die Details dieser Transaktion auf der Transaktionsseite überprüfen';
			case 'transaction.next_payments.recurrent_rule_finished': return 'Die wiederkehrende Regel ist abgeschlossen, es sind keine weiteren Zahlungen mehr zu leisten!';
			case 'transaction.list.empty': return 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. ';
			case 'transaction.list.searcher_placeholder': return 'Suche nach Kategorie, Beschreibung...';
			case 'transaction.list.searcher_no_results': return 'Es wurden keine Transaktionen gefunden, die den Suchkriterien entsprechen';
			case 'transaction.list.loading': return 'Weitere Transaktionen werden geladen...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '${n} ausgewählt',
				other: '${n} ausgewählt',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '${n} Transaktion ausgewählt',
				other: '${n} Transaktionen ausgewählt',
			);
			case 'transaction.list.bulk_edit.dates': return 'Daten bearbeiten';
			case 'transaction.list.bulk_edit.categories': return 'Kategorien bearbeiten';
			case 'transaction.list.bulk_edit.status': return 'Status bearbeiten';
			case 'transaction.filters.from_value': return 'Ab Betrag';
			case 'transaction.filters.to_value': return 'Bis zum Betrag';
			case 'transaction.filters.from_value_def': return ({required Object x}) => 'Von ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => 'Bis zu ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => 'Von der ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => 'Bis zum ${date}';
			case 'transaction.form.validators.zero': return 'Der Wert einer Transaktion kann nicht gleich Null sein';
			case 'transaction.form.validators.date_max': return 'Das ausgewählte Datum liegt nach dem aktuellen. ';
			case 'transaction.form.validators.date_after_account_creation': return 'Du kannst keine Transaktion erstellen, deren Datum vor dem Erstellungsdatum des Kontos liegt, zu dem sie gehört';
			case 'transaction.form.validators.negative_transfer': return 'Der Geldwert einer Überweisung darf nicht negativ sein';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'Das Ursprungs- und das Zielkonto dürfen nicht identisch sein';
			case 'transaction.form.title': return 'Transaktionstitel';
			case 'transaction.form.title_short': return 'Titel';
			case 'transaction.form.value': return 'Wert der Transaktion';
			case 'transaction.form.tap_to_see_more': return 'Tippen, um weitere Details anzuzeigen';
			case 'transaction.form.no_tags': return '– Keine Tags –';
			case 'transaction.form.description': return 'Beschreibung';
			case 'transaction.form.description_info': return 'Tippe hier, um eine detailliertere Beschreibung dieser Transaktion einzugeben';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => 'Wechselkurs zu ${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return 'Am Transaktionsdatum';
			case 'transaction.reversed.title': return 'Umgekehrte Transaktion';
			case 'transaction.reversed.title_short': return 'Umgekehrte Tr.';
			case 'transaction.reversed.description_for_expenses': return 'Obwohl es sich um eine Spesentransaktion handelt, weist sie einen positiven Betrag auf. ';
			case 'transaction.reversed.description_for_incomes': return 'Obwohl es sich um eine Einkommenstransaktion handelt, weist sie einen negativen Betrag auf. ';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Status',
				other: 'Status',
			);
			case 'transaction.status.display_long': return 'Transaktionsstatus';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status} Transaktion';
			case 'transaction.status.none': return 'Ohne Status';
			case 'transaction.status.none_descr': return 'Transaktion ohne bestimmten Status';
			case 'transaction.status.reconciled': return 'Ausgeglichen';
			case 'transaction.status.reconciled_descr': return 'Diese Transaktion wurde bereits validiert und entspricht einer echten Transaktion Deiner Bank';
			case 'transaction.status.unreconciled': return 'Unausgeglichen';
			case 'transaction.status.unreconciled_descr': return 'Diese Transaktion wurde noch nicht validiert und erscheint daher noch nicht auf Deinem echten Bankkonten. ';
			case 'transaction.status.pending': return 'Ausstehend';
			case 'transaction.status.pending_descr': return 'Diese Transaktion steht noch aus und wird daher bei der Berechnung von Salden und Statistiken nicht berücksichtigt';
			case 'transaction.status.voided': return 'Entwertet';
			case 'transaction.status.voided_descr': return 'Transaktion aufgrund eines Zahlungsfehlers oder aus einem anderen Grund ungültig/storniert. ';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Transaktionstyp',
				other: 'Transaktiontypen',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Einkommen',
				other: 'Einkommen',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Ausgaben',
				other: 'Ausgaben',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Überweisen',
				other: 'Überweisungen',
			);
			case 'transfer.display': return 'Überweisen';
			case 'transfer.transfers': return 'Überweisungen';
			case 'transfer.transfer_to': return ({required Object account}) => 'Überweisen an ${account}';
			case 'transfer.create': return 'Neue Überweisung';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return 'Um diese Aktion auszuführen, sind mindestens zwei Konten erforderlich. Wenn Du den aktuellen Saldo dieses Kontos anpassen oder bearbeiten möchtest, klicke auf die Schaltfläche Bearbeiten';
			case 'transfer.form.from': return 'Origin-Konto';
			case 'transfer.form.to': return 'Zielkonto';
			case 'transfer.form.value_in_destiny.title': return 'Am Zielkonto überwiesener Betrag';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} zum Zielkonto';
			case 'recurrent_transactions.title': return 'Wiederkehrende Transaktionen';
			case 'recurrent_transactions.title_short': return 'Wiederk. Transakt.';
			case 'recurrent_transactions.empty': return 'Anscheinend hast Du keine wiederkehrenden Transaktionen. Erstelle eine monatliche, jährliche oder wöchentliche wiederkehrende Transaktion, die hier angezeigt wird.';
			case 'recurrent_transactions.total_expense_title': return 'Gesamtausgaben pro Periode';
			case 'recurrent_transactions.total_expense_descr': return '* Ohne Berücksichtigung des Start- und Enddatums jeder Wiederholung';
			case 'recurrent_transactions.details.title': return 'Wiederkehrende Transaktion';
			case 'recurrent_transactions.details.descr': return 'Die nächsten Schritte für diese Transaktion werden unten angezeigt. Du kannst den ersten Schritt akzeptieren oder diesen Schritt auslassen';
			case 'recurrent_transactions.details.last_payment_info': return 'Diese Bewegung ist die letzte der wiederkehrenden Regel, daher wird diese Regel beim Bestätigen dieser Aktion automatisch gelöscht';
			case 'recurrent_transactions.details.delete_header': return 'Wiederkehrende Transaktion löschen';
			case 'recurrent_transactions.details.delete_message': return 'Diese Aktion ist unumkehrbar und hat keinen Einfluss auf Transaktionen, die Du bereits bestätigt/bezahlt habst';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => 'Verzögert um ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => 'In ${x} Tagen';
			case 'account.details': return 'Kontodaten';
			case 'account.date': return 'Eröffnungsdatum';
			case 'account.close_date': return 'Einsendeschluss';
			case 'account.reopen': return 'Konto erneut eröffnen';
			case 'account.reopen_short': return 'Wieder öffnen';
			case 'account.reopen_descr': return 'Möchtest Du dieses Konto wirklich wieder eröffnen?';
			case 'account.balance': return 'Kontostand';
			case 'account.n_transactions': return 'Anzahl der Transaktionen';
			case 'account.add_money': return 'Geld hinzufügen';
			case 'account.withdraw_money': return 'Geld abheben';
			case 'account.no_accounts': return 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. Füge eine Transaktion hinzu, indem Du auf die Schaltfläche „+“ am unteren Rand klickst.';
			case 'account.types.title': return 'Kontotyp';
			case 'account.types.warning': return 'Sobald der Kontotyp ausgewählt wurde, kann er in Zukunft nicht mehr geändert werden';
			case 'account.types.normal': return 'Normales Konto';
			case 'account.types.normal_descr': return 'Nützlich, um Deine täglichen Finanzen aufzuzeichnen. Es ist das gebräuchlichste Konto, das es Dir ermöglicht, Ausgaben, Einnahmen hinzuzufügen';
			case 'account.types.saving': return 'Sparkonto';
			case 'account.types.saving_descr': return 'Du kannst nur Geld von anderen Konten einzahlen und abheben. Perfekt geignet, um Geld zu sparen';
			case 'account.form.name': return 'Kontoname';
			case 'account.form.name_placeholder': return 'Beispiel: Sparkonto';
			case 'account.form.notes': return 'Notizen';
			case 'account.form.notes_placeholder': return 'Gebe einige Notizen/Beschreibungen zu diesem Konto ein';
			case 'account.form.initial_balance': return 'Anfangssaldo';
			case 'account.form.current_balance': return 'Aktueller Kontostand';
			case 'account.form.create': return 'Konto erstellen';
			case 'account.form.edit': return 'Konto bearbeiten';
			case 'account.form.currency_not_found_warn': return 'Du hast keine Informationen zu den Wechselkursen für diese Währung. Als Standardwechselkurs wird 1,0 verwendet. Du kannst das in den Einstellungen ändern';
			case 'account.form.already_exists': return 'Es gibt bereits ein Konto mit demselben Namen, bitte nutze einen anderen';
			case 'account.form.tr_before_opening_date': return 'Auf diesem Konto liegen Transaktionen vor, deren Datum vor dem Eröffnungsdatum liegt';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return 'Konto löschen?';
			case 'account.delete.warning_text': return 'Durch diese Aktion werden dieses Konto und alle seine Transaktionen gelöscht';
			case 'account.delete.success': return 'Konto erfolgreich gelöscht';
			case 'account.close.title': return 'Konto schließen';
			case 'account.close.title_short': return 'Schließen';
			case 'account.close.warn': return 'Dieses Konto wird in bestimmten Einträgen nicht mehr angezeigt und Du kannst darin keine Transaktionen mit einem späteren als dem unten angegebenen Datum erstellen. Diese Aktion hat keine Auswirkungen auf Transaktionen oder Guthaben, und Du kannst dieses Konto auch jederzeit wieder eröffnen.';
			case 'account.close.should_have_zero_balance': return 'Um das Konto schließen zu können, muss der aktuelle Kontostand 0 betragen.  Bitte bearbeite das Konto, bevor du fortfährst';
			case 'account.close.should_have_no_transactions': return 'Auf diesem Konto liegen Transaktionen nach dem angegebenen Schlussdatum vor. Lösche sie oder bearbeite das Datum der Kontoschließung, bevor Du fortfährst';
			case 'account.close.success': return 'Konto erfolgreich geschlossen';
			case 'account.close.unarchive_succes': return 'Konto erfolgreich wiedereröffnet';
			case 'account.select.one': return 'Wähle ein Konto aus';
			case 'account.select.all': return 'Alle Konten';
			case 'account.select.multiple': return 'Wähle Konten aus';
			case 'currencies.currency_converter': return 'Währungsrechner';
			case 'currencies.currency': return 'Währung';
			case 'currencies.currency_manager': return 'Währungsmanager';
			case 'currencies.currency_manager_descr': return 'Konfiguriere Deine Währung und deren Wechselkurse mit anderen';
			case 'currencies.preferred_currency': return 'Bevorzugte/Basis Währung';
			case 'currencies.change_preferred_currency_title': return 'Änder die bevorzugte Währung';
			case 'currencies.change_preferred_currency_msg': return 'Alle Statistiken und Budgets werden ab sofort in dieser Währung angezeigt. Konten und Transaktionen behalten die Währung, die sie hatten. Alle gespeicherten Wechselkurse werden gelöscht, wenn Du diese Aktion ausführst. Möchtest Du fortfahren?';
			case 'currencies.form.equal_to_preferred_warn': return 'Die Währung darf nicht mit der Benutzerwährung übereinstimmen';
			case 'currencies.form.specify_a_currency': return 'Bitte gib eine Währung an';
			case 'currencies.form.add': return 'Wechselkurs hinzufügen';
			case 'currencies.form.add_success': return 'Wechselkurs erfolgreich hinzugefügt';
			case 'currencies.form.edit': return 'Wechselkurs bearbeiten';
			case 'currencies.form.edit_success': return 'Wechselkurs erfolgreich bearbeitet';
			case 'currencies.delete_all_success': return 'Wechselkurse erfolgreich gelöscht';
			case 'currencies.historical': return 'Historische Kurse';
			case 'currencies.exchange_rate': return 'Wechselkurs';
			case 'currencies.exchange_rates': return 'Wechselkurse';
			case 'currencies.empty': return 'Füge hier Wechselkurse hinzu, damit unsere Diagramme genauer sind, wenn Du Konten in anderen Währungen als Deiner Basiswährung hast';
			case 'currencies.select_a_currency': return 'Wähle eine Währung aus';
			case 'currencies.search': return 'Suche nach Name oder Währungscode';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Label',
				other: 'Schlagworte',
			);
			case 'tags.form.name': return 'Schlagworte-Name';
			case 'tags.form.description': return 'Beschreibung';
			case 'tags.select.title': return 'Schlagworte auswählen';
			case 'tags.select.all': return 'Alle Schlagworte';
			case 'tags.empty_list': return 'Du hast noch keine Schlagworte erstellt. Schlagworte und Kategorien sind eine gute Möglichkeit, Deine Bewegungen zu kategorisieren';
			case 'tags.without_tags': return 'Ohne Schlagworte';
			case 'tags.add': return 'Schlagwort hinzufügen';
			case 'tags.create': return 'Label erstellen';
			case 'tags.create_success': return 'Label erfolgreich erstellt';
			case 'tags.already_exists': return 'Dieser Schlagwort-Name existiert bereits. ';
			case 'tags.edit': return 'Schlagwort bearbeiten';
			case 'tags.edit_success': return 'Schlagwort erfolgreich bearbeitet';
			case 'tags.delete_success': return 'Kategorie erfolgreich gelöscht';
			case 'tags.delete_warning_header': return 'Schlagwort löschen?';
			case 'tags.delete_warning_message': return 'Durch diese Aktion werden keine Transaktionen gelöscht, die dieses Schlagwort haben.';
			case 'categories.unknown': return 'Unbekannte Kategorie';
			case 'categories.create': return 'Kategorie erstellen';
			case 'categories.create_success': return 'Kategorie korrekt erstellt';
			case 'categories.new_category': return 'Neue Kategorie';
			case 'categories.already_exists': return 'Der Name dieser Kategorie existiert bereits. Willst du es verändern?';
			case 'categories.edit': return 'Kategorie bearbeiten';
			case 'categories.edit_success': return 'Kategorie korrekt bearbeitet';
			case 'categories.name': return 'Kategoriename';
			case 'categories.type': return 'Kategorietyp';
			case 'categories.both_types': return 'Beide Typen';
			case 'categories.subcategories': return 'Unterkategorien';
			case 'categories.subcategories_add': return 'Unterkategorie hinzufügen';
			case 'categories.make_parent': return 'Zur Kategorie hinzufügen';
			case 'categories.make_child': return 'Erstelle eine Unterkategorie';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'Diese Kategorie und ihre Unterkategorien werden zu Unterkategorien von <b>${destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'Deine Transaktionen <b>(${x})</b> werden in die neuen Unterkategorien verschoben, die innerhalb der Kategorie <b>${destiny}</b> erstellt wurden.';
			case 'categories.make_child_success': return 'Unterkategorien erfolgreich erstellt';
			case 'categories.merge': return 'Mit einer anderen Kategorie zusammenführen';
			case 'categories.merge_warning1': return ({required Object x, required Object from, required Object destiny}) => 'Alle Transaktionen (${x}), die mit der Kategorie <b>${from}</b> verknüpft sind werden in die Kategorie <b>${destiny}</b> verschoben';
			case 'categories.merge_warning2': return ({required Object from}) => 'Die Kategorie <b>${from}</b> werden unwiderruflich gelöscht.';
			case 'categories.merge_success': return 'Die Kategorie wurde erfolgreich zusammengeführt';
			case 'categories.delete_success': return 'Kategorie wurde korrekt gelöscht';
			case 'categories.delete_warning_header': return 'Kategorie löschen?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'Durch diese Aktion werden alle Transaktionen unwiderruflich gelöscht <b>(${x})</b> im Zusammenhang mit dieser Kategorie.';
			case 'categories.select.title': return 'Kategorien auswählen';
			case 'categories.select.select_one': return 'Wähle eine Kategorie aus';
			case 'categories.select.select_subcategory': return 'Wähle eine Unterkategorie';
			case 'categories.select.without_subcategory': return 'Ohne Unterkategorie';
			case 'categories.select.all': return 'Alle Kategorien';
			case 'categories.select.all_short': return 'Alle';
			case 'budgets.title': return 'Budgets';
			case 'budgets.repeated': return 'Wiederkehrend';
			case 'budgets.one_time': return 'Einmalig';
			case 'budgets.annual': return 'Jährlich';
			case 'budgets.week': return 'Wöchentlich';
			case 'budgets.month': return 'Monatlich';
			case 'budgets.actives': return 'Aktive';
			case 'budgets.pending': return 'Ausstehender Start';
			case 'budgets.finish': return 'Fertig';
			case 'budgets.from_budgeted': return 'übrig von ';
			case 'budgets.days_left': return 'Tage übrig';
			case 'budgets.days_to_start': return 'Tage bis Start';
			case 'budgets.since_expiration': return 'Tage seit Ablauf';
			case 'budgets.no_budgets': return 'Es scheint, dass in diesem Abschnitt keine Budgets angezeigt werden können. Beginne mit der Erstellung eines Budgets, indem Du auf die Schaltfläche unten klickst';
			case 'budgets.delete': return 'Budget löschen';
			case 'budgets.delete_warning': return 'Diese Aktion ist irreversibel. ';
			case 'budgets.form.title': return 'Budget hinzufügen';
			case 'budgets.form.name': return 'Budgetname';
			case 'budgets.form.value': return 'Menge begrenzen';
			case 'budgets.form.create': return 'Budget hinzufügen';
			case 'budgets.form.edit': return 'Budget bearbeiten';
			case 'budgets.form.negative_warn': return 'Die Budgets dürfen keinen negativen Betrag haben';
			case 'budgets.details.title': return 'Budgetdetails';
			case 'budgets.details.statistics': return 'Statistiken';
			case 'budgets.details.budget_value': return 'Budgetiert';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => 'Du kannst ${dailyAmount}/Tag für ${remainingDays} verbleibende Tage ausgeben';
			case 'budgets.details.expend_evolution': return 'Ausgabenentwicklung';
			case 'budgets.details.no_transactions': return 'Es scheint, dass Du im Zusammenhang mit diesem Budget keine Ausgaben getätigt hast';
			case 'backup.export.title': return 'Daten exportieren';
			case 'backup.export.title_short': return 'Export';
			case 'backup.export.all': return 'Vollständige Sicherung';
			case 'backup.export.all_descr': return 'Exportiere alle Deine Daten (Konten, Transaktionen, Budgets, Einstellungen...). ';
			case 'backup.export.transactions': return 'Sicherung der Transaktionen';
			case 'backup.export.transactions_descr': return 'Exportiere Deine Transaktionen im CSV-Format, damit Du sie einfacher in anderen Programmen oder Anwendungen analysieren kannst.';
			case 'backup.export.description': return 'Lade Deine Daten in verschiedenen Formaten herunter';
			case 'backup.export.dialog_title': return 'Datei speichern/senden';
			case 'backup.export.success': return ({required Object x}) => 'Datei erfolgreich gespeichert/heruntergeladen in ${x}';
			case 'backup.export.error': return 'Fehler beim Herunterladen der Datei. ';
			case 'backup.import.title': return 'Daten importieren';
			case 'backup.import.title_short': return 'Import';
			case 'backup.import.restore_backup': return 'Sicherung wiederherstellen';
			case 'backup.import.restore_backup_descr': return 'Importiere eine zuvor gespeicherte Datenbank von Monekin. Diese Aktion ersetzt alle aktuellen Anwendungsdaten durch die neuen Daten';
			case 'backup.import.restore_backup_warn_description': return 'Beim Importieren einer neuen Datenbank gehen alle derzeit in der App gespeicherten Daten verloren. Es wird empfohlen, eine Sicherungskopie zu erstellen, bevor Du fortfährst. Lade hier keine Dateien hoch, deren Herkunft Du nicht kennst. Lade nur Dateien hoch, die Du zuvor von Monekin heruntergeladen hast.';
			case 'backup.import.restore_backup_warn_title': return 'Alle Daten überschreiben';
			case 'backup.import.select_other_file': return 'Andere Datei auswählen';
			case 'backup.import.tap_to_select_file': return 'Tippe, um eine Datei auszuwählen';
			case 'backup.import.manual_import.title': return 'Manueller Import';
			case 'backup.import.manual_import.descr': return 'Importiere Transaktionen manuell aus einer CSV-Datei';
			case 'backup.import.manual_import.default_account': return 'Standardkonto';
			case 'backup.import.manual_import.remove_default_account': return 'Standardkonto entfernen';
			case 'backup.import.manual_import.default_category': return 'Standardkategorie';
			case 'backup.import.manual_import.select_a_column': return 'Wählen eine Spalte aus der CSV-Datei aus';
			case 'backup.import.manual_import.steps.0': return 'Wähle Deine Datei aus';
			case 'backup.import.manual_import.steps.1': return 'Spalte für Menge';
			case 'backup.import.manual_import.steps.2': return 'Spalte für Konto';
			case 'backup.import.manual_import.steps.3': return 'Spalte für Kategorie';
			case 'backup.import.manual_import.steps.4': return 'Spalte für Datum';
			case 'backup.import.manual_import.steps.5': return 'andere Spalten';
			case 'backup.import.manual_import.steps_descr.0': return 'Wähle eine CSV-Datei von Deinem Gerät aus. Stelle sicher, dass die erste Zeile den Namen der einzelnen Spalten enthält';
			case 'backup.import.manual_import.steps_descr.1': return 'Wählen die Spalte aus, in der der Wert jeder Transaktion angegeben ist. Verwende negative Werte für Ausgaben und positive Werte für Einnahmen. Verwende einen Punkt als Dezimaltrennzeichen';
			case 'backup.import.manual_import.steps_descr.2': return 'Wähle die Spalte aus, in der das Konto angegeben ist, zu dem jede Transaktion gehört. Du kannst auch ein Standardkonto auswählen, falls wir das von Dir gewünschte Konto nicht finden können. Wenn Du kein Standardkonto angibst, wird eines mit demselben Namen erstellt ';
			case 'backup.import.manual_import.steps_descr.3': return 'Gebe die Spalte an, in der sich der Name der Transaktionskategorie befindet. Du musst eine Standardkategorie angeben, damit wir diese Kategorie den Transaktionen zuordnen können, falls die Kategorie nicht gefunden werden kann.';
			case 'backup.import.manual_import.steps_descr.4': return 'Wähle die Spalte aus, in der das Datum jeder Transaktion angegeben ist. Wird nichts angegeben, werden die Transaktionen mit dem aktuellen Datum erstellt.';
			case 'backup.import.manual_import.steps_descr.5': return 'Gibt die Spalten für andere optionale Transaktionsattribute an';
			case 'backup.import.manual_import.success': return ({required Object x}) => 'Erfolgreich ${x} Transaktionen importiert';
			case 'backup.import.success': return 'Der Import wurde erfolgreich durchgeführt';
			case 'backup.import.cancelled': return 'Der Import wurde vom Benutzer abgebrochen';
			case 'backup.import.error': return 'Fehler beim Importieren der Datei. Bitte kontaktiere den Entwickler lozin.technologies@gmail.com';
			case 'backup.about.title': return 'Informationen zu Deiner Datenbank';
			case 'backup.about.create_date': return 'Erstellungsdatum';
			case 'backup.about.modify_date': return 'Zuletzt geändert';
			case 'backup.about.last_backup': return 'Letzte Sicherung';
			case 'backup.about.size': return 'Größe';
			case 'settings.title_long': return 'Einstellungen und Aussehen';
			case 'settings.title_short': return 'Einstellungen';
			case 'settings.description': return 'App-Theme, Texte und andere allgemeine Einstellungen';
			case 'settings.edit_profile': return 'Profil bearbeiten';
			case 'settings.lang_section': return 'Sprache und Texte';
			case 'settings.lang_title': return 'App-Sprache';
			case 'settings.lang_descr': return 'Sprache, in der die Texte in der App angezeigt werden';
			case 'settings.lang_help': return 'Wenn an den Übersetzungen dieser App mitarbeiten möchten, kannst du dich an <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>unser Beschreibung</a> wenden';
			case 'settings.locale': return 'Region';
			case 'settings.locale_descr': return 'Lege das für Datumsangaben, Zahlen usw. zu verwendende Format fest.';
			case 'settings.locale_warn': return 'Wenn Du die Region änderst, wird die App aktualisiert';
			case 'settings.first_day_of_week': return 'Erster Tag der Woche';
			case 'settings.theme_and_colors': return 'Thema und Farben';
			case 'settings.theme': return 'Thema';
			case 'settings.theme_auto': return 'Vom System definiert';
			case 'settings.theme_light': return 'Hell';
			case 'settings.theme_dark': return 'Dunkel';
			case 'settings.amoled_mode': return 'AMOLED-Modus';
			case 'settings.amoled_mode_descr': return 'Verwende nach Möglichkeit einn rein schwarzen Hintergrund. Das wird den Akku von Geräten mit AMOLED-Bildschirmen etwas schonen.';
			case 'settings.dynamic_colors': return 'Dynamische Farben';
			case 'settings.dynamic_colors_descr': return 'Verwende wann immer möglich die Akzentfarbe des Systems';
			case 'settings.accent_color': return 'Akzentfarbe';
			case 'settings.accent_color_descr': return 'Wähle die Farbe aus, mit der die App bestimmte Teile der Benutzeroberfläche hervorhebt';
			case 'settings.security.title': return 'Sicherheit';
			case 'settings.security.private_mode_at_launch': return 'Privatmodus beim Start';
			case 'settings.security.private_mode_at_launch_descr': return 'Starte die App standardmäßig im privaten Modus';
			case 'settings.security.private_mode': return 'Privatmodus';
			case 'settings.security.private_mode_descr': return 'Alle Geldwerte ausblenden';
			case 'settings.security.private_mode_activated': return 'Privatmodus aktiviert';
			case 'settings.security.private_mode_deactivated': return 'Privatmodus deaktiviert';
			case 'more.title': return 'Mehr';
			case 'more.title_long': return 'Weitere Aktionen';
			case 'more.data.display': return 'Daten';
			case 'more.data.display_descr': return 'Exportiere und importiere Deine Daten, damit Du nichts verlierst';
			case 'more.data.delete_all': return 'Meine Daten löschen';
			case 'more.data.delete_all_header1': return 'Höre genau dort auf, Padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return 'Bist Du sicher, dass Du fortfahren möchtest? Alle Daten werden endgültig gelöscht und können nicht wiederhergestellt werden.';
			case 'more.data.delete_all_header2': return 'Ein letzter Schritt ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'Durch das Löschen eines Kontos löschst Du alle Deine gespeicherten persönlichen Daten. Deine Konten, Transaktionen, Budgets und Kategorien werden gelöscht und können nicht wiederhergestellt werden. Bist Du damit einverstanden?';
			case 'more.about_us.display': return 'App-Informationen';
			case 'more.about_us.description': return 'Schaue Dir die Bedingungen und andere relevante Informationen über Monekin an. Treten mit der Community in Kontakt, indem Du Fehler meldest, Vorschläge machst...';
			case 'more.about_us.legal.display': return 'Rechtliche Informationen';
			case 'more.about_us.legal.privacy': return 'Datenschutzrichtlinie';
			case 'more.about_us.legal.terms': return 'Nutzungsbedingungen';
			case 'more.about_us.legal.licenses': return 'Lizenzen';
			case 'more.about_us.project.display': return 'Projekt';
			case 'more.about_us.project.contributors': return 'Mitarbeiter';
			case 'more.about_us.project.contributors_descr': return 'Alle Entwickler, die Monekin wachsen lassen haben';
			case 'more.about_us.project.contact': return 'Kontaktiere uns';
			case 'more.help_us.display': return 'Hilf uns';
			case 'more.help_us.description': return 'Finde heraus, wie Du Monekin dabei helfen kannst, immer besser zu werden';
			case 'more.help_us.rate_us': return 'Bewerte uns';
			case 'more.help_us.rate_us_descr': return 'Jede Hilfe ist willkommen!';
			case 'more.help_us.share': return 'Teile  Monekin';
			case 'more.help_us.share_descr': return 'Teile  unsere App mit Freunden und Familie';
			case 'more.help_us.share_text': return 'Monekin! ';
			case 'more.help_us.thanks': return 'Danke schön!';
			case 'more.help_us.thanks_long': return 'Deine Beiträge zu Monekin und anderen großen und kleinen Open-Source-Projekten machen großartige Projekte wie dieses möglich. Danke, dass Du dir die Zeit nimmst teilzunehmen';
			case 'more.help_us.donate': return 'Mache eine Spende';
			case 'more.help_us.donate_descr': return 'Mit Deiner Spende trägst dazu bei, dass die App weiterhin verbessert wird. Was gibt es Schöneres, als sich für die geleistete Arbeit zu bedanken, indem man mich zu einem Kaffee einlädt?';
			case 'more.help_us.donate_success': return 'Spende erfolgt. Herzlichen Dank für Deine Beitrag! ❤️';
			case 'more.help_us.donate_err': return 'Hoppla! Es scheint ein Fehler beim Empfang Deiner Zahlung aufgetreten zu sein';
			case 'more.help_us.report': return 'Melde Fehler, hinterlasse Vorschläge ...';
			default: return null;
		}
	}
}

extension on _TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'general.cancel': return 'Cancelar';
			case 'general.or': return 'o';
			case 'general.understood': return 'Entendido';
			case 'general.unspecified': return 'Sin especificar';
			case 'general.confirm': return 'Confirmar';
			case 'general.continue_text': return 'Continuar';
			case 'general.quick_actions': return 'Acciones rápidas';
			case 'general.save': return 'Guardar';
			case 'general.save_changes': return 'Guardar cambios';
			case 'general.close_and_save': return 'Guardar y cerrar';
			case 'general.add': return 'Añadir';
			case 'general.edit': return 'Editar';
			case 'general.delete': return 'Eliminar';
			case 'general.balance': return 'Balance';
			case 'general.account': return 'Cuenta';
			case 'general.accounts': return 'Cuentas';
			case 'general.categories': return 'Categorías';
			case 'general.category': return 'Categoría';
			case 'general.today': return 'Hoy';
			case 'general.yesterday': return 'Ayer';
			case 'general.filters': return 'Filtros';
			case 'general.see_more': return 'Ver más';
			case 'general.select_all': return 'Seleccionar todo';
			case 'general.deselect_all': return 'Deseleccionar todo';
			case 'general.empty_warn': return 'Ops! Esto esta muy vacio';
			case 'general.insufficient_data': return 'Datos insuficientes';
			case 'general.show_more_fields': return 'Show more fields';
			case 'general.show_less_fields': return 'Show less fields';
			case 'general.tap_to_search': return 'Toca para buscar';
			case 'general.clipboard.success': return ({required Object x}) => '${x} copiado al portapapeles';
			case 'general.clipboard.error': return 'Error al copiar';
			case 'general.time.start_date': return 'Fecha de inicio';
			case 'general.time.end_date': return 'Fecha de fin';
			case 'general.time.from_date': return 'Desde fecha';
			case 'general.time.until_date': return 'Hasta fecha';
			case 'general.time.date': return 'Fecha';
			case 'general.time.datetime': return 'Fecha y hora';
			case 'general.time.time': return 'Hora';
			case 'general.time.each': return 'Cada';
			case 'general.time.after': return 'Tras';
			case 'general.time.ranges.display': return 'Rango temporal';
			case 'general.time.ranges.it_repeat': return 'Se repite';
			case 'general.time.ranges.it_ends': return 'Termina';
			case 'general.time.ranges.types.cycle': return 'Ciclos';
			case 'general.time.ranges.types.last_days': return 'Últimos días';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '${x} días anteriores';
			case 'general.time.ranges.types.all': return 'Siempre';
			case 'general.time.ranges.types.date_range': return 'Rango personalizado';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range}',
				other: 'Cada ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} hasta el ${day}',
				other: 'Cada ${n} ${range} hasta el ${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} ${limit} veces',
				other: 'Cada ${n} ${range} ${limit} veces',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} una vez',
				other: 'Cada ${n} ${range} una vez',
			);
			case 'general.time.ranges.forever': return 'Para siempre';
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Mes',
				other: 'Meses',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Año',
				other: 'Años',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Día',
				other: 'Días',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Semana',
				other: 'Semanas',
			);
			case 'general.time.periodicity.display': return 'Periodicidad';
			case 'general.time.periodicity.no_repeat': return 'Sin repetición';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Repetición',
				other: 'Repeticiones',
			);
			case 'general.time.periodicity.diary': return 'Diaría';
			case 'general.time.periodicity.monthly': return 'Mensual';
			case 'general.time.periodicity.annually': return 'Anual';
			case 'general.time.periodicity.quaterly': return 'Trimestral';
			case 'general.time.periodicity.weekly': return 'Semanal';
			case 'general.time.periodicity.custom': return 'Personalizado';
			case 'general.time.periodicity.infinite': return 'Siempre';
			case 'general.time.current.diary': return 'Este día';
			case 'general.time.current.monthly': return 'Este mes';
			case 'general.time.current.annually': return 'Este año';
			case 'general.time.current.quaterly': return 'Este trimestre';
			case 'general.time.current.weekly': return 'Esta semana';
			case 'general.time.current.infinite': return 'Desde siempre';
			case 'general.time.current.custom': return 'Rango personalizado';
			case 'general.time.all.diary': return 'Todos los días';
			case 'general.time.all.monthly': return 'Todos los meses';
			case 'general.time.all.annually': return 'Todos los años';
			case 'general.time.all.quaterly': return 'Todos los trimestres';
			case 'general.time.all.weekly': return 'Todas las semanas';
			case 'general.transaction_order.display': return 'Ordenar transacciones';
			case 'general.transaction_order.category': return 'Por categoría';
			case 'general.transaction_order.quantity': return 'Por cantidad';
			case 'general.transaction_order.date': return 'Por fecha';
			case 'general.validations.form_error': return 'Corrije los campos indicados en el formulario para continuar';
			case 'general.validations.required': return 'Campo obligatorio';
			case 'general.validations.positive': return 'Debe ser positivo';
			case 'general.validations.min_number': return ({required Object x}) => 'Debe ser mayor que ${x}';
			case 'general.validations.max_number': return ({required Object x}) => 'Debe ser menor que ${x}';
			case 'intro.start': return 'Empecemos';
			case 'intro.skip': return 'Saltar';
			case 'intro.next': return 'Siguiente';
			case 'intro.select_your_currency': return 'Selecciona tu divisa';
			case 'intro.welcome_subtitle': return 'Tu gestor de finanzas personales';
			case 'intro.welcome_subtitle2': return '100% libre, 100% gratis';
			case 'intro.welcome_footer': return 'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación';
			case 'intro.offline_descr_title': return 'CUENTA SIN CONEXIÓN:';
			case 'intro.offline_descr': return 'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
			case 'intro.offline_start': return 'Iniciar sesión offline';
			case 'intro.sl1_title': return 'Selecciona tu divisa';
			case 'intro.sl1_descr': return 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
			case 'intro.sl2_title': return 'Seguro, privado y confiable';
			case 'intro.sl2_descr': return 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
			case 'intro.sl2_descr2': return 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
			case 'intro.last_slide_title': return 'Todo listo!';
			case 'intro.last_slide_descr': return 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
			case 'intro.last_slide_descr2': return 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
			case 'home.title': return 'Inicio';
			case 'home.filter_transactions': return 'Filtrar transacciones';
			case 'home.hello_day': return 'Buenos días,';
			case 'home.hello_night': return 'Buenas noches,';
			case 'home.total_balance': return 'Saldo total';
			case 'home.my_accounts': return 'Mis cuentas';
			case 'home.active_accounts': return 'Cuentas activas';
			case 'home.no_accounts': return 'Aun no hay cuentas creadas';
			case 'home.no_accounts_descr': return 'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones';
			case 'home.last_transactions': return 'Últimas transacciones';
			case 'home.should_create_account_header': return 'Ops!';
			case 'home.should_create_account_message': return 'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones';
			case 'financial_health.display': return 'Salud financiera';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Excelente!';
					case GenderContext.female:
						return 'Excelente!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Bueno';
					case GenderContext.female:
						return 'Buena';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'En la media';
					case GenderContext.female:
						return 'En la media';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Regular';
					case GenderContext.female:
						return 'Regular';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Muy malo';
					case GenderContext.female:
						return 'Muy mala';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Datos insuficientes';
					case GenderContext.female:
						return 'Datos insuficientes';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!';
			case 'financial_health.review.descr.very_good': return 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
			case 'financial_health.review.descr.good': return 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
			case 'financial_health.review.descr.normal': return 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
			case 'financial_health.review.descr.bad': return 'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas';
			case 'financial_health.review.descr.very_bad': return 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos';
			case 'financial_health.months_without_income.title': return 'Ratio de supervivencia';
			case 'financial_health.months_without_income.subtitle': return 'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos';
			case 'financial_health.months_without_income.text_zero': return '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!';
			case 'financial_health.months_without_income.text_one': return '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.';
			case 'financial_health.months_without_income.text_infinite': return 'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.';
			case 'financial_health.months_without_income.suggestion': return 'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.';
			case 'financial_health.months_without_income.insufficient_data': return 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
			case 'financial_health.savings_percentage.title': return 'Porcentaje de ahorro';
			case 'financial_health.savings_percentage.subtitle': return 'Que parte de tus ingresos no son gastados en este periodo';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!';
			case 'financial_health.savings_percentage.text.very_bad': return 'Vaya, no has conseguido ahorrar nada durante este periodo.';
			case 'financial_health.savings_percentage.suggestion': return 'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.';
			case 'stats.title': return 'Estadísticas';
			case 'stats.balance': return 'Saldo';
			case 'stats.final_balance': return 'Saldo final';
			case 'stats.balance_by_account': return 'Saldo por cuentas';
			case 'stats.balance_by_account_subtitle': return '¿Donde tengo la mayor parte de mi dinero?';
			case 'stats.balance_by_currency': return 'Saldo por divisas';
			case 'stats.balance_by_currency_subtitle': return '¿Cuanto dinero tengo en moneda extranjera?';
			case 'stats.balance_evolution': return 'Tendencia de saldo';
			case 'stats.balance_evolution_subtitle': return '¿Tengo más dinero que antes?';
			case 'stats.compared_to_previous_period': return 'Frente al periodo anterior';
			case 'stats.cash_flow': return 'Flujo de caja';
			case 'stats.cash_flow_subtitle': return '¿Estoy gastando menos de lo que gano?';
			case 'stats.by_periods': return 'Por periodos';
			case 'stats.by_categories': return 'Por categorías';
			case 'stats.by_tags': return 'Por etiquetas';
			case 'stats.distribution': return 'Distribución';
			case 'stats.finance_health_resume': return 'Resumen';
			case 'stats.finance_health_breakdown': return 'Desglose';
			case 'icon_selector.name': return 'Nombre:';
			case 'icon_selector.icon': return 'Icono';
			case 'icon_selector.color': return 'Color';
			case 'icon_selector.select_icon': return 'Selecciona un icono';
			case 'icon_selector.select_color': return 'Selecciona un color';
			case 'icon_selector.custom_color': return 'Color personalizado';
			case 'icon_selector.current_color_selection': return 'Selección actual';
			case 'icon_selector.select_account_icon': return 'Identifica tu cuenta';
			case 'icon_selector.select_category_icon': return 'Identifica tu categoría';
			case 'icon_selector.scopes.transport': return 'Transporte';
			case 'icon_selector.scopes.money': return 'Dinero';
			case 'icon_selector.scopes.food': return 'Comida';
			case 'icon_selector.scopes.medical': return 'Salud';
			case 'icon_selector.scopes.entertainment': return 'Entretenimiento';
			case 'icon_selector.scopes.technology': return 'Technología';
			case 'icon_selector.scopes.other': return 'Otros';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Financial institutions';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Transacción',
				other: 'Transacciones',
			);
			case 'transaction.create': return 'Nueva transacción';
			case 'transaction.new_income': return 'Nuevo ingreso';
			case 'transaction.new_expense': return 'Nuevo gasto';
			case 'transaction.new_success': return 'Transacción creada correctamente';
			case 'transaction.edit': return 'Editar transacción';
			case 'transaction.edit_success': return 'Transacción editada correctamente';
			case 'transaction.edit_multiple': return 'Editar transacciones';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} transacciones editadas correctamente';
			case 'transaction.duplicate': return 'Clonar transacción';
			case 'transaction.duplicate_short': return 'Clonar';
			case 'transaction.duplicate_warning_message': return 'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?';
			case 'transaction.duplicate_success': return 'Transacción clonada con exito';
			case 'transaction.delete': return 'Eliminar transacción';
			case 'transaction.delete_warning_message': return 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
			case 'transaction.delete_success': return 'Transacción eliminada correctamente';
			case 'transaction.delete_multiple': return 'Eliminar transacciones';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} transacciones eliminadas correctamente';
			case 'transaction.details': return 'Detalles del movimiento';
			case 'transaction.next_payments.skip': return 'Saltar';
			case 'transaction.next_payments.skip_success': return 'Transacción saltada con exito';
			case 'transaction.next_payments.skip_dialog_title': return 'Saltar transacción';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}';
			case 'transaction.next_payments.accept': return 'Aceptar';
			case 'transaction.next_payments.accept_today': return 'Aceptar hoy';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Aceptar en la fecha requerida (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'Aceptar transacción';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones';
			case 'transaction.next_payments.recurrent_rule_finished': return 'La regla recurrente se ha completado, ya no hay mas pagos a realizar!';
			case 'transaction.list.empty': return 'No se han encontrado transacciones que mostrar aquí. Añade unas cuantas transacciones en la app y quizas tengas más suerte la proxima vez';
			case 'transaction.list.searcher_placeholder': return 'Busca por categoría, descripción...';
			case 'transaction.list.searcher_no_results': return 'No se han encontrado transacciones que coincidan con los criterios de busqueda';
			case 'transaction.list.loading': return 'Cargando más transacciones...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '${n} seleccionada',
				other: '${n} seleccionadas',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '${n} transacción seleccionada',
				other: '${n} transacciones seleccionadas',
			);
			case 'transaction.list.bulk_edit.dates': return 'Editar fechas';
			case 'transaction.list.bulk_edit.categories': return 'Editar categorías';
			case 'transaction.list.bulk_edit.status': return 'Editar estados';
			case 'transaction.filters.from_value': return 'Desde monto';
			case 'transaction.filters.to_value': return 'Hasta monto';
			case 'transaction.filters.from_value_def': return ({required Object x}) => 'Desde ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => 'Hasta ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => 'Desde el ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => 'Hasta el ${date}';
			case 'transaction.form.validators.zero': return 'El valor de una transacción no puede ser igual a cero';
			case 'transaction.form.validators.date_max': return 'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente';
			case 'transaction.form.validators.date_after_account_creation': return 'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece';
			case 'transaction.form.validators.negative_transfer': return 'El valor monetario de una transferencia no puede ser negativo';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'Las cuentas de origen y destino no pueden coincidir';
			case 'transaction.form.title': return 'Título de la transacción';
			case 'transaction.form.title_short': return 'Título';
			case 'transaction.form.no_tags': return '-- Sin etiquetas --';
			case 'transaction.form.value': return 'Valor de la transacción';
			case 'transaction.form.tap_to_see_more': return 'Toca para ver más detalles';
			case 'transaction.form.description': return 'Descripción';
			case 'transaction.form.description_info': return 'Toca aquí para escribir una descripción mas detallada sobre esta transacción';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => 'Cambio a ${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return 'El día de la transacción';
			case 'transaction.reversed.title': return 'Transacción invertida';
			case 'transaction.reversed.title_short': return 'Tr. invertida';
			case 'transaction.reversed.description_for_expenses': return 'A pesar de ser una transacción de tipo gasto, esta transacción tiene un monto positivo. Este tipo de transacciones pueden usarse para representar la devolución de un gasto previamente registrado, como un reembolso o que te realicen el pago de una deuda.';
			case 'transaction.reversed.description_for_incomes': return 'A pesar de ser una transacción de tipo ingreso, esta transacción tiene un monto negativo. Este tipo de transacciones pueden usarse para anular o corregir un ingreso que fue registrado incorrectamente, para reflejar una devolución o reembolso de dinero o para registrar el pago de deudas.';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Estado',
				other: 'Estados',
			);
			case 'transaction.status.display_long': return 'Estado de la transacción';
			case 'transaction.status.tr_status': return ({required Object status}) => 'Transacción ${status}';
			case 'transaction.status.none': return 'Sin estado';
			case 'transaction.status.none_descr': return 'Transacción sin un estado concreto';
			case 'transaction.status.reconciled': return 'Reconciliada';
			case 'transaction.status.reconciled_descr': return 'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco';
			case 'transaction.status.unreconciled': return 'No reconciliada';
			case 'transaction.status.unreconciled_descr': return 'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin';
			case 'transaction.status.pending': return 'Pendiente';
			case 'transaction.status.pending_descr': return 'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas';
			case 'transaction.status.voided': return 'Nula';
			case 'transaction.status.voided_descr': return 'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Tipo de transacción',
				other: 'Tipos de transacción',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Ingreso',
				other: 'Ingresos',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Gasto',
				other: 'Gastos',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Transferencia',
				other: 'Transferencias',
			);
			case 'transfer.display': return 'Transferencia';
			case 'transfer.transfers': return 'Transferencias';
			case 'transfer.transfer_to': return ({required Object account}) => 'Transferencia hacia ${account}';
			case 'transfer.create': return 'Nueva transferencia';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
			case 'transfer.form.from': return 'Cuenta origen';
			case 'transfer.form.to': return 'Cuenta destino';
			case 'transfer.form.value_in_destiny.title': return 'Cantidad transferida en destino';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} a cuenta de destino';
			case 'recurrent_transactions.title': return 'Movimientos recurrentes';
			case 'recurrent_transactions.title_short': return 'Mov. recurrentes';
			case 'recurrent_transactions.empty': return 'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
			case 'recurrent_transactions.total_expense_title': return 'Gasto total por periodo';
			case 'recurrent_transactions.total_expense_descr': return '* Sin considerar la fecha de inicio y fin de cada recurrencia';
			case 'recurrent_transactions.details.title': return 'Transaccion recurrente';
			case 'recurrent_transactions.details.descr': return 'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento';
			case 'recurrent_transactions.details.last_payment_info': return 'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción';
			case 'recurrent_transactions.details.delete_header': return 'Eliminar transacción recurrente';
			case 'recurrent_transactions.details.delete_message': return 'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => 'Atrasado por ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => 'En ${x} días';
			case 'account.details': return 'Detalles de la cuenta';
			case 'account.date': return 'Fecha de apertura';
			case 'account.close_date': return 'Fecha de cierre';
			case 'account.reopen_short': return 'Reabrir';
			case 'account.reopen': return 'Reabrir cuenta';
			case 'account.reopen_descr': return '¿Seguro que quieres volver a abrir esta cuenta?';
			case 'account.balance': return 'Saldo de la cuenta';
			case 'account.n_transactions': return 'Número de transacciones';
			case 'account.add_money': return 'Añadir dinero';
			case 'account.withdraw_money': return 'Retirar dinero';
			case 'account.no_accounts': return 'No se han encontrado cuentas que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
			case 'account.types.title': return 'Tipo de cuenta';
			case 'account.types.warning': return 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
			case 'account.types.normal': return 'Cuenta corriente';
			case 'account.types.normal_descr': return 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
			case 'account.types.saving': return 'Cuenta de ahorros';
			case 'account.types.saving_descr': return 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
			case 'account.form.name': return 'Nombre de la cuenta';
			case 'account.form.name_placeholder': return 'Ej: Cuenta de ahorros';
			case 'account.form.notes': return 'Notas';
			case 'account.form.notes_placeholder': return 'Escribe algunas notas/descripciones sobre esta cuenta';
			case 'account.form.initial_balance': return 'Balance inicial';
			case 'account.form.current_balance': return 'Balance actual';
			case 'account.form.create': return 'Crear cuenta';
			case 'account.form.edit': return 'Editar cuenta';
			case 'account.form.tr_before_opening_date': return 'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura';
			case 'account.form.currency_not_found_warn': return 'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes';
			case 'account.form.already_exists': return 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return '¿Eliminar cuenta?';
			case 'account.delete.warning_text': return 'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.';
			case 'account.delete.success': return 'Cuenta eliminada correctamente';
			case 'account.close.title': return 'Cerrar cuenta';
			case 'account.close.title_short': return 'Cerrar';
			case 'account.close.warn': return 'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras';
			case 'account.close.should_have_zero_balance': return 'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar';
			case 'account.close.should_have_no_transactions': return 'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar';
			case 'account.close.success': return 'Cuenta cerrada exitosamente';
			case 'account.close.unarchive_succes': return 'Cuenta re-abierta exitosamente';
			case 'account.select.one': return 'Selecciona una cuenta';
			case 'account.select.multiple': return 'Selecciona cuentas';
			case 'account.select.all': return 'Todas las cuentas';
			case 'currencies.currency_converter': return 'Conversor de divisas';
			case 'currencies.currency_manager': return 'Administrador de divisas';
			case 'currencies.currency_manager_descr': return 'Configura tu divisa y sus tipos de cambio con otras';
			case 'currencies.currency': return 'Divisa';
			case 'currencies.preferred_currency': return 'Divisa predeterminada/base';
			case 'currencies.change_preferred_currency_title': return 'Cambiar divisa predeterminada';
			case 'currencies.change_preferred_currency_msg': return 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
			case 'currencies.form.equal_to_preferred_warn': return 'The currency can not be equal to the user currency';
			case 'currencies.form.specify_a_currency': return 'Por favor, especifica una divisa';
			case 'currencies.form.add': return 'Añadir tipo de cambio';
			case 'currencies.form.add_success': return 'Tipo de cambio añadido correctamente';
			case 'currencies.form.edit': return 'Editar tipo de cambio';
			case 'currencies.form.edit_success': return 'Tipo de cambio editado correctamente';
			case 'currencies.delete_all_success': return 'Tipos de cambio borrados con exito';
			case 'currencies.historical': return 'Histórico de tasas';
			case 'currencies.exchange_rate': return 'Tipo de cambio';
			case 'currencies.exchange_rates': return 'Tipos de cambio';
			case 'currencies.empty': return 'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos';
			case 'currencies.select_a_currency': return 'Selecciona una divisa';
			case 'currencies.search': return 'Busca por nombre o por código de la divisa';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Etiqueta',
				other: 'Etiquetas',
			);
			case 'tags.form.name': return 'Nombre de la etiqueta';
			case 'tags.form.description': return 'Descripción';
			case 'tags.select.title': return 'Selecciona etiquetas';
			case 'tags.select.all': return 'Todas las etiquetas';
			case 'tags.empty_list': return 'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos';
			case 'tags.without_tags': return 'Sin etiquetas';
			case 'tags.create': return 'Crear etiqueta';
			case 'tags.add': return 'Añadir etiqueta';
			case 'tags.create_success': return 'Etiqueta creada correctamente';
			case 'tags.already_exists': return 'El nombre de esta etiqueta ya existe. Puede que quieras editarla';
			case 'tags.edit': return 'Editar etiqueta';
			case 'tags.edit_success': return 'Etiqueta editada correctamente';
			case 'tags.delete_success': return 'Categoría eliminada correctamente';
			case 'tags.delete_warning_header': return '¿Eliminar etiqueta?';
			case 'tags.delete_warning_message': return 'Esta acción no borrará las transacciones que poseen esta etiqueta.';
			case 'categories.unknown': return 'Categoría desconocida';
			case 'categories.create': return 'Crear categoría';
			case 'categories.create_success': return 'Categoría creada correctamente';
			case 'categories.new_category': return 'Nueva categoría';
			case 'categories.already_exists': return 'El nombre de esta categoría ya existe. Puede que quieras editarla';
			case 'categories.edit': return 'Editar categoría';
			case 'categories.edit_success': return 'Categoría editada correctamente';
			case 'categories.name': return 'Nombre de la categoría';
			case 'categories.type': return 'Tipo de categoría';
			case 'categories.both_types': return 'Ambos tipos';
			case 'categories.subcategories': return 'Subcategorías';
			case 'categories.subcategories_add': return 'Añadir subcategoría';
			case 'categories.make_parent': return 'Convertir en categoría';
			case 'categories.make_child': return 'Convertir en subcategoría';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.';
			case 'categories.make_child_success': return 'Subcategorías creadas con exito';
			case 'categories.merge': return 'Fusionar con otra categoría';
			case 'categories.merge_warning1': return ({required Object x, required Object from, required Object destiny}) => 'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.';
			case 'categories.merge_warning2': return ({required Object from}) => 'La categoría <b>${from}</b> será eliminada de forma irreversible.';
			case 'categories.merge_success': return 'Categoría fusionada correctamente';
			case 'categories.delete_success': return 'Categoría eliminada correctamente';
			case 'categories.delete_warning_header': return '¿Eliminar categoría?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.';
			case 'categories.select.title': return 'Selecciona categorías';
			case 'categories.select.select_one': return 'Selecciona una categoría';
			case 'categories.select.select_subcategory': return 'Elige una subcategoría';
			case 'categories.select.without_subcategory': return 'Sin subcategoría';
			case 'categories.select.all': return 'Todas las categorías';
			case 'categories.select.all_short': return 'Todas';
			case 'budgets.title': return 'Presupuestos';
			case 'budgets.repeated': return 'Periódicos';
			case 'budgets.one_time': return 'Una vez';
			case 'budgets.annual': return 'Anuales';
			case 'budgets.week': return 'Semanales';
			case 'budgets.month': return 'Mensuales';
			case 'budgets.actives': return 'Activos';
			case 'budgets.pending': return 'Pendientes de comenzar';
			case 'budgets.finish': return 'Finalizados';
			case 'budgets.from_budgeted': return 'De un total de ';
			case 'budgets.days_left': return 'días restantes';
			case 'budgets.days_to_start': return 'días para empezar';
			case 'budgets.since_expiration': return 'días desde su expiración';
			case 'budgets.no_budgets': return 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
			case 'budgets.delete': return 'Eliminar presupuesto';
			case 'budgets.delete_warning': return 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
			case 'budgets.form.title': return 'Añade un presupuesto';
			case 'budgets.form.name': return 'Nombre del presupuesto';
			case 'budgets.form.value': return 'Cantidad límite';
			case 'budgets.form.create': return 'Añade el presupuesto';
			case 'budgets.form.edit': return 'Editar presupuesto';
			case 'budgets.form.negative_warn': return 'Los presupuestos no pueden tener un valor límite negativo';
			case 'budgets.details.title': return 'Detalles del presupuesto';
			case 'budgets.details.budget_value': return 'Presupuestado';
			case 'budgets.details.statistics': return 'Estadísticas';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => 'Puedes gastar ${dailyAmount}/día por los ${remainingDays} días restantes';
			case 'budgets.details.expend_evolution': return 'Evolución del gasto';
			case 'budgets.details.no_transactions': return 'Parece que no has realizado ningún gasto relativo a este presupuesto';
			case 'backup.export.title': return 'Exportar datos';
			case 'backup.export.title_short': return 'Exportar';
			case 'backup.export.all': return 'Respaldo total';
			case 'backup.export.all_descr': return 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
			case 'backup.export.transactions': return 'Respaldo de transacciones';
			case 'backup.export.transactions_descr': return 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
			case 'backup.export.description': return 'Exporta tus datos en diferentes formatos';
			case 'backup.export.dialog_title': return 'Guardar/Enviar archivo';
			case 'backup.export.success': return ({required Object x}) => 'Archivo guardado/enviado correctamente en ${x}';
			case 'backup.export.error': return 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
			case 'backup.import.title': return 'Importar tus datos';
			case 'backup.import.title_short': return 'Importar';
			case 'backup.import.restore_backup': return 'Restaurar copia de seguridad';
			case 'backup.import.restore_backup_descr': return 'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos';
			case 'backup.import.restore_backup_warn_title': return 'Sobreescribir todos los datos';
			case 'backup.import.restore_backup_warn_description': return 'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin';
			case 'backup.import.tap_to_select_file': return 'Pulsa para seleccionar un archivo';
			case 'backup.import.select_other_file': return 'Selecciona otro fichero';
			case 'backup.import.manual_import.title': return 'Importación manual';
			case 'backup.import.manual_import.descr': return 'Importa transacciones desde un fichero .csv de forma manual';
			case 'backup.import.manual_import.default_account': return 'Cuenta por defecto';
			case 'backup.import.manual_import.remove_default_account': return 'Eliminar cuenta por defecto';
			case 'backup.import.manual_import.default_category': return 'Categoría por defecto';
			case 'backup.import.manual_import.select_a_column': return 'Selecciona una columna del .csv';
			case 'backup.import.manual_import.success': return ({required Object x}) => 'Se han importado correctamente ${x} transacciones';
			case 'backup.import.manual_import.steps.0': return 'Selecciona tu fichero';
			case 'backup.import.manual_import.steps.1': return 'Columna para la cantidad';
			case 'backup.import.manual_import.steps.2': return 'Columna para la cuenta';
			case 'backup.import.manual_import.steps.3': return 'Columna para la categoría';
			case 'backup.import.manual_import.steps.4': return 'Columna para la fecha';
			case 'backup.import.manual_import.steps.5': return 'Otras columnas';
			case 'backup.import.manual_import.steps_descr.0': return 'Selecciona un fichero .csv de tu dispositivo. Asegurate de que este tenga una primera fila que describa el nombre de cada columna';
			case 'backup.import.manual_import.steps_descr.1': return 'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos. Usa un punto como separador decimal';
			case 'backup.import.manual_import.steps_descr.2': return 'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre';
			case 'backup.import.manual_import.steps_descr.3': return 'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar';
			case 'backup.import.manual_import.steps_descr.4': return 'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual';
			case 'backup.import.manual_import.steps_descr.5': return 'Especifica las columnas para otros atributos optativos de las transacciones';
			case 'backup.import.success': return 'Importación realizada con exito';
			case 'backup.import.cancelled': return 'La importación fue cancelada por el usuario';
			case 'backup.import.error': return 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
			case 'backup.about.title': return 'Información sobre tu base de datos';
			case 'backup.about.create_date': return 'Fecha de creación';
			case 'backup.about.modify_date': return 'Última modificación';
			case 'backup.about.last_backup': return 'Última copia de seguridad';
			case 'backup.about.size': return 'Tamaño';
			case 'settings.title_long': return 'Configuración y apariencia';
			case 'settings.title_short': return 'Configuración';
			case 'settings.description': return 'Tema de la aplicación, textos y otras configuraciones generales';
			case 'settings.edit_profile': return 'Editar perfil';
			case 'settings.lang_section': return 'Idioma y textos';
			case 'settings.lang_title': return 'Idioma de la aplicación';
			case 'settings.lang_descr': return 'Idioma en el que se mostrarán los textos en la aplicación';
			case 'settings.lang_help': return 'Si quieres colaborar con las traducciones de esta app puedes consultar <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>nuestra guía</a> ';
			case 'settings.locale': return 'Región';
			case 'settings.locale_descr': return 'Establecer el formato a utilizar para fechas, números...';
			case 'settings.locale_warn': return 'Al cambiar la región, la aplicación se actualizará';
			case 'settings.first_day_of_week': return 'Primer día de la semana';
			case 'settings.theme_and_colors': return 'Tema y colores';
			case 'settings.theme': return 'Tema';
			case 'settings.theme_auto': return 'Definido por el sistema';
			case 'settings.theme_light': return 'Claro';
			case 'settings.theme_dark': return 'Oscuro';
			case 'settings.amoled_mode': return 'Modo AMOLED';
			case 'settings.amoled_mode_descr': return 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
			case 'settings.dynamic_colors': return 'Colores dinámicos';
			case 'settings.dynamic_colors_descr': return 'Usar el color de acento de su sistema siempre que sea posible';
			case 'settings.accent_color': return 'Color de acento';
			case 'settings.accent_color_descr': return 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
			case 'settings.security.title': return 'Seguridad';
			case 'settings.security.private_mode_at_launch': return 'Modo privado al arrancar';
			case 'settings.security.private_mode_at_launch_descr': return 'Arranca la app en modo privado por defecto';
			case 'settings.security.private_mode': return 'Modo privado';
			case 'settings.security.private_mode_descr': return 'Oculta todos los valores monetarios';
			case 'settings.security.private_mode_activated': return 'Modo privado activado';
			case 'settings.security.private_mode_deactivated': return 'Modo privado desactivado';
			case 'more.title': return 'Más';
			case 'more.title_long': return 'Más acciones';
			case 'more.data.display': return 'Datos';
			case 'more.data.display_descr': return 'Exporta y importa tus datos para no perder nada';
			case 'more.data.delete_all': return 'Eliminar mis datos';
			case 'more.data.delete_all_header1': return 'Alto ahí padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
			case 'more.data.delete_all_header2': return 'Un último paso ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
			case 'more.about_us.display': return 'Información de la app';
			case 'more.about_us.description': return 'Consulta los terminos y otra información relevante sobre Monekin. Ponte en contacto con la comunidad reportando errores, dejando sugerencias...';
			case 'more.about_us.legal.display': return 'Información legal';
			case 'more.about_us.legal.privacy': return 'Política de privacidad';
			case 'more.about_us.legal.terms': return 'Términos de uso';
			case 'more.about_us.legal.licenses': return 'Licencias';
			case 'more.about_us.project.display': return 'Proyecto';
			case 'more.about_us.project.contributors': return 'Colaboradores';
			case 'more.about_us.project.contributors_descr': return 'Todos los desarrolladores que han hecho que Monekin crezca';
			case 'more.about_us.project.contact': return 'Contacta con nosotros';
			case 'more.help_us.display': return 'Ayúdanos';
			case 'more.help_us.description': return 'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor';
			case 'more.help_us.rate_us': return 'Califícanos';
			case 'more.help_us.rate_us_descr': return '¡Cualquier valoración es bienvenida!';
			case 'more.help_us.share': return 'Comparte Monekin';
			case 'more.help_us.share_descr': return 'Comparte nuestra app a amigos y familiares';
			case 'more.help_us.share_text': return 'Monekin! La mejor app de finanzas personales. Descargala aquí';
			case 'more.help_us.thanks': return '¡Gracias!';
			case 'more.help_us.thanks_long': return 'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.';
			case 'more.help_us.donate': return 'Haz una donación';
			case 'more.help_us.donate_descr': return 'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?';
			case 'more.help_us.donate_success': return 'Donación realizada. Muchas gracias por tu contribución! ❤️';
			case 'more.help_us.donate_err': return 'Ups! Parece que ha habido un error a la hora de recibir tu pago';
			case 'more.help_us.report': return 'Reporta errores, deja sugerencias...';
			default: return null;
		}
	}
}

extension on _TranslationsHu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'general.cancel': return 'Magyar';
			case 'general.or': return 'vagy';
			case 'general.understood': return 'Megértve';
			case 'general.unspecified': return 'Meghatározatlan';
			case 'general.confirm': return 'Megerősítés';
			case 'general.continue_text': return 'Folytatás';
			case 'general.quick_actions': return 'Gyorsműveletek';
			case 'general.save': return 'Mentés';
			case 'general.save_changes': return 'Módosítások mentése';
			case 'general.close_and_save': return 'Mentés és bezárás';
			case 'general.add': return 'Hozzáad';
			case 'general.edit': return 'Szerkesztés';
			case 'general.balance': return 'Egyenleg';
			case 'general.delete': return 'Törlés';
			case 'general.account': return 'Számla';
			case 'general.accounts': return 'Számlák';
			case 'general.categories': return 'Kategóriák';
			case 'general.category': return 'Kategória';
			case 'general.today': return 'Ma';
			case 'general.yesterday': return 'Tegnap';
			case 'general.filters': return 'Szűrők';
			case 'general.see_more': return 'Továbbiak';
			case 'general.select_all': return 'Összes kijelölése';
			case 'general.deselect_all': return 'Egyiket sem';
			case 'general.empty_warn': return 'Hoppá! Ez nagyon üres.';
			case 'general.insufficient_data': return 'Hiányos adatok';
			case 'general.show_more_fields': return 'Több mező mutatása';
			case 'general.show_less_fields': return 'Kevesebb mező mutatása';
			case 'general.tap_to_search': return 'Koppintson a kereséshez';
			case 'general.clipboard.success': return ({required Object x}) => '${x} a vágólapra másolva';
			case 'general.clipboard.error': return 'Másolási hiba';
			case 'general.time.start_date': return 'Kezdő dátum';
			case 'general.time.end_date': return 'Befejezés dátuma';
			case 'general.time.from_date': return 'Ettől kezdve';
			case 'general.time.until_date': return 'Dátumig';
			case 'general.time.date': return 'Dátum';
			case 'general.time.datetime': return 'Időpont';
			case 'general.time.time': return 'Idő';
			case 'general.time.each': return 'Minden';
			case 'general.time.after': return 'Után';
			case 'general.time.ranges.display': return 'Időtartomány';
			case 'general.time.ranges.it_repeat': return 'Ismétlések';
			case 'general.time.ranges.it_ends': return 'Vége';
			case 'general.time.ranges.forever': return 'Mindig';
			case 'general.time.ranges.types.cycle': return 'Ciklusok';
			case 'general.time.ranges.types.last_days': return 'Utolsó nap';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '${x} előző nap';
			case 'general.time.ranges.types.all': return 'Mindig';
			case 'general.time.ranges.types.date_range': return 'Egyéni tartomány';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range}',
				other: 'Minden ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range} ${day} -ig',
				other: 'Minden ${n} ${range} ${day} -ig',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range} ${limit} alkalommal',
				other: 'Minden ${n} ${range} ${limit} alkalommal',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range} egyszer',
				other: 'Minden ${n} ${range} egyszer',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Hónap',
				other: 'Hónap',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Év',
				other: 'Év',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Nap',
				other: 'Nap',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Hét',
				other: 'Hét',
			);
			case 'general.time.periodicity.display': return 'Ismétlődés';
			case 'general.time.periodicity.no_repeat': return 'Nem ismétlődik';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Ismétlés',
				other: 'Ismétlések',
			);
			case 'general.time.periodicity.diary': return 'Naponta';
			case 'general.time.periodicity.monthly': return 'Havonta';
			case 'general.time.periodicity.annually': return 'Évente';
			case 'general.time.periodicity.quaterly': return 'Negyedévente';
			case 'general.time.periodicity.weekly': return 'Hetente';
			case 'general.time.periodicity.custom': return 'Egyéni';
			case 'general.time.periodicity.infinite': return 'Mindig';
			case 'general.time.current.monthly': return 'Ebben a hónapban';
			case 'general.time.current.annually': return 'Ebben az évben';
			case 'general.time.current.quaterly': return 'Ebben a negyedévben';
			case 'general.time.current.weekly': return 'Ezen a héten';
			case 'general.time.current.infinite': return 'Mindig';
			case 'general.time.current.custom': return 'Egyéni tartomány';
			case 'general.time.all.diary': return 'Minden nap';
			case 'general.time.all.monthly': return 'Minden hónapban';
			case 'general.time.all.annually': return 'Minden évben';
			case 'general.time.all.quaterly': return 'Minden negyedévben';
			case 'general.time.all.weekly': return 'Minden héten';
			case 'general.transaction_order.display': return 'Tranzakciók rendezése';
			case 'general.transaction_order.category': return 'Kategóriánként';
			case 'general.transaction_order.quantity': return 'Mennyiség szerint';
			case 'general.transaction_order.date': return 'Dátum szerint';
			case 'general.validations.form_error': return 'A folytatáshoz javítsa ki a megadott mezőket';
			case 'general.validations.required': return 'Kötelező mező';
			case 'general.validations.positive': return 'Pozitívnak kell lennie';
			case 'general.validations.min_number': return ({required Object x}) => 'Nagyobbnak kell lennie, mint ${x}';
			case 'general.validations.max_number': return ({required Object x}) => 'Kevesebbnek kell lennie, mint ${x}';
			case 'intro.start': return 'Kezdés';
			case 'intro.skip': return 'Kihagyás';
			case 'intro.next': return 'Tovább';
			case 'intro.select_your_currency': return 'Válassza ki a pénznemet';
			case 'intro.welcome_subtitle': return 'Az Ön személyes pénzügyi menedzsere';
			case 'intro.welcome_subtitle2': return '100% -ban nyitott, és 100% -ban ingyenes';
			case 'intro.welcome_footer': return 'A bejelentkezéssel elfogadja az <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Adatvédelmi irányelveket</a> és az alkalmazás <a href=\' https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Felhasználási feltételeit</a>';
			case 'intro.offline_descr_title': return 'OFFLINE SZÁMLA:';
			case 'intro.offline_descr': return 'Az Ön adatai csak az Ön készülékén tárolódnak, és biztonságban lesznek, amíg nem távolítja el az alkalmazást, vagy nem cseréli le a telefont. Az adatvesztés megelőzése érdekében ajánlott rendszeresen biztonsági mentést készíteni az alkalmazás beállításaiból.';
			case 'intro.offline_start': return 'Offline munkamenet indítása';
			case 'intro.sl1_title': return 'Válassza ki a pénznemet';
			case 'intro.sl1_descr': return 'Az alapértelmezett pénznemet a jelentésekben és az általános diagramokban használjuk. A pénznemet és az alkalmazás nyelvét később bármikor megváltoztathatja az alkalmazás beállításaiban.';
			case 'intro.sl2_title': return 'Biztonságos, privát és megbízható';
			case 'intro.sl2_descr': return 'Az Ön adatai csak az Önéi. Az adatokat közvetlenül az Ön eszközén tároljuk, anélkül, hogy azok külső szervereken keresztül mennének át. Ez lehetővé teszi az alkalmazás használatát internet nélkül is.';
			case 'intro.sl2_descr2': return 'Az alkalmazás forráskódja is nyilvános, így bárki közreműködhet benne, és megnézheti, hogyan is működik.';
			case 'intro.last_slide_title': return 'Minden kész';
			case 'intro.last_slide_descr': return 'A Monekin segítségével végre elérheti azt az anyagi függetlenséget, amelyre annyira vágyik. Grafikonok, költségvetések, tippek, statisztikák és még sok minden más lesz megtalálható a pénzével kapcsolatban.';
			case 'intro.last_slide_descr2': return 'Reméljük, hogy élvezni fogja az élményt! Ne habozzon kapcsolatba lépni velünk, ha kétségei, javaslatai vannak...';
			case 'home.title': return 'Kezdőlap';
			case 'home.filter_transactions': return 'Tranzakciók szűrése';
			case 'home.hello_day': return 'Jó reggelt,';
			case 'home.hello_night': return 'Jó éjszakát,';
			case 'home.total_balance': return 'Teljes egyenleg';
			case 'home.my_accounts': return 'Saját számláim';
			case 'home.active_accounts': return 'Aktív számlák';
			case 'home.no_accounts': return 'Még nincsenek számlák létrehozva';
			case 'home.no_accounts_descr': return 'Kezdje el élvezni a Monekin összes varázsát. A tranzakciók hozzáadásához legalább egy számlát hozzon létre.';
			case 'home.last_transactions': return 'Legutóbbi tranzakciók';
			case 'home.should_create_account_header': return 'Hoppá!';
			case 'home.should_create_account_message': return 'A tranzakciók létrehozásához legalább egy nem archivált számlával kell rendelkeznie';
			case 'financial_health.display': return 'Pénzügyi állapot';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Nagyon jó!';
					case GenderContext.female:
						return 'Nagyon jó!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Jó';
					case GenderContext.female:
						return 'Jó';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Átlagos';
					case GenderContext.female:
						return 'Átlagos';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Korrekt';
					case GenderContext.female:
						return 'Korrekt';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Nagyon rossz';
					case GenderContext.female:
						return 'Nagyon rossz';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Hiányos adatok';
					case GenderContext.female:
						return 'Hiányos adatok';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'Úgy tűnik, nincs elég rögzített kiadásunk ahhoz, hogy kiszámítsuk a pénzügyi állapotát. Adjon hozzá néhány kiadást/bevételt ebben az időszakban, hogy tudjunk segíteni Önnek!';
			case 'financial_health.review.descr.very_good': return 'Gratulálunk! Az Ön pénzügyi helyzete nagyon rendben van. Reméljük, hogy folytatódik a jó szériája, és továbbra is tanulni fog a Monekin-nel.';
			case 'financial_health.review.descr.good': return 'Nagyszerű! Az Ön pénzügyi helyzete rendben van. Látogasson el az elemzés fülre, hogy megtudja, hogyan takaríthat meg még többet!';
			case 'financial_health.review.descr.normal': return 'Az Ön pénzügyi állapota nagyjából a lakosság többi részének átlagában van ebben az időszakban.';
			case 'financial_health.review.descr.bad': return 'Úgy tűnik, hogy az Ön pénzügyi helyzete még nem a legjobb. Tekintse át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
			case 'financial_health.review.descr.very_bad': return 'Hmm, a pénzügyi helyzete messze elmarad attól, aminek lennie kellene. Nézze át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
			case 'financial_health.months_without_income.title': return 'Túlélési arány';
			case 'financial_health.months_without_income.subtitle': return 'Egyenlegét tekintve, mennyi ideig maradhat bevétel nélkül';
			case 'financial_health.months_without_income.text_zero': return 'Ilyen kiadás mellett egy hónapot sem bírna ki bevétel nélkül!';
			case 'financial_health.months_without_income.text_one': return 'Ilyen mértékű kiadások mellett aligha tudna akár egy hónapot is túlélni bevétel nélkül!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'Ezzel a költési aránnyal körülbelül <b>${n} hónapot</b> tudna túlélni jövedelem nélkül.';
			case 'financial_health.months_without_income.text_infinite': return 'Ezzel a költési aránnyal nagyjából <b>az egész életében</b> meg tudna élni jövedelem nélkül.';
			case 'financial_health.months_without_income.suggestion': return 'Ne feledje, hogy célszerű ezt az arányt mindig legalább 5 hónap felett tartani. Ha úgy látja, hogy nem rendelkezik elegendő megtakarítási tartalékkal, csökkentse a felesleges kiadásokat.';
			case 'financial_health.months_without_income.insufficient_data': return 'Úgy tűnik, nincs elég rögzített kiadásunk ahhoz, hogy kiszámolhassuk, hány hónapig tudna bevétel nélkül megélni. Adjon meg néhány tranzakciót, és térjen vissza ide, hogy ellenőrizze a pénzügyi helyzetét.';
			case 'financial_health.savings_percentage.title': return 'Megtakarítási százalék';
			case 'financial_health.savings_percentage.subtitle': return 'A jövedelmének mekkora részét nem költi el ebben az időszakban';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Gratulálunk! Ebben az időszakban a bevételének <b>${value}%</b>-át sikerült megtakarítania. Úgy tűnik, már rendelkezik hozzáértéssel, csak így tovább!';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Gratulálunk, a bevételének <b>${value}%</b>-át sikerült megtakarítania ebben az időszakban.';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'Ebben az időszakban sikerült megtakarítania a jövedelmének <b>${value}%-át</b>. Úgy gondoljuk azonban, hogy ennél még sokkal többet is tehet!';
			case 'financial_health.savings_percentage.text.very_bad': return 'Hűha, sajnos ebben az időszakban semmit sem sikerült megtakarítania.';
			case 'financial_health.savings_percentage.suggestion': return 'Ne feledje, hogy a jövedelmének legalább 15-20%-át célszerű megtakarítani.';
			case 'stats.title': return 'Statisztika';
			case 'stats.balance': return 'Egyenleg';
			case 'stats.final_balance': return 'Végső egyenleg';
			case 'stats.balance_by_account': return 'Számlák szerinti egyenleg';
			case 'stats.balance_by_account_subtitle': return 'Hol van a legtöbb pénzem?';
			case 'stats.balance_by_currency': return 'Egyenleg pénznemenként';
			case 'stats.balance_by_currency_subtitle': return 'Mennyi pénzem van devizában?';
			case 'stats.balance_evolution': return 'Egyenleg alakulása';
			case 'stats.balance_evolution_subtitle': return 'Több pénzem van, mint korábban?';
			case 'stats.compared_to_previous_period': return 'Az előző időszakhoz képest';
			case 'stats.cash_flow': return 'Pénzforgalom';
			case 'stats.cash_flow_subtitle': return 'Kevesebbet költök, mint amennyit megkeresek?';
			case 'stats.by_periods': return 'Időszakonként';
			case 'stats.by_categories': return 'Kategóriánként';
			case 'stats.by_tags': return 'Címkék szerint';
			case 'stats.distribution': return 'Megoszlás';
			case 'stats.finance_health_resume': return 'Folytatás';
			case 'stats.finance_health_breakdown': return 'Csőd';
			case 'icon_selector.name': return 'Név:';
			case 'icon_selector.icon': return 'Ikon';
			case 'icon_selector.color': return 'Szín';
			case 'icon_selector.select_icon': return 'Ikon kiválasztása';
			case 'icon_selector.select_color': return 'Szín kiválasztása';
			case 'icon_selector.custom_color': return 'Egyedi szín';
			case 'icon_selector.current_color_selection': return 'Jelenlegi kiválasztás';
			case 'icon_selector.select_account_icon': return 'Számla azonosítása';
			case 'icon_selector.select_category_icon': return 'Kategória azonosítása';
			case 'icon_selector.scopes.transport': return 'Közlekedés';
			case 'icon_selector.scopes.money': return 'Pénz';
			case 'icon_selector.scopes.food': return 'Élelmiszer';
			case 'icon_selector.scopes.medical': return 'Egészség';
			case 'icon_selector.scopes.entertainment': return 'Szabadidő';
			case 'icon_selector.scopes.technology': return 'Technológia';
			case 'icon_selector.scopes.other': return 'Egyebek';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Pénzintézetek';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Tranzakció',
				other: 'Tranzakciók',
			);
			case 'transaction.create': return 'Új tranzakció';
			case 'transaction.new_income': return 'Új bevétel';
			case 'transaction.new_expense': return 'Új kiadás';
			case 'transaction.new_success': return 'A tranzakció sikeresen létrehozva';
			case 'transaction.edit': return 'Tranzakció szerkesztése';
			case 'transaction.edit_success': return 'A tranzakció sikeresen szerkesztve';
			case 'transaction.edit_multiple': return 'Tranzakciók szerkesztése';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} tranzakció sikeresen szerkesztve';
			case 'transaction.duplicate': return 'Tranzakció klónozása';
			case 'transaction.duplicate_short': return 'Klónozás';
			case 'transaction.duplicate_warning_message': return 'Egy ezzel megegyező tranzakció jön létre ugyanazzal a dátummal, folytatni szeretné?';
			case 'transaction.duplicate_success': return 'A tranzakció sikeresen klónozva';
			case 'transaction.delete': return 'Tranzakció törlése';
			case 'transaction.delete_warning_message': return 'Ez a művelet visszafordíthatatlan. A számlák aktuális egyenlege és az összes statisztikája újraszámításra kerül.';
			case 'transaction.delete_success': return 'A tranzakció sikeresen törölve';
			case 'transaction.delete_multiple': return 'Tranzakciók törlése';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'Ez a művelet visszafordíthatatlan, és eltávolít ${x} tranzakciót. A számlái aktuális egyenlege és minden statisztikája újraszámításra kerül.';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} tranzakció megfelelően törölve';
			case 'transaction.details': return 'A mozgás részletei';
			case 'transaction.next_payments.accept': return 'Elfogadás';
			case 'transaction.next_payments.skip': return 'Kihagyás';
			case 'transaction.next_payments.skip_success': return 'A tranzakció sikeresen kihagyásra került';
			case 'transaction.next_payments.skip_dialog_title': return 'Tranzakció kihagyása';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'Ez a művelet visszafordíthatatlan. A következő átvitel dátumát módosítjuk erre: ${date}';
			case 'transaction.next_payments.accept_today': return 'Elfogadom ma';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Elfogadás a szükséges időpontban: (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'Tranzakció elfogadása';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'A tranzakció új állapota nulla lesz. A tranzakció státuszát bármikor újra módosíthatja, amikor csak akarja.';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'Ez a művelet egy új tranzakciót hoz létre ${date} dátummal. A tranzakció részleteit a tranzakciós oldalon ellenőrizheti.';
			case 'transaction.next_payments.recurrent_rule_finished': return 'Az ismétlődő szabály teljesült, nincs több kifizetés!';
			case 'transaction.list.empty': return 'Nem található itt megjeleníthető tranzakció. Adjon hozzá néhány tranzakciót az alkalmazásban, és talán legközelebb több szerencséje lesz.';
			case 'transaction.list.searcher_placeholder': return 'Keresés kategória, leírás alapján...';
			case 'transaction.list.searcher_no_results': return 'Nincs a keresési feltételeknek megfelelő tranzakció';
			case 'transaction.list.loading': return 'További tranzakciók betöltése...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: '${n} kiválasztva',
				other: '${n} kiválasztva',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: '${n} tranzakció kiválasztva',
				other: '${n} tranzakció kiválasztva',
			);
			case 'transaction.list.bulk_edit.dates': return 'Dátumok szerkesztése';
			case 'transaction.list.bulk_edit.categories': return 'Kategóriák szerkesztése';
			case 'transaction.list.bulk_edit.status': return 'Állapotok szerkesztése';
			case 'transaction.filters.from_value': return 'Ebből az összegből';
			case 'transaction.filters.to_value': return 'Eddig az összegig';
			case 'transaction.filters.from_value_def': return ({required Object x}) => 'Innen: ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => 'Ide: ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => 'Ettől: ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => 'Eddig: ${date}';
			case 'transaction.form.validators.zero': return 'A tranzakció értéke nem lehet nulla.';
			case 'transaction.form.validators.date_max': return 'A kiválasztott dátum az aktuális dátum után van. A tranzakció függő tranzakcióként kerül hozzáadásra.';
			case 'transaction.form.validators.date_after_account_creation': return 'Nem hozhat létre olyan tranzakciót, amelynek a dátuma megelőzi a hozzá tartozó számla létrehozásának a dátumát.';
			case 'transaction.form.validators.negative_transfer': return 'Az átutalás pénzbeli értéke nem lehet negatív.';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'A kiindulási és a célszámla nem lehet ugyanaz.';
			case 'transaction.form.title': return 'Tranzakció megnevezése';
			case 'transaction.form.title_short': return 'Cím';
			case 'transaction.form.value': return 'A tranzakció értéke';
			case 'transaction.form.tap_to_see_more': return 'Koppintson a további részletek megtekintéséhez';
			case 'transaction.form.no_tags': return '-- Nincsenek címkék --';
			case 'transaction.form.description': return 'Leírás';
			case 'transaction.form.description_info': return 'Koppintson ide a tranzakció részletesebb leírásának megadásához.';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => '${currency} átváltási árfolyam';
			case 'transaction.form.exchange_to_preferred_in_date': return 'A tranzakció napján';
			case 'transaction.reversed.title': return 'Megfordított tranzakció';
			case 'transaction.reversed.title_short': return 'Megfordított';
			case 'transaction.reversed.description_for_expenses': return 'Annak ellenére, hogy költségtranzakció, pozitív összegű. Az ilyen típusú tranzakciókat egy korábban elszámolt kiadás visszatérülésének, például visszatérítésnek vagy egy tartozás kifizetésének megjelenítésére lehet használni.';
			case 'transaction.reversed.description_for_incomes': return 'Annak ellenére, hogy bevételi tranzakció, negatív összegű. Az ilyen típusú tranzakciók felhasználhatók a helytelenül elszámolt bevétel érvénytelenítésére vagy helyesbítésére, pénzvisszatérítés vagy pénzvisszatérítés tükrözésére, illetve tartozások kifizetésének rögzítésére.';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Állapot',
				other: 'Állapotok',
			);
			case 'transaction.status.display_long': return 'Tranzakció állapota';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status} tranzakció';
			case 'transaction.status.none': return 'Állapot nélküli';
			case 'transaction.status.none_descr': return 'Konkrét állapot nélküli tranzakció';
			case 'transaction.status.reconciled': return 'Egyeztetett';
			case 'transaction.status.reconciled_descr': return 'Ezt a tranzakciót már érvényesítették, és megfelel a bankja valós tranzakciójának.';
			case 'transaction.status.unreconciled': return 'Nem egyeztetett';
			case 'transaction.status.unreconciled_descr': return 'Ezt a tranzakciót még nem ellenőrizték, ezért még nem jelenik meg a valódi bankszámláin. Ez azonban szükséges a Monekin egyenlegeinek és statisztikáinak kiszámításához.';
			case 'transaction.status.pending': return 'Függőben';
			case 'transaction.status.pending_descr': return 'Ez a tranzakció függőben van, ezért az egyenlegek és statisztikák kiszámításakor nem kerül figyelembevételbe.';
			case 'transaction.status.voided': return 'Érvénytelenítve';
			case 'transaction.status.voided_descr': return 'Fizetési hiba vagy bármilyen más ok miatt érvénytelenített/törölt tranzakció. Ezt nem vesszük figyelembe az egyenlegek és statisztikák kiszámításakor.';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Tranzakció típusa',
				other: 'Tranzakciótípusok',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Bevétel',
				other: 'Bevételek',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Kiadás',
				other: 'Kiadások',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Áthelyezés',
				other: 'Áthelyezések',
			);
			case 'transfer.display': return 'Áthelyezés';
			case 'transfer.transfers': return 'Áthelyezések';
			case 'transfer.transfer_to': return ({required Object account}) => 'Áthelyezés ide: ${account}';
			case 'transfer.create': return 'Új átvitel';
			case 'transfer.need_two_accounts_warning_header': return 'Hoppá!';
			case 'transfer.need_two_accounts_warning_message': return 'A művelet végrehajtásához legalább kettő számlára van szükség. Ha módosítani vagy szerkeszteni szeretné a számla aktuális egyenlegét, kattintson a szerkesztés gombra.';
			case 'transfer.form.from': return 'Eredeti számla';
			case 'transfer.form.to': return 'Célszámla';
			case 'transfer.form.value_in_destiny.title': return 'A rendeltetési helyre átutalt összeg';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} a célszámlához';
			case 'recurrent_transactions.title': return 'Ismétlődő tranzakciók';
			case 'recurrent_transactions.title_short': return 'Ism. tranzakciók';
			case 'recurrent_transactions.empty': return 'Úgy tűnik, hogy nincsenek ismétlődő tranzakciói. Hozzon létre havi, éves vagy heti ismétlődő tranzakciót, és az itt fog megjelenni.';
			case 'recurrent_transactions.total_expense_title': return 'Összes kiadás periódusonként';
			case 'recurrent_transactions.total_expense_descr': return '* Az egyes ismétlődések kezdő és befejező időpontjának figyelembevétele nélkül';
			case 'recurrent_transactions.details.title': return 'Ismétlődő tranzakció';
			case 'recurrent_transactions.details.descr': return 'A tranzakció következő lépései az alábbiakban láthatók. Elfogadhatja az első lépést, vagy kihagyhatja ezt a lépést.';
			case 'recurrent_transactions.details.last_payment_info': return 'Ez a mozgatás az utolsó az ismétlődő szabályban, így ez a szabály automatikusan törlődik a művelet megerősítésekor.';
			case 'recurrent_transactions.details.delete_header': return 'Ismétlődő tranzakció törlése';
			case 'recurrent_transactions.details.delete_message': return 'Ez a művelet visszafordíthatatlan, és nem érinti a már visszaigazolt/befizetett tranzakciókat.';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => 'Késés: ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => '${x} napon belül';
			case 'account.details': return 'Számlaadatok';
			case 'account.date': return 'Megnyitás dátuma';
			case 'account.close_date': return 'Lezárás dátuma';
			case 'account.reopen': return 'Számla újranyitása';
			case 'account.reopen_short': return 'Újranyitás';
			case 'account.reopen_descr': return 'Biztos, hogy újra meg akarja nyitni ezt a számlát?';
			case 'account.balance': return 'Számlaegyenleg';
			case 'account.n_transactions': return 'Tranzakciók száma';
			case 'account.add_money': return 'Hozzáadás';
			case 'account.withdraw_money': return 'Pénzfelvétel';
			case 'account.no_accounts': return 'Nem található itt megjeleníthető tranzakció. Adjon hozzá egy tranzakciót az alul található „+” gombra kattintva.';
			case 'account.types.title': return 'Számlatípus';
			case 'account.types.warning': return 'A számlatípus kiválasztása után az a jövőben nem változtatható meg.';
			case 'account.types.normal': return 'Normál számla';
			case 'account.types.normal_descr': return 'Hasznos a napi pénzügyek rögzítéséhez. Ez a leggyakoribb számla, amely lehetővé teszi kiadások, bevételek hozzáadását...';
			case 'account.types.saving': return 'Megtakarítási számla';
			case 'account.types.saving_descr': return 'Csak más számlákról tud pénzt hozzáadni és kivenni belőle. Tökéletes a megtakarítás megkezdéséhez.';
			case 'account.form.name': return 'Számla neve';
			case 'account.form.name_placeholder': return 'Pl.: Megtakarítási számla';
			case 'account.form.notes': return 'Megjegyzések';
			case 'account.form.notes_placeholder': return 'Írjon néhány megjegyzést/leírást erről a számláról.';
			case 'account.form.initial_balance': return 'Kezdőegyenleg';
			case 'account.form.current_balance': return 'Aktuális egyenleg';
			case 'account.form.create': return 'Számla létrehozása';
			case 'account.form.edit': return 'Számla szerkesztése';
			case 'account.form.currency_not_found_warn': return 'Nincs információja ennek a pénznemnek az árfolyamairól. 1,0 lesz az alapértelmezett átváltási árfolyam. Ezt a beállításokban tudja majd módosítani.';
			case 'account.form.already_exists': return 'Ugyanezzel a névvel már van egy másik is. Kérjük, adjon meg egy másikat.';
			case 'account.form.tr_before_opening_date': return 'A számlán a nyitási dátumot megelőző dátumú tranzakciók vannak.';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return 'Törli a számlát?';
			case 'account.delete.warning_text': return 'Ez a művelet törli ezt a számlát és annak az összes tranzakcióját.';
			case 'account.delete.success': return 'A számla sikeresen törlésre került';
			case 'account.close.title': return 'Számla lezárása';
			case 'account.close.title_short': return 'Lezárás';
			case 'account.close.warn': return 'Ez a számla többé nem jelenik meg bizonyos listákban, és nem tud benne tranzakciókat létrehozni az alább megadott dátumnál későbbi dátummal. Ez a művelet semmilyen tranzakciót vagy egyenleget nem érint, és ezt a számlát bármikor újra megnyithatja. ';
			case 'account.close.should_have_zero_balance': return 'A számla lezárásához 0-nak kell lennie az aktuális egyenlegnek. Kérjük, a folytatás előtt szerkessze át a számlát.';
			case 'account.close.should_have_no_transactions': return 'Ez a számla a megadott zárási dátumot követő tranzakciókat tartalmaz. Törölje őket, vagy szerkessze a számla zárási dátumát, mielőtt folytatná.';
			case 'account.close.success': return 'A számla sikeresen lezárva';
			case 'account.close.unarchive_succes': return 'A számla sikeresen újranyitásra került';
			case 'account.select.one': return 'Egy számla kiválasztása';
			case 'account.select.all': return 'Összes számla';
			case 'account.select.multiple': return 'Számlák kiválasztása';
			case 'currencies.currency_converter': return 'Valutaváltó';
			case 'currencies.currency': return 'Pénznem';
			case 'currencies.currency_manager': return 'Valutakezelő';
			case 'currencies.currency_manager_descr': return 'Konfigurálja a pénznemet és annak árfolyamait másokkal együtt';
			case 'currencies.preferred_currency': return 'Kedvelt/alap pénznem';
			case 'currencies.change_preferred_currency_title': return 'Kedvelt pénznem módosítása';
			case 'currencies.change_preferred_currency_msg': return 'Mostantól minden statisztika és költségvetés ebben a pénznemben jelenik meg. A számlák és tranzakciók megtartják a korábbi pénznemet. Minden elmentett árfolyam törlődik, ha ezt a műveletet végrehajtja. Szeretné folytatni?';
			case 'currencies.form.equal_to_preferred_warn': return 'A pénznem nem lehet azonos a felhasználói pénznemmel';
			case 'currencies.form.specify_a_currency': return 'Kérjük, adjon meg egy pénznemet';
			case 'currencies.form.add': return 'Árfolyam hozzáadása';
			case 'currencies.form.add_success': return 'Az árfolyam sikeresen hozzáadva';
			case 'currencies.form.edit': return 'Árfolyam szerkesztése';
			case 'currencies.form.edit_success': return 'Az árfolyam szerkesztése sikerült';
			case 'currencies.delete_all_success': return 'Az árfolyamok sikeresen törlésre kerültek';
			case 'currencies.historical': return 'Árfolyamtörténetek';
			case 'currencies.exchange_rate': return 'Árfolyam';
			case 'currencies.exchange_rates': return 'Árfolyamok';
			case 'currencies.empty': return 'Adja hozzá az árfolyamokat, hogy ha az alapvalutától eltérő valutában vezetett számlái vannak, és így a grafikonok pontosabbak legyenek.';
			case 'currencies.select_a_currency': return 'Válasszon ki egy pénznemet';
			case 'currencies.search': return 'Keresés név vagy pénznemkód alapján';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Felirat',
				other: 'Címkék',
			);
			case 'tags.form.name': return 'Címke neve';
			case 'tags.form.description': return 'Leírás';
			case 'tags.select.title': return 'Címke kiválasztása';
			case 'tags.select.all': return 'Minden címke';
			case 'tags.empty_list': return 'Még nem hozott létre címkéket. A címkék és kategóriák nagyszerű lehetőséget kínálnak a pénzmozgások kategorizálására.';
			case 'tags.without_tags': return 'Címkék nélkül';
			case 'tags.add': return 'Hozzáadás';
			case 'tags.create': return 'Felirat készítése';
			case 'tags.create_success': return 'A felirat sikeresen létrehozva';
			case 'tags.already_exists': return 'Ez a címkenév már létezik. Érdemes lehet átszerkeszteni';
			case 'tags.edit': return 'Címke szerkesztése';
			case 'tags.edit_success': return 'A címke sikeresen szerkesztésre került';
			case 'tags.delete_success': return 'A kategória sikeresen törölve';
			case 'tags.delete_warning_header': return 'Törli a címkét?';
			case 'tags.delete_warning_message': return 'Ez a művelet nem törli az ezzel a címkével rendelkező tranzakciókat.';
			case 'categories.unknown': return 'Ismeretlen kategória';
			case 'categories.create': return 'Kategória létrehozása';
			case 'categories.create_success': return 'A kategória sikeresen létrehozva';
			case 'categories.new_category': return 'Új kategória';
			case 'categories.already_exists': return 'Ez a kategórianév már létezik. Talán szeretné szerkeszteni?';
			case 'categories.edit': return 'Kategória szerkesztése';
			case 'categories.edit_success': return 'A kategória sikeresen szerkesztve lett';
			case 'categories.name': return 'Kategória neve';
			case 'categories.type': return 'Kategória típusa';
			case 'categories.both_types': return 'Mindkét típus';
			case 'categories.subcategories': return 'Alkategóriák';
			case 'categories.subcategories_add': return 'Hozzáadás';
			case 'categories.make_parent': return 'Kategória létrehozása';
			case 'categories.make_child': return 'Alkategória létrehozása';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'Ez a kategória és alkategóriái a(z) <b>${destiny}</b> alkategóriái lesznek.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'A tranzakcióik <b>(${x})</b> átkerülnek a(z) <b>${destiny}</b> kategóriában létrehozott új alkategóriákba.';
			case 'categories.make_child_success': return 'Az alkategóriák sikeresen létrehozva';
			case 'categories.merge': return 'Összevonás másik kategóriával';
			case 'categories.merge_warning1': return ({required Object from, required Object x, required Object destiny}) => 'A(z) <b>${from}</b> kategóriához tartozó összes tranzakció (${x}) átkerül a(z) <b>${destiny}</b> kategóriába.';
			case 'categories.merge_warning2': return ({required Object from}) => 'A(z) <b>${from}</b> kategória visszafordíthatatlanul törlésre kerül.';
			case 'categories.merge_success': return 'A kategória sikeresen egyesítve';
			case 'categories.delete_success': return 'A kategória sikeresen törölve';
			case 'categories.delete_warning_header': return 'Törli a kategóriát?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'Ez a művelet visszafordíthatatlanul törli az összes <b>(${x})</b> tranzakciót, amely ehhez a kategóriához kapcsolódik.';
			case 'categories.select.title': return 'Kategóriák kiválasztása';
			case 'categories.select.select_one': return 'Kategória kiválasztása';
			case 'categories.select.select_subcategory': return 'Alkategória kiválasztása';
			case 'categories.select.without_subcategory': return 'Alkategória nélkül';
			case 'categories.select.all': return 'Összes kategória';
			case 'categories.select.all_short': return 'Mind';
			case 'budgets.title': return 'Költségvetések';
			case 'budgets.repeated': return 'Ismétlődő';
			case 'budgets.one_time': return 'Egyszer';
			case 'budgets.annual': return 'Éves';
			case 'budgets.week': return 'Hetente';
			case 'budgets.month': return 'Havonta';
			case 'budgets.actives': return 'Aktívok';
			case 'budgets.pending': return 'Függőben lévő kezdés';
			case 'budgets.finish': return 'Kész';
			case 'budgets.from_budgeted': return 'maradt ';
			case 'budgets.days_left': return 'nap van hátra';
			case 'budgets.days_to_start': return 'nap van a kezdésig';
			case 'budgets.since_expiration': return 'napja lejárt';
			case 'budgets.no_budgets': return 'Úgy tűnik, hogy ebben a szakaszban nincs megjelenítendő költségvetés. Kezdje a költségvetés létrehozásával az alábbi gombra kattintva.';
			case 'budgets.delete': return 'Költségvetés törlése';
			case 'budgets.delete_warning': return 'Ez a művelet visszafordíthatatlan. Az erre az ajánlatra hivatkozó kategóriák és tranzakciók nem törlődnek.';
			case 'budgets.form.title': return 'Hozzáadás';
			case 'budgets.form.name': return 'Költségvetés neve';
			case 'budgets.form.value': return 'Mennyiségkorlátozás';
			case 'budgets.form.create': return 'Hozzáadás';
			case 'budgets.form.edit': return 'Szerkesztés';
			case 'budgets.form.negative_warn': return 'A költségvetések nem lehetnek negatív összegűek.';
			case 'budgets.details.title': return 'Költségvetés részletei';
			case 'budgets.details.statistics': return 'Statisztika';
			case 'budgets.details.budget_value': return 'Költségvetésben';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => 'Naponta ${dailyAmount} -ot költhet el, még ${remainingDays} napig';
			case 'budgets.details.expend_evolution': return 'Költségek alakulása';
			case 'budgets.details.no_transactions': return 'Úgy tűnik, hogy ezzel a költségvetéssel kapcsolatban semmilyen kiadást nem teljesített.';
			case 'backup.export.title': return 'Adatok exportálása';
			case 'backup.export.title_short': return 'Exportálás';
			case 'backup.export.all': return 'Teljes mentés';
			case 'backup.export.all_descr': return 'Exportálja az összes adatát (számlák, tranzakciók, költségvetések, beállítások...). Bármikor újra importálhatja őket, így semmit sem veszíthet el.';
			case 'backup.export.transactions': return 'Tranzakciók mentése';
			case 'backup.export.transactions_descr': return 'Exportálja tranzakcióit CSV formátumban, így könnyebben elemezheti azokat más programokban vagy alkalmazásokban.';
			case 'backup.export.description': return 'Adatok letöltése különböző formátumokban';
			case 'backup.export.dialog_title': return 'Fájl mentése/küldése';
			case 'backup.export.success': return ({required Object x}) => 'A fájl sikeresen mentve/letöltve ide: ${x}';
			case 'backup.export.error': return 'Hiba a fájl letöltésében. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
			case 'backup.import.title': return 'Adatok importálása';
			case 'backup.import.title_short': return 'Importálás';
			case 'backup.import.restore_backup': return 'Mentés visszaállítása';
			case 'backup.import.restore_backup_descr': return 'Importáljon egy korábban mentett adatbázist a Monekinből. Ez a művelet minden jelenlegi alkalmazásadatot lecseréli az új adatokra.';
			case 'backup.import.restore_backup_warn_description': return 'Új adatbázis importálásakor az alkalmazásban jelenleg mentett összes adat elveszik. A folytatás előtt ajánlatos biztonsági másolatot készíteni. Ne töltsön fel ide olyan fájlt, amelynek eredetét nem ismeri, csak azokat a fájlokat töltse fel, amelyeket korábban letöltött a Monekin oldaláról.';
			case 'backup.import.restore_backup_warn_title': return 'Az összes adat felülírása';
			case 'backup.import.select_other_file': return 'Másik fájl kiválasztása';
			case 'backup.import.tap_to_select_file': return 'Koppintson a fájl kiválasztásához';
			case 'backup.import.manual_import.title': return 'Kézi importálás';
			case 'backup.import.manual_import.descr': return 'Tranzakciók kézi importálása egy .csv fájlból';
			case 'backup.import.manual_import.default_account': return 'Alapértelm. számla';
			case 'backup.import.manual_import.remove_default_account': return 'Alapértelmezett számla törlése';
			case 'backup.import.manual_import.default_category': return 'Alapértelm. kategória';
			case 'backup.import.manual_import.select_a_column': return 'Válasszon ki egy oszlopot a .csv fájlból';
			case 'backup.import.manual_import.steps.0': return 'Fájl kiválasztása';
			case 'backup.import.manual_import.steps.1': return 'Mennyiség oszlop';
			case 'backup.import.manual_import.steps.2': return 'Számlaoszlop';
			case 'backup.import.manual_import.steps.3': return 'Kategória oszlop';
			case 'backup.import.manual_import.steps.4': return 'Dátum oszlop';
			case 'backup.import.manual_import.steps.5': return 'egyéb oszlopok';
			case 'backup.import.manual_import.steps_descr.0': return 'Válasszon ki egy .csv fájlt az eszközről. Győződjön meg arról, hogy van egy első sora, amely leírja az egyes oszlopok nevét.';
			case 'backup.import.manual_import.steps_descr.1': return 'Válassza ki azt az oszlopot, amelyben az egyes tranzakciók dátuma meg van adva. Ha nincs megadva, a tranzakciók az aktuális dátummal jönnek létre. Válassza ki azt az oszlopot, ahol az egyes tranzakciók értéke meg van adva. Használjon negatív értékeket a kiadásokhoz és pozitív értékeket a bevételekhez. Használjon pontot tizedeselválasztóként.';
			case 'backup.import.manual_import.steps_descr.2': return 'Válassza ki azt az oszlopot, amelyben meg van adva az a számla, amelyhez az egyes tranzakciók tartoznak. Kiválaszthat egy alapértelmezett fiókot is arra az esetre, ha nem találnánk a kívánt fiókot. Ha nincs megadva alapértelmezett fiók, akkor létrehozunk egyet ugyanazzal a névvel. ';
			case 'backup.import.manual_import.steps_descr.3': return 'Adja meg azt az oszlopot, ahol a tranzakciókategória neve található. Meg kell adnia egy alapértelmezett kategóriát, hogy ezt a kategóriát rendeljük hozzá a tranzakciókhoz, ha a kategória nem található.';
			case 'backup.import.manual_import.steps_descr.4': return 'Válassza ki azt az oszlopot, amelyben az egyes tranzakciók dátuma meg van adva. Ha nincs megadva, a tranzakciók az aktuális dátummal jönnek létre.';
			case 'backup.import.manual_import.steps_descr.5': return 'Az egyéb opcionális tranzakciós attribútumok oszlopainak meghatározása';
			case 'backup.import.manual_import.success': return ({required Object x}) => '${x} tranzakció sikeresen importálva';
			case 'backup.import.success': return 'Az importálás sikeresen végrehajtva';
			case 'backup.import.cancelled': return 'Az importálást a felhasználó megszakította';
			case 'backup.import.error': return 'Hiba történt importálásakor. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
			case 'backup.about.title': return 'Információk az adatbázisról';
			case 'backup.about.create_date': return 'Létrehozás dátuma';
			case 'backup.about.modify_date': return 'Utolsó módosítása';
			case 'backup.about.last_backup': return 'Utolsó mentés';
			case 'backup.about.size': return 'Méret';
			case 'settings.title_long': return 'Beállítások és megjelenés';
			case 'settings.title_short': return 'Beállítások';
			case 'settings.description': return 'Alkalmazás témája, szövegek és egyéb általános beállítások';
			case 'settings.edit_profile': return 'Profil szerkesztése';
			case 'settings.lang_section': return 'Nyelv és szövegek';
			case 'settings.lang_title': return 'Alkalmazás nyelve';
			case 'settings.lang_descr': return 'Nyelv, amelyen a szövegek megjelennek az alkalmazásban';
			case 'settings.lang_help': return 'Ha együttműködni szeretne ennek az alkalmazásnak a fordításával, tekintse meg a <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'> útmutatónk</a>';
			case 'settings.locale': return 'Régió';
			case 'settings.locale_descr': return 'Dátumok, számformátumok beállítása...';
			case 'settings.locale_warn': return 'Régióváltáskor az alkalmazás frissülni fog';
			case 'settings.first_day_of_week': return 'A hét első napja';
			case 'settings.theme_and_colors': return 'Témák és színek';
			case 'settings.theme': return 'Téma';
			case 'settings.theme_auto': return 'A rendszer határozza meg';
			case 'settings.theme_light': return 'Világos';
			case 'settings.theme_dark': return 'Sötét';
			case 'settings.amoled_mode': return 'AMOLED mód';
			case 'settings.amoled_mode_descr': return 'Ha lehetséges, használjon tiszta fekete háttérképet. Ez némileg segíti az AMOLED képernyővel rendelkező készülékek akkumulátorát.';
			case 'settings.dynamic_colors': return 'Dinamikus színek';
			case 'settings.dynamic_colors_descr': return 'Amikor csak lehetséges, használja a rendszer kiemelő színét';
			case 'settings.accent_color': return 'Kiemelő szín';
			case 'settings.accent_color_descr': return 'Válassza ki, hogy az alkalmazás milyen színnel emelje ki a felület bizonyos részeit';
			case 'settings.security.title': return 'Biztonság';
			case 'settings.security.private_mode_at_launch': return 'Privát mód indításkor';
			case 'settings.security.private_mode_at_launch_descr': return 'Az alkalmazás alapértelmezés szerinti indítása privát módban';
			case 'settings.security.private_mode': return 'Privát mód';
			case 'settings.security.private_mode_descr': return 'Minden pénzösszeg elrejtése';
			case 'settings.security.private_mode_activated': return 'Privát mód aktiválva';
			case 'settings.security.private_mode_deactivated': return 'Privát mód letiltva';
			case 'more.title': return 'Továbbiak';
			case 'more.title_long': return 'További műveletek';
			case 'more.data.display': return 'Adatok';
			case 'more.data.display_descr': return 'Exportálja és importálja az adatait, hogy ne veszítsen el semmit se';
			case 'more.data.delete_all': return 'Adataim törlése';
			case 'more.data.delete_all_header1': return 'Álljon meg ⚠️⚠️';
			case 'more.data.delete_all_message1': return 'Biztosan benne, hogy folytatja? Minden adata véglegesen törlődik, és nem állítható vissza';
			case 'more.data.delete_all_header2': return 'Még egy utolsó lépés ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'A fiók törlésével törli az összes tárolt személyes adatát. A számlái, tranzakciói, költségvetései és kategóriái törlődnek, és nem állíthatók helyre. Egyetért ezzel?';
			case 'more.about_us.display': return 'Alkalmazásinformációk';
			case 'more.about_us.description': return 'Nézze meg a Monekinre vonatkozó feltételeket és egyéb fontos információkat. Lépjen kapcsolatba a közösséggel a hibák bejelentésével, javaslatok megtételével...';
			case 'more.about_us.legal.display': return 'Jogi információk';
			case 'more.about_us.legal.privacy': return 'Adatvédelem';
			case 'more.about_us.legal.terms': return 'Használati feltételek';
			case 'more.about_us.legal.licenses': return 'Licencek';
			case 'more.about_us.project.display': return 'Projekt';
			case 'more.about_us.project.contributors': return 'Közreműködők';
			case 'more.about_us.project.contributors_descr': return 'Az összes fejlesztő, akik hozzájárultak a Monekin létrehozásához';
			case 'more.about_us.project.contact': return 'Kapcsolatfelvétel';
			case 'more.help_us.display': return 'Segítsen nekünk';
			case 'more.help_us.description': return 'Tudja meg, hogyan segíthet a Monekinnek abban, hogy egyre jobb és jobb legyen';
			case 'more.help_us.rate_us': return 'Értékeljen minket';
			case 'more.help_us.rate_us_descr': return 'Bármilyen értékelést szívesen fogadunk!';
			case 'more.help_us.share': return 'Monekin megosztása';
			case 'more.help_us.share_descr': return 'Ossza meg alkalmazásunkat a barátaival és a családtagjaival';
			case 'more.help_us.share_text': return 'Monekin! A legjobb személyes pénzügyi alkalmazás. Töltse le innen';
			case 'more.help_us.thanks': return 'Köszönjük!';
			case 'more.help_us.thanks_long': return 'Az Ön hozzájárulása a Monekinhez és más nyílt forráskódú projektekhez, legyen az kicsi vagy nagy, lehetővé teszi az ehhez hasonló nagyszerű projekteket. Köszönjük, hogy időt szán a közreműködésre.';
			case 'more.help_us.donate': return 'Adományozás';
			case 'more.help_us.donate_descr': return 'Az adományával segít az alkalmazás további fejlesztésében. Mi lehetne jobb módja, mint megköszönni az elvégzett munkát egy kávéra való meghívással?';
			case 'more.help_us.donate_success': return 'Az adományozás megtörtént. Köszönöm szépen a közreműködését! ❤️';
			case 'more.help_us.donate_err': return 'Hoppá! Úgy tűnik, hiba történt a fizetés fogadásakor';
			case 'more.help_us.report': return 'Hibák jelentése, javaslatok...';
			default: return null;
		}
	}
}

extension on _TranslationsUk {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'general.cancel': return 'Скасувати';
			case 'general.or': return 'або';
			case 'general.understood': return 'Зрозуміло';
			case 'general.unspecified': return 'Не вказано';
			case 'general.confirm': return 'Підтвердити';
			case 'general.continue_text': return 'Продовжити';
			case 'general.quick_actions': return 'Швидкі дії';
			case 'general.save': return 'Зберегти';
			case 'general.save_changes': return 'Зберегти зміни';
			case 'general.close_and_save': return 'Закрити та зберегти';
			case 'general.add': return 'Додати';
			case 'general.edit': return 'Редагувати';
			case 'general.balance': return 'Баланс';
			case 'general.delete': return 'Видалити';
			case 'general.account': return 'Рахунок';
			case 'general.accounts': return 'Рахунки';
			case 'general.categories': return 'Категорії';
			case 'general.category': return 'Категорія';
			case 'general.today': return 'Сьогодні';
			case 'general.yesterday': return 'Вчора';
			case 'general.filters': return 'Фільтри';
			case 'general.see_more': return 'Побачити більше';
			case 'general.select_all': return 'Вибрати всі';
			case 'general.deselect_all': return 'Скасувати вибір усіх';
			case 'general.empty_warn': return 'Ой! Тут порожньо';
			case 'general.insufficient_data': return 'Недостатньо даних';
			case 'general.show_more_fields': return 'Показати більше полів';
			case 'general.show_less_fields': return 'Показати менше полів';
			case 'general.tap_to_search': return 'Натисніть для пошуку';
			case 'general.clipboard.success': return ({required Object x}) => '${x} скопійовано в буфер обміну';
			case 'general.clipboard.error': return 'Помилка копіювання';
			case 'general.time.start_date': return 'Початкова дата';
			case 'general.time.end_date': return 'Кінцева дата';
			case 'general.time.from_date': return 'З дати';
			case 'general.time.until_date': return 'До дати';
			case 'general.time.date': return 'Дата';
			case 'general.time.datetime': return 'Дата та час';
			case 'general.time.time': return 'Час';
			case 'general.time.each': return 'Кожний';
			case 'general.time.after': return 'Після';
			case 'general.time.ranges.display': return 'Часовий діапазон';
			case 'general.time.ranges.it_repeat': return 'Повторюється';
			case 'general.time.ranges.it_ends': return 'Закінчується';
			case 'general.time.ranges.forever': return 'Назавжди';
			case 'general.time.ranges.types.cycle': return 'Цикли';
			case 'general.time.ranges.types.last_days': return 'Останні дні';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '${x} попередніх днів';
			case 'general.time.ranges.types.all': return 'Завжди';
			case 'general.time.ranges.types.date_range': return 'Власний діапазон';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range}',
				other: 'Кожних ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range} до ${day}',
				other: 'Кожних ${n} ${range} до ${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range} ${limit} раз',
				other: 'Кожних ${n} ${range} ${limit} раз',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range} один раз',
				other: 'Кожних ${n} ${range} один раз',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Місяць',
				other: 'Місяці',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Рік',
				other: 'Роки',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'День',
				other: 'Дні',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Тиждень',
				other: 'Тижні',
			);
			case 'general.time.periodicity.display': return 'Повторення';
			case 'general.time.periodicity.no_repeat': return 'Без повторень';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Повторення',
				other: 'Повторень',
			);
			case 'general.time.periodicity.diary': return 'Щоденно';
			case 'general.time.periodicity.monthly': return 'Щомісяця';
			case 'general.time.periodicity.annually': return 'Щороку';
			case 'general.time.periodicity.quaterly': return 'Щокварталу';
			case 'general.time.periodicity.weekly': return 'Щотижня';
			case 'general.time.periodicity.custom': return 'Власний';
			case 'general.time.periodicity.infinite': return 'Завжди';
			case 'general.time.current.monthly': return 'Цього місяця';
			case 'general.time.current.annually': return 'Цього року';
			case 'general.time.current.quaterly': return 'Цього кварталу';
			case 'general.time.current.weekly': return 'На цьому тижні';
			case 'general.time.current.infinite': return 'Назавжди';
			case 'general.time.current.custom': return 'Власний діапазон';
			case 'general.time.all.diary': return 'Щоденно';
			case 'general.time.all.monthly': return 'Щомісяця';
			case 'general.time.all.annually': return 'Щороку';
			case 'general.time.all.quaterly': return 'Щокварталу';
			case 'general.time.all.weekly': return 'Щотижня';
			case 'general.transaction_order.display': return 'Сортувати транзакції';
			case 'general.transaction_order.category': return 'За категорією';
			case 'general.transaction_order.quantity': return 'За кількістю';
			case 'general.transaction_order.date': return 'За датою';
			case 'general.validations.form_error': return 'Виправте поля, зазначені у формі, щоб продовжити';
			case 'general.validations.required': return 'Обов\'язкове поле';
			case 'general.validations.positive': return 'Повинно бути позитивним';
			case 'general.validations.min_number': return ({required Object x}) => 'Повинно бути більшим, ніж ${x}';
			case 'general.validations.max_number': return ({required Object x}) => 'Повинно бути меншим, ніж ${x}';
			case 'intro.start': return 'Початок';
			case 'intro.skip': return 'Пропустити';
			case 'intro.next': return 'Далі';
			case 'intro.select_your_currency': return 'Виберіть вашу валюту';
			case 'intro.welcome_subtitle': return 'Ваш особистий фінансовий менеджер';
			case 'intro.welcome_subtitle2': return '100% відкритий, 100% безкоштовний';
			case 'intro.welcome_footer': return 'Увійшовши в систему, ви погоджуєтеся з <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Політикою конфіденційності</a> та <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Умовами використання</a> додатка';
			case 'intro.offline_descr_title': return 'ОФЛАЙН-РЕЖИМ:';
			case 'intro.offline_descr': return 'Ваші дані будуть збережені тільки на вашому пристрої, поки ви не видалите програму або не зміните телефон. Щоб запобігти втраті даних, рекомендується регулярно робити резервні копії з налаштувань програми.';
			case 'intro.offline_start': return 'Почати сеанс офлайн';
			case 'intro.sl1_title': return 'Виберіть вашу валюту';
			case 'intro.sl1_descr': return 'Ваша основна валюта буде використовуватися в звітах та загальних діаграмах. Ви зможете змінити валюту та мову програми пізніше в будь-який час у налаштуваннях додатка';
			case 'intro.sl2_title': return 'Безпечно, приватно і надійно';
			case 'intro.sl2_descr': return 'Ваші дані належать тільки вам. Інформація зберігається безпосередньо на вашому пристрої, без пропуску через зовнішні сервери. Це дозволяє використовувати додаток навіть без Інтернету';
			case 'intro.sl2_descr2': return 'Крім того, вихідний код програми є відкритим, будь-хто може вносити свої правки та переглядати, як він працює';
			case 'intro.last_slide_title': return 'Все готово';
			case 'intro.last_slide_descr': return 'З Monekin ви нарешті можете досягти фінансової незалежності, яку так багато хочете. У вас будуть графіки, бюджети, поради, статистика та багато іншого про ваші фінанси.';
			case 'intro.last_slide_descr2': return 'Сподіваємося, вам сподобається користуватись додатком! Не соромтеся зв\'язатися з нами у разі сумнівів або пропозицій...';
			case 'home.title': return 'Панель керування';
			case 'home.filter_transactions': return 'Фільтрувати транзакції';
			case 'home.hello_day': return 'Доброго ранку,';
			case 'home.hello_night': return 'Доброї ночі,';
			case 'home.total_balance': return 'Загальний баланс';
			case 'home.my_accounts': return 'Мої рахунки';
			case 'home.active_accounts': return 'Активні рахунки';
			case 'home.no_accounts': return 'Рахунки ще не створені';
			case 'home.no_accounts_descr': return 'Почніть використовувати всю магію Monekin. Створіть принаймні один рахунок, щоб почати додавати транзакції';
			case 'home.last_transactions': return 'Останні транзакції';
			case 'home.should_create_account_header': return 'Ой!';
			case 'home.should_create_account_message': return 'Перш ніж почати створювати транзакції, вам потрібно мати принаймні один неархівований рахунок';
			case 'financial_health.display': return 'Фінансове здоров\'я';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Дуже добре!';
					case GenderContext.female:
						return 'Дуже добре!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Добре';
					case GenderContext.female:
						return 'Добре';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Середнє';
					case GenderContext.female:
						return 'Середнє';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Прийнятно';
					case GenderContext.female:
						return 'Прийнятно';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Дуже погано';
					case GenderContext.female:
						return 'Дуже погано';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Недостатньо даних';
					case GenderContext.female:
						return 'Недостатньо даних';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'Схоже, у нас недостатньо витрат, щоб розрахувати ваше фінансове здоров\'я. Додайте деякі витрати/доходи за цей період, щоб дозволити нам допомогти вам!';
			case 'financial_health.review.descr.very_good': return 'Вітаємо! Ваше фінансове здоров\'я прекрасне. Сподіваємося, ви продовжите свою успішну хвилю і будете навчатися разом з Monekin';
			case 'financial_health.review.descr.good': return 'Чудово! Ваше фінансове здоров\'я гарне. Відвідайте вкладку аналізу, щоб побачити, як зберегти ще більше!';
			case 'financial_health.review.descr.normal': return 'Ваше фінансове здоров\'я більш-менш в середньому залишку населення за цей період';
			case 'financial_health.review.descr.bad': return 'Схоже, що ваша фінансова ситуація ще не найкраща. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
			case 'financial_health.review.descr.very_bad': return 'Хмм, ваше фінансове здоров\'я далеко не відповідає тому, що воно повинно бути. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
			case 'financial_health.months_without_income.title': return 'Шанси на виживання';
			case 'financial_health.months_without_income.subtitle': return 'З урахуванням вашого балансу, час, на який ви можете обійтися без доходу';
			case 'financial_health.months_without_income.text_zero': return 'Ви не могли б прожити місяць без доходу з такою швидкістю витрат!';
			case 'financial_health.months_without_income.text_one': return 'Ви ледве могли б прожити близько місяця без доходу з такою швидкістю витрат!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'Ви могли б прожити приблизно <b>${n} місяців</b> без доходу з такою швидкістю витрат.';
			case 'financial_health.months_without_income.text_infinite': return 'Ви могли б прожити приблизно <b>майже все своє життя</b> без доходу з такою швидкістю витрат.';
			case 'financial_health.months_without_income.suggestion': return 'Пам\'ятайте, що рекомендується завжди тримати цей відсоток не менше 5 місяців. Якщо ви бачите, що у вас недостатньо збережень, зменште непотрібні витрати.';
			case 'financial_health.months_without_income.insufficient_data': return 'Схоже, у нас недостатньо витрат, щоб розрахувати, на скільки місяців ви можете вижити без доходу. Введіть кілька транзакцій і повертайтесь сюди, щоб перевірити ваше фінансове здоров\'я';
			case 'financial_health.savings_percentage.title': return 'Відсоток заощаджень';
			case 'financial_health.savings_percentage.subtitle': return 'Яка частина вашого доходу не витрачена за цей період';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Вітаємо! Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Схоже, ви вже професіонал, продовжуйте в тому ж дусі!';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Вітаємо, ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду.';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Проте ми вважаємо, що ви все ще можете зробити набагато більше!';
			case 'financial_health.savings_percentage.text.very_bad': return 'Вау, ви не змогли заощадити нічого протягом цього періоду.';
			case 'financial_health.savings_percentage.suggestion': return 'Пам\'ятайте, що рекомендується заощаджувати принаймні 15-20% від вашого доходу.';
			case 'stats.title': return 'Статистика';
			case 'stats.balance': return 'Баланс';
			case 'stats.final_balance': return 'Кінцевий баланс';
			case 'stats.balance_by_account': return 'Баланс за рахунками';
			case 'stats.balance_by_account_subtitle': return 'Де я маю більшість грошей?';
			case 'stats.balance_by_currency': return 'Баланс за валютою';
			case 'stats.balance_by_currency_subtitle': return 'Скільки я маю грошей в іноземній валюті?';
			case 'stats.balance_evolution': return 'Тенденція балансу';
			case 'stats.balance_evolution_subtitle': return 'У мене більше грошей, ніж раніше?';
			case 'stats.compared_to_previous_period': return 'Порівняно з попереднім періодом';
			case 'stats.cash_flow': return 'Грошовий потік';
			case 'stats.cash_flow_subtitle': return 'Я витрачаю менше, ніж заробляю?';
			case 'stats.by_periods': return 'За періодами';
			case 'stats.by_categories': return 'За категоріями';
			case 'stats.by_tags': return 'За тегами';
			case 'stats.distribution': return 'Розподіл';
			case 'stats.finance_health_resume': return 'Підсумок фінансового здоров\'я';
			case 'stats.finance_health_breakdown': return 'Детальний аналіз фінансового здоров\'я';
			case 'icon_selector.name': return 'Назва:';
			case 'icon_selector.icon': return 'Іконка';
			case 'icon_selector.color': return 'Колір';
			case 'icon_selector.select_color': return 'Виберіть колір';
			case 'icon_selector.custom_color': return 'Користувацький колір';
			case 'icon_selector.current_color_selection': return 'Поточний вибір';
			case 'icon_selector.select_icon': return 'Виберіть іконку';
			case 'icon_selector.select_account_icon': return 'Ідентифікуйте ваш рахунок';
			case 'icon_selector.select_category_icon': return 'Ідентифікуйте вашу категорію';
			case 'icon_selector.scopes.transport': return 'Транспорт';
			case 'icon_selector.scopes.money': return 'Гроші';
			case 'icon_selector.scopes.food': return 'Їжа';
			case 'icon_selector.scopes.medical': return 'Медицина';
			case 'icon_selector.scopes.entertainment': return 'Розваги';
			case 'icon_selector.scopes.technology': return 'Технології';
			case 'icon_selector.scopes.other': return 'Інше';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Фінансові установи';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Транзакція',
				other: 'Транзакції',
			);
			case 'transaction.create': return 'Нова транзакція';
			case 'transaction.new_income': return 'Новий дохід';
			case 'transaction.new_expense': return 'Новий витрати';
			case 'transaction.new_success': return 'Транзакція успішно створена';
			case 'transaction.edit': return 'Редагувати транзакцію';
			case 'transaction.edit_success': return 'Транзакція успішно відредагована';
			case 'transaction.edit_multiple': return 'редагувати транзакції';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} належним чином відредаговані транзакції';
			case 'transaction.duplicate': return 'Клонувати транзакцію';
			case 'transaction.duplicate_short': return 'Клон';
			case 'transaction.duplicate_warning_message': return 'Транзакція, ідентична цій, буде створена з такою ж датою. Бажаєте продовжити?';
			case 'transaction.duplicate_success': return 'Транзакція успішно склонована';
			case 'transaction.delete': return 'Видалити транзакцію';
			case 'transaction.delete_warning_message': return 'Ця дія незворотня. Поточний баланс ваших рахунків і всі ваші статистичні дані будуть перераховані';
			case 'transaction.delete_success': return 'Транзакцію успішно видалено';
			case 'transaction.delete_multiple': return 'Усунути транзакції';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'Ця дія незворотна і безумовно стерть ${x} транзакції. Поточний баланс ваших рахунків та вся ваша статистика будуть перенесені';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} належним чином усунути транзакції';
			case 'transaction.details': return 'Деталі руху коштів';
			case 'transaction.next_payments.accept': return 'Прийняти';
			case 'transaction.next_payments.skip': return 'Пропустити';
			case 'transaction.next_payments.skip_success': return 'Транзакцію успішно пропущено';
			case 'transaction.next_payments.skip_dialog_title': return 'Пропустити транзакцію';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'Ця дія незворотня. Ми перемістимо дату наступного переходу до ${date}';
			case 'transaction.next_payments.accept_today': return 'Прийняти сьогодні';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Прийняти в потрібну дату (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'Прийняти транзакцію';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'Новий статус транзакції буде нульовим. Ви можете знову редагувати статус цієї транзакції в будь-який момент';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'Ця дія створить нову транзакцію з датою ${date}. Ви зможете переглянути деталі цієї транзакції на сторінці транзакцій';
			case 'transaction.next_payments.recurrent_rule_finished': return 'Правило періодичності було завершено, більше немає платежів!';
			case 'transaction.list.empty': return 'Тут не знайдено жодних транзакцій для відображення. Додайте кілька транзакцій у додаток, і, можливо, наступного разу вам пощастить більше';
			case 'transaction.list.searcher_placeholder': return 'Шукати за категорією, описом...';
			case 'transaction.list.searcher_no_results': return 'Не знайдено транзакцій, що відповідають критеріям пошуку';
			case 'transaction.list.loading': return 'Завантаження додаткових транзакцій...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: '${n} вибрано',
				other: 'вибрано ${n}',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: '${n} вибрана транзакція',
				other: '${n} вибраних транзакцій',
			);
			case 'transaction.list.bulk_edit.dates': return 'Редагувати дати';
			case 'transaction.list.bulk_edit.categories': return 'Редагувати категорії';
			case 'transaction.list.bulk_edit.status': return 'Редагувати статуси';
			case 'transaction.filters.from_value': return 'Від суми';
			case 'transaction.filters.to_value': return 'До суми';
			case 'transaction.filters.from_value_def': return ({required Object x}) => 'Від ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => 'До ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => 'З ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => 'До ${date}';
			case 'transaction.form.validators.zero': return 'Значення транзакції не може бути рівним нулю';
			case 'transaction.form.validators.date_max': return 'Обрана дата після поточної. Транзакція буде додана як очікувана';
			case 'transaction.form.validators.date_after_account_creation': return 'Ви не можете створити транзакцію з датою до створення рахунку, до якого вона належить';
			case 'transaction.form.validators.negative_transfer': return 'Монетарна вартість переказу не може бути від\'ємною';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'Облікові записи джерела та призначення не збігаються';
			case 'transaction.form.title': return 'Назва транзакції';
			case 'transaction.form.title_short': return 'Назва';
			case 'transaction.form.value': return 'Сума транзакції';
			case 'transaction.form.tap_to_see_more': return 'Натисніть, щоб побачити більше деталей';
			case 'transaction.form.no_tags': return '-- Немає тегів --';
			case 'transaction.form.description': return 'Опис';
			case 'transaction.form.description_info': return 'Натисніть тут, щоб ввести детальніший опис цієї транзакції';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => 'Обмінний курс на ${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return 'На дату транзакції';
			case 'transaction.reversed.title': return 'Скасована транзакція';
			case 'transaction.reversed.title_short': return 'Перевернутий тр.';
			case 'transaction.reversed.description_for_expenses': return 'Незважаючи на те, що транзакція типу витрат, ця транзакція має додатну суму. Ці типи транзакцій можна використовувати для представлення повернення раніше зареєстрованих витрат, таких як відшкодування або оплата борг.';
			case 'transaction.reversed.description_for_incomes': return 'Незважаючи на те, що транзакція є дохідною, ця транзакція має від’ємну суму. Ці типи транзакцій можна використовувати ля анулювання або виправлення неправильно зареєстрованого доходу, для відображення повернення або відшкодування грошей або для обліку сплати боргів».';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Статус',
				other: 'Статуси',
			);
			case 'transaction.status.display_long': return 'Статус транзакції';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status} транзакція';
			case 'transaction.status.none': return 'Без статусу';
			case 'transaction.status.none_descr': return 'Транзакція без певного стану';
			case 'transaction.status.reconciled': return 'Узгоджений';
			case 'transaction.status.reconciled_descr': return 'Ця транзакція вже підтверджена і відповідає реальній транзакції з вашого банку';
			case 'transaction.status.unreconciled': return 'Не узгоджений';
			case 'transaction.status.unreconciled_descr': return 'Ця транзакція ще не підтверджена і тому ще не відображається у ваших реальних банківських рахунках. Однак вона враховується при розрахунку балансів і статистики в Monekin';
			case 'transaction.status.pending': return 'Очікується';
			case 'transaction.status.pending_descr': return 'Ця транзакція очікується і тому не буде враховуватися при розрахунку балансів і статистики';
			case 'transaction.status.voided': return 'Скасований';
			case 'transaction.status.voided_descr': return 'Скасована транзакція через помилку в платежі або будь-яку іншу причину. Вона не буде враховуватися при розрахунку балансів і статистики';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Тип транзакції',
				other: 'Типи транзакцій',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Дохід',
				other: 'Доходи',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Витрата',
				other: 'Витрати',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Переказ',
				other: 'Перекази',
			);
			case 'transfer.display': return 'Переказ';
			case 'transfer.transfers': return 'Перекази';
			case 'transfer.transfer_to': return ({required Object account}) => 'Переказ на ${account}';
			case 'transfer.create': return 'Новий переказ';
			case 'transfer.need_two_accounts_warning_header': return 'Увага!';
			case 'transfer.need_two_accounts_warning_message': return 'Для виконання цієї дії потрібно щонайменше два рахунки. Якщо вам потрібно відредагувати поточний баланс цього рахунку, натисніть кнопку редагування';
			case 'transfer.form.from': return 'Початковий рахунок';
			case 'transfer.form.to': return 'Цільовий рахунок';
			case 'transfer.form.value_in_destiny.title': return 'Сума переказу в пункті призначення';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} на цільовий рахунок';
			case 'recurrent_transactions.title': return 'Повторювані транзакції';
			case 'recurrent_transactions.title_short': return 'Повт. транзакції';
			case 'recurrent_transactions.empty': return 'Схоже, у вас немає жодних повторюваних транзакцій. Створіть щомісячну, щорічну або щотижневу повторювану транзакцію, і вона з\'явиться тут';
			case 'recurrent_transactions.total_expense_title': return 'Загальні витрати за період';
			case 'recurrent_transactions.total_expense_descr': return '* Без урахування початкової та кінцевої дати кожної повторюваної транзакції';
			case 'recurrent_transactions.details.title': return 'Повторювана транзакція';
			case 'recurrent_transactions.details.descr': return 'Наступні переміщення для цієї транзакції показані нижче. Ви можете прийняти перший рух або пропустити цей рух';
			case 'recurrent_transactions.details.last_payment_info': return 'Цей рух є останнім за повторюваною правилою, тому це правило буде автоматично видалено при підтвердженні цієї дії';
			case 'recurrent_transactions.details.delete_header': return 'Видалити повторювану транзакцію';
			case 'recurrent_transactions.details.delete_message': return 'Ця дія є незворотньою і не вплине на транзакції, які ви вже підтвердили/оплатили';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => 'Затримано на ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => 'Через ${x} днів';
			case 'account.details': return 'Деталі рахунку';
			case 'account.date': return 'Дата відкриття';
			case 'account.close_date': return 'Дата закриття';
			case 'account.reopen': return 'Повторно відкрити рахунок';
			case 'account.reopen_short': return 'Повторно відкрити';
			case 'account.reopen_descr': return 'Ви впевнені, що хочете повторно відкрити цей рахунок?';
			case 'account.balance': return 'Баланс рахунку';
			case 'account.n_transactions': return 'Кількість транзакцій';
			case 'account.add_money': return 'Додати кошти';
			case 'account.withdraw_money': return 'Зняти кошти';
			case 'account.no_accounts': return 'Тут не знайдено жодних транзакцій для відображення. Додайте транзакцію, натиснувши кнопку \'+\' внизу';
			case 'account.types.title': return 'Тип рахунку';
			case 'account.types.warning': return 'Після вибору типу рахунку його не можна буде змінити в майбутньому';
			case 'account.types.normal': return 'Звичайний рахунок';
			case 'account.types.normal_descr': return 'Використовується для фіксації вашої повсякденної фінансової діяльності. Це найбільш поширений рахунок, який дозволяє додавати витрати, доходи...';
			case 'account.types.saving': return 'Зберігаючий рахунок';
			case 'account.types.saving_descr': return 'З нього можна тільки додавати та знімати гроші з інших рахунків. Ідеально підходить для початку збереження грошей';
			case 'account.form.name': return 'Назва рахунку';
			case 'account.form.name_placeholder': return 'Наприклад: Зберігаючий рахунок';
			case 'account.form.notes': return 'Примітки';
			case 'account.form.notes_placeholder': return 'Введіть примітки/опис про цей рахунок';
			case 'account.form.initial_balance': return 'Початковий баланс';
			case 'account.form.current_balance': return 'Поточний баланс';
			case 'account.form.create': return 'Створити рахунок';
			case 'account.form.edit': return 'Редагувати рахунок';
			case 'account.form.currency_not_found_warn': return 'У вас немає інформації про обмінні курси для цієї валюти. За замовчуванням буде використано 1.0 як курс обміну. Ви можете змінити це в налаштуваннях';
			case 'account.form.already_exists': return 'Вже існує інший з такою самою назвою, будь ласка, введіть іншу';
			case 'account.form.tr_before_opening_date': return 'В цьому рахунку є транзакції з датою перед датою відкриття';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return 'Видалити рахунок?';
			case 'account.delete.warning_text': return 'Ця дія видалить цей рахунок і всі його транзакції';
			case 'account.delete.success': return 'Рахунок успішно видалено';
			case 'account.close.title': return 'Закрити рахунок';
			case 'account.close.title_short': return 'Закрити';
			case 'account.close.warn': return 'Цей рахунок більше не буде відображатися у певних списках, і ви не зможете створювати транзакції в ньому з датою пізніше, ніж вказана нижче. Ця дія не впливає на жодні транзакції або баланс, і ви також можете повторно відкрити цей рахунок у будь-який час. ';
			case 'account.close.should_have_zero_balance': return 'Баланс цього рахунку повинен бути 0, щоб його закрити. Будь ласка, відредагуйте рахунок перед продовженням';
			case 'account.close.should_have_no_transactions': return 'У цього рахунку є транзакції після вказаної дати закриття. Видаліть їх або відредагуйте дату закриття рахунку перед продовженням';
			case 'account.close.success': return 'Рахунок успішно закрито';
			case 'account.close.unarchive_succes': return 'Рахунок успішно повторно відкрито';
			case 'account.select.one': return 'Виберіть рахунок';
			case 'account.select.all': return 'Всі рахунки';
			case 'account.select.multiple': return 'Вибрати рахунки';
			case 'currencies.currency_converter': return 'Конвертер валют';
			case 'currencies.currency': return 'Валюта';
			case 'currencies.currency_manager': return 'Менеджер валют';
			case 'currencies.currency_manager_descr': return 'Налаштуйте вашу валюту та її обмінні курси з іншими';
			case 'currencies.preferred_currency': return 'Перевагова/базова валюта';
			case 'currencies.change_preferred_currency_title': return 'Змінити перевагову валюту';
			case 'currencies.change_preferred_currency_msg': return 'Усі статистичні дані та бюджети будуть відображатися в цій валюті відтепер. Рахунки та транзакції залишаться у тій валюті, яку вони мали. Усі збережені обмінні курси будуть видалені, якщо ви виконаєте цю дію. Ви хочете продовжити?';
			case 'currencies.form.equal_to_preferred_warn': return 'Валюта не може бути однаковою з валютою користувача';
			case 'currencies.form.specify_a_currency': return 'Будь ласка, вкажіть валюту';
			case 'currencies.form.add': return 'Додати обмінний курс';
			case 'currencies.form.add_success': return 'Обмінний курс успішно додано';
			case 'currencies.form.edit': return 'Редагувати обмінний курс';
			case 'currencies.form.edit_success': return 'Обмінний курс успішно відредаговано';
			case 'currencies.delete_all_success': return 'Обмінні курси успішно видалено';
			case 'currencies.historical': return 'Історичні курси';
			case 'currencies.exchange_rate': return 'Обмінний курс';
			case 'currencies.exchange_rates': return 'Обмінні курси';
			case 'currencies.empty': return 'Додайте тут обмінні курси, щоб, якщо у вас є рахунки в інших валютах, наші графіки були б точнішими';
			case 'currencies.select_a_currency': return 'Виберіть валюту';
			case 'currencies.search': return 'Пошук за назвою або кодом валюти';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Мітка',
				other: 'Теги',
			);
			case 'tags.form.name': return 'Назва тегу';
			case 'tags.form.description': return 'Опис';
			case 'tags.select.title': return 'Вибрати теги';
			case 'tags.select.all': return 'Усі теги';
			case 'tags.empty_list': return 'Ви ще не створили жодних тегів. Теги та категорії - це відмінний спосіб категоризувати ваші рухи';
			case 'tags.without_tags': return 'Без тегів';
			case 'tags.add': return 'Додати тег';
			case 'tags.create': return 'Створити мітку';
			case 'tags.create_success': return 'Мітка успішно створена';
			case 'tags.already_exists': return 'Ця назва тегу вже існує. Ви можете відредагувати її';
			case 'tags.edit': return 'Редагувати тег';
			case 'tags.edit_success': return 'Тег успішно відредаговано';
			case 'tags.delete_success': return 'Тег успішно видалено';
			case 'tags.delete_warning_header': return 'Видалити тег?';
			case 'tags.delete_warning_message': return 'Ця дія не призведе до видалення транзакцій, які мають цей тег.';
			case 'categories.unknown': return 'Невідома категорія';
			case 'categories.create': return 'Створити категорію';
			case 'categories.create_success': return 'Категорія успішно створена';
			case 'categories.new_category': return 'Нова категорія';
			case 'categories.already_exists': return 'Така назва категорії вже існує. Можливо, ви хочете відредагувати її';
			case 'categories.edit': return 'Редагувати категорію';
			case 'categories.edit_success': return 'Категорію успішно відредаговано';
			case 'categories.name': return 'Назва категорії';
			case 'categories.type': return 'Тип категорії';
			case 'categories.both_types': return 'Обидва типи';
			case 'categories.subcategories': return 'Підкатегорії';
			case 'categories.subcategories_add': return 'Додати підкатегорію';
			case 'categories.make_parent': return 'Зробити батьківською категорією';
			case 'categories.make_child': return 'Зробити підкатегорією';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'Ця категорія та її підкатегорії стануть підкатегоріями <b>${destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'Їх транзакції <b>(${x})</b> будуть перенесені до нових підкатегорій, створених всередині категорії <b>${destiny}</b>.';
			case 'categories.make_child_success': return 'Підкатегорії успішно створено';
			case 'categories.merge': return 'Об\'єднати з іншою категорією';
			case 'categories.merge_warning1': return ({required Object x, required Object from, required Object destiny}) => 'Всі транзакції (${x}), пов\'язані з категорією <b>${from}</b>, будуть перенесені до категорії <b>${destiny}</b>';
			case 'categories.merge_warning2': return ({required Object from}) => 'Категорія <b>${from}</b> буде безповоротно видалена.';
			case 'categories.merge_success': return 'Категорії успішно об\'єднані';
			case 'categories.delete_success': return 'Категорію видалено коректно';
			case 'categories.delete_warning_header': return 'Видалити категорію?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'Ця дія незворотно видалить всі транзакції <b>(${x})</b>, пов\'язані з цією категорією.';
			case 'categories.select.title': return 'Вибрати категорії';
			case 'categories.select.select_one': return 'Виберіть категорію';
			case 'categories.select.select_subcategory': return 'Оберіть підкатегорію';
			case 'categories.select.without_subcategory': return 'Без підкатегорії';
			case 'categories.select.all': return 'Усі категорії';
			case 'categories.select.all_short': return 'Усі';
			case 'budgets.title': return 'Бюджети';
			case 'budgets.repeated': return 'Повторювані';
			case 'budgets.one_time': return 'Одноразові';
			case 'budgets.annual': return 'Щорічні';
			case 'budgets.week': return 'Щотижневі';
			case 'budgets.month': return 'Щомісячні';
			case 'budgets.actives': return 'Активні';
			case 'budgets.pending': return 'Очікує початку';
			case 'budgets.finish': return 'Завершені';
			case 'budgets.from_budgeted': return 'з ';
			case 'budgets.days_left': return 'днів залишилось';
			case 'budgets.days_to_start': return 'днів до початку';
			case 'budgets.since_expiration': return 'днів після закінчення терміну';
			case 'budgets.no_budgets': return 'Здається, що в цьому розділі немає жодних бюджетів для відображення. Розпочніть з створення бюджету, натиснувши кнопку нижче';
			case 'budgets.delete': return 'Видалити бюджет';
			case 'budgets.delete_warning': return 'Ця дія незворотня. Категорії та транзакції, що стосуються цитати, не будуть видалені';
			case 'budgets.form.title': return 'Додати бюджет';
			case 'budgets.form.name': return 'Назва бюджету';
			case 'budgets.form.value': return 'Обмежена кількість';
			case 'budgets.form.create': return 'Додати бюджет';
			case 'budgets.form.edit': return 'Редагувати бюджет';
			case 'budgets.form.negative_warn': return 'Бюджети не можуть мати від\'ємну суму';
			case 'budgets.details.title': return 'Деталі бюджету';
			case 'budgets.details.statistics': return 'Статистика';
			case 'budgets.details.budget_value': return 'Заплановано';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => 'Ви можете витрачати ${dailyAmount} на день ще ${remainingDays} днів';
			case 'budgets.details.expend_evolution': return 'Еволюція витрат';
			case 'budgets.details.no_transactions': return 'Здається, ви не здійснили жодних витрат, пов\'язаних з цим бюджетом';
			case 'backup.export.title': return 'Експорт ваших даних';
			case 'backup.export.title_short': return 'Експорт';
			case 'backup.export.all': return 'Повне резервне копіювання';
			case 'backup.export.all_descr': return 'Експортувати всі ваші дані (рахунки, транзакції, бюджети, налаштування...). Імпортуйте їх знову у будь-який момент, щоб нічого не втратити.';
			case 'backup.export.transactions': return 'Резервне копіювання транзакцій';
			case 'backup.export.transactions_descr': return 'Експортуйте ваші транзакції у форматі CSV, щоб ви могли зручніше їх аналізувати в інших програмах або застосунках.';
			case 'backup.export.description': return 'Завантажте ваші дані у різних форматах';
			case 'backup.export.dialog_title': return 'Зберегти/Відправити файл';
			case 'backup.export.success': return ({required Object x}) => 'Файл успішно збережено/завантажено у ${x}';
			case 'backup.export.error': return 'Помилка при завантаженні файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
			case 'backup.import.title': return 'Імпорт ваших даних';
			case 'backup.import.title_short': return 'Імпорт';
			case 'backup.import.restore_backup': return 'Відновити резервну копію';
			case 'backup.import.restore_backup_descr': return 'Імпортуйте раніше збережену базу даних з Monekin. Ця дія замінить будь-які поточні дані програми новими даними';
			case 'backup.import.restore_backup_warn_description': return 'При імпорті нової бази даних ви втратите всі дані, які вже збережено в програмі. Рекомендується зробити резервну копію перед продовженням. Не завантажуйте сюди будь-який файл, походження якого ви не знаєте, завантажуйте лише файли, які ви раніше завантажили з Monekin';
			case 'backup.import.restore_backup_warn_title': return 'Перезаписати всі дані';
			case 'backup.import.select_other_file': return 'Вибрати інший файл';
			case 'backup.import.tap_to_select_file': return 'Торкніться, щоб вибрати файл';
			case 'backup.import.manual_import.title': return 'Ручний імпорт';
			case 'backup.import.manual_import.descr': return 'Імпортуйте транзакції з файлу .csv вручну';
			case 'backup.import.manual_import.default_account': return 'Типовий рахунок';
			case 'backup.import.manual_import.remove_default_account': return 'Видалити типовий рахунок';
			case 'backup.import.manual_import.default_category': return 'Типова категорія';
			case 'backup.import.manual_import.select_a_column': return 'Виберіть стовпець з файлу .csv';
			case 'backup.import.manual_import.steps.0': return 'Виберіть ваш файл';
			case 'backup.import.manual_import.steps.1': return 'Стовпець для суми';
			case 'backup.import.manual_import.steps.2': return 'Стовпець для рахунку';
			case 'backup.import.manual_import.steps.3': return 'Стовпець для категорії';
			case 'backup.import.manual_import.steps.4': return 'Стовпець для дати';
			case 'backup.import.manual_import.steps.5': return 'інші стовпці';
			case 'backup.import.manual_import.steps_descr.0': return 'Виберіть файл .csv з вашого пристрою. Переконайтеся, що в ньому є перший рядок, який описує назву кожного стовпця';
			case 'backup.import.manual_import.steps_descr.1': return 'Виберіть стовпець, де вказано значення кожної транзакції. Використовуйте від\'ємні значення для витрат та позитивні значення для доходів. Використовуйте крапку як десятковий роздільник';
			case 'backup.import.manual_import.steps_descr.2': return 'Виберіть стовпець, де вказано рахунок, до якого належить кожна транзакція. Ви також можете вибрати типовий рахунок у випадку, якщо ми не зможемо знайти рахунок, який вам потрібен. Якщо типовий рахунок не вказано, ми створимо його з такою самою назвою';
			case 'backup.import.manual_import.steps_descr.3': return 'Вкажіть стовпець, де знаходиться назва категорії транзакції. Ви повинні вказати типову категорію, щоб ми призначили цю категорію транзакціям, у випадку, якщо категорія не може бути знайдена';
			case 'backup.import.manual_import.steps_descr.4': return 'Виберіть стовпець, де вказано дату кожної транзакції. Якщо не вказано, транзакції будуть створені з поточною датою';
			case 'backup.import.manual_import.steps_descr.5': return 'Вкажіть стовпці для інших необов\'язкових атрибутів транзакцій';
			case 'backup.import.manual_import.success': return ({required Object x}) => 'Успішно імпортовано ${x} транзакцій';
			case 'backup.import.success': return 'Імпорт виконано успішно';
			case 'backup.import.cancelled': return 'Імпорт скасовано користувачем';
			case 'backup.import.error': return 'Помилка імпорту файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
			case 'backup.about.title': return 'Інформація про вашу базу даних';
			case 'backup.about.create_date': return 'Дата створення';
			case 'backup.about.modify_date': return 'Останнє змінено';
			case 'backup.about.last_backup': return 'Остання резервна копія';
			case 'backup.about.size': return 'Розмір';
			case 'settings.title_long': return 'Налаштування та вигляд';
			case 'settings.title_short': return 'Налаштування';
			case 'settings.description': return 'Тема додатку, тексти та інші загальні налаштування';
			case 'settings.edit_profile': return 'Редагувати профіль';
			case 'settings.lang_section': return 'Мова та тексти';
			case 'settings.lang_title': return 'Мова додатку';
			case 'settings.lang_descr': return 'Мова, в якій будуть відображатися тексти в додатку';
			case 'settings.lang_help': return 'Якщо ви хочете співпрацювати з перекладами цієї програми, ви можете звернутися до <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>нашого посібник</ a>';
			case 'settings.locale': return 'Регіон';
			case 'settings.locale_descr': return 'Встановіть формат, який буде використовуватися для дат, чисел...';
			case 'settings.locale_warn': return 'Після зміни регіону додаток оновиться';
			case 'settings.first_day_of_week': return 'Перший день тижня';
			case 'settings.theme_and_colors': return 'Тема та кольори';
			case 'settings.theme': return 'Тема';
			case 'settings.theme_auto': return 'Визначено системою';
			case 'settings.theme_light': return 'Світла';
			case 'settings.theme_dark': return 'Темна';
			case 'settings.amoled_mode': return 'Режим AMOLED';
			case 'settings.amoled_mode_descr': return 'Використовуйте чисто чорний шпалери, якщо це можливо. Це трохи допоможе акумулятору пристроїв з екранами AMOLED';
			case 'settings.dynamic_colors': return 'Динамічні кольори';
			case 'settings.dynamic_colors_descr': return 'Використовуйте колір акценту вашої системи, коли це можливо';
			case 'settings.accent_color': return 'Колір акценту';
			case 'settings.accent_color_descr': return 'Виберіть колір, який додаток буде використовувати для виділення певних частин інтерфейсу';
			case 'settings.security.title': return 'Безпека';
			case 'settings.security.private_mode_at_launch': return 'Приватний режим під час запуску';
			case 'settings.security.private_mode_at_launch_descr': return 'За замовчуванням запускати програму в приватному режимі';
			case 'settings.security.private_mode': return 'Приватний режим';
			case 'settings.security.private_mode_descr': return 'Приховати всі грошові значення';
			case 'settings.security.private_mode_activated': return 'Приватний режим активовано';
			case 'settings.security.private_mode_deactivated': return 'Приватний режим вимкнено';
			case 'more.title': return 'Більше';
			case 'more.title_long': return 'Більше дій';
			case 'more.data.display': return 'Дані';
			case 'more.data.display_descr': return 'Експортуйте та імпортуйте свої дані, щоб нічого не втратити';
			case 'more.data.delete_all': return 'Видалити мої дані';
			case 'more.data.delete_all_header1': return 'Зупиніться, молодий падаване ⚠️⚠️';
			case 'more.data.delete_all_message1': return 'Ви впевнені, що хочете продовжити? Всі ваші дані буде остаточно видалено і не може бути відновлено';
			case 'more.data.delete_all_header2': return 'Останній крок ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'Видаляючи обліковий запис, ви видалите всі ваші збережені особисті дані. Ваші облікові записи, транзакції, бюджети та категорії будуть видалені і не можуть бути відновлені. Ви згодні?';
			case 'more.about_us.display': return 'Інформація про додаток';
			case 'more.about_us.description': return 'Перегляньте умови та іншу важливу інформацію про Monekin. Зв\'яжіться зі спільнотою, повідомте про помилки, залиште пропозиції ...';
			case 'more.about_us.legal.display': return 'Юридична інформація';
			case 'more.about_us.legal.privacy': return 'Політика конфіденційності';
			case 'more.about_us.legal.terms': return 'Умови використання';
			case 'more.about_us.legal.licenses': return 'Ліцензії';
			case 'more.about_us.project.display': return 'Проект';
			case 'more.about_us.project.contributors': return 'Співробітники';
			case 'more.about_us.project.contributors_descr': return 'Усі розробники, які зробили Monekin краще';
			case 'more.about_us.project.contact': return 'Зв\'яжіться з нами';
			case 'more.help_us.display': return 'Допоможіть нам';
			case 'more.help_us.description': return 'Дізнайтеся, як ви можете допомогти Monekin ставати кращим і кращим';
			case 'more.help_us.rate_us': return 'Оцініть нас';
			case 'more.help_us.rate_us_descr': return 'Будь-яка оцінка вітається!';
			case 'more.help_us.share': return 'Поділіться Monekin';
			case 'more.help_us.share_descr': return 'Поділіться нашим додатком з друзями та родиною';
			case 'more.help_us.share_text': return 'Monekin! Найкращий додаток для особистих фінансів. Завантажте його тут';
			case 'more.help_us.thanks': return 'Дякуємо!';
			case 'more.help_us.thanks_long': return 'Ваші внески в Monekin та інші відкриті проекти, великі та малі, роблять великі проекти, подібні до цього, можливими. Дякуємо вам за час, витрачений на внесок.';
			case 'more.help_us.donate': return 'Зробіть пожертву';
			case 'more.help_us.donate_descr': return 'З вашою пожертвою ви допоможете додатку продовжувати отримувати вдосконалення. Що може бути краще, ніж подякувати за виконану роботу, запрошуючи мене на каву?';
			case 'more.help_us.donate_success': return 'Пожертва зроблена. Дуже вдячний за ваш внесок! ❤️';
			case 'more.help_us.donate_err': return 'Ой! Здається, виникла помилка при отриманні вашого платежу';
			case 'more.help_us.report': return 'Повідомити про помилки, залишити пропозиції...';
			default: return null;
		}
	}
}

extension on _TranslationsZhTw {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'general.cancel': return '取消';
			case 'general.or': return '或';
			case 'general.understood': return '明白了';
			case 'general.unspecified': return '未指定';
			case 'general.confirm': return '確認';
			case 'general.continue_text': return '繼續';
			case 'general.quick_actions': return '快速行動';
			case 'general.save': return '保存';
			case 'general.save_changes': return '儲存變更';
			case 'general.close_and_save': return '儲存並關閉';
			case 'general.add': return '添加';
			case 'general.edit': return '編輯';
			case 'general.balance': return '平衡';
			case 'general.delete': return '刪除';
			case 'general.account': return '帳戶';
			case 'general.accounts': return '帳戶';
			case 'general.categories': return '類別';
			case 'general.category': return '類別';
			case 'general.today': return '今天';
			case 'general.yesterday': return '昨天';
			case 'general.filters': return '過濾器';
			case 'general.see_more': return '查看更多';
			case 'general.select_all': return '全選';
			case 'general.deselect_all': return '取消全選';
			case 'general.empty_warn': return '哦！這裡非常空';
			case 'general.insufficient_data': return '數據不足';
			case 'general.show_more_fields': return '顯示更多欄位';
			case 'general.show_less_fields': return '顯示較少的欄位';
			case 'general.tap_to_search': return '點擊即可搜尋';
			case 'general.clipboard.success': return ({required Object x}) => '${x}已複製到剪貼簿';
			case 'general.clipboard.error': return '複製錯誤';
			case 'general.time.start_date': return '開始日期';
			case 'general.time.end_date': return '結束日期';
			case 'general.time.from_date': return '從日期';
			case 'general.time.until_date': return '截止日期';
			case 'general.time.date': return '日期';
			case 'general.time.datetime': return '約會時間';
			case 'general.time.time': return '時間';
			case 'general.time.each': return '每個';
			case 'general.time.after': return '後';
			case 'general.time.ranges.display': return '時間範圍';
			case 'general.time.ranges.it_repeat': return '重複';
			case 'general.time.ranges.it_ends': return '結束';
			case 'general.time.ranges.forever': return '永遠';
			case 'general.time.ranges.types.cycle': return '循環';
			case 'general.time.ranges.types.last_days': return '最後一天';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '前${x}天';
			case 'general.time.ranges.types.all': return '總是';
			case 'general.time.ranges.types.date_range': return '自訂範圍';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每個${range}',
				other: '每${n}${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}直到${day}',
				other: '每 ${n}${range}直到${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}${limit}次',
				other: '每${n}${range}${limit}次',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}一次',
				other: '每${n}${range}一次',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '月',
				other: '月',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '年',
				other: '年',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '天',
				other: '天',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '星期',
				other: '幾週',
			);
			case 'general.time.periodicity.display': return '週期性';
			case 'general.time.periodicity.no_repeat': return '不再重複';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '重複',
				other: '重複',
			);
			case 'general.time.periodicity.diary': return '日常的';
			case 'general.time.periodicity.monthly': return '每月';
			case 'general.time.periodicity.annually': return '每年';
			case 'general.time.periodicity.quaterly': return '季刊';
			case 'general.time.periodicity.weekly': return '每週';
			case 'general.time.periodicity.custom': return '風俗';
			case 'general.time.periodicity.infinite': return '總是';
			case 'general.time.current.monthly': return '這個月';
			case 'general.time.current.annually': return '今年';
			case 'general.time.current.quaterly': return '本季';
			case 'general.time.current.weekly': return '本星期';
			case 'general.time.current.infinite': return '永遠';
			case 'general.time.current.custom': return '自訂範圍';
			case 'general.time.all.diary': return '每天';
			case 'general.time.all.monthly': return '每月';
			case 'general.time.all.annually': return '每年';
			case 'general.time.all.quaterly': return '每季';
			case 'general.time.all.weekly': return '每週';
			case 'general.transaction_order.display': return '訂單交易';
			case 'general.transaction_order.category': return '按類別';
			case 'general.transaction_order.quantity': return '按數量';
			case 'general.transaction_order.date': return '按日期';
			case 'general.validations.form_error': return '修正表單中指示的欄位以繼續';
			case 'general.validations.required': return '必填項目';
			case 'general.validations.positive': return '應該是積極的';
			case 'general.validations.min_number': return ({required Object x}) => '應該大於${x}';
			case 'general.validations.max_number': return ({required Object x}) => '應小於${x}';
			case 'intro.start': return '開始';
			case 'intro.skip': return '跳過';
			case 'intro.next': return '下一個';
			case 'intro.select_your_currency': return '選擇您的貨幣';
			case 'intro.welcome_subtitle': return '您的個人財務管家';
			case 'intro.welcome_subtitle2': return '100% 開放，100% 免費';
			case 'intro.welcome_footer': return '登入即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隱私權政策</a>和<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>應用程式的使用條款</a>';
			case 'intro.offline_descr_title': return '離線帳戶：';
			case 'intro.offline_descr': return '您的資料只會儲存在您的裝置上，只要您不卸載應用程式或更換手機，資料就安全。為防止資料遺失，建議定期從應用程式設定中進行備份。';
			case 'intro.offline_start': return '離線啟動會話';
			case 'intro.sl1_title': return '選擇您的貨幣';
			case 'intro.sl1_descr': return '您的預設貨幣將用於報告和一般圖表。您以後可以隨時在應用程式設定中更改貨幣和應用程式語言';
			case 'intro.sl2_title': return '安全、隱私、可靠';
			case 'intro.sl2_descr': return '您的資料只屬於您。我們將資訊直接儲存在您的設備上，無需通過外部伺服器。這使得即使沒有互聯網也可以使用該應用程式';
			case 'intro.sl2_descr2': return '此外，該應用程式的源代碼是公開的，任何人都可以對其進行協作並查看它是如何工作的';
			case 'intro.last_slide_title': return '一切準備就緒';
			case 'intro.last_slide_descr': return '有了 Monekin，您終於可以實現您想要的財務獨立。您將擁有圖表、預算、提示、統計數據以及更多有關您的資金的信息。';
			case 'intro.last_slide_descr2': return '我們希望您享受這次體驗！如有疑問、建議，請隨時與我們聯繫......';
			case 'home.title': return '儀表板';
			case 'home.filter_transactions': return '過濾交易';
			case 'home.hello_day': return '早安，';
			case 'home.hello_night': return '晚安，';
			case 'home.total_balance': return '總餘額';
			case 'home.my_accounts': return '我的帳戶';
			case 'home.active_accounts': return '活躍帳戶';
			case 'home.no_accounts': return '尚未建立帳戶';
			case 'home.no_accounts_descr': return '開始使用 Monekin 的所有魔力。創建至少一個帳戶以開始添加交易';
			case 'home.last_transactions': return '最後的交易';
			case 'home.should_create_account_header': return '哎呀！';
			case 'home.should_create_account_message': return '您必須至少擁有一個非存檔帳戶才能開始創建交易';
			case 'financial_health.display': return '財務健康';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '很好！';
					case GenderContext.female:
						return '很好！';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '好';
					case GenderContext.female:
						return '好';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '平均';
					case GenderContext.female:
						return '平均';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '一般';
					case GenderContext.female:
						return '一般';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '非常糟糕';
					case GenderContext.female:
						return '非常糟糕';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '數據不足';
					case GenderContext.female:
						return '數據不足';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return '看起來我們沒有足夠的收入來計算您的財務健康狀況。添加這段時間的一些收入/收入，以便我們能夠幫助您！';
			case 'financial_health.review.descr.very_good': return '恭喜！您的財務狀況非常好。我們希望您繼續保持良好的勢頭，並繼續與 Monekin 一起學習';
			case 'financial_health.review.descr.good': return '太棒了！您的財務狀況良好。請訪問分析選項卡，了解如何節省更多！';
			case 'financial_health.review.descr.normal': return '您的財務健康狀況或多或少處於這一時期其他人口的平均水平';
			case 'financial_health.review.descr.bad': return '看來您的財務狀況還不是最好的。探索其餘圖表以了解更多有關您財務狀況的信息';
			case 'financial_health.review.descr.very_bad': return '嗯，您的財務健康狀況遠低於應有的水平。探索其餘圖表以了解有關您財務狀況的更多信息';
			case 'financial_health.months_without_income.title': return '存活率';
			case 'financial_health.months_without_income.subtitle': return '考慮到您的餘額，您可以在沒有收入的情況下度過多長時間';
			case 'financial_health.months_without_income.text_zero': return '按照這樣的開支，沒有收入你一個月都活不下去！';
			case 'financial_health.months_without_income.text_one': return '按照這樣的收入，如果沒有收入，你幾乎無法生存大約一個月！';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => '以這樣的支出速度，如果沒有收入，您大約可以生存 <b>${n}個月</b>。';
			case 'financial_health.months_without_income.text_infinite': return '以這樣的支出速度，如果沒有收入，您大約可以<b>一生</b>生存。';
			case 'financial_health.months_without_income.suggestion': return '請記住，建議始終將此比率保持在至少 5 個月以上。如果您發現自己沒有足夠的儲蓄緩衝，請減少不必要的開支。';
			case 'financial_health.months_without_income.insufficient_data': return '看來我們沒有足夠的開支來計算您在沒有收入的情況下可以生存多少個月。輸入幾筆交易，然後回到這裡檢查您的財務狀況';
			case 'financial_health.savings_percentage.title': return '儲蓄百分比';
			case 'financial_health.savings_percentage.subtitle': return '你的收入中有哪一部分沒有在這段時間花掉';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => '恭喜您！您在這段時間裡成功節省了收入的<b>${value}%</b>。看來您已經是專家了，繼續努力吧！';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => '恭喜您，在此期間您已成功節省收入的 <b>${value}%</b>。';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => '在此期間，您已成功節省了收入的 <b>${value}%</b>。但是，我們認為您還可以做得更多！';
			case 'financial_health.savings_percentage.text.very_bad': return '哇哦，這段時間你什麼都沒保存下來。';
			case 'financial_health.savings_percentage.suggestion': return '請記住，建議將收入的至少 15-20% 存起來。';
			case 'stats.title': return '統計數據';
			case 'stats.balance': return '平衡';
			case 'stats.final_balance': return '最終餘額';
			case 'stats.balance_by_account': return '帳戶餘額';
			case 'stats.balance_by_account_subtitle': return '我的大部分錢都在哪裡？';
			case 'stats.balance_by_currency': return '按貨幣餘额';
			case 'stats.balance_by_currency_subtitle': return '我有多少錢的外幣？';
			case 'stats.balance_evolution': return '平衡趨勢';
			case 'stats.balance_evolution_subtitle': return '我的錢比以前多了嗎？';
			case 'stats.compared_to_previous_period': return '與上一时期相比';
			case 'stats.cash_flow': return '現金流';
			case 'stats.cash_flow_subtitle': return '我的支出是否少于我的收入？';
			case 'stats.by_periods': return '按時期';
			case 'stats.by_categories': return '按類別';
			case 'stats.by_tags': return '按標籤';
			case 'stats.distribution': return '分配';
			case 'stats.finance_health_resume': return '恢復';
			case 'stats.finance_health_breakdown': return '分解';
			case 'icon_selector.name': return '姓名：';
			case 'icon_selector.icon': return '圖示';
			case 'icon_selector.color': return '顏色';
			case 'icon_selector.select_icon': return '選擇一個圖示';
			case 'icon_selector.select_color': return '選擇一種顏色';
			case 'icon_selector.current_color_selection': return '目前選擇';
			case 'icon_selector.custom_color': return '自訂顏色';
			case 'icon_selector.select_account_icon': return '識別您的帳戶';
			case 'icon_selector.select_category_icon': return '確定您的類別';
			case 'icon_selector.scopes.transport': return '運輸';
			case 'icon_selector.scopes.money': return '錢';
			case 'icon_selector.scopes.food': return '食物';
			case 'icon_selector.scopes.medical': return '健康';
			case 'icon_selector.scopes.entertainment': return '閒暇';
			case 'icon_selector.scopes.technology': return '技術';
			case 'icon_selector.scopes.other': return '其他的';
			case 'icon_selector.scopes.logos_financial_institutions': return '金融機構';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易',
				other: '交易',
			);
			case 'transaction.create': return '新交易';
			case 'transaction.new_income': return '新收入';
			case 'transaction.new_expense': return '新開支';
			case 'transaction.new_success': return '交易創造成功';
			case 'transaction.edit': return '編輯交易';
			case 'transaction.edit_success': return '交易編輯成功';
			case 'transaction.edit_multiple': return '編輯交易';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x}筆交易已成功編輯';
			case 'transaction.duplicate': return '複製交易';
			case 'transaction.duplicate_short': return '複製';
			case 'transaction.duplicate_warning_message': return '將在同一日期創建與此相同的交易，您想繼續嗎？';
			case 'transaction.duplicate_success': return '交易複製成功';
			case 'transaction.delete': return '刪除交易';
			case 'transaction.delete_warning_message': return '此操作不可逆轉。您的帳戶當前餘額和所有統計資料都將重新計算';
			case 'transaction.delete_success': return '交易已正確刪除';
			case 'transaction.delete_multiple': return '刪除交易';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => '此操作不可逆轉，將刪除${x}筆交易。您帳戶的當前餘額和所有統計資料都將重新計算';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '正確刪除了${x}筆交易';
			case 'transaction.details': return '動作詳情';
			case 'transaction.next_payments.accept': return '接受';
			case 'transaction.next_payments.skip': return '跳過';
			case 'transaction.next_payments.skip_success': return '成功跳過交易';
			case 'transaction.next_payments.skip_dialog_title': return '跳過交易';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => '此操作不可逆轉。我們會將下次移動的日期移至${date}';
			case 'transaction.next_payments.accept_today': return '今天接受';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => '在要求的日期 (${date}) 接受';
			case 'transaction.next_payments.accept_dialog_title': return '接受交易';
			case 'transaction.next_payments.accept_dialog_msg_single': return '該交易的新狀態將為空。您可以隨時重新編輯該交易的狀態';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => '此操作將建立日期為${date}的新交易。您將能夠在交易頁面上查看此交易的詳細資訊';
			case 'transaction.next_payments.recurrent_rule_finished': return '循環規則已完成，無需再支付！';
			case 'transaction.list.empty': return '未發現此處顯示的交易。在應用程式中添加一些交易，也許您下次會有更好的運氣';
			case 'transaction.list.searcher_placeholder': return '按類別、描述搜尋...';
			case 'transaction.list.searcher_no_results': return '未找到符合搜尋條件的交易';
			case 'transaction.list.loading': return '正在加載更多交易...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '${n} 已選取',
				other: '${n} 已選取',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '已選擇 ${n} 筆交易',
				other: '選擇 ${n} 筆交易',
			);
			case 'transaction.list.bulk_edit.dates': return '編輯日期';
			case 'transaction.list.bulk_edit.categories': return '編輯類別';
			case 'transaction.list.bulk_edit.status': return '編輯狀態';
			case 'transaction.filters.from_value': return '從金額';
			case 'transaction.filters.to_value': return '最多金額';
			case 'transaction.filters.from_value_def': return ({required Object x}) => '來自 ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => '最多 ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => '從${date}開始';
			case 'transaction.filters.to_date_def': return ({required Object date}) => '截至 ${date}';
			case 'transaction.form.validators.zero': return '一筆交易的價值不能等於零';
			case 'transaction.form.validators.date_max': return '所選日期晚於當前日期。交易將新增為待處理';
			case 'transaction.form.validators.date_after_account_creation': return '您無法建立日期早於所屬帳戶建立日期的交易';
			case 'transaction.form.validators.negative_transfer': return '轉帳的貨幣價值不能為負數';
			case 'transaction.form.validators.transfer_between_same_accounts': return '來源帳號與目標帳號不能符合';
			case 'transaction.form.title': return '交易標題';
			case 'transaction.form.title_short': return '資質';
			case 'transaction.form.value': return '交易價值';
			case 'transaction.form.tap_to_see_more': return '點擊查看更多詳細資訊';
			case 'transaction.form.no_tags': return '-- 無標籤 --';
			case 'transaction.form.description': return '描述';
			case 'transaction.form.description_info': return '點擊此處輸入有關此交易的更詳細描述';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => '匯率為${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return '交易日';
			case 'transaction.reversed.title': return '逆向交易';
			case 'transaction.reversed.title_short': return '逆向交易';
			case 'transaction.reversed.description_for_expenses': return '儘管是收入交易，但它的金額為正數。這些類型的交易可用於表示先前記錄的收入的返還，例如退款或償還債務。';
			case 'transaction.reversed.description_for_incomes': return '儘管是一項收入交易，但其金額為負數。這些類型的交易可用於作廢或更正錯誤記錄的收入，反映資金的返還或退款或記錄債務的支付。';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '地位',
				other: '狀態',
			);
			case 'transaction.status.display_long': return '交易狀態';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status}交易';
			case 'transaction.status.none': return '無國籍';
			case 'transaction.status.none_descr': return '沒有特定狀態的交易';
			case 'transaction.status.reconciled': return '和好了';
			case 'transaction.status.reconciled_descr': return '此交易已經過驗證，並且與您銀行的真實交易相對應';
			case 'transaction.status.unreconciled': return '不甘心';
			case 'transaction.status.unreconciled_descr': return '此交易尚未經過驗證，因此尚未出現在您的真實銀行帳戶中。但是，它將計算 Monekin 中的餘額和統計數據';
			case 'transaction.status.pending': return '待辦的';
			case 'transaction.status.pending_descr': return '此交易正在等待處理，因此在計算餘額和統計數據時不會考慮它';
			case 'transaction.status.voided': return '作廢';
			case 'transaction.status.voided_descr': return '由於付款錯誤或任何其他原因導致的交易無效/取消。在計算餘額和統計時不會考慮該交易';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易類型',
				other: '交易類型',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '收入',
				other: '收入',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '支出',
				other: '支出',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '轉移',
				other: '轉移',
			);
			case 'transfer.display': return '轉移';
			case 'transfer.transfers': return '轉移';
			case 'transfer.transfer_to': return ({required Object account}) => '轉移至${account}';
			case 'transfer.create': return '轉移';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return '至少需要兩個帳戶才能執行此操作。如果您需要調整或編輯該帳戶的當前餘額，請點擊編輯按鈕';
			case 'transfer.form.from': return '原始帳戶';
			case 'transfer.form.to': return '目的地帳戶';
			case 'transfer.form.value_in_destiny.title': return '目的地轉帳金额';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount}至目標帳户';
			case 'recurrent_transactions.title': return '經常交易';
			case 'recurrent_transactions.title_short': return '經常交易';
			case 'recurrent_transactions.empty': return '您似乎沒有任何經常交易。創建每月、每年或每週的經常交易，它將顯示在此處';
			case 'recurrent_transactions.total_expense_title': return '每個期間的總收入';
			case 'recurrent_transactions.total_expense_descr': return '*不考慮每次重複的開始和結束日期';
			case 'recurrent_transactions.details.title': return '經常交易';
			case 'recurrent_transactions.details.descr': return '此交易的下一步動作如下所示。您可以接受第一步動作或跳過此動作';
			case 'recurrent_transactions.details.last_payment_info': return '此動作是循環規則的最後一個，因此當確認此動作時，該規則將自動刪除';
			case 'recurrent_transactions.details.delete_header': return '刪除重複交易';
			case 'recurrent_transactions.details.delete_message': return '此操作不可逆轉，不會影響您已確認/付款的交易';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => '延遲了 ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => '${x} 天後';
			case 'account.details': return '帳戶詳細資料';
			case 'account.date': return '開業日期';
			case 'account.close_date': return '截止日期';
			case 'account.reopen': return '重新開立帳戶';
			case 'account.reopen_short': return '重新開放';
			case 'account.reopen_descr': return '您確定要重新開啟此帳戶嗎？';
			case 'account.balance': return '帳戶餘額';
			case 'account.n_transactions': return '交易數量';
			case 'account.add_money': return '增加金額';
			case 'account.withdraw_money': return '取出金額';
			case 'account.no_accounts': return '未發現此處顯示的交易。請點選底部的 \'+\' 按鈕新增交易';
			case 'account.types.title': return '帳戶類型';
			case 'account.types.warning': return '帳戶類型一旦選擇，以後將無法更改';
			case 'account.types.normal': return '普通帳戶';
			case 'account.types.normal_descr': return '對於記錄您的日常財務很有用。這是最常見的帳戶，它可以讓您添加支出、收入......';
			case 'account.types.saving': return '儲蓄帳戶';
			case 'account.types.saving_descr': return '您只能從其他帳戶中添加和提取資金。非常適合開始存錢';
			case 'account.form.name': return '帳戶名稱';
			case 'account.form.name_placeholder': return '例如：儲蓄帳戶';
			case 'account.form.notes': return '筆記';
			case 'account.form.notes_placeholder': return '輸入有關此帳戶的一些註釋/描述';
			case 'account.form.initial_balance': return '初始餘額';
			case 'account.form.current_balance': return '當前餘額';
			case 'account.form.create': return '創建帳戶';
			case 'account.form.edit': return '編輯帳戶';
			case 'account.form.currency_not_found_warn': return '您沒有該貨幣的匯率資訊。1.0 將用作預設匯率。您可以在設定中修改';
			case 'account.form.already_exists': return '已經有另一個同名，請再寫一個';
			case 'account.form.tr_before_opening_date': return '該帳戶中有日期早於開戶日期的交易';
			case 'account.form.iban': return 'iban';
			case 'account.form.swift': return 'swift';
			case 'account.delete.warning_header': return '刪除帳戶？';
			case 'account.delete.warning_text': return '此操作將刪除該帳戶及其所有交易';
			case 'account.delete.success': return '帳號刪除成功';
			case 'account.close.title': return '關閉帳戶';
			case 'account.close.title_short': return '關閉';
			case 'account.close.warn': return '此帳戶將不再出現在某些清單中，您將無法在其中建立日期晚於下面指定的日期的交易。此操作不會影響任何交易或餘額，您也可以隨時重新開啟此帳戶時間。 ';
			case 'account.close.should_have_zero_balance': return '此帳戶中的當前餘額必須為 0 才能關閉它。請在繼續之前編輯帳戶';
			case 'account.close.should_have_no_transactions': return '此帳戶在指定的關閉日期之後有交易。請刪除它們或編輯帳戶關閉日期，然後再繼續';
			case 'account.close.success': return '帳戶關閉成功';
			case 'account.close.unarchive_succes': return '帳戶已成功重新開設';
			case 'account.select.one': return '選擇一個帳戶';
			case 'account.select.all': return '所有帳戶';
			case 'account.select.multiple': return '選擇帳戶';
			case 'currencies.currency_converter': return '貨幣換算';
			case 'currencies.currency': return '貨幣';
			case 'currencies.currency_manager': return '貨幣管理';
			case 'currencies.currency_manager_descr': return '配置您的貨幣及其與其他貨幣的匯率';
			case 'currencies.preferred_currency': return '首選/基礎貨幣';
			case 'currencies.change_preferred_currency_title': return '更改首選貨幣';
			case 'currencies.change_preferred_currency_msg': return '從現在開始，所有統計數據和預算都將以該貨幣顯示。帳戶和交易將保留其所擁有的貨幣。如果您執行此操作，所有保存的匯率都將被刪除。您想繼續嗎？';
			case 'currencies.form.equal_to_preferred_warn': return '幣種不能等於用戶幣種';
			case 'currencies.form.specify_a_currency': return '請指定貨幣';
			case 'currencies.form.add': return '添加匯率';
			case 'currencies.form.add_success': return '匯率新增成功';
			case 'currencies.form.edit': return '編輯匯率';
			case 'currencies.form.edit_success': return '匯率編輯成功';
			case 'currencies.delete_all_success': return '刪除匯率成功';
			case 'currencies.historical': return '歷史利率';
			case 'currencies.exchange_rate': return '匯率';
			case 'currencies.exchange_rates': return '匯率';
			case 'currencies.empty': return '在此處添加匯率，以便如果您的帳戶使用基礎貨幣以外的貨幣，我們的圖表會更加準確';
			case 'currencies.select_a_currency': return '選擇貨幣';
			case 'currencies.search': return '按名稱或貨幣代碼搜尋';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '標籤',
				other: '標籤',
			);
			case 'tags.form.name': return '標籤名';
			case 'tags.form.description': return '描述';
			case 'tags.select.title': return '選擇標籤';
			case 'tags.select.all': return '所有標籤';
			case 'tags.empty_list': return '您還沒有創建任何標籤。標籤和類別是對您的動作進行分類的好方法';
			case 'tags.without_tags': return '沒有標籤';
			case 'tags.add': return '添加標籤';
			case 'tags.create': return '建立標籤';
			case 'tags.create_success': return '標籤創建成功';
			case 'tags.already_exists': return '此標籤名稱已存在。您可能需要編輯它';
			case 'tags.edit': return '編輯標籤';
			case 'tags.edit_success': return '標籤編輯成功';
			case 'tags.delete_success': return '類別刪除成功';
			case 'tags.delete_warning_header': return '刪除標籤？';
			case 'tags.delete_warning_message': return '此操作不會刪除具有此標籤的交易。';
			case 'categories.unknown': return '未知類別';
			case 'categories.create': return '創建類別';
			case 'categories.create_success': return '類別創建正確';
			case 'categories.new_category': return '新類別';
			case 'categories.already_exists': return '該類別的名稱已存在。也許您可以編輯';
			case 'categories.edit': return '編輯類別';
			case 'categories.edit_success': return '類別編輯正確';
			case 'categories.name': return '分類名稱';
			case 'categories.type': return '類別類型';
			case 'categories.both_types': return '兩種類型';
			case 'categories.subcategories': return '子類別';
			case 'categories.subcategories_add': return '新增子類別';
			case 'categories.make_parent': return '按類別製作';
			case 'categories.make_child': return '建立一個子類別';
			case 'categories.make_child_warning1': return ({required Object destiny}) => '此類別及其子類別將成為<b>${destiny}</b>的子類別。';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => '他們的交易<b>(${x})</b>將被移至<b>${destiny}</b>類別中創建的新子類別。';
			case 'categories.make_child_success': return '子類別創建成功';
			case 'categories.merge': return '與另一個類別合併';
			case 'categories.merge_warning1': return ({required Object from, required Object x, required Object destiny}) => '與類別<b>${from}</b>相關的所有交易 (${x}) 將移至類別<b>${destiny}</b>';
			case 'categories.merge_warning2': return ({required Object from}) => '類別<b>${from}</b>將被不可逆轉地刪除。 ';
			case 'categories.merge_success': return '類別合併成功';
			case 'categories.delete_success': return '類別已正確刪除';
			case 'categories.delete_warning_header': return '刪除類別？';
			case 'categories.delete_warning_message': return ({required Object x}) => '此操作將不可逆轉地刪除與此類別相關的所有交易<b>(${x})</b>。';
			case 'categories.select.title': return '選擇類別';
			case 'categories.select.select_one': return '選擇一個類別';
			case 'categories.select.select_subcategory': return '選擇一個子類別';
			case 'categories.select.without_subcategory': return '沒有子類別';
			case 'categories.select.all': return '所有類別';
			case 'categories.select.all_short': return '全部';
			case 'budgets.title': return '預算';
			case 'budgets.repeated': return '重複';
			case 'budgets.one_time': return '一次';
			case 'budgets.annual': return '年度';
			case 'budgets.week': return '每週';
			case 'budgets.month': return '每月';
			case 'budgets.actives': return '活躍';
			case 'budgets.pending': return '等待開始';
			case 'budgets.finish': return '完成的';
			case 'budgets.from_budgeted': return '從預算';
			case 'budgets.days_left': return '還剩幾天';
			case 'budgets.days_to_start': return '開始的日子';
			case 'budgets.since_expiration': return '自到期日起的天數';
			case 'budgets.no_budgets': return '此部分中似乎沒有可顯示的預算。首先單擊下面的按鈕以建立預算';
			case 'budgets.delete': return '刪除預算';
			case 'budgets.delete_warning': return '此操作不可逆轉。引用此報價的類別和交易不會被刪除';
			case 'budgets.form.title': return '添加預算';
			case 'budgets.form.name': return '預算名稱';
			case 'budgets.form.value': return '數量限制';
			case 'budgets.form.create': return '添加預算';
			case 'budgets.form.edit': return '編輯預算';
			case 'budgets.form.negative_warn': return '預算不能有負數';
			case 'budgets.details.title': return '預算詳情';
			case 'budgets.details.statistics': return '統計數據';
			case 'budgets.details.budget_value': return '預算';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => '您每天可以花費${dailyAmount}/天，持續${remainingDays}天';
			case 'budgets.details.expend_evolution': return '支出變化';
			case 'budgets.details.no_transactions': return '看來您還沒有做出與此預算相關的任何收入';
			case 'backup.export.title': return '匯出您的資料';
			case 'backup.export.title_short': return '匯出';
			case 'backup.export.all': return '完整備份';
			case 'backup.export.all_descr': return '匯出您的所有資料（帳戶、交易、預算、設定...）。隨時重新匯入它們，這樣您就不會丟失任何內容。';
			case 'backup.export.transactions': return '交易備份';
			case 'backup.export.transactions_descr': return '以 CSV 格式匯出您的交易，以便您可以在其他程式或應用程式中更輕鬆地分析它們。';
			case 'backup.export.description': return '以不同格式下載資料';
			case 'backup.export.dialog_title': return '儲存/傳送文件';
			case 'backup.export.success': return ({required Object x}) => '檔案已在${x}中成功儲存/下載';
			case 'backup.export.error': return '下載檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員';
			case 'backup.import.title': return '匯入您的資料';
			case 'backup.import.title_short': return '匯入';
			case 'backup.import.restore_backup': return '恢復備份';
			case 'backup.import.restore_backup_descr': return '從 Monekin 匯入先前儲存的資料庫。此操作將用新資料取代任何當前應用程式資料';
			case 'backup.import.restore_backup_warn_description': return '導入新資料庫時，您將丟失應用程式中當前保存的所有資料。建議在繼續之前進行備份。請勿在此處上傳任何來源不明的文件，僅上傳您之前從其下載的文件 Monekin';
			case 'backup.import.restore_backup_warn_title': return '覆蓋所有數據';
			case 'backup.import.select_other_file': return '選擇其他文件';
			case 'backup.import.tap_to_select_file': return '點選選擇檔案';
			case 'backup.import.manual_import.title': return '手動導入';
			case 'backup.import.manual_import.descr': return '手動從 .csv 檔案匯入交易';
			case 'backup.import.manual_import.default_account': return '預設帳戶';
			case 'backup.import.manual_import.remove_default_account': return '刪除預設帳戶';
			case 'backup.import.manual_import.default_category': return '預設類別';
			case 'backup.import.manual_import.select_a_column': return '從 .csv 中選擇一列';
			case 'backup.import.manual_import.steps.0': return '選擇您的文件';
			case 'backup.import.manual_import.steps.1': return '數量欄位';
			case 'backup.import.manual_import.steps.2': return '帳戶欄位';
			case 'backup.import.manual_import.steps.3': return '類別欄位';
			case 'backup.import.manual_import.steps.4': return '日期欄位';
			case 'backup.import.manual_import.steps.5': return '其他欄位';
			case 'backup.import.manual_import.steps_descr.0': return '從您的裝置中選擇一個 .csv 檔案。確保它的第一行描述了每列的名稱。';
			case 'backup.import.manual_import.steps_descr.1': return '選擇每筆交易價值的欄位。使用負值表示支出，使用正值表示收入。使用點作為小數點分隔符號。';
			case 'backup.import.manual_import.steps_descr.2': return '選擇每筆交易所屬帳戶的列。您也可以選擇預設帳戶，以防我們找不到您想要的帳戶。如果未指定預設帳戶，我們將建立一個同名帳戶。';
			case 'backup.import.manual_import.steps_descr.3': return '選擇交易類別名稱所在的欄位。您必須指定一個預設類別，以便我們將此類別指派給交易，以防找不到該類別。';
			case 'backup.import.manual_import.steps_descr.4': return '選擇每筆交易日期的欄位。如果未指定，交易將使用當前日期建立。';
			case 'backup.import.manual_import.steps_descr.5': return '選擇其他交易屬性的資料列';
			case 'backup.import.manual_import.success': return ({required Object x}) => '已成功導入${x}筆交易';
			case 'backup.import.success': return '導入成功';
			case 'backup.import.cancelled': return '導入已被用戶取消';
			case 'backup.import.error': return '匯入檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員。';
			case 'backup.about.title': return '有關您的資料庫的資訊';
			case 'backup.about.create_date': return '創建日期';
			case 'backup.about.modify_date': return '上一次更改';
			case 'backup.about.last_backup': return '上次備份';
			case 'backup.about.size': return '檔案大小';
			case 'settings.title_long': return '設定和外觀';
			case 'settings.title_short': return '設定';
			case 'settings.description': return '應用程式主題、文字和其他常規設定';
			case 'settings.edit_profile': return '編輯個人資料';
			case 'settings.lang_section': return '語言和文本';
			case 'settings.lang_title': return '應用程式語言';
			case 'settings.lang_descr': return '應用程式中顯示文字的語言';
			case 'settings.lang_help': return '如果您想與此應用程式的翻譯合作，您可以參考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我們的指南</a>';
			case 'settings.locale': return '地區';
			case 'settings.locale_descr': return '設定用於日期、數字的格式...';
			case 'settings.locale_warn': return '更改區域時應用程式將更新';
			case 'settings.first_day_of_week': return '一週的第一天';
			case 'settings.theme_and_colors': return '主題和顏色';
			case 'settings.theme': return '主題';
			case 'settings.theme_auto': return '由系統定義';
			case 'settings.theme_light': return '明亮主題';
			case 'settings.theme_dark': return '黑暗主題';
			case 'settings.amoled_mode': return 'amoled mode';
			case 'settings.amoled_mode_descr': return '盡可能使用純黑色壁紙。這對 AMOLED 螢幕設備的電池略有幫助';
			case 'settings.dynamic_colors': return '動態色彩';
			case 'settings.dynamic_colors_descr': return '盡可能使用系統強調色';
			case 'settings.accent_color': return '強調色';
			case 'settings.accent_color_descr': return '選擇應用程式用來強調介面某些部分的顏色';
			case 'settings.security.title': return '安全';
			case 'settings.security.private_mode_at_launch': return '啟動時啟用的隱私模式';
			case 'settings.security.private_mode_at_launch_descr': return '默認以隱私模式啟動應用程序';
			case 'settings.security.private_mode': return '隱私模式';
			case 'settings.security.private_mode_descr': return '隱藏所有貨幣值';
			case 'settings.security.private_mode_activated': return '隱私模式已啟用';
			case 'settings.security.private_mode_deactivated': return '隱私模式已禁用';
			case 'more.title': return '更多';
			case 'more.title_long': return '更多';
			case 'more.data.display': return '數據';
			case 'more.data.display_descr': return '匯出和匯入您的數據，這樣您就不會丟失任何東西';
			case 'more.data.delete_all': return '刪除我的資料';
			case 'more.data.delete_all_header1': return 'Stop right there padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return '您確定要繼續嗎？您的所有資料將永久刪除且無法恢復';
			case 'more.data.delete_all_header2': return '最後一步⚠️⚠️';
			case 'more.data.delete_all_message2': return '刪除帳戶後，您將刪除所有儲存的個人資料。您的帳戶、交易、預算和類別將被刪除且無法恢復。您同意嗎？';
			case 'more.about_us.display': return '應用程式資訊';
			case 'more.about_us.description': return '查看有關 Monekin 的條款和其他相關資訊。透過報告錯誤、留下建議與社區取得聯繫......';
			case 'more.about_us.legal.display': return '法律資訊';
			case 'more.about_us.legal.privacy': return '隱私權政策';
			case 'more.about_us.legal.terms': return '使用條款';
			case 'more.about_us.legal.licenses': return '許可證';
			case 'more.about_us.project.display': return '專案';
			case 'more.about_us.project.contributors': return '合作者';
			case 'more.about_us.project.contributors_descr': return '所有讓 Monekin 成長的開發者';
			case 'more.about_us.project.contact': return '聯絡我們';
			case 'more.help_us.display': return '幫助我們';
			case 'more.help_us.description': return '了解如何幫助 Monekin 變得越來越好';
			case 'more.help_us.rate_us': return '評價我們';
			case 'more.help_us.rate_us_descr': return '歡迎任何價格！';
			case 'more.help_us.share': return '分享 Monekin';
			case 'more.help_us.share_descr': return '與朋友和家人分享我們的應用程式';
			case 'more.help_us.share_text': return 'Monekin！最好的個人理財應用程式。在這裡下載';
			case 'more.help_us.thanks': return '謝謝你！';
			case 'more.help_us.thanks_long': return '您對 Monekin 和其他大大小小的開源專案的貢獻使得這樣偉大的專案成為可能。感謝您花時間做出貢獻。';
			case 'more.help_us.donate': return '做捐贈';
			case 'more.help_us.donate_descr': return '透過您的捐款，您將幫助該應用程式繼續改進。還有什麼比邀請我喝咖啡來感謝所做的工作更好的方式呢？';
			case 'more.help_us.donate_success': return '捐款已完成。非常感謝您的貢獻！❤️';
			case 'more.help_us.donate_err': return '糟糕！接收您的付款時出現錯誤';
			case 'more.help_us.report': return '報告錯誤、留下建議…';
			default: return null;
		}
	}
}

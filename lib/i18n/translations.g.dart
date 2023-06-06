/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 719 (359 per locale)
///
/// Built on 2023-06-05 at 15:19 UTC

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
enum AppLocale with BaseAppLocale<AppLocale, _TranslationsEn> {
	en(languageCode: 'en', build: _TranslationsEn.build),
	es(languageCode: 'es', build: _TranslationsEs.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _TranslationsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_TranslationsEn get translations => LocaleSettings.instance.translationMap[this]!;
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
_TranslationsEn get t => LocaleSettings.instance.currentTranslations;

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
class Translations {
	Translations._(); // no constructor

	static _TranslationsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _TranslationsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _TranslationsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _TranslationsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _TranslationsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_TranslationsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _TranslationsEn> {
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
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _TranslationsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _TranslationsEn implements BaseTranslations<AppLocale, _TranslationsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	@override final TranslationMetadata<AppLocale, _TranslationsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsGeneralEn general = _TranslationsGeneralEn._(_root);
	late final _TranslationsIntroEn intro = _TranslationsIntroEn._(_root);
	late final _TranslationsTabsEn tabs = _TranslationsTabsEn._(_root);
	late final _TranslationsFinancialHealthEn financial_health = _TranslationsFinancialHealthEn._(_root);
	late final _TranslationsIconSelectorEn icon_selector = _TranslationsIconSelectorEn._(_root);
	late final _TranslationsTransactionEn transaction = _TranslationsTransactionEn._(_root);
	late final _TranslationsTransferEn transfer = _TranslationsTransferEn._(_root);
	late final _TranslationsRecurrentTransactionsEn recurrent_transactions = _TranslationsRecurrentTransactionsEn._(_root);
	late final _TranslationsAccountEn account = _TranslationsAccountEn._(_root);
	late final _TranslationsCurrenciesEn currencies = _TranslationsCurrenciesEn._(_root);
	late final _TranslationsCategoriesEn categories = _TranslationsCategoriesEn._(_root);
	late final _TranslationsBudgetsEn budgets = _TranslationsBudgetsEn._(_root);
	late final _TranslationsGoPremiumEn go_premium = _TranslationsGoPremiumEn._(_root);
	late final _TranslationsBackupEn backup = _TranslationsBackupEn._(_root);
	late final _TranslationsSettingsEn settings = _TranslationsSettingsEn._(_root);
	late final _TranslationsLangEn lang = _TranslationsLangEn._(_root);
}

// Path: general
class _TranslationsGeneralEn {
	_TranslationsGeneralEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get cancel => 'Cancel';
	String get or => 'or';
	String get understood => 'Understood';
	String get confirm => 'Confirm';
	String get add => 'Add';
	String get edit => 'Edit';
	String get delete => 'Delete';
	String get income => 'Income';
	String get expense => 'Expense';
	String get incomes => 'Incomes';
	String get expenses => 'Expenses';
	String get expenses_and_incomes => 'Expenses and incomes';
	String get account => 'Account';
	String get accounts => 'Accounts';
	String get categories => 'Categories';
	String get category => 'Category';
	String get transaction => 'Transaction';
	String get transactions => 'Transactions';
	String get store_limit => 'Size of the app reached. No action allowed';
	String get today => 'Today';
	String get yesterday => 'Yesterday';
	String get filters => 'Filters';
	late final _TranslationsGeneralClipboardEn clipboard = _TranslationsGeneralClipboardEn._(_root);
	late final _TranslationsGeneralTimeEn time = _TranslationsGeneralTimeEn._(_root);
	late final _TranslationsGeneralTransactionOrderEn transaction_order = _TranslationsGeneralTransactionOrderEn._(_root);
	late final _TranslationsGeneralValidationsEn validations = _TranslationsGeneralValidationsEn._(_root);
}

// Path: intro
class _TranslationsIntroEn {
	_TranslationsIntroEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get start => 'Start';
	String get skip => 'Skip';
	String get next => 'Next';
	String get select_your_currency => 'Select your currency';
	String get welcome => 'Welcome to Monekin';
	String get welcome_subtitle => 'Your personal finance manager';
	String get welcome_footer => '<p>By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application</p>';
	String get offline_descr => '<strong>OFFLINE ACCOUNT:</strong><br> Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';
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

// Path: tabs
class _TranslationsTabsEn {
	_TranslationsTabsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get filter_transactions => 'Filter transactions';
	String get should_create_account_header => 'Ops!';
	String get should_create_account_message => 'You must create an account before you can start creating transactions';
	late final _TranslationsTabsTab1En tab1 = _TranslationsTabsTab1En._(_root);
	late final _TranslationsTabsTab2En tab2 = _TranslationsTabsTab2En._(_root);
	late final _TranslationsTabsTab3En tab3 = _TranslationsTabsTab3En._(_root);
}

// Path: financial_health
class _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get display => 'Financial health';
	late final _TranslationsFinancialHealthReviewEn review = _TranslationsFinancialHealthReviewEn._(_root);
	late final _TranslationsFinancialHealthMonthsWithoutIncomeEn months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeEn._(_root);
	late final _TranslationsFinancialHealthSavingsPercentageEn savings_percentage = _TranslationsFinancialHealthSavingsPercentageEn._(_root);
}

// Path: icon_selector
class _TranslationsIconSelectorEn {
	_TranslationsIconSelectorEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Name:';
	String get icon => 'Icon';
	String get color => 'Colour';
	String get select_icon => 'Select an icon';
	String get add_subcategory => 'Add subcategory';
	String get edit_subcategory => 'Edit subcategory';
}

// Path: transaction
class _TranslationsTransactionEn {
	_TranslationsTransactionEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get create => 'New transaction';
	String get new_income => 'New income';
	String get new_expense => 'New expense';
	String get new_success => 'Transaction created successfully';
	String get edit => 'Edit transaction';
	String get edit_success => 'Transaction edited successfully';
	String get duplicate => 'Clone transaction';
	String get duplicate_success => 'Transaction cloned successfully';
	String get delete => 'Delete transaction';
	String get delete_warning_message => 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';
	String get delete_success => 'Transaction deleted correctly';
	late final _TranslationsTransactionFormEn form = _TranslationsTransactionFormEn._(_root);
}

// Path: transfer
class _TranslationsTransferEn {
	_TranslationsTransferEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get display => 'Transfer';
	String from_to_text({required Object X, required Object Y}) => 'From ${X} to ${Y}';
	String get create => 'New Transfer';
	String get edit => 'Edit Transfer';
	String get delete => 'Delete transfer';
	String get delete_warning_message => 'This action is irreversible';
	String get delete_success => 'Transfer successfully deleted';
	String get need_two_accounts_warning_header => 'Ops!';
	String get need_two_accounts_warning_message => 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
	late final _TranslationsTransferFormEn form = _TranslationsTransferFormEn._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Recurrent transactions';
	String get empty => 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
	String get balance => 'Total balance';
	late final _TranslationsRecurrentTransactionsDetailsEn details = _TranslationsRecurrentTransactionsDetailsEn._(_root);
	late final _TranslationsRecurrentTransactionsSelectorEn selector = _TranslationsRecurrentTransactionsSelectorEn._(_root);
}

// Path: account
class _TranslationsAccountEn {
	_TranslationsAccountEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get date => 'Date created';
	String get balance => 'Account balance';
	String get n_transactions => 'Number of transactions';
	String get add_money => 'Add money';
	String get withdraw_money => 'Withdraw money';
	late final _TranslationsAccountTypesEn types = _TranslationsAccountTypesEn._(_root);
	late final _TranslationsAccountFormEn form = _TranslationsAccountFormEn._(_root);
	late final _TranslationsAccountShareEn share = _TranslationsAccountShareEn._(_root);
	late final _TranslationsAccountDeleteEn delete = _TranslationsAccountDeleteEn._(_root);
	late final _TranslationsAccountSelectEn select = _TranslationsAccountSelectEn._(_root);
}

// Path: currencies
class _TranslationsCurrenciesEn {
	_TranslationsCurrenciesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get currency_converter => 'Currency converter';
	String get select_a_currency => 'Select a currency';
	String get search_placeholder => 'Search by currency name, code...';
	String days_without_update({required Object X}) => 'Exchange rates last updated ${X} day(s) ago';
}

// Path: categories
class _TranslationsCategoriesEn {
	_TranslationsCategoriesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

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
	String make_child_warning1({required Object Destiny}) => 'This category and its subcategories will become subcategories of <b>${Destiny}</b>.';
	String make_child_warning2({required Object X, required Object Destiny}) => 'Their transactions <b>(${X})</b> will be moved to the new subcategories created within the <b>${Destiny}</b> category.';
	String get make_child_success => 'Subcategories created successfully';
	String get merge => 'Merge with another category';
	String merge_warning1({required Object X, required Object From, required Object Destiny}) => 'All transactions (<b>${X}</b>) associated with the category <b>${From}</b> will be moved to the category <b>${Destiny}</b>.';
	String merge_warning2({required Object From}) => 'The category <b>${From}</b> will be irreversibly deleted.';
	String get merge_success => 'Category merged successfully';
	String get delete_success => 'Category deleted correctly';
	String get delete_warning_header => 'Delete category?';
	String delete_warning_message({required Object X}) => 'This action will irreversibly delete all transactions <b>(${X})</b> related to this category.';
	late final _TranslationsCategoriesSelectEn select = _TranslationsCategoriesSelectEn._(_root);
}

// Path: budgets
class _TranslationsBudgetsEn {
	_TranslationsBudgetsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

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
	String get to_expend => 'to spend';
	String get days_left => 'days left';
	String get days_to_start => 'days to start';
	String get since_expiration => 'days since expiration';
	String get no_budgets => 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';
	String get delete => 'Delete budget';
	String get delete_warning => 'This action is irreversible. Categories and transactions referring to this quote will not be deleted';
	late final _TranslationsBudgetsFormEn form = _TranslationsBudgetsFormEn._(_root);
	late final _TranslationsBudgetsDetailsEn details = _TranslationsBudgetsDetailsEn._(_root);
}

// Path: go_premium
class _TranslationsGoPremiumEn {
	_TranslationsGoPremiumEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Choose a plan';
	String get description => 'Check the benefits of all our premium plans. Choose one and cancel whenever you want.';
	String get accounts_limit => 'Maximum number of accounts';
	String get budgets_limit => 'Maximum number of budgets';
	String get recurring_transactions_limit => 'Recurring transactions allowed';
	String get rate_update_frequency => 'Exchange rates update frequency';
	String get support => 'Support the developer';
	String get anual_price => 'Anual price';
	String get monthly_price => 'Mensual price';
	String get change_plan => 'To change plans you must first cancel previous subscriptions and wait for them to expire';
	String get return_to_free => 'To return to the free plan cancel the subscriptions you currently have active';
	String get current_plan => 'This is your current plan. You can cancel without obligation at any time';
	String get current_free_plan => 'You are here on the basic plan right now';
	String get admin_subscriptions => 'Manage subscriptions';
}

// Path: backup
class _TranslationsBackupEn {
	_TranslationsBackupEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	late final _TranslationsBackupExportEn export = _TranslationsBackupExportEn._(_root);
	late final _TranslationsBackupImportEn import = _TranslationsBackupImportEn._(_root);
	late final _TranslationsBackupGuideEn guide = _TranslationsBackupGuideEn._(_root);
}

// Path: settings
class _TranslationsSettingsEn {
	_TranslationsSettingsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	String get edit_profile => 'Edit profile';
	String get display_name => 'User name';
	String get lang => 'Language';
	String get lang_descr => 'Language in which the texts will be displayed in the app';
	String get locale => 'Region';
	String get locale_descr => 'Set the format to use for dates, numbers...';
	String get locale_warn => 'When changing region the app will update';
	String get first_day_of_week => 'First day of week';
	late final _TranslationsSettingsGeneralEn general = _TranslationsSettingsGeneralEn._(_root);
	late final _TranslationsSettingsDataEn data = _TranslationsSettingsDataEn._(_root);
	late final _TranslationsSettingsProjectEn project = _TranslationsSettingsProjectEn._(_root);
	late final _TranslationsSettingsHelpUsEn help_us = _TranslationsSettingsHelpUsEn._(_root);
	late final _TranslationsSettingsLicensesEn licenses = _TranslationsSettingsLicensesEn._(_root);
	late final _TranslationsSettingsPrivacyEn privacy = _TranslationsSettingsPrivacyEn._(_root);
	late final _TranslationsSettingsTermsOfUseEn terms_of_use = _TranslationsSettingsTermsOfUseEn._(_root);
}

// Path: lang
class _TranslationsLangEn {
	_TranslationsLangEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get es => 'Spanish';
	String get en => 'English';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String success({required Object X}) => '${X} copiado al portapapeles';
	String get error => 'Error al copiar';
}

// Path: general.time
class _TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get range => 'Time range';
	String get monthly => 'Monthly';
	String get diary => 'Diary';
	String get annualy => 'Annualy';
	String get quaterly => 'Quaterly';
	String get weekly => 'Weekly';
	String get custom => 'Custom';
	String get infinite => 'Always';
	String get start_date => 'Start date';
	String get end_date => 'End date';
	String get no_repeat => 'No recurrent';
	String get periodicity => 'Periodicity';
	late final _TranslationsGeneralTimeCurrentEn current = _TranslationsGeneralTimeCurrentEn._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get display => 'Order transactions';
	String get category => 'By category';
	String get quantity => 'By quantity';
	String get date => 'By date';
}

// Path: general.validations
class _TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get required => 'Required field';
}

// Path: tabs.tab1
class _TranslationsTabsTab1En {
	_TranslationsTabsTab1En._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Home';
	String get hello_day => 'Good morning,';
	String get hello_night => 'Good evening,';
	String get total_balance => 'Total balance';
	String get my_accounts => 'My accounts';
	String get tools => 'Tools';
	String get important_expenses => 'Largest expenses';
	String get empty_expenses => 'It looks like you don\'t have any transactions for this period yet. Add one by clicking the \'+\' button at the bottom';
	late final _TranslationsTabsTab1AccountResumeEn account_resume = _TranslationsTabsTab1AccountResumeEn._(_root);
}

// Path: tabs.tab2
class _TranslationsTabsTab2En {
	_TranslationsTabsTab2En._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Transacciones';
	String get balance => 'Balance';
	String get empty => 'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
	String get searcher_placeholder => 'Search by category, description...';
	String get loading => 'Loading more transactions...';
}

// Path: tabs.tab3
class _TranslationsTabsTab3En {
	_TranslationsTabsTab3En._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Resume';
	String get without_subcat => 'Other - ';
	String get average_by_transaction => 'Average/transaction';
	String get average_by_day => 'Average/day';
	String get balance => 'Final balance';
	String get balance_by_period => 'Average balance/period';
	String get cash_flow => 'Cash-flow';
	String get balance_evolution => 'Fund evolution';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get very_good => 'Very good!';
	String get good => 'Good';
	String get normal => 'Average';
	String get bad => 'Fair';
	String get very_bad => 'Very Bad';
	late final _TranslationsFinancialHealthReviewDescrEn descr = _TranslationsFinancialHealthReviewDescrEn._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String good({required Object X}) => 'Well done! At your current spending rate right now you could survive up to ${X} months without any income';
	String normal({required Object X}) => 'At your current spending rate right now you could survive up to ${X} months without any income. While this value is acceptable, you can still improve a little more!';
	String bad({required Object X}) => 'Wow! You would barely survive ${X} months without income at your current spending rate. Remember that it is recommended to be able to live at least 6 months without any income';
	String get very_bad => 'Wow! You could hardly survive a month without income at your current spending rate. Remember that it is recommended to be able to live at least 6 months without any income';
	String get insufficient_data => 'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String good({required Object Value}) => 'Congratulations! You have managed to save ${Value}% of your income during this period. It seems that you are already quite an expert. Keep it up!';
	String normal({required Object Value}) => 'Congratulations, you managed to save ${Value}% of your income during this period. Visit the analysis tab to see where you can save even more!';
	String bad({required Object Value}) => 'You have managed to save ${Value}% of your income during this period. However, we believe that you can still do much more! Remember that it is recommended to save at least 30% of what you earn';
	String get very_bad => 'Wow, you haven\'t managed to save anything during this period :( Visit the analysis tab to see where your financial weaknesses are. Remember that it is recommended to save at least 30% of what you earn';
}

// Path: transaction.form
class _TranslationsTransactionFormEn {
	_TranslationsTransactionFormEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get description => 'Description';
	String get description_info => 'Adding a note will help you find this transaction faster in the future';
	String get description_add => 'Add a note';
	String get without_category => 'Unspecified';
	String exchange_to_preferred({required Object X}) => 'Currently equal to approximately ${X}';
}

// Path: transfer.form
class _TranslationsTransferFormEn {
	_TranslationsTransferFormEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get from => 'Origin account';
	String get to => 'Destination account';
	String currency_info_add({required Object X}) => '${X} will be transferred to the destination account &#183; Click to edit';
	String currency_info_edit({required Object X}) => '${X} have been transferred to the destination account &#183; Click to edit';
	late final _TranslationsTransferFormCurrencyExchangeSelectorEn currency_exchange_selector = _TranslationsTransferFormCurrencyExchangeSelectorEn._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Transaction details';
	String get each_week => 'Each week';
	String get each_month => 'Each month';
	String get each_year => 'Each year';
	String get start_date => 'First move';
	String get balance_expense => 'Paid so far';
	String get balance_income => 'Income so far';
	String get end_date => 'End Date';
	String get pause_header => 'Pause payments';
	String get pause_message => 'This action will terminate this transaction today, and no more payments will be made from now on. Payments made before today will not be removed from the balance';
	String get pause_correctly => 'Transaction paused successfully';
	String get delete_header => 'Delete payments';
	String get delete_message => 'This action is irreversible and will delete all your payments from the balance';
	String get delete_success => 'Transactions deleted correctly';
}

// Path: recurrent_transactions.selector
class _TranslationsRecurrentTransactionsSelectorEn {
	_TranslationsRecurrentTransactionsSelectorEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => '¿How is your transaction repeated?';
	String get until => 'Until';
	String get infinite => 'The infinite';
	String get date => 'A date';
}

// Path: account.types
class _TranslationsAccountTypesEn {
	_TranslationsAccountTypesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

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

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Account name';
	String get name_placeholder => 'Ex: Savings account';
	String get description => 'Description';
	String get initial_balance => 'Initial balance';
	String get current_balance => 'Current balance';
	String get create => 'Create account';
	String get edit => 'Edit account';
	String get already_exists => 'There is already another one with the same name, please write another';
	String get users => 'Account users';
	String get admin => 'Administrator';
	String get collaborator => 'Collaborator';
	String get iban => 'IBAN';
	String get swift => 'SWIFT';
}

// Path: account.share
class _TranslationsAccountShareEn {
	_TranslationsAccountShareEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Share this account';
	String get title_short => 'Share';
	String get description => 'Enter the ID of the user in question to share this account. The user will be able to see, add, edit or modify all the transactions of this account';
	String get correct => 'Account shared successfully';
}

// Path: account.delete
class _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get warning_header => 'Are you sure?';
	String get warning_text => 'This action will delete this account and all its transactions';
	String get success => 'Account deleted successfully';
}

// Path: account.select
class _TranslationsAccountSelectEn {
	_TranslationsAccountSelectEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get one => 'Select an account';
	String get all => 'All accounts';
	String get multiple => 'Select accounts';
}

// Path: categories.select
class _TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Select categories';
	String get select_all => 'Select all';
	String get select_one => 'Select a category';
	String get select_subcategory => 'Choose a subcategory';
	String get without_subcategory => 'Without subcategory';
	String get all => 'All categories';
}

// Path: budgets.form
class _TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Add a budget';
	String get name => 'Budget name';
	String get value => 'Limit quantity';
	String get repetition => 'Repetition';
	String get create => 'Add budget';
	String get edit => 'Edit budget';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Budget Details';
	String get budget_value => 'Budget';
	String get statistics => 'Statistics';
	String get you_already_expend => 'You have already spent the';
	String get budget_exceeded_for => 'You have exceeded budget by';
	String get of_the_budget => 'of the budget';
	String get expend_diary_left => 'Remaining daily spend';
	String get expend_evolution => 'Expenditure evolution';
	String get no_transactions => 'It seems that you have not made any expenses related to this budget';
}

// Path: backup.export
class _TranslationsBackupExportEn {
	_TranslationsBackupExportEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Export your data';
	String get title_sort => 'Export';
	String get all => 'Full backup';
	String get all_descr => 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';
	String get transactions => 'Transactions backup';
	String get transactions_descr => 'Export your transactions in various formats so you can more easily analyze them in other programs or applications.';
	String get description => 'Keep a backup of all your accounts, budgets, transactions, settings...';
	String get dialog_title => 'Save/Send file';
	String get success_in_documents => 'File successfully saved to Internal Storage/Documents';
	String get success_in_data => 'File saved/downloaded successfully';
	String get error => 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportEn {
	_TranslationsBackupImportEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Import your data';
	String get title_sort => 'Import';
	String get upload_file => 'Upload your data file';
	String get touch_to_import => 'Touch to import';
	String get touch_to_change => 'Touch to change';
	String get onboarding_done => 'Backup uploaded';
	String get file => 'Import file';
	String get description => 'Replace all data currently in the app with data you have previously saved';
	String get long_description => 'If you have already used our application before, you may have a backup saved on your device with the name Monekin_backup_YYYY_MM_DD. If you prefer, you can perform this data import later.';
	String get success => 'Import performed successfully';
	String get error => 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
}

// Path: backup.guide
class _TranslationsBackupGuideEn {
	_TranslationsBackupGuideEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Guide on how to import/export your data';
	String get title_short => 'Import/Export data';
	String get message0 => 'So that you can recover your data if you uninstall the application, change your mobile or if they are lost by accident, it is recommended to export them from time to time. Thanks to this export you will be able to recover these data at any time in this window.';
	String get message1 => 'To export your data press the \'Export data\' box. A dialog should immediately open for you to select where you want to save your data. It is recommended to save it directly to your device\'s storage, although any other option like saving it in Google Drive or send it by mail is also perfectly valid.';
	String get message2 => 'Once you choose where to save/send your data, Monekin will save a file with all your information (transactions, budgets, categories, adjustments...). Absolutely everything will be saved in a JSON type file, with the name \'Monekin_backup_YEAR_MONTH_DAY\',';
	String get message3 => 'Now you can recover your data at any time by selecting the \'Import data\' option. When you press the box, you will have to search for the file that you previously exported. Once you have selected all your data that you have in that file, they will be loaded into our app .';
	String get message4 => 'When performing the data import, all the current data that the application has will be deleted and replaced by the new ones that you import.';
}

// Path: settings.general
class _TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get display => 'General settings';
	String get currency => 'Default currency';
	String get categories_descr => 'Create and edit categories to your liking';
	String get other => 'Advanced settings';
	String get other_descr => 'Other general app customization settings';
}

// Path: settings.data
class _TranslationsSettingsDataEn {
	_TranslationsSettingsDataEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get display => 'Data';
	String get export_descr => 'Download your data in different formats';
	String get import => 'Restore Backup';
	String get import_descr => 'Upload a .JSON file, and replace all your current data with the new one';
	String get delete_all => 'Delete my data';
	String get delete_all_header1 => 'Stop right there padawan ⚠️⚠️';
	String get delete_all_message1 => 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';
	String get delete_all_header2 => 'One last step ⚠️⚠️';
	String get delete_all_message2 => 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
}

// Path: settings.project
class _TranslationsSettingsProjectEn {
	_TranslationsSettingsProjectEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get display => 'Project';
	String get legal => 'Terms and privacy';
	String get legal_descr => 'Check licenses and other legal terms of our app';
	String get contributors => 'Collaborators';
	String get contributors_descr => 'All the developers who have made Monekin grow';
	String get contact => 'Contact us';
}

// Path: settings.help_us
class _TranslationsSettingsHelpUsEn {
	_TranslationsSettingsHelpUsEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get display => 'Help us';
	String get rate_us => 'Rate us';
	String get rate_us_descr => 'Any rate is welcome!';
	String get share => 'Share Monekin';
	String get share_text => 'Monekin! The best personal finance app';
	String get report => 'Report bugs, leave suggestions...';
}

// Path: settings.licenses
class _TranslationsSettingsLicensesEn {
	_TranslationsSettingsLicensesEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Licenses';
	String get footer => '<p>To build trust in us and help grow the app and its security, this project is 100% open source and 100% free. Anyone can see how it works inside and how data is stored Anyone can fix bugs, develop new features, etc.</p><p>Click <a href=\'https://github.com/enrique-lozano/Monekin\'>here</a> to see the application code and other useful information.</p>';
	String get start => 'All content in this application, such as icons, fonts and other libraries, has been legally obtained. External code libraries have been downloaded and used via the npm package manager. Also, the project is open source and anyone can contribute to it.';
	String get icons => 'Icons';
	String get fonts => 'Typefaces & Fonts';
	String get text1 => 'The icons of this app have been extracted from';
	String get text2 => 'We should mention the following authors:';
	String get text3 => 'A special mention should be made to the <a href=\'https://www.flaticon.com/packs/avatars-90?style_id=688&family_id=71&group_id=232\'>Vitaly Gorbachev avatar pack</a>, thanks to which you can configure your profile picture.';
}

// Path: settings.privacy
class _TranslationsSettingsPrivacyEn {
	_TranslationsSettingsPrivacyEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Privacy policy';
}

// Path: settings.terms_of_use
class _TranslationsSettingsTermsOfUseEn {
	_TranslationsSettingsTermsOfUseEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Terms of use';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get monthly => 'This month';
	String get annualy => 'This year';
	String get quaterly => 'This quarter';
	String get weekly => 'This week';
	String get infinite => 'For ever';
	String get custom => 'Custom Range';
}

// Path: tabs.tab1.account_resume
class _TranslationsTabsTab1AccountResumeEn {
	_TranslationsTabsTab1AccountResumeEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get link => 'See all';
	String get display => 'Summary of accounts';
	String get balance_by_account => 'Balance by accounts';
	String get balance_by_currency => 'Balance by currency';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get very_good => 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';
	String get good => 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';
	String get normal => 'Your financial health is more or less in the average of the rest of the population for this period';
	String get bad => 'It seems that your financial situation is not the best yet. Explore the analysis tab to learn more about your finances';
	String get very_bad => 'Hmm, your financial health is far below what it should be. Try to see where the problem is in the analysis section';
}

// Path: transfer.form.currency_exchange_selector
class _TranslationsTransferFormCurrencyExchangeSelectorEn {
	_TranslationsTransferFormCurrencyExchangeSelectorEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Edit exchange between currencies';
	String get exchange_rate => 'Exchange rate';
	String get value_in_destiny => 'Amount transferred in destination';
}

// Path: <root>
class _TranslationsEs extends _TranslationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, _TranslationsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _TranslationsEs _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsGeneralEs general = _TranslationsGeneralEs._(_root);
	@override late final _TranslationsIntroEs intro = _TranslationsIntroEs._(_root);
	@override late final _TranslationsTabsEs tabs = _TranslationsTabsEs._(_root);
	@override late final _TranslationsFinancialHealthEs financial_health = _TranslationsFinancialHealthEs._(_root);
	@override late final _TranslationsIconSelectorEs icon_selector = _TranslationsIconSelectorEs._(_root);
	@override late final _TranslationsTransactionEs transaction = _TranslationsTransactionEs._(_root);
	@override late final _TranslationsTransferEs transfer = _TranslationsTransferEs._(_root);
	@override late final _TranslationsRecurrentTransactionsEs recurrent_transactions = _TranslationsRecurrentTransactionsEs._(_root);
	@override late final _TranslationsAccountEs account = _TranslationsAccountEs._(_root);
	@override late final _TranslationsCurrenciesEs currencies = _TranslationsCurrenciesEs._(_root);
	@override late final _TranslationsCategoriesEs categories = _TranslationsCategoriesEs._(_root);
	@override late final _TranslationsBudgetsEs budgets = _TranslationsBudgetsEs._(_root);
	@override late final _TranslationsGoPremiumEs go_premium = _TranslationsGoPremiumEs._(_root);
	@override late final _TranslationsBackupEs backup = _TranslationsBackupEs._(_root);
	@override late final _TranslationsSettingsEs settings = _TranslationsSettingsEs._(_root);
	@override late final _TranslationsLangEs lang = _TranslationsLangEs._(_root);
}

// Path: general
class _TranslationsGeneralEs extends _TranslationsGeneralEn {
	_TranslationsGeneralEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get or => 'o';
	@override String get understood => 'Entendido';
	@override String get confirm => 'Confirmar';
	@override String get add => 'Añadir';
	@override String get edit => 'Editar';
	@override String get delete => 'Eliminar';
	@override String get income => 'Ingreso';
	@override String get expense => 'Gasto';
	@override String get incomes => 'Ingresos';
	@override String get expenses => 'Gastos';
	@override String get expenses_and_incomes => 'Gastos e ingresos';
	@override String get account => 'Cuenta';
	@override String get accounts => 'Cuentas';
	@override String get categories => 'Categorías';
	@override String get category => 'Categoría';
	@override String get transaction => 'Transacción';
	@override String get transactions => 'Transacciones';
	@override String get store_limit => 'Almacenamiento máximo de la app alcanzado. Acción cancelada';
	@override String get today => 'Hoy';
	@override String get yesterday => 'Ayer';
	@override String get filters => 'Filtros';
	@override late final _TranslationsGeneralClipboardEs clipboard = _TranslationsGeneralClipboardEs._(_root);
	@override late final _TranslationsGeneralTimeEs time = _TranslationsGeneralTimeEs._(_root);
	@override late final _TranslationsGeneralTransactionOrderEs transaction_order = _TranslationsGeneralTransactionOrderEs._(_root);
	@override late final _TranslationsGeneralValidationsEs validations = _TranslationsGeneralValidationsEs._(_root);
}

// Path: intro
class _TranslationsIntroEs extends _TranslationsIntroEn {
	_TranslationsIntroEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get start => 'Empecemos';
	@override String get skip => 'Saltar';
	@override String get next => 'Siguiente';
	@override String get select_your_currency => 'Selecciona tu divisa';
	@override String get welcome => 'Bienvenido a Monekin';
	@override String get welcome_subtitle => 'Tu gestor de finanzas personales';
	@override String get welcome_footer => '<p>Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación</p>';
	@override String get offline_descr => '<strong>CUENTA SIN CONEXIÓN:</strong><br> Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
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

// Path: tabs
class _TranslationsTabsEs extends _TranslationsTabsEn {
	_TranslationsTabsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get filter_transactions => 'Filtrar transacciones';
	@override String get should_create_account_header => 'Ops!';
	@override String get should_create_account_message => 'Debes crear una cuenta antes de empezar a crear transacciones';
	@override late final _TranslationsTabsTab1Es tab1 = _TranslationsTabsTab1Es._(_root);
	@override late final _TranslationsTabsTab2Es tab2 = _TranslationsTabsTab2Es._(_root);
	@override late final _TranslationsTabsTab3Es tab3 = _TranslationsTabsTab3Es._(_root);
}

// Path: financial_health
class _TranslationsFinancialHealthEs extends _TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Salud financiera';
	@override late final _TranslationsFinancialHealthReviewEs review = _TranslationsFinancialHealthReviewEs._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeEs months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeEs._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageEs savings_percentage = _TranslationsFinancialHealthSavingsPercentageEs._(_root);
}

// Path: icon_selector
class _TranslationsIconSelectorEs extends _TranslationsIconSelectorEn {
	_TranslationsIconSelectorEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre:';
	@override String get icon => 'Icono';
	@override String get color => 'Color';
	@override String get select_icon => 'Selecciona un icono';
	@override String get add_subcategory => 'Añadir subcategoría';
	@override String get edit_subcategory => 'Editar subcategoría';
}

// Path: transaction
class _TranslationsTransactionEs extends _TranslationsTransactionEn {
	_TranslationsTransactionEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get create => 'Nueva transacción';
	@override String get new_income => 'Nuevo ingreso';
	@override String get new_expense => 'Nuevo gasto';
	@override String get new_success => 'Transacción creada correctamente';
	@override String get edit => 'Editar transacción';
	@override String get edit_success => 'Transacción editada correctamente';
	@override String get duplicate => 'Clonar transacción';
	@override String get duplicate_success => 'Transacción clonada con exito';
	@override String get delete => 'Eliminar transacción';
	@override String get delete_warning_message => 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
	@override String get delete_success => 'Transacción eliminada correctamente';
	@override late final _TranslationsTransactionFormEs form = _TranslationsTransactionFormEs._(_root);
}

// Path: transfer
class _TranslationsTransferEs extends _TranslationsTransferEn {
	_TranslationsTransferEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Transferencia';
	@override String from_to_text({required Object X, required Object Y}) => 'Desde ${X} hasta ${Y}';
	@override String get create => 'Nueva transferencia';
	@override String get edit => 'Editar transferencia';
	@override String get delete => 'Eliminar transferencia';
	@override String get delete_warning_message => 'Esta acción es irreversible';
	@override String get delete_success => 'Transferencia eliminada correctamente';
	@override String get need_two_accounts_warning_header => 'Ops!';
	@override String get need_two_accounts_warning_message => 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
	@override late final _TranslationsTransferFormEs form = _TranslationsTransferFormEs._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsEs extends _TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Movimientos recurrentes';
	@override String get empty => 'Parece que no posees ninguna transacción que se repita periodicamente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
	@override String get balance => 'Balance total';
	@override late final _TranslationsRecurrentTransactionsDetailsEs details = _TranslationsRecurrentTransactionsDetailsEs._(_root);
	@override late final _TranslationsRecurrentTransactionsSelectorEs selector = _TranslationsRecurrentTransactionsSelectorEs._(_root);
}

// Path: account
class _TranslationsAccountEs extends _TranslationsAccountEn {
	_TranslationsAccountEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get date => 'Fecha de creación';
	@override String get balance => 'Saldo de la cuenta';
	@override String get n_transactions => 'Número de transacciones';
	@override String get add_money => 'Añadir dinero';
	@override String get withdraw_money => 'Retirar dinero';
	@override late final _TranslationsAccountTypesEs types = _TranslationsAccountTypesEs._(_root);
	@override late final _TranslationsAccountFormEs form = _TranslationsAccountFormEs._(_root);
	@override late final _TranslationsAccountShareEs share = _TranslationsAccountShareEs._(_root);
	@override late final _TranslationsAccountDeleteEs delete = _TranslationsAccountDeleteEs._(_root);
	@override late final _TranslationsAccountSelectEs select = _TranslationsAccountSelectEs._(_root);
}

// Path: currencies
class _TranslationsCurrenciesEs extends _TranslationsCurrenciesEn {
	_TranslationsCurrenciesEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Conversor de divisas';
	@override String get select_a_currency => 'Selecciona una divisa';
	@override String get search_placeholder => 'Busca por nombre o por código de la divisa';
	@override String days_without_update({required Object X}) => 'Tipos de cambio actualizados por última vez hace ${X} día(s)';
}

// Path: categories
class _TranslationsCategoriesEs extends _TranslationsCategoriesEn {
	_TranslationsCategoriesEs._(_TranslationsEs root) : this._root = root, super._(root);

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
	@override String make_child_warning1({required Object Destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${Destiny}</b>.';
	@override String make_child_warning2({required Object X, required Object Destiny}) => 'Sus transacciones <b>(${X})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${Destiny}</b>.';
	@override String get make_child_success => 'Subcategorías creadas con exito';
	@override String get merge => 'Fusionar con otra categoría';
	@override String merge_warning1({required Object X, required Object From, required Object Destiny}) => 'Todas las transacciones (<b>${X}</b>) asocidadas con la categoría <b>${From}</b> serán movidas a la categoría <b>${Destiny}</b>.';
	@override String merge_warning2({required Object From}) => 'La categoría <b>${From}</b> será eliminada de forma irreversible.';
	@override String get merge_success => 'Categoría fusionada correctamente';
	@override String get delete_success => 'Categoría eliminada correctamente';
	@override String get delete_warning_header => '¿Eliminar categoría?';
	@override String delete_warning_message({required Object X}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${X})</b> relativas a esta categoría.';
	@override late final _TranslationsCategoriesSelectEs select = _TranslationsCategoriesSelectEs._(_root);
}

// Path: budgets
class _TranslationsBudgetsEs extends _TranslationsBudgetsEn {
	_TranslationsBudgetsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Presupuestos';
	@override String get repeated => 'Periódicos';
	@override String get one_time => 'Una vez';
	@override String get anual => 'Anuales';
	@override String get week => 'Semanales';
	@override String get month => 'Mensuales';
	@override String get actives => 'Activos';
	@override String get pending => 'Pendientes de comenzar';
	@override String get finish => 'Finalizados';
	@override String get to_expend => 'por gastar';
	@override String get days_left => 'días restantes';
	@override String get days_to_start => 'días para empezar';
	@override String get since_expiration => 'días desde su expiración';
	@override String get no_budgets => 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
	@override String get delete => 'Eliminar presupuesto';
	@override String get delete_warning => 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
	@override late final _TranslationsBudgetsFormEs form = _TranslationsBudgetsFormEs._(_root);
	@override late final _TranslationsBudgetsDetailsEs details = _TranslationsBudgetsDetailsEs._(_root);
}

// Path: go_premium
class _TranslationsGoPremiumEs extends _TranslationsGoPremiumEn {
	_TranslationsGoPremiumEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Elige un plan';
	@override String get description => 'Consulta las ventajas de todos nuestros planes premium. Elige uno y cancela cuando quieras.';
	@override String get accounts_limit => 'Número máximo de cuentas';
	@override String get budgets_limit => 'Número máximo de presupuestos';
	@override String get recurring_transactions_limit => 'Transacciones recurrentes permitidas';
	@override String get rate_update_frequency => 'Frecuencia de actualización de los tipos de cambio';
	@override String get support => 'Apoyo al desarrollador';
	@override String get anual_price => 'Precio al año';
	@override String get monthly_price => 'Precio al mes';
	@override String get change_plan => 'Para cambiar de plan primero has de cancelar anteriores subscripciones y esperar a que estas expiren';
	@override String get return_to_free => 'Para volver al plan gratuito anula las subscripciones que tengas actualmente activas';
	@override String get current_plan => 'Este es tu plan actual. Puedes cancelarlo sin compromiso en cualquier momento';
	@override String get current_free_plan => 'Ahora mismo te encuentras aquí, en el plan básico';
	@override String get admin_subscriptions => 'Administrar subscripciones';
}

// Path: backup
class _TranslationsBackupEs extends _TranslationsBackupEn {
	_TranslationsBackupEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportEs export = _TranslationsBackupExportEs._(_root);
	@override late final _TranslationsBackupImportEs import = _TranslationsBackupImportEs._(_root);
	@override late final _TranslationsBackupGuideEs guide = _TranslationsBackupGuideEs._(_root);
}

// Path: settings
class _TranslationsSettingsEs extends _TranslationsSettingsEn {
	_TranslationsSettingsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajustes';
	@override String get edit_profile => 'Editar perfil';
	@override String get display_name => 'Nombre de usuario';
	@override String get lang => 'Idioma';
	@override String get lang_descr => 'Idioma en el que se mostrarán los textos en la app';
	@override String get locale => 'Región';
	@override String get locale_descr => 'Establece el formato a usar para fechas, números...';
	@override String get locale_warn => 'Al cambiar de región la app se refrescará';
	@override String get first_day_of_week => 'Primer día de la semana';
	@override late final _TranslationsSettingsGeneralEs general = _TranslationsSettingsGeneralEs._(_root);
	@override late final _TranslationsSettingsDataEs data = _TranslationsSettingsDataEs._(_root);
	@override late final _TranslationsSettingsProjectEs project = _TranslationsSettingsProjectEs._(_root);
	@override late final _TranslationsSettingsHelpUsEs help_us = _TranslationsSettingsHelpUsEs._(_root);
	@override late final _TranslationsSettingsLicensesEs licenses = _TranslationsSettingsLicensesEs._(_root);
	@override late final _TranslationsSettingsPrivacyEs privacy = _TranslationsSettingsPrivacyEs._(_root);
	@override late final _TranslationsSettingsTermsOfUseEs terms_of_use = _TranslationsSettingsTermsOfUseEs._(_root);
}

// Path: lang
class _TranslationsLangEs extends _TranslationsLangEn {
	_TranslationsLangEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get es => 'Español';
	@override String get en => 'Inglés';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardEs extends _TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String success({required Object X}) => '${X} copiado al portapapeles';
	@override String get error => 'Error al copiar';
}

// Path: general.time
class _TranslationsGeneralTimeEs extends _TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get range => 'Rango temporal';
	@override String get diary => 'Diaría';
	@override String get monthly => 'Mensual';
	@override String get annualy => 'Anual';
	@override String get quaterly => 'Trimestral';
	@override String get weekly => 'Semanal';
	@override String get custom => 'Personalizado';
	@override String get infinite => 'Siempre';
	@override String get start_date => 'Fecha de inicio';
	@override String get end_date => 'Fecha de fin';
	@override String get no_repeat => 'Sin repetición';
	@override String get periodicity => 'Periodicidad';
	@override late final _TranslationsGeneralTimeCurrentEs current = _TranslationsGeneralTimeCurrentEs._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderEs extends _TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ordenar transacciones';
	@override String get category => 'Por categoría';
	@override String get quantity => 'Por cantidad';
	@override String get date => 'Por fecha';
}

// Path: general.validations
class _TranslationsGeneralValidationsEs extends _TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get required => 'Campo obligatorio';
}

// Path: tabs.tab1
class _TranslationsTabsTab1Es extends _TranslationsTabsTab1En {
	_TranslationsTabsTab1Es._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Home';
	@override String get hello_day => 'Buenos días,';
	@override String get hello_night => 'Buenas noches,';
	@override String get total_balance => 'Saldo total';
	@override String get my_accounts => 'Mis cuentas';
	@override String get tools => 'Herramientas';
	@override String get important_expenses => 'Gastos mas grandes';
	@override String get empty_expenses => 'Parece que aun no tienes transacciones para este periodo. Añade una pulsando el botón \'+\' de la parte inferior';
	@override late final _TranslationsTabsTab1AccountResumeEs account_resume = _TranslationsTabsTab1AccountResumeEs._(_root);
}

// Path: tabs.tab2
class _TranslationsTabsTab2Es extends _TranslationsTabsTab2En {
	_TranslationsTabsTab2Es._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transacciones';
	@override String get balance => 'Balance';
	@override String get empty => 'No se han encontrado transacciones que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
	@override String get searcher_placeholder => 'Busca por categoría, descripción...';
	@override String get loading => 'Cargando más transacciones...';
}

// Path: tabs.tab3
class _TranslationsTabsTab3Es extends _TranslationsTabsTab3En {
	_TranslationsTabsTab3Es._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Análisis';
	@override String get without_subcat => 'Otro - ';
	@override String get average_by_transaction => 'Medía/transacción';
	@override String get average_by_day => 'Medía/día';
	@override String get balance => 'Balance final';
	@override String get balance_by_period => 'Balance medio/periodo';
	@override String get cash_flow => 'Flujo de caja';
	@override String get balance_evolution => 'Evolución de fondos';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewEs extends _TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get very_good => 'Muy buena!';
	@override String get good => 'Buena';
	@override String get normal => 'En la media';
	@override String get bad => 'Regular';
	@override String get very_bad => 'Muy mala';
	@override late final _TranslationsFinancialHealthReviewDescrEs descr = _TranslationsFinancialHealthReviewDescrEs._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeEs extends _TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String good({required Object X}) => 'Bien hecho! Con tu ritmo de gastos actual ahora mismo podrías sobrevivir hasta ${X} meses sin ningún ingreso';
	@override String normal({required Object X}) => 'Con tu ritmo de gastos actual ahora mismo podrías sobrevivir hasta ${X} meses sin ningún ingreso. Si bien este valor es aceptable, aun puedes mejorar un poco más!';
	@override String bad({required Object X}) => 'Vaya! Apenás sobrevivirías ${X} meses sin ingresos con tu ritmo de gastos actual. Recuerda que lo recomendable es poder vivir al menos 6 meses sin ningun ingreso';
	@override String get very_bad => 'Vaya! Apenas sobrevivirías un mes sin ingresos con tu ritmo de gastos actual. Recuerda que lo recomendable es poder vivir al menos 6 meses sin ningun ingreso';
	@override String get insufficient_data => 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageEs extends _TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String good({required Object Value}) => 'Enhorabuena! Has conseguido ahorrar un ${Value}% de tus ingresos durante este periodo. Parece que ya eres todo un expert@. Sigue asi!';
	@override String normal({required Object Value}) => 'Enhorabuena, has conseguido ahorrar un ${Value}% de tus ingresos durante este periodo. Visita la pestaña de análisis para ver donde puedes ahorrar aun más!';
	@override String bad({required Object Value}) => 'Has conseguido ahorrar un ${Value}% de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas! Recuerda que es recomendable ahorrar al menos un 30% de lo que ingresas';
	@override String get very_bad => 'Vaya, no has conseguido ahorrar nada durante este periodo :( Visita la pestaña de análisis para ver donde estan tus debilidades financieras. Recuerda que es recomendable ahorrar al menos un 30% de lo que ingresas';
}

// Path: transaction.form
class _TranslationsTransactionFormEs extends _TranslationsTransactionFormEn {
	_TranslationsTransactionFormEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Descripción';
	@override String get description_info => 'Añadir una nota te ayudará a encontrar mas rapidamente esta transacción en un futuro';
	@override String get description_add => 'Añade una nota';
	@override String get without_category => 'Sin especificar';
	@override String exchange_to_preferred({required Object X}) => 'Actualmente equivalen aproximadamente a ${X}';
}

// Path: transfer.form
class _TranslationsTransferFormEs extends _TranslationsTransferFormEn {
	_TranslationsTransferFormEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get from => 'Cuenta origen';
	@override String get to => 'Cuenta destino';
	@override String currency_info_add({required Object X}) => 'Se transpasarán ${X} a la cuenta de destino &#183; Pulsa para editar';
	@override String currency_info_edit({required Object X}) => 'Se han transpasado ${X} a la cuenta de destino &#183; Pulsa para editar';
	@override late final _TranslationsTransferFormCurrencyExchangeSelectorEs currency_exchange_selector = _TranslationsTransferFormCurrencyExchangeSelectorEs._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsEs extends _TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles del movimiento';
	@override String get each_week => 'Cada semana';
	@override String get each_month => 'Cada mes';
	@override String get each_year => 'Cada año';
	@override String get start_date => 'Primer movimiento';
	@override String get balance_expense => 'Pagado hasta ahora';
	@override String get balance_income => 'Ingresado hasta ahora';
	@override String get end_date => 'Fecha de finalización';
	@override String get pause_header => 'Pausar pagos';
	@override String get pause_message => 'Con esta acción se dará por finalizada esta transacción hoy, y no se produciran mas pagos a partir de ahora. Pagos previos al día de hoy no serán eliminados del balance';
	@override String get pause_correctly => 'Transacción pausada correctamente';
	@override String get delete_header => 'Eliminar pagos';
	@override String get delete_message => 'Esta acción es irreversible y borrara todos tus pagos del balance';
	@override String get delete_success => 'Transacciones eliminadas correctamente';
}

// Path: recurrent_transactions.selector
class _TranslationsRecurrentTransactionsSelectorEs extends _TranslationsRecurrentTransactionsSelectorEn {
	_TranslationsRecurrentTransactionsSelectorEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Cómo se repite su transacción?';
	@override String get until => 'Hasta';
	@override String get infinite => 'El infinito';
	@override String get date => 'Una fecha';
}

// Path: account.types
class _TranslationsAccountTypesEs extends _TranslationsAccountTypesEn {
	_TranslationsAccountTypesEs._(_TranslationsEs root) : this._root = root, super._(root);

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
class _TranslationsAccountFormEs extends _TranslationsAccountFormEn {
	_TranslationsAccountFormEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre de la cuenta';
	@override String get name_placeholder => 'Ej: Cuenta de ahorros';
	@override String get description => 'Descripción';
	@override String get initial_balance => 'Balance inicial';
	@override String get current_balance => 'Balance actual';
	@override String get create => 'Crear cuenta';
	@override String get edit => 'Editar cuenta';
	@override String get already_exists => 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
	@override String get users => 'Usuarios de la cuenta';
	@override String get admin => 'Administrador';
	@override String get collaborator => 'Colaborador';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.share
class _TranslationsAccountShareEs extends _TranslationsAccountShareEn {
	_TranslationsAccountShareEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartir esta cuenta';
	@override String get title_short => 'Compartir';
	@override String get description => 'Introduce el ID del usuario en cuestión para compartir esta cuenta. El usuario podrá ver, añadir, editar o modificar todas las transacciones de esta cuenta';
	@override String get correct => 'Cuenta compartida correctamente';
}

// Path: account.delete
class _TranslationsAccountDeleteEs extends _TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get warning_header => '¿Estas seguro?';
	@override String get warning_text => 'Esta acción borrara esta cuenta y todas sus transacciones';
	@override String get success => 'Cuenta eliminada correctamente';
}

// Path: account.select
class _TranslationsAccountSelectEs extends _TranslationsAccountSelectEn {
	_TranslationsAccountSelectEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get one => 'Selecciona una cuenta';
	@override String get multiple => 'Selecciona cuentas';
	@override String get all => 'Todas las cuentas';
}

// Path: categories.select
class _TranslationsCategoriesSelectEs extends _TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecciona categorías';
	@override String get select_all => 'Seleccionar todas';
	@override String get select_one => 'Selecciona una categoría';
	@override String get select_subcategory => 'Elige una subcategoría';
	@override String get without_subcategory => 'Sin subcategoría';
	@override String get all => 'Todas las categorías';
}

// Path: budgets.form
class _TranslationsBudgetsFormEs extends _TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Añade un presupuesto';
	@override String get name => 'Nombre del presupuesto';
	@override String get value => 'Cantidad límite';
	@override String get repetition => 'Repetición';
	@override String get create => 'Añade el presupuesto';
	@override String get edit => 'Editar presupuesto';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsEs extends _TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles del presupuesto';
	@override String get budget_value => 'Presupuestado';
	@override String get statistics => 'Estadísticas';
	@override String get you_already_expend => 'Ya has gastado el';
	@override String get budget_exceeded_for => 'Has sobrepasado el presupuesto en';
	@override String get of_the_budget => 'del presupuesto';
	@override String get expend_diary_left => 'Gasto diario restante';
	@override String get expend_evolution => 'Evolución del gasto';
	@override String get no_transactions => 'Parece que no has realizado ningún gasto relativo a este presupuesto';
}

// Path: backup.export
class _TranslationsBackupExportEs extends _TranslationsBackupExportEn {
	_TranslationsBackupExportEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exportar datos';
	@override String get title_sort => 'Exportar';
	@override String get all => 'Respaldo total';
	@override String get all_descr => 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
	@override String get transactions => 'Respaldo de transacciones';
	@override String get transactions_descr => 'Exporta tus transacciones en diversos formatos para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
	@override String get description => 'Guarda una copia de seguridad de todas tus cuentas, presupuestos, transacciones, ajustes...';
	@override String get dialog_title => 'Guardar/Enviar archivo';
	@override String get success_in_documents => 'Archivo guardado correctamente en Almacenamiento interno/Documents';
	@override String get success_in_data => 'Archivo guardado/enviado correctamente';
	@override String get error => 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportEs extends _TranslationsBackupImportEn {
	_TranslationsBackupImportEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importar tus datos';
	@override String get upload_file => 'Sube tu archivo de datos';
	@override String get touch_to_import => 'Toca para importar';
	@override String get touch_to_change => 'Toca para cambiar';
	@override String get onboarding_done => 'Copia de seguridad subida';
	@override String get file => 'Importar archivo';
	@override String get description => 'Reemplaza todos los datos que hay actualmente en la app por otros que hayas guardado previamente';
	@override String get long_description => 'Si ya has usado nuestra aplicación antes puede que tengas una copia de seguridad guardada en tu disposivo con el nombre Monekin_backup_YYYY_MM_DD. Si prefieres puedes realizar esta importación de datos mas adelante.';
	@override String get success => 'Importación realizada con exito';
	@override String get error => 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
}

// Path: backup.guide
class _TranslationsBackupGuideEs extends _TranslationsBackupGuideEn {
	_TranslationsBackupGuideEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Guía de como importar/exportar sus datos';
	@override String get title_short => 'Importar/Exportar datos';
	@override String get message0 => 'Para que puedas recuperar tus datos si desinstalas la aplicación, cambias de movil o estos son perdidos por accidente, se recomienda exportarlos cada cierto tiempo. Gracias a esta exportación podrás recuperar estos datos en cualquier momento en esta ventana.';
	@override String get message1 => 'Para exportar tus datos pulsa el cuadro de \'Exportar datos\'. Inmediatamente se debería abrir un dialogo para que selecciones donde quieres guardar tus datos. Se recomienda guardarlos directamente en el almacenamineto de tu dispositvo, aunque cualquier otra opción como guardarlo en Google Drive o enviarlo por mail también es perfectamente valida.';
	@override String get message2 => 'Una vez elijas donde guardar/enviar tus datos, Monekin guardará un fichero con toda tu información (transacciones, presupuestos, categorías, ajustes...). Absolutamnete todo será guardado en un fichero de tipo JSON, con el nombre \'Monekin_backup_AÑO_MES_DIA\',';
	@override String get message3 => 'Ahora podrás recuperar tus datos en cualquier momento seleccionando la opción \'Importar datos\'. Al pulsar el cuadro, deberás buscar el fichero que exportaste previamente. Una vez seleccionado todos tus datos que teneis en ese fichero se cargaran en nuestra app.';
	@override String get message4 => 'Al realizar la importación de datos, todos los datos actuales que tiene la aplicación serán borrados y reemplazados por los nuevos que importes.';
}

// Path: settings.general
class _TranslationsSettingsGeneralEs extends _TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ajustes generales';
	@override String get currency => 'Divisa predeterminada';
	@override String get categories_descr => 'Crea y edita categorías a tu gusto';
	@override String get other => 'Ajustes avanzados';
	@override String get other_descr => 'Otros ajustes generales de personalización de la app';
}

// Path: settings.data
class _TranslationsSettingsDataEs extends _TranslationsSettingsDataEn {
	_TranslationsSettingsDataEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Datos';
	@override String get export_descr => 'Descarga tus datos en diferentes formatos';
	@override String get import => 'Restaurar copia de seguridad';
	@override String get import_descr => 'Sube un fichero .JSON, y reemplaza todos tus datos actuales por los nuevos';
	@override String get delete_all => 'Eliminar mis datos';
	@override String get delete_all_header1 => 'Alto ahí padawan ⚠️⚠️';
	@override String get delete_all_message1 => '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
	@override String get delete_all_header2 => 'Un último paso ⚠️⚠️';
	@override String get delete_all_message2 => 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
}

// Path: settings.project
class _TranslationsSettingsProjectEs extends _TranslationsSettingsProjectEn {
	_TranslationsSettingsProjectEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Proyecto';
	@override String get legal => 'Términos y privacidad';
	@override String get legal_descr => 'Revisa licencias y otros terminos legales de nuestra app';
	@override String get contributors => 'Colaboradores';
	@override String get contributors_descr => 'Todos los desarrolladores que han hecho que Monekin crezca';
	@override String get contact => 'Contacta con nosotros';
}

// Path: settings.help_us
class _TranslationsSettingsHelpUsEs extends _TranslationsSettingsHelpUsEn {
	_TranslationsSettingsHelpUsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ayúdanos';
	@override String get rate_us => 'Califícanos';
	@override String get rate_us_descr => '¡Cualquier valoración es bienvenida!';
	@override String get share => 'Comparte Monekin';
	@override String get share_text => 'Monekin! La mejor app de finanzas personales';
	@override String get report => 'Reporta errores, deja sugerencias...';
}

// Path: settings.licenses
class _TranslationsSettingsLicensesEs extends _TranslationsSettingsLicensesEn {
	_TranslationsSettingsLicensesEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Licencias';
	@override String get start => 'Todo el contenido de esta aplicación, como íconos, fuentes y otras bibliotecas, se ha obtenido legalmente. Se han descargado y utilizado bibliotecas de códigos externos a través del administrador de paquetes npm. Además, el proyecto es de código abierto y cualquiera puede colaborar en el.';
	@override String get footer => '<p>Para generar confianza en nosotros y ayudar al crecimiento de la aplicación y su seguridad, este proyecto es 100 % de código abierto y 100 % gratuito. Cualquiera puede ver cómo funciona por dentro y cómo se almacenan los datos de los usuarios. Cualquiera puede solucionar errores, desarrollar nuevas funcionalidades, etc.</p><p>Pincha <a href=\'https://github.com/enrique-lozano/Monekin\'>aquí</a> para ver el código de la aplicación y más información de interés.</p>';
	@override String get icons => 'Iconos';
	@override String get fonts => 'Tipografías & Fuentes';
	@override String get text1 => 'Los iconos usados en esta aplicación han sido extraidos desde';
	@override String get text2 => 'Hemos de destacar a los siguientes autores:';
	@override String get text3 => 'Hemos de hacer mención especial al <a href=\'https://www.flaticon.com/packs/avatars-90?style_id=688&family_id=71&group_id=232\'>paquete de avatares de Vitaly Gorbachev</a>, gracias al cual podeis configurar vuestra imagen de perfil.';
}

// Path: settings.privacy
class _TranslationsSettingsPrivacyEs extends _TranslationsSettingsPrivacyEn {
	_TranslationsSettingsPrivacyEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Política de privacidad';
}

// Path: settings.terms_of_use
class _TranslationsSettingsTermsOfUseEs extends _TranslationsSettingsTermsOfUseEn {
	_TranslationsSettingsTermsOfUseEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Términos de uso';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentEs extends _TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Este mes';
	@override String get annualy => 'Este año';
	@override String get quaterly => 'Este trimestre';
	@override String get weekly => 'Esta semana';
	@override String get infinite => 'Desde siempre';
	@override String get custom => 'Rango personalizado';
}

// Path: tabs.tab1.account_resume
class _TranslationsTabsTab1AccountResumeEs extends _TranslationsTabsTab1AccountResumeEn {
	_TranslationsTabsTab1AccountResumeEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get link => 'Ver todas';
	@override String get display => 'Resumen de cuentas';
	@override String get balance_by_account => 'Saldo por cuentas';
	@override String get balance_by_currency => 'Saldo por divisas';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrEs extends _TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get very_good => 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
	@override String get good => 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
	@override String get normal => 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
	@override String get bad => 'Parece que tu situación financiera no es la mejor aun. Explora la pestaña de análisis para conocer mas sobre tus finanzas';
	@override String get very_bad => 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema en la sección de análisis';
}

// Path: transfer.form.currency_exchange_selector
class _TranslationsTransferFormCurrencyExchangeSelectorEs extends _TranslationsTransferFormCurrencyExchangeSelectorEn {
	_TranslationsTransferFormCurrencyExchangeSelectorEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar cambio entre divisas';
	@override String get exchange_rate => 'Tipo de cambio';
	@override String get value_in_destiny => 'Cantidad transferida en destino';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'general.cancel': return 'Cancel';
			case 'general.or': return 'or';
			case 'general.understood': return 'Understood';
			case 'general.confirm': return 'Confirm';
			case 'general.add': return 'Add';
			case 'general.edit': return 'Edit';
			case 'general.delete': return 'Delete';
			case 'general.income': return 'Income';
			case 'general.expense': return 'Expense';
			case 'general.incomes': return 'Incomes';
			case 'general.expenses': return 'Expenses';
			case 'general.expenses_and_incomes': return 'Expenses and incomes';
			case 'general.account': return 'Account';
			case 'general.accounts': return 'Accounts';
			case 'general.categories': return 'Categories';
			case 'general.category': return 'Category';
			case 'general.transaction': return 'Transaction';
			case 'general.transactions': return 'Transactions';
			case 'general.store_limit': return 'Size of the app reached. No action allowed';
			case 'general.today': return 'Today';
			case 'general.yesterday': return 'Yesterday';
			case 'general.filters': return 'Filters';
			case 'general.clipboard.success': return ({required Object X}) => '${X} copiado al portapapeles';
			case 'general.clipboard.error': return 'Error al copiar';
			case 'general.time.range': return 'Time range';
			case 'general.time.monthly': return 'Monthly';
			case 'general.time.diary': return 'Diary';
			case 'general.time.annualy': return 'Annualy';
			case 'general.time.quaterly': return 'Quaterly';
			case 'general.time.weekly': return 'Weekly';
			case 'general.time.custom': return 'Custom';
			case 'general.time.infinite': return 'Always';
			case 'general.time.start_date': return 'Start date';
			case 'general.time.end_date': return 'End date';
			case 'general.time.no_repeat': return 'No recurrent';
			case 'general.time.periodicity': return 'Periodicity';
			case 'general.time.current.monthly': return 'This month';
			case 'general.time.current.annualy': return 'This year';
			case 'general.time.current.quaterly': return 'This quarter';
			case 'general.time.current.weekly': return 'This week';
			case 'general.time.current.infinite': return 'For ever';
			case 'general.time.current.custom': return 'Custom Range';
			case 'general.transaction_order.display': return 'Order transactions';
			case 'general.transaction_order.category': return 'By category';
			case 'general.transaction_order.quantity': return 'By quantity';
			case 'general.transaction_order.date': return 'By date';
			case 'general.validations.required': return 'Required field';
			case 'intro.start': return 'Start';
			case 'intro.skip': return 'Skip';
			case 'intro.next': return 'Next';
			case 'intro.select_your_currency': return 'Select your currency';
			case 'intro.welcome': return 'Welcome to Monekin';
			case 'intro.welcome_subtitle': return 'Your personal finance manager';
			case 'intro.welcome_footer': return '<p>By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application</p>';
			case 'intro.offline_descr': return '<strong>OFFLINE ACCOUNT:</strong><br> Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';
			case 'intro.offline_start': return 'Start session offline';
			case 'intro.sl1_title': return 'Select your currency';
			case 'intro.sl1_descr': return 'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings';
			case 'intro.sl2_title': return 'Safe, private and reliable';
			case 'intro.sl2_descr': return 'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet';
			case 'intro.sl2_descr2': return 'Also, the source code of the application is public, anyone can collaborate on it and see how it works';
			case 'intro.last_slide_title': return 'All ready';
			case 'intro.last_slide_descr': return 'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.';
			case 'intro.last_slide_descr2': return 'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...';
			case 'tabs.filter_transactions': return 'Filter transactions';
			case 'tabs.should_create_account_header': return 'Ops!';
			case 'tabs.should_create_account_message': return 'You must create an account before you can start creating transactions';
			case 'tabs.tab1.title': return 'Home';
			case 'tabs.tab1.hello_day': return 'Good morning,';
			case 'tabs.tab1.hello_night': return 'Good evening,';
			case 'tabs.tab1.total_balance': return 'Total balance';
			case 'tabs.tab1.my_accounts': return 'My accounts';
			case 'tabs.tab1.tools': return 'Tools';
			case 'tabs.tab1.important_expenses': return 'Largest expenses';
			case 'tabs.tab1.empty_expenses': return 'It looks like you don\'t have any transactions for this period yet. Add one by clicking the \'+\' button at the bottom';
			case 'tabs.tab1.account_resume.link': return 'See all';
			case 'tabs.tab1.account_resume.display': return 'Summary of accounts';
			case 'tabs.tab1.account_resume.balance_by_account': return 'Balance by accounts';
			case 'tabs.tab1.account_resume.balance_by_currency': return 'Balance by currency';
			case 'tabs.tab2.title': return 'Transacciones';
			case 'tabs.tab2.balance': return 'Balance';
			case 'tabs.tab2.empty': return 'No transactions found to display here. Add a transaction by clicking the \'+\' button at the bottom';
			case 'tabs.tab2.searcher_placeholder': return 'Search by category, description...';
			case 'tabs.tab2.loading': return 'Loading more transactions...';
			case 'tabs.tab3.title': return 'Resume';
			case 'tabs.tab3.without_subcat': return 'Other - ';
			case 'tabs.tab3.average_by_transaction': return 'Average/transaction';
			case 'tabs.tab3.average_by_day': return 'Average/day';
			case 'tabs.tab3.balance': return 'Final balance';
			case 'tabs.tab3.balance_by_period': return 'Average balance/period';
			case 'tabs.tab3.cash_flow': return 'Cash-flow';
			case 'tabs.tab3.balance_evolution': return 'Fund evolution';
			case 'financial_health.display': return 'Financial health';
			case 'financial_health.review.very_good': return 'Very good!';
			case 'financial_health.review.good': return 'Good';
			case 'financial_health.review.normal': return 'Average';
			case 'financial_health.review.bad': return 'Fair';
			case 'financial_health.review.very_bad': return 'Very Bad';
			case 'financial_health.review.descr.very_good': return 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';
			case 'financial_health.review.descr.good': return 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';
			case 'financial_health.review.descr.normal': return 'Your financial health is more or less in the average of the rest of the population for this period';
			case 'financial_health.review.descr.bad': return 'It seems that your financial situation is not the best yet. Explore the analysis tab to learn more about your finances';
			case 'financial_health.review.descr.very_bad': return 'Hmm, your financial health is far below what it should be. Try to see where the problem is in the analysis section';
			case 'financial_health.months_without_income.good': return ({required Object X}) => 'Well done! At your current spending rate right now you could survive up to ${X} months without any income';
			case 'financial_health.months_without_income.normal': return ({required Object X}) => 'At your current spending rate right now you could survive up to ${X} months without any income. While this value is acceptable, you can still improve a little more!';
			case 'financial_health.months_without_income.bad': return ({required Object X}) => 'Wow! You would barely survive ${X} months without income at your current spending rate. Remember that it is recommended to be able to live at least 6 months without any income';
			case 'financial_health.months_without_income.very_bad': return 'Wow! You could hardly survive a month without income at your current spending rate. Remember that it is recommended to be able to live at least 6 months without any income';
			case 'financial_health.months_without_income.insufficient_data': return 'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
			case 'financial_health.savings_percentage.good': return ({required Object Value}) => 'Congratulations! You have managed to save ${Value}% of your income during this period. It seems that you are already quite an expert. Keep it up!';
			case 'financial_health.savings_percentage.normal': return ({required Object Value}) => 'Congratulations, you managed to save ${Value}% of your income during this period. Visit the analysis tab to see where you can save even more!';
			case 'financial_health.savings_percentage.bad': return ({required Object Value}) => 'You have managed to save ${Value}% of your income during this period. However, we believe that you can still do much more! Remember that it is recommended to save at least 30% of what you earn';
			case 'financial_health.savings_percentage.very_bad': return 'Wow, you haven\'t managed to save anything during this period :( Visit the analysis tab to see where your financial weaknesses are. Remember that it is recommended to save at least 30% of what you earn';
			case 'icon_selector.name': return 'Name:';
			case 'icon_selector.icon': return 'Icon';
			case 'icon_selector.color': return 'Colour';
			case 'icon_selector.select_icon': return 'Select an icon';
			case 'icon_selector.add_subcategory': return 'Add subcategory';
			case 'icon_selector.edit_subcategory': return 'Edit subcategory';
			case 'transaction.create': return 'New transaction';
			case 'transaction.new_income': return 'New income';
			case 'transaction.new_expense': return 'New expense';
			case 'transaction.new_success': return 'Transaction created successfully';
			case 'transaction.edit': return 'Edit transaction';
			case 'transaction.edit_success': return 'Transaction edited successfully';
			case 'transaction.duplicate': return 'Clone transaction';
			case 'transaction.duplicate_success': return 'Transaction cloned successfully';
			case 'transaction.delete': return 'Delete transaction';
			case 'transaction.delete_warning_message': return 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';
			case 'transaction.delete_success': return 'Transaction deleted correctly';
			case 'transaction.form.description': return 'Description';
			case 'transaction.form.description_info': return 'Adding a note will help you find this transaction faster in the future';
			case 'transaction.form.description_add': return 'Add a note';
			case 'transaction.form.without_category': return 'Unspecified';
			case 'transaction.form.exchange_to_preferred': return ({required Object X}) => 'Currently equal to approximately ${X}';
			case 'transfer.display': return 'Transfer';
			case 'transfer.from_to_text': return ({required Object X, required Object Y}) => 'From ${X} to ${Y}';
			case 'transfer.create': return 'New Transfer';
			case 'transfer.edit': return 'Edit Transfer';
			case 'transfer.delete': return 'Delete transfer';
			case 'transfer.delete_warning_message': return 'This action is irreversible';
			case 'transfer.delete_success': return 'Transfer successfully deleted';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
			case 'transfer.form.from': return 'Origin account';
			case 'transfer.form.to': return 'Destination account';
			case 'transfer.form.currency_info_add': return ({required Object X}) => '${X} will be transferred to the destination account &#183; Click to edit';
			case 'transfer.form.currency_info_edit': return ({required Object X}) => '${X} have been transferred to the destination account &#183; Click to edit';
			case 'transfer.form.currency_exchange_selector.title': return 'Edit exchange between currencies';
			case 'transfer.form.currency_exchange_selector.exchange_rate': return 'Exchange rate';
			case 'transfer.form.currency_exchange_selector.value_in_destiny': return 'Amount transferred in destination';
			case 'recurrent_transactions.title': return 'Recurrent transactions';
			case 'recurrent_transactions.empty': return 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
			case 'recurrent_transactions.balance': return 'Total balance';
			case 'recurrent_transactions.details.title': return 'Transaction details';
			case 'recurrent_transactions.details.each_week': return 'Each week';
			case 'recurrent_transactions.details.each_month': return 'Each month';
			case 'recurrent_transactions.details.each_year': return 'Each year';
			case 'recurrent_transactions.details.start_date': return 'First move';
			case 'recurrent_transactions.details.balance_expense': return 'Paid so far';
			case 'recurrent_transactions.details.balance_income': return 'Income so far';
			case 'recurrent_transactions.details.end_date': return 'End Date';
			case 'recurrent_transactions.details.pause_header': return 'Pause payments';
			case 'recurrent_transactions.details.pause_message': return 'This action will terminate this transaction today, and no more payments will be made from now on. Payments made before today will not be removed from the balance';
			case 'recurrent_transactions.details.pause_correctly': return 'Transaction paused successfully';
			case 'recurrent_transactions.details.delete_header': return 'Delete payments';
			case 'recurrent_transactions.details.delete_message': return 'This action is irreversible and will delete all your payments from the balance';
			case 'recurrent_transactions.details.delete_success': return 'Transactions deleted correctly';
			case 'recurrent_transactions.selector.title': return '¿How is your transaction repeated?';
			case 'recurrent_transactions.selector.until': return 'Until';
			case 'recurrent_transactions.selector.infinite': return 'The infinite';
			case 'recurrent_transactions.selector.date': return 'A date';
			case 'account.date': return 'Date created';
			case 'account.balance': return 'Account balance';
			case 'account.n_transactions': return 'Number of transactions';
			case 'account.add_money': return 'Add money';
			case 'account.withdraw_money': return 'Withdraw money';
			case 'account.types.title': return 'Account type';
			case 'account.types.warning': return 'Once the type of account has been chosen, it cannot be changed in the future';
			case 'account.types.normal': return 'Normal account';
			case 'account.types.normal_descr': return 'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...';
			case 'account.types.saving': return 'Savings account';
			case 'account.types.saving_descr': return 'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money';
			case 'account.form.name': return 'Account name';
			case 'account.form.name_placeholder': return 'Ex: Savings account';
			case 'account.form.description': return 'Description';
			case 'account.form.initial_balance': return 'Initial balance';
			case 'account.form.current_balance': return 'Current balance';
			case 'account.form.create': return 'Create account';
			case 'account.form.edit': return 'Edit account';
			case 'account.form.already_exists': return 'There is already another one with the same name, please write another';
			case 'account.form.users': return 'Account users';
			case 'account.form.admin': return 'Administrator';
			case 'account.form.collaborator': return 'Collaborator';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.share.title': return 'Share this account';
			case 'account.share.title_short': return 'Share';
			case 'account.share.description': return 'Enter the ID of the user in question to share this account. The user will be able to see, add, edit or modify all the transactions of this account';
			case 'account.share.correct': return 'Account shared successfully';
			case 'account.delete.warning_header': return 'Are you sure?';
			case 'account.delete.warning_text': return 'This action will delete this account and all its transactions';
			case 'account.delete.success': return 'Account deleted successfully';
			case 'account.select.one': return 'Select an account';
			case 'account.select.all': return 'All accounts';
			case 'account.select.multiple': return 'Select accounts';
			case 'currencies.currency_converter': return 'Currency converter';
			case 'currencies.select_a_currency': return 'Select a currency';
			case 'currencies.search_placeholder': return 'Search by currency name, code...';
			case 'currencies.days_without_update': return ({required Object X}) => 'Exchange rates last updated ${X} day(s) ago';
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
			case 'categories.make_child_warning1': return ({required Object Destiny}) => 'This category and its subcategories will become subcategories of <b>${Destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object X, required Object Destiny}) => 'Their transactions <b>(${X})</b> will be moved to the new subcategories created within the <b>${Destiny}</b> category.';
			case 'categories.make_child_success': return 'Subcategories created successfully';
			case 'categories.merge': return 'Merge with another category';
			case 'categories.merge_warning1': return ({required Object X, required Object From, required Object Destiny}) => 'All transactions (<b>${X}</b>) associated with the category <b>${From}</b> will be moved to the category <b>${Destiny}</b>.';
			case 'categories.merge_warning2': return ({required Object From}) => 'The category <b>${From}</b> will be irreversibly deleted.';
			case 'categories.merge_success': return 'Category merged successfully';
			case 'categories.delete_success': return 'Category deleted correctly';
			case 'categories.delete_warning_header': return 'Delete category?';
			case 'categories.delete_warning_message': return ({required Object X}) => 'This action will irreversibly delete all transactions <b>(${X})</b> related to this category.';
			case 'categories.select.title': return 'Select categories';
			case 'categories.select.select_all': return 'Select all';
			case 'categories.select.select_one': return 'Select a category';
			case 'categories.select.select_subcategory': return 'Choose a subcategory';
			case 'categories.select.without_subcategory': return 'Without subcategory';
			case 'categories.select.all': return 'All categories';
			case 'budgets.title': return 'Budgets';
			case 'budgets.repeated': return 'Recurring';
			case 'budgets.one_time': return 'Once';
			case 'budgets.annual': return 'Annuals';
			case 'budgets.week': return 'Weekly';
			case 'budgets.month': return 'Monthly';
			case 'budgets.actives': return 'Actives';
			case 'budgets.pending': return 'Pending start';
			case 'budgets.finish': return 'Finished';
			case 'budgets.to_expend': return 'to spend';
			case 'budgets.days_left': return 'days left';
			case 'budgets.days_to_start': return 'days to start';
			case 'budgets.since_expiration': return 'days since expiration';
			case 'budgets.no_budgets': return 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';
			case 'budgets.delete': return 'Delete budget';
			case 'budgets.delete_warning': return 'This action is irreversible. Categories and transactions referring to this quote will not be deleted';
			case 'budgets.form.title': return 'Add a budget';
			case 'budgets.form.name': return 'Budget name';
			case 'budgets.form.value': return 'Limit quantity';
			case 'budgets.form.repetition': return 'Repetition';
			case 'budgets.form.create': return 'Add budget';
			case 'budgets.form.edit': return 'Edit budget';
			case 'budgets.details.title': return 'Budget Details';
			case 'budgets.details.budget_value': return 'Budget';
			case 'budgets.details.statistics': return 'Statistics';
			case 'budgets.details.you_already_expend': return 'You have already spent the';
			case 'budgets.details.budget_exceeded_for': return 'You have exceeded budget by';
			case 'budgets.details.of_the_budget': return 'of the budget';
			case 'budgets.details.expend_diary_left': return 'Remaining daily spend';
			case 'budgets.details.expend_evolution': return 'Expenditure evolution';
			case 'budgets.details.no_transactions': return 'It seems that you have not made any expenses related to this budget';
			case 'go_premium.title': return 'Choose a plan';
			case 'go_premium.description': return 'Check the benefits of all our premium plans. Choose one and cancel whenever you want.';
			case 'go_premium.accounts_limit': return 'Maximum number of accounts';
			case 'go_premium.budgets_limit': return 'Maximum number of budgets';
			case 'go_premium.recurring_transactions_limit': return 'Recurring transactions allowed';
			case 'go_premium.rate_update_frequency': return 'Exchange rates update frequency';
			case 'go_premium.support': return 'Support the developer';
			case 'go_premium.anual_price': return 'Anual price';
			case 'go_premium.monthly_price': return 'Mensual price';
			case 'go_premium.change_plan': return 'To change plans you must first cancel previous subscriptions and wait for them to expire';
			case 'go_premium.return_to_free': return 'To return to the free plan cancel the subscriptions you currently have active';
			case 'go_premium.current_plan': return 'This is your current plan. You can cancel without obligation at any time';
			case 'go_premium.current_free_plan': return 'You are here on the basic plan right now';
			case 'go_premium.admin_subscriptions': return 'Manage subscriptions';
			case 'backup.export.title': return 'Export your data';
			case 'backup.export.title_sort': return 'Export';
			case 'backup.export.all': return 'Full backup';
			case 'backup.export.all_descr': return 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';
			case 'backup.export.transactions': return 'Transactions backup';
			case 'backup.export.transactions_descr': return 'Export your transactions in various formats so you can more easily analyze them in other programs or applications.';
			case 'backup.export.description': return 'Keep a backup of all your accounts, budgets, transactions, settings...';
			case 'backup.export.dialog_title': return 'Save/Send file';
			case 'backup.export.success_in_documents': return 'File successfully saved to Internal Storage/Documents';
			case 'backup.export.success_in_data': return 'File saved/downloaded successfully';
			case 'backup.export.error': return 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
			case 'backup.import.title': return 'Import your data';
			case 'backup.import.title_sort': return 'Import';
			case 'backup.import.upload_file': return 'Upload your data file';
			case 'backup.import.touch_to_import': return 'Touch to import';
			case 'backup.import.touch_to_change': return 'Touch to change';
			case 'backup.import.onboarding_done': return 'Backup uploaded';
			case 'backup.import.file': return 'Import file';
			case 'backup.import.description': return 'Replace all data currently in the app with data you have previously saved';
			case 'backup.import.long_description': return 'If you have already used our application before, you may have a backup saved on your device with the name Monekin_backup_YYYY_MM_DD. If you prefer, you can perform this data import later.';
			case 'backup.import.success': return 'Import performed successfully';
			case 'backup.import.error': return 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
			case 'backup.guide.title': return 'Guide on how to import/export your data';
			case 'backup.guide.title_short': return 'Import/Export data';
			case 'backup.guide.message0': return 'So that you can recover your data if you uninstall the application, change your mobile or if they are lost by accident, it is recommended to export them from time to time. Thanks to this export you will be able to recover these data at any time in this window.';
			case 'backup.guide.message1': return 'To export your data press the \'Export data\' box. A dialog should immediately open for you to select where you want to save your data. It is recommended to save it directly to your device\'s storage, although any other option like saving it in Google Drive or send it by mail is also perfectly valid.';
			case 'backup.guide.message2': return 'Once you choose where to save/send your data, Monekin will save a file with all your information (transactions, budgets, categories, adjustments...). Absolutely everything will be saved in a JSON type file, with the name \'Monekin_backup_YEAR_MONTH_DAY\',';
			case 'backup.guide.message3': return 'Now you can recover your data at any time by selecting the \'Import data\' option. When you press the box, you will have to search for the file that you previously exported. Once you have selected all your data that you have in that file, they will be loaded into our app .';
			case 'backup.guide.message4': return 'When performing the data import, all the current data that the application has will be deleted and replaced by the new ones that you import.';
			case 'settings.title': return 'Settings';
			case 'settings.edit_profile': return 'Edit profile';
			case 'settings.display_name': return 'User name';
			case 'settings.lang': return 'Language';
			case 'settings.lang_descr': return 'Language in which the texts will be displayed in the app';
			case 'settings.locale': return 'Region';
			case 'settings.locale_descr': return 'Set the format to use for dates, numbers...';
			case 'settings.locale_warn': return 'When changing region the app will update';
			case 'settings.first_day_of_week': return 'First day of week';
			case 'settings.general.display': return 'General settings';
			case 'settings.general.currency': return 'Default currency';
			case 'settings.general.categories_descr': return 'Create and edit categories to your liking';
			case 'settings.general.other': return 'Advanced settings';
			case 'settings.general.other_descr': return 'Other general app customization settings';
			case 'settings.data.display': return 'Data';
			case 'settings.data.export_descr': return 'Download your data in different formats';
			case 'settings.data.import': return 'Restore Backup';
			case 'settings.data.import_descr': return 'Upload a .JSON file, and replace all your current data with the new one';
			case 'settings.data.delete_all': return 'Delete my data';
			case 'settings.data.delete_all_header1': return 'Stop right there padawan ⚠️⚠️';
			case 'settings.data.delete_all_message1': return 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';
			case 'settings.data.delete_all_header2': return 'One last step ⚠️⚠️';
			case 'settings.data.delete_all_message2': return 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
			case 'settings.project.display': return 'Project';
			case 'settings.project.legal': return 'Terms and privacy';
			case 'settings.project.legal_descr': return 'Check licenses and other legal terms of our app';
			case 'settings.project.contributors': return 'Collaborators';
			case 'settings.project.contributors_descr': return 'All the developers who have made Monekin grow';
			case 'settings.project.contact': return 'Contact us';
			case 'settings.help_us.display': return 'Help us';
			case 'settings.help_us.rate_us': return 'Rate us';
			case 'settings.help_us.rate_us_descr': return 'Any rate is welcome!';
			case 'settings.help_us.share': return 'Share Monekin';
			case 'settings.help_us.share_text': return 'Monekin! The best personal finance app';
			case 'settings.help_us.report': return 'Report bugs, leave suggestions...';
			case 'settings.licenses.title': return 'Licenses';
			case 'settings.licenses.footer': return '<p>To build trust in us and help grow the app and its security, this project is 100% open source and 100% free. Anyone can see how it works inside and how data is stored Anyone can fix bugs, develop new features, etc.</p><p>Click <a href=\'https://github.com/enrique-lozano/Monekin\'>here</a> to see the application code and other useful information.</p>';
			case 'settings.licenses.start': return 'All content in this application, such as icons, fonts and other libraries, has been legally obtained. External code libraries have been downloaded and used via the npm package manager. Also, the project is open source and anyone can contribute to it.';
			case 'settings.licenses.icons': return 'Icons';
			case 'settings.licenses.fonts': return 'Typefaces & Fonts';
			case 'settings.licenses.text1': return 'The icons of this app have been extracted from';
			case 'settings.licenses.text2': return 'We should mention the following authors:';
			case 'settings.licenses.text3': return 'A special mention should be made to the <a href=\'https://www.flaticon.com/packs/avatars-90?style_id=688&family_id=71&group_id=232\'>Vitaly Gorbachev avatar pack</a>, thanks to which you can configure your profile picture.';
			case 'settings.privacy.title': return 'Privacy policy';
			case 'settings.terms_of_use.title': return 'Terms of use';
			case 'lang.es': return 'Spanish';
			case 'lang.en': return 'English';
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
			case 'general.confirm': return 'Confirmar';
			case 'general.add': return 'Añadir';
			case 'general.edit': return 'Editar';
			case 'general.delete': return 'Eliminar';
			case 'general.income': return 'Ingreso';
			case 'general.expense': return 'Gasto';
			case 'general.incomes': return 'Ingresos';
			case 'general.expenses': return 'Gastos';
			case 'general.expenses_and_incomes': return 'Gastos e ingresos';
			case 'general.account': return 'Cuenta';
			case 'general.accounts': return 'Cuentas';
			case 'general.categories': return 'Categorías';
			case 'general.category': return 'Categoría';
			case 'general.transaction': return 'Transacción';
			case 'general.transactions': return 'Transacciones';
			case 'general.store_limit': return 'Almacenamiento máximo de la app alcanzado. Acción cancelada';
			case 'general.today': return 'Hoy';
			case 'general.yesterday': return 'Ayer';
			case 'general.filters': return 'Filtros';
			case 'general.clipboard.success': return ({required Object X}) => '${X} copiado al portapapeles';
			case 'general.clipboard.error': return 'Error al copiar';
			case 'general.time.range': return 'Rango temporal';
			case 'general.time.diary': return 'Diaría';
			case 'general.time.monthly': return 'Mensual';
			case 'general.time.annualy': return 'Anual';
			case 'general.time.quaterly': return 'Trimestral';
			case 'general.time.weekly': return 'Semanal';
			case 'general.time.custom': return 'Personalizado';
			case 'general.time.infinite': return 'Siempre';
			case 'general.time.start_date': return 'Fecha de inicio';
			case 'general.time.end_date': return 'Fecha de fin';
			case 'general.time.no_repeat': return 'Sin repetición';
			case 'general.time.periodicity': return 'Periodicidad';
			case 'general.time.current.monthly': return 'Este mes';
			case 'general.time.current.annualy': return 'Este año';
			case 'general.time.current.quaterly': return 'Este trimestre';
			case 'general.time.current.weekly': return 'Esta semana';
			case 'general.time.current.infinite': return 'Desde siempre';
			case 'general.time.current.custom': return 'Rango personalizado';
			case 'general.transaction_order.display': return 'Ordenar transacciones';
			case 'general.transaction_order.category': return 'Por categoría';
			case 'general.transaction_order.quantity': return 'Por cantidad';
			case 'general.transaction_order.date': return 'Por fecha';
			case 'general.validations.required': return 'Campo obligatorio';
			case 'intro.start': return 'Empecemos';
			case 'intro.skip': return 'Saltar';
			case 'intro.next': return 'Siguiente';
			case 'intro.select_your_currency': return 'Selecciona tu divisa';
			case 'intro.welcome': return 'Bienvenido a Monekin';
			case 'intro.welcome_subtitle': return 'Tu gestor de finanzas personales';
			case 'intro.welcome_footer': return '<p>Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación</p>';
			case 'intro.offline_descr': return '<strong>CUENTA SIN CONEXIÓN:</strong><br> Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
			case 'intro.offline_start': return 'Iniciar sesión offline';
			case 'intro.sl1_title': return 'Selecciona tu divisa';
			case 'intro.sl1_descr': return 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
			case 'intro.sl2_title': return 'Seguro, privado y confiable';
			case 'intro.sl2_descr': return 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
			case 'intro.sl2_descr2': return 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
			case 'intro.last_slide_title': return 'Todo listo!';
			case 'intro.last_slide_descr': return 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
			case 'intro.last_slide_descr2': return 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
			case 'tabs.filter_transactions': return 'Filtrar transacciones';
			case 'tabs.should_create_account_header': return 'Ops!';
			case 'tabs.should_create_account_message': return 'Debes crear una cuenta antes de empezar a crear transacciones';
			case 'tabs.tab1.title': return 'Home';
			case 'tabs.tab1.hello_day': return 'Buenos días,';
			case 'tabs.tab1.hello_night': return 'Buenas noches,';
			case 'tabs.tab1.total_balance': return 'Saldo total';
			case 'tabs.tab1.my_accounts': return 'Mis cuentas';
			case 'tabs.tab1.tools': return 'Herramientas';
			case 'tabs.tab1.important_expenses': return 'Gastos mas grandes';
			case 'tabs.tab1.empty_expenses': return 'Parece que aun no tienes transacciones para este periodo. Añade una pulsando el botón \'+\' de la parte inferior';
			case 'tabs.tab1.account_resume.link': return 'Ver todas';
			case 'tabs.tab1.account_resume.display': return 'Resumen de cuentas';
			case 'tabs.tab1.account_resume.balance_by_account': return 'Saldo por cuentas';
			case 'tabs.tab1.account_resume.balance_by_currency': return 'Saldo por divisas';
			case 'tabs.tab2.title': return 'Transacciones';
			case 'tabs.tab2.balance': return 'Balance';
			case 'tabs.tab2.empty': return 'No se han encontrado transacciones que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
			case 'tabs.tab2.searcher_placeholder': return 'Busca por categoría, descripción...';
			case 'tabs.tab2.loading': return 'Cargando más transacciones...';
			case 'tabs.tab3.title': return 'Análisis';
			case 'tabs.tab3.without_subcat': return 'Otro - ';
			case 'tabs.tab3.average_by_transaction': return 'Medía/transacción';
			case 'tabs.tab3.average_by_day': return 'Medía/día';
			case 'tabs.tab3.balance': return 'Balance final';
			case 'tabs.tab3.balance_by_period': return 'Balance medio/periodo';
			case 'tabs.tab3.cash_flow': return 'Flujo de caja';
			case 'tabs.tab3.balance_evolution': return 'Evolución de fondos';
			case 'financial_health.display': return 'Salud financiera';
			case 'financial_health.review.very_good': return 'Muy buena!';
			case 'financial_health.review.good': return 'Buena';
			case 'financial_health.review.normal': return 'En la media';
			case 'financial_health.review.bad': return 'Regular';
			case 'financial_health.review.very_bad': return 'Muy mala';
			case 'financial_health.review.descr.very_good': return 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
			case 'financial_health.review.descr.good': return 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
			case 'financial_health.review.descr.normal': return 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
			case 'financial_health.review.descr.bad': return 'Parece que tu situación financiera no es la mejor aun. Explora la pestaña de análisis para conocer mas sobre tus finanzas';
			case 'financial_health.review.descr.very_bad': return 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema en la sección de análisis';
			case 'financial_health.months_without_income.good': return ({required Object X}) => 'Bien hecho! Con tu ritmo de gastos actual ahora mismo podrías sobrevivir hasta ${X} meses sin ningún ingreso';
			case 'financial_health.months_without_income.normal': return ({required Object X}) => 'Con tu ritmo de gastos actual ahora mismo podrías sobrevivir hasta ${X} meses sin ningún ingreso. Si bien este valor es aceptable, aun puedes mejorar un poco más!';
			case 'financial_health.months_without_income.bad': return ({required Object X}) => 'Vaya! Apenás sobrevivirías ${X} meses sin ingresos con tu ritmo de gastos actual. Recuerda que lo recomendable es poder vivir al menos 6 meses sin ningun ingreso';
			case 'financial_health.months_without_income.very_bad': return 'Vaya! Apenas sobrevivirías un mes sin ingresos con tu ritmo de gastos actual. Recuerda que lo recomendable es poder vivir al menos 6 meses sin ningun ingreso';
			case 'financial_health.months_without_income.insufficient_data': return 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
			case 'financial_health.savings_percentage.good': return ({required Object Value}) => 'Enhorabuena! Has conseguido ahorrar un ${Value}% de tus ingresos durante este periodo. Parece que ya eres todo un expert@. Sigue asi!';
			case 'financial_health.savings_percentage.normal': return ({required Object Value}) => 'Enhorabuena, has conseguido ahorrar un ${Value}% de tus ingresos durante este periodo. Visita la pestaña de análisis para ver donde puedes ahorrar aun más!';
			case 'financial_health.savings_percentage.bad': return ({required Object Value}) => 'Has conseguido ahorrar un ${Value}% de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas! Recuerda que es recomendable ahorrar al menos un 30% de lo que ingresas';
			case 'financial_health.savings_percentage.very_bad': return 'Vaya, no has conseguido ahorrar nada durante este periodo :( Visita la pestaña de análisis para ver donde estan tus debilidades financieras. Recuerda que es recomendable ahorrar al menos un 30% de lo que ingresas';
			case 'icon_selector.name': return 'Nombre:';
			case 'icon_selector.icon': return 'Icono';
			case 'icon_selector.color': return 'Color';
			case 'icon_selector.select_icon': return 'Selecciona un icono';
			case 'icon_selector.add_subcategory': return 'Añadir subcategoría';
			case 'icon_selector.edit_subcategory': return 'Editar subcategoría';
			case 'transaction.create': return 'Nueva transacción';
			case 'transaction.new_income': return 'Nuevo ingreso';
			case 'transaction.new_expense': return 'Nuevo gasto';
			case 'transaction.new_success': return 'Transacción creada correctamente';
			case 'transaction.edit': return 'Editar transacción';
			case 'transaction.edit_success': return 'Transacción editada correctamente';
			case 'transaction.duplicate': return 'Clonar transacción';
			case 'transaction.duplicate_success': return 'Transacción clonada con exito';
			case 'transaction.delete': return 'Eliminar transacción';
			case 'transaction.delete_warning_message': return 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
			case 'transaction.delete_success': return 'Transacción eliminada correctamente';
			case 'transaction.form.description': return 'Descripción';
			case 'transaction.form.description_info': return 'Añadir una nota te ayudará a encontrar mas rapidamente esta transacción en un futuro';
			case 'transaction.form.description_add': return 'Añade una nota';
			case 'transaction.form.without_category': return 'Sin especificar';
			case 'transaction.form.exchange_to_preferred': return ({required Object X}) => 'Actualmente equivalen aproximadamente a ${X}';
			case 'transfer.display': return 'Transferencia';
			case 'transfer.from_to_text': return ({required Object X, required Object Y}) => 'Desde ${X} hasta ${Y}';
			case 'transfer.create': return 'Nueva transferencia';
			case 'transfer.edit': return 'Editar transferencia';
			case 'transfer.delete': return 'Eliminar transferencia';
			case 'transfer.delete_warning_message': return 'Esta acción es irreversible';
			case 'transfer.delete_success': return 'Transferencia eliminada correctamente';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
			case 'transfer.form.from': return 'Cuenta origen';
			case 'transfer.form.to': return 'Cuenta destino';
			case 'transfer.form.currency_info_add': return ({required Object X}) => 'Se transpasarán ${X} a la cuenta de destino &#183; Pulsa para editar';
			case 'transfer.form.currency_info_edit': return ({required Object X}) => 'Se han transpasado ${X} a la cuenta de destino &#183; Pulsa para editar';
			case 'transfer.form.currency_exchange_selector.title': return 'Editar cambio entre divisas';
			case 'transfer.form.currency_exchange_selector.exchange_rate': return 'Tipo de cambio';
			case 'transfer.form.currency_exchange_selector.value_in_destiny': return 'Cantidad transferida en destino';
			case 'recurrent_transactions.title': return 'Movimientos recurrentes';
			case 'recurrent_transactions.empty': return 'Parece que no posees ninguna transacción que se repita periodicamente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
			case 'recurrent_transactions.balance': return 'Balance total';
			case 'recurrent_transactions.details.title': return 'Detalles del movimiento';
			case 'recurrent_transactions.details.each_week': return 'Cada semana';
			case 'recurrent_transactions.details.each_month': return 'Cada mes';
			case 'recurrent_transactions.details.each_year': return 'Cada año';
			case 'recurrent_transactions.details.start_date': return 'Primer movimiento';
			case 'recurrent_transactions.details.balance_expense': return 'Pagado hasta ahora';
			case 'recurrent_transactions.details.balance_income': return 'Ingresado hasta ahora';
			case 'recurrent_transactions.details.end_date': return 'Fecha de finalización';
			case 'recurrent_transactions.details.pause_header': return 'Pausar pagos';
			case 'recurrent_transactions.details.pause_message': return 'Con esta acción se dará por finalizada esta transacción hoy, y no se produciran mas pagos a partir de ahora. Pagos previos al día de hoy no serán eliminados del balance';
			case 'recurrent_transactions.details.pause_correctly': return 'Transacción pausada correctamente';
			case 'recurrent_transactions.details.delete_header': return 'Eliminar pagos';
			case 'recurrent_transactions.details.delete_message': return 'Esta acción es irreversible y borrara todos tus pagos del balance';
			case 'recurrent_transactions.details.delete_success': return 'Transacciones eliminadas correctamente';
			case 'recurrent_transactions.selector.title': return '¿Cómo se repite su transacción?';
			case 'recurrent_transactions.selector.until': return 'Hasta';
			case 'recurrent_transactions.selector.infinite': return 'El infinito';
			case 'recurrent_transactions.selector.date': return 'Una fecha';
			case 'account.date': return 'Fecha de creación';
			case 'account.balance': return 'Saldo de la cuenta';
			case 'account.n_transactions': return 'Número de transacciones';
			case 'account.add_money': return 'Añadir dinero';
			case 'account.withdraw_money': return 'Retirar dinero';
			case 'account.types.title': return 'Tipo de cuenta';
			case 'account.types.warning': return 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
			case 'account.types.normal': return 'Cuenta corriente';
			case 'account.types.normal_descr': return 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
			case 'account.types.saving': return 'Cuenta de ahorros';
			case 'account.types.saving_descr': return 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
			case 'account.form.name': return 'Nombre de la cuenta';
			case 'account.form.name_placeholder': return 'Ej: Cuenta de ahorros';
			case 'account.form.description': return 'Descripción';
			case 'account.form.initial_balance': return 'Balance inicial';
			case 'account.form.current_balance': return 'Balance actual';
			case 'account.form.create': return 'Crear cuenta';
			case 'account.form.edit': return 'Editar cuenta';
			case 'account.form.already_exists': return 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
			case 'account.form.users': return 'Usuarios de la cuenta';
			case 'account.form.admin': return 'Administrador';
			case 'account.form.collaborator': return 'Colaborador';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.share.title': return 'Compartir esta cuenta';
			case 'account.share.title_short': return 'Compartir';
			case 'account.share.description': return 'Introduce el ID del usuario en cuestión para compartir esta cuenta. El usuario podrá ver, añadir, editar o modificar todas las transacciones de esta cuenta';
			case 'account.share.correct': return 'Cuenta compartida correctamente';
			case 'account.delete.warning_header': return '¿Estas seguro?';
			case 'account.delete.warning_text': return 'Esta acción borrara esta cuenta y todas sus transacciones';
			case 'account.delete.success': return 'Cuenta eliminada correctamente';
			case 'account.select.one': return 'Selecciona una cuenta';
			case 'account.select.multiple': return 'Selecciona cuentas';
			case 'account.select.all': return 'Todas las cuentas';
			case 'currencies.currency_converter': return 'Conversor de divisas';
			case 'currencies.select_a_currency': return 'Selecciona una divisa';
			case 'currencies.search_placeholder': return 'Busca por nombre o por código de la divisa';
			case 'currencies.days_without_update': return ({required Object X}) => 'Tipos de cambio actualizados por última vez hace ${X} día(s)';
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
			case 'categories.make_child_warning1': return ({required Object Destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${Destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object X, required Object Destiny}) => 'Sus transacciones <b>(${X})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${Destiny}</b>.';
			case 'categories.make_child_success': return 'Subcategorías creadas con exito';
			case 'categories.merge': return 'Fusionar con otra categoría';
			case 'categories.merge_warning1': return ({required Object X, required Object From, required Object Destiny}) => 'Todas las transacciones (<b>${X}</b>) asocidadas con la categoría <b>${From}</b> serán movidas a la categoría <b>${Destiny}</b>.';
			case 'categories.merge_warning2': return ({required Object From}) => 'La categoría <b>${From}</b> será eliminada de forma irreversible.';
			case 'categories.merge_success': return 'Categoría fusionada correctamente';
			case 'categories.delete_success': return 'Categoría eliminada correctamente';
			case 'categories.delete_warning_header': return '¿Eliminar categoría?';
			case 'categories.delete_warning_message': return ({required Object X}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${X})</b> relativas a esta categoría.';
			case 'categories.select.title': return 'Selecciona categorías';
			case 'categories.select.select_all': return 'Seleccionar todas';
			case 'categories.select.select_one': return 'Selecciona una categoría';
			case 'categories.select.select_subcategory': return 'Elige una subcategoría';
			case 'categories.select.without_subcategory': return 'Sin subcategoría';
			case 'categories.select.all': return 'Todas las categorías';
			case 'budgets.title': return 'Presupuestos';
			case 'budgets.repeated': return 'Periódicos';
			case 'budgets.one_time': return 'Una vez';
			case 'budgets.anual': return 'Anuales';
			case 'budgets.week': return 'Semanales';
			case 'budgets.month': return 'Mensuales';
			case 'budgets.actives': return 'Activos';
			case 'budgets.pending': return 'Pendientes de comenzar';
			case 'budgets.finish': return 'Finalizados';
			case 'budgets.to_expend': return 'por gastar';
			case 'budgets.days_left': return 'días restantes';
			case 'budgets.days_to_start': return 'días para empezar';
			case 'budgets.since_expiration': return 'días desde su expiración';
			case 'budgets.no_budgets': return 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
			case 'budgets.delete': return 'Eliminar presupuesto';
			case 'budgets.delete_warning': return 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
			case 'budgets.form.title': return 'Añade un presupuesto';
			case 'budgets.form.name': return 'Nombre del presupuesto';
			case 'budgets.form.value': return 'Cantidad límite';
			case 'budgets.form.repetition': return 'Repetición';
			case 'budgets.form.create': return 'Añade el presupuesto';
			case 'budgets.form.edit': return 'Editar presupuesto';
			case 'budgets.details.title': return 'Detalles del presupuesto';
			case 'budgets.details.budget_value': return 'Presupuestado';
			case 'budgets.details.statistics': return 'Estadísticas';
			case 'budgets.details.you_already_expend': return 'Ya has gastado el';
			case 'budgets.details.budget_exceeded_for': return 'Has sobrepasado el presupuesto en';
			case 'budgets.details.of_the_budget': return 'del presupuesto';
			case 'budgets.details.expend_diary_left': return 'Gasto diario restante';
			case 'budgets.details.expend_evolution': return 'Evolución del gasto';
			case 'budgets.details.no_transactions': return 'Parece que no has realizado ningún gasto relativo a este presupuesto';
			case 'go_premium.title': return 'Elige un plan';
			case 'go_premium.description': return 'Consulta las ventajas de todos nuestros planes premium. Elige uno y cancela cuando quieras.';
			case 'go_premium.accounts_limit': return 'Número máximo de cuentas';
			case 'go_premium.budgets_limit': return 'Número máximo de presupuestos';
			case 'go_premium.recurring_transactions_limit': return 'Transacciones recurrentes permitidas';
			case 'go_premium.rate_update_frequency': return 'Frecuencia de actualización de los tipos de cambio';
			case 'go_premium.support': return 'Apoyo al desarrollador';
			case 'go_premium.anual_price': return 'Precio al año';
			case 'go_premium.monthly_price': return 'Precio al mes';
			case 'go_premium.change_plan': return 'Para cambiar de plan primero has de cancelar anteriores subscripciones y esperar a que estas expiren';
			case 'go_premium.return_to_free': return 'Para volver al plan gratuito anula las subscripciones que tengas actualmente activas';
			case 'go_premium.current_plan': return 'Este es tu plan actual. Puedes cancelarlo sin compromiso en cualquier momento';
			case 'go_premium.current_free_plan': return 'Ahora mismo te encuentras aquí, en el plan básico';
			case 'go_premium.admin_subscriptions': return 'Administrar subscripciones';
			case 'backup.export.title': return 'Exportar datos';
			case 'backup.export.title_sort': return 'Exportar';
			case 'backup.export.all': return 'Respaldo total';
			case 'backup.export.all_descr': return 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
			case 'backup.export.transactions': return 'Respaldo de transacciones';
			case 'backup.export.transactions_descr': return 'Exporta tus transacciones en diversos formatos para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
			case 'backup.export.description': return 'Guarda una copia de seguridad de todas tus cuentas, presupuestos, transacciones, ajustes...';
			case 'backup.export.dialog_title': return 'Guardar/Enviar archivo';
			case 'backup.export.success_in_documents': return 'Archivo guardado correctamente en Almacenamiento interno/Documents';
			case 'backup.export.success_in_data': return 'Archivo guardado/enviado correctamente';
			case 'backup.export.error': return 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
			case 'backup.import.title': return 'Importar tus datos';
			case 'backup.import.upload_file': return 'Sube tu archivo de datos';
			case 'backup.import.touch_to_import': return 'Toca para importar';
			case 'backup.import.touch_to_change': return 'Toca para cambiar';
			case 'backup.import.onboarding_done': return 'Copia de seguridad subida';
			case 'backup.import.file': return 'Importar archivo';
			case 'backup.import.description': return 'Reemplaza todos los datos que hay actualmente en la app por otros que hayas guardado previamente';
			case 'backup.import.long_description': return 'Si ya has usado nuestra aplicación antes puede que tengas una copia de seguridad guardada en tu disposivo con el nombre Monekin_backup_YYYY_MM_DD. Si prefieres puedes realizar esta importación de datos mas adelante.';
			case 'backup.import.success': return 'Importación realizada con exito';
			case 'backup.import.error': return 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
			case 'backup.guide.title': return 'Guía de como importar/exportar sus datos';
			case 'backup.guide.title_short': return 'Importar/Exportar datos';
			case 'backup.guide.message0': return 'Para que puedas recuperar tus datos si desinstalas la aplicación, cambias de movil o estos son perdidos por accidente, se recomienda exportarlos cada cierto tiempo. Gracias a esta exportación podrás recuperar estos datos en cualquier momento en esta ventana.';
			case 'backup.guide.message1': return 'Para exportar tus datos pulsa el cuadro de \'Exportar datos\'. Inmediatamente se debería abrir un dialogo para que selecciones donde quieres guardar tus datos. Se recomienda guardarlos directamente en el almacenamineto de tu dispositvo, aunque cualquier otra opción como guardarlo en Google Drive o enviarlo por mail también es perfectamente valida.';
			case 'backup.guide.message2': return 'Una vez elijas donde guardar/enviar tus datos, Monekin guardará un fichero con toda tu información (transacciones, presupuestos, categorías, ajustes...). Absolutamnete todo será guardado en un fichero de tipo JSON, con el nombre \'Monekin_backup_AÑO_MES_DIA\',';
			case 'backup.guide.message3': return 'Ahora podrás recuperar tus datos en cualquier momento seleccionando la opción \'Importar datos\'. Al pulsar el cuadro, deberás buscar el fichero que exportaste previamente. Una vez seleccionado todos tus datos que teneis en ese fichero se cargaran en nuestra app.';
			case 'backup.guide.message4': return 'Al realizar la importación de datos, todos los datos actuales que tiene la aplicación serán borrados y reemplazados por los nuevos que importes.';
			case 'settings.title': return 'Ajustes';
			case 'settings.edit_profile': return 'Editar perfil';
			case 'settings.display_name': return 'Nombre de usuario';
			case 'settings.lang': return 'Idioma';
			case 'settings.lang_descr': return 'Idioma en el que se mostrarán los textos en la app';
			case 'settings.locale': return 'Región';
			case 'settings.locale_descr': return 'Establece el formato a usar para fechas, números...';
			case 'settings.locale_warn': return 'Al cambiar de región la app se refrescará';
			case 'settings.first_day_of_week': return 'Primer día de la semana';
			case 'settings.general.display': return 'Ajustes generales';
			case 'settings.general.currency': return 'Divisa predeterminada';
			case 'settings.general.categories_descr': return 'Crea y edita categorías a tu gusto';
			case 'settings.general.other': return 'Ajustes avanzados';
			case 'settings.general.other_descr': return 'Otros ajustes generales de personalización de la app';
			case 'settings.data.display': return 'Datos';
			case 'settings.data.export_descr': return 'Descarga tus datos en diferentes formatos';
			case 'settings.data.import': return 'Restaurar copia de seguridad';
			case 'settings.data.import_descr': return 'Sube un fichero .JSON, y reemplaza todos tus datos actuales por los nuevos';
			case 'settings.data.delete_all': return 'Eliminar mis datos';
			case 'settings.data.delete_all_header1': return 'Alto ahí padawan ⚠️⚠️';
			case 'settings.data.delete_all_message1': return '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
			case 'settings.data.delete_all_header2': return 'Un último paso ⚠️⚠️';
			case 'settings.data.delete_all_message2': return 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
			case 'settings.project.display': return 'Proyecto';
			case 'settings.project.legal': return 'Términos y privacidad';
			case 'settings.project.legal_descr': return 'Revisa licencias y otros terminos legales de nuestra app';
			case 'settings.project.contributors': return 'Colaboradores';
			case 'settings.project.contributors_descr': return 'Todos los desarrolladores que han hecho que Monekin crezca';
			case 'settings.project.contact': return 'Contacta con nosotros';
			case 'settings.help_us.display': return 'Ayúdanos';
			case 'settings.help_us.rate_us': return 'Califícanos';
			case 'settings.help_us.rate_us_descr': return '¡Cualquier valoración es bienvenida!';
			case 'settings.help_us.share': return 'Comparte Monekin';
			case 'settings.help_us.share_text': return 'Monekin! La mejor app de finanzas personales';
			case 'settings.help_us.report': return 'Reporta errores, deja sugerencias...';
			case 'settings.licenses.title': return 'Licencias';
			case 'settings.licenses.start': return 'Todo el contenido de esta aplicación, como íconos, fuentes y otras bibliotecas, se ha obtenido legalmente. Se han descargado y utilizado bibliotecas de códigos externos a través del administrador de paquetes npm. Además, el proyecto es de código abierto y cualquiera puede colaborar en el.';
			case 'settings.licenses.footer': return '<p>Para generar confianza en nosotros y ayudar al crecimiento de la aplicación y su seguridad, este proyecto es 100 % de código abierto y 100 % gratuito. Cualquiera puede ver cómo funciona por dentro y cómo se almacenan los datos de los usuarios. Cualquiera puede solucionar errores, desarrollar nuevas funcionalidades, etc.</p><p>Pincha <a href=\'https://github.com/enrique-lozano/Monekin\'>aquí</a> para ver el código de la aplicación y más información de interés.</p>';
			case 'settings.licenses.icons': return 'Iconos';
			case 'settings.licenses.fonts': return 'Tipografías & Fuentes';
			case 'settings.licenses.text1': return 'Los iconos usados en esta aplicación han sido extraidos desde';
			case 'settings.licenses.text2': return 'Hemos de destacar a los siguientes autores:';
			case 'settings.licenses.text3': return 'Hemos de hacer mención especial al <a href=\'https://www.flaticon.com/packs/avatars-90?style_id=688&family_id=71&group_id=232\'>paquete de avatares de Vitaly Gorbachev</a>, gracias al cual podeis configurar vuestra imagen de perfil.';
			case 'settings.privacy.title': return 'Política de privacidad';
			case 'settings.terms_of_use.title': return 'Términos de uso';
			case 'lang.es': return 'Español';
			case 'lang.en': return 'Inglés';
			default: return null;
		}
	}
}

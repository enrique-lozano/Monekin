///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsUiActionsEn ui_actions = TranslationsUiActionsEn._(_root);
	late final TranslationsGeneralEn general = TranslationsGeneralEn._(_root);
	late final TranslationsIntroEn intro = TranslationsIntroEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsFinancialHealthEn financial_health = TranslationsFinancialHealthEn._(_root);
	late final TranslationsStatsEn stats = TranslationsStatsEn._(_root);
	late final TranslationsIconSelectorEn icon_selector = TranslationsIconSelectorEn._(_root);
	late final TranslationsTransactionEn transaction = TranslationsTransactionEn._(_root);
	late final TranslationsTransferEn transfer = TranslationsTransferEn._(_root);
	late final TranslationsRecurrentTransactionsEn recurrent_transactions = TranslationsRecurrentTransactionsEn._(_root);
	late final TranslationsAccountEn account = TranslationsAccountEn._(_root);
	late final TranslationsCurrenciesEn currencies = TranslationsCurrenciesEn._(_root);
	late final TranslationsTagsEn tags = TranslationsTagsEn._(_root);
	late final TranslationsCategoriesEn categories = TranslationsCategoriesEn._(_root);
	late final TranslationsBudgetsEn budgets = TranslationsBudgetsEn._(_root);
	late final TranslationsTargetTimelineStatusesEn target_timeline_statuses = TranslationsTargetTimelineStatusesEn._(_root);
	late final TranslationsBackupEn backup = TranslationsBackupEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsMoreEn more = TranslationsMoreEn._(_root);
}

// Path: ui_actions
class TranslationsUiActionsEn {
	TranslationsUiActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Continue'
	String get continue_text => 'Continue';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Save changes'
	String get save_changes => 'Save changes';

	/// en: 'Save and close'
	String get close_and_save => 'Save and close';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'See more'
	String get see_more => 'See more';

	/// en: 'Select all'
	String get select_all => 'Select all';

	/// en: 'Deselect all'
	String get deselect_all => 'Deselect all';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Filter'
	String get filter => 'Filter';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Submit'
	String get submit => 'Submit';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Previous'
	String get previous => 'Previous';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Reload'
	String get reload => 'Reload';

	/// en: 'View'
	String get view => 'View';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Upload'
	String get upload => 'Upload';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Paste'
	String get paste => 'Paste';

	/// en: 'Undo'
	String get undo => 'Undo';

	/// en: 'Redo'
	String get redo => 'Redo';

	/// en: 'Open'
	String get open => 'Open';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Discard'
	String get discard => 'Discard';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Share'
	String get share => 'Share';
}

// Path: general
class TranslationsGeneralEn {
	TranslationsGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'or'
	String get or => 'or';

	/// en: 'Understood'
	String get understood => 'Understood';

	/// en: 'Unspecified'
	String get unspecified => 'Unspecified';

	/// en: 'Quick actions'
	String get quick_actions => 'Quick actions';

	/// en: 'Details'
	String get details => 'Details';

	/// en: 'Balance'
	String get balance => 'Balance';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Accounts'
	String get accounts => 'Accounts';

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';

	/// en: 'Filters'
	String get filters => 'Filters';

	/// en: 'Ops! This is very empty'
	String get empty_warn => 'Ops! This is very empty';

	/// en: 'No items match your search criteria'
	String get search_no_results => 'No items match your search criteria';

	/// en: 'Insufficient data'
	String get insufficient_data => 'Insufficient data';

	/// en: 'Show more fields'
	String get show_more_fields => 'Show more fields';

	/// en: 'Show less fields'
	String get show_less_fields => 'Show less fields';

	/// en: 'Tap to search'
	String get tap_to_search => 'Tap to search';

	late final TranslationsGeneralLeaveWithoutSavingEn leave_without_saving = TranslationsGeneralLeaveWithoutSavingEn._(_root);
	late final TranslationsGeneralClipboardEn clipboard = TranslationsGeneralClipboardEn._(_root);
	late final TranslationsGeneralTimeEn time = TranslationsGeneralTimeEn._(_root);
	late final TranslationsGeneralTransactionOrderEn transaction_order = TranslationsGeneralTransactionOrderEn._(_root);
	late final TranslationsGeneralValidationsEn validations = TranslationsGeneralValidationsEn._(_root);
}

// Path: intro
class TranslationsIntroEn {
	TranslationsIntroEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Start'
	String get start => 'Start';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Select your currency'
	String get select_your_currency => 'Select your currency';

	/// en: 'Your personal finance manager'
	String get welcome_subtitle => 'Your personal finance manager';

	/// en: '100% open, 100% free'
	String get welcome_subtitle2 => '100% open, 100% free';

	/// en: 'By logging in you agree to the <a href='https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md'>Privacy Policy</a> and the <a href='https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md'>Terms of Use</a> of the application'
	String get welcome_footer => 'By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application';

	/// en: 'OFFLINE ACCOUNT:'
	String get offline_descr_title => 'OFFLINE ACCOUNT:';

	/// en: 'Your data will only be stored on your device, and will be safe as long as you don't uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.'
	String get offline_descr => 'Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';

	/// en: 'Start session offline'
	String get offline_start => 'Start session offline';

	/// en: 'Select your currency'
	String get sl1_title => 'Select your currency';

	/// en: 'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings'
	String get sl1_descr => 'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings';

	/// en: 'Safe, private and reliable'
	String get sl2_title => 'Safe, private and reliable';

	/// en: 'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet'
	String get sl2_descr => 'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet';

	/// en: 'Also, the source code of the application is public, anyone can collaborate on it and see how it works'
	String get sl2_descr2 => 'Also, the source code of the application is public, anyone can collaborate on it and see how it works';

	/// en: 'All ready'
	String get last_slide_title => 'All ready';

	/// en: 'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.'
	String get last_slide_descr => 'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.';

	/// en: 'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...'
	String get last_slide_descr2 => 'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Dashboard'
	String get title => 'Dashboard';

	/// en: 'Filter transactions'
	String get filter_transactions => 'Filter transactions';

	/// en: 'Good morning,'
	String get hello_day => 'Good morning,';

	/// en: 'Good night,'
	String get hello_night => 'Good night,';

	/// en: 'Total balance'
	String get total_balance => 'Total balance';

	/// en: 'My accounts'
	String get my_accounts => 'My accounts';

	/// en: 'Active accounts'
	String get active_accounts => 'Active accounts';

	/// en: 'No accounts created yet'
	String get no_accounts => 'No accounts created yet';

	/// en: 'Start using all the magic of Monekin. Create at least one account to start adding transactions'
	String get no_accounts_descr => 'Start using all the magic of Monekin. Create at least one account to start adding transactions';

	/// en: 'Last transactions'
	String get last_transactions => 'Last transactions';

	/// en: 'Oops!'
	String get should_create_account_header => 'Oops!';

	/// en: 'You must have at least one no-archived account before you can start creating transactions'
	String get should_create_account_message => 'You must have at least one no-archived account before you can start creating transactions';
}

// Path: financial_health
class TranslationsFinancialHealthEn {
	TranslationsFinancialHealthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Financial health'
	String get display => 'Financial health';

	late final TranslationsFinancialHealthReviewEn review = TranslationsFinancialHealthReviewEn._(_root);
	late final TranslationsFinancialHealthMonthsWithoutIncomeEn months_without_income = TranslationsFinancialHealthMonthsWithoutIncomeEn._(_root);
	late final TranslationsFinancialHealthSavingsPercentageEn savings_percentage = TranslationsFinancialHealthSavingsPercentageEn._(_root);
}

// Path: stats
class TranslationsStatsEn {
	TranslationsStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Statistics'
	String get title => 'Statistics';

	/// en: 'Balance'
	String get balance => 'Balance';

	/// en: 'Final balance'
	String get final_balance => 'Final balance';

	/// en: 'Balance by accounts'
	String get balance_by_account => 'Balance by accounts';

	/// en: 'Where do I have most of my money?'
	String get balance_by_account_subtitle => 'Where do I have most of my money?';

	/// en: 'Balance by currency'
	String get balance_by_currency => 'Balance by currency';

	/// en: 'How much money do I have in foreign currency?'
	String get balance_by_currency_subtitle => 'How much money do I have in foreign currency?';

	/// en: 'Balance trend'
	String get balance_evolution => 'Balance trend';

	/// en: 'Do I have more money than before?'
	String get balance_evolution_subtitle => 'Do I have more money than before?';

	/// en: 'Compared to the previous period'
	String get compared_to_previous_period => 'Compared to the previous period';

	/// en: 'Cash flow'
	String get cash_flow => 'Cash flow';

	/// en: 'Am I spending less than I earn?'
	String get cash_flow_subtitle => 'Am I spending less than I earn?';

	/// en: 'By periods'
	String get by_periods => 'By periods';

	/// en: 'By categories'
	String get by_categories => 'By categories';

	/// en: 'By tags'
	String get by_tags => 'By tags';

	/// en: 'Distribution'
	String get distribution => 'Distribution';

	/// en: 'Resume'
	String get finance_health_resume => 'Resume';

	/// en: 'Breakdown'
	String get finance_health_breakdown => 'Breakdown';
}

// Path: icon_selector
class TranslationsIconSelectorEn {
	TranslationsIconSelectorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Name:'
	String get name => 'Name:';

	/// en: 'Icon'
	String get icon => 'Icon';

	/// en: 'Color'
	String get color => 'Color';

	/// en: 'Select an icon'
	String get select_icon => 'Select an icon';

	/// en: 'Select a color'
	String get select_color => 'Select a color';

	/// en: 'Custom color'
	String get custom_color => 'Custom color';

	/// en: 'Current selection'
	String get current_color_selection => 'Current selection';

	/// en: 'Identify your account'
	String get select_account_icon => 'Identify your account';

	/// en: 'Identify your category'
	String get select_category_icon => 'Identify your category';

	late final TranslationsIconSelectorScopesEn scopes = TranslationsIconSelectorScopesEn._(_root);
}

// Path: transaction
class TranslationsTransactionEn {
	TranslationsTransactionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {Transaction} (other) {Transactions}'
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Transaction',
		other: 'Transactions',
	);

	/// en: 'New transaction'
	String get create => 'New transaction';

	/// en: 'New income'
	String get new_income => 'New income';

	/// en: 'New expense'
	String get new_expense => 'New expense';

	/// en: 'Transaction created successfully'
	String get new_success => 'Transaction created successfully';

	/// en: 'Edit transaction'
	String get edit => 'Edit transaction';

	/// en: 'Transaction edited successfully'
	String get edit_success => 'Transaction edited successfully';

	/// en: 'Edit transactions'
	String get edit_multiple => 'Edit transactions';

	/// en: '{{ x }} transactions edited successfully'
	String edit_multiple_success({required Object x}) => '${x} transactions edited successfully';

	/// en: 'Clone transaction'
	String get duplicate => 'Clone transaction';

	/// en: 'Clone'
	String get duplicate_short => 'Clone';

	/// en: 'A transaction identical to this will be created with the same date, do you want to continue?'
	String get duplicate_warning_message => 'A transaction identical to this will be created with the same date, do you want to continue?';

	/// en: 'Transaction cloned successfully'
	String get duplicate_success => 'Transaction cloned successfully';

	/// en: 'Delete transaction'
	String get delete => 'Delete transaction';

	/// en: 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated'
	String get delete_warning_message => 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';

	/// en: 'Transaction deleted correctly'
	String get delete_success => 'Transaction deleted correctly';

	/// en: 'Delete transactions'
	String get delete_multiple => 'Delete transactions';

	/// en: 'This action is irreversible and will remove {{ x }} transactions. The current balance of your accounts and all your statistics will be recalculated'
	String delete_multiple_warning_message({required Object x}) => 'This action is irreversible and will remove ${x} transactions. The current balance of your accounts and all your statistics will be recalculated';

	/// en: '{{x}} transactions deleted correctly'
	String delete_multiple_success({required Object x}) => '${x} transactions deleted correctly';

	/// en: 'Movement details'
	String get details => 'Movement details';

	late final TranslationsTransactionNextPaymentsEn next_payments = TranslationsTransactionNextPaymentsEn._(_root);
	late final TranslationsTransactionListEn list = TranslationsTransactionListEn._(_root);
	late final TranslationsTransactionFiltersEn filters = TranslationsTransactionFiltersEn._(_root);
	late final TranslationsTransactionFormEn form = TranslationsTransactionFormEn._(_root);
	late final TranslationsTransactionReversedEn reversed = TranslationsTransactionReversedEn._(_root);
	late final TranslationsTransactionStatusEn status = TranslationsTransactionStatusEn._(_root);
	late final TranslationsTransactionTypesEn types = TranslationsTransactionTypesEn._(_root);
}

// Path: transfer
class TranslationsTransferEn {
	TranslationsTransferEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Transfer'
	String get display => 'Transfer';

	/// en: 'Transfers'
	String get transfers => 'Transfers';

	/// en: 'Transfer to {{ account }}'
	String transfer_to({required Object account}) => 'Transfer to ${account}';

	/// en: 'New Transfer'
	String get create => 'New Transfer';

	/// en: 'Ops!'
	String get need_two_accounts_warning_header => 'Ops!';

	/// en: 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button'
	String get need_two_accounts_warning_message => 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';

	late final TranslationsTransferFormEn form = TranslationsTransferFormEn._(_root);
}

// Path: recurrent_transactions
class TranslationsRecurrentTransactionsEn {
	TranslationsRecurrentTransactionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recurrent transactions'
	String get title => 'Recurrent transactions';

	/// en: 'Rec. transactions'
	String get title_short => 'Rec. transactions';

	/// en: 'It looks like you don't have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here'
	String get empty => 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';

	/// en: 'Total expense per period'
	String get total_expense_title => 'Total expense per period';

	/// en: '* Without considering the start and end date of each recurrence'
	String get total_expense_descr => '* Without considering the start and end date of each recurrence';

	late final TranslationsRecurrentTransactionsDetailsEn details = TranslationsRecurrentTransactionsDetailsEn._(_root);
	late final TranslationsRecurrentTransactionsStatusEn status = TranslationsRecurrentTransactionsStatusEn._(_root);
}

// Path: account
class TranslationsAccountEn {
	TranslationsAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account details'
	String get details => 'Account details';

	/// en: 'Opening date'
	String get date => 'Opening date';

	/// en: 'Closing date'
	String get close_date => 'Closing date';

	/// en: 'Re-open account'
	String get reopen => 'Re-open account';

	/// en: 'Re-open'
	String get reopen_short => 'Re-open';

	/// en: 'Are you sure you want to reopen this account?'
	String get reopen_descr => 'Are you sure you want to reopen this account?';

	/// en: 'Account balance'
	String get balance => 'Account balance';

	/// en: 'Number of transactions'
	String get n_transactions => 'Number of transactions';

	/// en: 'Add money'
	String get add_money => 'Add money';

	/// en: 'Withdraw money'
	String get withdraw_money => 'Withdraw money';

	/// en: 'No accounts found to display here. Add an account by clicking the '+' button at the bottom'
	String get no_accounts => 'No accounts found to display here. Add an account by clicking the \'+\' button at the bottom';

	late final TranslationsAccountTypesEn types = TranslationsAccountTypesEn._(_root);
	late final TranslationsAccountFormEn form = TranslationsAccountFormEn._(_root);
	late final TranslationsAccountDeleteEn delete = TranslationsAccountDeleteEn._(_root);
	late final TranslationsAccountCloseEn close = TranslationsAccountCloseEn._(_root);
	late final TranslationsAccountSelectEn select = TranslationsAccountSelectEn._(_root);
}

// Path: currencies
class TranslationsCurrenciesEn {
	TranslationsCurrenciesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Currency converter'
	String get currency_converter => 'Currency converter';

	/// en: 'Currency'
	String get currency => 'Currency';

	/// en: 'Currency settings'
	String get currency_settings => 'Currency settings';

	/// en: 'Currency manager'
	String get currency_manager => 'Currency manager';

	/// en: 'Configure your currency and its exchange rates with others'
	String get currency_manager_descr => 'Configure your currency and its exchange rates with others';

	/// en: 'Preferred/base currency'
	String get preferred_currency => 'Preferred/base currency';

	/// en: 'Tap to change'
	String get tap_to_change_preferred_currency => 'Tap to change';

	/// en: 'Change preferred currency'
	String get change_preferred_currency_title => 'Change preferred currency';

	/// en: 'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?'
	String get change_preferred_currency_msg => 'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?';

	late final TranslationsCurrenciesExchangeRateFormEn exchange_rate_form = TranslationsCurrenciesExchangeRateFormEn._(_root);
	late final TranslationsCurrenciesTypesEn types = TranslationsCurrenciesTypesEn._(_root);
	late final TranslationsCurrenciesCurrencyFormEn currency_form = TranslationsCurrenciesCurrencyFormEn._(_root);

	/// en: 'Deleted exchange rates successfully'
	String get delete_all_success => 'Deleted exchange rates successfully';

	/// en: 'Historical rates'
	String get historical => 'Historical rates';

	/// en: 'No historical exchange rates found for this currency'
	String get historical_empty => 'No historical exchange rates found for this currency';

	/// en: 'Exchange rate'
	String get exchange_rate => 'Exchange rate';

	/// en: 'Exchange rates'
	String get exchange_rates => 'Exchange rates';

	/// en: 'Minimum exchange rate'
	String get min_exchange_rate => 'Minimum exchange rate';

	/// en: 'Maximum exchange rate'
	String get max_exchange_rate => 'Maximum exchange rate';

	/// en: 'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate'
	String get empty => 'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate';

	/// en: 'Select a currency'
	String get select_a_currency => 'Select a currency';

	/// en: 'Search by name or by currency code'
	String get search => 'Search by name or by currency code';
}

// Path: tags
class TranslationsTagsEn {
	TranslationsTagsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {Label} (other) {Tags}'
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Label',
		other: 'Tags',
	);

	late final TranslationsTagsFormEn form = TranslationsTagsFormEn._(_root);
	late final TranslationsTagsSelectEn select = TranslationsTagsSelectEn._(_root);

	/// en: 'You haven't created any tags yet. Tags and categories are a great way to categorize your movements'
	String get empty_list => 'You haven\'t created any tags yet. Tags and categories are a great way to categorize your movements';

	/// en: 'Without tags'
	String get without_tags => 'Without tags';

	/// en: 'Add tag'
	String get add => 'Add tag';

	/// en: 'Create label'
	String get create => 'Create label';

	/// en: 'Label created successfully'
	String get create_success => 'Label created successfully';

	/// en: 'This tag name already exists. You may want to edit it'
	String get already_exists => 'This tag name already exists. You may want to edit it';

	/// en: 'Edit tag'
	String get edit => 'Edit tag';

	/// en: 'Tag edited successfully'
	String get edit_success => 'Tag edited successfully';

	/// en: 'Category deleted successfully'
	String get delete_success => 'Category deleted successfully';

	/// en: 'Delete tag?'
	String get delete_warning_header => 'Delete tag?';

	/// en: 'This action will not delete transactions that have this tag.'
	String get delete_warning_message => 'This action will not delete transactions that have this tag.';
}

// Path: categories
class TranslationsCategoriesEn {
	TranslationsCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unknown category'
	String get unknown => 'Unknown category';

	/// en: 'Create category'
	String get create => 'Create category';

	/// en: 'Category created correctly'
	String get create_success => 'Category created correctly';

	/// en: 'New category'
	String get new_category => 'New category';

	/// en: 'The name of this category already exists. Maybe you want to edit it'
	String get already_exists => 'The name of this category already exists. Maybe you want to edit it';

	/// en: 'Edit category'
	String get edit => 'Edit category';

	/// en: 'Category edited correctly'
	String get edit_success => 'Category edited correctly';

	/// en: 'Category name'
	String get name => 'Category name';

	/// en: 'Category type'
	String get type => 'Category type';

	/// en: 'Both types'
	String get both_types => 'Both types';

	/// en: 'Subcategories'
	String get subcategories => 'Subcategories';

	/// en: 'Add subcategory'
	String get subcategories_add => 'Add subcategory';

	/// en: 'Make to category'
	String get make_parent => 'Make to category';

	/// en: 'Make a subcategory'
	String get make_child => 'Make a subcategory';

	/// en: 'This category and its subcategories will become subcategories of <b>{{destiny}}</b>.'
	String make_child_warning1({required Object destiny}) => 'This category and its subcategories will become subcategories of <b>${destiny}</b>.';

	/// en: 'Their transactions <b>({{x}})</b> will be moved to the new subcategories created within the <b>{{destiny}}</b> category.'
	String make_child_warning2({required Object x, required Object destiny}) => 'Their transactions <b>(${x})</b> will be moved to the new subcategories created within the <b>${destiny}</b> category.';

	/// en: 'Subcategories created successfully'
	String get make_child_success => 'Subcategories created successfully';

	/// en: 'Merge with another category'
	String get merge => 'Merge with another category';

	/// en: 'All transactions ({{x}}) associated with the category <b>{{from}}</b> will be moved to the category <b>{{destiny}}</b>'
	String merge_warning1({required Object x, required Object from, required Object destiny}) => 'All transactions (${x}) associated with the category <b>${from}</b> will be moved to the category <b>${destiny}</b>';

	/// en: 'The category <b>{{from}}</b> will be irreversibly deleted.'
	String merge_warning2({required Object from}) => 'The category <b>${from}</b> will be irreversibly deleted.';

	/// en: 'Category merged successfully'
	String get merge_success => 'Category merged successfully';

	/// en: 'Category deleted correctly'
	String get delete_success => 'Category deleted correctly';

	/// en: 'Delete category?'
	String get delete_warning_header => 'Delete category?';

	/// en: 'This action will irreversibly delete all transactions <b>({{x}})</b> related to this category.'
	String delete_warning_message({required Object x}) => 'This action will irreversibly delete all transactions <b>(${x})</b> related to this category.';

	late final TranslationsCategoriesSelectEn select = TranslationsCategoriesSelectEn._(_root);
}

// Path: budgets
class TranslationsBudgetsEn {
	TranslationsBudgetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Budgets'
	String get title => 'Budgets';

	/// en: 'Recurring'
	String get repeated => 'Recurring';

	/// en: 'Once'
	String get one_time => 'Once';

	/// en: 'Annuals'
	String get annual => 'Annuals';

	/// en: 'Weekly'
	String get week => 'Weekly';

	/// en: 'Monthly'
	String get month => 'Monthly';

	/// en: 'Actives'
	String get actives => 'Actives';

	/// en: 'Pending start'
	String get pending => 'Pending start';

	/// en: 'Finished'
	String get finish => 'Finished';

	/// en: 'left of '
	String get from_budgeted => 'left of ';

	/// en: 'days left'
	String get days_left => 'days left';

	/// en: 'days to start'
	String get days_to_start => 'days to start';

	/// en: 'days since expiration'
	String get since_expiration => 'days since expiration';

	/// en: 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below'
	String get no_budgets => 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';

	/// en: 'Delete budget'
	String get delete => 'Delete budget';

	/// en: 'This action is irreversible. Categories and transactions referring to this quote will not be deleted'
	String get delete_warning => 'This action is irreversible. Categories and transactions referring to this quote will not be deleted';

	late final TranslationsBudgetsFormEn form = TranslationsBudgetsFormEn._(_root);
	late final TranslationsBudgetsDetailsEn details = TranslationsBudgetsDetailsEn._(_root);
	late final TranslationsBudgetsTargetTimelineStatusesEn target_timeline_statuses = TranslationsBudgetsTargetTimelineStatusesEn._(_root);
	late final TranslationsBudgetsProgressEn progress = TranslationsBudgetsProgressEn._(_root);
}

// Path: target_timeline_statuses
class TranslationsTargetTimelineStatusesEn {
	TranslationsTargetTimelineStatusesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Past'
	String get past => 'Past';

	/// en: 'Future'
	String get future => 'Future';
}

// Path: backup
class TranslationsBackupEn {
	TranslationsBackupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No file selected'
	String get no_file_selected => 'No file selected';

	/// en: 'No directory selected'
	String get no_directory_selected => 'No directory selected';

	late final TranslationsBackupExportEn export = TranslationsBackupExportEn._(_root);
	late final TranslationsBackupImportEn import = TranslationsBackupImportEn._(_root);
	late final TranslationsBackupAboutEn about = TranslationsBackupAboutEn._(_root);
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings & Customization'
	String get title_long => 'Settings & Customization';

	/// en: 'Settings'
	String get title_short => 'Settings';

	/// en: 'Theme, Language, Data and more'
	String get description => 'Theme, Language, Data and more';

	/// en: 'Edit profile'
	String get edit_profile => 'Edit profile';

	late final TranslationsSettingsGeneralEn general = TranslationsSettingsGeneralEn._(_root);
	late final TranslationsSettingsSecurityEn security = TranslationsSettingsSecurityEn._(_root);
	late final TranslationsSettingsTransactionsEn transactions = TranslationsSettingsTransactionsEn._(_root);
	late final TranslationsSettingsAppearanceEn appearance = TranslationsSettingsAppearanceEn._(_root);
}

// Path: more
class TranslationsMoreEn {
	TranslationsMoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'More'
	String get title => 'More';

	/// en: 'More actions'
	String get title_long => 'More actions';

	late final TranslationsMoreDataEn data = TranslationsMoreDataEn._(_root);
	late final TranslationsMoreAboutUsEn about_us = TranslationsMoreAboutUsEn._(_root);
	late final TranslationsMoreHelpUsEn help_us = TranslationsMoreHelpUsEn._(_root);
}

// Path: general.leave_without_saving
class TranslationsGeneralLeaveWithoutSavingEn {
	TranslationsGeneralLeaveWithoutSavingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Leave without saving?'
	String get title => 'Leave without saving?';

	/// en: 'You have unsaved changes, are you sure you want to leave without saving them?'
	String get message => 'You have unsaved changes, are you sure you want to leave without saving them?';
}

// Path: general.clipboard
class TranslationsGeneralClipboardEn {
	TranslationsGeneralClipboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '{{x}} copied to the clipboard'
	String success({required Object x}) => '${x} copied to the clipboard';

	/// en: 'Error copying'
	String get error => 'Error copying';
}

// Path: general.time
class TranslationsGeneralTimeEn {
	TranslationsGeneralTimeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Start date'
	String get start_date => 'Start date';

	/// en: 'End date'
	String get end_date => 'End date';

	/// en: 'From date'
	String get from_date => 'From date';

	/// en: 'Until date'
	String get until_date => 'Until date';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Datetime'
	String get datetime => 'Datetime';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Each'
	String get each => 'Each';

	/// en: 'After'
	String get after => 'After';

	late final TranslationsGeneralTimeRangesEn ranges = TranslationsGeneralTimeRangesEn._(_root);
	late final TranslationsGeneralTimePeriodicityEn periodicity = TranslationsGeneralTimePeriodicityEn._(_root);
	late final TranslationsGeneralTimeCurrentEn current = TranslationsGeneralTimeCurrentEn._(_root);
	late final TranslationsGeneralTimeAllEn all = TranslationsGeneralTimeAllEn._(_root);
}

// Path: general.transaction_order
class TranslationsGeneralTransactionOrderEn {
	TranslationsGeneralTransactionOrderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Order transactions'
	String get display => 'Order transactions';

	/// en: 'By category'
	String get category => 'By category';

	/// en: 'By quantity'
	String get quantity => 'By quantity';

	/// en: 'By date'
	String get date => 'By date';
}

// Path: general.validations
class TranslationsGeneralValidationsEn {
	TranslationsGeneralValidationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fix the indicated fields to continue'
	String get form_error => 'Fix the indicated fields to continue';

	/// en: 'Required field'
	String get required => 'Required field';

	/// en: 'Should be positive'
	String get positive => 'Should be positive';

	/// en: 'Should be greater than {{x}}'
	String min_number({required Object x}) => 'Should be greater than ${x}';

	/// en: 'Should be less than {{x}}'
	String max_number({required Object x}) => 'Should be less than ${x}';
}

// Path: financial_health.review
class TranslationsFinancialHealthReviewEn {
	TranslationsFinancialHealthReviewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(male) {Very good!} (female) {Very good!}'
	String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Very good!';
			case GenderContext.female:
				return 'Very good!';
		}
	}

	/// en: '(male) {Good} (female) {Good}'
	String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Good';
			case GenderContext.female:
				return 'Good';
		}
	}

	/// en: '(male) {Average} (female) {Average}'
	String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Average';
			case GenderContext.female:
				return 'Average';
		}
	}

	/// en: '(male) {Fair} (female) {Fair}'
	String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Fair';
			case GenderContext.female:
				return 'Fair';
		}
	}

	/// en: '(male) {Very Bad} (female) {Very Bad}'
	String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Very Bad';
			case GenderContext.female:
				return 'Very Bad';
		}
	}

	/// en: '(male) {Insufficient data} (female) {Insufficient data}'
	String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Insufficient data';
			case GenderContext.female:
				return 'Insufficient data';
		}
	}

	late final TranslationsFinancialHealthReviewDescrEn descr = TranslationsFinancialHealthReviewDescrEn._(_root);
}

// Path: financial_health.months_without_income
class TranslationsFinancialHealthMonthsWithoutIncomeEn {
	TranslationsFinancialHealthMonthsWithoutIncomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Survival rate'
	String get title => 'Survival rate';

	/// en: 'Given your balance, amount of time you could go without income'
	String get subtitle => 'Given your balance, amount of time you could go without income';

	/// en: 'You couldn't survive a month without income at this rate of expenses!'
	String get text_zero => 'You couldn\'t survive a month without income at this rate of expenses!';

	/// en: 'You could barely survive approximately a month without income at this rate of expenses!'
	String get text_one => 'You could barely survive approximately a month without income at this rate of expenses!';

	/// en: 'You could survive approximately <b>{{ n }} months</b> without income at this rate of spending.'
	String text_other({required Object n}) => 'You could survive approximately <b>${n} months</b> without income at this rate of spending.';

	/// en: 'You could survive approximately <b>all your life</b> without income at this rate of spending.'
	String get text_infinite => 'You could survive approximately <b>all your life</b> without income at this rate of spending.';

	/// en: 'Remember that it is advisable to always keep this ratio above 5 months at least. If you see that you do not have a sufficient savings cushion, reduce unnecessary expenses.'
	String get suggestion => 'Remember that it is advisable to always keep this ratio above 5 months at least. If you see that you do not have a sufficient savings cushion, reduce unnecessary expenses.';

	/// en: 'It looks like we don't have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health'
	String get insufficient_data => 'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
}

// Path: financial_health.savings_percentage
class TranslationsFinancialHealthSavingsPercentageEn {
	TranslationsFinancialHealthSavingsPercentageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Savings percentage'
	String get title => 'Savings percentage';

	/// en: 'What part of your income is not spent in this period'
	String get subtitle => 'What part of your income is not spent in this period';

	late final TranslationsFinancialHealthSavingsPercentageTextEn text = TranslationsFinancialHealthSavingsPercentageTextEn._(_root);

	/// en: 'Remember that it is advisable to save at least 15-20% of what you earn.'
	String get suggestion => 'Remember that it is advisable to save at least 15-20% of what you earn.';
}

// Path: icon_selector.scopes
class TranslationsIconSelectorScopesEn {
	TranslationsIconSelectorScopesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Transport'
	String get transport => 'Transport';

	/// en: 'Money'
	String get money => 'Money';

	/// en: 'Food'
	String get food => 'Food';

	/// en: 'Health'
	String get medical => 'Health';

	/// en: 'Leisure'
	String get entertainment => 'Leisure';

	/// en: 'Technology'
	String get technology => 'Technology';

	/// en: 'Others'
	String get other => 'Others';

	/// en: 'Financial institutions'
	String get logos_financial_institutions => 'Financial institutions';
}

// Path: transaction.next_payments
class TranslationsTransactionNextPaymentsEn {
	TranslationsTransactionNextPaymentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Accept'
	String get accept => 'Accept';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Successfully skipped transaction'
	String get skip_success => 'Successfully skipped transaction';

	/// en: 'Skip transaction'
	String get skip_dialog_title => 'Skip transaction';

	/// en: 'This action is irreversible. We will move the date of the next move to {{date}}'
	String skip_dialog_msg({required Object date}) => 'This action is irreversible. We will move the date of the next move to ${date}';

	/// en: 'Accept today'
	String get accept_today => 'Accept today';

	/// en: 'Accept in required date ({{date}})'
	String accept_in_required_date({required Object date}) => 'Accept in required date (${date})';

	/// en: 'Accept transaction'
	String get accept_dialog_title => 'Accept transaction';

	/// en: 'The new status of the transaction will be null. You can re-edit the status of this transaction whenever you want'
	String get accept_dialog_msg_single => 'The new status of the transaction will be null. You can re-edit the status of this transaction whenever you want';

	/// en: 'This action will create a new transaction with date {{date}}. You will be able to check the details of this transaction on the transaction page'
	String accept_dialog_msg({required Object date}) => 'This action will create a new transaction with date ${date}. You will be able to check the details of this transaction on the transaction page';

	/// en: 'The recurring rule has been completed, there are no more payments to make!'
	String get recurrent_rule_finished => 'The recurring rule has been completed, there are no more payments to make!';
}

// Path: transaction.list
class TranslationsTransactionListEn {
	TranslationsTransactionListEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All transactions'
	String get all => 'All transactions';

	/// en: 'No transactions found to display here. Add a few transactions in the app and maybe you'll have better luck next time.'
	String get empty => 'No transactions found to display here. Add a few transactions in the app and maybe you\'ll have better luck next time.';

	/// en: 'Search by category, description...'
	String get searcher_placeholder => 'Search by category, description...';

	/// en: 'No transactions found matching the search criteria'
	String get searcher_no_results => 'No transactions found matching the search criteria';

	/// en: 'Loading more transactions...'
	String get loading => 'Loading more transactions...';

	/// en: '(one) {{{n}} selected} (other) {{{n}} selected}'
	String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} selected',
		other: '${n} selected',
	);

	/// en: '(one) {{{n}} transaction selected} (other) {{{n}} transactions selected}'
	String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} transaction selected',
		other: '${n} transactions selected',
	);

	late final TranslationsTransactionListBulkEditEn bulk_edit = TranslationsTransactionListBulkEditEn._(_root);
}

// Path: transaction.filters
class TranslationsTransactionFiltersEn {
	TranslationsTransactionFiltersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Transaction filters'
	String get title => 'Transaction filters';

	/// en: 'From amount'
	String get from_value => 'From amount';

	/// en: 'Up to amount'
	String get to_value => 'Up to amount';

	/// en: 'From {{ x }}'
	String from_value_def({required Object x}) => 'From ${x}';

	/// en: 'Up to {{ x }}'
	String to_value_def({required Object x}) => 'Up to ${x}';

	/// en: 'From the {{ date }}'
	String from_date_def({required Object date}) => 'From the ${date}';

	/// en: 'Up to the {{ date }}'
	String to_date_def({required Object date}) => 'Up to the ${date}';

	/// en: 'Reset filters'
	String get reset => 'Reset filters';

	late final TranslationsTransactionFiltersSavedEn saved = TranslationsTransactionFiltersSavedEn._(_root);
}

// Path: transaction.form
class TranslationsTransactionFormEn {
	TranslationsTransactionFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsTransactionFormValidatorsEn validators = TranslationsTransactionFormValidatorsEn._(_root);

	/// en: 'Transaction title'
	String get title => 'Transaction title';

	/// en: 'Title'
	String get title_short => 'Title';

	/// en: 'Value of the transaction'
	String get value => 'Value of the transaction';

	/// en: 'Tap to see more details'
	String get tap_to_see_more => 'Tap to see more details';

	/// en: '-- No tags --'
	String get no_tags => '-- No tags --';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Tap here to enter a more detailed description about this transaction'
	String get description_info => 'Tap here to enter a more detailed description about this transaction';

	/// en: 'Exchnage rate to {{ currency }}'
	String exchange_to_preferred_title({required Object currency}) => 'Exchnage rate to ${currency}';

	/// en: 'On transaction date'
	String get exchange_to_preferred_in_date => 'On transaction date';
}

// Path: transaction.reversed
class TranslationsTransactionReversedEn {
	TranslationsTransactionReversedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inverse transaction'
	String get title => 'Inverse transaction';

	/// en: 'Inverse tr.'
	String get title_short => 'Inverse tr.';

	/// en: 'Despite being an expense transaction, it has a positive amount. These types of transactions can be used to represent the return of a previously recorded expense, such as a refund or having the payment of a debt.'
	String get description_for_expenses => 'Despite being an expense transaction, it has a positive amount. These types of transactions can be used to represent the return of a previously recorded expense, such as a refund or having the payment of a debt.';

	/// en: 'Despite being an income transaction, it has a negative amount. These types of transactions can be used to void or correct an income that was incorrectly recorded, to reflect a return or refund of money or to record payment of debts.'
	String get description_for_incomes => 'Despite being an income transaction, it has a negative amount. These types of transactions can be used to void or correct an income that was incorrectly recorded, to reflect a return or refund of money or to record payment of debts.';
}

// Path: transaction.status
class TranslationsTransactionStatusEn {
	TranslationsTransactionStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {Status} (other) {Statuses}'
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Status',
		other: 'Statuses',
	);

	/// en: 'Transaction status'
	String get display_long => 'Transaction status';

	/// en: '{{ status }} transaction'
	String tr_status({required Object status}) => '${status} transaction';

	/// en: 'Stateless'
	String get none => 'Stateless';

	/// en: 'Transaction without a specific state'
	String get none_descr => 'Transaction without a specific state';

	/// en: 'Reconciled'
	String get reconciled => 'Reconciled';

	/// en: 'This transaction has already been validated and corresponds to a real transaction from your bank'
	String get reconciled_descr => 'This transaction has already been validated and corresponds to a real transaction from your bank';

	/// en: 'Unreconciled'
	String get unreconciled => 'Unreconciled';

	/// en: 'This transaction has not yet been validated and therefore does not yet appear in your real bank accounts. However, it counts for the calculation of balances and statistics in Monekin'
	String get unreconciled_descr => 'This transaction has not yet been validated and therefore does not yet appear in your real bank accounts. However, it counts for the calculation of balances and statistics in Monekin';

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'This transaction is pending and therefore it will not be taken into account when calculating balances and statistics'
	String get pending_descr => 'This transaction is pending and therefore it will not be taken into account when calculating balances and statistics';

	/// en: 'Voided'
	String get voided => 'Voided';

	/// en: 'Void/cancelled transaction due to payment error or any other reason. It will not be taken into account when calculating balances and statistics'
	String get voided_descr => 'Void/cancelled transaction due to payment error or any other reason. It will not be taken into account when calculating balances and statistics';
}

// Path: transaction.types
class TranslationsTransactionTypesEn {
	TranslationsTransactionTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {Transaction type} (other) {Transaction types}'
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Transaction type',
		other: 'Transaction types',
	);

	/// en: '(one) {Income} (other) {Incomes}'
	String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Income',
		other: 'Incomes',
	);

	/// en: '(one) {Expense} (other) {Expenses}'
	String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Expense',
		other: 'Expenses',
	);

	/// en: '(one) {Transfer} (other) {Transfers}'
	String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Transfer',
		other: 'Transfers',
	);
}

// Path: transfer.form
class TranslationsTransferFormEn {
	TranslationsTransferFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Origin account'
	String get from => 'Origin account';

	/// en: 'Destination account'
	String get to => 'Destination account';

	late final TranslationsTransferFormValueInDestinyEn value_in_destiny = TranslationsTransferFormValueInDestinyEn._(_root);
}

// Path: recurrent_transactions.details
class TranslationsRecurrentTransactionsDetailsEn {
	TranslationsRecurrentTransactionsDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recurrent transaction'
	String get title => 'Recurrent transaction';

	/// en: 'The next moves for this transaction are shown below. You can accept the first move or skip this move'
	String get descr => 'The next moves for this transaction are shown below. You can accept the first move or skip this move';

	/// en: 'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action'
	String get last_payment_info => 'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action';

	/// en: 'Delete recurring transaction'
	String get delete_header => 'Delete recurring transaction';

	/// en: 'This action is irreversible and will not affect transactions you have already confirmed/paid for'
	String get delete_message => 'This action is irreversible and will not affect transactions you have already confirmed/paid for';
}

// Path: recurrent_transactions.status
class TranslationsRecurrentTransactionsStatusEn {
	TranslationsRecurrentTransactionsStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delayed by {{x}}d'
	String delayed_by({required Object x}) => 'Delayed by ${x}d';

	/// en: 'In {{x}} days'
	String coming_in({required Object x}) => 'In ${x} days';
}

// Path: account.types
class TranslationsAccountTypesEn {
	TranslationsAccountTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account type'
	String get title => 'Account type';

	/// en: 'Once the type of account has been chosen, it cannot be changed in the future'
	String get warning => 'Once the type of account has been chosen, it cannot be changed in the future';

	/// en: 'Normal account'
	String get normal => 'Normal account';

	/// en: 'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...'
	String get normal_descr => 'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...';

	/// en: 'Savings account'
	String get saving => 'Savings account';

	/// en: 'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money'
	String get saving_descr => 'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money';
}

// Path: account.form
class TranslationsAccountFormEn {
	TranslationsAccountFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account name'
	String get name => 'Account name';

	/// en: 'Ex: Savings account'
	String get name_placeholder => 'Ex: Savings account';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Type some notes/description about this account'
	String get notes_placeholder => 'Type some notes/description about this account';

	/// en: 'Initial balance'
	String get initial_balance => 'Initial balance';

	/// en: 'Current balance'
	String get current_balance => 'Current balance';

	/// en: 'Create account'
	String get create => 'Create account';

	/// en: 'Edit account'
	String get edit => 'Edit account';

	/// en: 'You do not have information on exchange rates for this currency. 1.0 will be used as the default exchange rate. You can modify this in the settings'
	String get currency_not_found_warn => 'You do not have information on exchange rates for this currency. 1.0 will be used as the default exchange rate. You can modify this in the settings';

	/// en: 'There is already another one with the same name, please write another'
	String get already_exists => 'There is already another one with the same name, please write another';

	/// en: 'There are transactions in this account with a date before the opening date'
	String get tr_before_opening_date => 'There are transactions in this account with a date before the opening date';

	/// en: 'IBAN'
	String get iban => 'IBAN';

	/// en: 'SWIFT'
	String get swift => 'SWIFT';
}

// Path: account.delete
class TranslationsAccountDeleteEn {
	TranslationsAccountDeleteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete account?'
	String get warning_header => 'Delete account?';

	/// en: 'This action will delete this account and all its transactions'
	String get warning_text => 'This action will delete this account and all its transactions';

	/// en: 'Account deleted successfully'
	String get success => 'Account deleted successfully';
}

// Path: account.close
class TranslationsAccountCloseEn {
	TranslationsAccountCloseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Close account'
	String get title => 'Close account';

	/// en: 'Close'
	String get title_short => 'Close';

	/// en: 'This account will no longer appear in certain listings and you will not be able to create transactions in it with a date later than the one specified below. This action does not affect any transactions or balance, and you can also reopen this account at any time. '
	String get warn => 'This account will no longer appear in certain listings and you will not be able to create transactions in it with a date later than the one specified below. This action does not affect any transactions or balance, and you can also reopen this account at any time. ';

	/// en: 'You must have a current balance of 0 in this account to close it. Please edit the account before continuing'
	String get should_have_zero_balance => 'You must have a current balance of 0 in this account to close it. Please edit the account before continuing';

	/// en: 'This account has transactions after the specified close date. Delete them or edit the account close date before continuing'
	String get should_have_no_transactions => 'This account has transactions after the specified close date. Delete them or edit the account close date before continuing';

	/// en: 'Account closed successfully'
	String get success => 'Account closed successfully';

	/// en: 'Account successfully re-opened'
	String get unarchive_succes => 'Account successfully re-opened';
}

// Path: account.select
class TranslationsAccountSelectEn {
	TranslationsAccountSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select an account'
	String get one => 'Select an account';

	/// en: 'All accounts'
	String get all => 'All accounts';

	/// en: 'Select accounts'
	String get multiple => 'Select accounts';
}

// Path: currencies.exchange_rate_form
class TranslationsCurrenciesExchangeRateFormEn {
	TranslationsCurrenciesExchangeRateFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The currency cannot be equal to the user currency'
	String get equal_to_preferred_warn => 'The currency cannot be equal to the user currency';

	/// en: 'An exchange rate for this currency in this date already exists. If you continue, the previous one will be overwritten'
	String get override_existing_warn => 'An exchange rate for this currency in this date already exists. If you continue, the previous one will be overwritten';

	/// en: 'Please specify a currency'
	String get specify_a_currency => 'Please specify a currency';

	/// en: 'Add exchange rate'
	String get add => 'Add exchange rate';

	/// en: 'Exchange rate added successfully'
	String get add_success => 'Exchange rate added successfully';

	/// en: 'Edit exchange rate'
	String get edit => 'Edit exchange rate';

	/// en: 'Exchange rate edited successfully'
	String get edit_success => 'Exchange rate edited successfully';

	/// en: 'Delete all exchange rates'
	String get remove_all => 'Delete all exchange rates';

	/// en: 'This action is irreversible and will delete all exchange rates for this currency'
	String get remove_all_warning => 'This action is irreversible and will delete all exchange rates for this currency';
}

// Path: currencies.types
class TranslationsCurrenciesTypesEn {
	TranslationsCurrenciesTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Currency type'
	String get display => 'Currency type';

	/// en: 'FIAT'
	String get fiat => 'FIAT';

	/// en: 'Cryptocurrency'
	String get crypto => 'Cryptocurrency';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: currencies.currency_form
class TranslationsCurrenciesCurrencyFormEn {
	TranslationsCurrenciesCurrencyFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Display Name'
	String get name => 'Display Name';

	/// en: 'Currency Code'
	String get code => 'Currency Code';

	/// en: 'Symbol'
	String get symbol => 'Symbol';

	/// en: 'Decimal Digits'
	String get decimal_digits => 'Decimal Digits';

	/// en: 'Create currency'
	String get create => 'Create currency';

	/// en: 'Currency created successfully'
	String get create_success => 'Currency created successfully';

	/// en: 'Edit currency'
	String get edit => 'Edit currency';

	/// en: 'Currency edited successfully'
	String get edit_success => 'Currency edited successfully';

	/// en: 'Delete currency'
	String get delete => 'Delete currency';

	/// en: 'Currency deleted successfully'
	String get delete_success => 'Currency deleted successfully';

	/// en: 'A currency with this code already exists. You may want to edit it'
	String get already_exists => 'A currency with this code already exists. You may want to edit it';
}

// Path: tags.form
class TranslationsTagsFormEn {
	TranslationsTagsFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tag name'
	String get name => 'Tag name';

	/// en: 'Description'
	String get description => 'Description';
}

// Path: tags.select
class TranslationsTagsSelectEn {
	TranslationsTagsSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select tags'
	String get title => 'Select tags';

	/// en: 'All the tags'
	String get all => 'All the tags';
}

// Path: categories.select
class TranslationsCategoriesSelectEn {
	TranslationsCategoriesSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select categories'
	String get title => 'Select categories';

	/// en: 'Select a category'
	String get select_one => 'Select a category';

	/// en: 'Choose a subcategory'
	String get select_subcategory => 'Choose a subcategory';

	/// en: 'Without subcategory'
	String get without_subcategory => 'Without subcategory';

	/// en: 'All categories'
	String get all => 'All categories';

	/// en: 'All'
	String get all_short => 'All';
}

// Path: budgets.form
class TranslationsBudgetsFormEn {
	TranslationsBudgetsFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add a budget'
	String get title => 'Add a budget';

	/// en: 'Budget name'
	String get name => 'Budget name';

	/// en: 'Limit quantity'
	String get value => 'Limit quantity';

	/// en: 'Add budget'
	String get create => 'Add budget';

	/// en: 'Budget created successfully'
	String get create_success => 'Budget created successfully';

	/// en: 'Edit budget'
	String get edit => 'Edit budget';

	/// en: 'Budget edited successfully'
	String get edit_success => 'Budget edited successfully';

	/// en: 'The budgets can not have a negative amount'
	String get negative_warn => 'The budgets can not have a negative amount';
}

// Path: budgets.details
class TranslationsBudgetsDetailsEn {
	TranslationsBudgetsDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Budget Details'
	String get title => 'Budget Details';

	/// en: 'Statistics'
	String get statistics => 'Statistics';

	/// en: 'Budgeted'
	String get budget_value => 'Budgeted';

	/// en: 'Expenditure evolution'
	String get expend_evolution => 'Expenditure evolution';

	/// en: 'It seems that you have not made any expenses related to this budget'
	String get no_transactions => 'It seems that you have not made any expenses related to this budget';
}

// Path: budgets.target_timeline_statuses
class TranslationsBudgetsTargetTimelineStatusesEn {
	TranslationsBudgetsTargetTimelineStatusesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Active budget'
	String get active => 'Active budget';

	/// en: 'Past budget'
	String get past => 'Past budget';

	/// en: 'Future budget'
	String get future => 'Future budget';
}

// Path: budgets.progress
class TranslationsBudgetsProgressEn {
	TranslationsBudgetsProgressEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBudgetsProgressLabelsEn labels = TranslationsBudgetsProgressLabelsEn._(_root);
	late final TranslationsBudgetsProgressDescriptionEn description = TranslationsBudgetsProgressDescriptionEn._(_root);
}

// Path: backup.export
class TranslationsBackupExportEn {
	TranslationsBackupExportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Export your data'
	String get title => 'Export your data';

	/// en: 'Export'
	String get title_short => 'Export';

	/// en: 'Type of export'
	String get type_of_export => 'Type of export';

	/// en: 'Options'
	String get other_options => 'Options';

	/// en: 'Full backup'
	String get all => 'Full backup';

	/// en: 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don't lose anything.'
	String get all_descr => 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';

	/// en: 'Transactions backup'
	String get transactions => 'Transactions backup';

	/// en: 'Export your transactions in CSV so you can more easily analyze them in other programs or applications.'
	String get transactions_descr => 'Export your transactions in CSV so you can more easily analyze them in other programs or applications.';

	/// en: '(one) {1 transaction to export} (other) {{{ n }} transactions to export}'
	String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '1 transaction to export',
		other: '${n} transactions to export',
	);

	/// en: 'Download your data in different formats'
	String get description => 'Download your data in different formats';

	/// en: 'Send file'
	String get send_file => 'Send file';

	/// en: 'See folder'
	String get see_folder => 'See folder';

	/// en: 'File saved successfully in {{x}}'
	String success({required Object x}) => 'File saved successfully in ${x}';

	/// en: 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com'
	String get error => 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
}

// Path: backup.import
class TranslationsBackupImportEn {
	TranslationsBackupImportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Import your data'
	String get title => 'Import your data';

	/// en: 'Import'
	String get title_short => 'Import';

	/// en: 'Restore Backup'
	String get restore_backup => 'Restore Backup';

	/// en: 'Import a previously saved database from Monekin. This action will replace any current application data with the new data'
	String get restore_backup_descr => 'Import a previously saved database from Monekin. This action will replace any current application data with the new data';

	/// en: 'When importing a new database, you will lose all data currently saved in the app. It is recommended to make a backup before continuing. Do not upload here any file whose origin you do not know, upload only files that you have previously downloaded from Monekin'
	String get restore_backup_warn_description => 'When importing a new database, you will lose all data currently saved in the app. It is recommended to make a backup before continuing. Do not upload here any file whose origin you do not know, upload only files that you have previously downloaded from Monekin';

	/// en: 'Overwrite all data'
	String get restore_backup_warn_title => 'Overwrite all data';

	/// en: 'Select other file'
	String get select_other_file => 'Select other file';

	/// en: 'Tap to select a file'
	String get tap_to_select_file => 'Tap to select a file';

	late final TranslationsBackupImportManualImportEn manual_import = TranslationsBackupImportManualImportEn._(_root);

	/// en: 'Import performed successfully'
	String get success => 'Import performed successfully';

	/// en: 'Error importing file. Please contact developer via lozin.technologies@gmail.com'
	String get error => 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
}

// Path: backup.about
class TranslationsBackupAboutEn {
	TranslationsBackupAboutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Information about your database'
	String get title => 'Information about your database';

	/// en: 'Creation date'
	String get create_date => 'Creation date';

	/// en: 'Last modified'
	String get modify_date => 'Last modified';

	/// en: 'Last backup'
	String get last_backup => 'Last backup';

	/// en: 'Size'
	String get size => 'Size';
}

// Path: settings.general
class TranslationsSettingsGeneralEn {
	TranslationsSettingsGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General Settings'
	String get menu_title => 'General Settings';

	/// en: 'Language, privacy, and more'
	String get menu_descr => 'Language, privacy, and more';

	late final TranslationsSettingsGeneralLanguageEn language = TranslationsSettingsGeneralLanguageEn._(_root);
	late final TranslationsSettingsGeneralLocaleEn locale = TranslationsSettingsGeneralLocaleEn._(_root);
}

// Path: settings.security
class TranslationsSettingsSecurityEn {
	TranslationsSettingsSecurityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Security'
	String get title => 'Security';

	/// en: 'Private mode at launch'
	String get private_mode_at_launch => 'Private mode at launch';

	/// en: 'Launch the app in private mode by default'
	String get private_mode_at_launch_descr => 'Launch the app in private mode by default';

	/// en: 'Private mode'
	String get private_mode => 'Private mode';

	/// en: 'Hide all monetary values'
	String get private_mode_descr => 'Hide all monetary values';

	/// en: 'Private mode activated'
	String get private_mode_activated => 'Private mode activated';

	/// en: 'Private mode disabled'
	String get private_mode_deactivated => 'Private mode disabled';
}

// Path: settings.transactions
class TranslationsSettingsTransactionsEn {
	TranslationsSettingsTransactionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Transactions'
	String get menu_title => 'Transactions';

	/// en: 'Configure the behavior of your transactions'
	String get menu_descr => 'Configure the behavior of your transactions';

	/// en: 'Transactions Settings'
	String get title => 'Transactions Settings';

	late final TranslationsSettingsTransactionsSwipeActionsEn swipe_actions = TranslationsSettingsTransactionsSwipeActionsEn._(_root);
	late final TranslationsSettingsTransactionsDefaultValuesEn default_values = TranslationsSettingsTransactionsDefaultValuesEn._(_root);
	late final TranslationsSettingsTransactionsDefaultTypeEn default_type = TranslationsSettingsTransactionsDefaultTypeEn._(_root);
}

// Path: settings.appearance
class TranslationsSettingsAppearanceEn {
	TranslationsSettingsAppearanceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Theme & Style'
	String get menu_title => 'Theme & Style';

	/// en: 'Theme selection, colors and other things related to the app appearance'
	String get menu_descr => 'Theme selection, colors and other things related to the app appearance';

	/// en: 'Theme and colors'
	String get theme_and_colors => 'Theme and colors';

	late final TranslationsSettingsAppearanceThemeEn theme = TranslationsSettingsAppearanceThemeEn._(_root);

	/// en: 'AMOLED mode'
	String get amoled_mode => 'AMOLED mode';

	/// en: 'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens'
	String get amoled_mode_descr => 'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens';

	/// en: 'Dynamic colors'
	String get dynamic_colors => 'Dynamic colors';

	/// en: 'Use your system accent color whenever possible'
	String get dynamic_colors_descr => 'Use your system accent color whenever possible';

	/// en: 'Accent color'
	String get accent_color => 'Accent color';

	/// en: 'Choose the color the app will use to emphasize certain parts of the interface'
	String get accent_color_descr => 'Choose the color the app will use to emphasize certain parts of the interface';

	/// en: 'Text'
	String get text => 'Text';

	/// en: 'Font'
	String get font => 'Font';

	/// en: 'Platform'
	String get font_platform => 'Platform';
}

// Path: more.data
class TranslationsMoreDataEn {
	TranslationsMoreDataEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Data'
	String get display => 'Data';

	/// en: 'Export and import your data so you don't lose anything'
	String get display_descr => 'Export and import your data so you don\'t lose anything';

	/// en: 'Delete my data'
	String get delete_all => 'Delete my data';

	/// en: 'Stop right there padawan ⚠️⚠️'
	String get delete_all_header1 => 'Stop right there padawan ⚠️⚠️';

	/// en: 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered'
	String get delete_all_message1 => 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';

	/// en: 'One last step ⚠️⚠️'
	String get delete_all_header2 => 'One last step ⚠️⚠️';

	/// en: 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?'
	String get delete_all_message2 => 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
}

// Path: more.about_us
class TranslationsMoreAboutUsEn {
	TranslationsMoreAboutUsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App information'
	String get display => 'App information';

	/// en: 'Find Monekin’s terms, important info, and connect by reporting bugs or sharing ideas'
	String get description => 'Find Monekin’s terms, important info, and connect by reporting bugs or sharing ideas';

	late final TranslationsMoreAboutUsLegalEn legal = TranslationsMoreAboutUsLegalEn._(_root);
	late final TranslationsMoreAboutUsProjectEn project = TranslationsMoreAboutUsProjectEn._(_root);
}

// Path: more.help_us
class TranslationsMoreHelpUsEn {
	TranslationsMoreHelpUsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Help us'
	String get display => 'Help us';

	/// en: 'Find out how you can help Monekin become better and better'
	String get description => 'Find out how you can help Monekin become better and better';

	/// en: 'Rate us'
	String get rate_us => 'Rate us';

	/// en: 'Any rate is welcome!'
	String get rate_us_descr => 'Any rate is welcome!';

	/// en: 'Share Monekin'
	String get share => 'Share Monekin';

	/// en: 'Share our app to friends and family'
	String get share_descr => 'Share our app to friends and family';

	/// en: 'Monekin! The best personal finance app. Download it here'
	String get share_text => 'Monekin! The best personal finance app. Download it here';

	/// en: 'Thank you!'
	String get thanks => 'Thank you!';

	/// en: 'Your contributions to Monekin and other open source projects, big and small, make great projects like this possible. Thank you for taking the time to contribute.'
	String get thanks_long => 'Your contributions to Monekin and other open source projects, big and small, make great projects like this possible. Thank you for taking the time to contribute.';

	/// en: 'Make a donation'
	String get donate => 'Make a donation';

	/// en: 'With your donation you will help the app continue receiving improvements. What better way than to thank the work done by inviting me to a coffee?'
	String get donate_descr => 'With your donation you will help the app continue receiving improvements. What better way than to thank the work done by inviting me to a coffee?';

	/// en: 'Donation made. Thank you very much for your contribution! ❤️'
	String get donate_success => 'Donation made. Thank you very much for your contribution! ❤️';

	/// en: 'Oops! It seems there was an error receiving your payment'
	String get donate_err => 'Oops! It seems there was an error receiving your payment';

	/// en: 'Report bugs, leave suggestions...'
	String get report => 'Report bugs, leave suggestions...';
}

// Path: general.time.ranges
class TranslationsGeneralTimeRangesEn {
	TranslationsGeneralTimeRangesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Time range'
	String get display => 'Time range';

	/// en: 'Repeats'
	String get it_repeat => 'Repeats';

	/// en: 'Ends'
	String get it_ends => 'Ends';

	/// en: 'Forever'
	String get forever => 'Forever';

	late final TranslationsGeneralTimeRangesTypesEn types = TranslationsGeneralTimeRangesTypesEn._(_root);

	/// en: '(one) {Every {{range}}} (other) {Every {{n}} {{range}}}'
	String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range}',
		other: 'Every ${n} ${range}',
	);

	/// en: '(one) {Every {{range}} until {{day}}} (other) {Every {{n}} {{range}} until {{day}}}'
	String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range} until ${day}',
		other: 'Every ${n} ${range} until ${day}',
	);

	/// en: '(one) {Every {{range}} {{limit}} times} (other) {Every {{n}} {{range}} {{limit}} times}'
	String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range} ${limit} times',
		other: 'Every ${n} ${range} ${limit} times',
	);

	/// en: '(one) {Every {{range}} once} (other) {Every {{n}} {{range}} once}'
	String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Every ${range} once',
		other: 'Every ${n} ${range} once',
	);

	/// en: '(one) {Month} (other) {Months}'
	String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Month',
		other: 'Months',
	);

	/// en: '(one) {Year} (other) {Years}'
	String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Year',
		other: 'Years',
	);

	/// en: '(one) {Day} (other) {Days}'
	String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Day',
		other: 'Days',
	);

	/// en: '(one) {Week} (other) {Weeks}'
	String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Week',
		other: 'Weeks',
	);
}

// Path: general.time.periodicity
class TranslationsGeneralTimePeriodicityEn {
	TranslationsGeneralTimePeriodicityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recurrence'
	String get display => 'Recurrence';

	/// en: 'No repeat'
	String get no_repeat => 'No repeat';

	/// en: '(one) {Repetition} (other) {Repetitions}'
	String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Repetition',
		other: 'Repetitions',
	);

	/// en: 'Daily'
	String get diary => 'Daily';

	/// en: 'Monthly'
	String get monthly => 'Monthly';

	/// en: 'Annually'
	String get annually => 'Annually';

	/// en: 'Quarterly'
	String get quaterly => 'Quarterly';

	/// en: 'Weekly'
	String get weekly => 'Weekly';

	/// en: 'Custom'
	String get custom => 'Custom';

	/// en: 'Always'
	String get infinite => 'Always';
}

// Path: general.time.current
class TranslationsGeneralTimeCurrentEn {
	TranslationsGeneralTimeCurrentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This month'
	String get monthly => 'This month';

	/// en: 'This year'
	String get annually => 'This year';

	/// en: 'This quarter'
	String get quaterly => 'This quarter';

	/// en: 'This week'
	String get weekly => 'This week';

	/// en: 'For ever'
	String get infinite => 'For ever';

	/// en: 'Custom Range'
	String get custom => 'Custom Range';
}

// Path: general.time.all
class TranslationsGeneralTimeAllEn {
	TranslationsGeneralTimeAllEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Every day'
	String get diary => 'Every day';

	/// en: 'Every month'
	String get monthly => 'Every month';

	/// en: 'Every year'
	String get annually => 'Every year';

	/// en: 'Every quarterly'
	String get quaterly => 'Every quarterly';

	/// en: 'Every week'
	String get weekly => 'Every week';
}

// Path: financial_health.review.descr
class TranslationsFinancialHealthReviewDescrEn {
	TranslationsFinancialHealthReviewDescrEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'It looks like we don't have enough expenses to calculate your financial health. Add some expenses/incomes in this period to allow us to help you!'
	String get insufficient_data => 'It looks like we don\'t have enough expenses to calculate your financial health. Add some expenses/incomes in this period to allow us to help you!';

	/// en: 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin'
	String get very_good => 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';

	/// en: 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!'
	String get good => 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';

	/// en: 'Your financial health is more or less in the average of the rest of the population for this period'
	String get normal => 'Your financial health is more or less in the average of the rest of the population for this period';

	/// en: 'It seems that your financial situation is not the best yet. Explore the rest of the charts to learn more about your finances'
	String get bad => 'It seems that your financial situation is not the best yet. Explore the rest of the charts to learn more about your finances';

	/// en: 'Hmm, your financial health is far below what it should be. Explore the rest of the charts to learn more about your finances'
	String get very_bad => 'Hmm, your financial health is far below what it should be. Explore the rest of the charts to learn more about your finances';
}

// Path: financial_health.savings_percentage.text
class TranslationsFinancialHealthSavingsPercentageTextEn {
	TranslationsFinancialHealthSavingsPercentageTextEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Congratulations! You have managed to save <b>{{value}}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!'
	String good({required Object value}) => 'Congratulations! You have managed to save <b>${value}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!';

	/// en: 'Congratulations, you have managed to save <b>{{value}}%</b> of your income during this period.'
	String normal({required Object value}) => 'Congratulations, you have managed to save <b>${value}%</b> of your income during this period.';

	/// en: 'You have managed to save <b>{{value}}%</b> of your income during this period. However, we think you can still do much more!'
	String bad({required Object value}) => 'You have managed to save <b>${value}%</b> of your income during this period. However, we think you can still do much more!';

	/// en: 'Wow, you haven't managed to save anything during this period.'
	String get very_bad => 'Wow, you haven\'t managed to save anything during this period.';
}

// Path: transaction.list.bulk_edit
class TranslationsTransactionListBulkEditEn {
	TranslationsTransactionListBulkEditEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit dates'
	String get dates => 'Edit dates';

	/// en: 'Edit categories'
	String get categories => 'Edit categories';

	/// en: 'Edit statuses'
	String get status => 'Edit statuses';
}

// Path: transaction.filters.saved
class TranslationsTransactionFiltersSavedEn {
	TranslationsTransactionFiltersSavedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Saved filters'
	String get title => 'Saved filters';

	/// en: 'New Filter'
	String get new_title => 'New Filter';

	/// en: 'Edit Filter'
	String get edit_title => 'Edit Filter';

	/// en: 'Filter Name'
	String get name_label => 'Filter Name';

	/// en: 'My custom filter'
	String get name_hint => 'My custom filter';

	/// en: 'Save Filter'
	String get save_dialog_title => 'Save Filter';

	/// en: 'Save current filter'
	String get save_tooltip => 'Save current filter';

	/// en: 'Load saved filter'
	String get load_tooltip => 'Load saved filter';

	/// en: 'No saved filters found'
	String get empty_title => 'No saved filters found';

	/// en: 'Save filters here to quickly access them later.'
	String get empty_description => 'Save filters here to quickly access them later.';

	/// en: 'Filter saved successfully'
	String get save_success => 'Filter saved successfully';

	/// en: 'Filter deleted successfully'
	String get delete_success => 'Filter deleted successfully';
}

// Path: transaction.form.validators
class TranslationsTransactionFormValidatorsEn {
	TranslationsTransactionFormValidatorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The value of a transaction cannot be equal to zero'
	String get zero => 'The value of a transaction cannot be equal to zero';

	/// en: 'The selected date is after the current one. The transaction will be added as pending'
	String get date_max => 'The selected date is after the current one. The transaction will be added as pending';

	/// en: 'You cannot create a transaction whose date is before the creation date of the account it belongs to'
	String get date_after_account_creation => 'You cannot create a transaction whose date is before the creation date of the account it belongs to';

	/// en: 'The monetary value of a transfer cannot be negative'
	String get negative_transfer => 'The monetary value of a transfer cannot be negative';

	/// en: 'The origin and the destination account cannot be the same'
	String get transfer_between_same_accounts => 'The origin and the destination account cannot be the same';
}

// Path: transfer.form.value_in_destiny
class TranslationsTransferFormValueInDestinyEn {
	TranslationsTransferFormValueInDestinyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Amount transferred at destination'
	String get title => 'Amount transferred at destination';

	/// en: '{{amount}} to target account'
	String amount_short({required Object amount}) => '${amount} to target account';
}

// Path: budgets.progress.labels
class TranslationsBudgetsProgressLabelsEn {
	TranslationsBudgetsProgressLabelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'On track'
	String get active_on_track => 'On track';

	/// en: 'Overspending'
	String get active_overspending => 'Overspending';

	/// en: 'Achieved'
	String get success => 'Achieved';

	/// en: 'Budget exceeded'
	String get fail => 'Budget exceeded';
}

// Path: budgets.progress.description
class TranslationsBudgetsProgressDescriptionEn {
	TranslationsBudgetsProgressDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'You can spend {{ dailyAmount }} per day for the remaining {{ remainingDays }} days'
	String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'You can spend ${dailyAmount} per day for the remaining ${remainingDays} days';

	/// en: 'To get back on track, you should limit your spending to {{ dailyAmount }} per day for the remaining {{ remainingDays }} days'
	String active_overspending({required Object dailyAmount, required Object remainingDays}) => 'To get back on track, you should limit your spending to ${dailyAmount} per day for the remaining ${remainingDays} days';

	/// en: 'You have already exceeded your budget limit by {{ amount }}. If you don't find any incomes for this budget, you should stop spending for the rest of its period'
	String active_exceeded({required Object amount}) => 'You have already exceeded your budget limit by ${amount}. If you don\'t find any incomes for this budget, you should stop spending for the rest of its period';

	/// en: 'Great job! This budget has already finish successfully. Keep creating budgets to manage your expenses'
	String get success => 'Great job! This budget has already finish successfully. Keep creating budgets to manage your expenses';

	/// en: 'You exceeded the budget by {{ amount }}. Try to be more careful next time!'
	String fail({required Object amount}) => 'You exceeded the budget by ${amount}. Try to be more careful next time!';
}

// Path: backup.import.manual_import
class TranslationsBackupImportManualImportEn {
	TranslationsBackupImportManualImportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Manual import'
	String get title => 'Manual import';

	/// en: 'Import transactions from a .csv file manually'
	String get descr => 'Import transactions from a .csv file manually';

	/// en: 'Default account'
	String get default_account => 'Default account';

	/// en: 'Remove default account'
	String get remove_default_account => 'Remove default account';

	/// en: 'Default Category'
	String get default_category => 'Default Category';

	/// en: 'Select a column from the .csv'
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

	/// en: 'Successfully imported {{x}} transactions'
	String success({required Object x}) => 'Successfully imported ${x} transactions';
}

// Path: settings.general.language
class TranslationsSettingsGeneralLanguageEn {
	TranslationsSettingsGeneralLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Language and texts'
	String get section => 'Language and texts';

	/// en: 'App language'
	String get title => 'App language';

	/// en: 'Language in which the texts will be displayed in the app'
	String get descr => 'Language in which the texts will be displayed in the app';

	/// en: 'If you want to collaborate with the translations of this app, you can consult <a href='https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n'>our guide</a>'
	String get help => 'If you want to collaborate with the translations of this app, you can consult <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>our guide</a>';
}

// Path: settings.general.locale
class TranslationsSettingsGeneralLocaleEn {
	TranslationsSettingsGeneralLocaleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Region'
	String get title => 'Region';

	/// en: 'System'
	String get auto => 'System';

	/// en: 'Set the format to use for dates, numbers...'
	String get descr => 'Set the format to use for dates, numbers...';

	/// en: 'When changing region the app will update'
	String get warn => 'When changing region the app will update';

	/// en: 'First day of week'
	String get first_day_of_week => 'First day of week';
}

// Path: settings.transactions.swipe_actions
class TranslationsSettingsTransactionsSwipeActionsEn {
	TranslationsSettingsTransactionsSwipeActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Swipe actions'
	String get title => 'Swipe actions';

	/// en: 'Choose what action will be triggered when you swipe a transaction item in the list using this swipe direction'
	String get choose_description => 'Choose what action will be triggered when you swipe a transaction item in the list using this swipe direction';

	/// en: 'Swipe left'
	String get swipe_left => 'Swipe left';

	/// en: 'Swipe right'
	String get swipe_right => 'Swipe right';

	/// en: 'No action'
	String get none => 'No action';

	/// en: 'Toggle reconciled'
	String get toggle_reconciled => 'Toggle reconciled';

	/// en: 'Toggle pending'
	String get toggle_pending => 'Toggle pending';

	/// en: 'Toggle voided'
	String get toggle_voided => 'Toggle voided';

	/// en: 'Toggle unreconciled'
	String get toggle_unreconciled => 'Toggle unreconciled';

	/// en: 'Remove status'
	String get remove_status => 'Remove status';
}

// Path: settings.transactions.default_values
class TranslationsSettingsTransactionsDefaultValuesEn {
	TranslationsSettingsTransactionsDefaultValuesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default Form Values'
	String get title => 'Default Form Values';

	/// en: 'New Transaction: Default Form Values'
	String get page_title => 'New Transaction: Default Form Values';

	/// en: 'Reuse Last Transaction Values'
	String get reuse_last_transaction => 'Reuse Last Transaction Values';

	/// en: 'Automatically fill the form with some values from the last created transaction'
	String get reuse_last_transaction_descr => 'Automatically fill the form with some values from the last created transaction';

	/// en: 'Fields to reuse'
	String get fields_to_reuse => 'Fields to reuse';

	/// en: 'Select the fields that should be pre-filled with the values from the last created transaction.'
	String get reuse_last_values_modal_descr => 'Select the fields that should be pre-filled with the values from the last created transaction.';

	/// en: 'Default Values'
	String get default_values_separator => 'Default Values';

	/// en: 'Default Category'
	String get default_category => 'Default Category';

	/// en: 'Default Status'
	String get default_status => 'Default Status';

	/// en: 'Default Tags'
	String get default_tags => 'Default Tags';

	/// en: 'No tags selected'
	String get no_tags_selected => 'No tags selected';
}

// Path: settings.transactions.default_type
class TranslationsSettingsTransactionsDefaultTypeEn {
	TranslationsSettingsTransactionsDefaultTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default Type'
	String get title => 'Default Type';

	/// en: 'Select Default Type'
	String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class TranslationsSettingsAppearanceThemeEn {
	TranslationsSettingsAppearanceThemeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Theme'
	String get title => 'Theme';

	/// en: 'System'
	String get auto => 'System';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';
}

// Path: more.about_us.legal
class TranslationsMoreAboutUsLegalEn {
	TranslationsMoreAboutUsLegalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Legal information'
	String get display => 'Legal information';

	/// en: 'Privacy policy'
	String get privacy => 'Privacy policy';

	/// en: 'Terms of use'
	String get terms => 'Terms of use';

	/// en: 'Licenses'
	String get licenses => 'Licenses';
}

// Path: more.about_us.project
class TranslationsMoreAboutUsProjectEn {
	TranslationsMoreAboutUsProjectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Project'
	String get display => 'Project';

	/// en: 'Collaborators'
	String get contributors => 'Collaborators';

	/// en: 'All the developers who have made Monekin grow'
	String get contributors_descr => 'All the developers who have made Monekin grow';

	/// en: 'Contact us'
	String get contact => 'Contact us';
}

// Path: general.time.ranges.types
class TranslationsGeneralTimeRangesTypesEn {
	TranslationsGeneralTimeRangesTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cycles'
	String get cycle => 'Cycles';

	/// en: 'Last days'
	String get last_days => 'Last days';

	/// en: '{{x}} previous days'
	String last_days_form({required Object x}) => '${x} previous days';

	/// en: 'Always'
	String get all => 'Always';

	/// en: 'Custom range'
	String get date_range => 'Custom range';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on Translations {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = 'Cancel';
		map['ui_actions.confirm'] = 'Confirm';
		map['ui_actions.continue_text'] = 'Continue';
		map['ui_actions.save'] = 'Save';
		map['ui_actions.save_changes'] = 'Save changes';
		map['ui_actions.close_and_save'] = 'Save and close';
		map['ui_actions.add'] = 'Add';
		map['ui_actions.edit'] = 'Edit';
		map['ui_actions.delete'] = 'Delete';
		map['ui_actions.see_more'] = 'See more';
		map['ui_actions.select_all'] = 'Select all';
		map['ui_actions.deselect_all'] = 'Deselect all';
		map['ui_actions.select'] = 'Select';
		map['ui_actions.search'] = 'Search';
		map['ui_actions.filter'] = 'Filter';
		map['ui_actions.reset'] = 'Reset';
		map['ui_actions.submit'] = 'Submit';
		map['ui_actions.next'] = 'Next';
		map['ui_actions.previous'] = 'Previous';
		map['ui_actions.back'] = 'Back';
		map['ui_actions.reload'] = 'Reload';
		map['ui_actions.view'] = 'View';
		map['ui_actions.download'] = 'Download';
		map['ui_actions.upload'] = 'Upload';
		map['ui_actions.retry'] = 'Retry';
		map['ui_actions.copy'] = 'Copy';
		map['ui_actions.paste'] = 'Paste';
		map['ui_actions.undo'] = 'Undo';
		map['ui_actions.redo'] = 'Redo';
		map['ui_actions.open'] = 'Open';
		map['ui_actions.close'] = 'Close';
		map['ui_actions.apply'] = 'Apply';
		map['ui_actions.discard'] = 'Discard';
		map['ui_actions.refresh'] = 'Refresh';
		map['ui_actions.share'] = 'Share';
		map['general.or'] = 'or';
		map['general.understood'] = 'Understood';
		map['general.unspecified'] = 'Unspecified';
		map['general.quick_actions'] = 'Quick actions';
		map['general.details'] = 'Details';
		map['general.balance'] = 'Balance';
		map['general.account'] = 'Account';
		map['general.accounts'] = 'Accounts';
		map['general.categories'] = 'Categories';
		map['general.category'] = 'Category';
		map['general.today'] = 'Today';
		map['general.yesterday'] = 'Yesterday';
		map['general.filters'] = 'Filters';
		map['general.empty_warn'] = 'Ops! This is very empty';
		map['general.search_no_results'] = 'No items match your search criteria';
		map['general.insufficient_data'] = 'Insufficient data';
		map['general.show_more_fields'] = 'Show more fields';
		map['general.show_less_fields'] = 'Show less fields';
		map['general.tap_to_search'] = 'Tap to search';
		map['general.leave_without_saving.title'] = 'Leave without saving?';
		map['general.leave_without_saving.message'] = 'You have unsaved changes, are you sure you want to leave without saving them?';
		map['general.clipboard.success'] = ({required Object x}) => '${x} copied to the clipboard';
		map['general.clipboard.error'] = 'Error copying';
		map['general.time.start_date'] = 'Start date';
		map['general.time.end_date'] = 'End date';
		map['general.time.from_date'] = 'From date';
		map['general.time.until_date'] = 'Until date';
		map['general.time.date'] = 'Date';
		map['general.time.datetime'] = 'Datetime';
		map['general.time.time'] = 'Time';
		map['general.time.each'] = 'Each';
		map['general.time.after'] = 'After';
		map['general.time.ranges.display'] = 'Time range';
		map['general.time.ranges.it_repeat'] = 'Repeats';
		map['general.time.ranges.it_ends'] = 'Ends';
		map['general.time.ranges.forever'] = 'Forever';
		map['general.time.ranges.types.cycle'] = 'Cycles';
		map['general.time.ranges.types.last_days'] = 'Last days';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '${x} previous days';
		map['general.time.ranges.types.all'] = 'Always';
		map['general.time.ranges.types.date_range'] = 'Custom range';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range}',
				other: 'Every ${n} ${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range} until ${day}',
				other: 'Every ${n} ${range} until ${day}',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range} ${limit} times',
				other: 'Every ${n} ${range} ${limit} times',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Every ${range} once',
				other: 'Every ${n} ${range} once',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Month',
				other: 'Months',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Year',
				other: 'Years',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Day',
				other: 'Days',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Week',
				other: 'Weeks',
			);
		map['general.time.periodicity.display'] = 'Recurrence';
		map['general.time.periodicity.no_repeat'] = 'No repeat';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Repetition',
				other: 'Repetitions',
			);
		map['general.time.periodicity.diary'] = 'Daily';
		map['general.time.periodicity.monthly'] = 'Monthly';
		map['general.time.periodicity.annually'] = 'Annually';
		map['general.time.periodicity.quaterly'] = 'Quarterly';
		map['general.time.periodicity.weekly'] = 'Weekly';
		map['general.time.periodicity.custom'] = 'Custom';
		map['general.time.periodicity.infinite'] = 'Always';
		map['general.time.current.monthly'] = 'This month';
		map['general.time.current.annually'] = 'This year';
		map['general.time.current.quaterly'] = 'This quarter';
		map['general.time.current.weekly'] = 'This week';
		map['general.time.current.infinite'] = 'For ever';
		map['general.time.current.custom'] = 'Custom Range';
		map['general.time.all.diary'] = 'Every day';
		map['general.time.all.monthly'] = 'Every month';
		map['general.time.all.annually'] = 'Every year';
		map['general.time.all.quaterly'] = 'Every quarterly';
		map['general.time.all.weekly'] = 'Every week';
		map['general.transaction_order.display'] = 'Order transactions';
		map['general.transaction_order.category'] = 'By category';
		map['general.transaction_order.quantity'] = 'By quantity';
		map['general.transaction_order.date'] = 'By date';
		map['general.validations.form_error'] = 'Fix the indicated fields to continue';
		map['general.validations.required'] = 'Required field';
		map['general.validations.positive'] = 'Should be positive';
		map['general.validations.min_number'] = ({required Object x}) => 'Should be greater than ${x}';
		map['general.validations.max_number'] = ({required Object x}) => 'Should be less than ${x}';
		map['intro.start'] = 'Start';
		map['intro.skip'] = 'Skip';
		map['intro.next'] = 'Next';
		map['intro.select_your_currency'] = 'Select your currency';
		map['intro.welcome_subtitle'] = 'Your personal finance manager';
		map['intro.welcome_subtitle2'] = '100% open, 100% free';
		map['intro.welcome_footer'] = 'By logging in you agree to the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Privacy Policy</a> and the <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Terms of Use</a> of the application';
		map['intro.offline_descr_title'] = 'OFFLINE ACCOUNT:';
		map['intro.offline_descr'] = 'Your data will only be stored on your device, and will be safe as long as you don\'t uninstall the app or change phone. To prevent data loss, it is recommended to make a backup regularly from the app settings.';
		map['intro.offline_start'] = 'Start session offline';
		map['intro.sl1_title'] = 'Select your currency';
		map['intro.sl1_descr'] = 'Your default currency will be used in reports and general charts. You will be able to change the currency and the app language later at any time in the application settings';
		map['intro.sl2_title'] = 'Safe, private and reliable';
		map['intro.sl2_descr'] = 'Your data is only yours. We store the information directly on your device, without going through external servers. This makes it possible to use the app even without internet';
		map['intro.sl2_descr2'] = 'Also, the source code of the application is public, anyone can collaborate on it and see how it works';
		map['intro.last_slide_title'] = 'All ready';
		map['intro.last_slide_descr'] = 'With Monekin, you can finally achieve the financial independence you want so much. You will have graphs, budgets, tips, statistics and much more about your money.';
		map['intro.last_slide_descr2'] = 'We hope you enjoy your experience! Do not hesitate to contact us in case of doubts, suggestions...';
		map['home.title'] = 'Dashboard';
		map['home.filter_transactions'] = 'Filter transactions';
		map['home.hello_day'] = 'Good morning,';
		map['home.hello_night'] = 'Good night,';
		map['home.total_balance'] = 'Total balance';
		map['home.my_accounts'] = 'My accounts';
		map['home.active_accounts'] = 'Active accounts';
		map['home.no_accounts'] = 'No accounts created yet';
		map['home.no_accounts_descr'] = 'Start using all the magic of Monekin. Create at least one account to start adding transactions';
		map['home.last_transactions'] = 'Last transactions';
		map['home.should_create_account_header'] = 'Oops!';
		map['home.should_create_account_message'] = 'You must have at least one no-archived account before you can start creating transactions';
		map['financial_health.display'] = 'Financial health';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Very good!';
					case GenderContext.female:
						return 'Very good!';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Good';
					case GenderContext.female:
						return 'Good';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Average';
					case GenderContext.female:
						return 'Average';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Fair';
					case GenderContext.female:
						return 'Fair';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Very Bad';
					case GenderContext.female:
						return 'Very Bad';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Insufficient data';
					case GenderContext.female:
						return 'Insufficient data';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = 'It looks like we don\'t have enough expenses to calculate your financial health. Add some expenses/incomes in this period to allow us to help you!';
		map['financial_health.review.descr.very_good'] = 'Congratulations! Your financial health is tremendous. We hope you continue your good streak and continue learning with Monekin';
		map['financial_health.review.descr.good'] = 'Great! Your financial health is good. Visit the analysis tab to see how to save even more!';
		map['financial_health.review.descr.normal'] = 'Your financial health is more or less in the average of the rest of the population for this period';
		map['financial_health.review.descr.bad'] = 'It seems that your financial situation is not the best yet. Explore the rest of the charts to learn more about your finances';
		map['financial_health.review.descr.very_bad'] = 'Hmm, your financial health is far below what it should be. Explore the rest of the charts to learn more about your finances';
		map['financial_health.months_without_income.title'] = 'Survival rate';
		map['financial_health.months_without_income.subtitle'] = 'Given your balance, amount of time you could go without income';
		map['financial_health.months_without_income.text_zero'] = 'You couldn\'t survive a month without income at this rate of expenses!';
		map['financial_health.months_without_income.text_one'] = 'You could barely survive approximately a month without income at this rate of expenses!';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => 'You could survive approximately <b>${n} months</b> without income at this rate of spending.';
		map['financial_health.months_without_income.text_infinite'] = 'You could survive approximately <b>all your life</b> without income at this rate of spending.';
		map['financial_health.months_without_income.suggestion'] = 'Remember that it is advisable to always keep this ratio above 5 months at least. If you see that you do not have a sufficient savings cushion, reduce unnecessary expenses.';
		map['financial_health.months_without_income.insufficient_data'] = 'It looks like we don\'t have enough expenses to calculate how many months you could survive without income. Enter a few transactions and come back here to check your financial health';
		map['financial_health.savings_percentage.title'] = 'Savings percentage';
		map['financial_health.savings_percentage.subtitle'] = 'What part of your income is not spent in this period';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => 'Congratulations! You have managed to save <b>${value}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => 'Congratulations, you have managed to save <b>${value}%</b> of your income during this period.';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => 'You have managed to save <b>${value}%</b> of your income during this period. However, we think you can still do much more!';
		map['financial_health.savings_percentage.text.very_bad'] = 'Wow, you haven\'t managed to save anything during this period.';
		map['financial_health.savings_percentage.suggestion'] = 'Remember that it is advisable to save at least 15-20% of what you earn.';
		map['stats.title'] = 'Statistics';
		map['stats.balance'] = 'Balance';
		map['stats.final_balance'] = 'Final balance';
		map['stats.balance_by_account'] = 'Balance by accounts';
		map['stats.balance_by_account_subtitle'] = 'Where do I have most of my money?';
		map['stats.balance_by_currency'] = 'Balance by currency';
		map['stats.balance_by_currency_subtitle'] = 'How much money do I have in foreign currency?';
		map['stats.balance_evolution'] = 'Balance trend';
		map['stats.balance_evolution_subtitle'] = 'Do I have more money than before?';
		map['stats.compared_to_previous_period'] = 'Compared to the previous period';
		map['stats.cash_flow'] = 'Cash flow';
		map['stats.cash_flow_subtitle'] = 'Am I spending less than I earn?';
		map['stats.by_periods'] = 'By periods';
		map['stats.by_categories'] = 'By categories';
		map['stats.by_tags'] = 'By tags';
		map['stats.distribution'] = 'Distribution';
		map['stats.finance_health_resume'] = 'Resume';
		map['stats.finance_health_breakdown'] = 'Breakdown';
		map['icon_selector.name'] = 'Name:';
		map['icon_selector.icon'] = 'Icon';
		map['icon_selector.color'] = 'Color';
		map['icon_selector.select_icon'] = 'Select an icon';
		map['icon_selector.select_color'] = 'Select a color';
		map['icon_selector.custom_color'] = 'Custom color';
		map['icon_selector.current_color_selection'] = 'Current selection';
		map['icon_selector.select_account_icon'] = 'Identify your account';
		map['icon_selector.select_category_icon'] = 'Identify your category';
		map['icon_selector.scopes.transport'] = 'Transport';
		map['icon_selector.scopes.money'] = 'Money';
		map['icon_selector.scopes.food'] = 'Food';
		map['icon_selector.scopes.medical'] = 'Health';
		map['icon_selector.scopes.entertainment'] = 'Leisure';
		map['icon_selector.scopes.technology'] = 'Technology';
		map['icon_selector.scopes.other'] = 'Others';
		map['icon_selector.scopes.logos_financial_institutions'] = 'Financial institutions';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Transaction',
				other: 'Transactions',
			);
		map['transaction.create'] = 'New transaction';
		map['transaction.new_income'] = 'New income';
		map['transaction.new_expense'] = 'New expense';
		map['transaction.new_success'] = 'Transaction created successfully';
		map['transaction.edit'] = 'Edit transaction';
		map['transaction.edit_success'] = 'Transaction edited successfully';
		map['transaction.edit_multiple'] = 'Edit transactions';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x} transactions edited successfully';
		map['transaction.duplicate'] = 'Clone transaction';
		map['transaction.duplicate_short'] = 'Clone';
		map['transaction.duplicate_warning_message'] = 'A transaction identical to this will be created with the same date, do you want to continue?';
		map['transaction.duplicate_success'] = 'Transaction cloned successfully';
		map['transaction.delete'] = 'Delete transaction';
		map['transaction.delete_warning_message'] = 'This action is irreversible. The current balance of your accounts and all your statistics will be recalculated';
		map['transaction.delete_success'] = 'Transaction deleted correctly';
		map['transaction.delete_multiple'] = 'Delete transactions';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => 'This action is irreversible and will remove ${x} transactions. The current balance of your accounts and all your statistics will be recalculated';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x} transactions deleted correctly';
		map['transaction.details'] = 'Movement details';
		map['transaction.next_payments.accept'] = 'Accept';
		map['transaction.next_payments.skip'] = 'Skip';
		map['transaction.next_payments.skip_success'] = 'Successfully skipped transaction';
		map['transaction.next_payments.skip_dialog_title'] = 'Skip transaction';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => 'This action is irreversible. We will move the date of the next move to ${date}';
		map['transaction.next_payments.accept_today'] = 'Accept today';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => 'Accept in required date (${date})';
		map['transaction.next_payments.accept_dialog_title'] = 'Accept transaction';
		map['transaction.next_payments.accept_dialog_msg_single'] = 'The new status of the transaction will be null. You can re-edit the status of this transaction whenever you want';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => 'This action will create a new transaction with date ${date}. You will be able to check the details of this transaction on the transaction page';
		map['transaction.next_payments.recurrent_rule_finished'] = 'The recurring rule has been completed, there are no more payments to make!';
		map['transaction.list.all'] = 'All transactions';
		map['transaction.list.empty'] = 'No transactions found to display here. Add a few transactions in the app and maybe you\'ll have better luck next time.';
		map['transaction.list.searcher_placeholder'] = 'Search by category, description...';
		map['transaction.list.searcher_no_results'] = 'No transactions found matching the search criteria';
		map['transaction.list.loading'] = 'Loading more transactions...';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} selected',
				other: '${n} selected',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} transaction selected',
				other: '${n} transactions selected',
			);
		map['transaction.list.bulk_edit.dates'] = 'Edit dates';
		map['transaction.list.bulk_edit.categories'] = 'Edit categories';
		map['transaction.list.bulk_edit.status'] = 'Edit statuses';
		map['transaction.filters.title'] = 'Transaction filters';
		map['transaction.filters.from_value'] = 'From amount';
		map['transaction.filters.to_value'] = 'Up to amount';
		map['transaction.filters.from_value_def'] = ({required Object x}) => 'From ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => 'Up to ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => 'From the ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => 'Up to the ${date}';
		map['transaction.filters.reset'] = 'Reset filters';
		map['transaction.filters.saved.title'] = 'Saved filters';
		map['transaction.filters.saved.new_title'] = 'New Filter';
		map['transaction.filters.saved.edit_title'] = 'Edit Filter';
		map['transaction.filters.saved.name_label'] = 'Filter Name';
		map['transaction.filters.saved.name_hint'] = 'My custom filter';
		map['transaction.filters.saved.save_dialog_title'] = 'Save Filter';
		map['transaction.filters.saved.save_tooltip'] = 'Save current filter';
		map['transaction.filters.saved.load_tooltip'] = 'Load saved filter';
		map['transaction.filters.saved.empty_title'] = 'No saved filters found';
		map['transaction.filters.saved.empty_description'] = 'Save filters here to quickly access them later.';
		map['transaction.filters.saved.save_success'] = 'Filter saved successfully';
		map['transaction.filters.saved.delete_success'] = 'Filter deleted successfully';
		map['transaction.form.validators.zero'] = 'The value of a transaction cannot be equal to zero';
		map['transaction.form.validators.date_max'] = 'The selected date is after the current one. The transaction will be added as pending';
		map['transaction.form.validators.date_after_account_creation'] = 'You cannot create a transaction whose date is before the creation date of the account it belongs to';
		map['transaction.form.validators.negative_transfer'] = 'The monetary value of a transfer cannot be negative';
		map['transaction.form.validators.transfer_between_same_accounts'] = 'The origin and the destination account cannot be the same';
		map['transaction.form.title'] = 'Transaction title';
		map['transaction.form.title_short'] = 'Title';
		map['transaction.form.value'] = 'Value of the transaction';
		map['transaction.form.tap_to_see_more'] = 'Tap to see more details';
		map['transaction.form.no_tags'] = '-- No tags --';
		map['transaction.form.description'] = 'Description';
		map['transaction.form.description_info'] = 'Tap here to enter a more detailed description about this transaction';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => 'Exchnage rate to ${currency}';
		map['transaction.form.exchange_to_preferred_in_date'] = 'On transaction date';
		map['transaction.reversed.title'] = 'Inverse transaction';
		map['transaction.reversed.title_short'] = 'Inverse tr.';
		map['transaction.reversed.description_for_expenses'] = 'Despite being an expense transaction, it has a positive amount. These types of transactions can be used to represent the return of a previously recorded expense, such as a refund or having the payment of a debt.';
		map['transaction.reversed.description_for_incomes'] = 'Despite being an income transaction, it has a negative amount. These types of transactions can be used to void or correct an income that was incorrectly recorded, to reflect a return or refund of money or to record payment of debts.';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Status',
				other: 'Statuses',
			);
		map['transaction.status.display_long'] = 'Transaction status';
		map['transaction.status.tr_status'] = ({required Object status}) => '${status} transaction';
		map['transaction.status.none'] = 'Stateless';
		map['transaction.status.none_descr'] = 'Transaction without a specific state';
		map['transaction.status.reconciled'] = 'Reconciled';
		map['transaction.status.reconciled_descr'] = 'This transaction has already been validated and corresponds to a real transaction from your bank';
		map['transaction.status.unreconciled'] = 'Unreconciled';
		map['transaction.status.unreconciled_descr'] = 'This transaction has not yet been validated and therefore does not yet appear in your real bank accounts. However, it counts for the calculation of balances and statistics in Monekin';
		map['transaction.status.pending'] = 'Pending';
		map['transaction.status.pending_descr'] = 'This transaction is pending and therefore it will not be taken into account when calculating balances and statistics';
		map['transaction.status.voided'] = 'Voided';
		map['transaction.status.voided_descr'] = 'Void/cancelled transaction due to payment error or any other reason. It will not be taken into account when calculating balances and statistics';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Transaction type',
				other: 'Transaction types',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Income',
				other: 'Incomes',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Expense',
				other: 'Expenses',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Transfer',
				other: 'Transfers',
			);
		map['transfer.display'] = 'Transfer';
		map['transfer.transfers'] = 'Transfers';
		map['transfer.transfer_to'] = ({required Object account}) => 'Transfer to ${account}';
		map['transfer.create'] = 'New Transfer';
		map['transfer.need_two_accounts_warning_header'] = 'Ops!';
		map['transfer.need_two_accounts_warning_message'] = 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
		map['transfer.form.from'] = 'Origin account';
		map['transfer.form.to'] = 'Destination account';
		map['transfer.form.value_in_destiny.title'] = 'Amount transferred at destination';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} to target account';
		map['recurrent_transactions.title'] = 'Recurrent transactions';
		map['recurrent_transactions.title_short'] = 'Rec. transactions';
		map['recurrent_transactions.empty'] = 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
		map['recurrent_transactions.total_expense_title'] = 'Total expense per period';
		map['recurrent_transactions.total_expense_descr'] = '* Without considering the start and end date of each recurrence';
		map['recurrent_transactions.details.title'] = 'Recurrent transaction';
		map['recurrent_transactions.details.descr'] = 'The next moves for this transaction are shown below. You can accept the first move or skip this move';
		map['recurrent_transactions.details.last_payment_info'] = 'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action';
		map['recurrent_transactions.details.delete_header'] = 'Delete recurring transaction';
		map['recurrent_transactions.details.delete_message'] = 'This action is irreversible and will not affect transactions you have already confirmed/paid for';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => 'Delayed by ${x}d';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => 'In ${x} days';
		map['account.details'] = 'Account details';
		map['account.date'] = 'Opening date';
		map['account.close_date'] = 'Closing date';
		map['account.reopen'] = 'Re-open account';
		map['account.reopen_short'] = 'Re-open';
		map['account.reopen_descr'] = 'Are you sure you want to reopen this account?';
		map['account.balance'] = 'Account balance';
		map['account.n_transactions'] = 'Number of transactions';
		map['account.add_money'] = 'Add money';
		map['account.withdraw_money'] = 'Withdraw money';
		map['account.no_accounts'] = 'No accounts found to display here. Add an account by clicking the \'+\' button at the bottom';
		map['account.types.title'] = 'Account type';
		map['account.types.warning'] = 'Once the type of account has been chosen, it cannot be changed in the future';
		map['account.types.normal'] = 'Normal account';
		map['account.types.normal_descr'] = 'Useful to record your day-to-day finances. It is the most common account, it allows you to add expenses, income...';
		map['account.types.saving'] = 'Savings account';
		map['account.types.saving_descr'] = 'You will only be able to add and withdraw money from it from other accounts. Perfect to start saving money';
		map['account.form.name'] = 'Account name';
		map['account.form.name_placeholder'] = 'Ex: Savings account';
		map['account.form.notes'] = 'Notes';
		map['account.form.notes_placeholder'] = 'Type some notes/description about this account';
		map['account.form.initial_balance'] = 'Initial balance';
		map['account.form.current_balance'] = 'Current balance';
		map['account.form.create'] = 'Create account';
		map['account.form.edit'] = 'Edit account';
		map['account.form.currency_not_found_warn'] = 'You do not have information on exchange rates for this currency. 1.0 will be used as the default exchange rate. You can modify this in the settings';
		map['account.form.already_exists'] = 'There is already another one with the same name, please write another';
		map['account.form.tr_before_opening_date'] = 'There are transactions in this account with a date before the opening date';
		map['account.form.iban'] = 'IBAN';
		map['account.form.swift'] = 'SWIFT';
		map['account.delete.warning_header'] = 'Delete account?';
		map['account.delete.warning_text'] = 'This action will delete this account and all its transactions';
		map['account.delete.success'] = 'Account deleted successfully';
		map['account.close.title'] = 'Close account';
		map['account.close.title_short'] = 'Close';
		map['account.close.warn'] = 'This account will no longer appear in certain listings and you will not be able to create transactions in it with a date later than the one specified below. This action does not affect any transactions or balance, and you can also reopen this account at any time. ';
		map['account.close.should_have_zero_balance'] = 'You must have a current balance of 0 in this account to close it. Please edit the account before continuing';
		map['account.close.should_have_no_transactions'] = 'This account has transactions after the specified close date. Delete them or edit the account close date before continuing';
		map['account.close.success'] = 'Account closed successfully';
		map['account.close.unarchive_succes'] = 'Account successfully re-opened';
		map['account.select.one'] = 'Select an account';
		map['account.select.all'] = 'All accounts';
		map['account.select.multiple'] = 'Select accounts';
		map['currencies.currency_converter'] = 'Currency converter';
		map['currencies.currency'] = 'Currency';
		map['currencies.currency_settings'] = 'Currency settings';
		map['currencies.currency_manager'] = 'Currency manager';
		map['currencies.currency_manager_descr'] = 'Configure your currency and its exchange rates with others';
		map['currencies.preferred_currency'] = 'Preferred/base currency';
		map['currencies.tap_to_change_preferred_currency'] = 'Tap to change';
		map['currencies.change_preferred_currency_title'] = 'Change preferred currency';
		map['currencies.change_preferred_currency_msg'] = 'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?';
		map['currencies.exchange_rate_form.equal_to_preferred_warn'] = 'The currency cannot be equal to the user currency';
		map['currencies.exchange_rate_form.override_existing_warn'] = 'An exchange rate for this currency in this date already exists. If you continue, the previous one will be overwritten';
		map['currencies.exchange_rate_form.specify_a_currency'] = 'Please specify a currency';
		map['currencies.exchange_rate_form.add'] = 'Add exchange rate';
		map['currencies.exchange_rate_form.add_success'] = 'Exchange rate added successfully';
		map['currencies.exchange_rate_form.edit'] = 'Edit exchange rate';
		map['currencies.exchange_rate_form.edit_success'] = 'Exchange rate edited successfully';
		map['currencies.exchange_rate_form.remove_all'] = 'Delete all exchange rates';
		map['currencies.exchange_rate_form.remove_all_warning'] = 'This action is irreversible and will delete all exchange rates for this currency';
		map['currencies.types.display'] = 'Currency type';
		map['currencies.types.fiat'] = 'FIAT';
		map['currencies.types.crypto'] = 'Cryptocurrency';
		map['currencies.types.other'] = 'Other';
		map['currencies.currency_form.name'] = 'Display Name';
		map['currencies.currency_form.code'] = 'Currency Code';
		map['currencies.currency_form.symbol'] = 'Symbol';
		map['currencies.currency_form.decimal_digits'] = 'Decimal Digits';
		map['currencies.currency_form.create'] = 'Create currency';
		map['currencies.currency_form.create_success'] = 'Currency created successfully';
		map['currencies.currency_form.edit'] = 'Edit currency';
		map['currencies.currency_form.edit_success'] = 'Currency edited successfully';
		map['currencies.currency_form.delete'] = 'Delete currency';
		map['currencies.currency_form.delete_success'] = 'Currency deleted successfully';
		map['currencies.currency_form.already_exists'] = 'A currency with this code already exists. You may want to edit it';
		map['currencies.delete_all_success'] = 'Deleted exchange rates successfully';
		map['currencies.historical'] = 'Historical rates';
		map['currencies.historical_empty'] = 'No historical exchange rates found for this currency';
		map['currencies.exchange_rate'] = 'Exchange rate';
		map['currencies.exchange_rates'] = 'Exchange rates';
		map['currencies.min_exchange_rate'] = 'Minimum exchange rate';
		map['currencies.max_exchange_rate'] = 'Maximum exchange rate';
		map['currencies.empty'] = 'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate';
		map['currencies.select_a_currency'] = 'Select a currency';
		map['currencies.search'] = 'Search by name or by currency code';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: 'Label',
				other: 'Tags',
			);
		map['tags.form.name'] = 'Tag name';
		map['tags.form.description'] = 'Description';
		map['tags.select.title'] = 'Select tags';
		map['tags.select.all'] = 'All the tags';
		map['tags.empty_list'] = 'You haven\'t created any tags yet. Tags and categories are a great way to categorize your movements';
		map['tags.without_tags'] = 'Without tags';
		map['tags.add'] = 'Add tag';
		map['tags.create'] = 'Create label';
		map['tags.create_success'] = 'Label created successfully';
		map['tags.already_exists'] = 'This tag name already exists. You may want to edit it';
		map['tags.edit'] = 'Edit tag';
		map['tags.edit_success'] = 'Tag edited successfully';
		map['tags.delete_success'] = 'Category deleted successfully';
		map['tags.delete_warning_header'] = 'Delete tag?';
		map['tags.delete_warning_message'] = 'This action will not delete transactions that have this tag.';
		map['categories.unknown'] = 'Unknown category';
		map['categories.create'] = 'Create category';
		map['categories.create_success'] = 'Category created correctly';
		map['categories.new_category'] = 'New category';
		map['categories.already_exists'] = 'The name of this category already exists. Maybe you want to edit it';
		map['categories.edit'] = 'Edit category';
		map['categories.edit_success'] = 'Category edited correctly';
		map['categories.name'] = 'Category name';
		map['categories.type'] = 'Category type';
		map['categories.both_types'] = 'Both types';
		map['categories.subcategories'] = 'Subcategories';
		map['categories.subcategories_add'] = 'Add subcategory';
		map['categories.make_parent'] = 'Make to category';
		map['categories.make_child'] = 'Make a subcategory';
		map['categories.make_child_warning1'] = ({required Object destiny}) => 'This category and its subcategories will become subcategories of <b>${destiny}</b>.';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => 'Their transactions <b>(${x})</b> will be moved to the new subcategories created within the <b>${destiny}</b> category.';
		map['categories.make_child_success'] = 'Subcategories created successfully';
		map['categories.merge'] = 'Merge with another category';
		map['categories.merge_warning1'] = ({required Object x, required Object from, required Object destiny}) => 'All transactions (${x}) associated with the category <b>${from}</b> will be moved to the category <b>${destiny}</b>';
		map['categories.merge_warning2'] = ({required Object from}) => 'The category <b>${from}</b> will be irreversibly deleted.';
		map['categories.merge_success'] = 'Category merged successfully';
		map['categories.delete_success'] = 'Category deleted correctly';
		map['categories.delete_warning_header'] = 'Delete category?';
		map['categories.delete_warning_message'] = ({required Object x}) => 'This action will irreversibly delete all transactions <b>(${x})</b> related to this category.';
		map['categories.select.title'] = 'Select categories';
		map['categories.select.select_one'] = 'Select a category';
		map['categories.select.select_subcategory'] = 'Choose a subcategory';
		map['categories.select.without_subcategory'] = 'Without subcategory';
		map['categories.select.all'] = 'All categories';
		map['categories.select.all_short'] = 'All';
		map['budgets.title'] = 'Budgets';
		map['budgets.repeated'] = 'Recurring';
		map['budgets.one_time'] = 'Once';
		map['budgets.annual'] = 'Annuals';
		map['budgets.week'] = 'Weekly';
		map['budgets.month'] = 'Monthly';
		map['budgets.actives'] = 'Actives';
		map['budgets.pending'] = 'Pending start';
		map['budgets.finish'] = 'Finished';
		map['budgets.from_budgeted'] = 'left of ';
		map['budgets.days_left'] = 'days left';
		map['budgets.days_to_start'] = 'days to start';
		map['budgets.since_expiration'] = 'days since expiration';
		map['budgets.no_budgets'] = 'There seem to be no budgets to display in this section. Start by creating a budget by clicking the button below';
		map['budgets.delete'] = 'Delete budget';
		map['budgets.delete_warning'] = 'This action is irreversible. Categories and transactions referring to this quote will not be deleted';
		map['budgets.form.title'] = 'Add a budget';
		map['budgets.form.name'] = 'Budget name';
		map['budgets.form.value'] = 'Limit quantity';
		map['budgets.form.create'] = 'Add budget';
		map['budgets.form.create_success'] = 'Budget created successfully';
		map['budgets.form.edit'] = 'Edit budget';
		map['budgets.form.edit_success'] = 'Budget edited successfully';
		map['budgets.form.negative_warn'] = 'The budgets can not have a negative amount';
		map['budgets.details.title'] = 'Budget Details';
		map['budgets.details.statistics'] = 'Statistics';
		map['budgets.details.budget_value'] = 'Budgeted';
		map['budgets.details.expend_evolution'] = 'Expenditure evolution';
		map['budgets.details.no_transactions'] = 'It seems that you have not made any expenses related to this budget';
		map['budgets.target_timeline_statuses.active'] = 'Active budget';
		map['budgets.target_timeline_statuses.past'] = 'Past budget';
		map['budgets.target_timeline_statuses.future'] = 'Future budget';
		map['budgets.progress.labels.active_on_track'] = 'On track';
		map['budgets.progress.labels.active_overspending'] = 'Overspending';
		map['budgets.progress.labels.success'] = 'Achieved';
		map['budgets.progress.labels.fail'] = 'Budget exceeded';
		map['budgets.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'You can spend ${dailyAmount} per day for the remaining ${remainingDays} days';
		map['budgets.progress.description.active_overspending'] = ({required Object dailyAmount, required Object remainingDays}) => 'To get back on track, you should limit your spending to ${dailyAmount} per day for the remaining ${remainingDays} days';
		map['budgets.progress.description.active_exceeded'] = ({required Object amount}) => 'You have already exceeded your budget limit by ${amount}. If you don\'t find any incomes for this budget, you should stop spending for the rest of its period';
		map['budgets.progress.description.success'] = 'Great job! This budget has already finish successfully. Keep creating budgets to manage your expenses';
		map['budgets.progress.description.fail'] = ({required Object amount}) => 'You exceeded the budget by ${amount}. Try to be more careful next time!';
		map['target_timeline_statuses.active'] = 'Active';
		map['target_timeline_statuses.past'] = 'Past';
		map['target_timeline_statuses.future'] = 'Future';
		map['backup.no_file_selected'] = 'No file selected';
		map['backup.no_directory_selected'] = 'No directory selected';
		map['backup.export.title'] = 'Export your data';
		map['backup.export.title_short'] = 'Export';
		map['backup.export.type_of_export'] = 'Type of export';
		map['backup.export.other_options'] = 'Options';
		map['backup.export.all'] = 'Full backup';
		map['backup.export.all_descr'] = 'Export all your data (accounts, transactions, budgets, settings...). Import them again at any time so you don\'t lose anything.';
		map['backup.export.transactions'] = 'Transactions backup';
		map['backup.export.transactions_descr'] = 'Export your transactions in CSV so you can more easily analyze them in other programs or applications.';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '1 transaction to export',
				other: '${n} transactions to export',
			);
		map['backup.export.description'] = 'Download your data in different formats';
		map['backup.export.send_file'] = 'Send file';
		map['backup.export.see_folder'] = 'See folder';
		map['backup.export.success'] = ({required Object x}) => 'File saved successfully in ${x}';
		map['backup.export.error'] = 'Error downloading the file. Please contact the developer via lozin.technologies@gmail.com';
		map['backup.import.title'] = 'Import your data';
		map['backup.import.title_short'] = 'Import';
		map['backup.import.restore_backup'] = 'Restore Backup';
		map['backup.import.restore_backup_descr'] = 'Import a previously saved database from Monekin. This action will replace any current application data with the new data';
		map['backup.import.restore_backup_warn_description'] = 'When importing a new database, you will lose all data currently saved in the app. It is recommended to make a backup before continuing. Do not upload here any file whose origin you do not know, upload only files that you have previously downloaded from Monekin';
		map['backup.import.restore_backup_warn_title'] = 'Overwrite all data';
		map['backup.import.select_other_file'] = 'Select other file';
		map['backup.import.tap_to_select_file'] = 'Tap to select a file';
		map['backup.import.manual_import.title'] = 'Manual import';
		map['backup.import.manual_import.descr'] = 'Import transactions from a .csv file manually';
		map['backup.import.manual_import.default_account'] = 'Default account';
		map['backup.import.manual_import.remove_default_account'] = 'Remove default account';
		map['backup.import.manual_import.default_category'] = 'Default Category';
		map['backup.import.manual_import.select_a_column'] = 'Select a column from the .csv';
		map['backup.import.manual_import.steps.0'] = 'Select your file';
		map['backup.import.manual_import.steps.1'] = 'Column for quantity';
		map['backup.import.manual_import.steps.2'] = 'Column for account';
		map['backup.import.manual_import.steps.3'] = 'Column for category';
		map['backup.import.manual_import.steps.4'] = 'Column for date';
		map['backup.import.manual_import.steps.5'] = 'other columns';
		map['backup.import.manual_import.steps_descr.0'] = 'Select a .csv file from your device. Make sure it has a first row that describes the name of each column';
		map['backup.import.manual_import.steps_descr.1'] = 'Select the column where the value of each transaction is specified. Use negative values for expenses and positive values for income. Use a point as a decimal separator';
		map['backup.import.manual_import.steps_descr.2'] = 'Select the column where the account to which each transaction belongs is specified. You can also select a default account in case we cannot find the account you want. If a default account is not specified, we will create one with the same name ';
		map['backup.import.manual_import.steps_descr.3'] = 'Specify the column where the transaction category name is located. You must specify a default category so that we assign this category to transactions, in case the category cannot be found';
		map['backup.import.manual_import.steps_descr.4'] = 'Select the column where the date of each transaction is specified. If not specified, transactions will be created with the current date';
		map['backup.import.manual_import.steps_descr.5'] = 'Specifies the columns for other optional transaction attributes';
		map['backup.import.manual_import.success'] = ({required Object x}) => 'Successfully imported ${x} transactions';
		map['backup.import.success'] = 'Import performed successfully';
		map['backup.import.error'] = 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
		map['backup.about.title'] = 'Information about your database';
		map['backup.about.create_date'] = 'Creation date';
		map['backup.about.modify_date'] = 'Last modified';
		map['backup.about.last_backup'] = 'Last backup';
		map['backup.about.size'] = 'Size';
		map['settings.title_long'] = 'Settings & Customization';
		map['settings.title_short'] = 'Settings';
		map['settings.description'] = 'Theme, Language, Data and more';
		map['settings.edit_profile'] = 'Edit profile';
		map['settings.general.menu_title'] = 'General Settings';
		map['settings.general.menu_descr'] = 'Language, privacy, and more';
		map['settings.general.language.section'] = 'Language and texts';
		map['settings.general.language.title'] = 'App language';
		map['settings.general.language.descr'] = 'Language in which the texts will be displayed in the app';
		map['settings.general.language.help'] = 'If you want to collaborate with the translations of this app, you can consult <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>our guide</a>';
		map['settings.general.locale.title'] = 'Region';
		map['settings.general.locale.auto'] = 'System';
		map['settings.general.locale.descr'] = 'Set the format to use for dates, numbers...';
		map['settings.general.locale.warn'] = 'When changing region the app will update';
		map['settings.general.locale.first_day_of_week'] = 'First day of week';
		map['settings.security.title'] = 'Security';
		map['settings.security.private_mode_at_launch'] = 'Private mode at launch';
		map['settings.security.private_mode_at_launch_descr'] = 'Launch the app in private mode by default';
		map['settings.security.private_mode'] = 'Private mode';
		map['settings.security.private_mode_descr'] = 'Hide all monetary values';
		map['settings.security.private_mode_activated'] = 'Private mode activated';
		map['settings.security.private_mode_deactivated'] = 'Private mode disabled';
		map['settings.transactions.menu_title'] = 'Transactions';
		map['settings.transactions.menu_descr'] = 'Configure the behavior of your transactions';
		map['settings.transactions.title'] = 'Transactions Settings';
		map['settings.transactions.swipe_actions.title'] = 'Swipe actions';
		map['settings.transactions.swipe_actions.choose_description'] = 'Choose what action will be triggered when you swipe a transaction item in the list using this swipe direction';
		map['settings.transactions.swipe_actions.swipe_left'] = 'Swipe left';
		map['settings.transactions.swipe_actions.swipe_right'] = 'Swipe right';
		map['settings.transactions.swipe_actions.none'] = 'No action';
		map['settings.transactions.swipe_actions.toggle_reconciled'] = 'Toggle reconciled';
		map['settings.transactions.swipe_actions.toggle_pending'] = 'Toggle pending';
		map['settings.transactions.swipe_actions.toggle_voided'] = 'Toggle voided';
		map['settings.transactions.swipe_actions.toggle_unreconciled'] = 'Toggle unreconciled';
		map['settings.transactions.swipe_actions.remove_status'] = 'Remove status';
		map['settings.transactions.default_values.title'] = 'Default Form Values';
		map['settings.transactions.default_values.page_title'] = 'New Transaction: Default Form Values';
		map['settings.transactions.default_values.reuse_last_transaction'] = 'Reuse Last Transaction Values';
		map['settings.transactions.default_values.reuse_last_transaction_descr'] = 'Automatically fill the form with some values from the last created transaction';
		map['settings.transactions.default_values.fields_to_reuse'] = 'Fields to reuse';
		map['settings.transactions.default_values.reuse_last_values_modal_descr'] = 'Select the fields that should be pre-filled with the values from the last created transaction.';
		map['settings.transactions.default_values.default_values_separator'] = 'Default Values';
		map['settings.transactions.default_values.default_category'] = 'Default Category';
		map['settings.transactions.default_values.default_status'] = 'Default Status';
		map['settings.transactions.default_values.default_tags'] = 'Default Tags';
		map['settings.transactions.default_values.no_tags_selected'] = 'No tags selected';
		map['settings.transactions.default_type.title'] = 'Default Type';
		map['settings.transactions.default_type.modal_title'] = 'Select Default Type';
		map['settings.appearance.menu_title'] = 'Theme & Style';
		map['settings.appearance.menu_descr'] = 'Theme selection, colors and other things related to the app appearance';
		map['settings.appearance.theme_and_colors'] = 'Theme and colors';
		map['settings.appearance.theme.title'] = 'Theme';
		map['settings.appearance.theme.auto'] = 'System';
		map['settings.appearance.theme.light'] = 'Light';
		map['settings.appearance.theme.dark'] = 'Dark';
		map['settings.appearance.amoled_mode'] = 'AMOLED mode';
		map['settings.appearance.amoled_mode_descr'] = 'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens';
		map['settings.appearance.dynamic_colors'] = 'Dynamic colors';
		map['settings.appearance.dynamic_colors_descr'] = 'Use your system accent color whenever possible';
		map['settings.appearance.accent_color'] = 'Accent color';
		map['settings.appearance.accent_color_descr'] = 'Choose the color the app will use to emphasize certain parts of the interface';
		map['settings.appearance.text'] = 'Text';
		map['settings.appearance.font'] = 'Font';
		map['settings.appearance.font_platform'] = 'Platform';
		map['more.title'] = 'More';
		map['more.title_long'] = 'More actions';
		map['more.data.display'] = 'Data';
		map['more.data.display_descr'] = 'Export and import your data so you don\'t lose anything';
		map['more.data.delete_all'] = 'Delete my data';
		map['more.data.delete_all_header1'] = 'Stop right there padawan ⚠️⚠️';
		map['more.data.delete_all_message1'] = 'Are you sure you want to continue? All your data will be permanently deleted and cannot be recovered';
		map['more.data.delete_all_header2'] = 'One last step ⚠️⚠️';
		map['more.data.delete_all_message2'] = 'By deleting an account you will delete all your stored personal data. Your accounts, transactions, budgets and categories will be deleted and cannot be recovered. Do you agree?';
		map['more.about_us.display'] = 'App information';
		map['more.about_us.description'] = 'Find Monekin’s terms, important info, and connect by reporting bugs or sharing ideas';
		map['more.about_us.legal.display'] = 'Legal information';
		map['more.about_us.legal.privacy'] = 'Privacy policy';
		map['more.about_us.legal.terms'] = 'Terms of use';
		map['more.about_us.legal.licenses'] = 'Licenses';
		map['more.about_us.project.display'] = 'Project';
		map['more.about_us.project.contributors'] = 'Collaborators';
		map['more.about_us.project.contributors_descr'] = 'All the developers who have made Monekin grow';
		map['more.about_us.project.contact'] = 'Contact us';
		map['more.help_us.display'] = 'Help us';
		map['more.help_us.description'] = 'Find out how you can help Monekin become better and better';
		map['more.help_us.rate_us'] = 'Rate us';
		map['more.help_us.rate_us_descr'] = 'Any rate is welcome!';
		map['more.help_us.share'] = 'Share Monekin';
		map['more.help_us.share_descr'] = 'Share our app to friends and family';
		map['more.help_us.share_text'] = 'Monekin! The best personal finance app. Download it here';
		map['more.help_us.thanks'] = 'Thank you!';
		map['more.help_us.thanks_long'] = 'Your contributions to Monekin and other open source projects, big and small, make great projects like this possible. Thank you for taking the time to contribute.';
		map['more.help_us.donate'] = 'Make a donation';
		map['more.help_us.donate_descr'] = 'With your donation you will help the app continue receiving improvements. What better way than to thank the work done by inviting me to a coffee?';
		map['more.help_us.donate_success'] = 'Donation made. Thank you very much for your contribution! ❤️';
		map['more.help_us.donate_err'] = 'Oops! It seems there was an error receiving your payment';
		map['more.help_us.report'] = 'Report bugs, leave suggestions...';

		_map = map;
		return map;
	}
}


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
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	late final TranslationsBackupEn backup = TranslationsBackupEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsMoreEn more = TranslationsMoreEn._(_root);
}

// Path: ui_actions
class TranslationsUiActionsEn {
	TranslationsUiActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get cancel => 'Cancel';
	String get confirm => 'Confirm';
	String get continue_text => 'Continue';
	String get save => 'Save';
	String get save_changes => 'Save changes';
	String get close_and_save => 'Save and close';
	String get add => 'Add';
	String get edit => 'Edit';
	String get delete => 'Delete';
	String get see_more => 'See more';
	String get select_all => 'Select all';
	String get deselect_all => 'Deselect all';
	String get select => 'Select';
	String get search => 'Search';
	String get filter => 'Filter';
	String get reset => 'Reset';
	String get submit => 'Submit';
	String get next => 'Next';
	String get previous => 'Previous';
	String get back => 'Back';
	String get reload => 'Reload';
	String get view => 'View';
	String get download => 'Download';
	String get upload => 'Upload';
	String get retry => 'Retry';
	String get copy => 'Copy';
	String get paste => 'Paste';
	String get undo => 'Undo';
	String get redo => 'Redo';
	String get open => 'Open';
	String get close => 'Close';
	String get apply => 'Apply';
	String get discard => 'Discard';
	String get refresh => 'Refresh';
	String get details => 'Details';
	String get share => 'Share';
}

// Path: general
class TranslationsGeneralEn {
	TranslationsGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get or => 'or';
	String get understood => 'Understood';
	String get unspecified => 'Unspecified';
	String get quick_actions => 'Quick actions';
	String get balance => 'Balance';
	String get account => 'Account';
	String get accounts => 'Accounts';
	String get categories => 'Categories';
	String get category => 'Category';
	String get today => 'Today';
	String get yesterday => 'Yesterday';
	String get filters => 'Filters';
	String get empty_warn => 'Ops! This is very empty';
	String get insufficient_data => 'Insufficient data';
	String get show_more_fields => 'Show more fields';
	String get show_less_fields => 'Show less fields';
	String get tap_to_search => 'Tap to search';
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
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

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
class TranslationsFinancialHealthEn {
	TranslationsFinancialHealthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
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
class TranslationsIconSelectorEn {
	TranslationsIconSelectorEn._(this._root);

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
	late final TranslationsIconSelectorScopesEn scopes = TranslationsIconSelectorScopesEn._(_root);
}

// Path: transaction
class TranslationsTransactionEn {
	TranslationsTransactionEn._(this._root);

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
	String get display => 'Transfer';
	String get transfers => 'Transfers';
	String transfer_to({required Object account}) => 'Transfer to ${account}';
	String get create => 'New Transfer';
	String get need_two_accounts_warning_header => 'Ops!';
	String get need_two_accounts_warning_message => 'At least two accounts are needed to perform this action. If you need to adjust or edit the current balance of this account, click the edit button';
	late final TranslationsTransferFormEn form = TranslationsTransferFormEn._(_root);
}

// Path: recurrent_transactions
class TranslationsRecurrentTransactionsEn {
	TranslationsRecurrentTransactionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Recurrent transactions';
	String get title_short => 'Rec. transactions';
	String get empty => 'It looks like you don\'t have any recurring transactions. Create a monthly, yearly, or weekly recurring transaction and it will appear here';
	String get total_expense_title => 'Total expense per period';
	String get total_expense_descr => '* Without considering the start and end date of each recurrence';
	late final TranslationsRecurrentTransactionsDetailsEn details = TranslationsRecurrentTransactionsDetailsEn._(_root);
	late final TranslationsRecurrentTransactionsStatusEn status = TranslationsRecurrentTransactionsStatusEn._(_root);
}

// Path: account
class TranslationsAccountEn {
	TranslationsAccountEn._(this._root);

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
	String get currency_converter => 'Currency converter';
	String get currency => 'Currency';
	String get currency_manager => 'Currency manager';
	String get currency_manager_descr => 'Configure your currency and its exchange rates with others';
	String get preferred_currency => 'Preferred/base currency';
	String get change_preferred_currency_title => 'Change preferred currency';
	String get change_preferred_currency_msg => 'All stats and budgets will be displayed in this currency from now on. Accounts and transactions will keep the currency they had. All saved exchange rates will be deleted if you execute this action. Do you wish to continue?';
	late final TranslationsCurrenciesFormEn form = TranslationsCurrenciesFormEn._(_root);
	String get delete_all_success => 'Deleted exchange rates successfully';
	String get historical => 'Historical rates';
	String get exchange_rate => 'Exchange rate';
	String get exchange_rates => 'Exchange rates';
	String get empty => 'Add exchange rates here so that if you have accounts in currencies other than your base currency our charts are more accurate';
	String get select_a_currency => 'Select a currency';
	String get search => 'Search by name or by currency code';
}

// Path: tags
class TranslationsTagsEn {
	TranslationsTagsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Label',
		other: 'Tags',
	);
	late final TranslationsTagsFormEn form = TranslationsTagsFormEn._(_root);
	late final TranslationsTagsSelectEn select = TranslationsTagsSelectEn._(_root);
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
class TranslationsCategoriesEn {
	TranslationsCategoriesEn._(this._root);

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
	late final TranslationsCategoriesSelectEn select = TranslationsCategoriesSelectEn._(_root);
}

// Path: budgets
class TranslationsBudgetsEn {
	TranslationsBudgetsEn._(this._root);

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
	late final TranslationsBudgetsFormEn form = TranslationsBudgetsFormEn._(_root);
	late final TranslationsBudgetsDetailsEn details = TranslationsBudgetsDetailsEn._(_root);
}

// Path: backup
class TranslationsBackupEn {
	TranslationsBackupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBackupExportEn export = TranslationsBackupExportEn._(_root);
	late final TranslationsBackupImportEn import = TranslationsBackupImportEn._(_root);
	late final TranslationsBackupAboutEn about = TranslationsBackupAboutEn._(_root);
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

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
	String get locale_auto => 'System';
	String get locale_descr => 'Set the format to use for dates, numbers...';
	String get locale_warn => 'When changing region the app will update';
	String get first_day_of_week => 'First day of week';
	String get theme_and_colors => 'Theme and colors';
	String get theme => 'Theme';
	String get theme_auto => 'System';
	String get theme_light => 'Light';
	String get theme_dark => 'Dark';
	String get amoled_mode => 'AMOLED mode';
	String get amoled_mode_descr => 'Use a pure black wallpaper when possible. This will slightly help the battery of devices with AMOLED screens';
	String get dynamic_colors => 'Dynamic colors';
	String get dynamic_colors_descr => 'Use your system accent color whenever possible';
	String get accent_color => 'Accent color';
	String get accent_color_descr => 'Choose the color the app will use to emphasize certain parts of the interface';
	late final TranslationsSettingsSecurityEn security = TranslationsSettingsSecurityEn._(_root);
}

// Path: more
class TranslationsMoreEn {
	TranslationsMoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'More';
	String get title_long => 'More actions';
	late final TranslationsMoreDataEn data = TranslationsMoreDataEn._(_root);
	late final TranslationsMoreAboutUsEn about_us = TranslationsMoreAboutUsEn._(_root);
	late final TranslationsMoreHelpUsEn help_us = TranslationsMoreHelpUsEn._(_root);
}

// Path: general.clipboard
class TranslationsGeneralClipboardEn {
	TranslationsGeneralClipboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String success({required Object x}) => '${x} copied to the clipboard';
	String get error => 'Error copying';
}

// Path: general.time
class TranslationsGeneralTimeEn {
	TranslationsGeneralTimeEn._(this._root);

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
	String get display => 'Order transactions';
	String get category => 'By category';
	String get quantity => 'By quantity';
	String get date => 'By date';
}

// Path: general.validations
class TranslationsGeneralValidationsEn {
	TranslationsGeneralValidationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get form_error => 'Fix the indicated fields to continue';
	String get required => 'Required field';
	String get positive => 'Should be positive';
	String min_number({required Object x}) => 'Should be greater than ${x}';
	String max_number({required Object x}) => 'Should be less than ${x}';
}

// Path: financial_health.review
class TranslationsFinancialHealthReviewEn {
	TranslationsFinancialHealthReviewEn._(this._root);

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
	late final TranslationsFinancialHealthReviewDescrEn descr = TranslationsFinancialHealthReviewDescrEn._(_root);
}

// Path: financial_health.months_without_income
class TranslationsFinancialHealthMonthsWithoutIncomeEn {
	TranslationsFinancialHealthMonthsWithoutIncomeEn._(this._root);

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
class TranslationsFinancialHealthSavingsPercentageEn {
	TranslationsFinancialHealthSavingsPercentageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Savings percentage';
	String get subtitle => 'What part of your income is not spent in this period';
	late final TranslationsFinancialHealthSavingsPercentageTextEn text = TranslationsFinancialHealthSavingsPercentageTextEn._(_root);
	String get suggestion => 'Remember that it is advisable to save at least 15-20% of what you earn.';
}

// Path: icon_selector.scopes
class TranslationsIconSelectorScopesEn {
	TranslationsIconSelectorScopesEn._(this._root);

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
class TranslationsTransactionNextPaymentsEn {
	TranslationsTransactionNextPaymentsEn._(this._root);

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
class TranslationsTransactionListEn {
	TranslationsTransactionListEn._(this._root);

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
	late final TranslationsTransactionListBulkEditEn bulk_edit = TranslationsTransactionListBulkEditEn._(_root);
}

// Path: transaction.filters
class TranslationsTransactionFiltersEn {
	TranslationsTransactionFiltersEn._(this._root);

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
class TranslationsTransactionFormEn {
	TranslationsTransactionFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsTransactionFormValidatorsEn validators = TranslationsTransactionFormValidatorsEn._(_root);
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
class TranslationsTransactionReversedEn {
	TranslationsTransactionReversedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Inverse transaction';
	String get title_short => 'Inverse tr.';
	String get description_for_expenses => 'Despite being an expense transaction, it has a positive amount. These types of transactions can be used to represent the return of a previously recorded expense, such as a refund or having the payment of a debt.';
	String get description_for_incomes => 'Despite being an income transaction, it has a negative amount. These types of transactions can be used to void or correct an income that was incorrectly recorded, to reflect a return or refund of money or to record payment of debts.';
}

// Path: transaction.status
class TranslationsTransactionStatusEn {
	TranslationsTransactionStatusEn._(this._root);

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
class TranslationsTransactionTypesEn {
	TranslationsTransactionTypesEn._(this._root);

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
class TranslationsTransferFormEn {
	TranslationsTransferFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get from => 'Origin account';
	String get to => 'Destination account';
	late final TranslationsTransferFormValueInDestinyEn value_in_destiny = TranslationsTransferFormValueInDestinyEn._(_root);
}

// Path: recurrent_transactions.details
class TranslationsRecurrentTransactionsDetailsEn {
	TranslationsRecurrentTransactionsDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Recurrent transaction';
	String get descr => 'The next moves for this transaction are shown below. You can accept the first move or skip this move';
	String get last_payment_info => 'This movement is the last of the recurring rule, so this rule will be automatically deleted when confirming this action';
	String get delete_header => 'Delete recurring transaction';
	String get delete_message => 'This action is irreversible and will not affect transactions you have already confirmed/paid for';
}

// Path: recurrent_transactions.status
class TranslationsRecurrentTransactionsStatusEn {
	TranslationsRecurrentTransactionsStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String delayed_by({required Object x}) => 'Delayed by ${x}d';
	String coming_in({required Object x}) => 'In ${x} days';
}

// Path: account.types
class TranslationsAccountTypesEn {
	TranslationsAccountTypesEn._(this._root);

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
class TranslationsAccountFormEn {
	TranslationsAccountFormEn._(this._root);

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
class TranslationsAccountDeleteEn {
	TranslationsAccountDeleteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get warning_header => 'Delete account?';
	String get warning_text => 'This action will delete this account and all its transactions';
	String get success => 'Account deleted successfully';
}

// Path: account.close
class TranslationsAccountCloseEn {
	TranslationsAccountCloseEn._(this._root);

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
class TranslationsAccountSelectEn {
	TranslationsAccountSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get one => 'Select an account';
	String get all => 'All accounts';
	String get multiple => 'Select accounts';
}

// Path: currencies.form
class TranslationsCurrenciesFormEn {
	TranslationsCurrenciesFormEn._(this._root);

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
class TranslationsTagsFormEn {
	TranslationsTagsFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Tag name';
	String get description => 'Description';
}

// Path: tags.select
class TranslationsTagsSelectEn {
	TranslationsTagsSelectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Select tags';
	String get all => 'All the tags';
}

// Path: categories.select
class TranslationsCategoriesSelectEn {
	TranslationsCategoriesSelectEn._(this._root);

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
class TranslationsBudgetsFormEn {
	TranslationsBudgetsFormEn._(this._root);

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
class TranslationsBudgetsDetailsEn {
	TranslationsBudgetsDetailsEn._(this._root);

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
class TranslationsBackupExportEn {
	TranslationsBackupExportEn._(this._root);

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
class TranslationsBackupImportEn {
	TranslationsBackupImportEn._(this._root);

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
	late final TranslationsBackupImportManualImportEn manual_import = TranslationsBackupImportManualImportEn._(_root);
	String get success => 'Import performed successfully';
	String get cancelled => 'Import was cancelled by the user';
	String get error => 'Error importing file. Please contact developer via lozin.technologies@gmail.com';
}

// Path: backup.about
class TranslationsBackupAboutEn {
	TranslationsBackupAboutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Information about your database';
	String get create_date => 'Creation date';
	String get modify_date => 'Last modified';
	String get last_backup => 'Last backup';
	String get size => 'Size';
}

// Path: settings.security
class TranslationsSettingsSecurityEn {
	TranslationsSettingsSecurityEn._(this._root);

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
class TranslationsMoreDataEn {
	TranslationsMoreDataEn._(this._root);

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
class TranslationsMoreAboutUsEn {
	TranslationsMoreAboutUsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'App information';
	String get description => 'Check out the terms and other relevant information about Monekin. Get in touch with the community by reporting bugs, leaving suggestions...';
	late final TranslationsMoreAboutUsLegalEn legal = TranslationsMoreAboutUsLegalEn._(_root);
	late final TranslationsMoreAboutUsProjectEn project = TranslationsMoreAboutUsProjectEn._(_root);
}

// Path: more.help_us
class TranslationsMoreHelpUsEn {
	TranslationsMoreHelpUsEn._(this._root);

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
class TranslationsGeneralTimeRangesEn {
	TranslationsGeneralTimeRangesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'Time range';
	String get it_repeat => 'Repeats';
	String get it_ends => 'Ends';
	String get forever => 'Forever';
	late final TranslationsGeneralTimeRangesTypesEn types = TranslationsGeneralTimeRangesTypesEn._(_root);
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
class TranslationsGeneralTimePeriodicityEn {
	TranslationsGeneralTimePeriodicityEn._(this._root);

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
class TranslationsGeneralTimeCurrentEn {
	TranslationsGeneralTimeCurrentEn._(this._root);

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
class TranslationsGeneralTimeAllEn {
	TranslationsGeneralTimeAllEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get diary => 'Every day';
	String get monthly => 'Every month';
	String get annually => 'Every year';
	String get quaterly => 'Every quarterly';
	String get weekly => 'Every week';
}

// Path: financial_health.review.descr
class TranslationsFinancialHealthReviewDescrEn {
	TranslationsFinancialHealthReviewDescrEn._(this._root);

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
class TranslationsFinancialHealthSavingsPercentageTextEn {
	TranslationsFinancialHealthSavingsPercentageTextEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String good({required Object value}) => 'Congratulations! You have managed to save <b>${value}%</b> of your income during this period. It seems that you are already an expert, keep up the good work!';
	String normal({required Object value}) => 'Congratulations, you have managed to save <b>${value}%</b> of your income during this period.';
	String bad({required Object value}) => 'You have managed to save <b>${value}%</b> of your income during this period. However, we think you can still do much more!';
	String get very_bad => 'Wow, you haven\'t managed to save anything during this period.';
}

// Path: transaction.list.bulk_edit
class TranslationsTransactionListBulkEditEn {
	TranslationsTransactionListBulkEditEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get dates => 'Edit dates';
	String get categories => 'Edit categories';
	String get status => 'Edit statuses';
}

// Path: transaction.form.validators
class TranslationsTransactionFormValidatorsEn {
	TranslationsTransactionFormValidatorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get zero => 'The value of a transaction cannot be equal to zero';
	String get date_max => 'The selected date is after the current one. The transaction will be added as pending';
	String get date_after_account_creation => 'You cannot create a transaction whose date is before the creation date of the account it belongs to';
	String get negative_transfer => 'The monetary value of a transfer cannot be negative';
	String get transfer_between_same_accounts => 'The origin and the destination account cannot be the same';
}

// Path: transfer.form.value_in_destiny
class TranslationsTransferFormValueInDestinyEn {
	TranslationsTransferFormValueInDestinyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Amount transferred at destination';
	String amount_short({required Object amount}) => '${amount} to target account';
}

// Path: backup.import.manual_import
class TranslationsBackupImportManualImportEn {
	TranslationsBackupImportManualImportEn._(this._root);

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
class TranslationsMoreAboutUsLegalEn {
	TranslationsMoreAboutUsLegalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'Legal information';
	String get privacy => 'Privacy policy';
	String get terms => 'Terms of use';
	String get licenses => 'Licenses';
}

// Path: more.about_us.project
class TranslationsMoreAboutUsProjectEn {
	TranslationsMoreAboutUsProjectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get display => 'Project';
	String get contributors => 'Collaborators';
	String get contributors_descr => 'All the developers who have made Monekin grow';
	String get contact => 'Contact us';
}

// Path: general.time.ranges.types
class TranslationsGeneralTimeRangesTypesEn {
	TranslationsGeneralTimeRangesTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get cycle => 'Cycles';
	String get last_days => 'Last days';
	String last_days_form({required Object x}) => '${x} previous days';
	String get all => 'Always';
	String get date_range => 'Custom range';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return 'Cancel';
			case 'ui_actions.confirm': return 'Confirm';
			case 'ui_actions.continue_text': return 'Continue';
			case 'ui_actions.save': return 'Save';
			case 'ui_actions.save_changes': return 'Save changes';
			case 'ui_actions.close_and_save': return 'Save and close';
			case 'ui_actions.add': return 'Add';
			case 'ui_actions.edit': return 'Edit';
			case 'ui_actions.delete': return 'Delete';
			case 'ui_actions.see_more': return 'See more';
			case 'ui_actions.select_all': return 'Select all';
			case 'ui_actions.deselect_all': return 'Deselect all';
			case 'ui_actions.select': return 'Select';
			case 'ui_actions.search': return 'Search';
			case 'ui_actions.filter': return 'Filter';
			case 'ui_actions.reset': return 'Reset';
			case 'ui_actions.submit': return 'Submit';
			case 'ui_actions.next': return 'Next';
			case 'ui_actions.previous': return 'Previous';
			case 'ui_actions.back': return 'Back';
			case 'ui_actions.reload': return 'Reload';
			case 'ui_actions.view': return 'View';
			case 'ui_actions.download': return 'Download';
			case 'ui_actions.upload': return 'Upload';
			case 'ui_actions.retry': return 'Retry';
			case 'ui_actions.copy': return 'Copy';
			case 'ui_actions.paste': return 'Paste';
			case 'ui_actions.undo': return 'Undo';
			case 'ui_actions.redo': return 'Redo';
			case 'ui_actions.open': return 'Open';
			case 'ui_actions.close': return 'Close';
			case 'ui_actions.apply': return 'Apply';
			case 'ui_actions.discard': return 'Discard';
			case 'ui_actions.refresh': return 'Refresh';
			case 'ui_actions.details': return 'Details';
			case 'ui_actions.share': return 'Share';
			case 'general.or': return 'or';
			case 'general.understood': return 'Understood';
			case 'general.unspecified': return 'Unspecified';
			case 'general.quick_actions': return 'Quick actions';
			case 'general.balance': return 'Balance';
			case 'general.account': return 'Account';
			case 'general.accounts': return 'Accounts';
			case 'general.categories': return 'Categories';
			case 'general.category': return 'Category';
			case 'general.today': return 'Today';
			case 'general.yesterday': return 'Yesterday';
			case 'general.filters': return 'Filters';
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
			case 'settings.locale_auto': return 'System';
			case 'settings.locale_descr': return 'Set the format to use for dates, numbers...';
			case 'settings.locale_warn': return 'When changing region the app will update';
			case 'settings.first_day_of_week': return 'First day of week';
			case 'settings.theme_and_colors': return 'Theme and colors';
			case 'settings.theme': return 'Theme';
			case 'settings.theme_auto': return 'System';
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


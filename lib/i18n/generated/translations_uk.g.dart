///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsUk implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsUk({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	late final TranslationsUk _root = this; // ignore: unused_field

	@override 
	TranslationsUk $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsUk(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsUk ui_actions = _TranslationsUiActionsUk._(_root);
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
	@override late final _TranslationsGoalsUk goals = _TranslationsGoalsUk._(_root);
	@override late final _TranslationsTargetTimelineStatusesUk target_timeline_statuses = _TranslationsTargetTimelineStatusesUk._(_root);
	@override late final _TranslationsBackupUk backup = _TranslationsBackupUk._(_root);
	@override late final _TranslationsSettingsUk settings = _TranslationsSettingsUk._(_root);
	@override late final _TranslationsMoreUk more = _TranslationsMoreUk._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsUk implements TranslationsUiActionsEn {
	_TranslationsUiActionsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Скасувати';
	@override String get confirm => 'Підтвердити';
	@override String get continue_text => 'Продовжити';
	@override String get save => 'Зберегти';
	@override String get save_changes => 'Зберегти зміни';
	@override String get close_and_save => 'Закрити та зберегти';
	@override String get add => 'Додати';
	@override String get edit => 'Редагувати';
	@override String get delete => 'Видалити';
	@override String get see_more => 'Детальніше';
	@override String get select_all => 'Вибрати все';
	@override String get deselect_all => 'Скасувати вибір всього';
	@override String get select => 'Вибрати';
	@override String get search => 'Пошук';
	@override String get filter => 'Фільтр';
	@override String get reset => 'Скинути';
	@override String get submit => 'Надіслати';
	@override String get next => 'Далі';
	@override String get previous => 'Назад';
	@override String get back => 'Повернутися';
	@override String get reload => 'Перезавантажити';
	@override String get view => 'Переглянути';
	@override String get download => 'Завантажити';
	@override String get upload => 'Завантажити файл';
	@override String get retry => 'Спробувати знову';
	@override String get copy => 'Копіювати';
	@override String get paste => 'Вставити';
	@override String get undo => 'Скасувати дію';
	@override String get redo => 'Повторити дію';
	@override String get open => 'Відкрити';
	@override String get close => 'Закрити';
	@override String get apply => 'Застосувати';
	@override String get discard => 'Скасувати зміни';
	@override String get refresh => 'Оновити';
	@override String get share => 'Поділитися';
}

// Path: general
class _TranslationsGeneralUk implements TranslationsGeneralEn {
	_TranslationsGeneralUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get or => 'або';
	@override String get understood => 'Зрозуміло';
	@override String get unspecified => 'Не вказано';
	@override String get quick_actions => 'Швидкі дії';
	@override String get details => 'Подробиці';
	@override String get balance => 'Баланс';
	@override String get account => 'Рахунок';
	@override String get accounts => 'Рахунки';
	@override String get categories => 'Категорії';
	@override String get category => 'Категорія';
	@override String get today => 'Сьогодні';
	@override String get yesterday => 'Вчора';
	@override String get filters => 'Фільтри';
	@override String get empty_warn => 'Ой! Тут порожньо';
	@override String get search_no_results => 'Немає елементів, які відповідають вашим критеріям пошуку';
	@override String get insufficient_data => 'Недостатньо даних';
	@override String get show_more_fields => 'Показати більше полів';
	@override String get show_less_fields => 'Показати менше полів';
	@override String get tap_to_search => 'Натисніть для пошуку';
	@override String get delete_success => 'Елемент успішно видалено';
	@override late final _TranslationsGeneralLeaveWithoutSavingUk leave_without_saving = _TranslationsGeneralLeaveWithoutSavingUk._(_root);
	@override late final _TranslationsGeneralClipboardUk clipboard = _TranslationsGeneralClipboardUk._(_root);
	@override late final _TranslationsGeneralTimeUk time = _TranslationsGeneralTimeUk._(_root);
	@override late final _TranslationsGeneralTransactionOrderUk transaction_order = _TranslationsGeneralTransactionOrderUk._(_root);
	@override late final _TranslationsGeneralValidationsUk validations = _TranslationsGeneralValidationsUk._(_root);
}

// Path: intro
class _TranslationsIntroUk implements TranslationsIntroEn {
	_TranslationsIntroUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsHomeUk implements TranslationsHomeEn {
	_TranslationsHomeUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsFinancialHealthUk implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Фінансове здоров\'я';
	@override late final _TranslationsFinancialHealthReviewUk review = _TranslationsFinancialHealthReviewUk._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeUk months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeUk._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageUk savings_percentage = _TranslationsFinancialHealthSavingsPercentageUk._(_root);
}

// Path: stats
class _TranslationsStatsUk implements TranslationsStatsEn {
	_TranslationsStatsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsIconSelectorUk implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get name => 'Назва:';
	@override String get icon => 'Іконка';
	@override String get color => 'Колір';
	@override String get select_icon => 'Виберіть іконку';
	@override String get select_color => 'Виберіть колір';
	@override String get custom_color => 'Користувацький колір';
	@override String get current_color_selection => 'Поточний вибір';
	@override String get select_account_icon => 'Ідентифікуйте ваш рахунок';
	@override String get select_category_icon => 'Ідентифікуйте вашу категорію';
	@override late final _TranslationsIconSelectorScopesUk scopes = _TranslationsIconSelectorScopesUk._(_root);
}

// Path: transaction
class _TranslationsTransactionUk implements TranslationsTransactionEn {
	_TranslationsTransactionUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransferUk implements TranslationsTransferEn {
	_TranslationsTransferUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsRecurrentTransactionsUk implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsAccountUk implements TranslationsAccountEn {
	_TranslationsAccountUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsCurrenciesUk implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Конвертер валют';
	@override String get currency => 'Валюта';
	@override String get currency_settings => 'Параметри валюти';
	@override String get currency_manager => 'Менеджер валют';
	@override String get currency_manager_descr => 'Налаштуйте вашу валюту та її обмінні курси з іншими';
	@override String get preferred_currency => 'Перевагова/базова валюта';
	@override String get tap_to_change_preferred_currency => 'Торкніться, щоб змінити';
	@override String get change_preferred_currency_title => 'Змінити перевагову валюту';
	@override String get change_preferred_currency_msg => 'Усі статистичні дані та бюджети будуть відображатися в цій валюті відтепер. Рахунки та транзакції залишаться у тій валюті, яку вони мали. Усі збережені обмінні курси будуть видалені, якщо ви виконаєте цю дію. Ви хочете продовжити?';
	@override late final _TranslationsCurrenciesExchangeRateFormUk exchange_rate_form = _TranslationsCurrenciesExchangeRateFormUk._(_root);
	@override late final _TranslationsCurrenciesTypesUk types = _TranslationsCurrenciesTypesUk._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormUk currency_form = _TranslationsCurrenciesCurrencyFormUk._(_root);
	@override String get delete_all_success => 'Обмінні курси успішно видалено';
	@override String get historical => 'Історичні курси';
	@override String get historical_empty => 'Історичних курсів обміну для цієї валюти не знайдено';
	@override String get exchange_rate => 'Обмінний курс';
	@override String get exchange_rates => 'Обмінні курси';
	@override String get min_exchange_rate => 'Мінімальний курс обміну';
	@override String get max_exchange_rate => 'Максимальний курс обміну';
	@override String get empty => 'Додайте тут обмінні курси, щоб, якщо у вас є рахунки в інших валютах, наші графіки були б точнішими';
	@override String get select_a_currency => 'Виберіть валюту';
	@override String get search => 'Пошук за назвою або кодом валюти';
}

// Path: tags
class _TranslationsTagsUk implements TranslationsTagsEn {
	_TranslationsTagsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsCategoriesUk implements TranslationsCategoriesEn {
	_TranslationsCategoriesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsBudgetsUk implements TranslationsBudgetsEn {
	_TranslationsBudgetsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Бюджети';
	@override String get status => 'Стан бюджету';
	@override String get repeated => 'Повторювані';
	@override String get one_time => 'Одноразові';
	@override String get actives => 'Активні';
	@override String get from_budgeted => 'з ';
	@override String get days_left => 'днів залишилось';
	@override String get days_to_start => 'днів до початку';
	@override String get since_expiration => 'днів після закінчення терміну';
	@override String get no_budgets => 'Здається, що в цьому розділі немає жодних бюджетів для відображення. Розпочніть з створення бюджету, натиснувши кнопку нижче';
	@override String get delete => 'Видалити бюджет';
	@override String get delete_warning => 'Ця дія незворотня. Категорії та транзакції, що стосуються цитати, не будуть видалені';
	@override late final _TranslationsBudgetsFormUk form = _TranslationsBudgetsFormUk._(_root);
	@override late final _TranslationsBudgetsDetailsUk details = _TranslationsBudgetsDetailsUk._(_root);
	@override late final _TranslationsBudgetsTargetTimelineStatusesUk target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesUk._(_root);
	@override late final _TranslationsBudgetsProgressUk progress = _TranslationsBudgetsProgressUk._(_root);
}

// Path: goals
class _TranslationsGoalsUk implements TranslationsGoalsEn {
	_TranslationsGoalsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Цілі';
	@override String get status => 'Статус цілі';
	@override late final _TranslationsGoalsTypeUk type = _TranslationsGoalsTypeUk._(_root);
	@override String get empty_title => 'Цілей не знайдено';
	@override String get empty_description => 'Створіть нову ціль, щоб почати відстежувати свої заощадження!';
	@override String get delete => 'Delete goal';
	@override String get delete_warning => 'This action is irreversible. Categories and transactions referring to this goal will not be deleted';
	@override late final _TranslationsGoalsFormUk form = _TranslationsGoalsFormUk._(_root);
	@override late final _TranslationsGoalsDetailsUk details = _TranslationsGoalsDetailsUk._(_root);
	@override late final _TranslationsGoalsTargetTimelineStatusesUk target_timeline_statuses = _TranslationsGoalsTargetTimelineStatusesUk._(_root);
	@override late final _TranslationsGoalsProgressUk progress = _TranslationsGoalsProgressUk._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesUk implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get active => 'Активний';
	@override String get past => 'Завершений';
	@override String get future => 'Майбутній';
}

// Path: backup
class _TranslationsBackupUk implements TranslationsBackupEn {
	_TranslationsBackupUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => 'Файл не вибрано';
	@override String get no_directory_selected => 'Каталог не вибрано';
	@override late final _TranslationsBackupExportUk export = _TranslationsBackupExportUk._(_root);
	@override late final _TranslationsBackupImportUk import = _TranslationsBackupImportUk._(_root);
	@override late final _TranslationsBackupAboutUk about = _TranslationsBackupAboutUk._(_root);
}

// Path: settings
class _TranslationsSettingsUk implements TranslationsSettingsEn {
	_TranslationsSettingsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Налаштування та Персоналізація';
	@override String get title_short => 'Налаштування';
	@override String get description => 'Тема, Мова, Дані та інше';
	@override String get edit_profile => 'Редагувати профіль';
	@override late final _TranslationsSettingsGeneralUk general = _TranslationsSettingsGeneralUk._(_root);
	@override late final _TranslationsSettingsSecurityUk security = _TranslationsSettingsSecurityUk._(_root);
	@override late final _TranslationsSettingsTransactionsUk transactions = _TranslationsSettingsTransactionsUk._(_root);
	@override late final _TranslationsSettingsAppearanceUk appearance = _TranslationsSettingsAppearanceUk._(_root);
}

// Path: more
class _TranslationsMoreUk implements TranslationsMoreEn {
	_TranslationsMoreUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Більше';
	@override String get title_long => 'Більше дій';
	@override late final _TranslationsMoreDataUk data = _TranslationsMoreDataUk._(_root);
	@override late final _TranslationsMoreAboutUsUk about_us = _TranslationsMoreAboutUsUk._(_root);
	@override late final _TranslationsMoreHelpUsUk help_us = _TranslationsMoreHelpUsUk._(_root);
}

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingUk implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Вийти без збереження?';
	@override String get message => 'У вас є незбережені зміни. Ви впевнені, що бажаєте вийти, не зберігаючи їх?';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardUk implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} скопійовано в буфер обміну';
	@override String get error => 'Помилка копіювання';
}

// Path: general.time
class _TranslationsGeneralTimeUk implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsGeneralTransactionOrderUk implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Сортувати транзакції';
	@override String get category => 'За категорією';
	@override String get quantity => 'За кількістю';
	@override String get date => 'За датою';
}

// Path: general.validations
class _TranslationsGeneralValidationsUk implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Виправте поля, зазначені у формі, щоб продовжити';
	@override String get required => 'Обов\'язкове поле';
	@override String get positive => 'Повинно бути позитивним';
	@override String min_number({required Object x}) => 'Повинно бути більшим, ніж ${x}';
	@override String max_number({required Object x}) => 'Повинно бути меншим, ніж ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewUk implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsFinancialHealthMonthsWithoutIncomeUk implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsFinancialHealthSavingsPercentageUk implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Відсоток заощаджень';
	@override String get subtitle => 'Яка частина вашого доходу не витрачена за цей період';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextUk text = _TranslationsFinancialHealthSavingsPercentageTextUk._(_root);
	@override String get suggestion => 'Пам\'ятайте, що рекомендується заощаджувати принаймні 15-20% від вашого доходу.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesUk implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransactionNextPaymentsUk implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransactionListUk implements TranslationsTransactionListEn {
	_TranslationsTransactionListUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get all => 'Всі транзакції';
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
class _TranslationsTransactionFiltersUk implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Фільтри транзакцій';
	@override String get from_value => 'Від суми';
	@override String get to_value => 'До суми';
	@override String from_value_def({required Object x}) => 'Від ${x}';
	@override String to_value_def({required Object x}) => 'До ${x}';
	@override String from_date_def({required Object date}) => 'З ${date}';
	@override String to_date_def({required Object date}) => 'До ${date}';
	@override String get reset => 'Скинути фільтри';
	@override late final _TranslationsTransactionFiltersSavedUk saved = _TranslationsTransactionFiltersSavedUk._(_root);
}

// Path: transaction.form
class _TranslationsTransactionFormUk implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransactionReversedUk implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Скасована транзакція';
	@override String get title_short => 'Перевернутий тр.';
	@override String get description_for_expenses => 'Незважаючи на те, що транзакція типу витрат, ця транзакція має додатну суму. Ці типи транзакцій можна використовувати для представлення повернення раніше зареєстрованих витрат, таких як відшкодування або оплата борг.';
	@override String get description_for_incomes => 'Незважаючи на те, що транзакція є дохідною, ця транзакція має від’ємну суму. Ці типи транзакцій можна використовувати ля анулювання або виправлення неправильно зареєстрованого доходу, для відображення повернення або відшкодування грошей або для обліку сплати боргів».';
}

// Path: transaction.status
class _TranslationsTransactionStatusUk implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransactionTypesUk implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransferFormUk implements TranslationsTransferFormEn {
	_TranslationsTransferFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get from => 'Початковий рахунок';
	@override String get to => 'Цільовий рахунок';
	@override late final _TranslationsTransferFormValueInDestinyUk value_in_destiny = _TranslationsTransferFormValueInDestinyUk._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsUk implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Повторювана транзакція';
	@override String get descr => 'Наступні переміщення для цієї транзакції показані нижче. Ви можете прийняти перший рух або пропустити цей рух';
	@override String get last_payment_info => 'Цей рух є останнім за повторюваною правилою, тому це правило буде автоматично видалено при підтвердженні цієї дії';
	@override String get delete_header => 'Видалити повторювану транзакцію';
	@override String get delete_message => 'Ця дія є незворотньою і не вплине на транзакції, які ви вже підтвердили/оплатили';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusUk implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Затримано на ${x}d';
	@override String coming_in({required Object x}) => 'Через ${x} днів';
}

// Path: account.types
class _TranslationsAccountTypesUk implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Тип рахунку';
	@override String get warning => 'Після вибору типу рахунку його не можна буде змінити в майбутньому';
	@override String get normal => 'Звичайний рахунок';
	@override String get normal_descr => 'Використовується для фіксації вашої повсякденної фінансової діяльності. Це найбільш поширений рахунок, який дозволяє додавати витрати, доходи...';
	@override String get saving => 'Зберігаючий рахунок';
	@override String get saving_descr => 'З нього можна тільки додавати та знімати гроші з інших рахунків. Ідеально підходить для початку збереження грошей';
}

// Path: account.form
class _TranslationsAccountFormUk implements TranslationsAccountFormEn {
	_TranslationsAccountFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsAccountDeleteUk implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Видалити рахунок?';
	@override String get warning_text => 'Ця дія видалить цей рахунок і всі його транзакції';
	@override String get success => 'Рахунок успішно видалено';
}

// Path: account.close
class _TranslationsAccountCloseUk implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsAccountSelectUk implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get one => 'Виберіть рахунок';
	@override String get all => 'Всі рахунки';
	@override String get multiple => 'Вибрати рахунки';
}

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormUk implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'Валюта не може бути однаковою з валютою користувача';
	@override String get override_existing_warn => 'Курс обміну для цієї валюти на цю дату вже існує. Якщо ви продовжите, попередній буде перезаписано';
	@override String get specify_a_currency => 'Будь ласка, вкажіть валюту';
	@override String get add => 'Додати обмінний курс';
	@override String get add_success => 'Обмінний курс успішно додано';
	@override String get edit => 'Редагувати обмінний курс';
	@override String get edit_success => 'Обмінний курс успішно відредаговано';
	@override String get remove_all => 'Видалити всі курси валют';
	@override String get remove_all_warning => 'Цю дію не можна відмінити, і всі курси обміну для цієї валюти буде видалено';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesUk implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Тип валюти';
	@override String get fiat => 'FIAT';
	@override String get crypto => 'Криптовалюта';
	@override String get other => 'інше';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormUk implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get name => 'Відображуване ім\'я';
	@override String get code => 'Код валюти';
	@override String get symbol => 'символ';
	@override String get decimal_digits => 'Десяткові цифри';
	@override String get create => 'Створіть валюту';
	@override String get create_success => 'Валюту створено успішно';
	@override String get edit => 'Редагувати валюту';
	@override String get edit_success => 'Валюту успішно відредаговано';
	@override String get delete => 'Видалити валюту';
	@override String get delete_success => 'Валюту успішно видалено';
	@override String get already_exists => 'Валюта з таким кодом уже існує. Ви можете відредагувати його';
}

// Path: tags.form
class _TranslationsTagsFormUk implements TranslationsTagsFormEn {
	_TranslationsTagsFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get name => 'Назва тегу';
	@override String get description => 'Опис';
}

// Path: tags.select
class _TranslationsTagsSelectUk implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Вибрати теги';
	@override String get all => 'Усі теги';
}

// Path: categories.select
class _TranslationsCategoriesSelectUk implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Вибрати категорії';
	@override String get select_one => 'Виберіть категорію';
	@override String get select_subcategory => 'Оберіть підкатегорію';
	@override String get without_subcategory => 'Без підкатегорії';
	@override String get all => 'Усі категорії';
	@override String get all_short => 'Усі';
}

// Path: budgets.form
class _TranslationsBudgetsFormUk implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Додати бюджет';
	@override String get name => 'Назва бюджету';
	@override String get value => 'Обмежена кількість';
	@override String get create => 'Додати бюджет';
	@override String get create_success => 'Бюджет створено успішно';
	@override String get edit => 'Редагувати бюджет';
	@override String get edit_success => 'Бюджет успішно відредаговано';
	@override String get negative_warn => 'Бюджети не можуть мати від\'ємну суму';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsUk implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Деталі бюджету';
	@override String get statistics => 'Статистика';
	@override String get budget_value => 'Заплановано';
	@override String get expend_evolution => 'Еволюція витрат';
	@override String get no_transactions => 'Здається, ви не здійснили жодних витрат, пов\'язаних з цим бюджетом';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesUk implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get active => 'Активний бюджет';
	@override String get past => 'Завершений бюджет';
	@override String get future => 'Майбутній бюджет';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressUk implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsUk labels = _TranslationsBudgetsProgressLabelsUk._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionUk description = _TranslationsBudgetsProgressDescriptionUk._(_root);
}

// Path: goals.type
class _TranslationsGoalsTypeUk implements TranslationsGoalsTypeEn {
	_TranslationsGoalsTypeUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Goal Type';
	@override late final _TranslationsGoalsTypeIncomeUk income = _TranslationsGoalsTypeIncomeUk._(_root);
	@override late final _TranslationsGoalsTypeExpenseUk expense = _TranslationsGoalsTypeExpenseUk._(_root);
}

// Path: goals.form
class _TranslationsGoalsFormUk implements TranslationsGoalsFormEn {
	_TranslationsGoalsFormUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get new_title => 'New Goal';
	@override String get edit_title => 'Edit Goal';
	@override String get target_amount => 'Target Amount';
	@override String get initial_amount => 'Initial Amount';
	@override String get name => 'Name';
	@override String get name_hint => 'My Saving Goal';
	@override String get create_success => 'Goal created successfully';
	@override String get edit_success => 'Goal edited successfully';
	@override String get negative_warn => 'The goal amount cannot be negative';
}

// Path: goals.details
class _TranslationsGoalsDetailsUk implements TranslationsGoalsDetailsEn {
	_TranslationsGoalsDetailsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Goal Details';
	@override String get statistics => 'Statistics';
	@override String get goal_value => 'Goal Target';
	@override String get evolution => 'Evolution';
	@override String get no_transactions => 'It seems that you have not made any transactions related to this goal';
}

// Path: goals.target_timeline_statuses
class _TranslationsGoalsTargetTimelineStatusesUk implements TranslationsGoalsTargetTimelineStatusesEn {
	_TranslationsGoalsTargetTimelineStatusesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get active => 'Active goal';
	@override String get past => 'Finished goal';
	@override String get future => 'Future goal';
}

// Path: goals.progress
class _TranslationsGoalsProgressUk implements TranslationsGoalsProgressEn {
	_TranslationsGoalsProgressUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGoalsProgressLabelsUk labels = _TranslationsGoalsProgressLabelsUk._(_root);
	@override late final _TranslationsGoalsProgressDescriptionUk description = _TranslationsGoalsProgressDescriptionUk._(_root);
}

// Path: backup.export
class _TranslationsBackupExportUk implements TranslationsBackupExportEn {
	_TranslationsBackupExportUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Експорт ваших даних';
	@override String get title_short => 'Експорт';
	@override String get type_of_export => 'Тип експорту';
	@override String get other_options => 'Опції';
	@override String get all => 'Повне резервне копіювання';
	@override String get all_descr => 'Експортувати всі ваші дані (рахунки, транзакції, бюджети, налаштування...). Імпортуйте їх знову у будь-який момент, щоб нічого не втратити.';
	@override String get transactions => 'Резервне копіювання транзакцій';
	@override String get transactions_descr => 'Експортуйте ваші транзакції у форматі CSV, щоб ви могли зручніше їх аналізувати в інших програмах або застосунках.';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
		one: '1 транзакція для експорту',
		other: '${n} транзакцій для експорту',
	);
	@override String get description => 'Завантажте ваші дані у різних форматах';
	@override String get send_file => 'Надіслати файл';
	@override String get see_folder => 'Дивіться папку';
	@override String success({required Object x}) => 'Файл успішно збережено/завантажено у ${x}';
	@override String get error => 'Помилка при завантаженні файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
	@override String get dialog_title => 'Зберегти/Відправити файл';
}

// Path: backup.import
class _TranslationsBackupImportUk implements TranslationsBackupImportEn {
	_TranslationsBackupImportUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
	@override String get error => 'Помилка імпорту файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
	@override String get cancelled => 'Імпорт скасовано користувачем';
}

// Path: backup.about
class _TranslationsBackupAboutUk implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Інформація про вашу базу даних';
	@override String get create_date => 'Дата створення';
	@override String get modify_date => 'Останнє змінено';
	@override String get last_backup => 'Остання резервна копія';
	@override String get size => 'Розмір';
}

// Path: settings.general
class _TranslationsSettingsGeneralUk implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Загальні налаштування';
	@override String get menu_descr => 'Мова, конфіденційність та інше';
	@override late final _TranslationsSettingsGeneralLanguageUk language = _TranslationsSettingsGeneralLanguageUk._(_root);
	@override late final _TranslationsSettingsGeneralLocaleUk locale = _TranslationsSettingsGeneralLocaleUk._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityUk implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Безпека';
	@override String get private_mode_at_launch => 'Приватний режим під час запуску';
	@override String get private_mode_at_launch_descr => 'За замовчуванням запускати програму в приватному режимі';
	@override String get private_mode => 'Приватний режим';
	@override String get private_mode_descr => 'Приховати всі грошові значення';
	@override String get private_mode_activated => 'Приватний режим активовано';
	@override String get private_mode_deactivated => 'Приватний режим вимкнено';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsUk implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Транзакції';
	@override String get menu_descr => 'Налаштуйте поведінку ваших транзакцій';
	@override String get title => 'Налаштування транзакцій';
	@override late final _TranslationsSettingsTransactionsSwipeActionsUk swipe_actions = _TranslationsSettingsTransactionsSwipeActionsUk._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesUk default_values = _TranslationsSettingsTransactionsDefaultValuesUk._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeUk default_type = _TranslationsSettingsTransactionsDefaultTypeUk._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceUk implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Тема та стиль';
	@override String get menu_descr => 'Вибір теми, кольори та інші речі, пов\'язані з виглядом програми';
	@override String get theme_and_colors => 'Тема та кольори';
	@override late final _TranslationsSettingsAppearanceThemeUk theme = _TranslationsSettingsAppearanceThemeUk._(_root);
	@override String get amoled_mode => 'Режим AMOLED';
	@override String get amoled_mode_descr => 'Використовуйте чисто чорний шпалери, якщо це можливо. Це трохи допоможе акумулятору пристроїв з екранами AMOLED';
	@override String get dynamic_colors => 'Динамічні кольори';
	@override String get dynamic_colors_descr => 'Використовуйте колір акценту вашої системи, коли це можливо';
	@override String get accent_color => 'Колір акценту';
	@override String get accent_color_descr => 'Виберіть колір, який додаток буде використовувати для виділення певних частин інтерфейсу';
	@override String get text => 'Текст';
	@override String get font => 'Шрифт';
	@override String get font_platform => 'Платформа';
}

// Path: more.data
class _TranslationsMoreDataUk implements TranslationsMoreDataEn {
	_TranslationsMoreDataUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsMoreAboutUsUk implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Інформація про додаток';
	@override String get description => 'Знаходьте умови Monekin, важливу інформацію та зв\'язуйтеся, повідомляючи про помилки або ділячись ідеями';
	@override late final _TranslationsMoreAboutUsLegalUk legal = _TranslationsMoreAboutUsLegalUk._(_root);
	@override late final _TranslationsMoreAboutUsProjectUk project = _TranslationsMoreAboutUsProjectUk._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsUk implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsGeneralTimeRangesUk implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsGeneralTimePeriodicityUk implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsGeneralTimeCurrentUk implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Цього місяця';
	@override String get annually => 'Цього року';
	@override String get quaterly => 'Цього кварталу';
	@override String get weekly => 'На цьому тижні';
	@override String get infinite => 'Назавжди';
	@override String get custom => 'Власний діапазон';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllUk implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Щоденно';
	@override String get monthly => 'Щомісяця';
	@override String get annually => 'Щороку';
	@override String get quaterly => 'Щокварталу';
	@override String get weekly => 'Щотижня';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrUk implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Схоже, у нас недостатньо витрат, щоб розрахувати ваше фінансове здоров\'я. Додайте деякі витрати/доходи за цей період, щоб дозволити нам допомогти вам!';
	@override String get very_good => 'Вітаємо! Ваше фінансове здоров\'я прекрасне. Сподіваємося, ви продовжите свою успішну хвилю і будете навчатися разом з Monekin';
	@override String get good => 'Чудово! Ваше фінансове здоров\'я гарне. Відвідайте вкладку аналізу, щоб побачити, як зберегти ще більше!';
	@override String get normal => 'Ваше фінансове здоров\'я більш-менш в середньому залишку населення за цей період';
	@override String get bad => 'Схоже, що ваша фінансова ситуація ще не найкраща. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
	@override String get very_bad => 'Хмм, ваше фінансове здоров\'я далеко не відповідає тому, що воно повинно бути. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextUk implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Вітаємо! Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Схоже, ви вже професіонал, продовжуйте в тому ж дусі!';
	@override String normal({required Object value}) => 'Вітаємо, ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду.';
	@override String bad({required Object value}) => 'Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Проте ми вважаємо, що ви все ще можете зробити набагато більше!';
	@override String get very_bad => 'Вау, ви не змогли заощадити нічого протягом цього періоду.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditUk implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Редагувати дати';
	@override String get categories => 'Редагувати категорії';
	@override String get status => 'Редагувати статуси';
}

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedUk implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Збережені фільтри';
	@override String get new_title => 'Новий фільтр';
	@override String get edit_title => 'Редагувати фільтр';
	@override String get name_label => 'Назва фільтру';
	@override String get name_hint => 'Мій власний фільтр';
	@override String get save_dialog_title => 'Зберегти фільтр';
	@override String get save_tooltip => 'Зберегти поточний фільтр';
	@override String get load_tooltip => 'Завантажити збережений фільтр';
	@override String get empty_title => 'Збережених фільтрів не знайдено';
	@override String get empty_description => 'Зберігайте фільтри тут, щоб швидко отримати до них доступ пізніше.';
	@override String get save_success => 'Фільтр успішно збережено';
	@override String get delete_success => 'Фільтр успішно видалено';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsUk implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get zero => 'Значення транзакції не може бути рівним нулю';
	@override String get date_max => 'Обрана дата після поточної. Транзакція буде додана як очікувана';
	@override String get date_after_account_creation => 'Ви не можете створити транзакцію з датою до створення рахунку, до якого вона належить';
	@override String get negative_transfer => 'Монетарна вартість переказу не може бути від\'ємною';
	@override String get transfer_between_same_accounts => 'Облікові записи джерела та призначення не збігаються';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyUk implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Сума переказу в пункті призначення';
	@override String amount_short({required Object amount}) => '${amount} на цільовий рахунок';
}

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsUk implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'За планом';
	@override String get active_overspending => 'Перевитрата';
	@override String get active_indeterminate => 'Активний';
	@override String get success => 'Досягнуто';
	@override String get fail => 'Бюджет перевищено';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionUk implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Ви можете витрачати ${dailyAmount} на день протягом ${remainingDays} днів, що залишилися';
	@override String active_overspending({required Object dailyAmount, required Object remainingDays}) => 'Щоб повернутися до плану, вам слід обмежити витрати до ${dailyAmount} на день протягом ${remainingDays} днів, що залишилися';
	@override String active_indeterminate({required Object amount}) => 'У вас залишилося витратити ${amount}.';
	@override String active_exceeded({required Object amount}) => 'Ви вже перевищили ліміт бюджету на ${amount}. Якщо ви не знайдете жодних доходів для цього бюджету, вам слід припинити витрати до кінця його періоду';
	@override String get success => 'Чудова робота! Цей бюджет успішно завершено. Продовжуйте створювати бюджети для управління витратами';
	@override String fail({required Object amount}) => 'Ви перевищили бюджет на ${amount}. Спробуйте бути уважнішими наступного разу!';
}

// Path: goals.type.income
class _TranslationsGoalsTypeIncomeUk implements TranslationsGoalsTypeIncomeEn {
	_TranslationsGoalsTypeIncomeUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ціль заощадження';
	@override String get descr => 'Ідеально для заощадження грошей. Ви досягаєте успіху, коли баланс перевищує вашу ціль.';
}

// Path: goals.type.expense
class _TranslationsGoalsTypeExpenseUk implements TranslationsGoalsTypeExpenseEn {
	_TranslationsGoalsTypeExpenseUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ціль витрат';
	@override String get descr => 'Відстежуйте, скільки ви витрачаєте, і намагайтеся досягти цільової суми. Добре підходить для пожертвувань...';
}

// Path: goals.progress.labels
class _TranslationsGoalsProgressLabelsUk implements TranslationsGoalsProgressLabelsEn {
	_TranslationsGoalsProgressLabelsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'На шляху';
	@override String get active_behind_schedule => 'Відставання від графіка';
	@override String get active_indeterminate => 'Активний';
	@override String get success => 'Мета досягнута';
	@override String get fail => 'Мета не вдалася';
}

// Path: goals.progress.description
class _TranslationsGoalsProgressDescriptionUk implements TranslationsGoalsProgressDescriptionEn {
	_TranslationsGoalsProgressDescriptionUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Ви на шляху до своєї мети! Ви повинні відкладати ${dailyAmount} на день протягом ${remainingDays} днів, що залишилися';
	@override String active_behind_schedule({required Object dailyAmount, required Object remainingDays}) => 'Ви відстаєте від графіка. Ви повинні заощаджувати ${dailyAmount} на день, щоб досягти своєї мети за ${remainingDays} днів';
	@override String active_indeterminate({required Object amount}) => 'Вам потрібно ще ${amount}, щоб досягти своєї мети.';
	@override String get success => 'Щиро вітаю! Ви досягли своєї мети.';
	@override String fail({required Object amount}) => 'Ви не досягли цілі на ${amount}.';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportUk implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

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

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageUk implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get section => 'Мова та тексти';
	@override String get title => 'Мова додатку';
	@override String get descr => 'Мова, в якій будуть відображатися тексти в додатку';
	@override String get help => 'Якщо ви хочете співпрацювати з перекладами цієї програми, ви можете звернутися до <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>нашого посібник</ a>';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleUk implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Регіон';
	@override String get auto => 'Система';
	@override String get descr => 'Встановіть формат, який буде використовуватися для дат, чисел...';
	@override String get warn => 'Після зміни регіону додаток оновиться';
	@override String get first_day_of_week => 'Перший день тижня';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsUk implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Дії гортання';
	@override String get choose_description => 'Виберіть, яка дія буде ініційована, коли ви проводите пальцем по елементу транзакції у списку в цьому напрямку';
	@override String get none => 'Ніяких дій';
	@override String get swipe_left => 'Проведіть ліворуч';
	@override String get swipe_right => 'Проведіть праворуч';
	@override String get toggle_reconciled => 'Перемикач узгоджено';
	@override String get toggle_pending => 'Перемкнути в очікуванні';
	@override String get toggle_voided => 'Перемикач скасовано';
	@override String get toggle_unreconciled => 'Перемикач неузгоджений';
	@override String get remove_status => 'Видалити статус';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesUk implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Form Values';
	@override String get page_title => 'New Transaction: Default Form Values';
	@override String get reuse_last_transaction => 'Reuse Last Transaction Values';
	@override String get reuse_last_transaction_descr => 'Automatically fill the form with some values from the last created transaction';
	@override String get fields_to_reuse => 'Fields to reuse';
	@override String get reuse_last_values_modal_descr => 'Select the fields that should be pre-filled with the values from the last created transaction.';
	@override String get default_values_separator => 'Default Values';
	@override String get default_category => 'Default Category';
	@override String get default_status => 'Default Status';
	@override String get default_tags => 'Default Tags';
	@override String get no_tags_selected => 'No tags selected';
}

// Path: settings.transactions.default_type
class _TranslationsSettingsTransactionsDefaultTypeUk implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Type';
	@override String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeUk implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get title => 'Тема';
	@override String get auto => 'система';
	@override String get light => 'Світла';
	@override String get dark => 'Темна';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalUk implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Юридична інформація';
	@override String get privacy => 'Політика конфіденційності';
	@override String get terms => 'Умови використання';
	@override String get licenses => 'Ліцензії';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectUk implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get display => 'Проект';
	@override String get contributors => 'Співробітники';
	@override String get contributors_descr => 'Усі розробники, які зробили Monekin краще';
	@override String get contact => 'Зв\'яжіться з нами';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesUk implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesUk._(this._root);

	final TranslationsUk _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Цикли';
	@override String get last_days => 'Останні дні';
	@override String last_days_form({required Object x}) => '${x} попередніх днів';
	@override String get all => 'Завжди';
	@override String get date_range => 'Власний діапазон';
}

/// The flat map containing all translations for locale <uk>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on TranslationsUk {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = 'Скасувати';
		map['ui_actions.confirm'] = 'Підтвердити';
		map['ui_actions.continue_text'] = 'Продовжити';
		map['ui_actions.save'] = 'Зберегти';
		map['ui_actions.save_changes'] = 'Зберегти зміни';
		map['ui_actions.close_and_save'] = 'Закрити та зберегти';
		map['ui_actions.add'] = 'Додати';
		map['ui_actions.edit'] = 'Редагувати';
		map['ui_actions.delete'] = 'Видалити';
		map['ui_actions.see_more'] = 'Детальніше';
		map['ui_actions.select_all'] = 'Вибрати все';
		map['ui_actions.deselect_all'] = 'Скасувати вибір всього';
		map['ui_actions.select'] = 'Вибрати';
		map['ui_actions.search'] = 'Пошук';
		map['ui_actions.filter'] = 'Фільтр';
		map['ui_actions.reset'] = 'Скинути';
		map['ui_actions.submit'] = 'Надіслати';
		map['ui_actions.next'] = 'Далі';
		map['ui_actions.previous'] = 'Назад';
		map['ui_actions.back'] = 'Повернутися';
		map['ui_actions.reload'] = 'Перезавантажити';
		map['ui_actions.view'] = 'Переглянути';
		map['ui_actions.download'] = 'Завантажити';
		map['ui_actions.upload'] = 'Завантажити файл';
		map['ui_actions.retry'] = 'Спробувати знову';
		map['ui_actions.copy'] = 'Копіювати';
		map['ui_actions.paste'] = 'Вставити';
		map['ui_actions.undo'] = 'Скасувати дію';
		map['ui_actions.redo'] = 'Повторити дію';
		map['ui_actions.open'] = 'Відкрити';
		map['ui_actions.close'] = 'Закрити';
		map['ui_actions.apply'] = 'Застосувати';
		map['ui_actions.discard'] = 'Скасувати зміни';
		map['ui_actions.refresh'] = 'Оновити';
		map['ui_actions.share'] = 'Поділитися';
		map['general.or'] = 'або';
		map['general.understood'] = 'Зрозуміло';
		map['general.unspecified'] = 'Не вказано';
		map['general.quick_actions'] = 'Швидкі дії';
		map['general.details'] = 'Подробиці';
		map['general.balance'] = 'Баланс';
		map['general.account'] = 'Рахунок';
		map['general.accounts'] = 'Рахунки';
		map['general.categories'] = 'Категорії';
		map['general.category'] = 'Категорія';
		map['general.today'] = 'Сьогодні';
		map['general.yesterday'] = 'Вчора';
		map['general.filters'] = 'Фільтри';
		map['general.empty_warn'] = 'Ой! Тут порожньо';
		map['general.search_no_results'] = 'Немає елементів, які відповідають вашим критеріям пошуку';
		map['general.insufficient_data'] = 'Недостатньо даних';
		map['general.show_more_fields'] = 'Показати більше полів';
		map['general.show_less_fields'] = 'Показати менше полів';
		map['general.tap_to_search'] = 'Натисніть для пошуку';
		map['general.delete_success'] = 'Елемент успішно видалено';
		map['general.leave_without_saving.title'] = 'Вийти без збереження?';
		map['general.leave_without_saving.message'] = 'У вас є незбережені зміни. Ви впевнені, що бажаєте вийти, не зберігаючи їх?';
		map['general.clipboard.success'] = ({required Object x}) => '${x} скопійовано в буфер обміну';
		map['general.clipboard.error'] = 'Помилка копіювання';
		map['general.time.start_date'] = 'Початкова дата';
		map['general.time.end_date'] = 'Кінцева дата';
		map['general.time.from_date'] = 'З дати';
		map['general.time.until_date'] = 'До дати';
		map['general.time.date'] = 'Дата';
		map['general.time.datetime'] = 'Дата та час';
		map['general.time.time'] = 'Час';
		map['general.time.each'] = 'Кожний';
		map['general.time.after'] = 'Після';
		map['general.time.ranges.display'] = 'Часовий діапазон';
		map['general.time.ranges.it_repeat'] = 'Повторюється';
		map['general.time.ranges.it_ends'] = 'Закінчується';
		map['general.time.ranges.forever'] = 'Назавжди';
		map['general.time.ranges.types.cycle'] = 'Цикли';
		map['general.time.ranges.types.last_days'] = 'Останні дні';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '${x} попередніх днів';
		map['general.time.ranges.types.all'] = 'Завжди';
		map['general.time.ranges.types.date_range'] = 'Власний діапазон';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range}',
				other: 'Кожних ${n} ${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range} до ${day}',
				other: 'Кожних ${n} ${range} до ${day}',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range} ${limit} раз',
				other: 'Кожних ${n} ${range} ${limit} раз',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Кожного ${range} один раз',
				other: 'Кожних ${n} ${range} один раз',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Місяць',
				other: 'Місяці',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Рік',
				other: 'Роки',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'День',
				other: 'Дні',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Тиждень',
				other: 'Тижні',
			);
		map['general.time.periodicity.display'] = 'Повторення';
		map['general.time.periodicity.no_repeat'] = 'Без повторень';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Повторення',
				other: 'Повторень',
			);
		map['general.time.periodicity.diary'] = 'Щоденно';
		map['general.time.periodicity.monthly'] = 'Щомісяця';
		map['general.time.periodicity.annually'] = 'Щороку';
		map['general.time.periodicity.quaterly'] = 'Щокварталу';
		map['general.time.periodicity.weekly'] = 'Щотижня';
		map['general.time.periodicity.custom'] = 'Власний';
		map['general.time.periodicity.infinite'] = 'Завжди';
		map['general.time.current.monthly'] = 'Цього місяця';
		map['general.time.current.annually'] = 'Цього року';
		map['general.time.current.quaterly'] = 'Цього кварталу';
		map['general.time.current.weekly'] = 'На цьому тижні';
		map['general.time.current.infinite'] = 'Назавжди';
		map['general.time.current.custom'] = 'Власний діапазон';
		map['general.time.all.diary'] = 'Щоденно';
		map['general.time.all.monthly'] = 'Щомісяця';
		map['general.time.all.annually'] = 'Щороку';
		map['general.time.all.quaterly'] = 'Щокварталу';
		map['general.time.all.weekly'] = 'Щотижня';
		map['general.transaction_order.display'] = 'Сортувати транзакції';
		map['general.transaction_order.category'] = 'За категорією';
		map['general.transaction_order.quantity'] = 'За кількістю';
		map['general.transaction_order.date'] = 'За датою';
		map['general.validations.form_error'] = 'Виправте поля, зазначені у формі, щоб продовжити';
		map['general.validations.required'] = 'Обов\'язкове поле';
		map['general.validations.positive'] = 'Повинно бути позитивним';
		map['general.validations.min_number'] = ({required Object x}) => 'Повинно бути більшим, ніж ${x}';
		map['general.validations.max_number'] = ({required Object x}) => 'Повинно бути меншим, ніж ${x}';
		map['intro.start'] = 'Початок';
		map['intro.skip'] = 'Пропустити';
		map['intro.next'] = 'Далі';
		map['intro.select_your_currency'] = 'Виберіть вашу валюту';
		map['intro.welcome_subtitle'] = 'Ваш особистий фінансовий менеджер';
		map['intro.welcome_subtitle2'] = '100% відкритий, 100% безкоштовний';
		map['intro.welcome_footer'] = 'Увійшовши в систему, ви погоджуєтеся з <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Політикою конфіденційності</a> та <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Умовами використання</a> додатка';
		map['intro.offline_descr_title'] = 'ОФЛАЙН-РЕЖИМ:';
		map['intro.offline_descr'] = 'Ваші дані будуть збережені тільки на вашому пристрої, поки ви не видалите програму або не зміните телефон. Щоб запобігти втраті даних, рекомендується регулярно робити резервні копії з налаштувань програми.';
		map['intro.offline_start'] = 'Почати сеанс офлайн';
		map['intro.sl1_title'] = 'Виберіть вашу валюту';
		map['intro.sl1_descr'] = 'Ваша основна валюта буде використовуватися в звітах та загальних діаграмах. Ви зможете змінити валюту та мову програми пізніше в будь-який час у налаштуваннях додатка';
		map['intro.sl2_title'] = 'Безпечно, приватно і надійно';
		map['intro.sl2_descr'] = 'Ваші дані належать тільки вам. Інформація зберігається безпосередньо на вашому пристрої, без пропуску через зовнішні сервери. Це дозволяє використовувати додаток навіть без Інтернету';
		map['intro.sl2_descr2'] = 'Крім того, вихідний код програми є відкритим, будь-хто може вносити свої правки та переглядати, як він працює';
		map['intro.last_slide_title'] = 'Все готово';
		map['intro.last_slide_descr'] = 'З Monekin ви нарешті можете досягти фінансової незалежності, яку так багато хочете. У вас будуть графіки, бюджети, поради, статистика та багато іншого про ваші фінанси.';
		map['intro.last_slide_descr2'] = 'Сподіваємося, вам сподобається користуватись додатком! Не соромтеся зв\'язатися з нами у разі сумнівів або пропозицій...';
		map['home.title'] = 'Панель керування';
		map['home.filter_transactions'] = 'Фільтрувати транзакції';
		map['home.hello_day'] = 'Доброго ранку,';
		map['home.hello_night'] = 'Доброї ночі,';
		map['home.total_balance'] = 'Загальний баланс';
		map['home.my_accounts'] = 'Мої рахунки';
		map['home.active_accounts'] = 'Активні рахунки';
		map['home.no_accounts'] = 'Рахунки ще не створені';
		map['home.no_accounts_descr'] = 'Почніть використовувати всю магію Monekin. Створіть принаймні один рахунок, щоб почати додавати транзакції';
		map['home.last_transactions'] = 'Останні транзакції';
		map['home.should_create_account_header'] = 'Ой!';
		map['home.should_create_account_message'] = 'Перш ніж почати створювати транзакції, вам потрібно мати принаймні один неархівований рахунок';
		map['financial_health.display'] = 'Фінансове здоров\'я';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Дуже добре!';
					case GenderContext.female:
						return 'Дуже добре!';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Добре';
					case GenderContext.female:
						return 'Добре';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Середнє';
					case GenderContext.female:
						return 'Середнє';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Прийнятно';
					case GenderContext.female:
						return 'Прийнятно';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Дуже погано';
					case GenderContext.female:
						return 'Дуже погано';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Недостатньо даних';
					case GenderContext.female:
						return 'Недостатньо даних';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = 'Схоже, у нас недостатньо витрат, щоб розрахувати ваше фінансове здоров\'я. Додайте деякі витрати/доходи за цей період, щоб дозволити нам допомогти вам!';
		map['financial_health.review.descr.very_good'] = 'Вітаємо! Ваше фінансове здоров\'я прекрасне. Сподіваємося, ви продовжите свою успішну хвилю і будете навчатися разом з Monekin';
		map['financial_health.review.descr.good'] = 'Чудово! Ваше фінансове здоров\'я гарне. Відвідайте вкладку аналізу, щоб побачити, як зберегти ще більше!';
		map['financial_health.review.descr.normal'] = 'Ваше фінансове здоров\'я більш-менш в середньому залишку населення за цей період';
		map['financial_health.review.descr.bad'] = 'Схоже, що ваша фінансова ситуація ще не найкраща. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
		map['financial_health.review.descr.very_bad'] = 'Хмм, ваше фінансове здоров\'я далеко не відповідає тому, що воно повинно бути. Вивчіть решту графіків, щоб дізнатися більше про свої фінанси';
		map['financial_health.months_without_income.title'] = 'Шанси на виживання';
		map['financial_health.months_without_income.subtitle'] = 'З урахуванням вашого балансу, час, на який ви можете обійтися без доходу';
		map['financial_health.months_without_income.text_zero'] = 'Ви не могли б прожити місяць без доходу з такою швидкістю витрат!';
		map['financial_health.months_without_income.text_one'] = 'Ви ледве могли б прожити близько місяця без доходу з такою швидкістю витрат!';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => 'Ви могли б прожити приблизно <b>${n} місяців</b> без доходу з такою швидкістю витрат.';
		map['financial_health.months_without_income.text_infinite'] = 'Ви могли б прожити приблизно <b>майже все своє життя</b> без доходу з такою швидкістю витрат.';
		map['financial_health.months_without_income.suggestion'] = 'Пам\'ятайте, що рекомендується завжди тримати цей відсоток не менше 5 місяців. Якщо ви бачите, що у вас недостатньо збережень, зменште непотрібні витрати.';
		map['financial_health.months_without_income.insufficient_data'] = 'Схоже, у нас недостатньо витрат, щоб розрахувати, на скільки місяців ви можете вижити без доходу. Введіть кілька транзакцій і повертайтесь сюди, щоб перевірити ваше фінансове здоров\'я';
		map['financial_health.savings_percentage.title'] = 'Відсоток заощаджень';
		map['financial_health.savings_percentage.subtitle'] = 'Яка частина вашого доходу не витрачена за цей період';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => 'Вітаємо! Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Схоже, ви вже професіонал, продовжуйте в тому ж дусі!';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => 'Вітаємо, ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду.';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => 'Ви змогли заощадити <b>${value}%</b> вашого доходу протягом цього періоду. Проте ми вважаємо, що ви все ще можете зробити набагато більше!';
		map['financial_health.savings_percentage.text.very_bad'] = 'Вау, ви не змогли заощадити нічого протягом цього періоду.';
		map['financial_health.savings_percentage.suggestion'] = 'Пам\'ятайте, що рекомендується заощаджувати принаймні 15-20% від вашого доходу.';
		map['stats.title'] = 'Статистика';
		map['stats.balance'] = 'Баланс';
		map['stats.final_balance'] = 'Кінцевий баланс';
		map['stats.balance_by_account'] = 'Баланс за рахунками';
		map['stats.balance_by_account_subtitle'] = 'Де я маю більшість грошей?';
		map['stats.balance_by_currency'] = 'Баланс за валютою';
		map['stats.balance_by_currency_subtitle'] = 'Скільки я маю грошей в іноземній валюті?';
		map['stats.balance_evolution'] = 'Тенденція балансу';
		map['stats.balance_evolution_subtitle'] = 'У мене більше грошей, ніж раніше?';
		map['stats.compared_to_previous_period'] = 'Порівняно з попереднім періодом';
		map['stats.cash_flow'] = 'Грошовий потік';
		map['stats.cash_flow_subtitle'] = 'Я витрачаю менше, ніж заробляю?';
		map['stats.by_periods'] = 'За періодами';
		map['stats.by_categories'] = 'За категоріями';
		map['stats.by_tags'] = 'За тегами';
		map['stats.distribution'] = 'Розподіл';
		map['stats.finance_health_resume'] = 'Підсумок фінансового здоров\'я';
		map['stats.finance_health_breakdown'] = 'Детальний аналіз фінансового здоров\'я';
		map['icon_selector.name'] = 'Назва:';
		map['icon_selector.icon'] = 'Іконка';
		map['icon_selector.color'] = 'Колір';
		map['icon_selector.select_icon'] = 'Виберіть іконку';
		map['icon_selector.select_color'] = 'Виберіть колір';
		map['icon_selector.custom_color'] = 'Користувацький колір';
		map['icon_selector.current_color_selection'] = 'Поточний вибір';
		map['icon_selector.select_account_icon'] = 'Ідентифікуйте ваш рахунок';
		map['icon_selector.select_category_icon'] = 'Ідентифікуйте вашу категорію';
		map['icon_selector.scopes.transport'] = 'Транспорт';
		map['icon_selector.scopes.money'] = 'Гроші';
		map['icon_selector.scopes.food'] = 'Їжа';
		map['icon_selector.scopes.medical'] = 'Медицина';
		map['icon_selector.scopes.entertainment'] = 'Розваги';
		map['icon_selector.scopes.technology'] = 'Технології';
		map['icon_selector.scopes.other'] = 'Інше';
		map['icon_selector.scopes.logos_financial_institutions'] = 'Фінансові установи';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Транзакція',
				other: 'Транзакції',
			);
		map['transaction.create'] = 'Нова транзакція';
		map['transaction.new_income'] = 'Новий дохід';
		map['transaction.new_expense'] = 'Новий витрати';
		map['transaction.new_success'] = 'Транзакція успішно створена';
		map['transaction.edit'] = 'Редагувати транзакцію';
		map['transaction.edit_success'] = 'Транзакція успішно відредагована';
		map['transaction.edit_multiple'] = 'редагувати транзакції';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x} належним чином відредаговані транзакції';
		map['transaction.duplicate'] = 'Клонувати транзакцію';
		map['transaction.duplicate_short'] = 'Клон';
		map['transaction.duplicate_warning_message'] = 'Транзакція, ідентична цій, буде створена з такою ж датою. Бажаєте продовжити?';
		map['transaction.duplicate_success'] = 'Транзакція успішно склонована';
		map['transaction.delete'] = 'Видалити транзакцію';
		map['transaction.delete_warning_message'] = 'Ця дія незворотня. Поточний баланс ваших рахунків і всі ваші статистичні дані будуть перераховані';
		map['transaction.delete_success'] = 'Транзакцію успішно видалено';
		map['transaction.delete_multiple'] = 'Усунути транзакції';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => 'Ця дія незворотна і безумовно стерть ${x} транзакції. Поточний баланс ваших рахунків та вся ваша статистика будуть перенесені';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x} належним чином усунути транзакції';
		map['transaction.details'] = 'Деталі руху коштів';
		map['transaction.next_payments.accept'] = 'Прийняти';
		map['transaction.next_payments.skip'] = 'Пропустити';
		map['transaction.next_payments.skip_success'] = 'Транзакцію успішно пропущено';
		map['transaction.next_payments.skip_dialog_title'] = 'Пропустити транзакцію';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => 'Ця дія незворотня. Ми перемістимо дату наступного переходу до ${date}';
		map['transaction.next_payments.accept_today'] = 'Прийняти сьогодні';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => 'Прийняти в потрібну дату (${date})';
		map['transaction.next_payments.accept_dialog_title'] = 'Прийняти транзакцію';
		map['transaction.next_payments.accept_dialog_msg_single'] = 'Новий статус транзакції буде нульовим. Ви можете знову редагувати статус цієї транзакції в будь-який момент';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => 'Ця дія створить нову транзакцію з датою ${date}. Ви зможете переглянути деталі цієї транзакції на сторінці транзакцій';
		map['transaction.next_payments.recurrent_rule_finished'] = 'Правило періодичності було завершено, більше немає платежів!';
		map['transaction.list.all'] = 'Всі транзакції';
		map['transaction.list.empty'] = 'Тут не знайдено жодних транзакцій для відображення. Додайте кілька транзакцій у додаток, і, можливо, наступного разу вам пощастить більше';
		map['transaction.list.searcher_placeholder'] = 'Шукати за категорією, описом...';
		map['transaction.list.searcher_no_results'] = 'Не знайдено транзакцій, що відповідають критеріям пошуку';
		map['transaction.list.loading'] = 'Завантаження додаткових транзакцій...';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: '${n} вибрано',
				other: 'вибрано ${n}',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: '${n} вибрана транзакція',
				other: '${n} вибраних транзакцій',
			);
		map['transaction.list.bulk_edit.dates'] = 'Редагувати дати';
		map['transaction.list.bulk_edit.categories'] = 'Редагувати категорії';
		map['transaction.list.bulk_edit.status'] = 'Редагувати статуси';
		map['transaction.filters.title'] = 'Фільтри транзакцій';
		map['transaction.filters.from_value'] = 'Від суми';
		map['transaction.filters.to_value'] = 'До суми';
		map['transaction.filters.from_value_def'] = ({required Object x}) => 'Від ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => 'До ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => 'З ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => 'До ${date}';
		map['transaction.filters.reset'] = 'Скинути фільтри';
		map['transaction.filters.saved.title'] = 'Збережені фільтри';
		map['transaction.filters.saved.new_title'] = 'Новий фільтр';
		map['transaction.filters.saved.edit_title'] = 'Редагувати фільтр';
		map['transaction.filters.saved.name_label'] = 'Назва фільтру';
		map['transaction.filters.saved.name_hint'] = 'Мій власний фільтр';
		map['transaction.filters.saved.save_dialog_title'] = 'Зберегти фільтр';
		map['transaction.filters.saved.save_tooltip'] = 'Зберегти поточний фільтр';
		map['transaction.filters.saved.load_tooltip'] = 'Завантажити збережений фільтр';
		map['transaction.filters.saved.empty_title'] = 'Збережених фільтрів не знайдено';
		map['transaction.filters.saved.empty_description'] = 'Зберігайте фільтри тут, щоб швидко отримати до них доступ пізніше.';
		map['transaction.filters.saved.save_success'] = 'Фільтр успішно збережено';
		map['transaction.filters.saved.delete_success'] = 'Фільтр успішно видалено';
		map['transaction.form.validators.zero'] = 'Значення транзакції не може бути рівним нулю';
		map['transaction.form.validators.date_max'] = 'Обрана дата після поточної. Транзакція буде додана як очікувана';
		map['transaction.form.validators.date_after_account_creation'] = 'Ви не можете створити транзакцію з датою до створення рахунку, до якого вона належить';
		map['transaction.form.validators.negative_transfer'] = 'Монетарна вартість переказу не може бути від\'ємною';
		map['transaction.form.validators.transfer_between_same_accounts'] = 'Облікові записи джерела та призначення не збігаються';
		map['transaction.form.title'] = 'Назва транзакції';
		map['transaction.form.title_short'] = 'Назва';
		map['transaction.form.value'] = 'Сума транзакції';
		map['transaction.form.tap_to_see_more'] = 'Натисніть, щоб побачити більше деталей';
		map['transaction.form.no_tags'] = '-- Немає тегів --';
		map['transaction.form.description'] = 'Опис';
		map['transaction.form.description_info'] = 'Натисніть тут, щоб ввести детальніший опис цієї транзакції';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => 'Обмінний курс на ${currency}';
		map['transaction.form.exchange_to_preferred_in_date'] = 'На дату транзакції';
		map['transaction.reversed.title'] = 'Скасована транзакція';
		map['transaction.reversed.title_short'] = 'Перевернутий тр.';
		map['transaction.reversed.description_for_expenses'] = 'Незважаючи на те, що транзакція типу витрат, ця транзакція має додатну суму. Ці типи транзакцій можна використовувати для представлення повернення раніше зареєстрованих витрат, таких як відшкодування або оплата борг.';
		map['transaction.reversed.description_for_incomes'] = 'Незважаючи на те, що транзакція є дохідною, ця транзакція має від’ємну суму. Ці типи транзакцій можна використовувати ля анулювання або виправлення неправильно зареєстрованого доходу, для відображення повернення або відшкодування грошей або для обліку сплати боргів».';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Статус',
				other: 'Статуси',
			);
		map['transaction.status.display_long'] = 'Статус транзакції';
		map['transaction.status.tr_status'] = ({required Object status}) => '${status} транзакція';
		map['transaction.status.none'] = 'Без статусу';
		map['transaction.status.none_descr'] = 'Транзакція без певного стану';
		map['transaction.status.reconciled'] = 'Узгоджений';
		map['transaction.status.reconciled_descr'] = 'Ця транзакція вже підтверджена і відповідає реальній транзакції з вашого банку';
		map['transaction.status.unreconciled'] = 'Не узгоджений';
		map['transaction.status.unreconciled_descr'] = 'Ця транзакція ще не підтверджена і тому ще не відображається у ваших реальних банківських рахунках. Однак вона враховується при розрахунку балансів і статистики в Monekin';
		map['transaction.status.pending'] = 'Очікується';
		map['transaction.status.pending_descr'] = 'Ця транзакція очікується і тому не буде враховуватися при розрахунку балансів і статистики';
		map['transaction.status.voided'] = 'Скасований';
		map['transaction.status.voided_descr'] = 'Скасована транзакція через помилку в платежі або будь-яку іншу причину. Вона не буде враховуватися при розрахунку балансів і статистики';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Тип транзакції',
				other: 'Типи транзакцій',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Дохід',
				other: 'Доходи',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Витрата',
				other: 'Витрати',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Переказ',
				other: 'Перекази',
			);
		map['transfer.display'] = 'Переказ';
		map['transfer.transfers'] = 'Перекази';
		map['transfer.transfer_to'] = ({required Object account}) => 'Переказ на ${account}';
		map['transfer.create'] = 'Новий переказ';
		map['transfer.need_two_accounts_warning_header'] = 'Увага!';
		map['transfer.need_two_accounts_warning_message'] = 'Для виконання цієї дії потрібно щонайменше два рахунки. Якщо вам потрібно відредагувати поточний баланс цього рахунку, натисніть кнопку редагування';
		map['transfer.form.from'] = 'Початковий рахунок';
		map['transfer.form.to'] = 'Цільовий рахунок';
		map['transfer.form.value_in_destiny.title'] = 'Сума переказу в пункті призначення';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} на цільовий рахунок';
		map['recurrent_transactions.title'] = 'Повторювані транзакції';
		map['recurrent_transactions.title_short'] = 'Повт. транзакції';
		map['recurrent_transactions.empty'] = 'Схоже, у вас немає жодних повторюваних транзакцій. Створіть щомісячну, щорічну або щотижневу повторювану транзакцію, і вона з\'явиться тут';
		map['recurrent_transactions.total_expense_title'] = 'Загальні витрати за період';
		map['recurrent_transactions.total_expense_descr'] = '* Без урахування початкової та кінцевої дати кожної повторюваної транзакції';
		map['recurrent_transactions.details.title'] = 'Повторювана транзакція';
		map['recurrent_transactions.details.descr'] = 'Наступні переміщення для цієї транзакції показані нижче. Ви можете прийняти перший рух або пропустити цей рух';
		map['recurrent_transactions.details.last_payment_info'] = 'Цей рух є останнім за повторюваною правилою, тому це правило буде автоматично видалено при підтвердженні цієї дії';
		map['recurrent_transactions.details.delete_header'] = 'Видалити повторювану транзакцію';
		map['recurrent_transactions.details.delete_message'] = 'Ця дія є незворотньою і не вплине на транзакції, які ви вже підтвердили/оплатили';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => 'Затримано на ${x}d';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => 'Через ${x} днів';
		map['account.details'] = 'Деталі рахунку';
		map['account.date'] = 'Дата відкриття';
		map['account.close_date'] = 'Дата закриття';
		map['account.reopen'] = 'Повторно відкрити рахунок';
		map['account.reopen_short'] = 'Повторно відкрити';
		map['account.reopen_descr'] = 'Ви впевнені, що хочете повторно відкрити цей рахунок?';
		map['account.balance'] = 'Баланс рахунку';
		map['account.n_transactions'] = 'Кількість транзакцій';
		map['account.add_money'] = 'Додати кошти';
		map['account.withdraw_money'] = 'Зняти кошти';
		map['account.no_accounts'] = 'Тут не знайдено жодних транзакцій для відображення. Додайте транзакцію, натиснувши кнопку \'+\' внизу';
		map['account.types.title'] = 'Тип рахунку';
		map['account.types.warning'] = 'Після вибору типу рахунку його не можна буде змінити в майбутньому';
		map['account.types.normal'] = 'Звичайний рахунок';
		map['account.types.normal_descr'] = 'Використовується для фіксації вашої повсякденної фінансової діяльності. Це найбільш поширений рахунок, який дозволяє додавати витрати, доходи...';
		map['account.types.saving'] = 'Зберігаючий рахунок';
		map['account.types.saving_descr'] = 'З нього можна тільки додавати та знімати гроші з інших рахунків. Ідеально підходить для початку збереження грошей';
		map['account.form.name'] = 'Назва рахунку';
		map['account.form.name_placeholder'] = 'Наприклад: Зберігаючий рахунок';
		map['account.form.notes'] = 'Примітки';
		map['account.form.notes_placeholder'] = 'Введіть примітки/опис про цей рахунок';
		map['account.form.initial_balance'] = 'Початковий баланс';
		map['account.form.current_balance'] = 'Поточний баланс';
		map['account.form.create'] = 'Створити рахунок';
		map['account.form.edit'] = 'Редагувати рахунок';
		map['account.form.currency_not_found_warn'] = 'У вас немає інформації про обмінні курси для цієї валюти. За замовчуванням буде використано 1.0 як курс обміну. Ви можете змінити це в налаштуваннях';
		map['account.form.already_exists'] = 'Вже існує інший з такою самою назвою, будь ласка, введіть іншу';
		map['account.form.tr_before_opening_date'] = 'В цьому рахунку є транзакції з датою перед датою відкриття';
		map['account.form.iban'] = 'IBAN';
		map['account.form.swift'] = 'SWIFT';
		map['account.delete.warning_header'] = 'Видалити рахунок?';
		map['account.delete.warning_text'] = 'Ця дія видалить цей рахунок і всі його транзакції';
		map['account.delete.success'] = 'Рахунок успішно видалено';
		map['account.close.title'] = 'Закрити рахунок';
		map['account.close.title_short'] = 'Закрити';
		map['account.close.warn'] = 'Цей рахунок більше не буде відображатися у певних списках, і ви не зможете створювати транзакції в ньому з датою пізніше, ніж вказана нижче. Ця дія не впливає на жодні транзакції або баланс, і ви також можете повторно відкрити цей рахунок у будь-який час. ';
		map['account.close.should_have_zero_balance'] = 'Баланс цього рахунку повинен бути 0, щоб його закрити. Будь ласка, відредагуйте рахунок перед продовженням';
		map['account.close.should_have_no_transactions'] = 'У цього рахунку є транзакції після вказаної дати закриття. Видаліть їх або відредагуйте дату закриття рахунку перед продовженням';
		map['account.close.success'] = 'Рахунок успішно закрито';
		map['account.close.unarchive_succes'] = 'Рахунок успішно повторно відкрито';
		map['account.select.one'] = 'Виберіть рахунок';
		map['account.select.all'] = 'Всі рахунки';
		map['account.select.multiple'] = 'Вибрати рахунки';
		map['currencies.currency_converter'] = 'Конвертер валют';
		map['currencies.currency'] = 'Валюта';
		map['currencies.currency_settings'] = 'Параметри валюти';
		map['currencies.currency_manager'] = 'Менеджер валют';
		map['currencies.currency_manager_descr'] = 'Налаштуйте вашу валюту та її обмінні курси з іншими';
		map['currencies.preferred_currency'] = 'Перевагова/базова валюта';
		map['currencies.tap_to_change_preferred_currency'] = 'Торкніться, щоб змінити';
		map['currencies.change_preferred_currency_title'] = 'Змінити перевагову валюту';
		map['currencies.change_preferred_currency_msg'] = 'Усі статистичні дані та бюджети будуть відображатися в цій валюті відтепер. Рахунки та транзакції залишаться у тій валюті, яку вони мали. Усі збережені обмінні курси будуть видалені, якщо ви виконаєте цю дію. Ви хочете продовжити?';
		map['currencies.exchange_rate_form.equal_to_preferred_warn'] = 'Валюта не може бути однаковою з валютою користувача';
		map['currencies.exchange_rate_form.override_existing_warn'] = 'Курс обміну для цієї валюти на цю дату вже існує. Якщо ви продовжите, попередній буде перезаписано';
		map['currencies.exchange_rate_form.specify_a_currency'] = 'Будь ласка, вкажіть валюту';
		map['currencies.exchange_rate_form.add'] = 'Додати обмінний курс';
		map['currencies.exchange_rate_form.add_success'] = 'Обмінний курс успішно додано';
		map['currencies.exchange_rate_form.edit'] = 'Редагувати обмінний курс';
		map['currencies.exchange_rate_form.edit_success'] = 'Обмінний курс успішно відредаговано';
		map['currencies.exchange_rate_form.remove_all'] = 'Видалити всі курси валют';
		map['currencies.exchange_rate_form.remove_all_warning'] = 'Цю дію не можна відмінити, і всі курси обміну для цієї валюти буде видалено';
		map['currencies.types.display'] = 'Тип валюти';
		map['currencies.types.fiat'] = 'FIAT';
		map['currencies.types.crypto'] = 'Криптовалюта';
		map['currencies.types.other'] = 'інше';
		map['currencies.currency_form.name'] = 'Відображуване ім\'я';
		map['currencies.currency_form.code'] = 'Код валюти';
		map['currencies.currency_form.symbol'] = 'символ';
		map['currencies.currency_form.decimal_digits'] = 'Десяткові цифри';
		map['currencies.currency_form.create'] = 'Створіть валюту';
		map['currencies.currency_form.create_success'] = 'Валюту створено успішно';
		map['currencies.currency_form.edit'] = 'Редагувати валюту';
		map['currencies.currency_form.edit_success'] = 'Валюту успішно відредаговано';
		map['currencies.currency_form.delete'] = 'Видалити валюту';
		map['currencies.currency_form.delete_success'] = 'Валюту успішно видалено';
		map['currencies.currency_form.already_exists'] = 'Валюта з таким кодом уже існує. Ви можете відредагувати його';
		map['currencies.delete_all_success'] = 'Обмінні курси успішно видалено';
		map['currencies.historical'] = 'Історичні курси';
		map['currencies.historical_empty'] = 'Історичних курсів обміну для цієї валюти не знайдено';
		map['currencies.exchange_rate'] = 'Обмінний курс';
		map['currencies.exchange_rates'] = 'Обмінні курси';
		map['currencies.min_exchange_rate'] = 'Мінімальний курс обміну';
		map['currencies.max_exchange_rate'] = 'Максимальний курс обміну';
		map['currencies.empty'] = 'Додайте тут обмінні курси, щоб, якщо у вас є рахунки в інших валютах, наші графіки були б точнішими';
		map['currencies.select_a_currency'] = 'Виберіть валюту';
		map['currencies.search'] = 'Пошук за назвою або кодом валюти';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: 'Мітка',
				other: 'Теги',
			);
		map['tags.form.name'] = 'Назва тегу';
		map['tags.form.description'] = 'Опис';
		map['tags.select.title'] = 'Вибрати теги';
		map['tags.select.all'] = 'Усі теги';
		map['tags.empty_list'] = 'Ви ще не створили жодних тегів. Теги та категорії - це відмінний спосіб категоризувати ваші рухи';
		map['tags.without_tags'] = 'Без тегів';
		map['tags.add'] = 'Додати тег';
		map['tags.create'] = 'Створити мітку';
		map['tags.create_success'] = 'Мітка успішно створена';
		map['tags.already_exists'] = 'Ця назва тегу вже існує. Ви можете відредагувати її';
		map['tags.edit'] = 'Редагувати тег';
		map['tags.edit_success'] = 'Тег успішно відредаговано';
		map['tags.delete_success'] = 'Тег успішно видалено';
		map['tags.delete_warning_header'] = 'Видалити тег?';
		map['tags.delete_warning_message'] = 'Ця дія не призведе до видалення транзакцій, які мають цей тег.';
		map['categories.unknown'] = 'Невідома категорія';
		map['categories.create'] = 'Створити категорію';
		map['categories.create_success'] = 'Категорія успішно створена';
		map['categories.new_category'] = 'Нова категорія';
		map['categories.already_exists'] = 'Така назва категорії вже існує. Можливо, ви хочете відредагувати її';
		map['categories.edit'] = 'Редагувати категорію';
		map['categories.edit_success'] = 'Категорію успішно відредаговано';
		map['categories.name'] = 'Назва категорії';
		map['categories.type'] = 'Тип категорії';
		map['categories.both_types'] = 'Обидва типи';
		map['categories.subcategories'] = 'Підкатегорії';
		map['categories.subcategories_add'] = 'Додати підкатегорію';
		map['categories.make_parent'] = 'Зробити батьківською категорією';
		map['categories.make_child'] = 'Зробити підкатегорією';
		map['categories.make_child_warning1'] = ({required Object destiny}) => 'Ця категорія та її підкатегорії стануть підкатегоріями <b>${destiny}</b>.';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => 'Їх транзакції <b>(${x})</b> будуть перенесені до нових підкатегорій, створених всередині категорії <b>${destiny}</b>.';
		map['categories.make_child_success'] = 'Підкатегорії успішно створено';
		map['categories.merge'] = 'Об\'єднати з іншою категорією';
		map['categories.merge_warning1'] = ({required Object x, required Object from, required Object destiny}) => 'Всі транзакції (${x}), пов\'язані з категорією <b>${from}</b>, будуть перенесені до категорії <b>${destiny}</b>';
		map['categories.merge_warning2'] = ({required Object from}) => 'Категорія <b>${from}</b> буде безповоротно видалена.';
		map['categories.merge_success'] = 'Категорії успішно об\'єднані';
		map['categories.delete_success'] = 'Категорію видалено коректно';
		map['categories.delete_warning_header'] = 'Видалити категорію?';
		map['categories.delete_warning_message'] = ({required Object x}) => 'Ця дія незворотно видалить всі транзакції <b>(${x})</b>, пов\'язані з цією категорією.';
		map['categories.select.title'] = 'Вибрати категорії';
		map['categories.select.select_one'] = 'Виберіть категорію';
		map['categories.select.select_subcategory'] = 'Оберіть підкатегорію';
		map['categories.select.without_subcategory'] = 'Без підкатегорії';
		map['categories.select.all'] = 'Усі категорії';
		map['categories.select.all_short'] = 'Усі';
		map['budgets.title'] = 'Бюджети';
		map['budgets.status'] = 'Стан бюджету';
		map['budgets.repeated'] = 'Повторювані';
		map['budgets.one_time'] = 'Одноразові';
		map['budgets.actives'] = 'Активні';
		map['budgets.from_budgeted'] = 'з ';
		map['budgets.days_left'] = 'днів залишилось';
		map['budgets.days_to_start'] = 'днів до початку';
		map['budgets.since_expiration'] = 'днів після закінчення терміну';
		map['budgets.no_budgets'] = 'Здається, що в цьому розділі немає жодних бюджетів для відображення. Розпочніть з створення бюджету, натиснувши кнопку нижче';
		map['budgets.delete'] = 'Видалити бюджет';
		map['budgets.delete_warning'] = 'Ця дія незворотня. Категорії та транзакції, що стосуються цитати, не будуть видалені';
		map['budgets.form.title'] = 'Додати бюджет';
		map['budgets.form.name'] = 'Назва бюджету';
		map['budgets.form.value'] = 'Обмежена кількість';
		map['budgets.form.create'] = 'Додати бюджет';
		map['budgets.form.create_success'] = 'Бюджет створено успішно';
		map['budgets.form.edit'] = 'Редагувати бюджет';
		map['budgets.form.edit_success'] = 'Бюджет успішно відредаговано';
		map['budgets.form.negative_warn'] = 'Бюджети не можуть мати від\'ємну суму';
		map['budgets.details.title'] = 'Деталі бюджету';
		map['budgets.details.statistics'] = 'Статистика';
		map['budgets.details.budget_value'] = 'Заплановано';
		map['budgets.details.expend_evolution'] = 'Еволюція витрат';
		map['budgets.details.no_transactions'] = 'Здається, ви не здійснили жодних витрат, пов\'язаних з цим бюджетом';
		map['budgets.target_timeline_statuses.active'] = 'Активний бюджет';
		map['budgets.target_timeline_statuses.past'] = 'Завершений бюджет';
		map['budgets.target_timeline_statuses.future'] = 'Майбутній бюджет';
		map['budgets.progress.labels.active_on_track'] = 'За планом';
		map['budgets.progress.labels.active_overspending'] = 'Перевитрата';
		map['budgets.progress.labels.active_indeterminate'] = 'Активний';
		map['budgets.progress.labels.success'] = 'Досягнуто';
		map['budgets.progress.labels.fail'] = 'Бюджет перевищено';
		map['budgets.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'Ви можете витрачати ${dailyAmount} на день протягом ${remainingDays} днів, що залишилися';
		map['budgets.progress.description.active_overspending'] = ({required Object dailyAmount, required Object remainingDays}) => 'Щоб повернутися до плану, вам слід обмежити витрати до ${dailyAmount} на день протягом ${remainingDays} днів, що залишилися';
		map['budgets.progress.description.active_indeterminate'] = ({required Object amount}) => 'У вас залишилося витратити ${amount}.';
		map['budgets.progress.description.active_exceeded'] = ({required Object amount}) => 'Ви вже перевищили ліміт бюджету на ${amount}. Якщо ви не знайдете жодних доходів для цього бюджету, вам слід припинити витрати до кінця його періоду';
		map['budgets.progress.description.success'] = 'Чудова робота! Цей бюджет успішно завершено. Продовжуйте створювати бюджети для управління витратами';
		map['budgets.progress.description.fail'] = ({required Object amount}) => 'Ви перевищили бюджет на ${amount}. Спробуйте бути уважнішими наступного разу!';
		map['goals.title'] = 'Цілі';
		map['goals.status'] = 'Статус цілі';
		map['goals.type.display'] = 'Goal Type';
		map['goals.type.income.title'] = 'Ціль заощадження';
		map['goals.type.income.descr'] = 'Ідеально для заощадження грошей. Ви досягаєте успіху, коли баланс перевищує вашу ціль.';
		map['goals.type.expense.title'] = 'Ціль витрат';
		map['goals.type.expense.descr'] = 'Відстежуйте, скільки ви витрачаєте, і намагайтеся досягти цільової суми. Добре підходить для пожертвувань...';
		map['goals.empty_title'] = 'Цілей не знайдено';
		map['goals.empty_description'] = 'Створіть нову ціль, щоб почати відстежувати свої заощадження!';
		map['goals.delete'] = 'Delete goal';
		map['goals.delete_warning'] = 'This action is irreversible. Categories and transactions referring to this goal will not be deleted';
		map['goals.form.new_title'] = 'New Goal';
		map['goals.form.edit_title'] = 'Edit Goal';
		map['goals.form.target_amount'] = 'Target Amount';
		map['goals.form.initial_amount'] = 'Initial Amount';
		map['goals.form.name'] = 'Name';
		map['goals.form.name_hint'] = 'My Saving Goal';
		map['goals.form.create_success'] = 'Goal created successfully';
		map['goals.form.edit_success'] = 'Goal edited successfully';
		map['goals.form.negative_warn'] = 'The goal amount cannot be negative';
		map['goals.details.title'] = 'Goal Details';
		map['goals.details.statistics'] = 'Statistics';
		map['goals.details.goal_value'] = 'Goal Target';
		map['goals.details.evolution'] = 'Evolution';
		map['goals.details.no_transactions'] = 'It seems that you have not made any transactions related to this goal';
		map['goals.target_timeline_statuses.active'] = 'Active goal';
		map['goals.target_timeline_statuses.past'] = 'Finished goal';
		map['goals.target_timeline_statuses.future'] = 'Future goal';
		map['goals.progress.labels.active_on_track'] = 'На шляху';
		map['goals.progress.labels.active_behind_schedule'] = 'Відставання від графіка';
		map['goals.progress.labels.active_indeterminate'] = 'Активний';
		map['goals.progress.labels.success'] = 'Мета досягнута';
		map['goals.progress.labels.fail'] = 'Мета не вдалася';
		map['goals.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'Ви на шляху до своєї мети! Ви повинні відкладати ${dailyAmount} на день протягом ${remainingDays} днів, що залишилися';
		map['goals.progress.description.active_behind_schedule'] = ({required Object dailyAmount, required Object remainingDays}) => 'Ви відстаєте від графіка. Ви повинні заощаджувати ${dailyAmount} на день, щоб досягти своєї мети за ${remainingDays} днів';
		map['goals.progress.description.active_indeterminate'] = ({required Object amount}) => 'Вам потрібно ще ${amount}, щоб досягти своєї мети.';
		map['goals.progress.description.success'] = 'Щиро вітаю! Ви досягли своєї мети.';
		map['goals.progress.description.fail'] = ({required Object amount}) => 'Ви не досягли цілі на ${amount}.';
		map['target_timeline_statuses.active'] = 'Активний';
		map['target_timeline_statuses.past'] = 'Завершений';
		map['target_timeline_statuses.future'] = 'Майбутній';
		map['backup.no_file_selected'] = 'Файл не вибрано';
		map['backup.no_directory_selected'] = 'Каталог не вибрано';
		map['backup.export.title'] = 'Експорт ваших даних';
		map['backup.export.title_short'] = 'Експорт';
		map['backup.export.type_of_export'] = 'Тип експорту';
		map['backup.export.other_options'] = 'Опції';
		map['backup.export.all'] = 'Повне резервне копіювання';
		map['backup.export.all_descr'] = 'Експортувати всі ваші дані (рахунки, транзакції, бюджети, налаштування...). Імпортуйте їх знову у будь-який момент, щоб нічого не втратити.';
		map['backup.export.transactions'] = 'Резервне копіювання транзакцій';
		map['backup.export.transactions_descr'] = 'Експортуйте ваші транзакції у форматі CSV, щоб ви могли зручніше їх аналізувати в інших програмах або застосунках.';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(n,
				one: '1 транзакція для експорту',
				other: '${n} транзакцій для експорту',
			);
		map['backup.export.description'] = 'Завантажте ваші дані у різних форматах';
		map['backup.export.send_file'] = 'Надіслати файл';
		map['backup.export.see_folder'] = 'Дивіться папку';
		map['backup.export.success'] = ({required Object x}) => 'Файл успішно збережено/завантажено у ${x}';
		map['backup.export.error'] = 'Помилка при завантаженні файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
		map['backup.export.dialog_title'] = 'Зберегти/Відправити файл';
		map['backup.import.title'] = 'Імпорт ваших даних';
		map['backup.import.title_short'] = 'Імпорт';
		map['backup.import.restore_backup'] = 'Відновити резервну копію';
		map['backup.import.restore_backup_descr'] = 'Імпортуйте раніше збережену базу даних з Monekin. Ця дія замінить будь-які поточні дані програми новими даними';
		map['backup.import.restore_backup_warn_description'] = 'При імпорті нової бази даних ви втратите всі дані, які вже збережено в програмі. Рекомендується зробити резервну копію перед продовженням. Не завантажуйте сюди будь-який файл, походження якого ви не знаєте, завантажуйте лише файли, які ви раніше завантажили з Monekin';
		map['backup.import.restore_backup_warn_title'] = 'Перезаписати всі дані';
		map['backup.import.select_other_file'] = 'Вибрати інший файл';
		map['backup.import.tap_to_select_file'] = 'Торкніться, щоб вибрати файл';
		map['backup.import.manual_import.title'] = 'Ручний імпорт';
		map['backup.import.manual_import.descr'] = 'Імпортуйте транзакції з файлу .csv вручну';
		map['backup.import.manual_import.default_account'] = 'Типовий рахунок';
		map['backup.import.manual_import.remove_default_account'] = 'Видалити типовий рахунок';
		map['backup.import.manual_import.default_category'] = 'Типова категорія';
		map['backup.import.manual_import.select_a_column'] = 'Виберіть стовпець з файлу .csv';
		map['backup.import.manual_import.steps.0'] = 'Виберіть ваш файл';
		map['backup.import.manual_import.steps.1'] = 'Стовпець для суми';
		map['backup.import.manual_import.steps.2'] = 'Стовпець для рахунку';
		map['backup.import.manual_import.steps.3'] = 'Стовпець для категорії';
		map['backup.import.manual_import.steps.4'] = 'Стовпець для дати';
		map['backup.import.manual_import.steps.5'] = 'інші стовпці';
		map['backup.import.manual_import.steps_descr.0'] = 'Виберіть файл .csv з вашого пристрою. Переконайтеся, що в ньому є перший рядок, який описує назву кожного стовпця';
		map['backup.import.manual_import.steps_descr.1'] = 'Виберіть стовпець, де вказано значення кожної транзакції. Використовуйте від\'ємні значення для витрат та позитивні значення для доходів. Використовуйте крапку як десятковий роздільник';
		map['backup.import.manual_import.steps_descr.2'] = 'Виберіть стовпець, де вказано рахунок, до якого належить кожна транзакція. Ви також можете вибрати типовий рахунок у випадку, якщо ми не зможемо знайти рахунок, який вам потрібен. Якщо типовий рахунок не вказано, ми створимо його з такою самою назвою';
		map['backup.import.manual_import.steps_descr.3'] = 'Вкажіть стовпець, де знаходиться назва категорії транзакції. Ви повинні вказати типову категорію, щоб ми призначили цю категорію транзакціям, у випадку, якщо категорія не може бути знайдена';
		map['backup.import.manual_import.steps_descr.4'] = 'Виберіть стовпець, де вказано дату кожної транзакції. Якщо не вказано, транзакції будуть створені з поточною датою';
		map['backup.import.manual_import.steps_descr.5'] = 'Вкажіть стовпці для інших необов\'язкових атрибутів транзакцій';
		map['backup.import.manual_import.success'] = ({required Object x}) => 'Успішно імпортовано ${x} транзакцій';
		map['backup.import.success'] = 'Імпорт виконано успішно';
		map['backup.import.error'] = 'Помилка імпорту файлу. Будь ласка, зв\'яжіться з розробником за адресою lozin.technologies@gmail.com';
		map['backup.import.cancelled'] = 'Імпорт скасовано користувачем';
		map['backup.about.title'] = 'Інформація про вашу базу даних';
		map['backup.about.create_date'] = 'Дата створення';
		map['backup.about.modify_date'] = 'Останнє змінено';
		map['backup.about.last_backup'] = 'Остання резервна копія';
		map['backup.about.size'] = 'Розмір';
		map['settings.title_long'] = 'Налаштування та Персоналізація';
		map['settings.title_short'] = 'Налаштування';
		map['settings.description'] = 'Тема, Мова, Дані та інше';
		map['settings.edit_profile'] = 'Редагувати профіль';
		map['settings.general.menu_title'] = 'Загальні налаштування';
		map['settings.general.menu_descr'] = 'Мова, конфіденційність та інше';
		map['settings.general.language.section'] = 'Мова та тексти';
		map['settings.general.language.title'] = 'Мова додатку';
		map['settings.general.language.descr'] = 'Мова, в якій будуть відображатися тексти в додатку';
		map['settings.general.language.help'] = 'Якщо ви хочете співпрацювати з перекладами цієї програми, ви можете звернутися до <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>нашого посібник</ a>';
		map['settings.general.locale.title'] = 'Регіон';
		map['settings.general.locale.auto'] = 'Система';
		map['settings.general.locale.descr'] = 'Встановіть формат, який буде використовуватися для дат, чисел...';
		map['settings.general.locale.warn'] = 'Після зміни регіону додаток оновиться';
		map['settings.general.locale.first_day_of_week'] = 'Перший день тижня';
		map['settings.security.title'] = 'Безпека';
		map['settings.security.private_mode_at_launch'] = 'Приватний режим під час запуску';
		map['settings.security.private_mode_at_launch_descr'] = 'За замовчуванням запускати програму в приватному режимі';
		map['settings.security.private_mode'] = 'Приватний режим';
		map['settings.security.private_mode_descr'] = 'Приховати всі грошові значення';
		map['settings.security.private_mode_activated'] = 'Приватний режим активовано';
		map['settings.security.private_mode_deactivated'] = 'Приватний режим вимкнено';
		map['settings.transactions.menu_title'] = 'Транзакції';
		map['settings.transactions.menu_descr'] = 'Налаштуйте поведінку ваших транзакцій';
		map['settings.transactions.title'] = 'Налаштування транзакцій';
		map['settings.transactions.swipe_actions.title'] = 'Дії гортання';
		map['settings.transactions.swipe_actions.choose_description'] = 'Виберіть, яка дія буде ініційована, коли ви проводите пальцем по елементу транзакції у списку в цьому напрямку';
		map['settings.transactions.swipe_actions.none'] = 'Ніяких дій';
		map['settings.transactions.swipe_actions.swipe_left'] = 'Проведіть ліворуч';
		map['settings.transactions.swipe_actions.swipe_right'] = 'Проведіть праворуч';
		map['settings.transactions.swipe_actions.toggle_reconciled'] = 'Перемикач узгоджено';
		map['settings.transactions.swipe_actions.toggle_pending'] = 'Перемкнути в очікуванні';
		map['settings.transactions.swipe_actions.toggle_voided'] = 'Перемикач скасовано';
		map['settings.transactions.swipe_actions.toggle_unreconciled'] = 'Перемикач неузгоджений';
		map['settings.transactions.swipe_actions.remove_status'] = 'Видалити статус';
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
		map['settings.appearance.menu_title'] = 'Тема та стиль';
		map['settings.appearance.menu_descr'] = 'Вибір теми, кольори та інші речі, пов\'язані з виглядом програми';
		map['settings.appearance.theme_and_colors'] = 'Тема та кольори';
		map['settings.appearance.theme.title'] = 'Тема';
		map['settings.appearance.theme.auto'] = 'система';
		map['settings.appearance.theme.light'] = 'Світла';
		map['settings.appearance.theme.dark'] = 'Темна';
		map['settings.appearance.amoled_mode'] = 'Режим AMOLED';
		map['settings.appearance.amoled_mode_descr'] = 'Використовуйте чисто чорний шпалери, якщо це можливо. Це трохи допоможе акумулятору пристроїв з екранами AMOLED';
		map['settings.appearance.dynamic_colors'] = 'Динамічні кольори';
		map['settings.appearance.dynamic_colors_descr'] = 'Використовуйте колір акценту вашої системи, коли це можливо';
		map['settings.appearance.accent_color'] = 'Колір акценту';
		map['settings.appearance.accent_color_descr'] = 'Виберіть колір, який додаток буде використовувати для виділення певних частин інтерфейсу';
		map['settings.appearance.text'] = 'Текст';
		map['settings.appearance.font'] = 'Шрифт';
		map['settings.appearance.font_platform'] = 'Платформа';
		map['more.title'] = 'Більше';
		map['more.title_long'] = 'Більше дій';
		map['more.data.display'] = 'Дані';
		map['more.data.display_descr'] = 'Експортуйте та імпортуйте свої дані, щоб нічого не втратити';
		map['more.data.delete_all'] = 'Видалити мої дані';
		map['more.data.delete_all_header1'] = 'Зупиніться, молодий падаване ⚠️⚠️';
		map['more.data.delete_all_message1'] = 'Ви впевнені, що хочете продовжити? Всі ваші дані буде остаточно видалено і не може бути відновлено';
		map['more.data.delete_all_header2'] = 'Останній крок ⚠️⚠️';
		map['more.data.delete_all_message2'] = 'Видаляючи обліковий запис, ви видалите всі ваші збережені особисті дані. Ваші облікові записи, транзакції, бюджети та категорії будуть видалені і не можуть бути відновлені. Ви згодні?';
		map['more.about_us.display'] = 'Інформація про додаток';
		map['more.about_us.description'] = 'Знаходьте умови Monekin, важливу інформацію та зв\'язуйтеся, повідомляючи про помилки або ділячись ідеями';
		map['more.about_us.legal.display'] = 'Юридична інформація';
		map['more.about_us.legal.privacy'] = 'Політика конфіденційності';
		map['more.about_us.legal.terms'] = 'Умови використання';
		map['more.about_us.legal.licenses'] = 'Ліцензії';
		map['more.about_us.project.display'] = 'Проект';
		map['more.about_us.project.contributors'] = 'Співробітники';
		map['more.about_us.project.contributors_descr'] = 'Усі розробники, які зробили Monekin краще';
		map['more.about_us.project.contact'] = 'Зв\'яжіться з нами';
		map['more.help_us.display'] = 'Допоможіть нам';
		map['more.help_us.description'] = 'Дізнайтеся, як ви можете допомогти Monekin ставати кращим і кращим';
		map['more.help_us.rate_us'] = 'Оцініть нас';
		map['more.help_us.rate_us_descr'] = 'Будь-яка оцінка вітається!';
		map['more.help_us.share'] = 'Поділіться Monekin';
		map['more.help_us.share_descr'] = 'Поділіться нашим додатком з друзями та родиною';
		map['more.help_us.share_text'] = 'Monekin! Найкращий додаток для особистих фінансів. Завантажте його тут';
		map['more.help_us.thanks'] = 'Дякуємо!';
		map['more.help_us.thanks_long'] = 'Ваші внески в Monekin та інші відкриті проекти, великі та малі, роблять великі проекти, подібні до цього, можливими. Дякуємо вам за час, витрачений на внесок.';
		map['more.help_us.donate'] = 'Зробіть пожертву';
		map['more.help_us.donate_descr'] = 'З вашою пожертвою ви допоможете додатку продовжувати отримувати вдосконалення. Що може бути краще, ніж подякувати за виконану роботу, запрошуючи мене на каву?';
		map['more.help_us.donate_success'] = 'Пожертва зроблена. Дуже вдячний за ваш внесок! ❤️';
		map['more.help_us.donate_err'] = 'Ой! Здається, виникла помилка при отриманні вашого платежу';
		map['more.help_us.report'] = 'Повідомити про помилки, залишити пропозиції...';

		_map = map;
		return map;
	}
}


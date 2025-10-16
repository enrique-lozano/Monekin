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
  TranslationsUk({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
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

  late final TranslationsUk _root = this; // ignore: unused_field

  @override
  TranslationsUk $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => TranslationsUk(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _TranslationsUiActionsUk ui_actions = _TranslationsUiActionsUk._(
    _root,
  );
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
  late final _TranslationsTransferUk transfer = _TranslationsTransferUk._(
    _root,
  );
  @override
  late final _TranslationsRecurrentTransactionsUk recurrent_transactions =
      _TranslationsRecurrentTransactionsUk._(_root);
  @override
  late final _TranslationsAccountUk account = _TranslationsAccountUk._(_root);
  @override
  late final _TranslationsCurrenciesUk currencies = _TranslationsCurrenciesUk._(
    _root,
  );
  @override
  late final _TranslationsTagsUk tags = _TranslationsTagsUk._(_root);
  @override
  late final _TranslationsCategoriesUk categories = _TranslationsCategoriesUk._(
    _root,
  );
  @override
  late final _TranslationsBudgetsUk budgets = _TranslationsBudgetsUk._(_root);
  @override
  late final _TranslationsBackupUk backup = _TranslationsBackupUk._(_root);
  @override
  late final _TranslationsSettingsUk settings = _TranslationsSettingsUk._(
    _root,
  );
  @override
  late final _TranslationsMoreUk more = _TranslationsMoreUk._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsUk implements TranslationsUiActionsEn {
  _TranslationsUiActionsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'Скасувати';
  @override
  String get confirm => 'Підтвердити';
  @override
  String get continue_text => 'Продовжити';
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
  String get delete => 'Видалити';
  @override
  String get see_more => 'Детальніше';
  @override
  String get select_all => 'Вибрати все';
  @override
  String get deselect_all => 'Скасувати вибір всього';
  @override
  String get select => 'Вибрати';
  @override
  String get search => 'Пошук';
  @override
  String get filter => 'Фільтр';
  @override
  String get reset => 'Скинути';
  @override
  String get submit => 'Надіслати';
  @override
  String get next => 'Далі';
  @override
  String get previous => 'Назад';
  @override
  String get back => 'Повернутися';
  @override
  String get reload => 'Перезавантажити';
  @override
  String get view => 'Переглянути';
  @override
  String get download => 'Завантажити';
  @override
  String get upload => 'Завантажити файл';
  @override
  String get retry => 'Спробувати знову';
  @override
  String get copy => 'Копіювати';
  @override
  String get paste => 'Вставити';
  @override
  String get undo => 'Скасувати дію';
  @override
  String get redo => 'Повторити дію';
  @override
  String get open => 'Відкрити';
  @override
  String get close => 'Закрити';
  @override
  String get apply => 'Застосувати';
  @override
  String get discard => 'Скасувати зміни';
  @override
  String get refresh => 'Оновити';
  @override
  String get details => 'Деталі';
  @override
  String get share => 'Поділитися';
}

// Path: general
class _TranslationsGeneralUk implements TranslationsGeneralEn {
  _TranslationsGeneralUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get or => 'або';
  @override
  String get understood => 'Зрозуміло';
  @override
  String get unspecified => 'Не вказано';
  @override
  String get quick_actions => 'Швидкі дії';
  @override
  String get balance => 'Баланс';
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
  String get empty_warn => 'Ой! Тут порожньо';
  @override
  String get insufficient_data => 'Недостатньо даних';
  @override
  String get show_more_fields => 'Показати більше полів';
  @override
  String get show_less_fields => 'Показати менше полів';
  @override
  String get tap_to_search => 'Натисніть для пошуку';
  @override
  late final _TranslationsGeneralClipboardUk clipboard =
      _TranslationsGeneralClipboardUk._(_root);
  @override
  late final _TranslationsGeneralTimeUk time = _TranslationsGeneralTimeUk._(
    _root,
  );
  @override
  late final _TranslationsGeneralTransactionOrderUk transaction_order =
      _TranslationsGeneralTransactionOrderUk._(_root);
  @override
  late final _TranslationsGeneralValidationsUk validations =
      _TranslationsGeneralValidationsUk._(_root);
}

// Path: intro
class _TranslationsIntroUk implements TranslationsIntroEn {
  _TranslationsIntroUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsHomeUk implements TranslationsHomeEn {
  _TranslationsHomeUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsFinancialHealthUk implements TranslationsFinancialHealthEn {
  _TranslationsFinancialHealthUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get display => 'Фінансове здоров\'я';
  @override
  late final _TranslationsFinancialHealthReviewUk review =
      _TranslationsFinancialHealthReviewUk._(_root);
  @override
  late final _TranslationsFinancialHealthMonthsWithoutIncomeUk
  months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeUk._(
    _root,
  );
  @override
  late final _TranslationsFinancialHealthSavingsPercentageUk
  savings_percentage = _TranslationsFinancialHealthSavingsPercentageUk._(_root);
}

// Path: stats
class _TranslationsStatsUk implements TranslationsStatsEn {
  _TranslationsStatsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  String get balance_by_account_subtitle => 'Де я маю більшість грошей?';
  @override
  String get balance_by_currency => 'Баланс за валютою';
  @override
  String get balance_by_currency_subtitle =>
      'Скільки я маю грошей в іноземній валюті?';
  @override
  String get balance_evolution => 'Тенденція балансу';
  @override
  String get balance_evolution_subtitle => 'У мене більше грошей, ніж раніше?';
  @override
  String get compared_to_previous_period => 'Порівняно з попереднім періодом';
  @override
  String get cash_flow => 'Грошовий потік';
  @override
  String get cash_flow_subtitle => 'Я витрачаю менше, ніж заробляю?';
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
class _TranslationsIconSelectorUk implements TranslationsIconSelectorEn {
  _TranslationsIconSelectorUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Назва:';
  @override
  String get icon => 'Іконка';
  @override
  String get color => 'Колір';
  @override
  String get select_icon => 'Виберіть іконку';
  @override
  String get select_color => 'Виберіть колір';
  @override
  String get custom_color => 'Користувацький колір';
  @override
  String get current_color_selection => 'Поточний вибір';
  @override
  String get select_account_icon => 'Ідентифікуйте ваш рахунок';
  @override
  String get select_category_icon => 'Ідентифікуйте вашу категорію';
  @override
  late final _TranslationsIconSelectorScopesUk scopes =
      _TranslationsIconSelectorScopesUk._(_root);
}

// Path: transaction
class _TranslationsTransactionUk implements TranslationsTransactionEn {
  _TranslationsTransactionUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  late final _TranslationsTransactionReversedUk reversed =
      _TranslationsTransactionReversedUk._(_root);
  @override
  late final _TranslationsTransactionStatusUk status =
      _TranslationsTransactionStatusUk._(_root);
  @override
  late final _TranslationsTransactionTypesUk types =
      _TranslationsTransactionTypesUk._(_root);
}

// Path: transfer
class _TranslationsTransferUk implements TranslationsTransferEn {
  _TranslationsTransferUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  late final _TranslationsTransferFormUk form = _TranslationsTransferFormUk._(
    _root,
  );
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsUk
    implements TranslationsRecurrentTransactionsEn {
  _TranslationsRecurrentTransactionsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  @override
  late final _TranslationsRecurrentTransactionsStatusUk status =
      _TranslationsRecurrentTransactionsStatusUk._(_root);
}

// Path: account
class _TranslationsAccountUk implements TranslationsAccountEn {
  _TranslationsAccountUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  late final _TranslationsAccountTypesUk types = _TranslationsAccountTypesUk._(
    _root,
  );
  @override
  late final _TranslationsAccountFormUk form = _TranslationsAccountFormUk._(
    _root,
  );
  @override
  late final _TranslationsAccountDeleteUk delete =
      _TranslationsAccountDeleteUk._(_root);
  @override
  late final _TranslationsAccountCloseUk close = _TranslationsAccountCloseUk._(
    _root,
  );
  @override
  late final _TranslationsAccountSelectUk select =
      _TranslationsAccountSelectUk._(_root);
}

// Path: currencies
class _TranslationsCurrenciesUk implements TranslationsCurrenciesEn {
  _TranslationsCurrenciesUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  String get search => 'Пошук за назвою або кодом валюти';
}

// Path: tags
class _TranslationsTagsUk implements TranslationsTagsEn {
  _TranslationsTagsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  late final _TranslationsTagsSelectUk select = _TranslationsTagsSelectUk._(
    _root,
  );
  @override
  String get empty_list =>
      'Ви ще не створили жодних тегів. Теги та категорії - це відмінний спосіб категоризувати ваші рухи';
  @override
  String get without_tags => 'Без тегів';
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
class _TranslationsCategoriesUk implements TranslationsCategoriesEn {
  _TranslationsCategoriesUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  String merge_warning1({
    required Object x,
    required Object from,
    required Object destiny,
  }) =>
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
class _TranslationsBudgetsUk implements TranslationsBudgetsEn {
  _TranslationsBudgetsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  late final _TranslationsBudgetsFormUk form = _TranslationsBudgetsFormUk._(
    _root,
  );
  @override
  late final _TranslationsBudgetsDetailsUk details =
      _TranslationsBudgetsDetailsUk._(_root);
}

// Path: backup
class _TranslationsBackupUk implements TranslationsBackupEn {
  _TranslationsBackupUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsBackupExportUk export = _TranslationsBackupExportUk._(
    _root,
  );
  @override
  late final _TranslationsBackupImportUk import = _TranslationsBackupImportUk._(
    _root,
  );
  @override
  late final _TranslationsBackupAboutUk about = _TranslationsBackupAboutUk._(
    _root,
  );
}

// Path: settings
class _TranslationsSettingsUk implements TranslationsSettingsEn {
  _TranslationsSettingsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  String get lang_help =>
      'Якщо ви хочете співпрацювати з перекладами цієї програми, ви можете звернутися до <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>нашого посібник</ a>';
  @override
  String get locale => 'Регіон';
  @override
  String get locale_auto => 'Система';
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
  String get theme_auto => 'система';
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
  @override
  late final _TranslationsSettingsSecurityUk security =
      _TranslationsSettingsSecurityUk._(_root);
}

// Path: more
class _TranslationsMoreUk implements TranslationsMoreEn {
  _TranslationsMoreUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Більше';
  @override
  String get title_long => 'Більше дій';
  @override
  late final _TranslationsMoreDataUk data = _TranslationsMoreDataUk._(_root);
  @override
  late final _TranslationsMoreAboutUsUk about_us = _TranslationsMoreAboutUsUk._(
    _root,
  );
  @override
  late final _TranslationsMoreHelpUsUk help_us = _TranslationsMoreHelpUsUk._(
    _root,
  );
}

// Path: general.clipboard
class _TranslationsGeneralClipboardUk
    implements TranslationsGeneralClipboardEn {
  _TranslationsGeneralClipboardUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String success({required Object x}) => '${x} скопійовано в буфер обміну';
  @override
  String get error => 'Помилка копіювання';
}

// Path: general.time
class _TranslationsGeneralTimeUk implements TranslationsGeneralTimeEn {
  _TranslationsGeneralTimeUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsGeneralTransactionOrderEn {
  _TranslationsGeneralTransactionOrderUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsGeneralValidationsEn {
  _TranslationsGeneralValidationsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get form_error => 'Виправте поля, зазначені у формі, щоб продовжити';
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
    implements TranslationsFinancialHealthReviewEn {
  _TranslationsFinancialHealthReviewUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
  _TranslationsFinancialHealthMonthsWithoutIncomeUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsFinancialHealthSavingsPercentageEn {
  _TranslationsFinancialHealthSavingsPercentageUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsIconSelectorScopesEn {
  _TranslationsIconSelectorScopesUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsTransactionNextPaymentsEn {
  _TranslationsTransactionNextPaymentsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransactionListUk implements TranslationsTransactionListEn {
  _TranslationsTransactionListUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get empty =>
      'Тут не знайдено жодних транзакцій для відображення. Додайте кілька транзакцій у додаток, і, можливо, наступного разу вам пощастить більше';
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
    implements TranslationsTransactionFiltersEn {
  _TranslationsTransactionFiltersUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransactionFormUk implements TranslationsTransactionFormEn {
  _TranslationsTransactionFormUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  late final _TranslationsTransactionFormValidatorsUk validators =
      _TranslationsTransactionFormValidatorsUk._(_root);
  @override
  String get title => 'Назва транзакції';
  @override
  String get title_short => 'Назва';
  @override
  String get value => 'Сума транзакції';
  @override
  String get tap_to_see_more => 'Натисніть, щоб побачити більше деталей';
  @override
  String get no_tags => '-- Немає тегів --';
  @override
  String get description => 'Опис';
  @override
  String get description_info =>
      'Натисніть тут, щоб ввести детальніший опис цієї транзакції';
  @override
  String exchange_to_preferred_title({required Object currency}) =>
      'Обмінний курс на ${currency}';
  @override
  String get exchange_to_preferred_in_date => 'На дату транзакції';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedUk
    implements TranslationsTransactionReversedEn {
  _TranslationsTransactionReversedUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Скасована транзакція';
  @override
  String get title_short => 'Перевернутий тр.';
  @override
  String get description_for_expenses =>
      'Незважаючи на те, що транзакція типу витрат, ця транзакція має додатну суму. Ці типи транзакцій можна використовувати для представлення повернення раніше зареєстрованих витрат, таких як відшкодування або оплата борг.';
  @override
  String get description_for_incomes =>
      'Незважаючи на те, що транзакція є дохідною, ця транзакція має від’ємну суму. Ці типи транзакцій можна використовувати ля анулювання або виправлення неправильно зареєстрованого доходу, для відображення повернення або відшкодування грошей або для обліку сплати боргів».';
}

// Path: transaction.status
class _TranslationsTransactionStatusUk
    implements TranslationsTransactionStatusEn {
  _TranslationsTransactionStatusUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String display({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
        n,
        one: 'Статус',
        other: 'Статуси',
      );
  @override
  String get display_long => 'Статус транзакції';
  @override
  String tr_status({required Object status}) => '${status} транзакція';
  @override
  String get none => 'Без статусу';
  @override
  String get none_descr => 'Транзакція без певного стану';
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
    implements TranslationsTransactionTypesEn {
  _TranslationsTransactionTypesUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTransferFormUk implements TranslationsTransferFormEn {
  _TranslationsTransferFormUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get from => 'Початковий рахунок';
  @override
  String get to => 'Цільовий рахунок';
  @override
  late final _TranslationsTransferFormValueInDestinyUk value_in_destiny =
      _TranslationsTransferFormValueInDestinyUk._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsUk
    implements TranslationsRecurrentTransactionsDetailsEn {
  _TranslationsRecurrentTransactionsDetailsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusUk
    implements TranslationsRecurrentTransactionsStatusEn {
  _TranslationsRecurrentTransactionsStatusUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String delayed_by({required Object x}) => 'Затримано на ${x}d';
  @override
  String coming_in({required Object x}) => 'Через ${x} днів';
}

// Path: account.types
class _TranslationsAccountTypesUk implements TranslationsAccountTypesEn {
  _TranslationsAccountTypesUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsAccountFormUk implements TranslationsAccountFormEn {
  _TranslationsAccountFormUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsAccountDeleteUk implements TranslationsAccountDeleteEn {
  _TranslationsAccountDeleteUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsAccountCloseUk implements TranslationsAccountCloseEn {
  _TranslationsAccountCloseUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsAccountSelectUk implements TranslationsAccountSelectEn {
  _TranslationsAccountSelectUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get one => 'Виберіть рахунок';
  @override
  String get all => 'Всі рахунки';
  @override
  String get multiple => 'Вибрати рахунки';
}

// Path: currencies.form
class _TranslationsCurrenciesFormUk implements TranslationsCurrenciesFormEn {
  _TranslationsCurrenciesFormUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsTagsFormUk implements TranslationsTagsFormEn {
  _TranslationsTagsFormUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Назва тегу';
  @override
  String get description => 'Опис';
}

// Path: tags.select
class _TranslationsTagsSelectUk implements TranslationsTagsSelectEn {
  _TranslationsTagsSelectUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Вибрати теги';
  @override
  String get all => 'Усі теги';
}

// Path: categories.select
class _TranslationsCategoriesSelectUk
    implements TranslationsCategoriesSelectEn {
  _TranslationsCategoriesSelectUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsBudgetsFormUk implements TranslationsBudgetsFormEn {
  _TranslationsBudgetsFormUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsBudgetsDetailsUk implements TranslationsBudgetsDetailsEn {
  _TranslationsBudgetsDetailsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Деталі бюджету';
  @override
  String get statistics => 'Статистика';
  @override
  String get budget_value => 'Заплановано';
  @override
  String expend_diary_left({
    required Object dailyAmount,
    required Object remainingDays,
  }) => 'Ви можете витрачати ${dailyAmount} на день ще ${remainingDays} днів';
  @override
  String get expend_evolution => 'Еволюція витрат';
  @override
  String get no_transactions =>
      'Здається, ви не здійснили жодних витрат, пов\'язаних з цим бюджетом';
}

// Path: backup.export
class _TranslationsBackupExportUk implements TranslationsBackupExportEn {
  _TranslationsBackupExportUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsBackupImportUk implements TranslationsBackupImportEn {
  _TranslationsBackupImportUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsBackupAboutUk implements TranslationsBackupAboutEn {
  _TranslationsBackupAboutUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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

// Path: settings.security
class _TranslationsSettingsSecurityUk
    implements TranslationsSettingsSecurityEn {
  _TranslationsSettingsSecurityUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Безпека';
  @override
  String get private_mode_at_launch => 'Приватний режим під час запуску';
  @override
  String get private_mode_at_launch_descr =>
      'За замовчуванням запускати програму в приватному режимі';
  @override
  String get private_mode => 'Приватний режим';
  @override
  String get private_mode_descr => 'Приховати всі грошові значення';
  @override
  String get private_mode_activated => 'Приватний режим активовано';
  @override
  String get private_mode_deactivated => 'Приватний режим вимкнено';
}

// Path: more.data
class _TranslationsMoreDataUk implements TranslationsMoreDataEn {
  _TranslationsMoreDataUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsMoreAboutUsUk implements TranslationsMoreAboutUsEn {
  _TranslationsMoreAboutUsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsMoreHelpUsUk implements TranslationsMoreHelpUsEn {
  _TranslationsMoreHelpUsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsGeneralTimeRangesEn {
  _TranslationsGeneralTimeRangesUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  String each_range_until_date({
    required num n,
    required Object range,
    required Object day,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
    n,
    one: 'Кожного ${range} до ${day}',
    other: 'Кожних ${n} ${range} до ${day}',
  );
  @override
  String each_range_until_times({
    required num n,
    required Object range,
    required Object limit,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
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
    implements TranslationsGeneralTimePeriodicityEn {
  _TranslationsGeneralTimePeriodicityUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsGeneralTimeCurrentEn {
  _TranslationsGeneralTimeCurrentUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
class _TranslationsGeneralTimeAllUk implements TranslationsGeneralTimeAllEn {
  _TranslationsGeneralTimeAllUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsFinancialHealthReviewDescrEn {
  _TranslationsFinancialHealthReviewDescrUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsFinancialHealthSavingsPercentageTextEn {
  _TranslationsFinancialHealthSavingsPercentageTextUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsTransactionListBulkEditEn {
  _TranslationsTransactionListBulkEditUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get dates => 'Редагувати дати';
  @override
  String get categories => 'Редагувати категорії';
  @override
  String get status => 'Редагувати статуси';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsUk
    implements TranslationsTransactionFormValidatorsEn {
  _TranslationsTransactionFormValidatorsUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
  String get negative_transfer =>
      'Монетарна вартість переказу не може бути від\'ємною';
  @override
  String get transfer_between_same_accounts =>
      'Облікові записи джерела та призначення не збігаються';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyUk
    implements TranslationsTransferFormValueInDestinyEn {
  _TranslationsTransferFormValueInDestinyUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Сума переказу в пункті призначення';
  @override
  String amount_short({required Object amount}) =>
      '${amount} на цільовий рахунок';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportUk
    implements TranslationsBackupImportManualImportEn {
  _TranslationsBackupImportManualImportUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsMoreAboutUsLegalEn {
  _TranslationsMoreAboutUsLegalUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsMoreAboutUsProjectEn {
  _TranslationsMoreAboutUsProjectUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
    implements TranslationsGeneralTimeRangesTypesEn {
  _TranslationsGeneralTimeRangesTypesUk._(this._root);

  final TranslationsUk _root; // ignore: unused_field

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
extension on TranslationsUk {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'ui_actions.cancel':
        return 'Скасувати';
      case 'ui_actions.confirm':
        return 'Підтвердити';
      case 'ui_actions.continue_text':
        return 'Продовжити';
      case 'ui_actions.save':
        return 'Зберегти';
      case 'ui_actions.save_changes':
        return 'Зберегти зміни';
      case 'ui_actions.close_and_save':
        return 'Закрити та зберегти';
      case 'ui_actions.add':
        return 'Додати';
      case 'ui_actions.edit':
        return 'Редагувати';
      case 'ui_actions.delete':
        return 'Видалити';
      case 'ui_actions.see_more':
        return 'Детальніше';
      case 'ui_actions.select_all':
        return 'Вибрати все';
      case 'ui_actions.deselect_all':
        return 'Скасувати вибір всього';
      case 'ui_actions.select':
        return 'Вибрати';
      case 'ui_actions.search':
        return 'Пошук';
      case 'ui_actions.filter':
        return 'Фільтр';
      case 'ui_actions.reset':
        return 'Скинути';
      case 'ui_actions.submit':
        return 'Надіслати';
      case 'ui_actions.next':
        return 'Далі';
      case 'ui_actions.previous':
        return 'Назад';
      case 'ui_actions.back':
        return 'Повернутися';
      case 'ui_actions.reload':
        return 'Перезавантажити';
      case 'ui_actions.view':
        return 'Переглянути';
      case 'ui_actions.download':
        return 'Завантажити';
      case 'ui_actions.upload':
        return 'Завантажити файл';
      case 'ui_actions.retry':
        return 'Спробувати знову';
      case 'ui_actions.copy':
        return 'Копіювати';
      case 'ui_actions.paste':
        return 'Вставити';
      case 'ui_actions.undo':
        return 'Скасувати дію';
      case 'ui_actions.redo':
        return 'Повторити дію';
      case 'ui_actions.open':
        return 'Відкрити';
      case 'ui_actions.close':
        return 'Закрити';
      case 'ui_actions.apply':
        return 'Застосувати';
      case 'ui_actions.discard':
        return 'Скасувати зміни';
      case 'ui_actions.refresh':
        return 'Оновити';
      case 'ui_actions.details':
        return 'Деталі';
      case 'ui_actions.share':
        return 'Поділитися';
      case 'general.or':
        return 'або';
      case 'general.understood':
        return 'Зрозуміло';
      case 'general.unspecified':
        return 'Не вказано';
      case 'general.quick_actions':
        return 'Швидкі дії';
      case 'general.balance':
        return 'Баланс';
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
      case 'general.empty_warn':
        return 'Ой! Тут порожньо';
      case 'general.insufficient_data':
        return 'Недостатньо даних';
      case 'general.show_more_fields':
        return 'Показати більше полів';
      case 'general.show_less_fields':
        return 'Показати менше полів';
      case 'general.tap_to_search':
        return 'Натисніть для пошуку';
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
        return ({
          required num n,
          required Object range,
          required Object limit,
        }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
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
      case 'general.validations.form_error':
        return 'Виправте поля, зазначені у формі, щоб продовжити';
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
      case 'stats.balance_by_account_subtitle':
        return 'Де я маю більшість грошей?';
      case 'stats.balance_by_currency':
        return 'Баланс за валютою';
      case 'stats.balance_by_currency_subtitle':
        return 'Скільки я маю грошей в іноземній валюті?';
      case 'stats.balance_evolution':
        return 'Тенденція балансу';
      case 'stats.balance_evolution_subtitle':
        return 'У мене більше грошей, ніж раніше?';
      case 'stats.compared_to_previous_period':
        return 'Порівняно з попереднім періодом';
      case 'stats.cash_flow':
        return 'Грошовий потік';
      case 'stats.cash_flow_subtitle':
        return 'Я витрачаю менше, ніж заробляю?';
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
      case 'icon_selector.select_icon':
        return 'Виберіть іконку';
      case 'icon_selector.select_color':
        return 'Виберіть колір';
      case 'icon_selector.custom_color':
        return 'Користувацький колір';
      case 'icon_selector.current_color_selection':
        return 'Поточний вибір';
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
        return 'Тут не знайдено жодних транзакцій для відображення. Додайте кілька транзакцій у додаток, і, можливо, наступного разу вам пощастить більше';
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
      case 'transaction.list.bulk_edit.status':
        return 'Редагувати статуси';
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
      case 'transaction.form.validators.negative_transfer':
        return 'Монетарна вартість переказу не може бути від\'ємною';
      case 'transaction.form.validators.transfer_between_same_accounts':
        return 'Облікові записи джерела та призначення не збігаються';
      case 'transaction.form.title':
        return 'Назва транзакції';
      case 'transaction.form.title_short':
        return 'Назва';
      case 'transaction.form.value':
        return 'Сума транзакції';
      case 'transaction.form.tap_to_see_more':
        return 'Натисніть, щоб побачити більше деталей';
      case 'transaction.form.no_tags':
        return '-- Немає тегів --';
      case 'transaction.form.description':
        return 'Опис';
      case 'transaction.form.description_info':
        return 'Натисніть тут, щоб ввести детальніший опис цієї транзакції';
      case 'transaction.form.exchange_to_preferred_title':
        return ({required Object currency}) => 'Обмінний курс на ${currency}';
      case 'transaction.form.exchange_to_preferred_in_date':
        return 'На дату транзакції';
      case 'transaction.reversed.title':
        return 'Скасована транзакція';
      case 'transaction.reversed.title_short':
        return 'Перевернутий тр.';
      case 'transaction.reversed.description_for_expenses':
        return 'Незважаючи на те, що транзакція типу витрат, ця транзакція має додатну суму. Ці типи транзакцій можна використовувати для представлення повернення раніше зареєстрованих витрат, таких як відшкодування або оплата борг.';
      case 'transaction.reversed.description_for_incomes':
        return 'Незважаючи на те, що транзакція є дохідною, ця транзакція має від’ємну суму. Ці типи транзакцій можна використовувати ля анулювання або виправлення неправильно зареєстрованого доходу, для відображення повернення або відшкодування грошей або для обліку сплати боргів».';
      case 'transaction.status.display':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uk'))(
              n,
              one: 'Статус',
              other: 'Статуси',
            );
      case 'transaction.status.display_long':
        return 'Статус транзакції';
      case 'transaction.status.tr_status':
        return ({required Object status}) => '${status} транзакція';
      case 'transaction.status.none':
        return 'Без статусу';
      case 'transaction.status.none_descr':
        return 'Транзакція без певного стану';
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
      case 'transfer.form.value_in_destiny.title':
        return 'Сума переказу в пункті призначення';
      case 'transfer.form.value_in_destiny.amount_short':
        return ({required Object amount}) => '${amount} на цільовий рахунок';
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
      case 'recurrent_transactions.status.delayed_by':
        return ({required Object x}) => 'Затримано на ${x}d';
      case 'recurrent_transactions.status.coming_in':
        return ({required Object x}) => 'Через ${x} днів';
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
      case 'currencies.search':
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
      case 'tags.select.title':
        return 'Вибрати теги';
      case 'tags.select.all':
        return 'Усі теги';
      case 'tags.empty_list':
        return 'Ви ще не створили жодних тегів. Теги та категорії - це відмінний спосіб категоризувати ваші рухи';
      case 'tags.without_tags':
        return 'Без тегів';
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
        return ({
          required Object x,
          required Object from,
          required Object destiny,
        }) =>
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
      case 'settings.lang_help':
        return 'Якщо ви хочете співпрацювати з перекладами цієї програми, ви можете звернутися до <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>нашого посібник</ a>';
      case 'settings.locale':
        return 'Регіон';
      case 'settings.locale_auto':
        return 'Система';
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
        return 'система';
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
      case 'settings.security.title':
        return 'Безпека';
      case 'settings.security.private_mode_at_launch':
        return 'Приватний режим під час запуску';
      case 'settings.security.private_mode_at_launch_descr':
        return 'За замовчуванням запускати програму в приватному режимі';
      case 'settings.security.private_mode':
        return 'Приватний режим';
      case 'settings.security.private_mode_descr':
        return 'Приховати всі грошові значення';
      case 'settings.security.private_mode_activated':
        return 'Приватний режим активовано';
      case 'settings.security.private_mode_deactivated':
        return 'Приватний режим вимкнено';
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

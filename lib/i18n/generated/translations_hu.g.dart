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
class TranslationsHu implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsHu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	late final TranslationsHu _root = this; // ignore: unused_field

	@override 
	TranslationsHu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsHu(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsHu ui_actions = _TranslationsUiActionsHu._(_root);
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
	@override late final _TranslationsGoalsHu goals = _TranslationsGoalsHu._(_root);
	@override late final _TranslationsTargetTimelineStatusesHu target_timeline_statuses = _TranslationsTargetTimelineStatusesHu._(_root);
	@override late final _TranslationsBackupHu backup = _TranslationsBackupHu._(_root);
	@override late final _TranslationsSettingsHu settings = _TranslationsSettingsHu._(_root);
	@override late final _TranslationsMoreHu more = _TranslationsMoreHu._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsHu implements TranslationsUiActionsEn {
	_TranslationsUiActionsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Mégse';
	@override String get confirm => 'Megerősítés';
	@override String get continue_text => 'Folytatás';
	@override String get save => 'Mentés';
	@override String get save_changes => 'Módosítások mentése';
	@override String get close_and_save => 'Mentés és bezárás';
	@override String get add => 'Hozzáad';
	@override String get edit => 'Szerkesztés';
	@override String get delete => 'Törlés';
	@override String get see_more => 'Továbbiak megtekintése';
	@override String get select_all => 'Összes kijelölése';
	@override String get deselect_all => 'Összes kijelölésének megszüntetése';
	@override String get select => 'Kiválasztás';
	@override String get search => 'Keresés';
	@override String get filter => 'Szűrés';
	@override String get reset => 'Alaphelyzetbe állítás';
	@override String get submit => 'Beküldés';
	@override String get next => 'Következő';
	@override String get previous => 'Előző';
	@override String get back => 'Vissza';
	@override String get reload => 'Újratöltés';
	@override String get view => 'Megtekintés';
	@override String get download => 'Letöltés';
	@override String get upload => 'Feltöltés';
	@override String get retry => 'Újrapróbálkozás';
	@override String get copy => 'Másolás';
	@override String get paste => 'Beillesztés';
	@override String get undo => 'Visszavonás';
	@override String get redo => 'Újra';
	@override String get open => 'Megnyitás';
	@override String get close => 'Bezárás';
	@override String get apply => 'Alkalmaz';
	@override String get discard => 'Elvetés';
	@override String get refresh => 'Frissítés';
	@override String get share => 'Megosztás';
}

// Path: general
class _TranslationsGeneralHu implements TranslationsGeneralEn {
	_TranslationsGeneralHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get or => 'vagy';
	@override String get understood => 'Megértve';
	@override String get unspecified => 'Meghatározatlan';
	@override String get quick_actions => 'Gyorsműveletek';
	@override String get details => 'Részletek';
	@override String get balance => 'Egyenleg';
	@override String get account => 'Számla';
	@override String get accounts => 'Számlák';
	@override String get categories => 'Kategóriák';
	@override String get category => 'Kategória';
	@override String get today => 'Ma';
	@override String get yesterday => 'Tegnap';
	@override String get filters => 'Szűrők';
	@override String get empty_warn => 'Hoppá! Ez nagyon üres.';
	@override String get search_no_results => 'Egyetlen elem sem felel meg a keresési feltételeknek';
	@override String get insufficient_data => 'Hiányos adatok';
	@override String get show_more_fields => 'Több mező mutatása';
	@override String get show_less_fields => 'Kevesebb mező mutatása';
	@override String get tap_to_search => 'Koppintson a kereséshez';
	@override String get delete_success => 'Az elem sikeresen törölve';
	@override late final _TranslationsGeneralLeaveWithoutSavingHu leave_without_saving = _TranslationsGeneralLeaveWithoutSavingHu._(_root);
	@override late final _TranslationsGeneralClipboardHu clipboard = _TranslationsGeneralClipboardHu._(_root);
	@override late final _TranslationsGeneralTimeHu time = _TranslationsGeneralTimeHu._(_root);
	@override late final _TranslationsGeneralTransactionOrderHu transaction_order = _TranslationsGeneralTransactionOrderHu._(_root);
	@override late final _TranslationsGeneralValidationsHu validations = _TranslationsGeneralValidationsHu._(_root);
}

// Path: intro
class _TranslationsIntroHu implements TranslationsIntroEn {
	_TranslationsIntroHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsHomeHu implements TranslationsHomeEn {
	_TranslationsHomeHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsFinancialHealthHu implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Pénzügyi állapot';
	@override late final _TranslationsFinancialHealthReviewHu review = _TranslationsFinancialHealthReviewHu._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeHu months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeHu._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageHu savings_percentage = _TranslationsFinancialHealthSavingsPercentageHu._(_root);
}

// Path: stats
class _TranslationsStatsHu implements TranslationsStatsEn {
	_TranslationsStatsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsIconSelectorHu implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsTransactionHu implements TranslationsTransactionEn {
	_TranslationsTransactionHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsTransferHu implements TranslationsTransferEn {
	_TranslationsTransferHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsRecurrentTransactionsHu implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsAccountHu implements TranslationsAccountEn {
	_TranslationsAccountHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsCurrenciesHu implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Valutaváltó';
	@override String get currency => 'Pénznem';
	@override String get currency_settings => 'Pénznem beállítások';
	@override String get currency_manager => 'Valutakezelő';
	@override String get currency_manager_descr => 'Konfigurálja a pénznemet és annak árfolyamait másokkal együtt';
	@override String get preferred_currency => 'Kedvelt/alap pénznem';
	@override String get tap_to_change_preferred_currency => 'Érintse meg a módosításhoz';
	@override String get change_preferred_currency_title => 'Kedvelt pénznem módosítása';
	@override String get change_preferred_currency_msg => 'Mostantól minden statisztika és költségvetés ebben a pénznemben jelenik meg. A számlák és tranzakciók megtartják a korábbi pénznemet. Minden elmentett árfolyam törlődik, ha ezt a műveletet végrehajtja. Szeretné folytatni?';
	@override late final _TranslationsCurrenciesExchangeRateFormHu exchange_rate_form = _TranslationsCurrenciesExchangeRateFormHu._(_root);
	@override late final _TranslationsCurrenciesTypesHu types = _TranslationsCurrenciesTypesHu._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormHu currency_form = _TranslationsCurrenciesCurrencyFormHu._(_root);
	@override String get delete_all_success => 'Az árfolyamok sikeresen törlésre kerültek';
	@override String get historical => 'Árfolyamtörténetek';
	@override String get historical_empty => 'Ehhez a pénznemhez nem található történelmi átváltási árfolyam';
	@override String get exchange_rate => 'Árfolyam';
	@override String get exchange_rates => 'Árfolyamok';
	@override String get min_exchange_rate => 'Minimális árfolyam';
	@override String get max_exchange_rate => 'Maximális árfolyam';
	@override String get empty => 'Adja hozzá az árfolyamokat, hogy ha az alapvalutától eltérő valutában vezetett számlái vannak, és így a grafikonok pontosabbak legyenek.';
	@override String get select_a_currency => 'Válasszon ki egy pénznemet';
	@override String get search => 'Keresés név vagy pénznemkód alapján';
}

// Path: tags
class _TranslationsTagsHu implements TranslationsTagsEn {
	_TranslationsTagsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsCategoriesHu implements TranslationsCategoriesEn {
	_TranslationsCategoriesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsBudgetsHu implements TranslationsBudgetsEn {
	_TranslationsBudgetsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Költségvetések';
	@override String get status => 'Költségkeret állapota';
	@override String get repeated => 'Ismétlődő';
	@override String get one_time => 'Egyszer';
	@override String get actives => 'Aktívok';
	@override String get from_budgeted => 'maradt ';
	@override String get days_left => 'nap van hátra';
	@override String get days_to_start => 'nap van a kezdésig';
	@override String get since_expiration => 'napja lejárt';
	@override String get no_budgets => 'Úgy tűnik, hogy ebben a szakaszban nincs megjelenítendő költségvetés. Kezdje a költségvetés létrehozásával az alábbi gombra kattintva.';
	@override String get delete => 'Költségvetés törlése';
	@override String get delete_warning => 'Ez a művelet visszafordíthatatlan. Az erre az ajánlatra hivatkozó kategóriák és tranzakciók nem törlődnek.';
	@override late final _TranslationsBudgetsFormHu form = _TranslationsBudgetsFormHu._(_root);
	@override late final _TranslationsBudgetsDetailsHu details = _TranslationsBudgetsDetailsHu._(_root);
	@override late final _TranslationsBudgetsTargetTimelineStatusesHu target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesHu._(_root);
	@override late final _TranslationsBudgetsProgressHu progress = _TranslationsBudgetsProgressHu._(_root);
}

// Path: goals
class _TranslationsGoalsHu implements TranslationsGoalsEn {
	_TranslationsGoalsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Célok';
	@override String get status => 'A cél állapota';
	@override late final _TranslationsGoalsTypeHu type = _TranslationsGoalsTypeHu._(_root);
	@override String get empty_title => 'Nincsenek célok';
	@override String get empty_description => 'Hozzon létre új célt megtakarításai követéséhez!';
	@override String get delete => 'Cél törlése';
	@override String get delete_warning => 'Ez a művelet visszafordíthatatlan. A célhoz kapcsolódó kategóriák és tranzakciók nem törlődnek';
	@override late final _TranslationsGoalsFormHu form = _TranslationsGoalsFormHu._(_root);
	@override late final _TranslationsGoalsDetailsHu details = _TranslationsGoalsDetailsHu._(_root);
	@override late final _TranslationsGoalsTargetTimelineStatusesHu target_timeline_statuses = _TranslationsGoalsTargetTimelineStatusesHu._(_root);
	@override late final _TranslationsGoalsProgressHu progress = _TranslationsGoalsProgressHu._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesHu implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktív';
	@override String get past => 'Befejezve';
	@override String get future => 'Jövő';
}

// Path: backup
class _TranslationsBackupHu implements TranslationsBackupEn {
	_TranslationsBackupHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => 'Nincs kiválasztva fájl';
	@override String get no_directory_selected => 'Nincs kiválasztott könyvtár';
	@override late final _TranslationsBackupExportHu export = _TranslationsBackupExportHu._(_root);
	@override late final _TranslationsBackupImportHu import = _TranslationsBackupImportHu._(_root);
	@override late final _TranslationsBackupAboutHu about = _TranslationsBackupAboutHu._(_root);
}

// Path: settings
class _TranslationsSettingsHu implements TranslationsSettingsEn {
	_TranslationsSettingsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Beállítások és Testreszabás';
	@override String get title_short => 'Beállítások';
	@override String get description => 'Téma, Nyelv, Adatok és egyebek';
	@override String get edit_profile => 'Profil szerkesztése';
	@override late final _TranslationsSettingsGeneralHu general = _TranslationsSettingsGeneralHu._(_root);
	@override late final _TranslationsSettingsSecurityHu security = _TranslationsSettingsSecurityHu._(_root);
	@override late final _TranslationsSettingsTransactionsHu transactions = _TranslationsSettingsTransactionsHu._(_root);
	@override late final _TranslationsSettingsAppearanceHu appearance = _TranslationsSettingsAppearanceHu._(_root);
}

// Path: more
class _TranslationsMoreHu implements TranslationsMoreEn {
	_TranslationsMoreHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Továbbiak';
	@override String get title_long => 'További műveletek';
	@override late final _TranslationsMoreDataHu data = _TranslationsMoreDataHu._(_root);
	@override late final _TranslationsMoreAboutUsHu about_us = _TranslationsMoreAboutUsHu._(_root);
	@override late final _TranslationsMoreHelpUsHu help_us = _TranslationsMoreHelpUsHu._(_root);
}

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingHu implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mentés nélkül távozik?';
	@override String get message => 'Vannak nem mentett módosításai. Biztos, hogy mentés nélkül kilép?';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardHu implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} a vágólapra másolva';
	@override String get error => 'Másolási hiba';
}

// Path: general.time
class _TranslationsGeneralTimeHu implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsGeneralTransactionOrderHu implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Tranzakciók rendezése';
	@override String get category => 'Kategóriánként';
	@override String get quantity => 'Mennyiség szerint';
	@override String get date => 'Dátum szerint';
}

// Path: general.validations
class _TranslationsGeneralValidationsHu implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'A folytatáshoz javítsa ki a megadott mezőket';
	@override String get required => 'Kötelező mező';
	@override String get positive => 'Pozitívnak kell lennie';
	@override String min_number({required Object x}) => 'Nagyobbnak kell lennie, mint ${x}';
	@override String max_number({required Object x}) => 'Kevesebbnek kell lennie, mint ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewHu implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsFinancialHealthMonthsWithoutIncomeHu implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsFinancialHealthSavingsPercentageHu implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Megtakarítási százalék';
	@override String get subtitle => 'A jövedelmének mekkora részét nem költi el ebben az időszakban';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextHu text = _TranslationsFinancialHealthSavingsPercentageTextHu._(_root);
	@override String get suggestion => 'Ne feledje, hogy a jövedelmének legalább 15-20%-át célszerű megtakarítani.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesHu implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsTransactionNextPaymentsHu implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsTransactionListHu implements TranslationsTransactionListEn {
	_TranslationsTransactionListHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get all => 'Minden tranzakció';
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
class _TranslationsTransactionFiltersHu implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tranzakciós szűrők';
	@override String get from_value => 'Ebből az összegből';
	@override String get to_value => 'Eddig az összegig';
	@override String from_value_def({required Object x}) => 'Innen: ${x}';
	@override String to_value_def({required Object x}) => 'Ide: ${x}';
	@override String from_date_def({required Object date}) => 'Ettől: ${date}';
	@override String to_date_def({required Object date}) => 'Eddig: ${date}';
	@override String get reset => 'Szűrők visszaállítása';
	@override late final _TranslationsTransactionFiltersSavedHu saved = _TranslationsTransactionFiltersSavedHu._(_root);
}

// Path: transaction.form
class _TranslationsTransactionFormHu implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsTransactionReversedHu implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Megfordított tranzakció';
	@override String get title_short => 'Megfordított';
	@override String get description_for_expenses => 'Annak ellenére, hogy költségtranzakció, pozitív összegű. Az ilyen típusú tranzakciókat egy korábban elszámolt kiadás visszatérülésének, például visszatérítésnek vagy egy tartozás kifizetésének megjelenítésére lehet használni.';
	@override String get description_for_incomes => 'Annak ellenére, hogy bevételi tranzakció, negatív összegű. Az ilyen típusú tranzakciók felhasználhatók a helytelenül elszámolt bevétel érvénytelenítésére vagy helyesbítésére, pénzvisszatérítés vagy pénzvisszatérítés tükrözésére, illetve tartozások kifizetésének rögzítésére.';
}

// Path: transaction.status
class _TranslationsTransactionStatusHu implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsTransactionTypesHu implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsTransferFormHu implements TranslationsTransferFormEn {
	_TranslationsTransferFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get from => 'Eredeti számla';
	@override String get to => 'Célszámla';
	@override late final _TranslationsTransferFormValueInDestinyHu value_in_destiny = _TranslationsTransferFormValueInDestinyHu._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsHu implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ismétlődő tranzakció';
	@override String get descr => 'A tranzakció következő lépései az alábbiakban láthatók. Elfogadhatja az első lépést, vagy kihagyhatja ezt a lépést.';
	@override String get last_payment_info => 'Ez a mozgatás az utolsó az ismétlődő szabályban, így ez a szabály automatikusan törlődik a művelet megerősítésekor.';
	@override String get delete_header => 'Ismétlődő tranzakció törlése';
	@override String get delete_message => 'Ez a művelet visszafordíthatatlan, és nem érinti a már visszaigazolt/befizetett tranzakciókat.';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusHu implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Késés: ${x}d';
	@override String coming_in({required Object x}) => '${x} napon belül';
}

// Path: account.types
class _TranslationsAccountTypesHu implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Számlatípus';
	@override String get warning => 'A számlatípus kiválasztása után az a jövőben nem változtatható meg.';
	@override String get normal => 'Normál számla';
	@override String get normal_descr => 'Hasznos a napi pénzügyek rögzítéséhez. Ez a leggyakoribb számla, amely lehetővé teszi kiadások, bevételek hozzáadását...';
	@override String get saving => 'Megtakarítási számla';
	@override String get saving_descr => 'Csak más számlákról tud pénzt hozzáadni és kivenni belőle. Tökéletes a megtakarítás megkezdéséhez.';
}

// Path: account.form
class _TranslationsAccountFormHu implements TranslationsAccountFormEn {
	_TranslationsAccountFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsAccountDeleteHu implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Törli a számlát?';
	@override String get warning_text => 'Ez a művelet törli ezt a számlát és annak az összes tranzakcióját.';
	@override String get success => 'A számla sikeresen törlésre került';
}

// Path: account.close
class _TranslationsAccountCloseHu implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsAccountSelectHu implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get one => 'Egy számla kiválasztása';
	@override String get all => 'Összes számla';
	@override String get multiple => 'Számlák kiválasztása';
}

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormHu implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'A pénznem nem lehet azonos a felhasználói pénznemmel';
	@override String get override_existing_warn => 'Ebben a dátumban már létezik árfolyam ehhez a pénznemhez. Ha folytatja, az előző felülírásra kerül';
	@override String get specify_a_currency => 'Kérjük, adjon meg egy pénznemet';
	@override String get add => 'Árfolyam hozzáadása';
	@override String get add_success => 'Az árfolyam sikeresen hozzáadva';
	@override String get edit => 'Árfolyam szerkesztése';
	@override String get edit_success => 'Az árfolyam szerkesztése sikerült';
	@override String get remove_all => 'Törölje az összes árfolyamot';
	@override String get remove_all_warning => 'Ez a művelet visszafordíthatatlan, és törli az összes átváltási árfolyamot ehhez a pénznemhez';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesHu implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Pénznem típusa';
	@override String get fiat => 'FIAT';
	@override String get crypto => 'Kriptovaluta';
	@override String get other => 'Más';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormHu implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Megjelenítési név';
	@override String get code => 'Pénznem kódja';
	@override String get symbol => 'Szimbólum';
	@override String get decimal_digits => 'Tizedesjegyek';
	@override String get create => 'Pénznem létrehozása';
	@override String get create_success => 'A pénznem sikeresen létrehozva';
	@override String get edit => 'Pénznem szerkesztése';
	@override String get edit_success => 'A pénznem sikeresen szerkesztve';
	@override String get delete => 'Pénznem törlése';
	@override String get delete_success => 'A pénznem sikeresen törölve';
	@override String get already_exists => 'Már létezik ilyen kóddal rendelkező pénznem. Érdemes lehet szerkeszteni';
}

// Path: tags.form
class _TranslationsTagsFormHu implements TranslationsTagsFormEn {
	_TranslationsTagsFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Címke neve';
	@override String get description => 'Leírás';
}

// Path: tags.select
class _TranslationsTagsSelectHu implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Címke kiválasztása';
	@override String get all => 'Minden címke';
}

// Path: categories.select
class _TranslationsCategoriesSelectHu implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kategóriák kiválasztása';
	@override String get select_one => 'Kategória kiválasztása';
	@override String get select_subcategory => 'Alkategória kiválasztása';
	@override String get without_subcategory => 'Alkategória nélkül';
	@override String get all => 'Összes kategória';
	@override String get all_short => 'Mind';
}

// Path: budgets.form
class _TranslationsBudgetsFormHu implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hozzáadás';
	@override String get name => 'Költségvetés neve';
	@override String get value => 'Mennyiségkorlátozás';
	@override String get create => 'Hozzáadás';
	@override String get create_success => 'A költségkeret sikeresen létrehozva';
	@override String get edit => 'Szerkesztés';
	@override String get edit_success => 'A költségvetés szerkesztése sikeresen megtörtént';
	@override String get negative_warn => 'A költségvetések nem lehetnek negatív összegűek.';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsHu implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Költségvetés részletei';
	@override String get statistics => 'Statisztika';
	@override String get budget_value => 'Költségvetésben';
	@override String get expend_evolution => 'Költségek alakulása';
	@override String get no_transactions => 'Úgy tűnik, hogy ezzel a költségvetéssel kapcsolatban semmilyen kiadást nem teljesített.';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesHu implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktív költségvetés';
	@override String get past => 'Befejezett költségvetés';
	@override String get future => 'Jövőbeli költségvetés';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressHu implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsHu labels = _TranslationsBudgetsProgressLabelsHu._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionHu description = _TranslationsBudgetsProgressDescriptionHu._(_root);
}

// Path: goals.type
class _TranslationsGoalsTypeHu implements TranslationsGoalsTypeEn {
	_TranslationsGoalsTypeHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Cél típusa';
	@override late final _TranslationsGoalsTypeIncomeHu income = _TranslationsGoalsTypeIncomeHu._(_root);
	@override late final _TranslationsGoalsTypeExpenseHu expense = _TranslationsGoalsTypeExpenseHu._(_root);
}

// Path: goals.form
class _TranslationsGoalsFormHu implements TranslationsGoalsFormEn {
	_TranslationsGoalsFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get new_title => 'Új cél';
	@override String get edit_title => 'Cél szerkesztése';
	@override String get target_amount => 'Célösszeg';
	@override String get initial_amount => 'Kezdő összeg';
	@override String get name => 'Név';
	@override String get name_hint => 'Megtakarítási célom';
	@override String get create_success => 'Cél sikeresen létrehozva';
	@override String get edit_success => 'Cél sikeresen szerkesztve';
	@override String get negative_warn => 'A cél összege nem lehet negatív';
}

// Path: goals.details
class _TranslationsGoalsDetailsHu implements TranslationsGoalsDetailsEn {
	_TranslationsGoalsDetailsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cél részletei';
	@override String get statistics => 'Statisztikák';
	@override String get goal_value => 'Célérték';
	@override String get evolution => 'Fejlődés';
	@override String get no_transactions => 'Úgy tűnik, nem hajtott végre ehhez a célhoz kapcsolódó tranzakciót';
}

// Path: goals.target_timeline_statuses
class _TranslationsGoalsTargetTimelineStatusesHu implements TranslationsGoalsTargetTimelineStatusesEn {
	_TranslationsGoalsTargetTimelineStatusesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktív cél';
	@override String get past => 'Befejezett cél';
	@override String get future => 'Jövőbeli cél';
}

// Path: goals.progress
class _TranslationsGoalsProgressHu implements TranslationsGoalsProgressEn {
	_TranslationsGoalsProgressHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGoalsProgressLabelsHu labels = _TranslationsGoalsProgressLabelsHu._(_root);
	@override late final _TranslationsGoalsProgressDescriptionHu description = _TranslationsGoalsProgressDescriptionHu._(_root);
}

// Path: backup.export
class _TranslationsBackupExportHu implements TranslationsBackupExportEn {
	_TranslationsBackupExportHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Adatok exportálása';
	@override String get title_short => 'Exportálás';
	@override String get type_of_export => 'Az export típusa';
	@override String get other_options => 'Opciók';
	@override String get all => 'Teljes mentés';
	@override String get all_descr => 'Exportálja az összes adatát (számlák, tranzakciók, költségvetések, beállítások...). Bármikor újra importálhatja őket, így semmit sem veszíthet el.';
	@override String get transactions => 'Tranzakciók mentése';
	@override String get transactions_descr => 'Exportálja tranzakcióit CSV formátumban, így könnyebben elemezheti azokat más programokban vagy alkalmazásokban.';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
		one: '1 exportálandó tranzakció',
		other: '${n} exportálandó tranzakció',
	);
	@override String get description => 'Adatok letöltése különböző formátumokban';
	@override String get send_file => 'Fájl küldése';
	@override String get see_folder => 'Lásd a mappát';
	@override String success({required Object x}) => 'A fájl sikeresen mentve/letöltve ide: ${x}';
	@override String get error => 'Hiba a fájl letöltésében. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
	@override String get dialog_title => 'Fájl mentése/küldése';
}

// Path: backup.import
class _TranslationsBackupImportHu implements TranslationsBackupImportEn {
	_TranslationsBackupImportHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
	@override String get error => 'Hiba történt importálásakor. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
	@override String get cancelled => 'Az importálást a felhasználó megszakította';
}

// Path: backup.about
class _TranslationsBackupAboutHu implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Információk az adatbázisról';
	@override String get create_date => 'Létrehozás dátuma';
	@override String get modify_date => 'Utolsó módosítása';
	@override String get last_backup => 'Utolsó mentés';
	@override String get size => 'Méret';
}

// Path: settings.general
class _TranslationsSettingsGeneralHu implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Általános beállítások';
	@override String get menu_descr => 'Nyelv, adatvédelem és egyebek';
	@override String get show_all_decimals => 'Összes tizedesjegy mutatása';
	@override String get show_all_decimals_descr => 'Minden tizedesjegy megjelenítése, még akkor is, ha nullára végződik';
	@override late final _TranslationsSettingsGeneralLanguageHu language = _TranslationsSettingsGeneralLanguageHu._(_root);
	@override late final _TranslationsSettingsGeneralLocaleHu locale = _TranslationsSettingsGeneralLocaleHu._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityHu implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Biztonság';
	@override String get private_mode_at_launch => 'Privát mód indításkor';
	@override String get private_mode_at_launch_descr => 'Az alkalmazás alapértelmezés szerinti indítása privát módban';
	@override String get private_mode => 'Privát mód';
	@override String get private_mode_descr => 'Minden pénzösszeg elrejtése';
	@override String get private_mode_activated => 'Privát mód aktiválva';
	@override String get private_mode_deactivated => 'Privát mód letiltva';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsHu implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Tranzakciók';
	@override String get menu_descr => 'Konfigurálja tranzakciói viselkedését';
	@override String get title => 'Tranzakciós beállítások';
	@override late final _TranslationsSettingsTransactionsStyleHu style = _TranslationsSettingsTransactionsStyleHu._(_root);
	@override late final _TranslationsSettingsTransactionsSwipeActionsHu swipe_actions = _TranslationsSettingsTransactionsSwipeActionsHu._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesHu default_values = _TranslationsSettingsTransactionsDefaultValuesHu._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeHu default_type = _TranslationsSettingsTransactionsDefaultTypeHu._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceHu implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Téma és stílus';
	@override String get menu_descr => 'Témaválasztás, színek és egyéb, az alkalmazás megjelenésével kapcsolatos dolgok';
	@override String get theme_and_colors => 'Témák és színek';
	@override late final _TranslationsSettingsAppearanceThemeHu theme = _TranslationsSettingsAppearanceThemeHu._(_root);
	@override String get amoled_mode => 'AMOLED mód';
	@override String get amoled_mode_descr => 'Ha lehetséges, használjon tiszta fekete háttérképet. Ez némileg segíti az AMOLED képernyővel rendelkező készülékek akkumulátorát.';
	@override String get dynamic_colors => 'Dinamikus színek';
	@override String get dynamic_colors_descr => 'Amikor csak lehetséges, használja a rendszer kiemelő színét';
	@override String get accent_color => 'Kiemelő szín';
	@override String get accent_color_descr => 'Válassza ki, hogy az alkalmazás milyen színnel emelje ki a felület bizonyos részeit';
	@override String get text => 'Szöveg';
	@override String get font => 'Betűtípus';
	@override String get font_platform => 'Platform';
}

// Path: more.data
class _TranslationsMoreDataHu implements TranslationsMoreDataEn {
	_TranslationsMoreDataHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsMoreAboutUsHu implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Alkalmazásinformációk';
	@override String get description => 'Találja meg a Monekin feltételeit, fontos információkat, és lépjen kapcsolatba hibák bejelentésével vagy ötletek megosztásával';
	@override late final _TranslationsMoreAboutUsLegalHu legal = _TranslationsMoreAboutUsLegalHu._(_root);
	@override late final _TranslationsMoreAboutUsProjectHu project = _TranslationsMoreAboutUsProjectHu._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsHu implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsGeneralTimeRangesHu implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsGeneralTimePeriodicityHu implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsGeneralTimeCurrentHu implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Ebben a hónapban';
	@override String get annually => 'Ebben az évben';
	@override String get quaterly => 'Ebben a negyedévben';
	@override String get weekly => 'Ezen a héten';
	@override String get infinite => 'Mindig';
	@override String get custom => 'Egyéni tartomány';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllHu implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Minden nap';
	@override String get monthly => 'Minden hónapban';
	@override String get annually => 'Minden évben';
	@override String get quaterly => 'Minden negyedévben';
	@override String get weekly => 'Minden héten';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrHu implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Úgy tűnik, nincs elég rögzített kiadásunk ahhoz, hogy kiszámítsuk a pénzügyi állapotát. Adjon hozzá néhány kiadást/bevételt ebben az időszakban, hogy tudjunk segíteni Önnek!';
	@override String get very_good => 'Gratulálunk! Az Ön pénzügyi helyzete nagyon rendben van. Reméljük, hogy folytatódik a jó szériája, és továbbra is tanulni fog a Monekin-nel.';
	@override String get good => 'Nagyszerű! Az Ön pénzügyi helyzete rendben van. Látogasson el az elemzés fülre, hogy megtudja, hogyan takaríthat meg még többet!';
	@override String get normal => 'Az Ön pénzügyi állapota nagyjából a lakosság többi részének átlagában van ebben az időszakban.';
	@override String get bad => 'Úgy tűnik, hogy az Ön pénzügyi helyzete még nem a legjobb. Tekintse át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
	@override String get very_bad => 'Hmm, a pénzügyi helyzete messze elmarad attól, aminek lennie kellene. Nézze át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextHu implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Gratulálunk! Ebben az időszakban a bevételének <b>${value}%</b>-át sikerült megtakarítania. Úgy tűnik, már rendelkezik hozzáértéssel, csak így tovább!';
	@override String normal({required Object value}) => 'Gratulálunk, a bevételének <b>${value}%</b>-át sikerült megtakarítania ebben az időszakban.';
	@override String bad({required Object value}) => 'Ebben az időszakban sikerült megtakarítania a jövedelmének <b>${value}%-át</b>. Úgy gondoljuk azonban, hogy ennél még sokkal többet is tehet!';
	@override String get very_bad => 'Hűha, sajnos ebben az időszakban semmit sem sikerült megtakarítania.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditHu implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Dátumok szerkesztése';
	@override String get categories => 'Kategóriák szerkesztése';
	@override String get status => 'Állapotok szerkesztése';
}

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedHu implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mentett szűrők';
	@override String get new_title => 'Új szűrő';
	@override String get edit_title => 'Szűrő szerkesztése';
	@override String get name_label => 'Szűrő neve';
	@override String get name_hint => 'Saját szűrőm';
	@override String get save_dialog_title => 'Szűrő mentése';
	@override String get save_tooltip => 'Jelenlegi szűrő mentése';
	@override String get load_tooltip => 'Mentett szűrő betöltése';
	@override String get empty_title => 'Nincsenek mentett szűrők';
	@override String get empty_description => 'Mentse el a szűrőket itt, hogy később gyorsan elérhesse őket.';
	@override String get save_success => 'Szűrő sikeresen mentve';
	@override String get delete_success => 'Szűrő sikeresen törölve';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsHu implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get zero => 'A tranzakció értéke nem lehet nulla.';
	@override String get date_max => 'A kiválasztott dátum az aktuális dátum után van. A tranzakció függő tranzakcióként kerül hozzáadásra.';
	@override String get date_after_account_creation => 'Nem hozhat létre olyan tranzakciót, amelynek a dátuma megelőzi a hozzá tartozó számla létrehozásának a dátumát.';
	@override String get negative_transfer => 'Az átutalás pénzbeli értéke nem lehet negatív.';
	@override String get transfer_between_same_accounts => 'A kiindulási és a célszámla nem lehet ugyanaz.';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyHu implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'A rendeltetési helyre átutalt összeg';
	@override String amount_short({required Object amount}) => '${amount} a célszámlához';
}

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsHu implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'Terv szerint';
	@override String get active_overspending => 'Túlköltekezés';
	@override String get active_indeterminate => 'Aktív';
	@override String get success => 'Teljesítve';
	@override String get fail => 'Költségvetés túllépve';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionHu implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Naponta ${dailyAmount} összeget költhet a hátralévő ${remainingDays} napban';
	@override String active_overspending({required Object dailyAmount, required Object remainingDays}) => 'Hogy visszatérjen a tervhez, korlátoznia kell kiadásait napi ${dailyAmount} összegre a hátralévő ${remainingDays} napban';
	@override String active_indeterminate({required Object amount}) => 'Még ${amount} elkölthető.';
	@override String active_exceeded({required Object amount}) => 'Már túllépte a költségvetési keretet ${amount} összeggel. Ha nem talál bevételt ehhez a költségvetéshez, abba kell hagynia a költekezést az időszak hátralévő részében';
	@override String get success => 'Szép munka! Ez a költségvetés sikeresen lezárult. Hozzon létre további költségvetéseket kiadásai kezeléséhez';
	@override String fail({required Object amount}) => 'Túllépte a költségvetést ${amount} összeggel. Próbáljon meg óvatosabb lenni legközelebb!';
}

// Path: goals.type.income
class _TranslationsGoalsTypeIncomeHu implements TranslationsGoalsTypeIncomeEn {
	_TranslationsGoalsTypeIncomeHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Megtakarítási cél';
	@override String get descr => 'Ideális pénzmegtakarításhoz. Akkor sikeres, ha az egyenleg meghaladja a célösszeget.';
}

// Path: goals.type.expense
class _TranslationsGoalsTypeExpenseHu implements TranslationsGoalsTypeExpenseEn {
	_TranslationsGoalsTypeExpenseHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Költési cél';
	@override String get descr => 'Kövesse nyomon kiadásait, és próbáljon meg elérni egy célösszeget. Jól használható adományokhoz...';
}

// Path: goals.progress.labels
class _TranslationsGoalsProgressLabelsHu implements TranslationsGoalsProgressLabelsEn {
	_TranslationsGoalsProgressLabelsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'Pályán';
	@override String get active_behind_schedule => 'A menetrend lemaradásával';
	@override String get active_indeterminate => 'Aktív';
	@override String get success => 'A cél elérve';
	@override String get fail => 'A gól nem sikerült';
}

// Path: goals.progress.description
class _TranslationsGoalsProgressDescriptionHu implements TranslationsGoalsProgressDescriptionEn {
	_TranslationsGoalsProgressDescriptionHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Jó úton haladsz a cél felé! Naponta ${dailyAmount} összeget kell megtakarítania a fennmaradó ${remainingDays} napig';
	@override String active_behind_schedule({required Object dailyAmount, required Object remainingDays}) => 'Lemaradsz a menetrendről. Naponta ${dailyAmount} összeget kell megtakarítania, hogy ${remainingDays} napon belül elérje célját';
	@override String active_indeterminate({required Object amount}) => 'További ${amount} kell a cél eléréséhez.';
	@override String get success => 'Gratulálok! Elérted a célodat.';
	@override String fail({required Object amount}) => '${amount} értékkel eltévesztette a célt.';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportHu implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageHu implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get section => 'Nyelv és szövegek';
	@override String get title => 'Alkalmazás nyelve';
	@override String get descr => 'Nyelv, amelyen a szövegek megjelennek az alkalmazásban';
	@override String get help => 'Ha együttműködni szeretne ennek az alkalmazásnak a fordításával, tekintse meg a <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'> útmutatónk</a>';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleHu implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Régió';
	@override String get auto => 'Rendszer';
	@override String get descr => 'Dátumok, számformátumok beállítása...';
	@override String get warn => 'Régióváltáskor az alkalmazás frissülni fog';
	@override String get first_day_of_week => 'A hét első napja';
}

// Path: settings.transactions.style
class _TranslationsSettingsTransactionsStyleHu implements TranslationsSettingsTransactionsStyleEn {
	_TranslationsSettingsTransactionsStyleHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tranzakció stílusa';
	@override String get subtitle => 'Állítsa be, hogyan jelenjenek meg a tranzakciók a listákban';
	@override String get show_tags => 'Címkék mutatása';
	@override String get show_time => 'Idő mutatása';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsHu implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Csúsztatási műveletek';
	@override String get choose_description => 'Válassza ki, hogy milyen művelet induljon el, ha a listában lévő tranzakciós tételt ezzel a csúsztatási irány segítségével csúsztatja';
	@override String get swipe_left => 'Csúsztasson balra';
	@override String get swipe_right => 'Csúsztasson jobbra';
	@override String get none => 'Nincs akció';
	@override String get toggle_reconciled => 'Váltás egyeztetve';
	@override String get toggle_pending => 'Váltás függőben';
	@override String get toggle_voided => 'Váltó érvénytelenítve';
	@override String get toggle_unreconciled => 'Váltás nem egyeztetve';
	@override String get remove_status => 'Állapot eltávolítása';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesHu implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
class _TranslationsSettingsTransactionsDefaultTypeHu implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Type';
	@override String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeHu implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Téma';
	@override String get auto => 'Rendszer';
	@override String get light => 'Világos';
	@override String get dark => 'Sötét';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalHu implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Jogi információk';
	@override String get privacy => 'Adatvédelem';
	@override String get terms => 'Használati feltételek';
	@override String get licenses => 'Licencek';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectHu implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get display => 'Projekt';
	@override String get contributors => 'Közreműködők';
	@override String get contributors_descr => 'Az összes fejlesztő, akik hozzájárultak a Monekin létrehozásához';
	@override String get contact => 'Kapcsolatfelvétel';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesHu implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Ciklusok';
	@override String get last_days => 'Utolsó nap';
	@override String last_days_form({required Object x}) => '${x} előző nap';
	@override String get all => 'Mindig';
	@override String get date_range => 'Egyéni tartomány';
}

/// The flat map containing all translations for locale <hu>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on TranslationsHu {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = 'Mégse';
		map['ui_actions.confirm'] = 'Megerősítés';
		map['ui_actions.continue_text'] = 'Folytatás';
		map['ui_actions.save'] = 'Mentés';
		map['ui_actions.save_changes'] = 'Módosítások mentése';
		map['ui_actions.close_and_save'] = 'Mentés és bezárás';
		map['ui_actions.add'] = 'Hozzáad';
		map['ui_actions.edit'] = 'Szerkesztés';
		map['ui_actions.delete'] = 'Törlés';
		map['ui_actions.see_more'] = 'Továbbiak megtekintése';
		map['ui_actions.select_all'] = 'Összes kijelölése';
		map['ui_actions.deselect_all'] = 'Összes kijelölésének megszüntetése';
		map['ui_actions.select'] = 'Kiválasztás';
		map['ui_actions.search'] = 'Keresés';
		map['ui_actions.filter'] = 'Szűrés';
		map['ui_actions.reset'] = 'Alaphelyzetbe állítás';
		map['ui_actions.submit'] = 'Beküldés';
		map['ui_actions.next'] = 'Következő';
		map['ui_actions.previous'] = 'Előző';
		map['ui_actions.back'] = 'Vissza';
		map['ui_actions.reload'] = 'Újratöltés';
		map['ui_actions.view'] = 'Megtekintés';
		map['ui_actions.download'] = 'Letöltés';
		map['ui_actions.upload'] = 'Feltöltés';
		map['ui_actions.retry'] = 'Újrapróbálkozás';
		map['ui_actions.copy'] = 'Másolás';
		map['ui_actions.paste'] = 'Beillesztés';
		map['ui_actions.undo'] = 'Visszavonás';
		map['ui_actions.redo'] = 'Újra';
		map['ui_actions.open'] = 'Megnyitás';
		map['ui_actions.close'] = 'Bezárás';
		map['ui_actions.apply'] = 'Alkalmaz';
		map['ui_actions.discard'] = 'Elvetés';
		map['ui_actions.refresh'] = 'Frissítés';
		map['ui_actions.share'] = 'Megosztás';
		map['general.or'] = 'vagy';
		map['general.understood'] = 'Megértve';
		map['general.unspecified'] = 'Meghatározatlan';
		map['general.quick_actions'] = 'Gyorsműveletek';
		map['general.details'] = 'Részletek';
		map['general.balance'] = 'Egyenleg';
		map['general.account'] = 'Számla';
		map['general.accounts'] = 'Számlák';
		map['general.categories'] = 'Kategóriák';
		map['general.category'] = 'Kategória';
		map['general.today'] = 'Ma';
		map['general.yesterday'] = 'Tegnap';
		map['general.filters'] = 'Szűrők';
		map['general.empty_warn'] = 'Hoppá! Ez nagyon üres.';
		map['general.search_no_results'] = 'Egyetlen elem sem felel meg a keresési feltételeknek';
		map['general.insufficient_data'] = 'Hiányos adatok';
		map['general.show_more_fields'] = 'Több mező mutatása';
		map['general.show_less_fields'] = 'Kevesebb mező mutatása';
		map['general.tap_to_search'] = 'Koppintson a kereséshez';
		map['general.delete_success'] = 'Az elem sikeresen törölve';
		map['general.leave_without_saving.title'] = 'Mentés nélkül távozik?';
		map['general.leave_without_saving.message'] = 'Vannak nem mentett módosításai. Biztos, hogy mentés nélkül kilép?';
		map['general.clipboard.success'] = ({required Object x}) => '${x} a vágólapra másolva';
		map['general.clipboard.error'] = 'Másolási hiba';
		map['general.time.start_date'] = 'Kezdő dátum';
		map['general.time.end_date'] = 'Befejezés dátuma';
		map['general.time.from_date'] = 'Ettől kezdve';
		map['general.time.until_date'] = 'Dátumig';
		map['general.time.date'] = 'Dátum';
		map['general.time.datetime'] = 'Időpont';
		map['general.time.time'] = 'Idő';
		map['general.time.each'] = 'Minden';
		map['general.time.after'] = 'Után';
		map['general.time.ranges.display'] = 'Időtartomány';
		map['general.time.ranges.it_repeat'] = 'Ismétlések';
		map['general.time.ranges.it_ends'] = 'Vége';
		map['general.time.ranges.forever'] = 'Mindig';
		map['general.time.ranges.types.cycle'] = 'Ciklusok';
		map['general.time.ranges.types.last_days'] = 'Utolsó nap';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '${x} előző nap';
		map['general.time.ranges.types.all'] = 'Mindig';
		map['general.time.ranges.types.date_range'] = 'Egyéni tartomány';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range}',
				other: 'Minden ${n} ${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range} ${day} -ig',
				other: 'Minden ${n} ${range} ${day} -ig',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range} ${limit} alkalommal',
				other: 'Minden ${n} ${range} ${limit} alkalommal',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Minden ${range} egyszer',
				other: 'Minden ${n} ${range} egyszer',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Hónap',
				other: 'Hónap',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Év',
				other: 'Év',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Nap',
				other: 'Nap',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Hét',
				other: 'Hét',
			);
		map['general.time.periodicity.display'] = 'Ismétlődés';
		map['general.time.periodicity.no_repeat'] = 'Nem ismétlődik';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Ismétlés',
				other: 'Ismétlések',
			);
		map['general.time.periodicity.diary'] = 'Naponta';
		map['general.time.periodicity.monthly'] = 'Havonta';
		map['general.time.periodicity.annually'] = 'Évente';
		map['general.time.periodicity.quaterly'] = 'Negyedévente';
		map['general.time.periodicity.weekly'] = 'Hetente';
		map['general.time.periodicity.custom'] = 'Egyéni';
		map['general.time.periodicity.infinite'] = 'Mindig';
		map['general.time.current.monthly'] = 'Ebben a hónapban';
		map['general.time.current.annually'] = 'Ebben az évben';
		map['general.time.current.quaterly'] = 'Ebben a negyedévben';
		map['general.time.current.weekly'] = 'Ezen a héten';
		map['general.time.current.infinite'] = 'Mindig';
		map['general.time.current.custom'] = 'Egyéni tartomány';
		map['general.time.all.diary'] = 'Minden nap';
		map['general.time.all.monthly'] = 'Minden hónapban';
		map['general.time.all.annually'] = 'Minden évben';
		map['general.time.all.quaterly'] = 'Minden negyedévben';
		map['general.time.all.weekly'] = 'Minden héten';
		map['general.transaction_order.display'] = 'Tranzakciók rendezése';
		map['general.transaction_order.category'] = 'Kategóriánként';
		map['general.transaction_order.quantity'] = 'Mennyiség szerint';
		map['general.transaction_order.date'] = 'Dátum szerint';
		map['general.validations.form_error'] = 'A folytatáshoz javítsa ki a megadott mezőket';
		map['general.validations.required'] = 'Kötelező mező';
		map['general.validations.positive'] = 'Pozitívnak kell lennie';
		map['general.validations.min_number'] = ({required Object x}) => 'Nagyobbnak kell lennie, mint ${x}';
		map['general.validations.max_number'] = ({required Object x}) => 'Kevesebbnek kell lennie, mint ${x}';
		map['intro.start'] = 'Kezdés';
		map['intro.skip'] = 'Kihagyás';
		map['intro.next'] = 'Tovább';
		map['intro.select_your_currency'] = 'Válassza ki a pénznemet';
		map['intro.welcome_subtitle'] = 'Az Ön személyes pénzügyi menedzsere';
		map['intro.welcome_subtitle2'] = '100% -ban nyitott, és 100% -ban ingyenes';
		map['intro.welcome_footer'] = 'A bejelentkezéssel elfogadja az <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Adatvédelmi irányelveket</a> és az alkalmazás <a href=\' https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Felhasználási feltételeit</a>';
		map['intro.offline_descr_title'] = 'OFFLINE SZÁMLA:';
		map['intro.offline_descr'] = 'Az Ön adatai csak az Ön készülékén tárolódnak, és biztonságban lesznek, amíg nem távolítja el az alkalmazást, vagy nem cseréli le a telefont. Az adatvesztés megelőzése érdekében ajánlott rendszeresen biztonsági mentést készíteni az alkalmazás beállításaiból.';
		map['intro.offline_start'] = 'Offline munkamenet indítása';
		map['intro.sl1_title'] = 'Válassza ki a pénznemet';
		map['intro.sl1_descr'] = 'Az alapértelmezett pénznemet a jelentésekben és az általános diagramokban használjuk. A pénznemet és az alkalmazás nyelvét később bármikor megváltoztathatja az alkalmazás beállításaiban.';
		map['intro.sl2_title'] = 'Biztonságos, privát és megbízható';
		map['intro.sl2_descr'] = 'Az Ön adatai csak az Önéi. Az adatokat közvetlenül az Ön eszközén tároljuk, anélkül, hogy azok külső szervereken keresztül mennének át. Ez lehetővé teszi az alkalmazás használatát internet nélkül is.';
		map['intro.sl2_descr2'] = 'Az alkalmazás forráskódja is nyilvános, így bárki közreműködhet benne, és megnézheti, hogyan is működik.';
		map['intro.last_slide_title'] = 'Minden kész';
		map['intro.last_slide_descr'] = 'A Monekin segítségével végre elérheti azt az anyagi függetlenséget, amelyre annyira vágyik. Grafikonok, költségvetések, tippek, statisztikák és még sok minden más lesz megtalálható a pénzével kapcsolatban.';
		map['intro.last_slide_descr2'] = 'Reméljük, hogy élvezni fogja az élményt! Ne habozzon kapcsolatba lépni velünk, ha kétségei, javaslatai vannak...';
		map['home.title'] = 'Kezdőlap';
		map['home.filter_transactions'] = 'Tranzakciók szűrése';
		map['home.hello_day'] = 'Jó reggelt,';
		map['home.hello_night'] = 'Jó éjszakát,';
		map['home.total_balance'] = 'Teljes egyenleg';
		map['home.my_accounts'] = 'Saját számláim';
		map['home.active_accounts'] = 'Aktív számlák';
		map['home.no_accounts'] = 'Még nincsenek számlák létrehozva';
		map['home.no_accounts_descr'] = 'Kezdje el élvezni a Monekin összes varázsát. A tranzakciók hozzáadásához legalább egy számlát hozzon létre.';
		map['home.last_transactions'] = 'Legutóbbi tranzakciók';
		map['home.should_create_account_header'] = 'Hoppá!';
		map['home.should_create_account_message'] = 'A tranzakciók létrehozásához legalább egy nem archivált számlával kell rendelkeznie';
		map['financial_health.display'] = 'Pénzügyi állapot';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Nagyon jó!';
					case GenderContext.female:
						return 'Nagyon jó!';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Jó';
					case GenderContext.female:
						return 'Jó';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Átlagos';
					case GenderContext.female:
						return 'Átlagos';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Korrekt';
					case GenderContext.female:
						return 'Korrekt';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Nagyon rossz';
					case GenderContext.female:
						return 'Nagyon rossz';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Hiányos adatok';
					case GenderContext.female:
						return 'Hiányos adatok';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = 'Úgy tűnik, nincs elég rögzített kiadásunk ahhoz, hogy kiszámítsuk a pénzügyi állapotát. Adjon hozzá néhány kiadást/bevételt ebben az időszakban, hogy tudjunk segíteni Önnek!';
		map['financial_health.review.descr.very_good'] = 'Gratulálunk! Az Ön pénzügyi helyzete nagyon rendben van. Reméljük, hogy folytatódik a jó szériája, és továbbra is tanulni fog a Monekin-nel.';
		map['financial_health.review.descr.good'] = 'Nagyszerű! Az Ön pénzügyi helyzete rendben van. Látogasson el az elemzés fülre, hogy megtudja, hogyan takaríthat meg még többet!';
		map['financial_health.review.descr.normal'] = 'Az Ön pénzügyi állapota nagyjából a lakosság többi részének átlagában van ebben az időszakban.';
		map['financial_health.review.descr.bad'] = 'Úgy tűnik, hogy az Ön pénzügyi helyzete még nem a legjobb. Tekintse át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
		map['financial_health.review.descr.very_bad'] = 'Hmm, a pénzügyi helyzete messze elmarad attól, aminek lennie kellene. Nézze át a többi diagramot, hogy többet tudjon meg a pénzügyeiről.';
		map['financial_health.months_without_income.title'] = 'Túlélési arány';
		map['financial_health.months_without_income.subtitle'] = 'Egyenlegét tekintve, mennyi ideig maradhat bevétel nélkül';
		map['financial_health.months_without_income.text_zero'] = 'Ilyen kiadás mellett egy hónapot sem bírna ki bevétel nélkül!';
		map['financial_health.months_without_income.text_one'] = 'Ilyen mértékű kiadások mellett aligha tudna akár egy hónapot is túlélni bevétel nélkül!';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => 'Ezzel a költési aránnyal körülbelül <b>${n} hónapot</b> tudna túlélni jövedelem nélkül.';
		map['financial_health.months_without_income.text_infinite'] = 'Ezzel a költési aránnyal nagyjából <b>az egész életében</b> meg tudna élni jövedelem nélkül.';
		map['financial_health.months_without_income.suggestion'] = 'Ne feledje, hogy célszerű ezt az arányt mindig legalább 5 hónap felett tartani. Ha úgy látja, hogy nem rendelkezik elegendő megtakarítási tartalékkal, csökkentse a felesleges kiadásokat.';
		map['financial_health.months_without_income.insufficient_data'] = 'Úgy tűnik, nincs elég rögzített kiadásunk ahhoz, hogy kiszámolhassuk, hány hónapig tudna bevétel nélkül megélni. Adjon meg néhány tranzakciót, és térjen vissza ide, hogy ellenőrizze a pénzügyi helyzetét.';
		map['financial_health.savings_percentage.title'] = 'Megtakarítási százalék';
		map['financial_health.savings_percentage.subtitle'] = 'A jövedelmének mekkora részét nem költi el ebben az időszakban';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => 'Gratulálunk! Ebben az időszakban a bevételének <b>${value}%</b>-át sikerült megtakarítania. Úgy tűnik, már rendelkezik hozzáértéssel, csak így tovább!';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => 'Gratulálunk, a bevételének <b>${value}%</b>-át sikerült megtakarítania ebben az időszakban.';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => 'Ebben az időszakban sikerült megtakarítania a jövedelmének <b>${value}%-át</b>. Úgy gondoljuk azonban, hogy ennél még sokkal többet is tehet!';
		map['financial_health.savings_percentage.text.very_bad'] = 'Hűha, sajnos ebben az időszakban semmit sem sikerült megtakarítania.';
		map['financial_health.savings_percentage.suggestion'] = 'Ne feledje, hogy a jövedelmének legalább 15-20%-át célszerű megtakarítani.';
		map['stats.title'] = 'Statisztika';
		map['stats.balance'] = 'Egyenleg';
		map['stats.final_balance'] = 'Végső egyenleg';
		map['stats.balance_by_account'] = 'Számlák szerinti egyenleg';
		map['stats.balance_by_account_subtitle'] = 'Hol van a legtöbb pénzem?';
		map['stats.balance_by_currency'] = 'Egyenleg pénznemenként';
		map['stats.balance_by_currency_subtitle'] = 'Mennyi pénzem van devizában?';
		map['stats.balance_evolution'] = 'Egyenleg alakulása';
		map['stats.balance_evolution_subtitle'] = 'Több pénzem van, mint korábban?';
		map['stats.compared_to_previous_period'] = 'Az előző időszakhoz képest';
		map['stats.cash_flow'] = 'Pénzforgalom';
		map['stats.cash_flow_subtitle'] = 'Kevesebbet költök, mint amennyit megkeresek?';
		map['stats.by_periods'] = 'Időszakonként';
		map['stats.by_categories'] = 'Kategóriánként';
		map['stats.by_tags'] = 'Címkék szerint';
		map['stats.distribution'] = 'Megoszlás';
		map['stats.finance_health_resume'] = 'Folytatás';
		map['stats.finance_health_breakdown'] = 'Csőd';
		map['icon_selector.name'] = 'Név:';
		map['icon_selector.icon'] = 'Ikon';
		map['icon_selector.color'] = 'Szín';
		map['icon_selector.select_icon'] = 'Ikon kiválasztása';
		map['icon_selector.select_color'] = 'Szín kiválasztása';
		map['icon_selector.custom_color'] = 'Egyedi szín';
		map['icon_selector.current_color_selection'] = 'Jelenlegi kiválasztás';
		map['icon_selector.select_account_icon'] = 'Számla azonosítása';
		map['icon_selector.select_category_icon'] = 'Kategória azonosítása';
		map['icon_selector.scopes.transport'] = 'Közlekedés';
		map['icon_selector.scopes.money'] = 'Pénz';
		map['icon_selector.scopes.food'] = 'Élelmiszer';
		map['icon_selector.scopes.medical'] = 'Egészség';
		map['icon_selector.scopes.entertainment'] = 'Szabadidő';
		map['icon_selector.scopes.technology'] = 'Technológia';
		map['icon_selector.scopes.other'] = 'Egyebek';
		map['icon_selector.scopes.logos_financial_institutions'] = 'Pénzintézetek';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Tranzakció',
				other: 'Tranzakciók',
			);
		map['transaction.create'] = 'Új tranzakció';
		map['transaction.new_income'] = 'Új bevétel';
		map['transaction.new_expense'] = 'Új kiadás';
		map['transaction.new_success'] = 'A tranzakció sikeresen létrehozva';
		map['transaction.edit'] = 'Tranzakció szerkesztése';
		map['transaction.edit_success'] = 'A tranzakció sikeresen szerkesztve';
		map['transaction.edit_multiple'] = 'Tranzakciók szerkesztése';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x} tranzakció sikeresen szerkesztve';
		map['transaction.duplicate'] = 'Tranzakció klónozása';
		map['transaction.duplicate_short'] = 'Klónozás';
		map['transaction.duplicate_warning_message'] = 'Egy ezzel megegyező tranzakció jön létre ugyanazzal a dátummal, folytatni szeretné?';
		map['transaction.duplicate_success'] = 'A tranzakció sikeresen klónozva';
		map['transaction.delete'] = 'Tranzakció törlése';
		map['transaction.delete_warning_message'] = 'Ez a művelet visszafordíthatatlan. A számlák aktuális egyenlege és az összes statisztikája újraszámításra kerül.';
		map['transaction.delete_success'] = 'A tranzakció sikeresen törölve';
		map['transaction.delete_multiple'] = 'Tranzakciók törlése';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => 'Ez a művelet visszafordíthatatlan, és eltávolít ${x} tranzakciót. A számlái aktuális egyenlege és minden statisztikája újraszámításra kerül.';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x} tranzakció megfelelően törölve';
		map['transaction.details'] = 'A mozgás részletei';
		map['transaction.next_payments.accept'] = 'Elfogadás';
		map['transaction.next_payments.skip'] = 'Kihagyás';
		map['transaction.next_payments.skip_success'] = 'A tranzakció sikeresen kihagyásra került';
		map['transaction.next_payments.skip_dialog_title'] = 'Tranzakció kihagyása';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => 'Ez a művelet visszafordíthatatlan. A következő átvitel dátumát módosítjuk erre: ${date}';
		map['transaction.next_payments.accept_today'] = 'Elfogadom ma';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => 'Elfogadás a szükséges időpontban: (${date})';
		map['transaction.next_payments.accept_dialog_title'] = 'Tranzakció elfogadása';
		map['transaction.next_payments.accept_dialog_msg_single'] = 'A tranzakció új állapota nulla lesz. A tranzakció státuszát bármikor újra módosíthatja, amikor csak akarja.';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => 'Ez a művelet egy új tranzakciót hoz létre ${date} dátummal. A tranzakció részleteit a tranzakciós oldalon ellenőrizheti.';
		map['transaction.next_payments.recurrent_rule_finished'] = 'Az ismétlődő szabály teljesült, nincs több kifizetés!';
		map['transaction.list.all'] = 'Minden tranzakció';
		map['transaction.list.empty'] = 'Nem található itt megjeleníthető tranzakció. Adjon hozzá néhány tranzakciót az alkalmazásban, és talán legközelebb több szerencséje lesz.';
		map['transaction.list.searcher_placeholder'] = 'Keresés kategória, leírás alapján...';
		map['transaction.list.searcher_no_results'] = 'Nincs a keresési feltételeknek megfelelő tranzakció';
		map['transaction.list.loading'] = 'További tranzakciók betöltése...';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: '${n} kiválasztva',
				other: '${n} kiválasztva',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: '${n} tranzakció kiválasztva',
				other: '${n} tranzakció kiválasztva',
			);
		map['transaction.list.bulk_edit.dates'] = 'Dátumok szerkesztése';
		map['transaction.list.bulk_edit.categories'] = 'Kategóriák szerkesztése';
		map['transaction.list.bulk_edit.status'] = 'Állapotok szerkesztése';
		map['transaction.filters.title'] = 'Tranzakciós szűrők';
		map['transaction.filters.from_value'] = 'Ebből az összegből';
		map['transaction.filters.to_value'] = 'Eddig az összegig';
		map['transaction.filters.from_value_def'] = ({required Object x}) => 'Innen: ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => 'Ide: ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => 'Ettől: ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => 'Eddig: ${date}';
		map['transaction.filters.reset'] = 'Szűrők visszaállítása';
		map['transaction.filters.saved.title'] = 'Mentett szűrők';
		map['transaction.filters.saved.new_title'] = 'Új szűrő';
		map['transaction.filters.saved.edit_title'] = 'Szűrő szerkesztése';
		map['transaction.filters.saved.name_label'] = 'Szűrő neve';
		map['transaction.filters.saved.name_hint'] = 'Saját szűrőm';
		map['transaction.filters.saved.save_dialog_title'] = 'Szűrő mentése';
		map['transaction.filters.saved.save_tooltip'] = 'Jelenlegi szűrő mentése';
		map['transaction.filters.saved.load_tooltip'] = 'Mentett szűrő betöltése';
		map['transaction.filters.saved.empty_title'] = 'Nincsenek mentett szűrők';
		map['transaction.filters.saved.empty_description'] = 'Mentse el a szűrőket itt, hogy később gyorsan elérhesse őket.';
		map['transaction.filters.saved.save_success'] = 'Szűrő sikeresen mentve';
		map['transaction.filters.saved.delete_success'] = 'Szűrő sikeresen törölve';
		map['transaction.form.validators.zero'] = 'A tranzakció értéke nem lehet nulla.';
		map['transaction.form.validators.date_max'] = 'A kiválasztott dátum az aktuális dátum után van. A tranzakció függő tranzakcióként kerül hozzáadásra.';
		map['transaction.form.validators.date_after_account_creation'] = 'Nem hozhat létre olyan tranzakciót, amelynek a dátuma megelőzi a hozzá tartozó számla létrehozásának a dátumát.';
		map['transaction.form.validators.negative_transfer'] = 'Az átutalás pénzbeli értéke nem lehet negatív.';
		map['transaction.form.validators.transfer_between_same_accounts'] = 'A kiindulási és a célszámla nem lehet ugyanaz.';
		map['transaction.form.title'] = 'Tranzakció megnevezése';
		map['transaction.form.title_short'] = 'Cím';
		map['transaction.form.value'] = 'A tranzakció értéke';
		map['transaction.form.tap_to_see_more'] = 'Koppintson a további részletek megtekintéséhez';
		map['transaction.form.no_tags'] = '-- Nincsenek címkék --';
		map['transaction.form.description'] = 'Leírás';
		map['transaction.form.description_info'] = 'Koppintson ide a tranzakció részletesebb leírásának megadásához.';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => '${currency} átváltási árfolyam';
		map['transaction.form.exchange_to_preferred_in_date'] = 'A tranzakció napján';
		map['transaction.reversed.title'] = 'Megfordított tranzakció';
		map['transaction.reversed.title_short'] = 'Megfordított';
		map['transaction.reversed.description_for_expenses'] = 'Annak ellenére, hogy költségtranzakció, pozitív összegű. Az ilyen típusú tranzakciókat egy korábban elszámolt kiadás visszatérülésének, például visszatérítésnek vagy egy tartozás kifizetésének megjelenítésére lehet használni.';
		map['transaction.reversed.description_for_incomes'] = 'Annak ellenére, hogy bevételi tranzakció, negatív összegű. Az ilyen típusú tranzakciók felhasználhatók a helytelenül elszámolt bevétel érvénytelenítésére vagy helyesbítésére, pénzvisszatérítés vagy pénzvisszatérítés tükrözésére, illetve tartozások kifizetésének rögzítésére.';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Állapot',
				other: 'Állapotok',
			);
		map['transaction.status.display_long'] = 'Tranzakció állapota';
		map['transaction.status.tr_status'] = ({required Object status}) => '${status} tranzakció';
		map['transaction.status.none'] = 'Állapot nélküli';
		map['transaction.status.none_descr'] = 'Konkrét állapot nélküli tranzakció';
		map['transaction.status.reconciled'] = 'Egyeztetett';
		map['transaction.status.reconciled_descr'] = 'Ezt a tranzakciót már érvényesítették, és megfelel a bankja valós tranzakciójának.';
		map['transaction.status.unreconciled'] = 'Nem egyeztetett';
		map['transaction.status.unreconciled_descr'] = 'Ezt a tranzakciót még nem ellenőrizték, ezért még nem jelenik meg a valódi bankszámláin. Ez azonban szükséges a Monekin egyenlegeinek és statisztikáinak kiszámításához.';
		map['transaction.status.pending'] = 'Függőben';
		map['transaction.status.pending_descr'] = 'Ez a tranzakció függőben van, ezért az egyenlegek és statisztikák kiszámításakor nem kerül figyelembevételbe.';
		map['transaction.status.voided'] = 'Érvénytelenítve';
		map['transaction.status.voided_descr'] = 'Fizetési hiba vagy bármilyen más ok miatt érvénytelenített/törölt tranzakció. Ezt nem vesszük figyelembe az egyenlegek és statisztikák kiszámításakor.';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Tranzakció típusa',
				other: 'Tranzakciótípusok',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Bevétel',
				other: 'Bevételek',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Kiadás',
				other: 'Kiadások',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Áthelyezés',
				other: 'Áthelyezések',
			);
		map['transfer.display'] = 'Áthelyezés';
		map['transfer.transfers'] = 'Áthelyezések';
		map['transfer.transfer_to'] = ({required Object account}) => 'Áthelyezés ide: ${account}';
		map['transfer.create'] = 'Új átvitel';
		map['transfer.need_two_accounts_warning_header'] = 'Hoppá!';
		map['transfer.need_two_accounts_warning_message'] = 'A művelet végrehajtásához legalább kettő számlára van szükség. Ha módosítani vagy szerkeszteni szeretné a számla aktuális egyenlegét, kattintson a szerkesztés gombra.';
		map['transfer.form.from'] = 'Eredeti számla';
		map['transfer.form.to'] = 'Célszámla';
		map['transfer.form.value_in_destiny.title'] = 'A rendeltetési helyre átutalt összeg';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} a célszámlához';
		map['recurrent_transactions.title'] = 'Ismétlődő tranzakciók';
		map['recurrent_transactions.title_short'] = 'Ism. tranzakciók';
		map['recurrent_transactions.empty'] = 'Úgy tűnik, hogy nincsenek ismétlődő tranzakciói. Hozzon létre havi, éves vagy heti ismétlődő tranzakciót, és az itt fog megjelenni.';
		map['recurrent_transactions.total_expense_title'] = 'Összes kiadás periódusonként';
		map['recurrent_transactions.total_expense_descr'] = '* Az egyes ismétlődések kezdő és befejező időpontjának figyelembevétele nélkül';
		map['recurrent_transactions.details.title'] = 'Ismétlődő tranzakció';
		map['recurrent_transactions.details.descr'] = 'A tranzakció következő lépései az alábbiakban láthatók. Elfogadhatja az első lépést, vagy kihagyhatja ezt a lépést.';
		map['recurrent_transactions.details.last_payment_info'] = 'Ez a mozgatás az utolsó az ismétlődő szabályban, így ez a szabály automatikusan törlődik a művelet megerősítésekor.';
		map['recurrent_transactions.details.delete_header'] = 'Ismétlődő tranzakció törlése';
		map['recurrent_transactions.details.delete_message'] = 'Ez a művelet visszafordíthatatlan, és nem érinti a már visszaigazolt/befizetett tranzakciókat.';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => 'Késés: ${x}d';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => '${x} napon belül';
		map['account.details'] = 'Számlaadatok';
		map['account.date'] = 'Megnyitás dátuma';
		map['account.close_date'] = 'Lezárás dátuma';
		map['account.reopen'] = 'Számla újranyitása';
		map['account.reopen_short'] = 'Újranyitás';
		map['account.reopen_descr'] = 'Biztos, hogy újra meg akarja nyitni ezt a számlát?';
		map['account.balance'] = 'Számlaegyenleg';
		map['account.n_transactions'] = 'Tranzakciók száma';
		map['account.add_money'] = 'Hozzáadás';
		map['account.withdraw_money'] = 'Pénzfelvétel';
		map['account.no_accounts'] = 'Nem található itt megjeleníthető tranzakció. Adjon hozzá egy tranzakciót az alul található „+” gombra kattintva.';
		map['account.types.title'] = 'Számlatípus';
		map['account.types.warning'] = 'A számlatípus kiválasztása után az a jövőben nem változtatható meg.';
		map['account.types.normal'] = 'Normál számla';
		map['account.types.normal_descr'] = 'Hasznos a napi pénzügyek rögzítéséhez. Ez a leggyakoribb számla, amely lehetővé teszi kiadások, bevételek hozzáadását...';
		map['account.types.saving'] = 'Megtakarítási számla';
		map['account.types.saving_descr'] = 'Csak más számlákról tud pénzt hozzáadni és kivenni belőle. Tökéletes a megtakarítás megkezdéséhez.';
		map['account.form.name'] = 'Számla neve';
		map['account.form.name_placeholder'] = 'Pl.: Megtakarítási számla';
		map['account.form.notes'] = 'Megjegyzések';
		map['account.form.notes_placeholder'] = 'Írjon néhány megjegyzést/leírást erről a számláról.';
		map['account.form.initial_balance'] = 'Kezdőegyenleg';
		map['account.form.current_balance'] = 'Aktuális egyenleg';
		map['account.form.create'] = 'Számla létrehozása';
		map['account.form.edit'] = 'Számla szerkesztése';
		map['account.form.currency_not_found_warn'] = 'Nincs információja ennek a pénznemnek az árfolyamairól. 1,0 lesz az alapértelmezett átváltási árfolyam. Ezt a beállításokban tudja majd módosítani.';
		map['account.form.already_exists'] = 'Ugyanezzel a névvel már van egy másik is. Kérjük, adjon meg egy másikat.';
		map['account.form.tr_before_opening_date'] = 'A számlán a nyitási dátumot megelőző dátumú tranzakciók vannak.';
		map['account.form.iban'] = 'IBAN';
		map['account.form.swift'] = 'SWIFT';
		map['account.delete.warning_header'] = 'Törli a számlát?';
		map['account.delete.warning_text'] = 'Ez a művelet törli ezt a számlát és annak az összes tranzakcióját.';
		map['account.delete.success'] = 'A számla sikeresen törlésre került';
		map['account.close.title'] = 'Számla lezárása';
		map['account.close.title_short'] = 'Lezárás';
		map['account.close.warn'] = 'Ez a számla többé nem jelenik meg bizonyos listákban, és nem tud benne tranzakciókat létrehozni az alább megadott dátumnál későbbi dátummal. Ez a művelet semmilyen tranzakciót vagy egyenleget nem érint, és ezt a számlát bármikor újra megnyithatja. ';
		map['account.close.should_have_zero_balance'] = 'A számla lezárásához 0-nak kell lennie az aktuális egyenlegnek. Kérjük, a folytatás előtt szerkessze át a számlát.';
		map['account.close.should_have_no_transactions'] = 'Ez a számla a megadott zárási dátumot követő tranzakciókat tartalmaz. Törölje őket, vagy szerkessze a számla zárási dátumát, mielőtt folytatná.';
		map['account.close.success'] = 'A számla sikeresen lezárva';
		map['account.close.unarchive_succes'] = 'A számla sikeresen újranyitásra került';
		map['account.select.one'] = 'Egy számla kiválasztása';
		map['account.select.all'] = 'Összes számla';
		map['account.select.multiple'] = 'Számlák kiválasztása';
		map['currencies.currency_converter'] = 'Valutaváltó';
		map['currencies.currency'] = 'Pénznem';
		map['currencies.currency_settings'] = 'Pénznem beállítások';
		map['currencies.currency_manager'] = 'Valutakezelő';
		map['currencies.currency_manager_descr'] = 'Konfigurálja a pénznemet és annak árfolyamait másokkal együtt';
		map['currencies.preferred_currency'] = 'Kedvelt/alap pénznem';
		map['currencies.tap_to_change_preferred_currency'] = 'Érintse meg a módosításhoz';
		map['currencies.change_preferred_currency_title'] = 'Kedvelt pénznem módosítása';
		map['currencies.change_preferred_currency_msg'] = 'Mostantól minden statisztika és költségvetés ebben a pénznemben jelenik meg. A számlák és tranzakciók megtartják a korábbi pénznemet. Minden elmentett árfolyam törlődik, ha ezt a műveletet végrehajtja. Szeretné folytatni?';
		map['currencies.exchange_rate_form.equal_to_preferred_warn'] = 'A pénznem nem lehet azonos a felhasználói pénznemmel';
		map['currencies.exchange_rate_form.override_existing_warn'] = 'Ebben a dátumban már létezik árfolyam ehhez a pénznemhez. Ha folytatja, az előző felülírásra kerül';
		map['currencies.exchange_rate_form.specify_a_currency'] = 'Kérjük, adjon meg egy pénznemet';
		map['currencies.exchange_rate_form.add'] = 'Árfolyam hozzáadása';
		map['currencies.exchange_rate_form.add_success'] = 'Az árfolyam sikeresen hozzáadva';
		map['currencies.exchange_rate_form.edit'] = 'Árfolyam szerkesztése';
		map['currencies.exchange_rate_form.edit_success'] = 'Az árfolyam szerkesztése sikerült';
		map['currencies.exchange_rate_form.remove_all'] = 'Törölje az összes árfolyamot';
		map['currencies.exchange_rate_form.remove_all_warning'] = 'Ez a művelet visszafordíthatatlan, és törli az összes átváltási árfolyamot ehhez a pénznemhez';
		map['currencies.types.display'] = 'Pénznem típusa';
		map['currencies.types.fiat'] = 'FIAT';
		map['currencies.types.crypto'] = 'Kriptovaluta';
		map['currencies.types.other'] = 'Más';
		map['currencies.currency_form.name'] = 'Megjelenítési név';
		map['currencies.currency_form.code'] = 'Pénznem kódja';
		map['currencies.currency_form.symbol'] = 'Szimbólum';
		map['currencies.currency_form.decimal_digits'] = 'Tizedesjegyek';
		map['currencies.currency_form.create'] = 'Pénznem létrehozása';
		map['currencies.currency_form.create_success'] = 'A pénznem sikeresen létrehozva';
		map['currencies.currency_form.edit'] = 'Pénznem szerkesztése';
		map['currencies.currency_form.edit_success'] = 'A pénznem sikeresen szerkesztve';
		map['currencies.currency_form.delete'] = 'Pénznem törlése';
		map['currencies.currency_form.delete_success'] = 'A pénznem sikeresen törölve';
		map['currencies.currency_form.already_exists'] = 'Már létezik ilyen kóddal rendelkező pénznem. Érdemes lehet szerkeszteni';
		map['currencies.delete_all_success'] = 'Az árfolyamok sikeresen törlésre kerültek';
		map['currencies.historical'] = 'Árfolyamtörténetek';
		map['currencies.historical_empty'] = 'Ehhez a pénznemhez nem található történelmi átváltási árfolyam';
		map['currencies.exchange_rate'] = 'Árfolyam';
		map['currencies.exchange_rates'] = 'Árfolyamok';
		map['currencies.min_exchange_rate'] = 'Minimális árfolyam';
		map['currencies.max_exchange_rate'] = 'Maximális árfolyam';
		map['currencies.empty'] = 'Adja hozzá az árfolyamokat, hogy ha az alapvalutától eltérő valutában vezetett számlái vannak, és így a grafikonok pontosabbak legyenek.';
		map['currencies.select_a_currency'] = 'Válasszon ki egy pénznemet';
		map['currencies.search'] = 'Keresés név vagy pénznemkód alapján';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: 'Felirat',
				other: 'Címkék',
			);
		map['tags.form.name'] = 'Címke neve';
		map['tags.form.description'] = 'Leírás';
		map['tags.select.title'] = 'Címke kiválasztása';
		map['tags.select.all'] = 'Minden címke';
		map['tags.empty_list'] = 'Még nem hozott létre címkéket. A címkék és kategóriák nagyszerű lehetőséget kínálnak a pénzmozgások kategorizálására.';
		map['tags.without_tags'] = 'Címkék nélkül';
		map['tags.add'] = 'Hozzáadás';
		map['tags.create'] = 'Felirat készítése';
		map['tags.create_success'] = 'A felirat sikeresen létrehozva';
		map['tags.already_exists'] = 'Ez a címkenév már létezik. Érdemes lehet átszerkeszteni';
		map['tags.edit'] = 'Címke szerkesztése';
		map['tags.edit_success'] = 'A címke sikeresen szerkesztésre került';
		map['tags.delete_success'] = 'A kategória sikeresen törölve';
		map['tags.delete_warning_header'] = 'Törli a címkét?';
		map['tags.delete_warning_message'] = 'Ez a művelet nem törli az ezzel a címkével rendelkező tranzakciókat.';
		map['categories.unknown'] = 'Ismeretlen kategória';
		map['categories.create'] = 'Kategória létrehozása';
		map['categories.create_success'] = 'A kategória sikeresen létrehozva';
		map['categories.new_category'] = 'Új kategória';
		map['categories.already_exists'] = 'Ez a kategórianév már létezik. Talán szeretné szerkeszteni?';
		map['categories.edit'] = 'Kategória szerkesztése';
		map['categories.edit_success'] = 'A kategória sikeresen szerkesztve lett';
		map['categories.name'] = 'Kategória neve';
		map['categories.type'] = 'Kategória típusa';
		map['categories.both_types'] = 'Mindkét típus';
		map['categories.subcategories'] = 'Alkategóriák';
		map['categories.subcategories_add'] = 'Hozzáadás';
		map['categories.make_parent'] = 'Kategória létrehozása';
		map['categories.make_child'] = 'Alkategória létrehozása';
		map['categories.make_child_warning1'] = ({required Object destiny}) => 'Ez a kategória és alkategóriái a(z) <b>${destiny}</b> alkategóriái lesznek.';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => 'A tranzakcióik <b>(${x})</b> átkerülnek a(z) <b>${destiny}</b> kategóriában létrehozott új alkategóriákba.';
		map['categories.make_child_success'] = 'Az alkategóriák sikeresen létrehozva';
		map['categories.merge'] = 'Összevonás másik kategóriával';
		map['categories.merge_warning1'] = ({required Object from, required Object x, required Object destiny}) => 'A(z) <b>${from}</b> kategóriához tartozó összes tranzakció (${x}) átkerül a(z) <b>${destiny}</b> kategóriába.';
		map['categories.merge_warning2'] = ({required Object from}) => 'A(z) <b>${from}</b> kategória visszafordíthatatlanul törlésre kerül.';
		map['categories.merge_success'] = 'A kategória sikeresen egyesítve';
		map['categories.delete_success'] = 'A kategória sikeresen törölve';
		map['categories.delete_warning_header'] = 'Törli a kategóriát?';
		map['categories.delete_warning_message'] = ({required Object x}) => 'Ez a művelet visszafordíthatatlanul törli az összes <b>(${x})</b> tranzakciót, amely ehhez a kategóriához kapcsolódik.';
		map['categories.select.title'] = 'Kategóriák kiválasztása';
		map['categories.select.select_one'] = 'Kategória kiválasztása';
		map['categories.select.select_subcategory'] = 'Alkategória kiválasztása';
		map['categories.select.without_subcategory'] = 'Alkategória nélkül';
		map['categories.select.all'] = 'Összes kategória';
		map['categories.select.all_short'] = 'Mind';
		map['budgets.title'] = 'Költségvetések';
		map['budgets.status'] = 'Költségkeret állapota';
		map['budgets.repeated'] = 'Ismétlődő';
		map['budgets.one_time'] = 'Egyszer';
		map['budgets.actives'] = 'Aktívok';
		map['budgets.from_budgeted'] = 'maradt ';
		map['budgets.days_left'] = 'nap van hátra';
		map['budgets.days_to_start'] = 'nap van a kezdésig';
		map['budgets.since_expiration'] = 'napja lejárt';
		map['budgets.no_budgets'] = 'Úgy tűnik, hogy ebben a szakaszban nincs megjelenítendő költségvetés. Kezdje a költségvetés létrehozásával az alábbi gombra kattintva.';
		map['budgets.delete'] = 'Költségvetés törlése';
		map['budgets.delete_warning'] = 'Ez a művelet visszafordíthatatlan. Az erre az ajánlatra hivatkozó kategóriák és tranzakciók nem törlődnek.';
		map['budgets.form.title'] = 'Hozzáadás';
		map['budgets.form.name'] = 'Költségvetés neve';
		map['budgets.form.value'] = 'Mennyiségkorlátozás';
		map['budgets.form.create'] = 'Hozzáadás';
		map['budgets.form.create_success'] = 'A költségkeret sikeresen létrehozva';
		map['budgets.form.edit'] = 'Szerkesztés';
		map['budgets.form.edit_success'] = 'A költségvetés szerkesztése sikeresen megtörtént';
		map['budgets.form.negative_warn'] = 'A költségvetések nem lehetnek negatív összegűek.';
		map['budgets.details.title'] = 'Költségvetés részletei';
		map['budgets.details.statistics'] = 'Statisztika';
		map['budgets.details.budget_value'] = 'Költségvetésben';
		map['budgets.details.expend_evolution'] = 'Költségek alakulása';
		map['budgets.details.no_transactions'] = 'Úgy tűnik, hogy ezzel a költségvetéssel kapcsolatban semmilyen kiadást nem teljesített.';
		map['budgets.target_timeline_statuses.active'] = 'Aktív költségvetés';
		map['budgets.target_timeline_statuses.past'] = 'Befejezett költségvetés';
		map['budgets.target_timeline_statuses.future'] = 'Jövőbeli költségvetés';
		map['budgets.progress.labels.active_on_track'] = 'Terv szerint';
		map['budgets.progress.labels.active_overspending'] = 'Túlköltekezés';
		map['budgets.progress.labels.active_indeterminate'] = 'Aktív';
		map['budgets.progress.labels.success'] = 'Teljesítve';
		map['budgets.progress.labels.fail'] = 'Költségvetés túllépve';
		map['budgets.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'Naponta ${dailyAmount} összeget költhet a hátralévő ${remainingDays} napban';
		map['budgets.progress.description.active_overspending'] = ({required Object dailyAmount, required Object remainingDays}) => 'Hogy visszatérjen a tervhez, korlátoznia kell kiadásait napi ${dailyAmount} összegre a hátralévő ${remainingDays} napban';
		map['budgets.progress.description.active_indeterminate'] = ({required Object amount}) => 'Még ${amount} elkölthető.';
		map['budgets.progress.description.active_exceeded'] = ({required Object amount}) => 'Már túllépte a költségvetési keretet ${amount} összeggel. Ha nem talál bevételt ehhez a költségvetéshez, abba kell hagynia a költekezést az időszak hátralévő részében';
		map['budgets.progress.description.success'] = 'Szép munka! Ez a költségvetés sikeresen lezárult. Hozzon létre további költségvetéseket kiadásai kezeléséhez';
		map['budgets.progress.description.fail'] = ({required Object amount}) => 'Túllépte a költségvetést ${amount} összeggel. Próbáljon meg óvatosabb lenni legközelebb!';
		map['goals.title'] = 'Célok';
		map['goals.status'] = 'A cél állapota';
		map['goals.type.display'] = 'Cél típusa';
		map['goals.type.income.title'] = 'Megtakarítási cél';
		map['goals.type.income.descr'] = 'Ideális pénzmegtakarításhoz. Akkor sikeres, ha az egyenleg meghaladja a célösszeget.';
		map['goals.type.expense.title'] = 'Költési cél';
		map['goals.type.expense.descr'] = 'Kövesse nyomon kiadásait, és próbáljon meg elérni egy célösszeget. Jól használható adományokhoz...';
		map['goals.empty_title'] = 'Nincsenek célok';
		map['goals.empty_description'] = 'Hozzon létre új célt megtakarításai követéséhez!';
		map['goals.delete'] = 'Cél törlése';
		map['goals.delete_warning'] = 'Ez a művelet visszafordíthatatlan. A célhoz kapcsolódó kategóriák és tranzakciók nem törlődnek';
		map['goals.form.new_title'] = 'Új cél';
		map['goals.form.edit_title'] = 'Cél szerkesztése';
		map['goals.form.target_amount'] = 'Célösszeg';
		map['goals.form.initial_amount'] = 'Kezdő összeg';
		map['goals.form.name'] = 'Név';
		map['goals.form.name_hint'] = 'Megtakarítási célom';
		map['goals.form.create_success'] = 'Cél sikeresen létrehozva';
		map['goals.form.edit_success'] = 'Cél sikeresen szerkesztve';
		map['goals.form.negative_warn'] = 'A cél összege nem lehet negatív';
		map['goals.details.title'] = 'Cél részletei';
		map['goals.details.statistics'] = 'Statisztikák';
		map['goals.details.goal_value'] = 'Célérték';
		map['goals.details.evolution'] = 'Fejlődés';
		map['goals.details.no_transactions'] = 'Úgy tűnik, nem hajtott végre ehhez a célhoz kapcsolódó tranzakciót';
		map['goals.target_timeline_statuses.active'] = 'Aktív cél';
		map['goals.target_timeline_statuses.past'] = 'Befejezett cél';
		map['goals.target_timeline_statuses.future'] = 'Jövőbeli cél';
		map['goals.progress.labels.active_on_track'] = 'Pályán';
		map['goals.progress.labels.active_behind_schedule'] = 'A menetrend lemaradásával';
		map['goals.progress.labels.active_indeterminate'] = 'Aktív';
		map['goals.progress.labels.success'] = 'A cél elérve';
		map['goals.progress.labels.fail'] = 'A gól nem sikerült';
		map['goals.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'Jó úton haladsz a cél felé! Naponta ${dailyAmount} összeget kell megtakarítania a fennmaradó ${remainingDays} napig';
		map['goals.progress.description.active_behind_schedule'] = ({required Object dailyAmount, required Object remainingDays}) => 'Lemaradsz a menetrendről. Naponta ${dailyAmount} összeget kell megtakarítania, hogy ${remainingDays} napon belül elérje célját';
		map['goals.progress.description.active_indeterminate'] = ({required Object amount}) => 'További ${amount} kell a cél eléréséhez.';
		map['goals.progress.description.success'] = 'Gratulálok! Elérted a célodat.';
		map['goals.progress.description.fail'] = ({required Object amount}) => '${amount} értékkel eltévesztette a célt.';
		map['target_timeline_statuses.active'] = 'Aktív';
		map['target_timeline_statuses.past'] = 'Befejezve';
		map['target_timeline_statuses.future'] = 'Jövő';
		map['backup.no_file_selected'] = 'Nincs kiválasztva fájl';
		map['backup.no_directory_selected'] = 'Nincs kiválasztott könyvtár';
		map['backup.export.title'] = 'Adatok exportálása';
		map['backup.export.title_short'] = 'Exportálás';
		map['backup.export.type_of_export'] = 'Az export típusa';
		map['backup.export.other_options'] = 'Opciók';
		map['backup.export.all'] = 'Teljes mentés';
		map['backup.export.all_descr'] = 'Exportálja az összes adatát (számlák, tranzakciók, költségvetések, beállítások...). Bármikor újra importálhatja őket, így semmit sem veszíthet el.';
		map['backup.export.transactions'] = 'Tranzakciók mentése';
		map['backup.export.transactions_descr'] = 'Exportálja tranzakcióit CSV formátumban, így könnyebben elemezheti azokat más programokban vagy alkalmazásokban.';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hu'))(n,
				one: '1 exportálandó tranzakció',
				other: '${n} exportálandó tranzakció',
			);
		map['backup.export.description'] = 'Adatok letöltése különböző formátumokban';
		map['backup.export.send_file'] = 'Fájl küldése';
		map['backup.export.see_folder'] = 'Lásd a mappát';
		map['backup.export.success'] = ({required Object x}) => 'A fájl sikeresen mentve/letöltve ide: ${x}';
		map['backup.export.error'] = 'Hiba a fájl letöltésében. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
		map['backup.export.dialog_title'] = 'Fájl mentése/küldése';
		map['backup.import.title'] = 'Adatok importálása';
		map['backup.import.title_short'] = 'Importálás';
		map['backup.import.restore_backup'] = 'Mentés visszaállítása';
		map['backup.import.restore_backup_descr'] = 'Importáljon egy korábban mentett adatbázist a Monekinből. Ez a művelet minden jelenlegi alkalmazásadatot lecseréli az új adatokra.';
		map['backup.import.restore_backup_warn_description'] = 'Új adatbázis importálásakor az alkalmazásban jelenleg mentett összes adat elveszik. A folytatás előtt ajánlatos biztonsági másolatot készíteni. Ne töltsön fel ide olyan fájlt, amelynek eredetét nem ismeri, csak azokat a fájlokat töltse fel, amelyeket korábban letöltött a Monekin oldaláról.';
		map['backup.import.restore_backup_warn_title'] = 'Az összes adat felülírása';
		map['backup.import.select_other_file'] = 'Másik fájl kiválasztása';
		map['backup.import.tap_to_select_file'] = 'Koppintson a fájl kiválasztásához';
		map['backup.import.manual_import.title'] = 'Kézi importálás';
		map['backup.import.manual_import.descr'] = 'Tranzakciók kézi importálása egy .csv fájlból';
		map['backup.import.manual_import.default_account'] = 'Alapértelm. számla';
		map['backup.import.manual_import.remove_default_account'] = 'Alapértelmezett számla törlése';
		map['backup.import.manual_import.default_category'] = 'Alapértelm. kategória';
		map['backup.import.manual_import.select_a_column'] = 'Válasszon ki egy oszlopot a .csv fájlból';
		map['backup.import.manual_import.steps.0'] = 'Fájl kiválasztása';
		map['backup.import.manual_import.steps.1'] = 'Mennyiség oszlop';
		map['backup.import.manual_import.steps.2'] = 'Számlaoszlop';
		map['backup.import.manual_import.steps.3'] = 'Kategória oszlop';
		map['backup.import.manual_import.steps.4'] = 'Dátum oszlop';
		map['backup.import.manual_import.steps.5'] = 'egyéb oszlopok';
		map['backup.import.manual_import.steps_descr.0'] = 'Válasszon ki egy .csv fájlt az eszközről. Győződjön meg arról, hogy van egy első sora, amely leírja az egyes oszlopok nevét.';
		map['backup.import.manual_import.steps_descr.1'] = 'Válassza ki azt az oszlopot, amelyben az egyes tranzakciók dátuma meg van adva. Ha nincs megadva, a tranzakciók az aktuális dátummal jönnek létre. Válassza ki azt az oszlopot, ahol az egyes tranzakciók értéke meg van adva. Használjon negatív értékeket a kiadásokhoz és pozitív értékeket a bevételekhez. Használjon pontot tizedeselválasztóként.';
		map['backup.import.manual_import.steps_descr.2'] = 'Válassza ki azt az oszlopot, amelyben meg van adva az a számla, amelyhez az egyes tranzakciók tartoznak. Kiválaszthat egy alapértelmezett fiókot is arra az esetre, ha nem találnánk a kívánt fiókot. Ha nincs megadva alapértelmezett fiók, akkor létrehozunk egyet ugyanazzal a névvel. ';
		map['backup.import.manual_import.steps_descr.3'] = 'Adja meg azt az oszlopot, ahol a tranzakciókategória neve található. Meg kell adnia egy alapértelmezett kategóriát, hogy ezt a kategóriát rendeljük hozzá a tranzakciókhoz, ha a kategória nem található.';
		map['backup.import.manual_import.steps_descr.4'] = 'Válassza ki azt az oszlopot, amelyben az egyes tranzakciók dátuma meg van adva. Ha nincs megadva, a tranzakciók az aktuális dátummal jönnek létre.';
		map['backup.import.manual_import.steps_descr.5'] = 'Az egyéb opcionális tranzakciós attribútumok oszlopainak meghatározása';
		map['backup.import.manual_import.success'] = ({required Object x}) => '${x} tranzakció sikeresen importálva';
		map['backup.import.success'] = 'Az importálás sikeresen végrehajtva';
		map['backup.import.error'] = 'Hiba történt importálásakor. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
		map['backup.import.cancelled'] = 'Az importálást a felhasználó megszakította';
		map['backup.about.title'] = 'Információk az adatbázisról';
		map['backup.about.create_date'] = 'Létrehozás dátuma';
		map['backup.about.modify_date'] = 'Utolsó módosítása';
		map['backup.about.last_backup'] = 'Utolsó mentés';
		map['backup.about.size'] = 'Méret';
		map['settings.title_long'] = 'Beállítások és Testreszabás';
		map['settings.title_short'] = 'Beállítások';
		map['settings.description'] = 'Téma, Nyelv, Adatok és egyebek';
		map['settings.edit_profile'] = 'Profil szerkesztése';
		map['settings.general.menu_title'] = 'Általános beállítások';
		map['settings.general.menu_descr'] = 'Nyelv, adatvédelem és egyebek';
		map['settings.general.show_all_decimals'] = 'Összes tizedesjegy mutatása';
		map['settings.general.show_all_decimals_descr'] = 'Minden tizedesjegy megjelenítése, még akkor is, ha nullára végződik';
		map['settings.general.language.section'] = 'Nyelv és szövegek';
		map['settings.general.language.title'] = 'Alkalmazás nyelve';
		map['settings.general.language.descr'] = 'Nyelv, amelyen a szövegek megjelennek az alkalmazásban';
		map['settings.general.language.help'] = 'Ha együttműködni szeretne ennek az alkalmazásnak a fordításával, tekintse meg a <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'> útmutatónk</a>';
		map['settings.general.locale.title'] = 'Régió';
		map['settings.general.locale.auto'] = 'Rendszer';
		map['settings.general.locale.descr'] = 'Dátumok, számformátumok beállítása...';
		map['settings.general.locale.warn'] = 'Régióváltáskor az alkalmazás frissülni fog';
		map['settings.general.locale.first_day_of_week'] = 'A hét első napja';
		map['settings.security.title'] = 'Biztonság';
		map['settings.security.private_mode_at_launch'] = 'Privát mód indításkor';
		map['settings.security.private_mode_at_launch_descr'] = 'Az alkalmazás alapértelmezés szerinti indítása privát módban';
		map['settings.security.private_mode'] = 'Privát mód';
		map['settings.security.private_mode_descr'] = 'Minden pénzösszeg elrejtése';
		map['settings.security.private_mode_activated'] = 'Privát mód aktiválva';
		map['settings.security.private_mode_deactivated'] = 'Privát mód letiltva';
		map['settings.transactions.menu_title'] = 'Tranzakciók';
		map['settings.transactions.menu_descr'] = 'Konfigurálja tranzakciói viselkedését';
		map['settings.transactions.title'] = 'Tranzakciós beállítások';
		map['settings.transactions.style.title'] = 'Tranzakció stílusa';
		map['settings.transactions.style.subtitle'] = 'Állítsa be, hogyan jelenjenek meg a tranzakciók a listákban';
		map['settings.transactions.style.show_tags'] = 'Címkék mutatása';
		map['settings.transactions.style.show_time'] = 'Idő mutatása';
		map['settings.transactions.swipe_actions.title'] = 'Csúsztatási műveletek';
		map['settings.transactions.swipe_actions.choose_description'] = 'Válassza ki, hogy milyen művelet induljon el, ha a listában lévő tranzakciós tételt ezzel a csúsztatási irány segítségével csúsztatja';
		map['settings.transactions.swipe_actions.swipe_left'] = 'Csúsztasson balra';
		map['settings.transactions.swipe_actions.swipe_right'] = 'Csúsztasson jobbra';
		map['settings.transactions.swipe_actions.none'] = 'Nincs akció';
		map['settings.transactions.swipe_actions.toggle_reconciled'] = 'Váltás egyeztetve';
		map['settings.transactions.swipe_actions.toggle_pending'] = 'Váltás függőben';
		map['settings.transactions.swipe_actions.toggle_voided'] = 'Váltó érvénytelenítve';
		map['settings.transactions.swipe_actions.toggle_unreconciled'] = 'Váltás nem egyeztetve';
		map['settings.transactions.swipe_actions.remove_status'] = 'Állapot eltávolítása';
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
		map['settings.appearance.menu_title'] = 'Téma és stílus';
		map['settings.appearance.menu_descr'] = 'Témaválasztás, színek és egyéb, az alkalmazás megjelenésével kapcsolatos dolgok';
		map['settings.appearance.theme_and_colors'] = 'Témák és színek';
		map['settings.appearance.theme.title'] = 'Téma';
		map['settings.appearance.theme.auto'] = 'Rendszer';
		map['settings.appearance.theme.light'] = 'Világos';
		map['settings.appearance.theme.dark'] = 'Sötét';
		map['settings.appearance.amoled_mode'] = 'AMOLED mód';
		map['settings.appearance.amoled_mode_descr'] = 'Ha lehetséges, használjon tiszta fekete háttérképet. Ez némileg segíti az AMOLED képernyővel rendelkező készülékek akkumulátorát.';
		map['settings.appearance.dynamic_colors'] = 'Dinamikus színek';
		map['settings.appearance.dynamic_colors_descr'] = 'Amikor csak lehetséges, használja a rendszer kiemelő színét';
		map['settings.appearance.accent_color'] = 'Kiemelő szín';
		map['settings.appearance.accent_color_descr'] = 'Válassza ki, hogy az alkalmazás milyen színnel emelje ki a felület bizonyos részeit';
		map['settings.appearance.text'] = 'Szöveg';
		map['settings.appearance.font'] = 'Betűtípus';
		map['settings.appearance.font_platform'] = 'Platform';
		map['more.title'] = 'Továbbiak';
		map['more.title_long'] = 'További műveletek';
		map['more.data.display'] = 'Adatok';
		map['more.data.display_descr'] = 'Exportálja és importálja az adatait, hogy ne veszítsen el semmit se';
		map['more.data.delete_all'] = 'Adataim törlése';
		map['more.data.delete_all_header1'] = 'Álljon meg ⚠️⚠️';
		map['more.data.delete_all_message1'] = 'Biztosan benne, hogy folytatja? Minden adata véglegesen törlődik, és nem állítható vissza';
		map['more.data.delete_all_header2'] = 'Még egy utolsó lépés ⚠️⚠️';
		map['more.data.delete_all_message2'] = 'A fiók törlésével törli az összes tárolt személyes adatát. A számlái, tranzakciói, költségvetései és kategóriái törlődnek, és nem állíthatók helyre. Egyetért ezzel?';
		map['more.about_us.display'] = 'Alkalmazásinformációk';
		map['more.about_us.description'] = 'Találja meg a Monekin feltételeit, fontos információkat, és lépjen kapcsolatba hibák bejelentésével vagy ötletek megosztásával';
		map['more.about_us.legal.display'] = 'Jogi információk';
		map['more.about_us.legal.privacy'] = 'Adatvédelem';
		map['more.about_us.legal.terms'] = 'Használati feltételek';
		map['more.about_us.legal.licenses'] = 'Licencek';
		map['more.about_us.project.display'] = 'Projekt';
		map['more.about_us.project.contributors'] = 'Közreműködők';
		map['more.about_us.project.contributors_descr'] = 'Az összes fejlesztő, akik hozzájárultak a Monekin létrehozásához';
		map['more.about_us.project.contact'] = 'Kapcsolatfelvétel';
		map['more.help_us.display'] = 'Segítsen nekünk';
		map['more.help_us.description'] = 'Tudja meg, hogyan segíthet a Monekinnek abban, hogy egyre jobb és jobb legyen';
		map['more.help_us.rate_us'] = 'Értékeljen minket';
		map['more.help_us.rate_us_descr'] = 'Bármilyen értékelést szívesen fogadunk!';
		map['more.help_us.share'] = 'Monekin megosztása';
		map['more.help_us.share_descr'] = 'Ossza meg alkalmazásunkat a barátaival és a családtagjaival';
		map['more.help_us.share_text'] = 'Monekin! A legjobb személyes pénzügyi alkalmazás. Töltse le innen';
		map['more.help_us.thanks'] = 'Köszönjük!';
		map['more.help_us.thanks_long'] = 'Az Ön hozzájárulása a Monekinhez és más nyílt forráskódú projektekhez, legyen az kicsi vagy nagy, lehetővé teszi az ehhez hasonló nagyszerű projekteket. Köszönjük, hogy időt szán a közreműködésre.';
		map['more.help_us.donate'] = 'Adományozás';
		map['more.help_us.donate_descr'] = 'Az adományával segít az alkalmazás további fejlesztésében. Mi lehetne jobb módja, mint megköszönni az elvégzett munkát egy kávéra való meghívással?';
		map['more.help_us.donate_success'] = 'Az adományozás megtörtént. Köszönöm szépen a közreműködését! ❤️';
		map['more.help_us.donate_err'] = 'Hoppá! Úgy tűnik, hiba történt a fizetés fogadásakor';
		map['more.help_us.report'] = 'Hibák jelentése, javaslatok...';

		_map = map;
		return map;
	}
}


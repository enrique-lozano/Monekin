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
	TranslationsHu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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

	late final TranslationsHu _root = this; // ignore: unused_field

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
	@override String get details => 'Részletek';
	@override String get share => 'Megosztás';
  @override String get none => 'Egyik sem';
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
	@override String get balance => 'Egyenleg';
	@override String get account => 'Számla';
	@override String get accounts => 'Számlák';
	@override String get categories => 'Kategóriák';
	@override String get category => 'Kategória';
	@override String get today => 'Ma';
	@override String get yesterday => 'Tegnap';
	@override String get filters => 'Szűrők';
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
class _TranslationsBackupHu implements TranslationsBackupEn {
	_TranslationsBackupHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportHu export = _TranslationsBackupExportHu._(_root);
	@override late final _TranslationsBackupImportHu import = _TranslationsBackupImportHu._(_root);
	@override late final _TranslationsBackupAboutHu about = _TranslationsBackupAboutHu._(_root);
}

// Path: settings
class _TranslationsSettingsHu implements TranslationsSettingsEn {
	_TranslationsSettingsHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
	@override String get theme_auto => 'Rendszer';
	@override String get theme_light => 'Világos';
	@override String get theme_dark => 'Sötét';
	@override String get amoled_mode => 'AMOLED mód';
	@override String get amoled_mode_descr => 'Ha lehetséges, használjon tiszta fekete háttérképet. Ez némileg segíti az AMOLED képernyővel rendelkező készülékek akkumulátorát.';
	@override String get dynamic_colors => 'Dinamikus színek';
	@override String get dynamic_colors_descr => 'Amikor csak lehetséges, használja a rendszer kiemelő színét';
	@override String get accent_color => 'Kiemelő szín';
	@override String get accent_color_descr => 'Válassza ki, hogy az alkalmazás milyen színnel emelje ki a felület bizonyos részeit';
	@override	String get swipe_title => 'Csúsztatási műveletek';
  @override String get swipe_right => 'Csúsztassa jobbra';
  @override String get swipe_left => 'Csúsztassa balra';
  @override late final _TranslationsSettingsSecurityHu security = _TranslationsSettingsSecurityHu._(_root);
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
	@override String get from_value => 'Ebből az összegből';
	@override String get to_value => 'Eddig az összegig';
	@override String from_value_def({required Object x}) => 'Innen: ${x}';
	@override String to_value_def({required Object x}) => 'Ide: ${x}';
	@override String from_date_def({required Object date}) => 'Ettől: ${date}';
	@override String to_date_def({required Object date}) => 'Eddig: ${date}';
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

// Path: currencies.form
class _TranslationsCurrenciesFormHu implements TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'A pénznem nem lehet azonos a felhasználói pénznemmel';
	@override String get specify_a_currency => 'Kérjük, adjon meg egy pénznemet';
	@override String get add => 'Árfolyam hozzáadása';
	@override String get add_success => 'Az árfolyam sikeresen hozzáadva';
	@override String get edit => 'Árfolyam szerkesztése';
	@override String get edit_success => 'Az árfolyam szerkesztése sikerült';
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
	@override String get edit => 'Szerkesztés';
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
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Naponta ${dailyAmount} -ot költhet el, még ${remainingDays} napig';
	@override String get expend_evolution => 'Költségek alakulása';
	@override String get no_transactions => 'Úgy tűnik, hogy ezzel a költségvetéssel kapcsolatban semmilyen kiadást nem teljesített.';
}

// Path: backup.export
class _TranslationsBackupExportHu implements TranslationsBackupExportEn {
	_TranslationsBackupExportHu._(this._root);

	final TranslationsHu _root; // ignore: unused_field

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
	@override String get cancelled => 'Az importálást a felhasználó megszakította';
	@override String get error => 'Hiba történt importálásakor. Kérjük, lépjen kapcsolatba a fejlesztővel a lozin.technologies@gmail.com címen keresztül.';
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
	@override String get description => 'Nézze meg a Monekinre vonatkozó feltételeket és egyéb fontos információkat. Lépjen kapcsolatba a közösséggel a hibák bejelentésével, javaslatok megtételével...';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsHu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return 'Mégse';
			case 'ui_actions.confirm': return 'Megerősítés';
			case 'ui_actions.continue_text': return 'Folytatás';
			case 'ui_actions.save': return 'Mentés';
			case 'ui_actions.save_changes': return 'Módosítások mentése';
			case 'ui_actions.close_and_save': return 'Mentés és bezárás';
			case 'ui_actions.add': return 'Hozzáad';
			case 'ui_actions.edit': return 'Szerkesztés';
			case 'ui_actions.delete': return 'Törlés';
			case 'ui_actions.see_more': return 'Továbbiak megtekintése';
			case 'ui_actions.select_all': return 'Összes kijelölése';
			case 'ui_actions.deselect_all': return 'Összes kijelölésének megszüntetése';
			case 'ui_actions.select': return 'Kiválasztás';
			case 'ui_actions.search': return 'Keresés';
			case 'ui_actions.filter': return 'Szűrés';
			case 'ui_actions.reset': return 'Alaphelyzetbe állítás';
			case 'ui_actions.submit': return 'Beküldés';
			case 'ui_actions.next': return 'Következő';
			case 'ui_actions.previous': return 'Előző';
			case 'ui_actions.back': return 'Vissza';
			case 'ui_actions.reload': return 'Újratöltés';
			case 'ui_actions.view': return 'Megtekintés';
			case 'ui_actions.download': return 'Letöltés';
			case 'ui_actions.upload': return 'Feltöltés';
			case 'ui_actions.retry': return 'Újrapróbálkozás';
			case 'ui_actions.copy': return 'Másolás';
			case 'ui_actions.paste': return 'Beillesztés';
			case 'ui_actions.undo': return 'Visszavonás';
			case 'ui_actions.redo': return 'Újra';
			case 'ui_actions.open': return 'Megnyitás';
			case 'ui_actions.close': return 'Bezárás';
			case 'ui_actions.apply': return 'Alkalmaz';
			case 'ui_actions.discard': return 'Elvetés';
			case 'ui_actions.refresh': return 'Frissítés';
			case 'ui_actions.details': return 'Részletek';
			case 'ui_actions.share': return 'Megosztás';
			case 'general.or': return 'vagy';
			case 'general.understood': return 'Megértve';
			case 'general.unspecified': return 'Meghatározatlan';
			case 'general.quick_actions': return 'Gyorsműveletek';
			case 'general.balance': return 'Egyenleg';
			case 'general.account': return 'Számla';
			case 'general.accounts': return 'Számlák';
			case 'general.categories': return 'Kategóriák';
			case 'general.category': return 'Kategória';
			case 'general.today': return 'Ma';
			case 'general.yesterday': return 'Tegnap';
			case 'general.filters': return 'Szűrők';
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
			case 'settings.theme_auto': return 'Rendszer';
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


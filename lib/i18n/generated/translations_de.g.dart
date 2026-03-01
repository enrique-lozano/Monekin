///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsDe with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsDe ui_actions = _TranslationsUiActionsDe._(_root);
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
	@override late final _TranslationsGoalsDe goals = _TranslationsGoalsDe._(_root);
	@override late final _TranslationsDebtsDe debts = _TranslationsDebtsDe._(_root);
	@override late final _TranslationsTargetTimelineStatusesDe target_timeline_statuses = _TranslationsTargetTimelineStatusesDe._(_root);
	@override late final _TranslationsBackupDe backup = _TranslationsBackupDe._(_root);
	@override late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
	@override late final _TranslationsMoreDe more = _TranslationsMoreDe._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsDe implements TranslationsUiActionsEn {
	_TranslationsUiActionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Abbrechen';
	@override String get confirm => 'Bestätigen';
	@override String get continue_text => 'Weiter';
	@override String get save => 'Speichern';
	@override String get save_changes => 'Änderungen speichern';
	@override String get close_and_save => 'Speichern und schließen';
	@override String get add => 'Hinzufügen';
	@override String get edit => 'Bearbeiten';
	@override String get delete => 'Löschen';
	@override String get see_more => 'Mehr anzeigen';
	@override String get select_all => 'Alles auswählen';
	@override String get deselect_all => 'Alles abwählen';
	@override String get select => 'Auswählen';
	@override String get search => 'Suchen';
	@override String get filter => 'Filtern';
	@override String get reset => 'Zurücksetzen';
	@override String get submit => 'Absenden';
	@override String get next => 'Weiter';
	@override String get previous => 'Zurück';
	@override String get back => 'Zurück';
	@override String get reload => 'Neu laden';
	@override String get view => 'Ansehen';
	@override String get download => 'Herunterladen';
	@override String get upload => 'Hochladen';
	@override String get retry => 'Erneut versuchen';
	@override String get copy => 'Kopieren';
	@override String get paste => 'Einfügen';
	@override String get undo => 'Rückgängig';
	@override String get redo => 'Wiederholen';
	@override String get open => 'Öffnen';
	@override String get close => 'Schließen';
	@override String get apply => 'Anwenden';
	@override String get discard => 'Verwerfen';
	@override String get refresh => 'Aktualisieren';
	@override String get share => 'Teilen';
}

// Path: general
class _TranslationsGeneralDe implements TranslationsGeneralEn {
	_TranslationsGeneralDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get or => 'oder';
	@override String get understood => 'Verstanden';
	@override String get unspecified => 'Nicht spezifiziert';
	@override String get quick_actions => 'Schnelle Aktionen';
	@override String get details => 'Details';
	@override String get balance => 'Kontostand';
	@override String get account => 'Konto';
	@override String get accounts => 'Konten';
	@override String get categories => 'Kategorien';
	@override String get category => 'Kategorie';
	@override String get today => 'Heute';
	@override String get yesterday => 'Gestern';
	@override String get filters => 'Filter';
	@override String get empty_warn => 'Ops! Das ist sehr leer';
	@override String get search_no_results => 'Keine Artikel entsprechen Ihren Suchkriterien';
	@override String get insufficient_data => 'Unzureichende Daten';
	@override String get show_more_fields => 'Weitere Felder anzeigen';
	@override String get show_less_fields => 'Weniger Felder anzeigen';
	@override String get tap_to_search => 'Zum Suchen tippen';
	@override String get delete_success => 'Element erfolgreich gelöscht';
	@override late final _TranslationsGeneralLeaveWithoutSavingDe leave_without_saving = _TranslationsGeneralLeaveWithoutSavingDe._(_root);
	@override late final _TranslationsGeneralClipboardDe clipboard = _TranslationsGeneralClipboardDe._(_root);
	@override late final _TranslationsGeneralTimeDe time = _TranslationsGeneralTimeDe._(_root);
	@override late final _TranslationsGeneralTransactionOrderDe transaction_order = _TranslationsGeneralTransactionOrderDe._(_root);
	@override late final _TranslationsGeneralValidationsDe validations = _TranslationsGeneralValidationsDe._(_root);
}

// Path: intro
class _TranslationsIntroDe implements TranslationsIntroEn {
	_TranslationsIntroDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsHomeDe implements TranslationsHomeEn {
	_TranslationsHomeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsFinancialHealthDe implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Finanzielle Lage';
	@override late final _TranslationsFinancialHealthReviewDe review = _TranslationsFinancialHealthReviewDe._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeDe months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeDe._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageDe savings_percentage = _TranslationsFinancialHealthSavingsPercentageDe._(_root);
}

// Path: stats
class _TranslationsStatsDe implements TranslationsStatsEn {
	_TranslationsStatsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsIconSelectorDe implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsTransactionDe implements TranslationsTransactionEn {
	_TranslationsTransactionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsTransferDe implements TranslationsTransferEn {
	_TranslationsTransferDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsRecurrentTransactionsDe implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsAccountDe implements TranslationsAccountEn {
	_TranslationsAccountDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsCurrenciesDe implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Währungsrechner';
	@override String get currency => 'Währung';
	@override String get currency_settings => 'Währungseinstellungen';
	@override String get currency_manager => 'Währungsmanager';
	@override String get currency_manager_descr => 'Konfiguriere Deine Währung und deren Wechselkurse mit anderen';
	@override String get preferred_currency => 'Bevorzugte/Basis Währung';
	@override String get tap_to_change_preferred_currency => 'Zum Ändern tippen';
	@override String get change_preferred_currency_title => 'Änder die bevorzugte Währung';
	@override String get change_preferred_currency_msg => 'Alle Statistiken und Budgets werden ab sofort in dieser Währung angezeigt. Konten und Transaktionen behalten die Währung, die sie hatten. Alle gespeicherten Wechselkurse werden gelöscht, wenn Du diese Aktion ausführst. Möchtest Du fortfahren?';
	@override late final _TranslationsCurrenciesExchangeRateFormDe exchange_rate_form = _TranslationsCurrenciesExchangeRateFormDe._(_root);
	@override late final _TranslationsCurrenciesTypesDe types = _TranslationsCurrenciesTypesDe._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormDe currency_form = _TranslationsCurrenciesCurrencyFormDe._(_root);
	@override String get delete_all_success => 'Wechselkurse erfolgreich gelöscht';
	@override String get historical => 'Historische Kurse';
	@override String get historical_empty => 'Für diese Währung wurden keine historischen Wechselkurse gefunden';
	@override String get exchange_rate => 'Wechselkurs';
	@override String get exchange_rates => 'Wechselkurse';
	@override String get min_exchange_rate => 'Mindestwechselkurs';
	@override String get max_exchange_rate => 'Maximaler Wechselkurs';
	@override String get empty => 'Füge hier Wechselkurse hinzu, damit unsere Diagramme genauer sind, wenn Du Konten in anderen Währungen als Deiner Basiswährung hast';
	@override String get select_a_currency => 'Wähle eine Währung aus';
	@override String get search => 'Suche nach Name oder Währungscode';
}

// Path: tags
class _TranslationsTagsDe implements TranslationsTagsEn {
	_TranslationsTagsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsCategoriesDe implements TranslationsCategoriesEn {
	_TranslationsCategoriesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsBudgetsDe implements TranslationsBudgetsEn {
	_TranslationsBudgetsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budgets';
	@override String get status => 'Budgetstatus';
	@override String get repeated => 'Wiederkehrend';
	@override String get one_time => 'Einmalig';
	@override String get actives => 'Aktive';
	@override String get from_budgeted => 'übrig von ';
	@override String get days_left => 'Tage übrig';
	@override String get days_to_start => 'Tage bis Start';
	@override String get since_expiration => 'Tage seit Ablauf';
	@override String get no_budgets => 'Es scheint, dass in diesem Abschnitt keine Budgets angezeigt werden können. Beginne mit der Erstellung eines Budgets, indem Du auf die Schaltfläche unten klickst';
	@override String get delete => 'Budget löschen';
	@override String get delete_warning => 'Diese Aktion ist irreversibel. ';
	@override late final _TranslationsBudgetsFormDe form = _TranslationsBudgetsFormDe._(_root);
	@override late final _TranslationsBudgetsDetailsDe details = _TranslationsBudgetsDetailsDe._(_root);
	@override late final _TranslationsBudgetsTargetTimelineStatusesDe target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesDe._(_root);
	@override late final _TranslationsBudgetsProgressDe progress = _TranslationsBudgetsProgressDe._(_root);
}

// Path: goals
class _TranslationsGoalsDe implements TranslationsGoalsEn {
	_TranslationsGoalsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ziele';
	@override String get status => 'Zielstatus';
	@override late final _TranslationsGoalsTypeDe type = _TranslationsGoalsTypeDe._(_root);
	@override String get empty_title => 'Keine Ziele gefunden';
	@override String get empty_description => 'Erstellen Sie ein neues Ziel, um Ihre Ersparnisse zu verfolgen!';
	@override String get delete => 'Ziel löschen';
	@override String get delete_warning => 'Diese Aktion ist unwiderruflich. Kategorien und Transaktionen, die sich auf dieses Ziel beziehen, werden nicht gelöscht.';
	@override late final _TranslationsGoalsFormDe form = _TranslationsGoalsFormDe._(_root);
	@override late final _TranslationsGoalsDetailsDe details = _TranslationsGoalsDetailsDe._(_root);
	@override late final _TranslationsGoalsTargetTimelineStatusesDe target_timeline_statuses = _TranslationsGoalsTargetTimelineStatusesDe._(_root);
	@override late final _TranslationsGoalsProgressDe progress = _TranslationsGoalsProgressDe._(_root);
}

// Path: debts
class _TranslationsDebtsDe implements TranslationsDebtsEn {
	_TranslationsDebtsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Schulden',
		other: 'Schulden',
	);
	@override late final _TranslationsDebtsFormDe form = _TranslationsDebtsFormDe._(_root);
	@override late final _TranslationsDebtsDirectionDe direction = _TranslationsDebtsDirectionDe._(_root);
	@override late final _TranslationsDebtsStatusDe status = _TranslationsDebtsStatusDe._(_root);
	@override late final _TranslationsDebtsDetailsDe details = _TranslationsDebtsDetailsDe._(_root);
	@override late final _TranslationsDebtsEmptyDe empty = _TranslationsDebtsEmptyDe._(_root);
	@override late final _TranslationsDebtsActionsDe actions = _TranslationsDebtsActionsDe._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesDe implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktiv';
	@override String get past => 'Abgeschlossen';
	@override String get future => 'Zukunft';
}

// Path: backup
class _TranslationsBackupDe implements TranslationsBackupEn {
	_TranslationsBackupDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => 'Keine Datei ausgewählt';
	@override String get no_directory_selected => 'Kein Verzeichnis ausgewählt';
	@override late final _TranslationsBackupExportDe export = _TranslationsBackupExportDe._(_root);
	@override late final _TranslationsBackupImportDe import = _TranslationsBackupImportDe._(_root);
	@override late final _TranslationsBackupAboutDe about = _TranslationsBackupAboutDe._(_root);
}

// Path: settings
class _TranslationsSettingsDe implements TranslationsSettingsEn {
	_TranslationsSettingsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Einstellungen & Anpassung';
	@override String get title_short => 'Einstellungen';
	@override String get description => 'Thema, Sprache, Daten und mehr';
	@override String get edit_profile => 'Profil bearbeiten';
	@override late final _TranslationsSettingsGeneralDe general = _TranslationsSettingsGeneralDe._(_root);
	@override late final _TranslationsSettingsSecurityDe security = _TranslationsSettingsSecurityDe._(_root);
	@override late final _TranslationsSettingsTransactionsDe transactions = _TranslationsSettingsTransactionsDe._(_root);
	@override late final _TranslationsSettingsAppearanceDe appearance = _TranslationsSettingsAppearanceDe._(_root);
}

// Path: more
class _TranslationsMoreDe implements TranslationsMoreEn {
	_TranslationsMoreDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mehr';
	@override String get title_long => 'Weitere Aktionen';
	@override late final _TranslationsMoreDataDe data = _TranslationsMoreDataDe._(_root);
	@override late final _TranslationsMoreAboutUsDe about_us = _TranslationsMoreAboutUsDe._(_root);
	@override late final _TranslationsMoreHelpUsDe help_us = _TranslationsMoreHelpUsDe._(_root);
}

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingDe implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ohne zu speichern verlassen?';
	@override String get message => 'Sie haben noch nicht gespeicherte Änderungen. Möchten Sie die Seite wirklich verlassen, ohne sie zu speichern?';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardDe implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} in die Zwischenablage kopiert';
	@override String get error => 'Fehler beim Kopieren';
}

// Path: general.time
class _TranslationsGeneralTimeDe implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsGeneralTransactionOrderDe implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Bestellvorgänge';
	@override String get category => 'Nach Kategorie';
	@override String get quantity => 'Nach Menge';
	@override String get date => 'Nach Datum';
}

// Path: general.validations
class _TranslationsGeneralValidationsDe implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Korrigiere die angegebenen Felder, um fortzufahren';
	@override String get required => 'Erforderliches Feld';
	@override String get positive => 'Sollte positiv sein';
	@override String min_number({required Object x}) => 'Sollte größer sein als ${x}';
	@override String max_number({required Object x}) => 'Sollte kleiner sein als ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewDe implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsFinancialHealthMonthsWithoutIncomeDe implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsFinancialHealthSavingsPercentageDe implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sparprozentsatz';
	@override String get subtitle => 'Welcher Teil Deines Einkommens wird in diesem Zeitraum nicht ausgegeben?';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextDe text = _TranslationsFinancialHealthSavingsPercentageTextDe._(_root);
	@override String get suggestion => 'Denk daran, dass es ratsam ist, mindestens 15-20 % Deines Einkommens zu sparen.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesDe implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsTransactionNextPaymentsDe implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsTransactionListDe implements TranslationsTransactionListEn {
	_TranslationsTransactionListDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get all => 'Alle Transaktionen';
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
class _TranslationsTransactionFiltersDe implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaktionsfilter';
	@override String get from_value => 'Ab Betrag';
	@override String get to_value => 'Bis zum Betrag';
	@override String from_value_def({required Object x}) => 'Von ${x}';
	@override String to_value_def({required Object x}) => 'Bis zu ${x}';
	@override String from_date_def({required Object date}) => 'Von der ${date}';
	@override String to_date_def({required Object date}) => 'Bis zum ${date}';
	@override String get reset => 'Filter zurücksetzen';
	@override late final _TranslationsTransactionFiltersSavedDe saved = _TranslationsTransactionFiltersSavedDe._(_root);
}

// Path: transaction.form
class _TranslationsTransactionFormDe implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsTransactionReversedDe implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Umgekehrte Transaktion';
	@override String get title_short => 'Umgekehrte Tr.';
	@override String get description_for_expenses => 'Obwohl es sich um eine Spesentransaktion handelt, weist sie einen positiven Betrag auf. ';
	@override String get description_for_incomes => 'Obwohl es sich um eine Einkommenstransaktion handelt, weist sie einen negativen Betrag auf. ';
}

// Path: transaction.status
class _TranslationsTransactionStatusDe implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsTransactionTypesDe implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsTransferFormDe implements TranslationsTransferFormEn {
	_TranslationsTransferFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get from => 'Origin-Konto';
	@override String get to => 'Zielkonto';
	@override late final _TranslationsTransferFormValueInDestinyDe value_in_destiny = _TranslationsTransferFormValueInDestinyDe._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsDe implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wiederkehrende Transaktion';
	@override String get descr => 'Die nächsten Schritte für diese Transaktion werden unten angezeigt. Du kannst den ersten Schritt akzeptieren oder diesen Schritt auslassen';
	@override String get last_payment_info => 'Diese Bewegung ist die letzte der wiederkehrenden Regel, daher wird diese Regel beim Bestätigen dieser Aktion automatisch gelöscht';
	@override String get delete_header => 'Wiederkehrende Transaktion löschen';
	@override String get delete_message => 'Diese Aktion ist unumkehrbar und hat keinen Einfluss auf Transaktionen, die Du bereits bestätigt/bezahlt habst';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusDe implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Verzögert um ${x}d';
	@override String coming_in({required Object x}) => 'In ${x} Tagen';
}

// Path: account.types
class _TranslationsAccountTypesDe implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontotyp';
	@override String get warning => 'Sobald der Kontotyp ausgewählt wurde, kann er in Zukunft nicht mehr geändert werden';
	@override String get normal => 'Normales Konto';
	@override String get normal_descr => 'Nützlich, um Deine täglichen Finanzen aufzuzeichnen. Es ist das gebräuchlichste Konto, das es Dir ermöglicht, Ausgaben, Einnahmen hinzuzufügen';
	@override String get saving => 'Sparkonto';
	@override String get saving_descr => 'Du kannst nur Geld von anderen Konten einzahlen und abheben. Perfekt geignet, um Geld zu sparen';
}

// Path: account.form
class _TranslationsAccountFormDe implements TranslationsAccountFormEn {
	_TranslationsAccountFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsAccountDeleteDe implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Konto löschen?';
	@override String get warning_text => 'Durch diese Aktion werden dieses Konto und alle seine Transaktionen gelöscht';
	@override String get success => 'Konto erfolgreich gelöscht';
}

// Path: account.close
class _TranslationsAccountCloseDe implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsAccountSelectDe implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get one => 'Wähle ein Konto aus';
	@override String get all => 'Alle Konten';
	@override String get multiple => 'Wähle Konten aus';
}

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormDe implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'Die Währung darf nicht mit der Benutzerwährung übereinstimmen';
	@override String get override_existing_warn => 'Für diese Währung existiert für dieses Datum bereits ein Wechselkurs. Wenn Sie fortfahren, wird die vorherige überschrieben';
	@override String get specify_a_currency => 'Bitte gib eine Währung an';
	@override String get add => 'Wechselkurs hinzufügen';
	@override String get add_success => 'Wechselkurs erfolgreich hinzugefügt';
	@override String get edit => 'Wechselkurs bearbeiten';
	@override String get edit_success => 'Wechselkurs erfolgreich bearbeitet';
	@override String get remove_all => 'Alle Wechselkurse löschen';
	@override String get remove_all_warning => 'Diese Aktion ist unwiderruflich und löscht alle Wechselkurse für diese Währung';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesDe implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Währungstyp';
	@override String get fiat => 'FIAT';
	@override String get crypto => 'Kryptowährung';
	@override String get other => 'Andere';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormDe implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Anzeigename';
	@override String get code => 'Währungscode';
	@override String get symbol => 'Symbol';
	@override String get decimal_digits => 'Dezimalstellen';
	@override String get create => 'Währung erstellen';
	@override String get create_success => 'Währung erfolgreich erstellt';
	@override String get edit => 'Währung bearbeiten';
	@override String get edit_success => 'Währung erfolgreich bearbeitet';
	@override String get delete => 'Währung löschen';
	@override String get delete_success => 'Währung erfolgreich gelöscht';
	@override String get already_exists => 'Eine Währung mit diesem Code existiert bereits. Möglicherweise möchten Sie es bearbeiten';
}

// Path: tags.form
class _TranslationsTagsFormDe implements TranslationsTagsFormEn {
	_TranslationsTagsFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Schlagworte-Name';
	@override String get description => 'Beschreibung';
}

// Path: tags.select
class _TranslationsTagsSelectDe implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Schlagworte auswählen';
	@override String get all => 'Alle Schlagworte';
}

// Path: categories.select
class _TranslationsCategoriesSelectDe implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kategorien auswählen';
	@override String get select_one => 'Wähle eine Kategorie aus';
	@override String get select_subcategory => 'Wähle eine Unterkategorie';
	@override String get without_subcategory => 'Ohne Unterkategorie';
	@override String get all => 'Alle Kategorien';
	@override String get all_short => 'Alle';
}

// Path: budgets.form
class _TranslationsBudgetsFormDe implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budget hinzufügen';
	@override String get name => 'Budgetname';
	@override String get value => 'Menge begrenzen';
	@override String get create => 'Budget hinzufügen';
	@override String get create_success => 'Budget erfolgreich erstellt';
	@override String get edit => 'Budget bearbeiten';
	@override String get edit_success => 'Budget erfolgreich bearbeitet';
	@override String get negative_warn => 'Die Budgets dürfen keinen negativen Betrag haben';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsDe implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budgetdetails';
	@override String get statistics => 'Statistiken';
	@override String get budget_value => 'Budgetiert';
	@override String get expend_evolution => 'Ausgabenentwicklung';
	@override String get no_transactions => 'Es scheint, dass Du im Zusammenhang mit diesem Budget keine Ausgaben getätigt hast';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesDe implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktives Budget';
	@override String get past => 'Abgeschlossenes Budget';
	@override String get future => 'Zukünftiges Budget';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressDe implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsDe labels = _TranslationsBudgetsProgressLabelsDe._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionDe description = _TranslationsBudgetsProgressDescriptionDe._(_root);
}

// Path: goals.type
class _TranslationsGoalsTypeDe implements TranslationsGoalsTypeEn {
	_TranslationsGoalsTypeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Zieltyp';
	@override late final _TranslationsGoalsTypeIncomeDe income = _TranslationsGoalsTypeIncomeDe._(_root);
	@override late final _TranslationsGoalsTypeExpenseDe expense = _TranslationsGoalsTypeExpenseDe._(_root);
}

// Path: goals.form
class _TranslationsGoalsFormDe implements TranslationsGoalsFormEn {
	_TranslationsGoalsFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get new_title => 'Neues Ziel';
	@override String get edit_title => 'Ziel bearbeiten';
	@override String get target_amount => 'Zielbetrag';
	@override String get initial_amount => 'Anfangsbetrag';
	@override String get name => 'Name';
	@override String get name_hint => 'Mein Sparziel';
	@override String get create_success => 'Ziel erfolgreich erstellt';
	@override String get edit_success => 'Ziel erfolgreich bearbeitet';
	@override String get negative_warn => 'Der Zielbetrag kann nicht negativ sein';
}

// Path: goals.details
class _TranslationsGoalsDetailsDe implements TranslationsGoalsDetailsEn {
	_TranslationsGoalsDetailsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zieldetails';
	@override String get statistics => 'Statistiken';
	@override String get goal_value => 'Zielwert';
	@override String get evolution => 'Entwicklung';
	@override String get no_transactions => 'Es scheint, dass Sie keine Transaktionen im Zusammenhang mit diesem Ziel getätigt haben';
}

// Path: goals.target_timeline_statuses
class _TranslationsGoalsTargetTimelineStatusesDe implements TranslationsGoalsTargetTimelineStatusesEn {
	_TranslationsGoalsTargetTimelineStatusesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktives Ziel';
	@override String get past => 'Abgeschlossenes Ziel';
	@override String get future => 'Zukünftiges Ziel';
}

// Path: goals.progress
class _TranslationsGoalsProgressDe implements TranslationsGoalsProgressEn {
	_TranslationsGoalsProgressDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGoalsProgressLabelsDe labels = _TranslationsGoalsProgressLabelsDe._(_root);
	@override late final _TranslationsGoalsProgressDescriptionDe description = _TranslationsGoalsProgressDescriptionDe._(_root);
}

// Path: debts.form
class _TranslationsDebtsFormDe implements TranslationsDebtsFormEn {
	_TranslationsDebtsFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Schuldenname';
	@override String get initial_amount => 'Anfangsbetrag';
	@override String get step_initial_value => 'Anfangswert';
	@override String get step_details => 'Einzelheiten';
	@override late final _TranslationsDebtsFormFromTransactionDe from_transaction = _TranslationsDebtsFormFromTransactionDe._(_root);
	@override late final _TranslationsDebtsFormFromAmountDe from_amount = _TranslationsDebtsFormFromAmountDe._(_root);
}

// Path: debts.direction
class _TranslationsDebtsDirectionDe implements TranslationsDebtsDirectionEn {
	_TranslationsDebtsDirectionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get lent => 'Verliehen';
	@override String get borrowed => 'Entlehnt';
}

// Path: debts.status
class _TranslationsDebtsStatusDe implements TranslationsDebtsStatusEn {
	_TranslationsDebtsStatusDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktiv';
	@override String get close => 'Geschlossen';
}

// Path: debts.details
class _TranslationsDebtsDetailsDe implements TranslationsDebtsDetailsEn {
	_TranslationsDebtsDetailsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get collected_amount => 'Gesammelter Betrag';
	@override String get remaining => 'Übrig';
	@override String get no_deadline => 'Keine Frist';
	@override String in_days({required Object x}) => 'In ${x} Tagen';
	@override String get due_today => 'Heute fällig';
	@override String days_ago({required Object x}) => 'Vor ${x} Tagen';
	@override String overdue_by({required Object x}) => 'Um ${x} Tage überfällig';
	@override String get per_day => '/ Tag';
	@override String get no_transactions => 'Für diese Schuld wurden keine Transaktionen gefunden';
}

// Path: debts.empty
class _TranslationsDebtsEmptyDe implements TranslationsDebtsEmptyEn {
	_TranslationsDebtsEmptyDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get no_debts_active => 'Keine aktiven Schulden gefunden. Erstellen Sie zunächst eine neue Schuld, indem Sie auf die Schaltfläche unten klicken';
	@override String get no_debts_closed => 'Keine geschlossenen Schulden gefunden. Eine Schuld gilt als beglichen, wenn Sie das gesamte Geld eingezogen oder den gesamten geschuldeten Betrag beglichen haben.';
}

// Path: debts.actions
class _TranslationsDebtsActionsDe implements TranslationsDebtsActionsEn {
	_TranslationsDebtsActionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDebtsActionsEditDe edit = _TranslationsDebtsActionsEditDe._(_root);
	@override late final _TranslationsDebtsActionsDeleteDe delete = _TranslationsDebtsActionsDeleteDe._(_root);
	@override late final _TranslationsDebtsActionsAddRegisterDe add_register = _TranslationsDebtsActionsAddRegisterDe._(_root);
	@override late final _TranslationsDebtsActionsLinkTransactionDe link_transaction = _TranslationsDebtsActionsLinkTransactionDe._(_root);
	@override late final _TranslationsDebtsActionsNewTransactionDe new_transaction = _TranslationsDebtsActionsNewTransactionDe._(_root);
	@override late final _TranslationsDebtsActionsCreateDe create = _TranslationsDebtsActionsCreateDe._(_root);
}

// Path: backup.export
class _TranslationsBackupExportDe implements TranslationsBackupExportEn {
	_TranslationsBackupExportDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Daten exportieren';
	@override String get title_short => 'Export';
	@override String get type_of_export => 'Art des Exports';
	@override String get other_options => 'Optionen';
	@override String get all => 'Vollständige Sicherung';
	@override String get all_descr => 'Exportiere alle Deine Daten (Konten, Transaktionen, Budgets, Einstellungen...). ';
	@override String get transactions => 'Sicherung der Transaktionen';
	@override String get transactions_descr => 'Exportiere Deine Transaktionen im CSV-Format, damit Du sie einfacher in anderen Programmen oder Anwendungen analysieren kannst.';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '1 Transaktion zum Exportieren',
		other: '${n} Transaktionen zum Exportieren',
	);
	@override String get description => 'Lade Deine Daten in verschiedenen Formaten herunter';
	@override String get send_file => 'Datei senden';
	@override String get see_folder => 'Siehe Ordner';
	@override String success({required Object x}) => 'Datei erfolgreich gespeichert/heruntergeladen in ${x}';
	@override String get error => 'Fehler beim Herunterladen der Datei. ';
	@override String get dialog_title => 'Datei speichern/senden';
}

// Path: backup.import
class _TranslationsBackupImportDe implements TranslationsBackupImportEn {
	_TranslationsBackupImportDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
	@override String get error => 'Fehler beim Importieren der Datei. Bitte kontaktiere den Entwickler lozin.technologies@gmail.com';
	@override String get cancelled => 'Der Import wurde vom Benutzer abgebrochen';
}

// Path: backup.about
class _TranslationsBackupAboutDe implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informationen zu Deiner Datenbank';
	@override String get create_date => 'Erstellungsdatum';
	@override String get modify_date => 'Zuletzt geändert';
	@override String get last_backup => 'Letzte Sicherung';
	@override String get size => 'Größe';
}

// Path: settings.general
class _TranslationsSettingsGeneralDe implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Allgemeine Einstellungen';
	@override String get menu_descr => 'Sprache, Datenschutz und mehr';
	@override String get show_all_decimals => 'Alle Nachkommastellen anzeigen';
	@override String get show_all_decimals_descr => 'Alle Dezimalstellen anzeigen, auch bei nachgestellten Nullen';
	@override late final _TranslationsSettingsGeneralLanguageDe language = _TranslationsSettingsGeneralLanguageDe._(_root);
	@override late final _TranslationsSettingsGeneralLocaleDe locale = _TranslationsSettingsGeneralLocaleDe._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityDe implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sicherheit';
	@override String get private_mode_at_launch => 'Privatmodus beim Start';
	@override String get private_mode_at_launch_descr => 'Starte die App standardmäßig im privaten Modus';
	@override String get private_mode => 'Privatmodus';
	@override String get private_mode_descr => 'Alle Geldwerte ausblenden';
	@override String get private_mode_activated => 'Privatmodus aktiviert';
	@override String get private_mode_deactivated => 'Privatmodus deaktiviert';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsDe implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Transaktionen';
	@override String get menu_descr => 'Konfigurieren Sie das Verhalten Ihrer Transaktionen';
	@override String get title => 'Transaktionseinstellungen';
	@override late final _TranslationsSettingsTransactionsStyleDe style = _TranslationsSettingsTransactionsStyleDe._(_root);
	@override late final _TranslationsSettingsTransactionsSwipeActionsDe swipe_actions = _TranslationsSettingsTransactionsSwipeActionsDe._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesDe default_values = _TranslationsSettingsTransactionsDefaultValuesDe._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeDe default_type = _TranslationsSettingsTransactionsDefaultTypeDe._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceDe implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Thema & Stil';
	@override String get menu_descr => 'Themenauswahl, Farben und andere Dinge im Zusammenhang mit dem Erscheinungsbild der App';
	@override String get theme_and_colors => 'Thema und Farben';
	@override late final _TranslationsSettingsAppearanceThemeDe theme = _TranslationsSettingsAppearanceThemeDe._(_root);
	@override String get amoled_mode => 'AMOLED-Modus';
	@override String get amoled_mode_descr => 'Verwende nach Möglichkeit einn rein schwarzen Hintergrund. Das wird den Akku von Geräten mit AMOLED-Bildschirmen etwas schonen.';
	@override String get dynamic_colors => 'Dynamische Farben';
	@override String get dynamic_colors_descr => 'Verwende wann immer möglich die Akzentfarbe des Systems';
	@override String get accent_color => 'Akzentfarbe';
	@override String get accent_color_descr => 'Wähle die Farbe aus, mit der die App bestimmte Teile der Benutzeroberfläche hervorhebt';
	@override String get text => 'Text';
	@override String get font => 'Schriftart';
	@override String get font_platform => 'Plattform';
}

// Path: more.data
class _TranslationsMoreDataDe implements TranslationsMoreDataEn {
	_TranslationsMoreDataDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsMoreAboutUsDe implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'App-Informationen';
	@override String get description => 'Finden Sie die Bedingungen von Monekin und wichtige Informationen, und nehmen Sie Kontakt auf, um Fehler zu melden oder Ideen zu teilen';
	@override late final _TranslationsMoreAboutUsLegalDe legal = _TranslationsMoreAboutUsLegalDe._(_root);
	@override late final _TranslationsMoreAboutUsProjectDe project = _TranslationsMoreAboutUsProjectDe._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsDe implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsGeneralTimeRangesDe implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsGeneralTimePeriodicityDe implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsGeneralTimeCurrentDe implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Diesen Monat';
	@override String get annually => 'Dieses Jahr';
	@override String get quaterly => 'Dieses Quartal';
	@override String get weekly => 'Diese Woche';
	@override String get infinite => 'Für immer';
	@override String get custom => 'Benutzerdefinierter Zeitraum';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllDe implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Täglich';
	@override String get monthly => 'Jeden Monat';
	@override String get annually => 'Jährlich';
	@override String get quaterly => 'Vierteljährlich';
	@override String get weekly => 'Jede Woche';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrDe implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Es sieht so aus, als hätten wir nicht genügend Ausgaben, um Deine finanzielle Lage zu berechnen. Füge in diesem Zeitraum einige Ausgaben/Einnahmen hinzu, damit wir Dir helfen können!';
	@override String get very_good => 'Glückwunsch! ';
	@override String get good => 'Großartig! ';
	@override String get normal => 'Deine finanzielle Lage entspricht in diesem Zeitraum mehr oder weniger dem Durchschnitt der übrigen Bevölkerung';
	@override String get bad => 'Es scheint, dass Deine finanzielle Situation noch nicht die beste ist. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
	@override String get very_bad => 'Hmm, Deine finanzielle Lage ist weit unter dem, was sie sein sollte. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextDe implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen. Es scheint, dass Du bereits ein Experte sind, mache weiter so! ';
	@override String normal({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen';
	@override String bad({required Object value}) => 'Du hast es geschafft <b>${value}%</b> Deines Einkommens in diesem Zeitraum zu sparen . ';
	@override String get very_bad => 'Wow, du hast es in dieser Zeit nicht geschafft, etwas zu sparen.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditDe implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Daten bearbeiten';
	@override String get categories => 'Kategorien bearbeiten';
	@override String get status => 'Status bearbeiten';
}

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedDe implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gespeicherte Filter';
	@override String get new_title => 'Neuer Filter';
	@override String get edit_title => 'Filter bearbeiten';
	@override String get name_label => 'Filtername';
	@override String get name_hint => 'Mein benutzerdefinierter Filter';
	@override String get save_dialog_title => 'Filter speichern';
	@override String get save_tooltip => 'Aktuellen Filter speichern';
	@override String get load_tooltip => 'Gespeicherten Filter laden';
	@override String get empty_title => 'Keine gespeicherten Filter gefunden';
	@override String get empty_description => 'Speichern Sie Filter hier, um später schnell darauf zugreifen zu können.';
	@override String get save_success => 'Filter erfolgreich gespeichert';
	@override String get delete_success => 'Filter erfolgreich gelöscht';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsDe implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get zero => 'Der Wert einer Transaktion kann nicht gleich Null sein';
	@override String get date_max => 'Das ausgewählte Datum liegt nach dem aktuellen. ';
	@override String get date_after_account_creation => 'Du kannst keine Transaktion erstellen, deren Datum vor dem Erstellungsdatum des Kontos liegt, zu dem sie gehört';
	@override String get negative_transfer => 'Der Geldwert einer Überweisung darf nicht negativ sein';
	@override String get transfer_between_same_accounts => 'Das Ursprungs- und das Zielkonto dürfen nicht identisch sein';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyDe implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Am Zielkonto überwiesener Betrag';
	@override String amount_short({required Object amount}) => '${amount} zum Zielkonto';
}

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsDe implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'Auf Kurs';
	@override String get active_overspending => 'Mehrausgaben';
	@override String get active_indeterminate => 'Aktiv';
	@override String get success => 'Erreicht';
	@override String get fail => 'Budget überschritten';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionDe implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Sie können ${dailyAmount} pro Tag für die verbleibenden ${remainingDays} Tage ausgeben';
	@override String active_overspending({required Object dailyAmount, required Object remainingDays}) => 'Um wieder auf Kurs zu kommen, sollten Sie Ihre Ausgaben auf ${dailyAmount} pro Tag für die verbleibenden ${remainingDays} Tage begrenzen';
	@override String active_indeterminate({required Object amount}) => 'Sie haben noch ${amount} zum Ausgeben übrig.';
	@override String active_exceeded({required Object amount}) => 'Sie haben Ihr Budgetlimit bereits um ${amount} überschritten. Wenn Sie keine Einnahmen für dieses Budget finden, sollten Sie für den Rest des Zeitraums keine Ausgaben mehr tätigen';
	@override String get success => 'Gute Arbeit! Dieses Budget wurde erfolgreich abgeschlossen. Erstellen Sie weiterhin Budgets, um Ihre Ausgaben zu verwalten';
	@override String fail({required Object amount}) => 'Sie haben das Budget um ${amount} überschritten. Versuchen Sie beim nächsten Mal vorsichtiger zu sein!';
}

// Path: goals.type.income
class _TranslationsGoalsTypeIncomeDe implements TranslationsGoalsTypeIncomeEn {
	_TranslationsGoalsTypeIncomeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sparziel';
	@override String get descr => 'Ideal zum Sparen. Du bist erfolgreich, wenn der Saldo dein Ziel übersteigt.';
}

// Path: goals.type.expense
class _TranslationsGoalsTypeExpenseDe implements TranslationsGoalsTypeExpenseEn {
	_TranslationsGoalsTypeExpenseDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ausgabenziel';
	@override String get descr => 'Verfolge, wie viel du ausgibst, und versuche, einen Zielbetrag zu erreichen. Gut für Spenden, Wohltätigkeit...';
}

// Path: goals.progress.labels
class _TranslationsGoalsProgressLabelsDe implements TranslationsGoalsProgressLabelsEn {
	_TranslationsGoalsProgressLabelsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'Auf dem richtigen Weg';
	@override String get active_behind_schedule => 'Hinter dem Zeitplan';
	@override String get active_indeterminate => 'Aktiv';
	@override String get success => 'Ziel erreicht';
	@override String get fail => 'Ziel gescheitert';
}

// Path: goals.progress.description
class _TranslationsGoalsProgressDescriptionDe implements TranslationsGoalsProgressDescriptionEn {
	_TranslationsGoalsProgressDescriptionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object remainingDays, required Object dailyAmount}) => 'Sie sind auf dem richtigen Weg, Ihr Ziel zu erreichen! Sie müssen für die verbleibenden ${remainingDays} Tage pro Tag ${dailyAmount} sparen';
	@override String active_behind_schedule({required Object dailyAmount, required Object remainingDays}) => 'Sie sind im Rückstand. Sie müssen ${dailyAmount} pro Tag sparen, um Ihr Ziel in ${remainingDays} Tagen zu erreichen';
	@override String active_indeterminate({required Object amount}) => 'Sie benötigen ${amount} mehr, um Ihr Ziel zu erreichen.';
	@override String get success => 'Glückwunsch! Du hast dein Ziel erreicht.';
	@override String fail({required Object amount}) => 'Sie haben Ihr Ziel um ${amount} verfehlt.';
}

// Path: debts.form.from_transaction
class _TranslationsDebtsFormFromTransactionDe implements TranslationsDebtsFormFromTransactionEn {
	_TranslationsDebtsFormFromTransactionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aus einer Transaktion';
	@override String get select => 'Wählen Sie eine Transaktion aus';
	@override String get tap_to_select => 'Tippen Sie, um eine Transaktion auszuwählen';
}

// Path: debts.form.from_amount
class _TranslationsDebtsFormFromAmountDe implements TranslationsDebtsFormFromAmountEn {
	_TranslationsDebtsFormFromAmountDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ab einem Anfangsbetrag';
	@override String get description => 'Dieser Betrag wird in der Statistik nicht als Aufwand/Ertrag berücksichtigt. Es wird zur Berechnung der Salden und des Nettovermögens verwendet';
}

// Path: debts.actions.edit
class _TranslationsDebtsActionsEditDe implements TranslationsDebtsActionsEditEn {
	_TranslationsDebtsActionsEditDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Schulden bearbeiten';
	@override String get success => 'Schulden erfolgreich bearbeitet';
}

// Path: debts.actions.delete
class _TranslationsDebtsActionsDeleteDe implements TranslationsDebtsActionsDeleteEn {
	_TranslationsDebtsActionsDeleteDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Diese Schulden löschen?';
	@override String get warning_text => 'Diese Aktion kann nicht rückgängig gemacht werden. Verknüpfte Transaktionen werden nicht gelöscht, sind aber nicht mehr mit dieser Schuld verknüpft.';
}

// Path: debts.actions.add_register
class _TranslationsDebtsActionsAddRegisterDe implements TranslationsDebtsActionsAddRegisterEn {
	_TranslationsDebtsActionsAddRegisterDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fügen Sie Bewegung hinzu';
	@override String get success => 'Bewegung erfolgreich hinzugefügt';
	@override String get fab_label => 'Register hinzufügen';
	@override String get modal_title => 'Register zu dieser Schuld hinzufügen';
	@override String get modal_subtitle => 'Wählen Sie eine der folgenden Optionen, um eine Transaktion mit dieser Schuld zu verknüpfen';
}

// Path: debts.actions.link_transaction
class _TranslationsDebtsActionsLinkTransactionDe implements TranslationsDebtsActionsLinkTransactionEn {
	_TranslationsDebtsActionsLinkTransactionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bestehende Transaktion verknüpfen';
	@override String get description => 'Wählen Sie einen vorhandenen Datensatz aus, um ihn mit dieser Schuld zu verknüpfen';
	@override String get success => 'Mit Schulden verbundene Transaktion';
	@override String creating({required Object name}) => 'Sie erstellen eine Transaktion, die mit der Schuld <b>${name}</b> verknüpft ist';
}

// Path: debts.actions.new_transaction
class _TranslationsDebtsActionsNewTransactionDe implements TranslationsDebtsActionsNewTransactionEn {
	_TranslationsDebtsActionsNewTransactionDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neue Transaktion hinzufügen';
	@override String get description => 'Fügen Sie die Schulden manuell hinzu oder reduzieren Sie sie, indem Sie eine neue Transaktion erstellen, die mit dieser Schuld verknüpft ist';
}

// Path: debts.actions.create
class _TranslationsDebtsActionsCreateDe implements TranslationsDebtsActionsCreateEn {
	_TranslationsDebtsActionsCreateDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Schulden machen';
	@override String get success => 'Schulden erfolgreich erstellt';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportDe implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
		'Wählen die Spalte aus, in der der Wert jeder Transaktion angegeben ist. Verwende negative Werte für Ausgaben und positive Werte für Einnahmen.',
		'Wähle die Spalte aus, in der das Konto angegeben ist, zu dem jede Transaktion gehört. Du kannst auch ein Standardkonto auswählen, falls wir das von Dir gewünschte Konto nicht finden können. Wenn Du kein Standardkonto angibst, wird eines mit demselben Namen erstellt ',
		'Gebe die Spalte an, in der sich der Name der Transaktionskategorie befindet. Du musst eine Standardkategorie angeben, damit wir diese Kategorie den Transaktionen zuordnen können, falls die Kategorie nicht gefunden werden kann.',
		'Wähle die Spalte aus, in der das Datum jeder Transaktion angegeben ist. Wird nichts angegeben, werden die Transaktionen mit dem aktuellen Datum erstellt.',
		'Gibt die Spalten für andere optionale Transaktionsattribute an',
	];
	@override String success({required Object x}) => 'Erfolgreich ${x} Transaktionen importiert';
}

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageDe implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get section => 'Sprache und Texte';
	@override String get title => 'App-Sprache';
	@override String get descr => 'Sprache, in der die Texte in der App angezeigt werden';
	@override String get help => 'Wenn an den Übersetzungen dieser App mitarbeiten möchten, kannst du dich an <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>unser Beschreibung</a> wenden';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleDe implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Region';
	@override String get auto => 'System';
	@override String get descr => 'Lege das für Datumsangaben, Zahlen usw. zu verwendende Format fest.';
	@override String get warn => 'Wenn Du die Region änderst, wird die App aktualisiert';
	@override String get first_day_of_week => 'Erster Tag der Woche';
}

// Path: settings.transactions.style
class _TranslationsSettingsTransactionsStyleDe implements TranslationsSettingsTransactionsStyleEn {
	_TranslationsSettingsTransactionsStyleDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaktionsstil';
	@override String get subtitle => 'Konfigurieren Sie das Aussehen von Transaktionen in Listen';
	@override String get show_tags => 'Tags anzeigen';
	@override String get show_time => 'Zeit anzeigen';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsDe implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wischaktionen';
	@override String get choose_description => 'Wählen Sie aus, welche Aktion ausgelöst wird, wenn Sie mit dieser Wischrichtung über ein Transaktionselement in der Liste wischen';
	@override String get swipe_left => 'Wischen Sie nach links';
	@override String get swipe_right => 'Wischen Sie nach rechts';
	@override String get none => 'Keine Aktion';
	@override String get toggle_reconciled => 'Toggle abgeglichen';
	@override String get toggle_pending => 'Umschalten steht aus';
	@override String get toggle_voided => 'Umschalten ungültig';
	@override String get toggle_unreconciled => 'Nicht abgestimmt umschalten';
	@override String get remove_status => 'Status entfernen';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesDe implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
class _TranslationsSettingsTransactionsDefaultTypeDe implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Type';
	@override String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeDe implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thema';
	@override String get auto => 'System';
	@override String get light => 'Hell';
	@override String get dark => 'Dunkel';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalDe implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Rechtliche Informationen';
	@override String get privacy => 'Datenschutzrichtlinie';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get licenses => 'Lizenzen';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectDe implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get display => 'Projekt';
	@override String get contributors => 'Mitarbeiter';
	@override String get contributors_descr => 'Alle Entwickler, die Monekin wachsen lassen haben';
	@override String get contact => 'Kontaktiere uns';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesDe implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Zyklen';
	@override String get last_days => 'Letzte Tage';
	@override String last_days_form({required Object x}) => '${x} Vortage';
	@override String get all => 'Immer';
	@override String get date_range => 'Benutzerdefinierter Zeitraum';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ui_actions.cancel' => 'Abbrechen',
			'ui_actions.confirm' => 'Bestätigen',
			'ui_actions.continue_text' => 'Weiter',
			'ui_actions.save' => 'Speichern',
			'ui_actions.save_changes' => 'Änderungen speichern',
			'ui_actions.close_and_save' => 'Speichern und schließen',
			'ui_actions.add' => 'Hinzufügen',
			'ui_actions.edit' => 'Bearbeiten',
			'ui_actions.delete' => 'Löschen',
			'ui_actions.see_more' => 'Mehr anzeigen',
			'ui_actions.select_all' => 'Alles auswählen',
			'ui_actions.deselect_all' => 'Alles abwählen',
			'ui_actions.select' => 'Auswählen',
			'ui_actions.search' => 'Suchen',
			'ui_actions.filter' => 'Filtern',
			'ui_actions.reset' => 'Zurücksetzen',
			'ui_actions.submit' => 'Absenden',
			'ui_actions.next' => 'Weiter',
			'ui_actions.previous' => 'Zurück',
			'ui_actions.back' => 'Zurück',
			'ui_actions.reload' => 'Neu laden',
			'ui_actions.view' => 'Ansehen',
			'ui_actions.download' => 'Herunterladen',
			'ui_actions.upload' => 'Hochladen',
			'ui_actions.retry' => 'Erneut versuchen',
			'ui_actions.copy' => 'Kopieren',
			'ui_actions.paste' => 'Einfügen',
			'ui_actions.undo' => 'Rückgängig',
			'ui_actions.redo' => 'Wiederholen',
			'ui_actions.open' => 'Öffnen',
			'ui_actions.close' => 'Schließen',
			'ui_actions.apply' => 'Anwenden',
			'ui_actions.discard' => 'Verwerfen',
			'ui_actions.refresh' => 'Aktualisieren',
			'ui_actions.share' => 'Teilen',
			'general.or' => 'oder',
			'general.understood' => 'Verstanden',
			'general.unspecified' => 'Nicht spezifiziert',
			'general.quick_actions' => 'Schnelle Aktionen',
			'general.details' => 'Details',
			'general.balance' => 'Kontostand',
			'general.account' => 'Konto',
			'general.accounts' => 'Konten',
			'general.categories' => 'Kategorien',
			'general.category' => 'Kategorie',
			'general.today' => 'Heute',
			'general.yesterday' => 'Gestern',
			'general.filters' => 'Filter',
			'general.empty_warn' => 'Ops! Das ist sehr leer',
			'general.search_no_results' => 'Keine Artikel entsprechen Ihren Suchkriterien',
			'general.insufficient_data' => 'Unzureichende Daten',
			'general.show_more_fields' => 'Weitere Felder anzeigen',
			'general.show_less_fields' => 'Weniger Felder anzeigen',
			'general.tap_to_search' => 'Zum Suchen tippen',
			'general.delete_success' => 'Element erfolgreich gelöscht',
			'general.leave_without_saving.title' => 'Ohne zu speichern verlassen?',
			'general.leave_without_saving.message' => 'Sie haben noch nicht gespeicherte Änderungen. Möchten Sie die Seite wirklich verlassen, ohne sie zu speichern?',
			'general.clipboard.success' => ({required Object x}) => '${x} in die Zwischenablage kopiert',
			'general.clipboard.error' => 'Fehler beim Kopieren',
			'general.time.start_date' => 'Startdatum',
			'general.time.end_date' => 'Enddatum',
			'general.time.from_date' => 'Ab Datum',
			'general.time.until_date' => 'Bis heute',
			'general.time.date' => 'Datum',
			'general.time.datetime' => 'Datum/Uhrzeit',
			'general.time.time' => 'Zeit',
			'general.time.each' => 'Jede',
			'general.time.after' => 'Nach',
			'general.time.ranges.display' => 'Zeitbereich',
			'general.time.ranges.it_repeat' => 'Wiederholt',
			'general.time.ranges.it_ends' => 'Endet',
			'general.time.ranges.forever' => 'Für immer',
			'general.time.ranges.types.cycle' => 'Zyklen',
			'general.time.ranges.types.last_days' => 'Letzte Tage',
			'general.time.ranges.types.last_days_form' => ({required Object x}) => '${x} Vortage',
			'general.time.ranges.types.all' => 'Immer',
			'general.time.ranges.types.date_range' => 'Benutzerdefinierter Zeitraum',
			'general.time.ranges.each_range' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Jeder ${range}', other: 'Jeder ${n} ${range}', ), 
			'general.time.ranges.each_range_until_date' => ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Jeder ${range} bis ${day}', other: 'Jeder ${n} ${range} bis ${day}', ), 
			'general.time.ranges.each_range_until_times' => ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Jeder ${range} ${limit} mal', other: 'Jeder ${n} ${range} ${limit} mal', ), 
			'general.time.ranges.each_range_until_once' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Jeder ${range} einmal', other: 'Jeder ${n} ${range} einmal', ), 
			'general.time.ranges.month' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Monat', other: 'Monate', ), 
			'general.time.ranges.year' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Jahr', other: 'Jahre', ), 
			'general.time.ranges.day' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Tag', other: 'Tage', ), 
			'general.time.ranges.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Woche', other: 'Wochen', ), 
			'general.time.periodicity.display' => 'Wiederholung',
			'general.time.periodicity.no_repeat' => 'Keine Wiederholung',
			'general.time.periodicity.repeat' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Wiederholung', other: 'Wiederholungen', ), 
			'general.time.periodicity.diary' => 'Täglich',
			'general.time.periodicity.monthly' => 'Monatlich',
			'general.time.periodicity.annually' => 'Jährlich',
			'general.time.periodicity.quaterly' => 'Vierteljährlich',
			'general.time.periodicity.weekly' => 'Wöchentlich',
			'general.time.periodicity.custom' => 'Brauch',
			'general.time.periodicity.infinite' => 'Stets',
			'general.time.current.monthly' => 'Diesen Monat',
			'general.time.current.annually' => 'Dieses Jahr',
			'general.time.current.quaterly' => 'Dieses Quartal',
			'general.time.current.weekly' => 'Diese Woche',
			'general.time.current.infinite' => 'Für immer',
			'general.time.current.custom' => 'Benutzerdefinierter Zeitraum',
			'general.time.all.diary' => 'Täglich',
			'general.time.all.monthly' => 'Jeden Monat',
			'general.time.all.annually' => 'Jährlich',
			'general.time.all.quaterly' => 'Vierteljährlich',
			'general.time.all.weekly' => 'Jede Woche',
			'general.transaction_order.display' => 'Bestellvorgänge',
			'general.transaction_order.category' => 'Nach Kategorie',
			'general.transaction_order.quantity' => 'Nach Menge',
			'general.transaction_order.date' => 'Nach Datum',
			'general.validations.form_error' => 'Korrigiere die angegebenen Felder, um fortzufahren',
			'general.validations.required' => 'Erforderliches Feld',
			'general.validations.positive' => 'Sollte positiv sein',
			'general.validations.min_number' => ({required Object x}) => 'Sollte größer sein als ${x}',
			'general.validations.max_number' => ({required Object x}) => 'Sollte kleiner sein als ${x}',
			'intro.start' => 'Start',
			'intro.skip' => 'Überspringen',
			'intro.next' => 'Nächste',
			'intro.select_your_currency' => 'Wähle Deine Währung aus',
			'intro.welcome_subtitle' => 'Dein persönlicher Finanzmanager',
			'intro.welcome_subtitle2' => '100 % geöffnet, 100 % kostenlos',
			'intro.welcome_footer' => 'Mit der Anmeldung stimmst Du der <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Datenschutzrichtlinie</a> und den <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Nutzungsbedingungen</a> der App zu',
			'intro.offline_descr_title' => 'OFFLINE-KONTO:',
			'intro.offline_descr' => 'Deine Daten werden nur auf Deinem Gerät gespeichert und sind sicher, solange Du die App nicht deinstallieren oder das Telefon wechselst. ',
			'intro.offline_start' => 'Sitzung offline starten',
			'intro.sl1_title' => 'Wähle Deine Währung aus',
			'intro.sl1_descr' => 'Deine Standardwährung wird in Berichten und allgemeinen Diagrammen verwendet. ',
			'intro.sl2_title' => 'Sicher, privat und zuverlässig',
			'intro.sl2_descr' => 'Deine Daten gehören nur Dir. ',
			'intro.sl2_descr2' => 'Außerdem ist der Quellcode der Anwendung öffentlich, jeder kann daran mitarbeiten und sehen, wie es funktioniert',
			'intro.last_slide_title' => 'Alles bereit',
			'intro.last_slide_descr' => 'Mit Monekin kannst Du endlich die finanzielle Unabhängigkeit erreichen, die Du dir so sehr wünschst. ',
			'intro.last_slide_descr2' => 'Wir hoffen, dass Du Deine Erfahrung genießet! Zögerne nicht, uns im Falle von Fragen oder Vorschlägen zu kontaktieren...',
			'home.title' => 'Übersicht',
			'home.filter_transactions' => 'Transaktionen filtern',
			'home.hello_day' => 'Guten Morgen,',
			'home.hello_night' => 'Gute Nacht,',
			'home.total_balance' => 'Gesamtbilanz',
			'home.my_accounts' => 'Meine Konten',
			'home.active_accounts' => 'Aktive Konten',
			'home.no_accounts' => 'Es wurden noch keine Konten erstellt',
			'home.no_accounts_descr' => 'Beginne, die ganze Magie von Monekin zu nutzen. ',
			'home.last_transactions' => 'Letzte Transaktionen',
			'home.should_create_account_header' => 'Hoppla!',
			'home.should_create_account_message' => 'Du musst über mindestens ein nicht archiviertes Konto verfügen, bevor Du mit der Erstellung von Transaktionen beginnen kannst',
			'financial_health.display' => 'Finanzielle Lage',
			'financial_health.review.very_good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Sehr gut!'; case GenderContext.female: return 'Sehr gut!'; } }, 
			'financial_health.review.good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Gut'; case GenderContext.female: return 'Gut'; } }, 
			'financial_health.review.normal' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Durchschnitt'; case GenderContext.female: return 'Durchschnitt'; } }, 
			'financial_health.review.bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Mäßig'; case GenderContext.female: return 'Mäßig'; } }, 
			'financial_health.review.very_bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Sehr schlecht'; case GenderContext.female: return 'Sehr schlecht'; } }, 
			'financial_health.review.insufficient_data' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Unzureichende Daten'; case GenderContext.female: return 'Unzureichende Daten'; } }, 
			'financial_health.review.descr.insufficient_data' => 'Es sieht so aus, als hätten wir nicht genügend Ausgaben, um Deine finanzielle Lage zu berechnen. Füge in diesem Zeitraum einige Ausgaben/Einnahmen hinzu, damit wir Dir helfen können!',
			'financial_health.review.descr.very_good' => 'Glückwunsch! ',
			'financial_health.review.descr.good' => 'Großartig! ',
			'financial_health.review.descr.normal' => 'Deine finanzielle Lage entspricht in diesem Zeitraum mehr oder weniger dem Durchschnitt der übrigen Bevölkerung',
			'financial_health.review.descr.bad' => 'Es scheint, dass Deine finanzielle Situation noch nicht die beste ist. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren',
			'financial_health.review.descr.very_bad' => 'Hmm, Deine finanzielle Lage ist weit unter dem, was sie sein sollte. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren',
			'financial_health.months_without_income.title' => 'Überlebensrate',
			'financial_health.months_without_income.subtitle' => 'Angesichts Deines Guthabens, wie viel Zeit kannst Du ohne Einkommen auskommen?',
			'financial_health.months_without_income.text_zero' => 'Bei diesem Ausgabenniveau kannst Du keinen Monat ohne Einkommen überleben!',
			'financial_health.months_without_income.text_one' => 'Bei diesem Ausgabenniveau kannst Du kaum etwa einen Monat ohne Einkommen überleben!',
			'financial_health.months_without_income.text_other' => ({required Object n}) => 'Du könntest ungefähr <b>${n} Monate</b> ohne Einkommen bei dieser Ausgabenrate überleben.',
			'financial_health.months_without_income.text_infinite' => 'Du könntest ungefähr <b>Dein ganzes Leben lang</b> ohne Einkommen bei dieser Ausgabenrate überleben.',
			'financial_health.months_without_income.suggestion' => 'Denke daran, dass es ratsam ist, dieses Verhältnis immer mindestens über 5 Monate zu halten. Wenn Du feststellst, dass Du nicht über ein ausreichendes Sparpolster verfügst, solltest Du unnötige Ausgaben reduzieren.',
			'financial_health.months_without_income.insufficient_data' => 'Offenbar haben wir nicht genügend Ausgaben, um zu berechnen, wie viele Monate Du ohne Einkommen überleben könntest. Gib ein paar Transaktionen ein und komme hierher zurück, um Deine Finanzen zu überprüfen.',
			'financial_health.savings_percentage.title' => 'Sparprozentsatz',
			'financial_health.savings_percentage.subtitle' => 'Welcher Teil Deines Einkommens wird in diesem Zeitraum nicht ausgegeben?',
			'financial_health.savings_percentage.text.good' => ({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen. Es scheint, dass Du bereits ein Experte sind, mache weiter so! ',
			'financial_health.savings_percentage.text.normal' => ({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen',
			'financial_health.savings_percentage.text.bad' => ({required Object value}) => 'Du hast es geschafft <b>${value}%</b> Deines Einkommens in diesem Zeitraum zu sparen . ',
			'financial_health.savings_percentage.text.very_bad' => 'Wow, du hast es in dieser Zeit nicht geschafft, etwas zu sparen.',
			'financial_health.savings_percentage.suggestion' => 'Denk daran, dass es ratsam ist, mindestens 15-20 % Deines Einkommens zu sparen.',
			'stats.title' => 'Statistiken',
			'stats.balance' => 'Kontostand',
			'stats.final_balance' => 'Schlussstand',
			'stats.balance_by_account' => 'Saldo nach Konten',
			'stats.balance_by_account_subtitle' => 'Wo habe ich das meiste Geld?',
			'stats.balance_by_currency' => 'Saldo nach Währung',
			'stats.balance_by_currency_subtitle' => 'Wie viel Geld habe ich in Fremdwährung?',
			'stats.balance_evolution' => 'Trend',
			'stats.balance_evolution_subtitle' => 'Habe ich mehr Geld als vorher?',
			'stats.compared_to_previous_period' => 'Im Vergleich zur Vorperiode',
			'stats.cash_flow' => 'Cashflow',
			'stats.cash_flow_subtitle' => 'Gebe ich weniger aus, als ich verdiene?',
			'stats.by_periods' => 'Nach Perioden',
			'stats.by_categories' => 'Nach Kategorien',
			'stats.by_tags' => 'Nach Tags',
			'stats.distribution' => 'Verteilung',
			'stats.finance_health_resume' => 'Zusammenfassung',
			'stats.finance_health_breakdown' => 'Auflüsselung',
			'icon_selector.name' => 'Name:',
			'icon_selector.icon' => 'Symbol',
			'icon_selector.color' => 'Farbe',
			'icon_selector.select_icon' => 'Wähle ein Symbol aus',
			'icon_selector.select_color' => 'Wähle eine Farbe',
			'icon_selector.custom_color' => 'Benutzerdefinierte Farbe',
			'icon_selector.current_color_selection' => 'Aktuelle Auswahl',
			'icon_selector.select_account_icon' => 'Identifiziere Dein Konto',
			'icon_selector.select_category_icon' => 'Identifiziere Deine Kategorie',
			'icon_selector.scopes.transport' => 'Transport',
			'icon_selector.scopes.money' => 'Geld',
			'icon_selector.scopes.food' => 'Essen',
			'icon_selector.scopes.medical' => 'Gesundheit',
			'icon_selector.scopes.entertainment' => 'Freizeit',
			'icon_selector.scopes.technology' => 'Technologie',
			'icon_selector.scopes.other' => 'Andere',
			'icon_selector.scopes.logos_financial_institutions' => 'Finanzinstitute',
			'transaction.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Transaktion', other: 'Transaktionen', ), 
			'transaction.create' => 'Neue Transaktion',
			'transaction.new_income' => 'Neues Einkommen',
			'transaction.new_expense' => 'Neue Ausgabe',
			'transaction.new_success' => 'Transaktion erfolgreich erstellt',
			'transaction.edit' => 'Transaktion bearbeiten',
			'transaction.edit_success' => 'Transaktion erfolgreich bearbeitet',
			'transaction.edit_multiple' => 'Bearbeite Deine Transaktionen',
			'transaction.edit_multiple_success' => ({required Object x}) => '${x} Transaktionen erfolgreich bearbeitet',
			'transaction.duplicate' => 'Transaktion klonen',
			'transaction.duplicate_short' => 'Klon',
			'transaction.duplicate_warning_message' => 'Eine mit dieser identische Transaktion wird mit demselben Datum erstellt. Möchtest Du fortfahren?',
			'transaction.duplicate_success' => 'Transaktion erfolgreich geklont',
			'transaction.delete' => 'Transaktion löschen',
			'transaction.delete_warning_message' => 'Diese Aktion ist irreversibel. ',
			'transaction.delete_success' => 'Transaktion korrekt gelöscht',
			'transaction.delete_multiple' => 'Transaktionen löschen',
			'transaction.delete_multiple_warning_message' => ({required Object x}) => 'Diese Aktion ist irreversibel und wird entfernt ${x} Transaktionen. ',
			'transaction.delete_multiple_success' => ({required Object x}) => '${x} Transaktionen korrekt gelöscht',
			'transaction.details' => 'Bewegungsdetails',
			'transaction.next_payments.accept' => 'Akzeptieren',
			'transaction.next_payments.skip' => 'Überspringen',
			'transaction.next_payments.skip_success' => 'Transaktion erfolgreich übersprungen',
			'transaction.next_payments.skip_dialog_title' => 'Transaktion überspringen',
			'transaction.next_payments.skip_dialog_msg' => ({required Object date}) => 'Diese Aktion ist irreversibel.  ${date}',
			'transaction.next_payments.accept_today' => 'Akzeptiere noch heute',
			'transaction.next_payments.accept_in_required_date' => ({required Object date}) => 'Akzeptierst Du das gewünschte Datum (${date})',
			'transaction.next_payments.accept_dialog_title' => 'Akzeptierst Du die Transaktion',
			'transaction.next_payments.accept_dialog_msg_single' => 'Der neue Status der Transaktion ist null. ',
			'transaction.next_payments.accept_dialog_msg' => ({required Object date}) => 'Diese Aktion erstellt eine neue Transaktion mit Datum ${date}. Du kannst die Details dieser Transaktion auf der Transaktionsseite überprüfen',
			'transaction.next_payments.recurrent_rule_finished' => 'Die wiederkehrende Regel ist abgeschlossen, es sind keine weiteren Zahlungen mehr zu leisten!',
			'transaction.list.all' => 'Alle Transaktionen',
			'transaction.list.empty' => 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. ',
			'transaction.list.searcher_placeholder' => 'Suche nach Kategorie, Beschreibung...',
			'transaction.list.searcher_no_results' => 'Es wurden keine Transaktionen gefunden, die den Suchkriterien entsprechen',
			'transaction.list.loading' => 'Weitere Transaktionen werden geladen...',
			'transaction.list.selected_short' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} ausgewählt', other: '${n} ausgewählt', ), 
			'transaction.list.selected_long' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Transaktion ausgewählt', other: '${n} Transaktionen ausgewählt', ), 
			'transaction.list.bulk_edit.dates' => 'Daten bearbeiten',
			'transaction.list.bulk_edit.categories' => 'Kategorien bearbeiten',
			'transaction.list.bulk_edit.status' => 'Status bearbeiten',
			'transaction.filters.title' => 'Transaktionsfilter',
			'transaction.filters.from_value' => 'Ab Betrag',
			'transaction.filters.to_value' => 'Bis zum Betrag',
			'transaction.filters.from_value_def' => ({required Object x}) => 'Von ${x}',
			'transaction.filters.to_value_def' => ({required Object x}) => 'Bis zu ${x}',
			'transaction.filters.from_date_def' => ({required Object date}) => 'Von der ${date}',
			'transaction.filters.to_date_def' => ({required Object date}) => 'Bis zum ${date}',
			'transaction.filters.reset' => 'Filter zurücksetzen',
			'transaction.filters.saved.title' => 'Gespeicherte Filter',
			'transaction.filters.saved.new_title' => 'Neuer Filter',
			'transaction.filters.saved.edit_title' => 'Filter bearbeiten',
			'transaction.filters.saved.name_label' => 'Filtername',
			'transaction.filters.saved.name_hint' => 'Mein benutzerdefinierter Filter',
			'transaction.filters.saved.save_dialog_title' => 'Filter speichern',
			'transaction.filters.saved.save_tooltip' => 'Aktuellen Filter speichern',
			'transaction.filters.saved.load_tooltip' => 'Gespeicherten Filter laden',
			'transaction.filters.saved.empty_title' => 'Keine gespeicherten Filter gefunden',
			'transaction.filters.saved.empty_description' => 'Speichern Sie Filter hier, um später schnell darauf zugreifen zu können.',
			'transaction.filters.saved.save_success' => 'Filter erfolgreich gespeichert',
			'transaction.filters.saved.delete_success' => 'Filter erfolgreich gelöscht',
			'transaction.form.validators.zero' => 'Der Wert einer Transaktion kann nicht gleich Null sein',
			'transaction.form.validators.date_max' => 'Das ausgewählte Datum liegt nach dem aktuellen. ',
			'transaction.form.validators.date_after_account_creation' => 'Du kannst keine Transaktion erstellen, deren Datum vor dem Erstellungsdatum des Kontos liegt, zu dem sie gehört',
			'transaction.form.validators.negative_transfer' => 'Der Geldwert einer Überweisung darf nicht negativ sein',
			'transaction.form.validators.transfer_between_same_accounts' => 'Das Ursprungs- und das Zielkonto dürfen nicht identisch sein',
			'transaction.form.title' => 'Transaktionstitel',
			'transaction.form.title_short' => 'Titel',
			'transaction.form.value' => 'Wert der Transaktion',
			'transaction.form.tap_to_see_more' => 'Tippen, um weitere Details anzuzeigen',
			'transaction.form.no_tags' => '– Keine Tags –',
			'transaction.form.description' => 'Beschreibung',
			'transaction.form.description_info' => 'Tippe hier, um eine detailliertere Beschreibung dieser Transaktion einzugeben',
			'transaction.form.exchange_to_preferred_title' => ({required Object currency}) => 'Wechselkurs zu ${currency}',
			'transaction.form.exchange_to_preferred_in_date' => 'Am Transaktionsdatum',
			'transaction.reversed.title' => 'Umgekehrte Transaktion',
			'transaction.reversed.title_short' => 'Umgekehrte Tr.',
			'transaction.reversed.description_for_expenses' => 'Obwohl es sich um eine Spesentransaktion handelt, weist sie einen positiven Betrag auf. ',
			'transaction.reversed.description_for_incomes' => 'Obwohl es sich um eine Einkommenstransaktion handelt, weist sie einen negativen Betrag auf. ',
			'transaction.status.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Status', other: 'Status', ), 
			'transaction.status.display_long' => 'Transaktionsstatus',
			'transaction.status.tr_status' => ({required Object status}) => '${status} Transaktion',
			'transaction.status.none' => 'Ohne Status',
			'transaction.status.none_descr' => 'Transaktion ohne bestimmten Status',
			'transaction.status.reconciled' => 'Ausgeglichen',
			'transaction.status.reconciled_descr' => 'Diese Transaktion wurde bereits validiert und entspricht einer echten Transaktion Deiner Bank',
			'transaction.status.unreconciled' => 'Unausgeglichen',
			'transaction.status.unreconciled_descr' => 'Diese Transaktion wurde noch nicht validiert und erscheint daher noch nicht auf Deinem echten Bankkonten. ',
			'transaction.status.pending' => 'Ausstehend',
			'transaction.status.pending_descr' => 'Diese Transaktion steht noch aus und wird daher bei der Berechnung von Salden und Statistiken nicht berücksichtigt',
			'transaction.status.voided' => 'Entwertet',
			'transaction.status.voided_descr' => 'Transaktion aufgrund eines Zahlungsfehlers oder aus einem anderen Grund ungültig/storniert. ',
			'transaction.types.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Transaktionstyp', other: 'Transaktiontypen', ), 
			'transaction.types.income' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Einkommen', other: 'Einkommen', ), 
			'transaction.types.expense' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Ausgaben', other: 'Ausgaben', ), 
			'transaction.types.transfer' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Überweisen', other: 'Überweisungen', ), 
			'transfer.display' => 'Überweisen',
			'transfer.transfers' => 'Überweisungen',
			'transfer.transfer_to' => ({required Object account}) => 'Überweisen an ${account}',
			'transfer.create' => 'Neue Überweisung',
			'transfer.need_two_accounts_warning_header' => 'Ops!',
			'transfer.need_two_accounts_warning_message' => 'Um diese Aktion auszuführen, sind mindestens zwei Konten erforderlich. Wenn Du den aktuellen Saldo dieses Kontos anpassen oder bearbeiten möchtest, klicke auf die Schaltfläche Bearbeiten',
			'transfer.form.from' => 'Origin-Konto',
			'transfer.form.to' => 'Zielkonto',
			'transfer.form.value_in_destiny.title' => 'Am Zielkonto überwiesener Betrag',
			'transfer.form.value_in_destiny.amount_short' => ({required Object amount}) => '${amount} zum Zielkonto',
			'recurrent_transactions.title' => 'Wiederkehrende Transaktionen',
			'recurrent_transactions.title_short' => 'Wiederk. Transakt.',
			'recurrent_transactions.empty' => 'Anscheinend hast Du keine wiederkehrenden Transaktionen. Erstelle eine monatliche, jährliche oder wöchentliche wiederkehrende Transaktion, die hier angezeigt wird.',
			'recurrent_transactions.total_expense_title' => 'Gesamtausgaben pro Periode',
			'recurrent_transactions.total_expense_descr' => '* Ohne Berücksichtigung des Start- und Enddatums jeder Wiederholung',
			'recurrent_transactions.details.title' => 'Wiederkehrende Transaktion',
			'recurrent_transactions.details.descr' => 'Die nächsten Schritte für diese Transaktion werden unten angezeigt. Du kannst den ersten Schritt akzeptieren oder diesen Schritt auslassen',
			'recurrent_transactions.details.last_payment_info' => 'Diese Bewegung ist die letzte der wiederkehrenden Regel, daher wird diese Regel beim Bestätigen dieser Aktion automatisch gelöscht',
			'recurrent_transactions.details.delete_header' => 'Wiederkehrende Transaktion löschen',
			'recurrent_transactions.details.delete_message' => 'Diese Aktion ist unumkehrbar und hat keinen Einfluss auf Transaktionen, die Du bereits bestätigt/bezahlt habst',
			'recurrent_transactions.status.delayed_by' => ({required Object x}) => 'Verzögert um ${x}d',
			'recurrent_transactions.status.coming_in' => ({required Object x}) => 'In ${x} Tagen',
			'account.details' => 'Kontodaten',
			'account.date' => 'Eröffnungsdatum',
			'account.close_date' => 'Einsendeschluss',
			'account.reopen' => 'Konto erneut eröffnen',
			'account.reopen_short' => 'Wieder öffnen',
			'account.reopen_descr' => 'Möchtest Du dieses Konto wirklich wieder eröffnen?',
			'account.balance' => 'Kontostand',
			'account.n_transactions' => 'Anzahl der Transaktionen',
			'account.add_money' => 'Geld hinzufügen',
			'account.withdraw_money' => 'Geld abheben',
			'account.no_accounts' => 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. Füge eine Transaktion hinzu, indem Du auf die Schaltfläche „+“ am unteren Rand klickst.',
			'account.types.title' => 'Kontotyp',
			'account.types.warning' => 'Sobald der Kontotyp ausgewählt wurde, kann er in Zukunft nicht mehr geändert werden',
			'account.types.normal' => 'Normales Konto',
			'account.types.normal_descr' => 'Nützlich, um Deine täglichen Finanzen aufzuzeichnen. Es ist das gebräuchlichste Konto, das es Dir ermöglicht, Ausgaben, Einnahmen hinzuzufügen',
			'account.types.saving' => 'Sparkonto',
			'account.types.saving_descr' => 'Du kannst nur Geld von anderen Konten einzahlen und abheben. Perfekt geignet, um Geld zu sparen',
			'account.form.name' => 'Kontoname',
			'account.form.name_placeholder' => 'Beispiel: Sparkonto',
			'account.form.notes' => 'Notizen',
			'account.form.notes_placeholder' => 'Gebe einige Notizen/Beschreibungen zu diesem Konto ein',
			'account.form.initial_balance' => 'Anfangssaldo',
			'account.form.current_balance' => 'Aktueller Kontostand',
			'account.form.create' => 'Konto erstellen',
			'account.form.edit' => 'Konto bearbeiten',
			'account.form.currency_not_found_warn' => 'Du hast keine Informationen zu den Wechselkursen für diese Währung. Als Standardwechselkurs wird 1,0 verwendet. Du kannst das in den Einstellungen ändern',
			'account.form.already_exists' => 'Es gibt bereits ein Konto mit demselben Namen, bitte nutze einen anderen',
			'account.form.tr_before_opening_date' => 'Auf diesem Konto liegen Transaktionen vor, deren Datum vor dem Eröffnungsdatum liegt',
			'account.form.iban' => 'IBAN',
			'account.form.swift' => 'SWIFT',
			'account.delete.warning_header' => 'Konto löschen?',
			'account.delete.warning_text' => 'Durch diese Aktion werden dieses Konto und alle seine Transaktionen gelöscht',
			'account.delete.success' => 'Konto erfolgreich gelöscht',
			'account.close.title' => 'Konto schließen',
			'account.close.title_short' => 'Schließen',
			'account.close.warn' => 'Dieses Konto wird in bestimmten Einträgen nicht mehr angezeigt und Du kannst darin keine Transaktionen mit einem späteren als dem unten angegebenen Datum erstellen. Diese Aktion hat keine Auswirkungen auf Transaktionen oder Guthaben, und Du kannst dieses Konto auch jederzeit wieder eröffnen.',
			'account.close.should_have_zero_balance' => 'Um das Konto schließen zu können, muss der aktuelle Kontostand 0 betragen.  Bitte bearbeite das Konto, bevor du fortfährst',
			'account.close.should_have_no_transactions' => 'Auf diesem Konto liegen Transaktionen nach dem angegebenen Schlussdatum vor. Lösche sie oder bearbeite das Datum der Kontoschließung, bevor Du fortfährst',
			'account.close.success' => 'Konto erfolgreich geschlossen',
			'account.close.unarchive_succes' => 'Konto erfolgreich wiedereröffnet',
			'account.select.one' => 'Wähle ein Konto aus',
			'account.select.all' => 'Alle Konten',
			'account.select.multiple' => 'Wähle Konten aus',
			'currencies.currency_converter' => 'Währungsrechner',
			'currencies.currency' => 'Währung',
			'currencies.currency_settings' => 'Währungseinstellungen',
			'currencies.currency_manager' => 'Währungsmanager',
			'currencies.currency_manager_descr' => 'Konfiguriere Deine Währung und deren Wechselkurse mit anderen',
			'currencies.preferred_currency' => 'Bevorzugte/Basis Währung',
			'currencies.tap_to_change_preferred_currency' => 'Zum Ändern tippen',
			'currencies.change_preferred_currency_title' => 'Änder die bevorzugte Währung',
			'currencies.change_preferred_currency_msg' => 'Alle Statistiken und Budgets werden ab sofort in dieser Währung angezeigt. Konten und Transaktionen behalten die Währung, die sie hatten. Alle gespeicherten Wechselkurse werden gelöscht, wenn Du diese Aktion ausführst. Möchtest Du fortfahren?',
			'currencies.exchange_rate_form.equal_to_preferred_warn' => 'Die Währung darf nicht mit der Benutzerwährung übereinstimmen',
			'currencies.exchange_rate_form.override_existing_warn' => 'Für diese Währung existiert für dieses Datum bereits ein Wechselkurs. Wenn Sie fortfahren, wird die vorherige überschrieben',
			'currencies.exchange_rate_form.specify_a_currency' => 'Bitte gib eine Währung an',
			'currencies.exchange_rate_form.add' => 'Wechselkurs hinzufügen',
			'currencies.exchange_rate_form.add_success' => 'Wechselkurs erfolgreich hinzugefügt',
			'currencies.exchange_rate_form.edit' => 'Wechselkurs bearbeiten',
			'currencies.exchange_rate_form.edit_success' => 'Wechselkurs erfolgreich bearbeitet',
			'currencies.exchange_rate_form.remove_all' => 'Alle Wechselkurse löschen',
			'currencies.exchange_rate_form.remove_all_warning' => 'Diese Aktion ist unwiderruflich und löscht alle Wechselkurse für diese Währung',
			'currencies.types.display' => 'Währungstyp',
			'currencies.types.fiat' => 'FIAT',
			'currencies.types.crypto' => 'Kryptowährung',
			'currencies.types.other' => 'Andere',
			'currencies.currency_form.name' => 'Anzeigename',
			'currencies.currency_form.code' => 'Währungscode',
			'currencies.currency_form.symbol' => 'Symbol',
			'currencies.currency_form.decimal_digits' => 'Dezimalstellen',
			'currencies.currency_form.create' => 'Währung erstellen',
			'currencies.currency_form.create_success' => 'Währung erfolgreich erstellt',
			'currencies.currency_form.edit' => 'Währung bearbeiten',
			'currencies.currency_form.edit_success' => 'Währung erfolgreich bearbeitet',
			'currencies.currency_form.delete' => 'Währung löschen',
			'currencies.currency_form.delete_success' => 'Währung erfolgreich gelöscht',
			'currencies.currency_form.already_exists' => 'Eine Währung mit diesem Code existiert bereits. Möglicherweise möchten Sie es bearbeiten',
			'currencies.delete_all_success' => 'Wechselkurse erfolgreich gelöscht',
			'currencies.historical' => 'Historische Kurse',
			'currencies.historical_empty' => 'Für diese Währung wurden keine historischen Wechselkurse gefunden',
			'currencies.exchange_rate' => 'Wechselkurs',
			'currencies.exchange_rates' => 'Wechselkurse',
			'currencies.min_exchange_rate' => 'Mindestwechselkurs',
			'currencies.max_exchange_rate' => 'Maximaler Wechselkurs',
			'currencies.empty' => 'Füge hier Wechselkurse hinzu, damit unsere Diagramme genauer sind, wenn Du Konten in anderen Währungen als Deiner Basiswährung hast',
			'currencies.select_a_currency' => 'Wähle eine Währung aus',
			'currencies.search' => 'Suche nach Name oder Währungscode',
			'tags.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Label', other: 'Schlagworte', ), 
			'tags.form.name' => 'Schlagworte-Name',
			'tags.form.description' => 'Beschreibung',
			'tags.select.title' => 'Schlagworte auswählen',
			'tags.select.all' => 'Alle Schlagworte',
			'tags.empty_list' => 'Du hast noch keine Schlagworte erstellt. Schlagworte und Kategorien sind eine gute Möglichkeit, Deine Bewegungen zu kategorisieren',
			'tags.without_tags' => 'Ohne Schlagworte',
			'tags.add' => 'Schlagwort hinzufügen',
			'tags.create' => 'Label erstellen',
			'tags.create_success' => 'Label erfolgreich erstellt',
			'tags.already_exists' => 'Dieser Schlagwort-Name existiert bereits. ',
			'tags.edit' => 'Schlagwort bearbeiten',
			'tags.edit_success' => 'Schlagwort erfolgreich bearbeitet',
			'tags.delete_success' => 'Kategorie erfolgreich gelöscht',
			'tags.delete_warning_header' => 'Schlagwort löschen?',
			'tags.delete_warning_message' => 'Durch diese Aktion werden keine Transaktionen gelöscht, die dieses Schlagwort haben.',
			'categories.unknown' => 'Unbekannte Kategorie',
			'categories.create' => 'Kategorie erstellen',
			'categories.create_success' => 'Kategorie korrekt erstellt',
			'categories.new_category' => 'Neue Kategorie',
			'categories.already_exists' => 'Der Name dieser Kategorie existiert bereits. Willst du es verändern?',
			'categories.edit' => 'Kategorie bearbeiten',
			'categories.edit_success' => 'Kategorie korrekt bearbeitet',
			'categories.name' => 'Kategoriename',
			'categories.type' => 'Kategorietyp',
			'categories.both_types' => 'Beide Typen',
			'categories.subcategories' => 'Unterkategorien',
			'categories.subcategories_add' => 'Unterkategorie hinzufügen',
			'categories.make_parent' => 'Zur Kategorie hinzufügen',
			'categories.make_child' => 'Erstelle eine Unterkategorie',
			'categories.make_child_warning1' => ({required Object destiny}) => 'Diese Kategorie und ihre Unterkategorien werden zu Unterkategorien von <b>${destiny}</b>.',
			'categories.make_child_warning2' => ({required Object x, required Object destiny}) => 'Deine Transaktionen <b>(${x})</b> werden in die neuen Unterkategorien verschoben, die innerhalb der Kategorie <b>${destiny}</b> erstellt wurden.',
			'categories.make_child_success' => 'Unterkategorien erfolgreich erstellt',
			'categories.merge' => 'Mit einer anderen Kategorie zusammenführen',
			'categories.merge_warning1' => ({required Object x, required Object from, required Object destiny}) => 'Alle Transaktionen (${x}), die mit der Kategorie <b>${from}</b> verknüpft sind werden in die Kategorie <b>${destiny}</b> verschoben',
			'categories.merge_warning2' => ({required Object from}) => 'Die Kategorie <b>${from}</b> werden unwiderruflich gelöscht.',
			'categories.merge_success' => 'Die Kategorie wurde erfolgreich zusammengeführt',
			'categories.delete_success' => 'Kategorie wurde korrekt gelöscht',
			'categories.delete_warning_header' => 'Kategorie löschen?',
			'categories.delete_warning_message' => ({required Object x}) => 'Durch diese Aktion werden alle Transaktionen unwiderruflich gelöscht <b>(${x})</b> im Zusammenhang mit dieser Kategorie.',
			'categories.select.title' => 'Kategorien auswählen',
			'categories.select.select_one' => 'Wähle eine Kategorie aus',
			'categories.select.select_subcategory' => 'Wähle eine Unterkategorie',
			'categories.select.without_subcategory' => 'Ohne Unterkategorie',
			'categories.select.all' => 'Alle Kategorien',
			'categories.select.all_short' => 'Alle',
			'budgets.title' => 'Budgets',
			'budgets.status' => 'Budgetstatus',
			'budgets.repeated' => 'Wiederkehrend',
			'budgets.one_time' => 'Einmalig',
			'budgets.actives' => 'Aktive',
			'budgets.from_budgeted' => 'übrig von ',
			'budgets.days_left' => 'Tage übrig',
			'budgets.days_to_start' => 'Tage bis Start',
			'budgets.since_expiration' => 'Tage seit Ablauf',
			'budgets.no_budgets' => 'Es scheint, dass in diesem Abschnitt keine Budgets angezeigt werden können. Beginne mit der Erstellung eines Budgets, indem Du auf die Schaltfläche unten klickst',
			'budgets.delete' => 'Budget löschen',
			'budgets.delete_warning' => 'Diese Aktion ist irreversibel. ',
			'budgets.form.title' => 'Budget hinzufügen',
			'budgets.form.name' => 'Budgetname',
			'budgets.form.value' => 'Menge begrenzen',
			'budgets.form.create' => 'Budget hinzufügen',
			'budgets.form.create_success' => 'Budget erfolgreich erstellt',
			'budgets.form.edit' => 'Budget bearbeiten',
			'budgets.form.edit_success' => 'Budget erfolgreich bearbeitet',
			'budgets.form.negative_warn' => 'Die Budgets dürfen keinen negativen Betrag haben',
			'budgets.details.title' => 'Budgetdetails',
			'budgets.details.statistics' => 'Statistiken',
			'budgets.details.budget_value' => 'Budgetiert',
			'budgets.details.expend_evolution' => 'Ausgabenentwicklung',
			'budgets.details.no_transactions' => 'Es scheint, dass Du im Zusammenhang mit diesem Budget keine Ausgaben getätigt hast',
			'budgets.target_timeline_statuses.active' => 'Aktives Budget',
			'budgets.target_timeline_statuses.past' => 'Abgeschlossenes Budget',
			'budgets.target_timeline_statuses.future' => 'Zukünftiges Budget',
			'budgets.progress.labels.active_on_track' => 'Auf Kurs',
			'budgets.progress.labels.active_overspending' => 'Mehrausgaben',
			'budgets.progress.labels.active_indeterminate' => 'Aktiv',
			'budgets.progress.labels.success' => 'Erreicht',
			'budgets.progress.labels.fail' => 'Budget überschritten',
			'budgets.progress.description.active_on_track' => ({required Object dailyAmount, required Object remainingDays}) => 'Sie können ${dailyAmount} pro Tag für die verbleibenden ${remainingDays} Tage ausgeben',
			'budgets.progress.description.active_overspending' => ({required Object dailyAmount, required Object remainingDays}) => 'Um wieder auf Kurs zu kommen, sollten Sie Ihre Ausgaben auf ${dailyAmount} pro Tag für die verbleibenden ${remainingDays} Tage begrenzen',
			'budgets.progress.description.active_indeterminate' => ({required Object amount}) => 'Sie haben noch ${amount} zum Ausgeben übrig.',
			'budgets.progress.description.active_exceeded' => ({required Object amount}) => 'Sie haben Ihr Budgetlimit bereits um ${amount} überschritten. Wenn Sie keine Einnahmen für dieses Budget finden, sollten Sie für den Rest des Zeitraums keine Ausgaben mehr tätigen',
			'budgets.progress.description.success' => 'Gute Arbeit! Dieses Budget wurde erfolgreich abgeschlossen. Erstellen Sie weiterhin Budgets, um Ihre Ausgaben zu verwalten',
			'budgets.progress.description.fail' => ({required Object amount}) => 'Sie haben das Budget um ${amount} überschritten. Versuchen Sie beim nächsten Mal vorsichtiger zu sein!',
			'goals.title' => 'Ziele',
			'goals.status' => 'Zielstatus',
			'goals.type.display' => 'Zieltyp',
			'goals.type.income.title' => 'Sparziel',
			'goals.type.income.descr' => 'Ideal zum Sparen. Du bist erfolgreich, wenn der Saldo dein Ziel übersteigt.',
			'goals.type.expense.title' => 'Ausgabenziel',
			'goals.type.expense.descr' => 'Verfolge, wie viel du ausgibst, und versuche, einen Zielbetrag zu erreichen. Gut für Spenden, Wohltätigkeit...',
			'goals.empty_title' => 'Keine Ziele gefunden',
			'goals.empty_description' => 'Erstellen Sie ein neues Ziel, um Ihre Ersparnisse zu verfolgen!',
			'goals.delete' => 'Ziel löschen',
			'goals.delete_warning' => 'Diese Aktion ist unwiderruflich. Kategorien und Transaktionen, die sich auf dieses Ziel beziehen, werden nicht gelöscht.',
			'goals.form.new_title' => 'Neues Ziel',
			'goals.form.edit_title' => 'Ziel bearbeiten',
			'goals.form.target_amount' => 'Zielbetrag',
			'goals.form.initial_amount' => 'Anfangsbetrag',
			_ => null,
		} ?? switch (path) {
			'goals.form.name' => 'Name',
			'goals.form.name_hint' => 'Mein Sparziel',
			'goals.form.create_success' => 'Ziel erfolgreich erstellt',
			'goals.form.edit_success' => 'Ziel erfolgreich bearbeitet',
			'goals.form.negative_warn' => 'Der Zielbetrag kann nicht negativ sein',
			'goals.details.title' => 'Zieldetails',
			'goals.details.statistics' => 'Statistiken',
			'goals.details.goal_value' => 'Zielwert',
			'goals.details.evolution' => 'Entwicklung',
			'goals.details.no_transactions' => 'Es scheint, dass Sie keine Transaktionen im Zusammenhang mit diesem Ziel getätigt haben',
			'goals.target_timeline_statuses.active' => 'Aktives Ziel',
			'goals.target_timeline_statuses.past' => 'Abgeschlossenes Ziel',
			'goals.target_timeline_statuses.future' => 'Zukünftiges Ziel',
			'goals.progress.labels.active_on_track' => 'Auf dem richtigen Weg',
			'goals.progress.labels.active_behind_schedule' => 'Hinter dem Zeitplan',
			'goals.progress.labels.active_indeterminate' => 'Aktiv',
			'goals.progress.labels.success' => 'Ziel erreicht',
			'goals.progress.labels.fail' => 'Ziel gescheitert',
			'goals.progress.description.active_on_track' => ({required Object remainingDays, required Object dailyAmount}) => 'Sie sind auf dem richtigen Weg, Ihr Ziel zu erreichen! Sie müssen für die verbleibenden ${remainingDays} Tage pro Tag ${dailyAmount} sparen',
			'goals.progress.description.active_behind_schedule' => ({required Object dailyAmount, required Object remainingDays}) => 'Sie sind im Rückstand. Sie müssen ${dailyAmount} pro Tag sparen, um Ihr Ziel in ${remainingDays} Tagen zu erreichen',
			'goals.progress.description.active_indeterminate' => ({required Object amount}) => 'Sie benötigen ${amount} mehr, um Ihr Ziel zu erreichen.',
			'goals.progress.description.success' => 'Glückwunsch! Du hast dein Ziel erreicht.',
			'goals.progress.description.fail' => ({required Object amount}) => 'Sie haben Ihr Ziel um ${amount} verfehlt.',
			'debts.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Schulden', other: 'Schulden', ), 
			'debts.form.name' => 'Schuldenname',
			'debts.form.initial_amount' => 'Anfangsbetrag',
			'debts.form.step_initial_value' => 'Anfangswert',
			'debts.form.step_details' => 'Einzelheiten',
			'debts.form.from_transaction.title' => 'Aus einer Transaktion',
			'debts.form.from_transaction.select' => 'Wählen Sie eine Transaktion aus',
			'debts.form.from_transaction.tap_to_select' => 'Tippen Sie, um eine Transaktion auszuwählen',
			'debts.form.from_amount.title' => 'Ab einem Anfangsbetrag',
			'debts.form.from_amount.description' => 'Dieser Betrag wird in der Statistik nicht als Aufwand/Ertrag berücksichtigt. Es wird zur Berechnung der Salden und des Nettovermögens verwendet',
			'debts.direction.lent' => 'Verliehen',
			'debts.direction.borrowed' => 'Entlehnt',
			'debts.status.active' => 'Aktiv',
			'debts.status.close' => 'Geschlossen',
			'debts.details.collected_amount' => 'Gesammelter Betrag',
			'debts.details.remaining' => 'Übrig',
			'debts.details.no_deadline' => 'Keine Frist',
			'debts.details.in_days' => ({required Object x}) => 'In ${x} Tagen',
			'debts.details.due_today' => 'Heute fällig',
			'debts.details.days_ago' => ({required Object x}) => 'Vor ${x} Tagen',
			'debts.details.overdue_by' => ({required Object x}) => 'Um ${x} Tage überfällig',
			'debts.details.per_day' => '/ Tag',
			'debts.details.no_transactions' => 'Für diese Schuld wurden keine Transaktionen gefunden',
			'debts.empty.no_debts_active' => 'Keine aktiven Schulden gefunden. Erstellen Sie zunächst eine neue Schuld, indem Sie auf die Schaltfläche unten klicken',
			'debts.empty.no_debts_closed' => 'Keine geschlossenen Schulden gefunden. Eine Schuld gilt als beglichen, wenn Sie das gesamte Geld eingezogen oder den gesamten geschuldeten Betrag beglichen haben.',
			'debts.actions.edit.title' => 'Schulden bearbeiten',
			'debts.actions.edit.success' => 'Schulden erfolgreich bearbeitet',
			'debts.actions.delete.warning_header' => 'Diese Schulden löschen?',
			'debts.actions.delete.warning_text' => 'Diese Aktion kann nicht rückgängig gemacht werden. Verknüpfte Transaktionen werden nicht gelöscht, sind aber nicht mehr mit dieser Schuld verknüpft.',
			'debts.actions.add_register.title' => 'Fügen Sie Bewegung hinzu',
			'debts.actions.add_register.success' => 'Bewegung erfolgreich hinzugefügt',
			'debts.actions.add_register.fab_label' => 'Register hinzufügen',
			'debts.actions.add_register.modal_title' => 'Register zu dieser Schuld hinzufügen',
			'debts.actions.add_register.modal_subtitle' => 'Wählen Sie eine der folgenden Optionen, um eine Transaktion mit dieser Schuld zu verknüpfen',
			'debts.actions.link_transaction.title' => 'Bestehende Transaktion verknüpfen',
			'debts.actions.link_transaction.description' => 'Wählen Sie einen vorhandenen Datensatz aus, um ihn mit dieser Schuld zu verknüpfen',
			'debts.actions.link_transaction.success' => 'Mit Schulden verbundene Transaktion',
			'debts.actions.link_transaction.creating' => ({required Object name}) => 'Sie erstellen eine Transaktion, die mit der Schuld <b>${name}</b> verknüpft ist',
			'debts.actions.new_transaction.title' => 'Neue Transaktion hinzufügen',
			'debts.actions.new_transaction.description' => 'Fügen Sie die Schulden manuell hinzu oder reduzieren Sie sie, indem Sie eine neue Transaktion erstellen, die mit dieser Schuld verknüpft ist',
			'debts.actions.create.title' => 'Schulden machen',
			'debts.actions.create.success' => 'Schulden erfolgreich erstellt',
			'target_timeline_statuses.active' => 'Aktiv',
			'target_timeline_statuses.past' => 'Abgeschlossen',
			'target_timeline_statuses.future' => 'Zukunft',
			'backup.no_file_selected' => 'Keine Datei ausgewählt',
			'backup.no_directory_selected' => 'Kein Verzeichnis ausgewählt',
			'backup.export.title' => 'Daten exportieren',
			'backup.export.title_short' => 'Export',
			'backup.export.type_of_export' => 'Art des Exports',
			'backup.export.other_options' => 'Optionen',
			'backup.export.all' => 'Vollständige Sicherung',
			'backup.export.all_descr' => 'Exportiere alle Deine Daten (Konten, Transaktionen, Budgets, Einstellungen...). ',
			'backup.export.transactions' => 'Sicherung der Transaktionen',
			'backup.export.transactions_descr' => 'Exportiere Deine Transaktionen im CSV-Format, damit Du sie einfacher in anderen Programmen oder Anwendungen analysieren kannst.',
			'backup.export.transactions_to_export' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '1 Transaktion zum Exportieren', other: '${n} Transaktionen zum Exportieren', ), 
			'backup.export.description' => 'Lade Deine Daten in verschiedenen Formaten herunter',
			'backup.export.send_file' => 'Datei senden',
			'backup.export.see_folder' => 'Siehe Ordner',
			'backup.export.success' => ({required Object x}) => 'Datei erfolgreich gespeichert/heruntergeladen in ${x}',
			'backup.export.error' => 'Fehler beim Herunterladen der Datei. ',
			'backup.export.dialog_title' => 'Datei speichern/senden',
			'backup.import.title' => 'Daten importieren',
			'backup.import.title_short' => 'Import',
			'backup.import.restore_backup' => 'Sicherung wiederherstellen',
			'backup.import.restore_backup_descr' => 'Importiere eine zuvor gespeicherte Datenbank von Monekin. Diese Aktion ersetzt alle aktuellen Anwendungsdaten durch die neuen Daten',
			'backup.import.restore_backup_warn_description' => 'Beim Importieren einer neuen Datenbank gehen alle derzeit in der App gespeicherten Daten verloren. Es wird empfohlen, eine Sicherungskopie zu erstellen, bevor Du fortfährst. Lade hier keine Dateien hoch, deren Herkunft Du nicht kennst. Lade nur Dateien hoch, die Du zuvor von Monekin heruntergeladen hast.',
			'backup.import.restore_backup_warn_title' => 'Alle Daten überschreiben',
			'backup.import.select_other_file' => 'Andere Datei auswählen',
			'backup.import.tap_to_select_file' => 'Tippe, um eine Datei auszuwählen',
			'backup.import.manual_import.title' => 'Manueller Import',
			'backup.import.manual_import.descr' => 'Importiere Transaktionen manuell aus einer CSV-Datei',
			'backup.import.manual_import.default_account' => 'Standardkonto',
			'backup.import.manual_import.remove_default_account' => 'Standardkonto entfernen',
			'backup.import.manual_import.default_category' => 'Standardkategorie',
			'backup.import.manual_import.select_a_column' => 'Wählen eine Spalte aus der CSV-Datei aus',
			'backup.import.manual_import.steps.0' => 'Wähle Deine Datei aus',
			'backup.import.manual_import.steps.1' => 'Spalte für Menge',
			'backup.import.manual_import.steps.2' => 'Spalte für Konto',
			'backup.import.manual_import.steps.3' => 'Spalte für Kategorie',
			'backup.import.manual_import.steps.4' => 'Spalte für Datum',
			'backup.import.manual_import.steps.5' => 'andere Spalten',
			'backup.import.manual_import.steps_descr.0' => 'Wähle eine CSV-Datei von Deinem Gerät aus. Stelle sicher, dass die erste Zeile den Namen der einzelnen Spalten enthält',
			'backup.import.manual_import.steps_descr.1' => 'Wählen die Spalte aus, in der der Wert jeder Transaktion angegeben ist. Verwende negative Werte für Ausgaben und positive Werte für Einnahmen.',
			'backup.import.manual_import.steps_descr.2' => 'Wähle die Spalte aus, in der das Konto angegeben ist, zu dem jede Transaktion gehört. Du kannst auch ein Standardkonto auswählen, falls wir das von Dir gewünschte Konto nicht finden können. Wenn Du kein Standardkonto angibst, wird eines mit demselben Namen erstellt ',
			'backup.import.manual_import.steps_descr.3' => 'Gebe die Spalte an, in der sich der Name der Transaktionskategorie befindet. Du musst eine Standardkategorie angeben, damit wir diese Kategorie den Transaktionen zuordnen können, falls die Kategorie nicht gefunden werden kann.',
			'backup.import.manual_import.steps_descr.4' => 'Wähle die Spalte aus, in der das Datum jeder Transaktion angegeben ist. Wird nichts angegeben, werden die Transaktionen mit dem aktuellen Datum erstellt.',
			'backup.import.manual_import.steps_descr.5' => 'Gibt die Spalten für andere optionale Transaktionsattribute an',
			'backup.import.manual_import.success' => ({required Object x}) => 'Erfolgreich ${x} Transaktionen importiert',
			'backup.import.success' => 'Der Import wurde erfolgreich durchgeführt',
			'backup.import.error' => 'Fehler beim Importieren der Datei. Bitte kontaktiere den Entwickler lozin.technologies@gmail.com',
			'backup.import.cancelled' => 'Der Import wurde vom Benutzer abgebrochen',
			'backup.about.title' => 'Informationen zu Deiner Datenbank',
			'backup.about.create_date' => 'Erstellungsdatum',
			'backup.about.modify_date' => 'Zuletzt geändert',
			'backup.about.last_backup' => 'Letzte Sicherung',
			'backup.about.size' => 'Größe',
			'settings.title_long' => 'Einstellungen & Anpassung',
			'settings.title_short' => 'Einstellungen',
			'settings.description' => 'Thema, Sprache, Daten und mehr',
			'settings.edit_profile' => 'Profil bearbeiten',
			'settings.general.menu_title' => 'Allgemeine Einstellungen',
			'settings.general.menu_descr' => 'Sprache, Datenschutz und mehr',
			'settings.general.show_all_decimals' => 'Alle Nachkommastellen anzeigen',
			'settings.general.show_all_decimals_descr' => 'Alle Dezimalstellen anzeigen, auch bei nachgestellten Nullen',
			'settings.general.language.section' => 'Sprache und Texte',
			'settings.general.language.title' => 'App-Sprache',
			'settings.general.language.descr' => 'Sprache, in der die Texte in der App angezeigt werden',
			'settings.general.language.help' => 'Wenn an den Übersetzungen dieser App mitarbeiten möchten, kannst du dich an <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>unser Beschreibung</a> wenden',
			'settings.general.locale.title' => 'Region',
			'settings.general.locale.auto' => 'System',
			'settings.general.locale.descr' => 'Lege das für Datumsangaben, Zahlen usw. zu verwendende Format fest.',
			'settings.general.locale.warn' => 'Wenn Du die Region änderst, wird die App aktualisiert',
			'settings.general.locale.first_day_of_week' => 'Erster Tag der Woche',
			'settings.security.title' => 'Sicherheit',
			'settings.security.private_mode_at_launch' => 'Privatmodus beim Start',
			'settings.security.private_mode_at_launch_descr' => 'Starte die App standardmäßig im privaten Modus',
			'settings.security.private_mode' => 'Privatmodus',
			'settings.security.private_mode_descr' => 'Alle Geldwerte ausblenden',
			'settings.security.private_mode_activated' => 'Privatmodus aktiviert',
			'settings.security.private_mode_deactivated' => 'Privatmodus deaktiviert',
			'settings.transactions.menu_title' => 'Transaktionen',
			'settings.transactions.menu_descr' => 'Konfigurieren Sie das Verhalten Ihrer Transaktionen',
			'settings.transactions.title' => 'Transaktionseinstellungen',
			'settings.transactions.style.title' => 'Transaktionsstil',
			'settings.transactions.style.subtitle' => 'Konfigurieren Sie das Aussehen von Transaktionen in Listen',
			'settings.transactions.style.show_tags' => 'Tags anzeigen',
			'settings.transactions.style.show_time' => 'Zeit anzeigen',
			'settings.transactions.swipe_actions.title' => 'Wischaktionen',
			'settings.transactions.swipe_actions.choose_description' => 'Wählen Sie aus, welche Aktion ausgelöst wird, wenn Sie mit dieser Wischrichtung über ein Transaktionselement in der Liste wischen',
			'settings.transactions.swipe_actions.swipe_left' => 'Wischen Sie nach links',
			'settings.transactions.swipe_actions.swipe_right' => 'Wischen Sie nach rechts',
			'settings.transactions.swipe_actions.none' => 'Keine Aktion',
			'settings.transactions.swipe_actions.toggle_reconciled' => 'Toggle abgeglichen',
			'settings.transactions.swipe_actions.toggle_pending' => 'Umschalten steht aus',
			'settings.transactions.swipe_actions.toggle_voided' => 'Umschalten ungültig',
			'settings.transactions.swipe_actions.toggle_unreconciled' => 'Nicht abgestimmt umschalten',
			'settings.transactions.swipe_actions.remove_status' => 'Status entfernen',
			'settings.transactions.default_values.title' => 'Default Form Values',
			'settings.transactions.default_values.page_title' => 'New Transaction: Default Form Values',
			'settings.transactions.default_values.reuse_last_transaction' => 'Reuse Last Transaction Values',
			'settings.transactions.default_values.reuse_last_transaction_descr' => 'Automatically fill the form with some values from the last created transaction',
			'settings.transactions.default_values.fields_to_reuse' => 'Fields to reuse',
			'settings.transactions.default_values.reuse_last_values_modal_descr' => 'Select the fields that should be pre-filled with the values from the last created transaction.',
			'settings.transactions.default_values.default_values_separator' => 'Default Values',
			'settings.transactions.default_values.default_category' => 'Default Category',
			'settings.transactions.default_values.default_status' => 'Default Status',
			'settings.transactions.default_values.default_tags' => 'Default Tags',
			'settings.transactions.default_values.no_tags_selected' => 'No tags selected',
			'settings.transactions.default_type.title' => 'Default Type',
			'settings.transactions.default_type.modal_title' => 'Select Default Type',
			'settings.appearance.menu_title' => 'Thema & Stil',
			'settings.appearance.menu_descr' => 'Themenauswahl, Farben und andere Dinge im Zusammenhang mit dem Erscheinungsbild der App',
			'settings.appearance.theme_and_colors' => 'Thema und Farben',
			'settings.appearance.theme.title' => 'Thema',
			'settings.appearance.theme.auto' => 'System',
			'settings.appearance.theme.light' => 'Hell',
			'settings.appearance.theme.dark' => 'Dunkel',
			'settings.appearance.amoled_mode' => 'AMOLED-Modus',
			'settings.appearance.amoled_mode_descr' => 'Verwende nach Möglichkeit einn rein schwarzen Hintergrund. Das wird den Akku von Geräten mit AMOLED-Bildschirmen etwas schonen.',
			'settings.appearance.dynamic_colors' => 'Dynamische Farben',
			'settings.appearance.dynamic_colors_descr' => 'Verwende wann immer möglich die Akzentfarbe des Systems',
			'settings.appearance.accent_color' => 'Akzentfarbe',
			'settings.appearance.accent_color_descr' => 'Wähle die Farbe aus, mit der die App bestimmte Teile der Benutzeroberfläche hervorhebt',
			'settings.appearance.text' => 'Text',
			'settings.appearance.font' => 'Schriftart',
			'settings.appearance.font_platform' => 'Plattform',
			'more.title' => 'Mehr',
			'more.title_long' => 'Weitere Aktionen',
			'more.data.display' => 'Daten',
			'more.data.display_descr' => 'Exportiere und importiere Deine Daten, damit Du nichts verlierst',
			'more.data.delete_all' => 'Meine Daten löschen',
			'more.data.delete_all_header1' => 'Höre genau dort auf, Padawan ⚠️⚠️',
			'more.data.delete_all_message1' => 'Bist Du sicher, dass Du fortfahren möchtest? Alle Daten werden endgültig gelöscht und können nicht wiederhergestellt werden.',
			'more.data.delete_all_header2' => 'Ein letzter Schritt ⚠️⚠️',
			'more.data.delete_all_message2' => 'Durch das Löschen eines Kontos löschst Du alle Deine gespeicherten persönlichen Daten. Deine Konten, Transaktionen, Budgets und Kategorien werden gelöscht und können nicht wiederhergestellt werden. Bist Du damit einverstanden?',
			'more.about_us.display' => 'App-Informationen',
			'more.about_us.description' => 'Finden Sie die Bedingungen von Monekin und wichtige Informationen, und nehmen Sie Kontakt auf, um Fehler zu melden oder Ideen zu teilen',
			'more.about_us.legal.display' => 'Rechtliche Informationen',
			'more.about_us.legal.privacy' => 'Datenschutzrichtlinie',
			'more.about_us.legal.terms' => 'Nutzungsbedingungen',
			'more.about_us.legal.licenses' => 'Lizenzen',
			'more.about_us.project.display' => 'Projekt',
			'more.about_us.project.contributors' => 'Mitarbeiter',
			'more.about_us.project.contributors_descr' => 'Alle Entwickler, die Monekin wachsen lassen haben',
			'more.about_us.project.contact' => 'Kontaktiere uns',
			'more.help_us.display' => 'Hilf uns',
			'more.help_us.description' => 'Finde heraus, wie Du Monekin dabei helfen kannst, immer besser zu werden',
			'more.help_us.rate_us' => 'Bewerte uns',
			'more.help_us.rate_us_descr' => 'Jede Hilfe ist willkommen!',
			'more.help_us.share' => 'Teile  Monekin',
			'more.help_us.share_descr' => 'Teile  unsere App mit Freunden und Familie',
			'more.help_us.share_text' => 'Monekin! ',
			'more.help_us.thanks' => 'Danke schön!',
			'more.help_us.thanks_long' => 'Deine Beiträge zu Monekin und anderen großen und kleinen Open-Source-Projekten machen großartige Projekte wie dieses möglich. Danke, dass Du dir die Zeit nimmst teilzunehmen',
			'more.help_us.donate' => 'Mache eine Spende',
			'more.help_us.donate_descr' => 'Mit Deiner Spende trägst dazu bei, dass die App weiterhin verbessert wird. Was gibt es Schöneres, als sich für die geleistete Arbeit zu bedanken, indem man mich zu einem Kaffee einlädt?',
			'more.help_us.donate_success' => 'Spende erfolgt. Herzlichen Dank für Deine Beitrag! ❤️',
			'more.help_us.donate_err' => 'Hoppla! Es scheint ein Fehler beim Empfang Deiner Zahlung aufgetreten zu sein',
			'more.help_us.report' => 'Melde Fehler, hinterlasse Vorschläge ...',
			_ => null,
		};
	}
}

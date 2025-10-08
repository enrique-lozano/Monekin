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
class TranslationsDe implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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

	late final TranslationsDe _root = this; // ignore: unused_field

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
	@override String get details => 'Details';
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
	@override String get balance => 'Kontostand';
	@override String get account => 'Konto';
	@override String get accounts => 'Konten';
	@override String get categories => 'Kategorien';
	@override String get category => 'Kategorie';
	@override String get today => 'Heute';
	@override String get yesterday => 'Gestern';
	@override String get filters => 'Filter';
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
class _TranslationsBackupDe implements TranslationsBackupEn {
	_TranslationsBackupDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportDe export = _TranslationsBackupExportDe._(_root);
	@override late final _TranslationsBackupImportDe import = _TranslationsBackupImportDe._(_root);
	@override late final _TranslationsBackupAboutDe about = _TranslationsBackupAboutDe._(_root);
}

// Path: settings
class _TranslationsSettingsDe implements TranslationsSettingsEn {
	_TranslationsSettingsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
	@override String get locale_auto => 'System';
	@override String get locale_descr => 'Lege das für Datumsangaben, Zahlen usw. zu verwendende Format fest.';
	@override String get locale_warn => 'Wenn Du die Region änderst, wird die App aktualisiert';
	@override String get first_day_of_week => 'Erster Tag der Woche';
	@override String get theme_and_colors => 'Thema und Farben';
	@override String get theme => 'Thema';
	@override String get theme_auto => 'System';
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
	@override String get from_value => 'Ab Betrag';
	@override String get to_value => 'Bis zum Betrag';
	@override String from_value_def({required Object x}) => 'Von ${x}';
	@override String to_value_def({required Object x}) => 'Bis zu ${x}';
	@override String from_date_def({required Object date}) => 'Von der ${date}';
	@override String to_date_def({required Object date}) => 'Bis zum ${date}';
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

// Path: currencies.form
class _TranslationsCurrenciesFormDe implements TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'Die Währung darf nicht mit der Benutzerwährung übereinstimmen';
	@override String get specify_a_currency => 'Bitte gib eine Währung an';
	@override String get add => 'Wechselkurs hinzufügen';
	@override String get add_success => 'Wechselkurs erfolgreich hinzugefügt';
	@override String get edit => 'Wechselkurs bearbeiten';
	@override String get edit_success => 'Wechselkurs erfolgreich bearbeitet';
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
	@override String get edit => 'Budget bearbeiten';
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
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Du kannst ${dailyAmount}/Tag für ${remainingDays} verbleibende Tage ausgeben';
	@override String get expend_evolution => 'Ausgabenentwicklung';
	@override String get no_transactions => 'Es scheint, dass Du im Zusammenhang mit diesem Budget keine Ausgaben getätigt hast';
}

// Path: backup.export
class _TranslationsBackupExportDe implements TranslationsBackupExportEn {
	_TranslationsBackupExportDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

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
	@override String get cancelled => 'Der Import wurde vom Benutzer abgebrochen';
	@override String get error => 'Fehler beim Importieren der Datei. Bitte kontaktiere den Entwickler lozin.technologies@gmail.com';
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
	@override String get description => 'Schaue Dir die Bedingungen und andere relevante Informationen über Monekin an. Treten mit der Community in Kontakt, indem Du Fehler meldest, Vorschläge machst...';
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
		'Wählen die Spalte aus, in der der Wert jeder Transaktion angegeben ist. Verwende negative Werte für Ausgaben und positive Werte für Einnahmen. Verwende einen Punkt als Dezimaltrennzeichen',
		'Wähle die Spalte aus, in der das Konto angegeben ist, zu dem jede Transaktion gehört. Du kannst auch ein Standardkonto auswählen, falls wir das von Dir gewünschte Konto nicht finden können. Wenn Du kein Standardkonto angibst, wird eines mit demselben Namen erstellt ',
		'Gebe die Spalte an, in der sich der Name der Transaktionskategorie befindet. Du musst eine Standardkategorie angeben, damit wir diese Kategorie den Transaktionen zuordnen können, falls die Kategorie nicht gefunden werden kann.',
		'Wähle die Spalte aus, in der das Datum jeder Transaktion angegeben ist. Wird nichts angegeben, werden die Transaktionen mit dem aktuellen Datum erstellt.',
		'Gibt die Spalten für andere optionale Transaktionsattribute an',
	];
	@override String success({required Object x}) => 'Erfolgreich ${x} Transaktionen importiert';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return 'Abbrechen';
			case 'ui_actions.confirm': return 'Bestätigen';
			case 'ui_actions.continue_text': return 'Weiter';
			case 'ui_actions.save': return 'Speichern';
			case 'ui_actions.save_changes': return 'Änderungen speichern';
			case 'ui_actions.close_and_save': return 'Speichern und schließen';
			case 'ui_actions.add': return 'Hinzufügen';
			case 'ui_actions.edit': return 'Bearbeiten';
			case 'ui_actions.delete': return 'Löschen';
			case 'ui_actions.see_more': return 'Mehr anzeigen';
			case 'ui_actions.select_all': return 'Alles auswählen';
			case 'ui_actions.deselect_all': return 'Alles abwählen';
			case 'ui_actions.select': return 'Auswählen';
			case 'ui_actions.search': return 'Suchen';
			case 'ui_actions.filter': return 'Filtern';
			case 'ui_actions.reset': return 'Zurücksetzen';
			case 'ui_actions.submit': return 'Absenden';
			case 'ui_actions.next': return 'Weiter';
			case 'ui_actions.previous': return 'Zurück';
			case 'ui_actions.back': return 'Zurück';
			case 'ui_actions.reload': return 'Neu laden';
			case 'ui_actions.view': return 'Ansehen';
			case 'ui_actions.download': return 'Herunterladen';
			case 'ui_actions.upload': return 'Hochladen';
			case 'ui_actions.retry': return 'Erneut versuchen';
			case 'ui_actions.copy': return 'Kopieren';
			case 'ui_actions.paste': return 'Einfügen';
			case 'ui_actions.undo': return 'Rückgängig';
			case 'ui_actions.redo': return 'Wiederholen';
			case 'ui_actions.open': return 'Öffnen';
			case 'ui_actions.close': return 'Schließen';
			case 'ui_actions.apply': return 'Anwenden';
			case 'ui_actions.discard': return 'Verwerfen';
			case 'ui_actions.refresh': return 'Aktualisieren';
			case 'ui_actions.details': return 'Details';
			case 'ui_actions.share': return 'Teilen';
			case 'general.or': return 'oder';
			case 'general.understood': return 'Verstanden';
			case 'general.unspecified': return 'Nicht spezifiziert';
			case 'general.quick_actions': return 'Schnelle Aktionen';
			case 'general.balance': return 'Kontostand';
			case 'general.account': return 'Konto';
			case 'general.accounts': return 'Konten';
			case 'general.categories': return 'Kategorien';
			case 'general.category': return 'Kategorie';
			case 'general.today': return 'Heute';
			case 'general.yesterday': return 'Gestern';
			case 'general.filters': return 'Filter';
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
			case 'settings.locale_auto': return 'System';
			case 'settings.locale_descr': return 'Lege das für Datumsangaben, Zahlen usw. zu verwendende Format fest.';
			case 'settings.locale_warn': return 'Wenn Du die Region änderst, wird die App aktualisiert';
			case 'settings.first_day_of_week': return 'Erster Tag der Woche';
			case 'settings.theme_and_colors': return 'Thema und Farben';
			case 'settings.theme': return 'Thema';
			case 'settings.theme_auto': return 'System';
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


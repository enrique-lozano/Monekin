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
	@override String get font => 'Schriftart';
	@override String get font_platform => 'Plattform';
	@override late final _TranslationsSettingsSwipeActionsDe swipe_actions = _TranslationsSettingsSwipeActionsDe._(_root);
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

// Path: settings.swipe_actions
class _TranslationsSettingsSwipeActionsDe implements TranslationsSettingsSwipeActionsEn {
	_TranslationsSettingsSwipeActionsDe._(this._root);

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

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = 'Abbrechen';
		map['ui_actions.confirm'] = 'Bestätigen';
		map['ui_actions.continue_text'] = 'Weiter';
		map['ui_actions.save'] = 'Speichern';
		map['ui_actions.save_changes'] = 'Änderungen speichern';
		map['ui_actions.close_and_save'] = 'Speichern und schließen';
		map['ui_actions.add'] = 'Hinzufügen';
		map['ui_actions.edit'] = 'Bearbeiten';
		map['ui_actions.delete'] = 'Löschen';
		map['ui_actions.see_more'] = 'Mehr anzeigen';
		map['ui_actions.select_all'] = 'Alles auswählen';
		map['ui_actions.deselect_all'] = 'Alles abwählen';
		map['ui_actions.select'] = 'Auswählen';
		map['ui_actions.search'] = 'Suchen';
		map['ui_actions.filter'] = 'Filtern';
		map['ui_actions.reset'] = 'Zurücksetzen';
		map['ui_actions.submit'] = 'Absenden';
		map['ui_actions.next'] = 'Weiter';
		map['ui_actions.previous'] = 'Zurück';
		map['ui_actions.back'] = 'Zurück';
		map['ui_actions.reload'] = 'Neu laden';
		map['ui_actions.view'] = 'Ansehen';
		map['ui_actions.download'] = 'Herunterladen';
		map['ui_actions.upload'] = 'Hochladen';
		map['ui_actions.retry'] = 'Erneut versuchen';
		map['ui_actions.copy'] = 'Kopieren';
		map['ui_actions.paste'] = 'Einfügen';
		map['ui_actions.undo'] = 'Rückgängig';
		map['ui_actions.redo'] = 'Wiederholen';
		map['ui_actions.open'] = 'Öffnen';
		map['ui_actions.close'] = 'Schließen';
		map['ui_actions.apply'] = 'Anwenden';
		map['ui_actions.discard'] = 'Verwerfen';
		map['ui_actions.refresh'] = 'Aktualisieren';
		map['ui_actions.details'] = 'Details';
		map['ui_actions.share'] = 'Teilen';
		map['general.or'] = 'oder';
		map['general.understood'] = 'Verstanden';
		map['general.unspecified'] = 'Nicht spezifiziert';
		map['general.quick_actions'] = 'Schnelle Aktionen';
		map['general.balance'] = 'Kontostand';
		map['general.account'] = 'Konto';
		map['general.accounts'] = 'Konten';
		map['general.categories'] = 'Kategorien';
		map['general.category'] = 'Kategorie';
		map['general.today'] = 'Heute';
		map['general.yesterday'] = 'Gestern';
		map['general.filters'] = 'Filter';
		map['general.empty_warn'] = 'Ops! Das ist sehr leer';
		map['general.insufficient_data'] = 'Unzureichende Daten';
		map['general.show_more_fields'] = 'Weitere Felder anzeigen';
		map['general.show_less_fields'] = 'Weniger Felder anzeigen';
		map['general.tap_to_search'] = 'Zum Suchen tippen';
		map['general.clipboard.success'] = ({required Object x}) => '${x} in die Zwischenablage kopiert';
		map['general.clipboard.error'] = 'Fehler beim Kopieren';
		map['general.time.start_date'] = 'Startdatum';
		map['general.time.end_date'] = 'Enddatum';
		map['general.time.from_date'] = 'Ab Datum';
		map['general.time.until_date'] = 'Bis heute';
		map['general.time.date'] = 'Datum';
		map['general.time.datetime'] = 'Datum/Uhrzeit';
		map['general.time.time'] = 'Zeit';
		map['general.time.each'] = 'Jede';
		map['general.time.after'] = 'Nach';
		map['general.time.ranges.display'] = 'Zeitbereich';
		map['general.time.ranges.it_repeat'] = 'Wiederholt';
		map['general.time.ranges.it_ends'] = 'Endet';
		map['general.time.ranges.forever'] = 'Für immer';
		map['general.time.ranges.types.cycle'] = 'Zyklen';
		map['general.time.ranges.types.last_days'] = 'Letzte Tage';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '${x} Vortage';
		map['general.time.ranges.types.all'] = 'Immer';
		map['general.time.ranges.types.date_range'] = 'Benutzerdefinierter Zeitraum';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range}',
				other: 'Jeder ${n} ${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range} bis ${day}',
				other: 'Jeder ${n} ${range} bis ${day}',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range} ${limit} mal',
				other: 'Jeder ${n} ${range} ${limit} mal',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jeder ${range} einmal',
				other: 'Jeder ${n} ${range} einmal',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Monat',
				other: 'Monate',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Jahr',
				other: 'Jahre',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Tag',
				other: 'Tage',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Woche',
				other: 'Wochen',
			);
		map['general.time.periodicity.display'] = 'Wiederholung';
		map['general.time.periodicity.no_repeat'] = 'Keine Wiederholung';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Wiederholung',
				other: 'Wiederholungen',
			);
		map['general.time.periodicity.diary'] = 'Täglich';
		map['general.time.periodicity.monthly'] = 'Monatlich';
		map['general.time.periodicity.annually'] = 'Jährlich';
		map['general.time.periodicity.quaterly'] = 'Vierteljährlich';
		map['general.time.periodicity.weekly'] = 'Wöchentlich';
		map['general.time.periodicity.custom'] = 'Brauch';
		map['general.time.periodicity.infinite'] = 'Stets';
		map['general.time.current.monthly'] = 'Diesen Monat';
		map['general.time.current.annually'] = 'Dieses Jahr';
		map['general.time.current.quaterly'] = 'Dieses Quartal';
		map['general.time.current.weekly'] = 'Diese Woche';
		map['general.time.current.infinite'] = 'Für immer';
		map['general.time.current.custom'] = 'Benutzerdefinierter Zeitraum';
		map['general.time.all.diary'] = 'Täglich';
		map['general.time.all.monthly'] = 'Jeden Monat';
		map['general.time.all.annually'] = 'Jährlich';
		map['general.time.all.quaterly'] = 'Vierteljährlich';
		map['general.time.all.weekly'] = 'Jede Woche';
		map['general.transaction_order.display'] = 'Bestellvorgänge';
		map['general.transaction_order.category'] = 'Nach Kategorie';
		map['general.transaction_order.quantity'] = 'Nach Menge';
		map['general.transaction_order.date'] = 'Nach Datum';
		map['general.validations.form_error'] = 'Korrigiere die angegebenen Felder, um fortzufahren';
		map['general.validations.required'] = 'Erforderliches Feld';
		map['general.validations.positive'] = 'Sollte positiv sein';
		map['general.validations.min_number'] = ({required Object x}) => 'Sollte größer sein als ${x}';
		map['general.validations.max_number'] = ({required Object x}) => 'Sollte kleiner sein als ${x}';
		map['intro.start'] = 'Start';
		map['intro.skip'] = 'Überspringen';
		map['intro.next'] = 'Nächste';
		map['intro.select_your_currency'] = 'Wähle Deine Währung aus';
		map['intro.welcome_subtitle'] = 'Dein persönlicher Finanzmanager';
		map['intro.welcome_subtitle2'] = '100 % geöffnet, 100 % kostenlos';
		map['intro.welcome_footer'] = 'Mit der Anmeldung stimmst Du der <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Datenschutzrichtlinie</a> und den <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Nutzungsbedingungen</a> der App zu';
		map['intro.offline_descr_title'] = 'OFFLINE-KONTO:';
		map['intro.offline_descr'] = 'Deine Daten werden nur auf Deinem Gerät gespeichert und sind sicher, solange Du die App nicht deinstallieren oder das Telefon wechselst. ';
		map['intro.offline_start'] = 'Sitzung offline starten';
		map['intro.sl1_title'] = 'Wähle Deine Währung aus';
		map['intro.sl1_descr'] = 'Deine Standardwährung wird in Berichten und allgemeinen Diagrammen verwendet. ';
		map['intro.sl2_title'] = 'Sicher, privat und zuverlässig';
		map['intro.sl2_descr'] = 'Deine Daten gehören nur Dir. ';
		map['intro.sl2_descr2'] = 'Außerdem ist der Quellcode der Anwendung öffentlich, jeder kann daran mitarbeiten und sehen, wie es funktioniert';
		map['intro.last_slide_title'] = 'Alles bereit';
		map['intro.last_slide_descr'] = 'Mit Monekin kannst Du endlich die finanzielle Unabhängigkeit erreichen, die Du dir so sehr wünschst. ';
		map['intro.last_slide_descr2'] = 'Wir hoffen, dass Du Deine Erfahrung genießet! Zögerne nicht, uns im Falle von Fragen oder Vorschlägen zu kontaktieren...';
		map['home.title'] = 'Übersicht';
		map['home.filter_transactions'] = 'Transaktionen filtern';
		map['home.hello_day'] = 'Guten Morgen,';
		map['home.hello_night'] = 'Gute Nacht,';
		map['home.total_balance'] = 'Gesamtbilanz';
		map['home.my_accounts'] = 'Meine Konten';
		map['home.active_accounts'] = 'Aktive Konten';
		map['home.no_accounts'] = 'Es wurden noch keine Konten erstellt';
		map['home.no_accounts_descr'] = 'Beginne, die ganze Magie von Monekin zu nutzen. ';
		map['home.last_transactions'] = 'Letzte Transaktionen';
		map['home.should_create_account_header'] = 'Hoppla!';
		map['home.should_create_account_message'] = 'Du musst über mindestens ein nicht archiviertes Konto verfügen, bevor Du mit der Erstellung von Transaktionen beginnen kannst';
		map['financial_health.display'] = 'Finanzielle Lage';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Sehr gut!';
					case GenderContext.female:
						return 'Sehr gut!';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Gut';
					case GenderContext.female:
						return 'Gut';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Durchschnitt';
					case GenderContext.female:
						return 'Durchschnitt';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Mäßig';
					case GenderContext.female:
						return 'Mäßig';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Sehr schlecht';
					case GenderContext.female:
						return 'Sehr schlecht';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Unzureichende Daten';
					case GenderContext.female:
						return 'Unzureichende Daten';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = 'Es sieht so aus, als hätten wir nicht genügend Ausgaben, um Deine finanzielle Lage zu berechnen. Füge in diesem Zeitraum einige Ausgaben/Einnahmen hinzu, damit wir Dir helfen können!';
		map['financial_health.review.descr.very_good'] = 'Glückwunsch! ';
		map['financial_health.review.descr.good'] = 'Großartig! ';
		map['financial_health.review.descr.normal'] = 'Deine finanzielle Lage entspricht in diesem Zeitraum mehr oder weniger dem Durchschnitt der übrigen Bevölkerung';
		map['financial_health.review.descr.bad'] = 'Es scheint, dass Deine finanzielle Situation noch nicht die beste ist. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
		map['financial_health.review.descr.very_bad'] = 'Hmm, Deine finanzielle Lage ist weit unter dem, was sie sein sollte. Erkunde den Rest der Diagramme, um mehr über Deine Finanzen zu erfahren';
		map['financial_health.months_without_income.title'] = 'Überlebensrate';
		map['financial_health.months_without_income.subtitle'] = 'Angesichts Deines Guthabens, wie viel Zeit kannst Du ohne Einkommen auskommen?';
		map['financial_health.months_without_income.text_zero'] = 'Bei diesem Ausgabenniveau kannst Du keinen Monat ohne Einkommen überleben!';
		map['financial_health.months_without_income.text_one'] = 'Bei diesem Ausgabenniveau kannst Du kaum etwa einen Monat ohne Einkommen überleben!';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => 'Du könntest ungefähr <b>${n} Monate</b> ohne Einkommen bei dieser Ausgabenrate überleben.';
		map['financial_health.months_without_income.text_infinite'] = 'Du könntest ungefähr <b>Dein ganzes Leben lang</b> ohne Einkommen bei dieser Ausgabenrate überleben.';
		map['financial_health.months_without_income.suggestion'] = 'Denke daran, dass es ratsam ist, dieses Verhältnis immer mindestens über 5 Monate zu halten. Wenn Du feststellst, dass Du nicht über ein ausreichendes Sparpolster verfügst, solltest Du unnötige Ausgaben reduzieren.';
		map['financial_health.months_without_income.insufficient_data'] = 'Offenbar haben wir nicht genügend Ausgaben, um zu berechnen, wie viele Monate Du ohne Einkommen überleben könntest. Gib ein paar Transaktionen ein und komme hierher zurück, um Deine Finanzen zu überprüfen.';
		map['financial_health.savings_percentage.title'] = 'Sparprozentsatz';
		map['financial_health.savings_percentage.subtitle'] = 'Welcher Teil Deines Einkommens wird in diesem Zeitraum nicht ausgegeben?';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen. Es scheint, dass Du bereits ein Experte sind, mache weiter so! ';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => 'Herzlichen Glückwunsch! Du hast es geschafft, während dieses Zeitraums <b>${value}%</b> Deines Einkommens zu sparen';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => 'Du hast es geschafft <b>${value}%</b> Deines Einkommens in diesem Zeitraum zu sparen . ';
		map['financial_health.savings_percentage.text.very_bad'] = 'Wow, du hast es in dieser Zeit nicht geschafft, etwas zu sparen.';
		map['financial_health.savings_percentage.suggestion'] = 'Denk daran, dass es ratsam ist, mindestens 15-20 % Deines Einkommens zu sparen.';
		map['stats.title'] = 'Statistiken';
		map['stats.balance'] = 'Kontostand';
		map['stats.final_balance'] = 'Schlussstand';
		map['stats.balance_by_account'] = 'Saldo nach Konten';
		map['stats.balance_by_account_subtitle'] = 'Wo habe ich das meiste Geld?';
		map['stats.balance_by_currency'] = 'Saldo nach Währung';
		map['stats.balance_by_currency_subtitle'] = 'Wie viel Geld habe ich in Fremdwährung?';
		map['stats.balance_evolution'] = 'Trend';
		map['stats.balance_evolution_subtitle'] = 'Habe ich mehr Geld als vorher?';
		map['stats.compared_to_previous_period'] = 'Im Vergleich zur Vorperiode';
		map['stats.cash_flow'] = 'Cashflow';
		map['stats.cash_flow_subtitle'] = 'Gebe ich weniger aus, als ich verdiene?';
		map['stats.by_periods'] = 'Nach Perioden';
		map['stats.by_categories'] = 'Nach Kategorien';
		map['stats.by_tags'] = 'Nach Tags';
		map['stats.distribution'] = 'Verteilung';
		map['stats.finance_health_resume'] = 'Zusammenfassung';
		map['stats.finance_health_breakdown'] = 'Auflüsselung';
		map['icon_selector.name'] = 'Name:';
		map['icon_selector.icon'] = 'Symbol';
		map['icon_selector.color'] = 'Farbe';
		map['icon_selector.select_icon'] = 'Wähle ein Symbol aus';
		map['icon_selector.select_color'] = 'Wähle eine Farbe';
		map['icon_selector.custom_color'] = 'Benutzerdefinierte Farbe';
		map['icon_selector.current_color_selection'] = 'Aktuelle Auswahl';
		map['icon_selector.select_account_icon'] = 'Identifiziere Dein Konto';
		map['icon_selector.select_category_icon'] = 'Identifiziere Deine Kategorie';
		map['icon_selector.scopes.transport'] = 'Transport';
		map['icon_selector.scopes.money'] = 'Geld';
		map['icon_selector.scopes.food'] = 'Essen';
		map['icon_selector.scopes.medical'] = 'Gesundheit';
		map['icon_selector.scopes.entertainment'] = 'Freizeit';
		map['icon_selector.scopes.technology'] = 'Technologie';
		map['icon_selector.scopes.other'] = 'Andere';
		map['icon_selector.scopes.logos_financial_institutions'] = 'Finanzinstitute';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Transaktion',
				other: 'Transaktionen',
			);
		map['transaction.create'] = 'Neue Transaktion';
		map['transaction.new_income'] = 'Neues Einkommen';
		map['transaction.new_expense'] = 'Neue Ausgabe';
		map['transaction.new_success'] = 'Transaktion erfolgreich erstellt';
		map['transaction.edit'] = 'Transaktion bearbeiten';
		map['transaction.edit_success'] = 'Transaktion erfolgreich bearbeitet';
		map['transaction.edit_multiple'] = 'Bearbeite Deine Transaktionen';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x} Transaktionen erfolgreich bearbeitet';
		map['transaction.duplicate'] = 'Transaktion klonen';
		map['transaction.duplicate_short'] = 'Klon';
		map['transaction.duplicate_warning_message'] = 'Eine mit dieser identische Transaktion wird mit demselben Datum erstellt. Möchtest Du fortfahren?';
		map['transaction.duplicate_success'] = 'Transaktion erfolgreich geklont';
		map['transaction.delete'] = 'Transaktion löschen';
		map['transaction.delete_warning_message'] = 'Diese Aktion ist irreversibel. ';
		map['transaction.delete_success'] = 'Transaktion korrekt gelöscht';
		map['transaction.delete_multiple'] = 'Transaktionen löschen';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => 'Diese Aktion ist irreversibel und wird entfernt ${x} Transaktionen. ';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x} Transaktionen korrekt gelöscht';
		map['transaction.details'] = 'Bewegungsdetails';
		map['transaction.next_payments.accept'] = 'Akzeptieren';
		map['transaction.next_payments.skip'] = 'Überspringen';
		map['transaction.next_payments.skip_success'] = 'Transaktion erfolgreich übersprungen';
		map['transaction.next_payments.skip_dialog_title'] = 'Transaktion überspringen';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => 'Diese Aktion ist irreversibel.  ${date}';
		map['transaction.next_payments.accept_today'] = 'Akzeptiere noch heute';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => 'Akzeptierst Du das gewünschte Datum (${date})';
		map['transaction.next_payments.accept_dialog_title'] = 'Akzeptierst Du die Transaktion';
		map['transaction.next_payments.accept_dialog_msg_single'] = 'Der neue Status der Transaktion ist null. ';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => 'Diese Aktion erstellt eine neue Transaktion mit Datum ${date}. Du kannst die Details dieser Transaktion auf der Transaktionsseite überprüfen';
		map['transaction.next_payments.recurrent_rule_finished'] = 'Die wiederkehrende Regel ist abgeschlossen, es sind keine weiteren Zahlungen mehr zu leisten!';
		map['transaction.list.all'] = 'Alle Transaktionen';
		map['transaction.list.empty'] = 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. ';
		map['transaction.list.searcher_placeholder'] = 'Suche nach Kategorie, Beschreibung...';
		map['transaction.list.searcher_no_results'] = 'Es wurden keine Transaktionen gefunden, die den Suchkriterien entsprechen';
		map['transaction.list.loading'] = 'Weitere Transaktionen werden geladen...';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '${n} ausgewählt',
				other: '${n} ausgewählt',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '${n} Transaktion ausgewählt',
				other: '${n} Transaktionen ausgewählt',
			);
		map['transaction.list.bulk_edit.dates'] = 'Daten bearbeiten';
		map['transaction.list.bulk_edit.categories'] = 'Kategorien bearbeiten';
		map['transaction.list.bulk_edit.status'] = 'Status bearbeiten';
		map['transaction.filters.title'] = 'Transaktionsfilter';
		map['transaction.filters.from_value'] = 'Ab Betrag';
		map['transaction.filters.to_value'] = 'Bis zum Betrag';
		map['transaction.filters.from_value_def'] = ({required Object x}) => 'Von ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => 'Bis zu ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => 'Von der ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => 'Bis zum ${date}';
		map['transaction.form.validators.zero'] = 'Der Wert einer Transaktion kann nicht gleich Null sein';
		map['transaction.form.validators.date_max'] = 'Das ausgewählte Datum liegt nach dem aktuellen. ';
		map['transaction.form.validators.date_after_account_creation'] = 'Du kannst keine Transaktion erstellen, deren Datum vor dem Erstellungsdatum des Kontos liegt, zu dem sie gehört';
		map['transaction.form.validators.negative_transfer'] = 'Der Geldwert einer Überweisung darf nicht negativ sein';
		map['transaction.form.validators.transfer_between_same_accounts'] = 'Das Ursprungs- und das Zielkonto dürfen nicht identisch sein';
		map['transaction.form.title'] = 'Transaktionstitel';
		map['transaction.form.title_short'] = 'Titel';
		map['transaction.form.value'] = 'Wert der Transaktion';
		map['transaction.form.tap_to_see_more'] = 'Tippen, um weitere Details anzuzeigen';
		map['transaction.form.no_tags'] = '– Keine Tags –';
		map['transaction.form.description'] = 'Beschreibung';
		map['transaction.form.description_info'] = 'Tippe hier, um eine detailliertere Beschreibung dieser Transaktion einzugeben';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => 'Wechselkurs zu ${currency}';
		map['transaction.form.exchange_to_preferred_in_date'] = 'Am Transaktionsdatum';
		map['transaction.reversed.title'] = 'Umgekehrte Transaktion';
		map['transaction.reversed.title_short'] = 'Umgekehrte Tr.';
		map['transaction.reversed.description_for_expenses'] = 'Obwohl es sich um eine Spesentransaktion handelt, weist sie einen positiven Betrag auf. ';
		map['transaction.reversed.description_for_incomes'] = 'Obwohl es sich um eine Einkommenstransaktion handelt, weist sie einen negativen Betrag auf. ';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Status',
				other: 'Status',
			);
		map['transaction.status.display_long'] = 'Transaktionsstatus';
		map['transaction.status.tr_status'] = ({required Object status}) => '${status} Transaktion';
		map['transaction.status.none'] = 'Ohne Status';
		map['transaction.status.none_descr'] = 'Transaktion ohne bestimmten Status';
		map['transaction.status.reconciled'] = 'Ausgeglichen';
		map['transaction.status.reconciled_descr'] = 'Diese Transaktion wurde bereits validiert und entspricht einer echten Transaktion Deiner Bank';
		map['transaction.status.unreconciled'] = 'Unausgeglichen';
		map['transaction.status.unreconciled_descr'] = 'Diese Transaktion wurde noch nicht validiert und erscheint daher noch nicht auf Deinem echten Bankkonten. ';
		map['transaction.status.pending'] = 'Ausstehend';
		map['transaction.status.pending_descr'] = 'Diese Transaktion steht noch aus und wird daher bei der Berechnung von Salden und Statistiken nicht berücksichtigt';
		map['transaction.status.voided'] = 'Entwertet';
		map['transaction.status.voided_descr'] = 'Transaktion aufgrund eines Zahlungsfehlers oder aus einem anderen Grund ungültig/storniert. ';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Transaktionstyp',
				other: 'Transaktiontypen',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Einkommen',
				other: 'Einkommen',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Ausgaben',
				other: 'Ausgaben',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Überweisen',
				other: 'Überweisungen',
			);
		map['transfer.display'] = 'Überweisen';
		map['transfer.transfers'] = 'Überweisungen';
		map['transfer.transfer_to'] = ({required Object account}) => 'Überweisen an ${account}';
		map['transfer.create'] = 'Neue Überweisung';
		map['transfer.need_two_accounts_warning_header'] = 'Ops!';
		map['transfer.need_two_accounts_warning_message'] = 'Um diese Aktion auszuführen, sind mindestens zwei Konten erforderlich. Wenn Du den aktuellen Saldo dieses Kontos anpassen oder bearbeiten möchtest, klicke auf die Schaltfläche Bearbeiten';
		map['transfer.form.from'] = 'Origin-Konto';
		map['transfer.form.to'] = 'Zielkonto';
		map['transfer.form.value_in_destiny.title'] = 'Am Zielkonto überwiesener Betrag';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} zum Zielkonto';
		map['recurrent_transactions.title'] = 'Wiederkehrende Transaktionen';
		map['recurrent_transactions.title_short'] = 'Wiederk. Transakt.';
		map['recurrent_transactions.empty'] = 'Anscheinend hast Du keine wiederkehrenden Transaktionen. Erstelle eine monatliche, jährliche oder wöchentliche wiederkehrende Transaktion, die hier angezeigt wird.';
		map['recurrent_transactions.total_expense_title'] = 'Gesamtausgaben pro Periode';
		map['recurrent_transactions.total_expense_descr'] = '* Ohne Berücksichtigung des Start- und Enddatums jeder Wiederholung';
		map['recurrent_transactions.details.title'] = 'Wiederkehrende Transaktion';
		map['recurrent_transactions.details.descr'] = 'Die nächsten Schritte für diese Transaktion werden unten angezeigt. Du kannst den ersten Schritt akzeptieren oder diesen Schritt auslassen';
		map['recurrent_transactions.details.last_payment_info'] = 'Diese Bewegung ist die letzte der wiederkehrenden Regel, daher wird diese Regel beim Bestätigen dieser Aktion automatisch gelöscht';
		map['recurrent_transactions.details.delete_header'] = 'Wiederkehrende Transaktion löschen';
		map['recurrent_transactions.details.delete_message'] = 'Diese Aktion ist unumkehrbar und hat keinen Einfluss auf Transaktionen, die Du bereits bestätigt/bezahlt habst';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => 'Verzögert um ${x}d';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => 'In ${x} Tagen';
		map['account.details'] = 'Kontodaten';
		map['account.date'] = 'Eröffnungsdatum';
		map['account.close_date'] = 'Einsendeschluss';
		map['account.reopen'] = 'Konto erneut eröffnen';
		map['account.reopen_short'] = 'Wieder öffnen';
		map['account.reopen_descr'] = 'Möchtest Du dieses Konto wirklich wieder eröffnen?';
		map['account.balance'] = 'Kontostand';
		map['account.n_transactions'] = 'Anzahl der Transaktionen';
		map['account.add_money'] = 'Geld hinzufügen';
		map['account.withdraw_money'] = 'Geld abheben';
		map['account.no_accounts'] = 'Es wurden keine Transaktionen gefunden, die hier angezeigt werden könnten. Füge eine Transaktion hinzu, indem Du auf die Schaltfläche „+“ am unteren Rand klickst.';
		map['account.types.title'] = 'Kontotyp';
		map['account.types.warning'] = 'Sobald der Kontotyp ausgewählt wurde, kann er in Zukunft nicht mehr geändert werden';
		map['account.types.normal'] = 'Normales Konto';
		map['account.types.normal_descr'] = 'Nützlich, um Deine täglichen Finanzen aufzuzeichnen. Es ist das gebräuchlichste Konto, das es Dir ermöglicht, Ausgaben, Einnahmen hinzuzufügen';
		map['account.types.saving'] = 'Sparkonto';
		map['account.types.saving_descr'] = 'Du kannst nur Geld von anderen Konten einzahlen und abheben. Perfekt geignet, um Geld zu sparen';
		map['account.form.name'] = 'Kontoname';
		map['account.form.name_placeholder'] = 'Beispiel: Sparkonto';
		map['account.form.notes'] = 'Notizen';
		map['account.form.notes_placeholder'] = 'Gebe einige Notizen/Beschreibungen zu diesem Konto ein';
		map['account.form.initial_balance'] = 'Anfangssaldo';
		map['account.form.current_balance'] = 'Aktueller Kontostand';
		map['account.form.create'] = 'Konto erstellen';
		map['account.form.edit'] = 'Konto bearbeiten';
		map['account.form.currency_not_found_warn'] = 'Du hast keine Informationen zu den Wechselkursen für diese Währung. Als Standardwechselkurs wird 1,0 verwendet. Du kannst das in den Einstellungen ändern';
		map['account.form.already_exists'] = 'Es gibt bereits ein Konto mit demselben Namen, bitte nutze einen anderen';
		map['account.form.tr_before_opening_date'] = 'Auf diesem Konto liegen Transaktionen vor, deren Datum vor dem Eröffnungsdatum liegt';
		map['account.form.iban'] = 'IBAN';
		map['account.form.swift'] = 'SWIFT';
		map['account.delete.warning_header'] = 'Konto löschen?';
		map['account.delete.warning_text'] = 'Durch diese Aktion werden dieses Konto und alle seine Transaktionen gelöscht';
		map['account.delete.success'] = 'Konto erfolgreich gelöscht';
		map['account.close.title'] = 'Konto schließen';
		map['account.close.title_short'] = 'Schließen';
		map['account.close.warn'] = 'Dieses Konto wird in bestimmten Einträgen nicht mehr angezeigt und Du kannst darin keine Transaktionen mit einem späteren als dem unten angegebenen Datum erstellen. Diese Aktion hat keine Auswirkungen auf Transaktionen oder Guthaben, und Du kannst dieses Konto auch jederzeit wieder eröffnen.';
		map['account.close.should_have_zero_balance'] = 'Um das Konto schließen zu können, muss der aktuelle Kontostand 0 betragen.  Bitte bearbeite das Konto, bevor du fortfährst';
		map['account.close.should_have_no_transactions'] = 'Auf diesem Konto liegen Transaktionen nach dem angegebenen Schlussdatum vor. Lösche sie oder bearbeite das Datum der Kontoschließung, bevor Du fortfährst';
		map['account.close.success'] = 'Konto erfolgreich geschlossen';
		map['account.close.unarchive_succes'] = 'Konto erfolgreich wiedereröffnet';
		map['account.select.one'] = 'Wähle ein Konto aus';
		map['account.select.all'] = 'Alle Konten';
		map['account.select.multiple'] = 'Wähle Konten aus';
		map['currencies.currency_converter'] = 'Währungsrechner';
		map['currencies.currency'] = 'Währung';
		map['currencies.currency_manager'] = 'Währungsmanager';
		map['currencies.currency_manager_descr'] = 'Konfiguriere Deine Währung und deren Wechselkurse mit anderen';
		map['currencies.preferred_currency'] = 'Bevorzugte/Basis Währung';
		map['currencies.change_preferred_currency_title'] = 'Änder die bevorzugte Währung';
		map['currencies.change_preferred_currency_msg'] = 'Alle Statistiken und Budgets werden ab sofort in dieser Währung angezeigt. Konten und Transaktionen behalten die Währung, die sie hatten. Alle gespeicherten Wechselkurse werden gelöscht, wenn Du diese Aktion ausführst. Möchtest Du fortfahren?';
		map['currencies.form.equal_to_preferred_warn'] = 'Die Währung darf nicht mit der Benutzerwährung übereinstimmen';
		map['currencies.form.specify_a_currency'] = 'Bitte gib eine Währung an';
		map['currencies.form.add'] = 'Wechselkurs hinzufügen';
		map['currencies.form.add_success'] = 'Wechselkurs erfolgreich hinzugefügt';
		map['currencies.form.edit'] = 'Wechselkurs bearbeiten';
		map['currencies.form.edit_success'] = 'Wechselkurs erfolgreich bearbeitet';
		map['currencies.delete_all_success'] = 'Wechselkurse erfolgreich gelöscht';
		map['currencies.historical'] = 'Historische Kurse';
		map['currencies.exchange_rate'] = 'Wechselkurs';
		map['currencies.exchange_rates'] = 'Wechselkurse';
		map['currencies.empty'] = 'Füge hier Wechselkurse hinzu, damit unsere Diagramme genauer sind, wenn Du Konten in anderen Währungen als Deiner Basiswährung hast';
		map['currencies.select_a_currency'] = 'Wähle eine Währung aus';
		map['currencies.search'] = 'Suche nach Name oder Währungscode';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: 'Label',
				other: 'Schlagworte',
			);
		map['tags.form.name'] = 'Schlagworte-Name';
		map['tags.form.description'] = 'Beschreibung';
		map['tags.select.title'] = 'Schlagworte auswählen';
		map['tags.select.all'] = 'Alle Schlagworte';
		map['tags.empty_list'] = 'Du hast noch keine Schlagworte erstellt. Schlagworte und Kategorien sind eine gute Möglichkeit, Deine Bewegungen zu kategorisieren';
		map['tags.without_tags'] = 'Ohne Schlagworte';
		map['tags.add'] = 'Schlagwort hinzufügen';
		map['tags.create'] = 'Label erstellen';
		map['tags.create_success'] = 'Label erfolgreich erstellt';
		map['tags.already_exists'] = 'Dieser Schlagwort-Name existiert bereits. ';
		map['tags.edit'] = 'Schlagwort bearbeiten';
		map['tags.edit_success'] = 'Schlagwort erfolgreich bearbeitet';
		map['tags.delete_success'] = 'Kategorie erfolgreich gelöscht';
		map['tags.delete_warning_header'] = 'Schlagwort löschen?';
		map['tags.delete_warning_message'] = 'Durch diese Aktion werden keine Transaktionen gelöscht, die dieses Schlagwort haben.';
		map['categories.unknown'] = 'Unbekannte Kategorie';
		map['categories.create'] = 'Kategorie erstellen';
		map['categories.create_success'] = 'Kategorie korrekt erstellt';
		map['categories.new_category'] = 'Neue Kategorie';
		map['categories.already_exists'] = 'Der Name dieser Kategorie existiert bereits. Willst du es verändern?';
		map['categories.edit'] = 'Kategorie bearbeiten';
		map['categories.edit_success'] = 'Kategorie korrekt bearbeitet';
		map['categories.name'] = 'Kategoriename';
		map['categories.type'] = 'Kategorietyp';
		map['categories.both_types'] = 'Beide Typen';
		map['categories.subcategories'] = 'Unterkategorien';
		map['categories.subcategories_add'] = 'Unterkategorie hinzufügen';
		map['categories.make_parent'] = 'Zur Kategorie hinzufügen';
		map['categories.make_child'] = 'Erstelle eine Unterkategorie';
		map['categories.make_child_warning1'] = ({required Object destiny}) => 'Diese Kategorie und ihre Unterkategorien werden zu Unterkategorien von <b>${destiny}</b>.';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => 'Deine Transaktionen <b>(${x})</b> werden in die neuen Unterkategorien verschoben, die innerhalb der Kategorie <b>${destiny}</b> erstellt wurden.';
		map['categories.make_child_success'] = 'Unterkategorien erfolgreich erstellt';
		map['categories.merge'] = 'Mit einer anderen Kategorie zusammenführen';
		map['categories.merge_warning1'] = ({required Object x, required Object from, required Object destiny}) => 'Alle Transaktionen (${x}), die mit der Kategorie <b>${from}</b> verknüpft sind werden in die Kategorie <b>${destiny}</b> verschoben';
		map['categories.merge_warning2'] = ({required Object from}) => 'Die Kategorie <b>${from}</b> werden unwiderruflich gelöscht.';
		map['categories.merge_success'] = 'Die Kategorie wurde erfolgreich zusammengeführt';
		map['categories.delete_success'] = 'Kategorie wurde korrekt gelöscht';
		map['categories.delete_warning_header'] = 'Kategorie löschen?';
		map['categories.delete_warning_message'] = ({required Object x}) => 'Durch diese Aktion werden alle Transaktionen unwiderruflich gelöscht <b>(${x})</b> im Zusammenhang mit dieser Kategorie.';
		map['categories.select.title'] = 'Kategorien auswählen';
		map['categories.select.select_one'] = 'Wähle eine Kategorie aus';
		map['categories.select.select_subcategory'] = 'Wähle eine Unterkategorie';
		map['categories.select.without_subcategory'] = 'Ohne Unterkategorie';
		map['categories.select.all'] = 'Alle Kategorien';
		map['categories.select.all_short'] = 'Alle';
		map['budgets.title'] = 'Budgets';
		map['budgets.repeated'] = 'Wiederkehrend';
		map['budgets.one_time'] = 'Einmalig';
		map['budgets.annual'] = 'Jährlich';
		map['budgets.week'] = 'Wöchentlich';
		map['budgets.month'] = 'Monatlich';
		map['budgets.actives'] = 'Aktive';
		map['budgets.pending'] = 'Ausstehender Start';
		map['budgets.finish'] = 'Fertig';
		map['budgets.from_budgeted'] = 'übrig von ';
		map['budgets.days_left'] = 'Tage übrig';
		map['budgets.days_to_start'] = 'Tage bis Start';
		map['budgets.since_expiration'] = 'Tage seit Ablauf';
		map['budgets.no_budgets'] = 'Es scheint, dass in diesem Abschnitt keine Budgets angezeigt werden können. Beginne mit der Erstellung eines Budgets, indem Du auf die Schaltfläche unten klickst';
		map['budgets.delete'] = 'Budget löschen';
		map['budgets.delete_warning'] = 'Diese Aktion ist irreversibel. ';
		map['budgets.form.title'] = 'Budget hinzufügen';
		map['budgets.form.name'] = 'Budgetname';
		map['budgets.form.value'] = 'Menge begrenzen';
		map['budgets.form.create'] = 'Budget hinzufügen';
		map['budgets.form.edit'] = 'Budget bearbeiten';
		map['budgets.form.negative_warn'] = 'Die Budgets dürfen keinen negativen Betrag haben';
		map['budgets.details.title'] = 'Budgetdetails';
		map['budgets.details.statistics'] = 'Statistiken';
		map['budgets.details.budget_value'] = 'Budgetiert';
		map['budgets.details.expend_diary_left'] = ({required Object dailyAmount, required Object remainingDays}) => 'Du kannst ${dailyAmount}/Tag für ${remainingDays} verbleibende Tage ausgeben';
		map['budgets.details.expend_evolution'] = 'Ausgabenentwicklung';
		map['budgets.details.no_transactions'] = 'Es scheint, dass Du im Zusammenhang mit diesem Budget keine Ausgaben getätigt hast';
		map['backup.no_file_selected'] = 'Keine Datei ausgewählt';
		map['backup.no_directory_selected'] = 'Kein Verzeichnis ausgewählt';
		map['backup.export.title'] = 'Daten exportieren';
		map['backup.export.title_short'] = 'Export';
		map['backup.export.type_of_export'] = 'Art des Exports';
		map['backup.export.other_options'] = 'Optionen';
		map['backup.export.all'] = 'Vollständige Sicherung';
		map['backup.export.all_descr'] = 'Exportiere alle Deine Daten (Konten, Transaktionen, Budgets, Einstellungen...). ';
		map['backup.export.transactions'] = 'Sicherung der Transaktionen';
		map['backup.export.transactions_descr'] = 'Exportiere Deine Transaktionen im CSV-Format, damit Du sie einfacher in anderen Programmen oder Anwendungen analysieren kannst.';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '1 Transaktion zum Exportieren',
				other: '${n} Transaktionen zum Exportieren',
			);
		map['backup.export.description'] = 'Lade Deine Daten in verschiedenen Formaten herunter';
		map['backup.export.send_file'] = 'Datei senden';
		map['backup.export.see_folder'] = 'Siehe Ordner';
		map['backup.export.success'] = ({required Object x}) => 'Datei erfolgreich gespeichert/heruntergeladen in ${x}';
		map['backup.export.error'] = 'Fehler beim Herunterladen der Datei. ';
		map['backup.export.dialog_title'] = 'Datei speichern/senden';
		map['backup.import.title'] = 'Daten importieren';
		map['backup.import.title_short'] = 'Import';
		map['backup.import.restore_backup'] = 'Sicherung wiederherstellen';
		map['backup.import.restore_backup_descr'] = 'Importiere eine zuvor gespeicherte Datenbank von Monekin. Diese Aktion ersetzt alle aktuellen Anwendungsdaten durch die neuen Daten';
		map['backup.import.restore_backup_warn_description'] = 'Beim Importieren einer neuen Datenbank gehen alle derzeit in der App gespeicherten Daten verloren. Es wird empfohlen, eine Sicherungskopie zu erstellen, bevor Du fortfährst. Lade hier keine Dateien hoch, deren Herkunft Du nicht kennst. Lade nur Dateien hoch, die Du zuvor von Monekin heruntergeladen hast.';
		map['backup.import.restore_backup_warn_title'] = 'Alle Daten überschreiben';
		map['backup.import.select_other_file'] = 'Andere Datei auswählen';
		map['backup.import.tap_to_select_file'] = 'Tippe, um eine Datei auszuwählen';
		map['backup.import.manual_import.title'] = 'Manueller Import';
		map['backup.import.manual_import.descr'] = 'Importiere Transaktionen manuell aus einer CSV-Datei';
		map['backup.import.manual_import.default_account'] = 'Standardkonto';
		map['backup.import.manual_import.remove_default_account'] = 'Standardkonto entfernen';
		map['backup.import.manual_import.default_category'] = 'Standardkategorie';
		map['backup.import.manual_import.select_a_column'] = 'Wählen eine Spalte aus der CSV-Datei aus';
		map['backup.import.manual_import.steps.0'] = 'Wähle Deine Datei aus';
		map['backup.import.manual_import.steps.1'] = 'Spalte für Menge';
		map['backup.import.manual_import.steps.2'] = 'Spalte für Konto';
		map['backup.import.manual_import.steps.3'] = 'Spalte für Kategorie';
		map['backup.import.manual_import.steps.4'] = 'Spalte für Datum';
		map['backup.import.manual_import.steps.5'] = 'andere Spalten';
		map['backup.import.manual_import.steps_descr.0'] = 'Wähle eine CSV-Datei von Deinem Gerät aus. Stelle sicher, dass die erste Zeile den Namen der einzelnen Spalten enthält';
		map['backup.import.manual_import.steps_descr.1'] = 'Wählen die Spalte aus, in der der Wert jeder Transaktion angegeben ist. Verwende negative Werte für Ausgaben und positive Werte für Einnahmen. Verwende einen Punkt als Dezimaltrennzeichen';
		map['backup.import.manual_import.steps_descr.2'] = 'Wähle die Spalte aus, in der das Konto angegeben ist, zu dem jede Transaktion gehört. Du kannst auch ein Standardkonto auswählen, falls wir das von Dir gewünschte Konto nicht finden können. Wenn Du kein Standardkonto angibst, wird eines mit demselben Namen erstellt ';
		map['backup.import.manual_import.steps_descr.3'] = 'Gebe die Spalte an, in der sich der Name der Transaktionskategorie befindet. Du musst eine Standardkategorie angeben, damit wir diese Kategorie den Transaktionen zuordnen können, falls die Kategorie nicht gefunden werden kann.';
		map['backup.import.manual_import.steps_descr.4'] = 'Wähle die Spalte aus, in der das Datum jeder Transaktion angegeben ist. Wird nichts angegeben, werden die Transaktionen mit dem aktuellen Datum erstellt.';
		map['backup.import.manual_import.steps_descr.5'] = 'Gibt die Spalten für andere optionale Transaktionsattribute an';
		map['backup.import.manual_import.success'] = ({required Object x}) => 'Erfolgreich ${x} Transaktionen importiert';
		map['backup.import.success'] = 'Der Import wurde erfolgreich durchgeführt';
		map['backup.import.error'] = 'Fehler beim Importieren der Datei. Bitte kontaktiere den Entwickler lozin.technologies@gmail.com';
		map['backup.import.cancelled'] = 'Der Import wurde vom Benutzer abgebrochen';
		map['backup.about.title'] = 'Informationen zu Deiner Datenbank';
		map['backup.about.create_date'] = 'Erstellungsdatum';
		map['backup.about.modify_date'] = 'Zuletzt geändert';
		map['backup.about.last_backup'] = 'Letzte Sicherung';
		map['backup.about.size'] = 'Größe';
		map['settings.title_long'] = 'Einstellungen und Aussehen';
		map['settings.title_short'] = 'Einstellungen';
		map['settings.description'] = 'App-Theme, Texte und andere allgemeine Einstellungen';
		map['settings.edit_profile'] = 'Profil bearbeiten';
		map['settings.lang_section'] = 'Sprache und Texte';
		map['settings.lang_title'] = 'App-Sprache';
		map['settings.lang_descr'] = 'Sprache, in der die Texte in der App angezeigt werden';
		map['settings.lang_help'] = 'Wenn an den Übersetzungen dieser App mitarbeiten möchten, kannst du dich an <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>unser Beschreibung</a> wenden';
		map['settings.locale'] = 'Region';
		map['settings.locale_auto'] = 'System';
		map['settings.locale_descr'] = 'Lege das für Datumsangaben, Zahlen usw. zu verwendende Format fest.';
		map['settings.locale_warn'] = 'Wenn Du die Region änderst, wird die App aktualisiert';
		map['settings.first_day_of_week'] = 'Erster Tag der Woche';
		map['settings.theme_and_colors'] = 'Thema und Farben';
		map['settings.theme'] = 'Thema';
		map['settings.theme_auto'] = 'System';
		map['settings.theme_light'] = 'Hell';
		map['settings.theme_dark'] = 'Dunkel';
		map['settings.amoled_mode'] = 'AMOLED-Modus';
		map['settings.amoled_mode_descr'] = 'Verwende nach Möglichkeit einn rein schwarzen Hintergrund. Das wird den Akku von Geräten mit AMOLED-Bildschirmen etwas schonen.';
		map['settings.dynamic_colors'] = 'Dynamische Farben';
		map['settings.dynamic_colors_descr'] = 'Verwende wann immer möglich die Akzentfarbe des Systems';
		map['settings.accent_color'] = 'Akzentfarbe';
		map['settings.accent_color_descr'] = 'Wähle die Farbe aus, mit der die App bestimmte Teile der Benutzeroberfläche hervorhebt';
		map['settings.font'] = 'Schriftart';
		map['settings.font_platform'] = 'Plattform';
		map['settings.swipe_actions.title'] = 'Wischaktionen';
		map['settings.swipe_actions.choose_description'] = 'Wählen Sie aus, welche Aktion ausgelöst wird, wenn Sie mit dieser Wischrichtung über ein Transaktionselement in der Liste wischen';
		map['settings.swipe_actions.swipe_left'] = 'Wischen Sie nach links';
		map['settings.swipe_actions.swipe_right'] = 'Wischen Sie nach rechts';
		map['settings.swipe_actions.none'] = 'Keine Aktion';
		map['settings.swipe_actions.toggle_reconciled'] = 'Toggle abgeglichen';
		map['settings.swipe_actions.toggle_pending'] = 'Umschalten steht aus';
		map['settings.swipe_actions.toggle_voided'] = 'Umschalten ungültig';
		map['settings.swipe_actions.toggle_unreconciled'] = 'Nicht abgestimmt umschalten';
		map['settings.swipe_actions.remove_status'] = 'Status entfernen';
		map['settings.security.title'] = 'Sicherheit';
		map['settings.security.private_mode_at_launch'] = 'Privatmodus beim Start';
		map['settings.security.private_mode_at_launch_descr'] = 'Starte die App standardmäßig im privaten Modus';
		map['settings.security.private_mode'] = 'Privatmodus';
		map['settings.security.private_mode_descr'] = 'Alle Geldwerte ausblenden';
		map['settings.security.private_mode_activated'] = 'Privatmodus aktiviert';
		map['settings.security.private_mode_deactivated'] = 'Privatmodus deaktiviert';
		map['more.title'] = 'Mehr';
		map['more.title_long'] = 'Weitere Aktionen';
		map['more.data.display'] = 'Daten';
		map['more.data.display_descr'] = 'Exportiere und importiere Deine Daten, damit Du nichts verlierst';
		map['more.data.delete_all'] = 'Meine Daten löschen';
		map['more.data.delete_all_header1'] = 'Höre genau dort auf, Padawan ⚠️⚠️';
		map['more.data.delete_all_message1'] = 'Bist Du sicher, dass Du fortfahren möchtest? Alle Daten werden endgültig gelöscht und können nicht wiederhergestellt werden.';
		map['more.data.delete_all_header2'] = 'Ein letzter Schritt ⚠️⚠️';
		map['more.data.delete_all_message2'] = 'Durch das Löschen eines Kontos löschst Du alle Deine gespeicherten persönlichen Daten. Deine Konten, Transaktionen, Budgets und Kategorien werden gelöscht und können nicht wiederhergestellt werden. Bist Du damit einverstanden?';
		map['more.about_us.display'] = 'App-Informationen';
		map['more.about_us.description'] = 'Schaue Dir die Bedingungen und andere relevante Informationen über Monekin an. Treten mit der Community in Kontakt, indem Du Fehler meldest, Vorschläge machst...';
		map['more.about_us.legal.display'] = 'Rechtliche Informationen';
		map['more.about_us.legal.privacy'] = 'Datenschutzrichtlinie';
		map['more.about_us.legal.terms'] = 'Nutzungsbedingungen';
		map['more.about_us.legal.licenses'] = 'Lizenzen';
		map['more.about_us.project.display'] = 'Projekt';
		map['more.about_us.project.contributors'] = 'Mitarbeiter';
		map['more.about_us.project.contributors_descr'] = 'Alle Entwickler, die Monekin wachsen lassen haben';
		map['more.about_us.project.contact'] = 'Kontaktiere uns';
		map['more.help_us.display'] = 'Hilf uns';
		map['more.help_us.description'] = 'Finde heraus, wie Du Monekin dabei helfen kannst, immer besser zu werden';
		map['more.help_us.rate_us'] = 'Bewerte uns';
		map['more.help_us.rate_us_descr'] = 'Jede Hilfe ist willkommen!';
		map['more.help_us.share'] = 'Teile  Monekin';
		map['more.help_us.share_descr'] = 'Teile  unsere App mit Freunden und Familie';
		map['more.help_us.share_text'] = 'Monekin! ';
		map['more.help_us.thanks'] = 'Danke schön!';
		map['more.help_us.thanks_long'] = 'Deine Beiträge zu Monekin und anderen großen und kleinen Open-Source-Projekten machen großartige Projekte wie dieses möglich. Danke, dass Du dir die Zeit nimmst teilzunehmen';
		map['more.help_us.donate'] = 'Mache eine Spende';
		map['more.help_us.donate_descr'] = 'Mit Deiner Spende trägst dazu bei, dass die App weiterhin verbessert wird. Was gibt es Schöneres, als sich für die geleistete Arbeit zu bedanken, indem man mich zu einem Kaffee einlädt?';
		map['more.help_us.donate_success'] = 'Spende erfolgt. Herzlichen Dank für Deine Beitrag! ❤️';
		map['more.help_us.donate_err'] = 'Hoppla! Es scheint ein Fehler beim Empfang Deiner Zahlung aufgetreten zu sein';
		map['more.help_us.report'] = 'Melde Fehler, hinterlasse Vorschläge ...';

		_map = map;
		return map;
	}
}


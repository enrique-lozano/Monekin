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
class TranslationsIt implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsIt ui_actions = _TranslationsUiActionsIt._(_root);
	@override late final _TranslationsGeneralIt general = _TranslationsGeneralIt._(_root);
	@override late final _TranslationsIntroIt intro = _TranslationsIntroIt._(_root);
	@override late final _TranslationsHomeIt home = _TranslationsHomeIt._(_root);
	@override late final _TranslationsFinancialHealthIt financial_health = _TranslationsFinancialHealthIt._(_root);
	@override late final _TranslationsStatsIt stats = _TranslationsStatsIt._(_root);
	@override late final _TranslationsIconSelectorIt icon_selector = _TranslationsIconSelectorIt._(_root);
	@override late final _TranslationsTransactionIt transaction = _TranslationsTransactionIt._(_root);
	@override late final _TranslationsTransferIt transfer = _TranslationsTransferIt._(_root);
	@override late final _TranslationsRecurrentTransactionsIt recurrent_transactions = _TranslationsRecurrentTransactionsIt._(_root);
	@override late final _TranslationsAccountIt account = _TranslationsAccountIt._(_root);
	@override late final _TranslationsCurrenciesIt currencies = _TranslationsCurrenciesIt._(_root);
	@override late final _TranslationsTagsIt tags = _TranslationsTagsIt._(_root);
	@override late final _TranslationsCategoriesIt categories = _TranslationsCategoriesIt._(_root);
	@override late final _TranslationsBudgetsIt budgets = _TranslationsBudgetsIt._(_root);
	@override late final _TranslationsBackupIt backup = _TranslationsBackupIt._(_root);
	@override late final _TranslationsSettingsIt settings = _TranslationsSettingsIt._(_root);
	@override late final _TranslationsMoreIt more = _TranslationsMoreIt._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsIt implements TranslationsUiActionsEn {
	_TranslationsUiActionsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annulla';
	@override String get confirm => 'Conferma';
	@override String get continue_text => 'Continua';
	@override String get save => 'Salva';
	@override String get save_changes => 'Salva modifiche';
	@override String get close_and_save => 'Salva e chiudi';
	@override String get add => 'Aggiungi';
	@override String get edit => 'Modifica';
	@override String get delete => 'Elimina';
	@override String get see_more => 'Vedi altro';
	@override String get select_all => 'Seleziona tutto';
	@override String get deselect_all => 'Deseleziona tutto';
	@override String get select => 'Seleziona';
	@override String get search => 'Cerca';
	@override String get filter => 'Filtra';
	@override String get reset => 'Ripristina';
	@override String get submit => 'Invia';
	@override String get next => 'Avanti';
	@override String get previous => 'Precedente';
	@override String get back => 'Indietro';
	@override String get reload => 'Ricarica';
	@override String get view => 'Visualizza';
	@override String get download => 'Scarica';
	@override String get upload => 'Carica';
	@override String get retry => 'Riprova';
	@override String get copy => 'Copia';
	@override String get paste => 'Incolla';
	@override String get undo => 'Annulla';
	@override String get redo => 'Ripristina';
	@override String get open => 'Apri';
	@override String get close => 'Chiudi';
	@override String get apply => 'Applica';
	@override String get discard => 'Ignora';
	@override String get refresh => 'Aggiorna';
	@override String get details => 'Dettagli';
	@override String get share => 'Condividi';
}

// Path: general
class _TranslationsGeneralIt implements TranslationsGeneralEn {
	_TranslationsGeneralIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get or => 'o';
	@override String get understood => 'Capito';
	@override String get unspecified => 'Non specificato';
	@override String get quick_actions => 'Azioni rapide';
	@override String get balance => 'Saldo';
	@override String get account => 'Conto';
	@override String get accounts => 'Conti';
	@override String get categories => 'Categorie';
	@override String get category => 'Categoria';
	@override String get today => 'Oggi';
	@override String get yesterday => 'Ieri';
	@override String get filters => 'Filtri';
	@override String get empty_warn => 'Ops! È davvero vuoto';
	@override String get insufficient_data => 'Dati insufficienti';
	@override String get show_more_fields => 'Mostra più campi';
	@override String get show_less_fields => 'Mostra meno campi';
	@override String get tap_to_search => 'Tocca per cercare';
	@override late final _TranslationsGeneralClipboardIt clipboard = _TranslationsGeneralClipboardIt._(_root);
	@override late final _TranslationsGeneralTimeIt time = _TranslationsGeneralTimeIt._(_root);
	@override late final _TranslationsGeneralTransactionOrderIt transaction_order = _TranslationsGeneralTransactionOrderIt._(_root);
	@override late final _TranslationsGeneralValidationsIt validations = _TranslationsGeneralValidationsIt._(_root);
}

// Path: intro
class _TranslationsIntroIt implements TranslationsIntroEn {
	_TranslationsIntroIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get start => 'Inizia';
	@override String get skip => 'Salta';
	@override String get next => 'Avanti';
	@override String get select_your_currency => 'Seleziona la tua valuta';
	@override String get welcome_subtitle => 'Il tuo gestore di finanze personali';
	@override String get welcome_subtitle2 => '100% open, 100% gratuito';
	@override String get welcome_footer => 'Effettuando l\'accesso accetti l\'<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>informativa sulla privacy</a> e i <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Termini di utilizzo</a> dell\'applicazione';
	@override String get offline_descr_title => 'CONTO OFFLINE:';
	@override String get offline_descr => 'I tuoi dati saranno conservati solo sul tuo dispositivo e saranno al sicuro finché non disinstallerai l\'app o cambierai telefono. Per prevenire la perdita di dati, si consiglia di effettuare un backup regolarmente dalle impostazioni dell\'app.';
	@override String get offline_start => 'Avvia sessione offline';
	@override String get sl1_title => 'Seleziona la tua valuta';
	@override String get sl1_descr => 'La tua valuta predefinita sarà utilizzata nei rapporti e nei grafici generali. Potrai cambiare la valuta e la lingua dell\'app in qualsiasi momento nelle impostazioni dell\'applicazione';
	@override String get sl2_title => 'Sicura, privata e affidabile';
	@override String get sl2_descr => 'I tuoi dati sono solo tuoi. Conserviamo le informazioni direttamente sul tuo dispositivo, senza passare per server esterni. Questo rende possibile usare l\'app anche senza internet';
	@override String get sl2_descr2 => 'Inoltre, il codice sorgente dell\'applicazione è pubblico, chiunque può collaborare e vedere come funziona';
	@override String get last_slide_title => 'Tutto pronto';
	@override String get last_slide_descr => 'Con Monekin, puoi finalmente raggiungere l\'indipendenza finanziaria che tanto desideri. Avrai grafici, budget, consigli, statistiche e molto altro sul tuo denaro.';
	@override String get last_slide_descr2 => 'Speriamo che la tua esperienza ti piaccia! Non esitare a contattarci in caso di dubbi, suggerimenti...';
}

// Path: home
class _TranslationsHomeIt implements TranslationsHomeEn {
	_TranslationsHomeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dashboard';
	@override String get filter_transactions => 'Filtra transazioni';
	@override String get hello_day => 'Buongiorno,';
	@override String get hello_night => 'Buonasera,';
	@override String get total_balance => 'Saldo totale';
	@override String get my_accounts => 'I miei conti';
	@override String get active_accounts => 'Conti attivi';
	@override String get no_accounts => 'Nessun conto creato ancora';
	@override String get no_accounts_descr => 'Inizia a usare tutta la magia di Monekin. Crea almeno un conto per iniziare ad aggiungere transazioni';
	@override String get last_transactions => 'Ultime transazioni';
	@override String get should_create_account_header => 'Oops!';
	@override String get should_create_account_message => 'Devi avere almeno un conto non archiviato prima di poter iniziare a creare transazioni';
}

// Path: financial_health
class _TranslationsFinancialHealthIt implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Salute finanziaria';
	@override late final _TranslationsFinancialHealthReviewIt review = _TranslationsFinancialHealthReviewIt._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeIt months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeIt._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageIt savings_percentage = _TranslationsFinancialHealthSavingsPercentageIt._(_root);
}

// Path: stats
class _TranslationsStatsIt implements TranslationsStatsEn {
	_TranslationsStatsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiche';
	@override String get balance => 'Saldo';
	@override String get final_balance => 'Saldo finale';
	@override String get balance_by_account => 'Saldo per conto';
	@override String get balance_by_account_subtitle => 'Dove ho la maggior parte dei miei soldi?';
	@override String get balance_by_currency => 'Saldo per valuta';
	@override String get balance_by_currency_subtitle => 'Quanti soldi ho in valuta estera?';
	@override String get balance_evolution => 'Andamento del saldo';
	@override String get balance_evolution_subtitle => 'Ho più soldi di prima?';
	@override String get compared_to_previous_period => 'Rispetto al periodo precedente';
	@override String get cash_flow => 'Flusso di cassa';
	@override String get cash_flow_subtitle => 'Sto spendendo meno di quanto guadagno?';
	@override String get by_periods => 'Per periodi';
	@override String get by_categories => 'Per categorie';
	@override String get by_tags => 'Per etichette';
	@override String get distribution => 'Distribuzione';
	@override String get finance_health_resume => 'Riepilogo';
	@override String get finance_health_breakdown => 'Ripartizione';
}

// Path: icon_selector
class _TranslationsIconSelectorIt implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome:';
	@override String get icon => 'Icona';
	@override String get color => 'Colore';
	@override String get select_icon => 'Seleziona un\'icona';
	@override String get select_color => 'Seleziona un colore';
	@override String get custom_color => 'Colore personalizzato';
	@override String get current_color_selection => 'Selezione attuale';
	@override String get select_account_icon => 'Identifica il tuo conto';
	@override String get select_category_icon => 'Identifica la tua categoria';
	@override late final _TranslationsIconSelectorScopesIt scopes = _TranslationsIconSelectorScopesIt._(_root);
}

// Path: transaction
class _TranslationsTransactionIt implements TranslationsTransactionEn {
	_TranslationsTransactionIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Transazione',
		other: 'Transazioni',
	);
	@override String get create => 'Nuova transazione';
	@override String get new_income => 'Nuova entrata';
	@override String get new_expense => 'Nuova spesa';
	@override String get new_success => 'Transazione creata con successo';
	@override String get edit => 'Modifica transazione';
	@override String get edit_success => 'Transazione modificata con successo';
	@override String get edit_multiple => 'Modifica transazioni';
	@override String edit_multiple_success({required Object x}) => '${x} transazioni modificate con successo';
	@override String get duplicate => 'Clona transazione';
	@override String get duplicate_short => 'Clona';
	@override String get duplicate_warning_message => 'Verrà creata una transazione identica a questa con la stessa data, vuoi continuare?';
	@override String get duplicate_success => 'Transazione clonata con successo';
	@override String get delete => 'Elimina transazione';
	@override String get delete_warning_message => 'Questa azione è irreversibile. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate';
	@override String get delete_success => 'Transazione eliminata correttamente';
	@override String get delete_multiple => 'Elimina transazioni';
	@override String delete_multiple_warning_message({required Object x}) => 'Questa azione è irreversibile ed eliminerà ${x} transazioni. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate';
	@override String delete_multiple_success({required Object x}) => '${x} transazioni eliminate correttamente';
	@override String get details => 'Dettagli movimento';
	@override late final _TranslationsTransactionNextPaymentsIt next_payments = _TranslationsTransactionNextPaymentsIt._(_root);
	@override late final _TranslationsTransactionListIt list = _TranslationsTransactionListIt._(_root);
	@override late final _TranslationsTransactionFiltersIt filters = _TranslationsTransactionFiltersIt._(_root);
	@override late final _TranslationsTransactionFormIt form = _TranslationsTransactionFormIt._(_root);
	@override late final _TranslationsTransactionReversedIt reversed = _TranslationsTransactionReversedIt._(_root);
	@override late final _TranslationsTransactionStatusIt status = _TranslationsTransactionStatusIt._(_root);
	@override late final _TranslationsTransactionTypesIt types = _TranslationsTransactionTypesIt._(_root);
}

// Path: transfer
class _TranslationsTransferIt implements TranslationsTransferEn {
	_TranslationsTransferIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Trasferimento';
	@override String get transfers => 'Trasferimenti';
	@override String transfer_to({required Object account}) => 'Trasferimento a ${account}';
	@override String get create => 'Nuovo Trasferimento';
	@override String get need_two_accounts_warning_header => 'Ops!';
	@override String get need_two_accounts_warning_message => 'Sono necessari almeno due conti per eseguire questa azione. Se devi regolare o modificare il saldo attuale di questo conto, clicca sul pulsante modifica';
	@override late final _TranslationsTransferFormIt form = _TranslationsTransferFormIt._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsIt implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transazioni ricorrenti';
	@override String get title_short => 'Trans. ric.';
	@override String get empty => 'Sembra che tu non abbia transazioni ricorrenti. Crea una transazione ricorrente mensile, annuale o settimanale e apparirà qui';
	@override String get total_expense_title => 'Spesa totale per periodo';
	@override String get total_expense_descr => '* Senza considerare la data di inizio e fine di ciascuna ricorrenza';
	@override late final _TranslationsRecurrentTransactionsDetailsIt details = _TranslationsRecurrentTransactionsDetailsIt._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusIt status = _TranslationsRecurrentTransactionsStatusIt._(_root);
}

// Path: account
class _TranslationsAccountIt implements TranslationsAccountEn {
	_TranslationsAccountIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get details => 'Dettagli conto';
	@override String get date => 'Data di apertura';
	@override String get close_date => 'Data di chiusura';
	@override String get reopen => 'Riapri conto';
	@override String get reopen_short => 'Riapri';
	@override String get reopen_descr => 'Sei sicuro di voler riaprire questo conto?';
	@override String get balance => 'Saldo del conto';
	@override String get n_transactions => 'Numero di transazioni';
	@override String get add_money => 'Aggiungi denaro';
	@override String get withdraw_money => 'Preleva denaro';
	@override String get no_accounts => 'Nessuna transazione trovata da mostrare qui. Aggiungi una transazione cliccando sul pulsante \'+\' in basso';
	@override late final _TranslationsAccountTypesIt types = _TranslationsAccountTypesIt._(_root);
	@override late final _TranslationsAccountFormIt form = _TranslationsAccountFormIt._(_root);
	@override late final _TranslationsAccountDeleteIt delete = _TranslationsAccountDeleteIt._(_root);
	@override late final _TranslationsAccountCloseIt close = _TranslationsAccountCloseIt._(_root);
	@override late final _TranslationsAccountSelectIt select = _TranslationsAccountSelectIt._(_root);
}

// Path: currencies
class _TranslationsCurrenciesIt implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Convertitore di valuta';
	@override String get currency => 'Valuta';
	@override String get currency_manager => 'Gestore valute';
	@override String get currency_manager_descr => 'Configura la tua valuta e i suoi tassi di cambio con altre';
	@override String get preferred_currency => 'Valuta preferita/base';
	@override String get change_preferred_currency_title => 'Cambia valuta preferita';
	@override String get change_preferred_currency_msg => 'Tutte le statistiche e i budget saranno visualizzati in questa valuta d\'ora in poi. Conti e transazioni manterranno la valuta che avevano. Tutti i tassi di cambio salvati verranno eliminati se esegui questa azione. Desideri continuare?';
	@override late final _TranslationsCurrenciesFormIt form = _TranslationsCurrenciesFormIt._(_root);
	@override String get delete_all_success => 'Tassi di cambio eliminati con successo';
	@override String get historical => 'Tassi storici';
	@override String get exchange_rate => 'Tasso di cambio';
	@override String get exchange_rates => 'Tassi di cambio';
	@override String get empty => 'Aggiungi tassi di cambio qui in modo che se hai conti in valute diverse dalla tua valuta base i nostri grafici siano più accurati';
	@override String get select_a_currency => 'Seleziona una valuta';
	@override String get search => 'Cerca per nome o per codice valuta';
}

// Path: tags
class _TranslationsTagsIt implements TranslationsTagsEn {
	_TranslationsTagsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Etichetta',
		other: 'Etichette',
	);
	@override late final _TranslationsTagsFormIt form = _TranslationsTagsFormIt._(_root);
	@override late final _TranslationsTagsSelectIt select = _TranslationsTagsSelectIt._(_root);
	@override String get empty_list => 'Non hai ancora creato alcuna etichetta. Etichette e categorie sono un ottimo modo per categorizzare i tuoi movimenti';
	@override String get without_tags => 'Senza etichette';
	@override String get add => 'Aggiungi etichetta';
	@override String get create => 'Crea etichetta';
	@override String get create_success => 'Etichetta creata con successo';
	@override String get already_exists => 'Questo nome di etichetta esiste già. Potresti volerla modificare';
	@override String get edit => 'Modifica etichetta';
	@override String get edit_success => 'Etichetta modificata con successo';
	@override String get delete_success => 'Categoria eliminata con successo';
	@override String get delete_warning_header => 'Eliminare etichetta?';
	@override String get delete_warning_message => 'Questa azione non eliminerà le transazioni che hanno questa etichetta.';
}

// Path: categories
class _TranslationsCategoriesIt implements TranslationsCategoriesEn {
	_TranslationsCategoriesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Categoria sconosciuta';
	@override String get create => 'Crea categoria';
	@override String get create_success => 'Categoria creata correttamente';
	@override String get new_category => 'Nuova categoria';
	@override String get already_exists => 'Il nome di questa categoria esiste già. Magari vuoi modificarla';
	@override String get edit => 'Modifica categoria';
	@override String get edit_success => 'Categoria modificata correttamente';
	@override String get name => 'Nome categoria';
	@override String get type => 'Tipo di categoria';
	@override String get both_types => 'Entrambi i tipi';
	@override String get subcategories => 'Sottocategorie';
	@override String get subcategories_add => 'Aggiungi sottocategoria';
	@override String get make_parent => 'Rendi categoria';
	@override String get make_child => 'Rendi una sottocategoria';
	@override String make_child_warning1({required Object destiny}) => 'Questa categoria e le sue sottocategorie diventeranno sottocategorie di <b>${destiny}</b>.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'Le loro transazioni <b>(${x})</b> saranno spostate nelle nuove sottocategorie create all\'interno della categoria <b>${destiny}</b>.';
	@override String get make_child_success => 'Sottocategorie create con successo';
	@override String get merge => 'Unisci con un\'altra categoria';
	@override String merge_warning1({required Object x, required Object from, required Object destiny}) => 'Tutte le transazioni (${x}) associate alla categoria <b>${from}</b> verranno spostate nella categoria <b>${destiny}</b>';
	@override String merge_warning2({required Object from}) => 'La categoria <b>${from}</b> verrà eliminata irreversibilmente.';
	@override String get merge_success => 'Categoria unita con successo';
	@override String get delete_success => 'Categoria eliminata correttamente';
	@override String get delete_warning_header => 'Eliminare categoria?';
	@override String delete_warning_message({required Object x}) => 'Questa azione eliminerà irreversibilmente tutte le transazioni <b>(${x})</b> relative a questa categoria.';
	@override late final _TranslationsCategoriesSelectIt select = _TranslationsCategoriesSelectIt._(_root);
}

// Path: budgets
class _TranslationsBudgetsIt implements TranslationsBudgetsEn {
	_TranslationsBudgetsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budget';
	@override String get repeated => 'Ricorrente';
	@override String get one_time => 'Una tantum';
	@override String get annual => 'Annuali';
	@override String get week => 'Settimanali';
	@override String get month => 'Mensili';
	@override String get actives => 'Attivi';
	@override String get pending => 'In attesa di inizio';
	@override String get finish => 'Terminati';
	@override String get from_budgeted => 'rimanenti di ';
	@override String get days_left => 'giorni rimasti';
	@override String get days_to_start => 'giorni all\'inizio';
	@override String get since_expiration => 'giorni dalla scadenza';
	@override String get no_budgets => 'Sembra che non ci siano budget da visualizzare in questa sezione. Inizia creando un budget cliccando sul pulsante in basso';
	@override String get delete => 'Elimina budget';
	@override String get delete_warning => 'Questa azione è irreversibile. Categorie e transazioni relative a questa quotazione non verranno eliminate';
	@override late final _TranslationsBudgetsFormIt form = _TranslationsBudgetsFormIt._(_root);
	@override late final _TranslationsBudgetsDetailsIt details = _TranslationsBudgetsDetailsIt._(_root);
}

// Path: backup
class _TranslationsBackupIt implements TranslationsBackupEn {
	_TranslationsBackupIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportIt export = _TranslationsBackupExportIt._(_root);
	@override late final _TranslationsBackupImportIt import = _TranslationsBackupImportIt._(_root);
	@override late final _TranslationsBackupAboutIt about = _TranslationsBackupAboutIt._(_root);
}

// Path: settings
class _TranslationsSettingsIt implements TranslationsSettingsEn {
	_TranslationsSettingsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Impostazioni e aspetto';
	@override String get title_short => 'Impostazioni';
	@override String get description => 'Tema dell\'app, testi e altre impostazioni generali';
	@override String get edit_profile => 'Modifica profilo';
	@override String get lang_section => 'Lingua e testi';
	@override String get lang_title => 'Lingua dell\'app';
	@override String get lang_descr => 'Lingua in cui i testi verranno visualizzati nell\'app';
	@override String get lang_help => 'Se vuoi collaborare con le traduzioni di questa app, puoi consultare <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>la nostra guida</a>';
	@override String get locale => 'Regione';
	@override String get locale_auto => 'Sistema';
	@override String get locale_descr => 'Imposta il formato da utilizzare per date, numeri...';
	@override String get locale_warn => 'Quando cambi regione l\'app si aggiornerà';
	@override String get first_day_of_week => 'Primo giorno della settimana';
	@override String get theme_and_colors => 'Tema e colori';
	@override String get theme => 'Tema';
	@override String get theme_auto => 'Sistema';
	@override String get theme_light => 'Chiaro';
	@override String get theme_dark => 'Scuro';
	@override String get amoled_mode => 'Modalità AMOLED';
	@override String get amoled_mode_descr => 'Usa uno sfondo nero puro quando possibile. Questo aiuterà leggermente la batteria dei dispositivi con schermi AMOLED';
	@override String get dynamic_colors => 'Colori dinamici';
	@override String get dynamic_colors_descr => 'Usa il colore di accento del tuo sistema quando possibile';
	@override String get accent_color => 'Colore di accento';
	@override String get accent_color_descr => 'Scegli il colore che l\'app utilizzerà per enfatizzare determinate parti dell\'interfaccia';
	@override late final _TranslationsSettingsSwipeActionsIt swipe_actions = _TranslationsSettingsSwipeActionsIt._(_root);
	@override late final _TranslationsSettingsSecurityIt security = _TranslationsSettingsSecurityIt._(_root);
}

// Path: more
class _TranslationsMoreIt implements TranslationsMoreEn {
	_TranslationsMoreIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Altro';
	@override String get title_long => 'Altre azioni';
	@override late final _TranslationsMoreDataIt data = _TranslationsMoreDataIt._(_root);
	@override late final _TranslationsMoreAboutUsIt about_us = _TranslationsMoreAboutUsIt._(_root);
	@override late final _TranslationsMoreHelpUsIt help_us = _TranslationsMoreHelpUsIt._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardIt implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} copiato negli appunti';
	@override String get error => 'Errore di copia';
}

// Path: general.time
class _TranslationsGeneralTimeIt implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Data di inizio';
	@override String get end_date => 'Data di fine';
	@override String get from_date => 'Dalla data';
	@override String get until_date => 'Fino alla data';
	@override String get date => 'Data';
	@override String get datetime => 'Data e ora';
	@override String get time => 'Ora';
	@override String get each => 'Ogni';
	@override String get after => 'Dopo';
	@override late final _TranslationsGeneralTimeRangesIt ranges = _TranslationsGeneralTimeRangesIt._(_root);
	@override late final _TranslationsGeneralTimePeriodicityIt periodicity = _TranslationsGeneralTimePeriodicityIt._(_root);
	@override late final _TranslationsGeneralTimeCurrentIt current = _TranslationsGeneralTimeCurrentIt._(_root);
	@override late final _TranslationsGeneralTimeAllIt all = _TranslationsGeneralTimeAllIt._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderIt implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ordina transazioni';
	@override String get category => 'Per categoria';
	@override String get quantity => 'Per quantità';
	@override String get date => 'Per data';
}

// Path: general.validations
class _TranslationsGeneralValidationsIt implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Correggi i campi indicati per continuare';
	@override String get required => 'Campo obbligatorio';
	@override String get positive => 'Deve essere positivo';
	@override String min_number({required Object x}) => 'Deve essere maggiore di ${x}';
	@override String max_number({required Object x}) => 'Deve essere minore di ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewIt implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Ottima!';
			case GenderContext.female:
				return 'Ottima!';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Buona';
			case GenderContext.female:
				return 'Buona';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Media';
			case GenderContext.female:
				return 'Media';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Discreta';
			case GenderContext.female:
				return 'Discreta';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Molto Cattiva';
			case GenderContext.female:
				return 'Molto Cattiva';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Dati insufficienti';
			case GenderContext.female:
				return 'Dati insufficienti';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrIt descr = _TranslationsFinancialHealthReviewDescrIt._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeIt implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tasso di sopravvivenza';
	@override String get subtitle => 'Dato il tuo saldo, il tempo che potresti resistere senza entrate';
	@override String get text_zero => 'Non potresti sopravvivere un mese senza entrate a questo tasso di spese!';
	@override String get text_one => 'Potresti a malapena sopravvivere circa un mese senza entrate a questo tasso di spese!';
	@override String text_other({required Object n}) => 'Potresti sopravvivere circa <b>${n} mesi</b> senza entrate a questo tasso di spesa.';
	@override String get text_infinite => 'Potresti sopravvivere circa <b>tutta la vita</b> senza entrate a questo tasso di spesa.';
	@override String get suggestion => 'Ricorda che è consigliabile mantenere questo rapporto al di sopra dei 5 mesi almeno. Se vedi che non hai un cuscinetto di risparmio sufficiente, riduci le spese non necessarie.';
	@override String get insufficient_data => 'Sembra che non abbiamo abbastanza spese per calcolare quanti mesi potresti sopravvivere senza entrate. Inserisci alcune transazioni e torna qui per controllare la tua salute finanziaria';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageIt implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Percentuale di risparmio';
	@override String get subtitle => 'Quale parte del tuo reddito non viene spesa in questo periodo';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextIt text = _TranslationsFinancialHealthSavingsPercentageTextIt._(_root);
	@override String get suggestion => 'Ricorda che è consigliabile risparmiare almeno il 15-20% di ciò che guadagni.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesIt implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Trasporto';
	@override String get money => 'Denaro';
	@override String get food => 'Cibo';
	@override String get medical => 'Salute';
	@override String get entertainment => 'Tempo libero';
	@override String get technology => 'Tecnologia';
	@override String get other => 'Altro';
	@override String get logos_financial_institutions => 'Istituzioni finanziarie';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsIt implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get accept => 'Accetta';
	@override String get skip => 'Salta';
	@override String get skip_success => 'Transazione saltata con successo';
	@override String get skip_dialog_title => 'Salta transazione';
	@override String skip_dialog_msg({required Object date}) => 'Questa azione è irreversibile. Sposteremo la data del prossimo movimento al ${date}';
	@override String get accept_today => 'Accetta oggi';
	@override String accept_in_required_date({required Object date}) => 'Accetta alla data richiesta (${date})';
	@override String get accept_dialog_title => 'Accetta transazione';
	@override String get accept_dialog_msg_single => 'Il nuovo stato della transazione sarà nullo. Potrai ri-modificare lo stato di questa transazione quando vuoi';
	@override String accept_dialog_msg({required Object date}) => 'Questa azione creerà una nuova transazione con data ${date}. Potrai controllare i dettagli di questa transazione sulla pagina delle transazioni';
	@override String get recurrent_rule_finished => 'La regola ricorrente è stata completata, non ci sono più pagamenti da effettuare!';
}

// Path: transaction.list
class _TranslationsTransactionListIt implements TranslationsTransactionListEn {
	_TranslationsTransactionListIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Nessuna transazione trovata da mostrare qui. Aggiungi alcune transazioni nell\'app e magari sarai più fortunato la prossima volta.';
	@override String get searcher_placeholder => 'Cerca per categoria, descrizione...';
	@override String get searcher_no_results => 'Nessuna transazione trovata corrispondente ai criteri di ricerca';
	@override String get loading => 'Caricamento di altre transazioni...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} selezionato',
		other: '${n} selezionati',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} transazione selezionata',
		other: '${n} transazioni selezionate',
	);
	@override late final _TranslationsTransactionListBulkEditIt bulk_edit = _TranslationsTransactionListBulkEditIt._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersIt implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get from_value => 'Da importo';
	@override String get to_value => 'Fino a importo';
	@override String from_value_def({required Object x}) => 'Da ${x}';
	@override String to_value_def({required Object x}) => 'Fino a ${x}';
	@override String from_date_def({required Object date}) => 'Dalla data ${date}';
	@override String to_date_def({required Object date}) => 'Fino alla data ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormIt implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsIt validators = _TranslationsTransactionFormValidatorsIt._(_root);
	@override String get title => 'Titolo transazione';
	@override String get title_short => 'Titolo';
	@override String get value => 'Valore della transazione';
	@override String get tap_to_see_more => 'Tocca per vedere più dettagli';
	@override String get no_tags => '-- Nessuna etichetta --';
	@override String get description => 'Descrizione';
	@override String get description_info => 'Tocca qui per inserire una descrizione più dettagliata su questa transazione';
	@override String exchange_to_preferred_title({required Object currency}) => 'Tasso di cambio per ${currency}';
	@override String get exchange_to_preferred_in_date => 'Alla data della transazione';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedIt implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transazione inversa';
	@override String get title_short => 'Trans. inversa';
	@override String get description_for_expenses => 'Nonostante sia una transazione di spesa, ha un importo positivo. Questi tipi di transazioni possono essere utilizzati per rappresentare la restituzione di una spesa precedentemente registrata, come un rimborso o il pagamento di un debito.';
	@override String get description_for_incomes => 'Nonostante sia una transazione di entrata, ha un importo negativo. Questi tipi di transazioni possono essere utilizzati per annullare o correggere un\'entrata registrata in modo errato, per riflettere una restituzione o un rimborso di denaro o per registrare il pagamento di debiti.';
}

// Path: transaction.status
class _TranslationsTransactionStatusIt implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Stato',
		other: 'Stati',
	);
	@override String get display_long => 'Stato transazione';
	@override String tr_status({required Object status}) => 'Transazione ${status}';
	@override String get none => 'Senza stato';
	@override String get none_descr => 'Transazione senza uno stato specifico';
	@override String get reconciled => 'Riconciliata';
	@override String get reconciled_descr => 'Questa transazione è già stata convalidata e corrisponde a una transazione reale della tua banca';
	@override String get unreconciled => 'Non riconciliata';
	@override String get unreconciled_descr => 'Questa transazione non è ancora stata convalidata e pertanto non appare ancora nei tuoi conti bancari reali. Tuttavia, conta per il calcolo dei saldi e delle statistiche in Monekin';
	@override String get pending => 'In sospeso';
	@override String get pending_descr => 'Questa transazione è in sospeso e pertanto non verrà presa in considerazione nel calcolo dei saldi e delle statistiche';
	@override String get voided => 'Annullata';
	@override String get voided_descr => 'Transazione annullata/cancellata a causa di errore di pagamento o qualsiasi altra ragione. Non verrà presa in considerazione nel calcolo dei saldi e delle statistiche';
}

// Path: transaction.types
class _TranslationsTransactionTypesIt implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Tipo di transazione',
		other: 'Tipi di transazione',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Entrata',
		other: 'Entrate',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Spesa',
		other: 'Spese',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Trasferimento',
		other: 'Trasferimenti',
	);
}

// Path: transfer.form
class _TranslationsTransferFormIt implements TranslationsTransferFormEn {
	_TranslationsTransferFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get from => 'Conto di origine';
	@override String get to => 'Conto di destinazione';
	@override late final _TranslationsTransferFormValueInDestinyIt value_in_destiny = _TranslationsTransferFormValueInDestinyIt._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsIt implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transazione ricorrente';
	@override String get descr => 'I prossimi movimenti per questa transazione sono mostrati di seguito. Puoi accettare il primo movimento o saltarlo';
	@override String get last_payment_info => 'Questo movimento è l\'ultimo della regola ricorrente, quindi questa regola verrà automaticamente eliminata confermando questa azione';
	@override String get delete_header => 'Elimina transazione ricorrente';
	@override String get delete_message => 'Questa azione è irreversibile e non influenzerà le transazioni che hai già confermato/pagato';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusIt implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Ritardato di ${x}g';
	@override String coming_in({required Object x}) => 'Tra ${x} giorni';
}

// Path: account.types
class _TranslationsAccountTypesIt implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tipo di conto';
	@override String get warning => 'Una volta scelto il tipo di conto, non potrà essere modificato in futuro';
	@override String get normal => 'Conto normale';
	@override String get normal_descr => 'Utile per registrare le tue finanze quotidiane. È il conto più comune, ti permette di aggiungere spese, entrate...';
	@override String get saving => 'Conto risparmio';
	@override String get saving_descr => 'Potrai solo aggiungere e prelevare denaro da esso da altri conti. Perfetto per iniziare a risparmiare denaro';
}

// Path: account.form
class _TranslationsAccountFormIt implements TranslationsAccountFormEn {
	_TranslationsAccountFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome conto';
	@override String get name_placeholder => 'Es: Conto risparmio';
	@override String get notes => 'Note';
	@override String get notes_placeholder => 'Digita alcune note/descrizione su questo conto';
	@override String get initial_balance => 'Saldo iniziale';
	@override String get current_balance => 'Saldo attuale';
	@override String get create => 'Crea conto';
	@override String get edit => 'Modifica conto';
	@override String get currency_not_found_warn => 'Non hai informazioni sui tassi di cambio per questa valuta. Verrà utilizzato 1.0 come tasso di cambio predefinito. Puoi modificarlo nelle impostazioni';
	@override String get already_exists => 'Ne esiste già un altro con lo stesso nome, per favore scrivine un altro';
	@override String get tr_before_opening_date => 'Ci sono transazioni in questo conto con una data precedente alla data di apertura';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteIt implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Eliminare conto?';
	@override String get warning_text => 'Questa azione eliminerà questo conto e tutte le sue transazioni';
	@override String get success => 'Conto eliminato con successo';
}

// Path: account.close
class _TranslationsAccountCloseIt implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chiudi conto';
	@override String get title_short => 'Chiudi';
	@override String get warn => 'Questo conto non apparirà più in determinati elenchi e non potrai creare transazioni in esso con una data successiva a quella specificata di seguito. Questa azione non influisce su transazioni o saldo, e puoi anche riaprire questo conto in qualsiasi momento.';
	@override String get should_have_zero_balance => 'Devi avere un saldo attuale di 0 in questo conto per chiuderlo. Per favore modifica il conto prima di continuare';
	@override String get should_have_no_transactions => 'Questo conto ha transazioni dopo la data di chiusura specificata. Eliminale o modifica la data di chiusura del conto prima di continuare';
	@override String get success => 'Conto chiuso con successo';
	@override String get unarchive_succes => 'Conto riaperto con successo';
}

// Path: account.select
class _TranslationsAccountSelectIt implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get one => 'Seleziona un conto';
	@override String get all => 'Tutti i conti';
	@override String get multiple => 'Seleziona conti';
}

// Path: currencies.form
class _TranslationsCurrenciesFormIt implements TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'La valuta non può essere uguale alla valuta dell\'utente';
	@override String get specify_a_currency => 'Per favore specifica una valuta';
	@override String get add => 'Aggiungi tasso di cambio';
	@override String get add_success => 'Tasso di cambio aggiunto con successo';
	@override String get edit => 'Modifica tasso di cambio';
	@override String get edit_success => 'Tasso di cambio modificato con successo';
}

// Path: tags.form
class _TranslationsTagsFormIt implements TranslationsTagsFormEn {
	_TranslationsTagsFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome etichetta';
	@override String get description => 'Descrizione';
}

// Path: tags.select
class _TranslationsTagsSelectIt implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleziona etichette';
	@override String get all => 'Tutte le etichette';
}

// Path: categories.select
class _TranslationsCategoriesSelectIt implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seleziona categorie';
	@override String get select_one => 'Seleziona una categoria';
	@override String get select_subcategory => 'Scegli una sottocategoria';
	@override String get without_subcategory => 'Senza sottocategoria';
	@override String get all => 'Tutte le categorie';
	@override String get all_short => 'Tutte';
}

// Path: budgets.form
class _TranslationsBudgetsFormIt implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aggiungi un budget';
	@override String get name => 'Nome budget';
	@override String get value => 'Quantità limite';
	@override String get create => 'Aggiungi budget';
	@override String get edit => 'Modifica budget';
	@override String get negative_warn => 'I budget non possono avere un importo negativo';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsIt implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dettagli budget';
	@override String get statistics => 'Statistiche';
	@override String get budget_value => 'A budget';
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Puoi spendere ${dailyAmount}/giorno per ${remainingDays} giorni rimanenti';
	@override String get expend_evolution => 'Evoluzione della spesa';
	@override String get no_transactions => 'Sembra che tu non abbia effettuato spese relative a questo budget';
}

// Path: backup.export
class _TranslationsBackupExportIt implements TranslationsBackupExportEn {
	_TranslationsBackupExportIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Esporta i tuoi dati';
	@override String get title_short => 'Esporta';
	@override String get all => 'Backup completo';
	@override String get all_descr => 'Esporta tutti i tuoi dati (conti, transazioni, budget, impostazioni...). Importali di nuovo in qualsiasi momento per non perdere nulla.';
	@override String get transactions => 'Backup transazioni';
	@override String get transactions_descr => 'Esporta le tue transazioni in CSV in modo da poterle analizzare più facilmente in altri programmi o applicazioni.';
	@override String get description => 'Scarica i tuoi dati in diversi formati';
	@override String get dialog_title => 'Salva/Invia file';
	@override String success({required Object x}) => 'File salvato/scaricato con successo in ${x}';
	@override String get error => 'Errore durante il download del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportIt implements TranslationsBackupImportEn {
	_TranslationsBackupImportIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importa i tuoi dati';
	@override String get title_short => 'Importa';
	@override String get restore_backup => 'Ripristina backup';
	@override String get restore_backup_descr => 'Importa un database precedentemente salvato da Monekin. Questa azione sostituirà tutti i dati attuali dell\'applicazione con i nuovi dati';
	@override String get restore_backup_warn_description => 'Importando un nuovo database, perderai tutti i dati attualmente salvati nell\'app. Si consiglia di effettuare un backup prima di continuare. Non caricare qui alcun file la cui origine non conosci, carica solo file che hai precedentemente scaricato da Monekin';
	@override String get restore_backup_warn_title => 'Sovrascrivi tutti i dati';
	@override String get select_other_file => 'Seleziona un altro file';
	@override String get tap_to_select_file => 'Tocca per selezionare un file';
	@override late final _TranslationsBackupImportManualImportIt manual_import = _TranslationsBackupImportManualImportIt._(_root);
	@override String get success => 'Importazione eseguita con successo';
	@override String get cancelled => 'Importazione annullata dall\'utente';
	@override String get error => 'Errore durante l\'importazione del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutIt implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informazioni sul tuo database';
	@override String get create_date => 'Data di creazione';
	@override String get modify_date => 'Ultima modifica';
	@override String get last_backup => 'Ultimo backup';
	@override String get size => 'Dimensione';
}

// Path: settings.swipe_actions
class _TranslationsSettingsSwipeActionsIt implements TranslationsSettingsSwipeActionsEn {
	_TranslationsSettingsSwipeActionsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Azioni di scorrimento';
	@override String get choose_description => 'Scegli quale azione verrà attivata quando fai scorrere un elemento di transazione nell\'elenco utilizzando questa direzione di scorrimento';
	@override String get swipe_left => 'Scorri verso sinistra';
	@override String get swipe_right => 'Scorri verso destra';
	@override String get none => 'Nessuna azione';
	@override String get toggle_reconciled => 'Attiva/disattiva riconciliato';
	@override String get toggle_pending => 'Attiva/disattiva in sospeso';
	@override String get toggle_voided => 'Attivazione/disattivazione annullata';
	@override String get toggle_unreconciled => 'Attiva/disattiva non riconciliato';
	@override String get remove_status => 'Rimuovi lo stato';
}

// Path: settings.security
class _TranslationsSettingsSecurityIt implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sicurezza';
	@override String get private_mode_at_launch => 'Modalità privata all\'avvio';
	@override String get private_mode_at_launch_descr => 'Avvia l\'app in modalità privata per impostazione predefinita';
	@override String get private_mode => 'Modalità privata';
	@override String get private_mode_descr => 'Nascondi tutti i valori monetari';
	@override String get private_mode_activated => 'Modalità privata attivata';
	@override String get private_mode_deactivated => 'Modalità privata disattivata';
}

// Path: more.data
class _TranslationsMoreDataIt implements TranslationsMoreDataEn {
	_TranslationsMoreDataIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Dati';
	@override String get display_descr => 'Esporta e importa i tuoi dati per non perdere nulla';
	@override String get delete_all => 'Elimina i miei dati';
	@override String get delete_all_header1 => 'Fermati subito padawan ⚠️⚠️';
	@override String get delete_all_message1 => 'Sei sicuro di voler continuare? Tutti i tuoi dati verranno eliminati in modo permanente e non potranno essere recuperati';
	@override String get delete_all_header2 => 'Un ultimo passo ⚠️⚠️';
	@override String get delete_all_message2 => 'Eliminando un account eliminerai tutti i tuoi dati personali memorizzati. I tuoi conti, transazioni, budget e categorie verranno eliminati e non potranno essere recuperati. Sei d\'accordo?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsIt implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Informazioni sull\'app';
	@override String get description => 'Consulta i termini e altre informazioni rilevanti su Monekin. Entra in contatto con la comunità segnalando bug, lasciando suggerimenti...';
	@override late final _TranslationsMoreAboutUsLegalIt legal = _TranslationsMoreAboutUsLegalIt._(_root);
	@override late final _TranslationsMoreAboutUsProjectIt project = _TranslationsMoreAboutUsProjectIt._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsIt implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Aiutaci';
	@override String get description => 'Scopri come puoi aiutare Monekin a migliorare sempre di più';
	@override String get rate_us => 'Valutaci';
	@override String get rate_us_descr => 'Ogni valutazione è benvenuta!';
	@override String get share => 'Condividi Monekin';
	@override String get share_descr => 'Condividi la nostra app con amici e famiglia';
	@override String get share_text => 'Monekin! La migliore app di finanza personale. Scaricala qui';
	@override String get thanks => 'Grazie!';
	@override String get thanks_long => 'I tuoi contributi a Monekin e ad altri progetti open source, grandi e piccoli, rendono possibili grandi progetti come questo. Grazie per aver dedicato tempo a contribuire.';
	@override String get donate => 'Fai una donazione';
	@override String get donate_descr => 'Con la tua donazione aiuterai l\'app a continuare a ricevere miglioramenti. Quale modo migliore per ringraziare il lavoro svolto se non invitandomi per un caffè?';
	@override String get donate_success => 'Donazione effettuata. Grazie mille per il tuo contributo! ❤️';
	@override String get donate_err => 'Oops! Sembra che ci sia stato un errore nel ricevere il tuo pagamento';
	@override String get report => 'Segnala bug, lascia suggerimenti...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesIt implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Intervallo di tempo';
	@override String get it_repeat => 'Si ripete';
	@override String get it_ends => 'Termina';
	@override String get forever => 'Sempre';
	@override late final _TranslationsGeneralTimeRangesTypesIt types = _TranslationsGeneralTimeRangesTypesIt._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Ogni ${range}',
		other: 'Ogni ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Ogni ${range} fino al ${day}',
		other: 'Ogni ${n} ${range} fino al ${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Ogni ${range} ${limit} volte',
		other: 'Ogni ${n} ${range} ${limit} volte',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Ogni ${range} una volta',
		other: 'Ogni ${n} ${range} una volta',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Mese',
		other: 'Mesi',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Anno',
		other: 'Anni',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Giorno',
		other: 'Giorni',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Settimana',
		other: 'Settimane',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityIt implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ricorrenza';
	@override String get no_repeat => 'Non si ripete';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Ripetizione',
		other: 'Ripetizioni',
	);
	@override String get diary => 'Giornaliera';
	@override String get monthly => 'Mensile';
	@override String get annually => 'Annuale';
	@override String get quaterly => 'Trimestrale';
	@override String get weekly => 'Settimanale';
	@override String get custom => 'Personalizzata';
	@override String get infinite => 'Sempre';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentIt implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Questo mese';
	@override String get annually => 'Quest\'anno';
	@override String get quaterly => 'Questo trimestre';
	@override String get weekly => 'Questa settimana';
	@override String get infinite => 'Per sempre';
	@override String get custom => 'Intervallo personalizzato';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllIt implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Ogni giorno';
	@override String get monthly => 'Ogni mese';
	@override String get annually => 'Ogni anno';
	@override String get quaterly => 'Ogni trimestre';
	@override String get weekly => 'Ogni settimana';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrIt implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Sembra che non abbiamo abbastanza spese per calcolare la tua salute finanziaria. Aggiungi alcune spese/entrate in questo periodo per permetterci di aiutarti!';
	@override String get very_good => 'Congratulazioni! La tua salute finanziaria è eccezionale. Speriamo che continui la tua buona serie e continui a imparare con Monekin';
	@override String get good => 'Ottimo! La tua salute finanziaria è buona. Visita la scheda di analisi per vedere come risparmiare ancora di più!';
	@override String get normal => 'La tua salute finanziaria è più o meno nella media del resto della popolazione per questo periodo';
	@override String get bad => 'Sembra che la tua situazione finanziaria non sia ancora delle migliori. Esplora il resto dei grafici per saperne di più sulle tue finanze';
	@override String get very_bad => 'Mmm, la tua salute finanziaria è ben al di sotto di quanto dovrebbe essere. Esplora il resto dei grafici per saperne di più sulle tue finanze';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextIt implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Congratulazioni! Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Sembra che tu sia già un esperto, continua così!';
	@override String normal({required Object value}) => 'Congratulazioni, sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo.';
	@override String bad({required Object value}) => 'Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Tuttavia, pensiamo che tu possa fare ancora molto di più!';
	@override String get very_bad => 'Wow, non sei riuscito a risparmiare nulla durante questo periodo.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditIt implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Modifica date';
	@override String get categories => 'Modifica categorie';
	@override String get status => 'Modifica stati';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsIt implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get zero => 'Il valore di una transazione non può essere uguale a zero';
	@override String get date_max => 'La data selezionata è successiva a quella attuale. La transazione verrà aggiunta come in sospeso';
	@override String get date_after_account_creation => 'Non puoi creare una transazione la cui data sia precedente alla data di creazione del conto a cui appartiene';
	@override String get negative_transfer => 'Il valore monetario di un trasferimento non può essere negativo';
	@override String get transfer_between_same_accounts => 'Il conto di origine e quello di destinazione non possono essere gli stessi';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyIt implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importo trasferito a destinazione';
	@override String amount_short({required Object amount}) => '${amount} al conto di destinazione';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportIt implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importazione manuale';
	@override String get descr => 'Importa manualmente le transazioni da un file .csv';
	@override String get default_account => 'Conto predefinito';
	@override String get remove_default_account => 'Rimuovi conto predefinito';
	@override String get default_category => 'Categoria predefinita';
	@override String get select_a_column => 'Seleziona una colonna dal .csv';
	@override List<String> get steps => [
		'Seleziona il tuo file',
		'Colonna per la quantità',
		'Colonna per il conto',
		'Colonna per la categoria',
		'Colonna per la data',
		'altre colonne',
	];
	@override List<String> get steps_descr => [
		'Seleziona un file .csv dal tuo dispositivo. Assicurati che abbia una prima riga che descriva il nome di ciascuna colonna',
		'Seleziona la colonna in cui è specificato il valore di ogni transazione. Usa valori negativi per le spese e valori positivi per le entrate. Usa un punto come separatore decimale',
		'Seleziona la colonna in cui è specificato il conto a cui appartiene ogni transazione. Puoi anche selezionare un conto predefinito nel caso in cui non riusciamo a trovare il conto che desideri. Se non viene specificato un conto predefinito, ne creeremo uno con lo stesso nome',
		'Specifica la colonna in cui si trova il nome della categoria della transazione. Devi specificare una categoria predefinita in modo da assegnare questa categoria alle transazioni, nel caso in cui la categoria non possa essere trovata',
		'Seleziona la colonna in cui è specificata la data di ogni transazione. Se non specificato, le transazioni verranno create con la data attuale',
		'Specifica le colonne per altri attributi opzionali della transazione',
	];
	@override String success({required Object x}) => '${x} transazioni importate con successo';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalIt implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Informazioni legali';
	@override String get privacy => 'Informativa sulla privacy';
	@override String get terms => 'Termini di utilizzo';
	@override String get licenses => 'Licenze';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectIt implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Progetto';
	@override String get contributors => 'Collaboratori';
	@override String get contributors_descr => 'Tutti gli sviluppatori che hanno fatto crescere Monekin';
	@override String get contact => 'Contattaci';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesIt implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Cicli';
	@override String get last_days => 'Ultimi giorni';
	@override String last_days_form({required Object x}) => '${x} giorni precedenti';
	@override String get all => 'Sempre';
	@override String get date_range => 'Intervallo personalizzato';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return 'Annulla';
			case 'ui_actions.confirm': return 'Conferma';
			case 'ui_actions.continue_text': return 'Continua';
			case 'ui_actions.save': return 'Salva';
			case 'ui_actions.save_changes': return 'Salva modifiche';
			case 'ui_actions.close_and_save': return 'Salva e chiudi';
			case 'ui_actions.add': return 'Aggiungi';
			case 'ui_actions.edit': return 'Modifica';
			case 'ui_actions.delete': return 'Elimina';
			case 'ui_actions.see_more': return 'Vedi altro';
			case 'ui_actions.select_all': return 'Seleziona tutto';
			case 'ui_actions.deselect_all': return 'Deseleziona tutto';
			case 'ui_actions.select': return 'Seleziona';
			case 'ui_actions.search': return 'Cerca';
			case 'ui_actions.filter': return 'Filtra';
			case 'ui_actions.reset': return 'Ripristina';
			case 'ui_actions.submit': return 'Invia';
			case 'ui_actions.next': return 'Avanti';
			case 'ui_actions.previous': return 'Precedente';
			case 'ui_actions.back': return 'Indietro';
			case 'ui_actions.reload': return 'Ricarica';
			case 'ui_actions.view': return 'Visualizza';
			case 'ui_actions.download': return 'Scarica';
			case 'ui_actions.upload': return 'Carica';
			case 'ui_actions.retry': return 'Riprova';
			case 'ui_actions.copy': return 'Copia';
			case 'ui_actions.paste': return 'Incolla';
			case 'ui_actions.undo': return 'Annulla';
			case 'ui_actions.redo': return 'Ripristina';
			case 'ui_actions.open': return 'Apri';
			case 'ui_actions.close': return 'Chiudi';
			case 'ui_actions.apply': return 'Applica';
			case 'ui_actions.discard': return 'Ignora';
			case 'ui_actions.refresh': return 'Aggiorna';
			case 'ui_actions.details': return 'Dettagli';
			case 'ui_actions.share': return 'Condividi';
			case 'general.or': return 'o';
			case 'general.understood': return 'Capito';
			case 'general.unspecified': return 'Non specificato';
			case 'general.quick_actions': return 'Azioni rapide';
			case 'general.balance': return 'Saldo';
			case 'general.account': return 'Conto';
			case 'general.accounts': return 'Conti';
			case 'general.categories': return 'Categorie';
			case 'general.category': return 'Categoria';
			case 'general.today': return 'Oggi';
			case 'general.yesterday': return 'Ieri';
			case 'general.filters': return 'Filtri';
			case 'general.empty_warn': return 'Ops! È davvero vuoto';
			case 'general.insufficient_data': return 'Dati insufficienti';
			case 'general.show_more_fields': return 'Mostra più campi';
			case 'general.show_less_fields': return 'Mostra meno campi';
			case 'general.tap_to_search': return 'Tocca per cercare';
			case 'general.clipboard.success': return ({required Object x}) => '${x} copiato negli appunti';
			case 'general.clipboard.error': return 'Errore di copia';
			case 'general.time.start_date': return 'Data di inizio';
			case 'general.time.end_date': return 'Data di fine';
			case 'general.time.from_date': return 'Dalla data';
			case 'general.time.until_date': return 'Fino alla data';
			case 'general.time.date': return 'Data';
			case 'general.time.datetime': return 'Data e ora';
			case 'general.time.time': return 'Ora';
			case 'general.time.each': return 'Ogni';
			case 'general.time.after': return 'Dopo';
			case 'general.time.ranges.display': return 'Intervallo di tempo';
			case 'general.time.ranges.it_repeat': return 'Si ripete';
			case 'general.time.ranges.it_ends': return 'Termina';
			case 'general.time.ranges.forever': return 'Sempre';
			case 'general.time.ranges.types.cycle': return 'Cicli';
			case 'general.time.ranges.types.last_days': return 'Ultimi giorni';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '${x} giorni precedenti';
			case 'general.time.ranges.types.all': return 'Sempre';
			case 'general.time.ranges.types.date_range': return 'Intervallo personalizzato';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range}',
				other: 'Ogni ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range} fino al ${day}',
				other: 'Ogni ${n} ${range} fino al ${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range} ${limit} volte',
				other: 'Ogni ${n} ${range} ${limit} volte',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range} una volta',
				other: 'Ogni ${n} ${range} una volta',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Mese',
				other: 'Mesi',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Anno',
				other: 'Anni',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Giorno',
				other: 'Giorni',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Settimana',
				other: 'Settimane',
			);
			case 'general.time.periodicity.display': return 'Ricorrenza';
			case 'general.time.periodicity.no_repeat': return 'Non si ripete';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ripetizione',
				other: 'Ripetizioni',
			);
			case 'general.time.periodicity.diary': return 'Giornaliera';
			case 'general.time.periodicity.monthly': return 'Mensile';
			case 'general.time.periodicity.annually': return 'Annuale';
			case 'general.time.periodicity.quaterly': return 'Trimestrale';
			case 'general.time.periodicity.weekly': return 'Settimanale';
			case 'general.time.periodicity.custom': return 'Personalizzata';
			case 'general.time.periodicity.infinite': return 'Sempre';
			case 'general.time.current.monthly': return 'Questo mese';
			case 'general.time.current.annually': return 'Quest\'anno';
			case 'general.time.current.quaterly': return 'Questo trimestre';
			case 'general.time.current.weekly': return 'Questa settimana';
			case 'general.time.current.infinite': return 'Per sempre';
			case 'general.time.current.custom': return 'Intervallo personalizzato';
			case 'general.time.all.diary': return 'Ogni giorno';
			case 'general.time.all.monthly': return 'Ogni mese';
			case 'general.time.all.annually': return 'Ogni anno';
			case 'general.time.all.quaterly': return 'Ogni trimestre';
			case 'general.time.all.weekly': return 'Ogni settimana';
			case 'general.transaction_order.display': return 'Ordina transazioni';
			case 'general.transaction_order.category': return 'Per categoria';
			case 'general.transaction_order.quantity': return 'Per quantità';
			case 'general.transaction_order.date': return 'Per data';
			case 'general.validations.form_error': return 'Correggi i campi indicati per continuare';
			case 'general.validations.required': return 'Campo obbligatorio';
			case 'general.validations.positive': return 'Deve essere positivo';
			case 'general.validations.min_number': return ({required Object x}) => 'Deve essere maggiore di ${x}';
			case 'general.validations.max_number': return ({required Object x}) => 'Deve essere minore di ${x}';
			case 'intro.start': return 'Inizia';
			case 'intro.skip': return 'Salta';
			case 'intro.next': return 'Avanti';
			case 'intro.select_your_currency': return 'Seleziona la tua valuta';
			case 'intro.welcome_subtitle': return 'Il tuo gestore di finanze personali';
			case 'intro.welcome_subtitle2': return '100% open, 100% gratuito';
			case 'intro.welcome_footer': return 'Effettuando l\'accesso accetti l\'<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>informativa sulla privacy</a> e i <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Termini di utilizzo</a> dell\'applicazione';
			case 'intro.offline_descr_title': return 'CONTO OFFLINE:';
			case 'intro.offline_descr': return 'I tuoi dati saranno conservati solo sul tuo dispositivo e saranno al sicuro finché non disinstallerai l\'app o cambierai telefono. Per prevenire la perdita di dati, si consiglia di effettuare un backup regolarmente dalle impostazioni dell\'app.';
			case 'intro.offline_start': return 'Avvia sessione offline';
			case 'intro.sl1_title': return 'Seleziona la tua valuta';
			case 'intro.sl1_descr': return 'La tua valuta predefinita sarà utilizzata nei rapporti e nei grafici generali. Potrai cambiare la valuta e la lingua dell\'app in qualsiasi momento nelle impostazioni dell\'applicazione';
			case 'intro.sl2_title': return 'Sicura, privata e affidabile';
			case 'intro.sl2_descr': return 'I tuoi dati sono solo tuoi. Conserviamo le informazioni direttamente sul tuo dispositivo, senza passare per server esterni. Questo rende possibile usare l\'app anche senza internet';
			case 'intro.sl2_descr2': return 'Inoltre, il codice sorgente dell\'applicazione è pubblico, chiunque può collaborare e vedere come funziona';
			case 'intro.last_slide_title': return 'Tutto pronto';
			case 'intro.last_slide_descr': return 'Con Monekin, puoi finalmente raggiungere l\'indipendenza finanziaria che tanto desideri. Avrai grafici, budget, consigli, statistiche e molto altro sul tuo denaro.';
			case 'intro.last_slide_descr2': return 'Speriamo che la tua esperienza ti piaccia! Non esitare a contattarci in caso di dubbi, suggerimenti...';
			case 'home.title': return 'Dashboard';
			case 'home.filter_transactions': return 'Filtra transazioni';
			case 'home.hello_day': return 'Buongiorno,';
			case 'home.hello_night': return 'Buonasera,';
			case 'home.total_balance': return 'Saldo totale';
			case 'home.my_accounts': return 'I miei conti';
			case 'home.active_accounts': return 'Conti attivi';
			case 'home.no_accounts': return 'Nessun conto creato ancora';
			case 'home.no_accounts_descr': return 'Inizia a usare tutta la magia di Monekin. Crea almeno un conto per iniziare ad aggiungere transazioni';
			case 'home.last_transactions': return 'Ultime transazioni';
			case 'home.should_create_account_header': return 'Oops!';
			case 'home.should_create_account_message': return 'Devi avere almeno un conto non archiviato prima di poter iniziare a creare transazioni';
			case 'financial_health.display': return 'Salute finanziaria';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Ottima!';
					case GenderContext.female:
						return 'Ottima!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Buona';
					case GenderContext.female:
						return 'Buona';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Media';
					case GenderContext.female:
						return 'Media';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Discreta';
					case GenderContext.female:
						return 'Discreta';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Molto Cattiva';
					case GenderContext.female:
						return 'Molto Cattiva';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Dati insufficienti';
					case GenderContext.female:
						return 'Dati insufficienti';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'Sembra che non abbiamo abbastanza spese per calcolare la tua salute finanziaria. Aggiungi alcune spese/entrate in questo periodo per permetterci di aiutarti!';
			case 'financial_health.review.descr.very_good': return 'Congratulazioni! La tua salute finanziaria è eccezionale. Speriamo che continui la tua buona serie e continui a imparare con Monekin';
			case 'financial_health.review.descr.good': return 'Ottimo! La tua salute finanziaria è buona. Visita la scheda di analisi per vedere come risparmiare ancora di più!';
			case 'financial_health.review.descr.normal': return 'La tua salute finanziaria è più o meno nella media del resto della popolazione per questo periodo';
			case 'financial_health.review.descr.bad': return 'Sembra che la tua situazione finanziaria non sia ancora delle migliori. Esplora il resto dei grafici per saperne di più sulle tue finanze';
			case 'financial_health.review.descr.very_bad': return 'Mmm, la tua salute finanziaria è ben al di sotto di quanto dovrebbe essere. Esplora il resto dei grafici per saperne di più sulle tue finanze';
			case 'financial_health.months_without_income.title': return 'Tasso di sopravvivenza';
			case 'financial_health.months_without_income.subtitle': return 'Dato il tuo saldo, il tempo che potresti resistere senza entrate';
			case 'financial_health.months_without_income.text_zero': return 'Non potresti sopravvivere un mese senza entrate a questo tasso di spese!';
			case 'financial_health.months_without_income.text_one': return 'Potresti a malapena sopravvivere circa un mese senza entrate a questo tasso di spese!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'Potresti sopravvivere circa <b>${n} mesi</b> senza entrate a questo tasso di spesa.';
			case 'financial_health.months_without_income.text_infinite': return 'Potresti sopravvivere circa <b>tutta la vita</b> senza entrate a questo tasso di spesa.';
			case 'financial_health.months_without_income.suggestion': return 'Ricorda che è consigliabile mantenere questo rapporto al di sopra dei 5 mesi almeno. Se vedi che non hai un cuscinetto di risparmio sufficiente, riduci le spese non necessarie.';
			case 'financial_health.months_without_income.insufficient_data': return 'Sembra che non abbiamo abbastanza spese per calcolare quanti mesi potresti sopravvivere senza entrate. Inserisci alcune transazioni e torna qui per controllare la tua salute finanziaria';
			case 'financial_health.savings_percentage.title': return 'Percentuale di risparmio';
			case 'financial_health.savings_percentage.subtitle': return 'Quale parte del tuo reddito non viene spesa in questo periodo';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Congratulazioni! Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Sembra che tu sia già un esperto, continua così!';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Congratulazioni, sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo.';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Tuttavia, pensiamo che tu possa fare ancora molto di più!';
			case 'financial_health.savings_percentage.text.very_bad': return 'Wow, non sei riuscito a risparmiare nulla durante questo periodo.';
			case 'financial_health.savings_percentage.suggestion': return 'Ricorda che è consigliabile risparmiare almeno il 15-20% di ciò che guadagni.';
			case 'stats.title': return 'Statistiche';
			case 'stats.balance': return 'Saldo';
			case 'stats.final_balance': return 'Saldo finale';
			case 'stats.balance_by_account': return 'Saldo per conto';
			case 'stats.balance_by_account_subtitle': return 'Dove ho la maggior parte dei miei soldi?';
			case 'stats.balance_by_currency': return 'Saldo per valuta';
			case 'stats.balance_by_currency_subtitle': return 'Quanti soldi ho in valuta estera?';
			case 'stats.balance_evolution': return 'Andamento del saldo';
			case 'stats.balance_evolution_subtitle': return 'Ho più soldi di prima?';
			case 'stats.compared_to_previous_period': return 'Rispetto al periodo precedente';
			case 'stats.cash_flow': return 'Flusso di cassa';
			case 'stats.cash_flow_subtitle': return 'Sto spendendo meno di quanto guadagno?';
			case 'stats.by_periods': return 'Per periodi';
			case 'stats.by_categories': return 'Per categorie';
			case 'stats.by_tags': return 'Per etichette';
			case 'stats.distribution': return 'Distribuzione';
			case 'stats.finance_health_resume': return 'Riepilogo';
			case 'stats.finance_health_breakdown': return 'Ripartizione';
			case 'icon_selector.name': return 'Nome:';
			case 'icon_selector.icon': return 'Icona';
			case 'icon_selector.color': return 'Colore';
			case 'icon_selector.select_icon': return 'Seleziona un\'icona';
			case 'icon_selector.select_color': return 'Seleziona un colore';
			case 'icon_selector.custom_color': return 'Colore personalizzato';
			case 'icon_selector.current_color_selection': return 'Selezione attuale';
			case 'icon_selector.select_account_icon': return 'Identifica il tuo conto';
			case 'icon_selector.select_category_icon': return 'Identifica la tua categoria';
			case 'icon_selector.scopes.transport': return 'Trasporto';
			case 'icon_selector.scopes.money': return 'Denaro';
			case 'icon_selector.scopes.food': return 'Cibo';
			case 'icon_selector.scopes.medical': return 'Salute';
			case 'icon_selector.scopes.entertainment': return 'Tempo libero';
			case 'icon_selector.scopes.technology': return 'Tecnologia';
			case 'icon_selector.scopes.other': return 'Altro';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Istituzioni finanziarie';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Transazione',
				other: 'Transazioni',
			);
			case 'transaction.create': return 'Nuova transazione';
			case 'transaction.new_income': return 'Nuova entrata';
			case 'transaction.new_expense': return 'Nuova spesa';
			case 'transaction.new_success': return 'Transazione creata con successo';
			case 'transaction.edit': return 'Modifica transazione';
			case 'transaction.edit_success': return 'Transazione modificata con successo';
			case 'transaction.edit_multiple': return 'Modifica transazioni';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} transazioni modificate con successo';
			case 'transaction.duplicate': return 'Clona transazione';
			case 'transaction.duplicate_short': return 'Clona';
			case 'transaction.duplicate_warning_message': return 'Verrà creata una transazione identica a questa con la stessa data, vuoi continuare?';
			case 'transaction.duplicate_success': return 'Transazione clonata con successo';
			case 'transaction.delete': return 'Elimina transazione';
			case 'transaction.delete_warning_message': return 'Questa azione è irreversibile. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate';
			case 'transaction.delete_success': return 'Transazione eliminata correttamente';
			case 'transaction.delete_multiple': return 'Elimina transazioni';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'Questa azione è irreversibile ed eliminerà ${x} transazioni. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} transazioni eliminate correttamente';
			case 'transaction.details': return 'Dettagli movimento';
			case 'transaction.next_payments.accept': return 'Accetta';
			case 'transaction.next_payments.skip': return 'Salta';
			case 'transaction.next_payments.skip_success': return 'Transazione saltata con successo';
			case 'transaction.next_payments.skip_dialog_title': return 'Salta transazione';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'Questa azione è irreversibile. Sposteremo la data del prossimo movimento al ${date}';
			case 'transaction.next_payments.accept_today': return 'Accetta oggi';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Accetta alla data richiesta (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'Accetta transazione';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'Il nuovo stato della transazione sarà nullo. Potrai ri-modificare lo stato di questa transazione quando vuoi';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'Questa azione creerà una nuova transazione con data ${date}. Potrai controllare i dettagli di questa transazione sulla pagina delle transazioni';
			case 'transaction.next_payments.recurrent_rule_finished': return 'La regola ricorrente è stata completata, non ci sono più pagamenti da effettuare!';
			case 'transaction.list.empty': return 'Nessuna transazione trovata da mostrare qui. Aggiungi alcune transazioni nell\'app e magari sarai più fortunato la prossima volta.';
			case 'transaction.list.searcher_placeholder': return 'Cerca per categoria, descrizione...';
			case 'transaction.list.searcher_no_results': return 'Nessuna transazione trovata corrispondente ai criteri di ricerca';
			case 'transaction.list.loading': return 'Caricamento di altre transazioni...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: '${n} selezionato',
				other: '${n} selezionati',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: '${n} transazione selezionata',
				other: '${n} transazioni selezionate',
			);
			case 'transaction.list.bulk_edit.dates': return 'Modifica date';
			case 'transaction.list.bulk_edit.categories': return 'Modifica categorie';
			case 'transaction.list.bulk_edit.status': return 'Modifica stati';
			case 'transaction.filters.from_value': return 'Da importo';
			case 'transaction.filters.to_value': return 'Fino a importo';
			case 'transaction.filters.from_value_def': return ({required Object x}) => 'Da ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => 'Fino a ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => 'Dalla data ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => 'Fino alla data ${date}';
			case 'transaction.form.validators.zero': return 'Il valore di una transazione non può essere uguale a zero';
			case 'transaction.form.validators.date_max': return 'La data selezionata è successiva a quella attuale. La transazione verrà aggiunta come in sospeso';
			case 'transaction.form.validators.date_after_account_creation': return 'Non puoi creare una transazione la cui data sia precedente alla data di creazione del conto a cui appartiene';
			case 'transaction.form.validators.negative_transfer': return 'Il valore monetario di un trasferimento non può essere negativo';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'Il conto di origine e quello di destinazione non possono essere gli stessi';
			case 'transaction.form.title': return 'Titolo transazione';
			case 'transaction.form.title_short': return 'Titolo';
			case 'transaction.form.value': return 'Valore della transazione';
			case 'transaction.form.tap_to_see_more': return 'Tocca per vedere più dettagli';
			case 'transaction.form.no_tags': return '-- Nessuna etichetta --';
			case 'transaction.form.description': return 'Descrizione';
			case 'transaction.form.description_info': return 'Tocca qui per inserire una descrizione più dettagliata su questa transazione';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => 'Tasso di cambio per ${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return 'Alla data della transazione';
			case 'transaction.reversed.title': return 'Transazione inversa';
			case 'transaction.reversed.title_short': return 'Trans. inversa';
			case 'transaction.reversed.description_for_expenses': return 'Nonostante sia una transazione di spesa, ha un importo positivo. Questi tipi di transazioni possono essere utilizzati per rappresentare la restituzione di una spesa precedentemente registrata, come un rimborso o il pagamento di un debito.';
			case 'transaction.reversed.description_for_incomes': return 'Nonostante sia una transazione di entrata, ha un importo negativo. Questi tipi di transazioni possono essere utilizzati per annullare o correggere un\'entrata registrata in modo errato, per riflettere una restituzione o un rimborso di denaro o per registrare il pagamento di debiti.';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Stato',
				other: 'Stati',
			);
			case 'transaction.status.display_long': return 'Stato transazione';
			case 'transaction.status.tr_status': return ({required Object status}) => 'Transazione ${status}';
			case 'transaction.status.none': return 'Senza stato';
			case 'transaction.status.none_descr': return 'Transazione senza uno stato specifico';
			case 'transaction.status.reconciled': return 'Riconciliata';
			case 'transaction.status.reconciled_descr': return 'Questa transazione è già stata convalidata e corrisponde a una transazione reale della tua banca';
			case 'transaction.status.unreconciled': return 'Non riconciliata';
			case 'transaction.status.unreconciled_descr': return 'Questa transazione non è ancora stata convalidata e pertanto non appare ancora nei tuoi conti bancari reali. Tuttavia, conta per il calcolo dei saldi e delle statistiche in Monekin';
			case 'transaction.status.pending': return 'In sospeso';
			case 'transaction.status.pending_descr': return 'Questa transazione è in sospeso e pertanto non verrà presa in considerazione nel calcolo dei saldi e delle statistiche';
			case 'transaction.status.voided': return 'Annullata';
			case 'transaction.status.voided_descr': return 'Transazione annullata/cancellata a causa di errore di pagamento o qualsiasi altra ragione. Non verrà presa in considerazione nel calcolo dei saldi e delle statistiche';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Tipo di transazione',
				other: 'Tipi di transazione',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Entrata',
				other: 'Entrate',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Spesa',
				other: 'Spese',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Trasferimento',
				other: 'Trasferimenti',
			);
			case 'transfer.display': return 'Trasferimento';
			case 'transfer.transfers': return 'Trasferimenti';
			case 'transfer.transfer_to': return ({required Object account}) => 'Trasferimento a ${account}';
			case 'transfer.create': return 'Nuovo Trasferimento';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return 'Sono necessari almeno due conti per eseguire questa azione. Se devi regolare o modificare il saldo attuale di questo conto, clicca sul pulsante modifica';
			case 'transfer.form.from': return 'Conto di origine';
			case 'transfer.form.to': return 'Conto di destinazione';
			case 'transfer.form.value_in_destiny.title': return 'Importo trasferito a destinazione';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} al conto di destinazione';
			case 'recurrent_transactions.title': return 'Transazioni ricorrenti';
			case 'recurrent_transactions.title_short': return 'Trans. ric.';
			case 'recurrent_transactions.empty': return 'Sembra che tu non abbia transazioni ricorrenti. Crea una transazione ricorrente mensile, annuale o settimanale e apparirà qui';
			case 'recurrent_transactions.total_expense_title': return 'Spesa totale per periodo';
			case 'recurrent_transactions.total_expense_descr': return '* Senza considerare la data di inizio e fine di ciascuna ricorrenza';
			case 'recurrent_transactions.details.title': return 'Transazione ricorrente';
			case 'recurrent_transactions.details.descr': return 'I prossimi movimenti per questa transazione sono mostrati di seguito. Puoi accettare il primo movimento o saltarlo';
			case 'recurrent_transactions.details.last_payment_info': return 'Questo movimento è l\'ultimo della regola ricorrente, quindi questa regola verrà automaticamente eliminata confermando questa azione';
			case 'recurrent_transactions.details.delete_header': return 'Elimina transazione ricorrente';
			case 'recurrent_transactions.details.delete_message': return 'Questa azione è irreversibile e non influenzerà le transazioni che hai già confermato/pagato';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => 'Ritardato di ${x}g';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => 'Tra ${x} giorni';
			case 'account.details': return 'Dettagli conto';
			case 'account.date': return 'Data di apertura';
			case 'account.close_date': return 'Data di chiusura';
			case 'account.reopen': return 'Riapri conto';
			case 'account.reopen_short': return 'Riapri';
			case 'account.reopen_descr': return 'Sei sicuro di voler riaprire questo conto?';
			case 'account.balance': return 'Saldo del conto';
			case 'account.n_transactions': return 'Numero di transazioni';
			case 'account.add_money': return 'Aggiungi denaro';
			case 'account.withdraw_money': return 'Preleva denaro';
			case 'account.no_accounts': return 'Nessuna transazione trovata da mostrare qui. Aggiungi una transazione cliccando sul pulsante \'+\' in basso';
			case 'account.types.title': return 'Tipo di conto';
			case 'account.types.warning': return 'Una volta scelto il tipo di conto, non potrà essere modificato in futuro';
			case 'account.types.normal': return 'Conto normale';
			case 'account.types.normal_descr': return 'Utile per registrare le tue finanze quotidiane. È il conto più comune, ti permette di aggiungere spese, entrate...';
			case 'account.types.saving': return 'Conto risparmio';
			case 'account.types.saving_descr': return 'Potrai solo aggiungere e prelevare denaro da esso da altri conti. Perfetto per iniziare a risparmiare denaro';
			case 'account.form.name': return 'Nome conto';
			case 'account.form.name_placeholder': return 'Es: Conto risparmio';
			case 'account.form.notes': return 'Note';
			case 'account.form.notes_placeholder': return 'Digita alcune note/descrizione su questo conto';
			case 'account.form.initial_balance': return 'Saldo iniziale';
			case 'account.form.current_balance': return 'Saldo attuale';
			case 'account.form.create': return 'Crea conto';
			case 'account.form.edit': return 'Modifica conto';
			case 'account.form.currency_not_found_warn': return 'Non hai informazioni sui tassi di cambio per questa valuta. Verrà utilizzato 1.0 come tasso di cambio predefinito. Puoi modificarlo nelle impostazioni';
			case 'account.form.already_exists': return 'Ne esiste già un altro con lo stesso nome, per favore scrivine un altro';
			case 'account.form.tr_before_opening_date': return 'Ci sono transazioni in questo conto con una data precedente alla data di apertura';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return 'Eliminare conto?';
			case 'account.delete.warning_text': return 'Questa azione eliminerà questo conto e tutte le sue transazioni';
			case 'account.delete.success': return 'Conto eliminato con successo';
			case 'account.close.title': return 'Chiudi conto';
			case 'account.close.title_short': return 'Chiudi';
			case 'account.close.warn': return 'Questo conto non apparirà più in determinati elenchi e non potrai creare transazioni in esso con una data successiva a quella specificata di seguito. Questa azione non influisce su transazioni o saldo, e puoi anche riaprire questo conto in qualsiasi momento.';
			case 'account.close.should_have_zero_balance': return 'Devi avere un saldo attuale di 0 in questo conto per chiuderlo. Per favore modifica il conto prima di continuare';
			case 'account.close.should_have_no_transactions': return 'Questo conto ha transazioni dopo la data di chiusura specificata. Eliminale o modifica la data di chiusura del conto prima di continuare';
			case 'account.close.success': return 'Conto chiuso con successo';
			case 'account.close.unarchive_succes': return 'Conto riaperto con successo';
			case 'account.select.one': return 'Seleziona un conto';
			case 'account.select.all': return 'Tutti i conti';
			case 'account.select.multiple': return 'Seleziona conti';
			case 'currencies.currency_converter': return 'Convertitore di valuta';
			case 'currencies.currency': return 'Valuta';
			case 'currencies.currency_manager': return 'Gestore valute';
			case 'currencies.currency_manager_descr': return 'Configura la tua valuta e i suoi tassi di cambio con altre';
			case 'currencies.preferred_currency': return 'Valuta preferita/base';
			case 'currencies.change_preferred_currency_title': return 'Cambia valuta preferita';
			case 'currencies.change_preferred_currency_msg': return 'Tutte le statistiche e i budget saranno visualizzati in questa valuta d\'ora in poi. Conti e transazioni manterranno la valuta che avevano. Tutti i tassi di cambio salvati verranno eliminati se esegui questa azione. Desideri continuare?';
			case 'currencies.form.equal_to_preferred_warn': return 'La valuta non può essere uguale alla valuta dell\'utente';
			case 'currencies.form.specify_a_currency': return 'Per favore specifica una valuta';
			case 'currencies.form.add': return 'Aggiungi tasso di cambio';
			case 'currencies.form.add_success': return 'Tasso di cambio aggiunto con successo';
			case 'currencies.form.edit': return 'Modifica tasso di cambio';
			case 'currencies.form.edit_success': return 'Tasso di cambio modificato con successo';
			case 'currencies.delete_all_success': return 'Tassi di cambio eliminati con successo';
			case 'currencies.historical': return 'Tassi storici';
			case 'currencies.exchange_rate': return 'Tasso di cambio';
			case 'currencies.exchange_rates': return 'Tassi di cambio';
			case 'currencies.empty': return 'Aggiungi tassi di cambio qui in modo che se hai conti in valute diverse dalla tua valuta base i nostri grafici siano più accurati';
			case 'currencies.select_a_currency': return 'Seleziona una valuta';
			case 'currencies.search': return 'Cerca per nome o per codice valuta';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Etichetta',
				other: 'Etichette',
			);
			case 'tags.form.name': return 'Nome etichetta';
			case 'tags.form.description': return 'Descrizione';
			case 'tags.select.title': return 'Seleziona etichette';
			case 'tags.select.all': return 'Tutte le etichette';
			case 'tags.empty_list': return 'Non hai ancora creato alcuna etichetta. Etichette e categorie sono un ottimo modo per categorizzare i tuoi movimenti';
			case 'tags.without_tags': return 'Senza etichette';
			case 'tags.add': return 'Aggiungi etichetta';
			case 'tags.create': return 'Crea etichetta';
			case 'tags.create_success': return 'Etichetta creata con successo';
			case 'tags.already_exists': return 'Questo nome di etichetta esiste già. Potresti volerla modificare';
			case 'tags.edit': return 'Modifica etichetta';
			case 'tags.edit_success': return 'Etichetta modificata con successo';
			case 'tags.delete_success': return 'Categoria eliminata con successo';
			case 'tags.delete_warning_header': return 'Eliminare etichetta?';
			case 'tags.delete_warning_message': return 'Questa azione non eliminerà le transazioni che hanno questa etichetta.';
			case 'categories.unknown': return 'Categoria sconosciuta';
			case 'categories.create': return 'Crea categoria';
			case 'categories.create_success': return 'Categoria creata correttamente';
			case 'categories.new_category': return 'Nuova categoria';
			case 'categories.already_exists': return 'Il nome di questa categoria esiste già. Magari vuoi modificarla';
			case 'categories.edit': return 'Modifica categoria';
			case 'categories.edit_success': return 'Categoria modificata correttamente';
			case 'categories.name': return 'Nome categoria';
			case 'categories.type': return 'Tipo di categoria';
			case 'categories.both_types': return 'Entrambi i tipi';
			case 'categories.subcategories': return 'Sottocategorie';
			case 'categories.subcategories_add': return 'Aggiungi sottocategoria';
			case 'categories.make_parent': return 'Rendi categoria';
			case 'categories.make_child': return 'Rendi una sottocategoria';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'Questa categoria e le sue sottocategorie diventeranno sottocategorie di <b>${destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'Le loro transazioni <b>(${x})</b> saranno spostate nelle nuove sottocategorie create all\'interno della categoria <b>${destiny}</b>.';
			case 'categories.make_child_success': return 'Sottocategorie create con successo';
			case 'categories.merge': return 'Unisci con un\'altra categoria';
			case 'categories.merge_warning1': return ({required Object x, required Object from, required Object destiny}) => 'Tutte le transazioni (${x}) associate alla categoria <b>${from}</b> verranno spostate nella categoria <b>${destiny}</b>';
			case 'categories.merge_warning2': return ({required Object from}) => 'La categoria <b>${from}</b> verrà eliminata irreversibilmente.';
			case 'categories.merge_success': return 'Categoria unita con successo';
			case 'categories.delete_success': return 'Categoria eliminata correttamente';
			case 'categories.delete_warning_header': return 'Eliminare categoria?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'Questa azione eliminerà irreversibilmente tutte le transazioni <b>(${x})</b> relative a questa categoria.';
			case 'categories.select.title': return 'Seleziona categorie';
			case 'categories.select.select_one': return 'Seleziona una categoria';
			case 'categories.select.select_subcategory': return 'Scegli una sottocategoria';
			case 'categories.select.without_subcategory': return 'Senza sottocategoria';
			case 'categories.select.all': return 'Tutte le categorie';
			case 'categories.select.all_short': return 'Tutte';
			case 'budgets.title': return 'Budget';
			case 'budgets.repeated': return 'Ricorrente';
			case 'budgets.one_time': return 'Una tantum';
			case 'budgets.annual': return 'Annuali';
			case 'budgets.week': return 'Settimanali';
			case 'budgets.month': return 'Mensili';
			case 'budgets.actives': return 'Attivi';
			case 'budgets.pending': return 'In attesa di inizio';
			case 'budgets.finish': return 'Terminati';
			case 'budgets.from_budgeted': return 'rimanenti di ';
			case 'budgets.days_left': return 'giorni rimasti';
			case 'budgets.days_to_start': return 'giorni all\'inizio';
			case 'budgets.since_expiration': return 'giorni dalla scadenza';
			case 'budgets.no_budgets': return 'Sembra che non ci siano budget da visualizzare in questa sezione. Inizia creando un budget cliccando sul pulsante in basso';
			case 'budgets.delete': return 'Elimina budget';
			case 'budgets.delete_warning': return 'Questa azione è irreversibile. Categorie e transazioni relative a questa quotazione non verranno eliminate';
			case 'budgets.form.title': return 'Aggiungi un budget';
			case 'budgets.form.name': return 'Nome budget';
			case 'budgets.form.value': return 'Quantità limite';
			case 'budgets.form.create': return 'Aggiungi budget';
			case 'budgets.form.edit': return 'Modifica budget';
			case 'budgets.form.negative_warn': return 'I budget non possono avere un importo negativo';
			case 'budgets.details.title': return 'Dettagli budget';
			case 'budgets.details.statistics': return 'Statistiche';
			case 'budgets.details.budget_value': return 'A budget';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => 'Puoi spendere ${dailyAmount}/giorno per ${remainingDays} giorni rimanenti';
			case 'budgets.details.expend_evolution': return 'Evoluzione della spesa';
			case 'budgets.details.no_transactions': return 'Sembra che tu non abbia effettuato spese relative a questo budget';
			case 'backup.export.title': return 'Esporta i tuoi dati';
			case 'backup.export.title_short': return 'Esporta';
			case 'backup.export.all': return 'Backup completo';
			case 'backup.export.all_descr': return 'Esporta tutti i tuoi dati (conti, transazioni, budget, impostazioni...). Importali di nuovo in qualsiasi momento per non perdere nulla.';
			case 'backup.export.transactions': return 'Backup transazioni';
			case 'backup.export.transactions_descr': return 'Esporta le tue transazioni in CSV in modo da poterle analizzare più facilmente in altri programmi o applicazioni.';
			case 'backup.export.description': return 'Scarica i tuoi dati in diversi formati';
			case 'backup.export.dialog_title': return 'Salva/Invia file';
			case 'backup.export.success': return ({required Object x}) => 'File salvato/scaricato con successo in ${x}';
			case 'backup.export.error': return 'Errore durante il download del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
			case 'backup.import.title': return 'Importa i tuoi dati';
			case 'backup.import.title_short': return 'Importa';
			case 'backup.import.restore_backup': return 'Ripristina backup';
			case 'backup.import.restore_backup_descr': return 'Importa un database precedentemente salvato da Monekin. Questa azione sostituirà tutti i dati attuali dell\'applicazione con i nuovi dati';
			case 'backup.import.restore_backup_warn_description': return 'Importando un nuovo database, perderai tutti i dati attualmente salvati nell\'app. Si consiglia di effettuare un backup prima di continuare. Non caricare qui alcun file la cui origine non conosci, carica solo file che hai precedentemente scaricato da Monekin';
			case 'backup.import.restore_backup_warn_title': return 'Sovrascrivi tutti i dati';
			case 'backup.import.select_other_file': return 'Seleziona un altro file';
			case 'backup.import.tap_to_select_file': return 'Tocca per selezionare un file';
			case 'backup.import.manual_import.title': return 'Importazione manuale';
			case 'backup.import.manual_import.descr': return 'Importa manualmente le transazioni da un file .csv';
			case 'backup.import.manual_import.default_account': return 'Conto predefinito';
			case 'backup.import.manual_import.remove_default_account': return 'Rimuovi conto predefinito';
			case 'backup.import.manual_import.default_category': return 'Categoria predefinita';
			case 'backup.import.manual_import.select_a_column': return 'Seleziona una colonna dal .csv';
			case 'backup.import.manual_import.steps.0': return 'Seleziona il tuo file';
			case 'backup.import.manual_import.steps.1': return 'Colonna per la quantità';
			case 'backup.import.manual_import.steps.2': return 'Colonna per il conto';
			case 'backup.import.manual_import.steps.3': return 'Colonna per la categoria';
			case 'backup.import.manual_import.steps.4': return 'Colonna per la data';
			case 'backup.import.manual_import.steps.5': return 'altre colonne';
			case 'backup.import.manual_import.steps_descr.0': return 'Seleziona un file .csv dal tuo dispositivo. Assicurati che abbia una prima riga che descriva il nome di ciascuna colonna';
			case 'backup.import.manual_import.steps_descr.1': return 'Seleziona la colonna in cui è specificato il valore di ogni transazione. Usa valori negativi per le spese e valori positivi per le entrate. Usa un punto come separatore decimale';
			case 'backup.import.manual_import.steps_descr.2': return 'Seleziona la colonna in cui è specificato il conto a cui appartiene ogni transazione. Puoi anche selezionare un conto predefinito nel caso in cui non riusciamo a trovare il conto che desideri. Se non viene specificato un conto predefinito, ne creeremo uno con lo stesso nome';
			case 'backup.import.manual_import.steps_descr.3': return 'Specifica la colonna in cui si trova il nome della categoria della transazione. Devi specificare una categoria predefinita in modo da assegnare questa categoria alle transazioni, nel caso in cui la categoria non possa essere trovata';
			case 'backup.import.manual_import.steps_descr.4': return 'Seleziona la colonna in cui è specificata la data di ogni transazione. Se non specificato, le transazioni verranno create con la data attuale';
			case 'backup.import.manual_import.steps_descr.5': return 'Specifica le colonne per altri attributi opzionali della transazione';
			case 'backup.import.manual_import.success': return ({required Object x}) => '${x} transazioni importate con successo';
			case 'backup.import.success': return 'Importazione eseguita con successo';
			case 'backup.import.cancelled': return 'Importazione annullata dall\'utente';
			case 'backup.import.error': return 'Errore durante l\'importazione del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
			case 'backup.about.title': return 'Informazioni sul tuo database';
			case 'backup.about.create_date': return 'Data di creazione';
			case 'backup.about.modify_date': return 'Ultima modifica';
			case 'backup.about.last_backup': return 'Ultimo backup';
			case 'backup.about.size': return 'Dimensione';
			case 'settings.title_long': return 'Impostazioni e aspetto';
			case 'settings.title_short': return 'Impostazioni';
			case 'settings.description': return 'Tema dell\'app, testi e altre impostazioni generali';
			case 'settings.edit_profile': return 'Modifica profilo';
			case 'settings.lang_section': return 'Lingua e testi';
			case 'settings.lang_title': return 'Lingua dell\'app';
			case 'settings.lang_descr': return 'Lingua in cui i testi verranno visualizzati nell\'app';
			case 'settings.lang_help': return 'Se vuoi collaborare con le traduzioni di questa app, puoi consultare <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>la nostra guida</a>';
			case 'settings.locale': return 'Regione';
			case 'settings.locale_auto': return 'Sistema';
			case 'settings.locale_descr': return 'Imposta il formato da utilizzare per date, numeri...';
			case 'settings.locale_warn': return 'Quando cambi regione l\'app si aggiornerà';
			case 'settings.first_day_of_week': return 'Primo giorno della settimana';
			case 'settings.theme_and_colors': return 'Tema e colori';
			case 'settings.theme': return 'Tema';
			case 'settings.theme_auto': return 'Sistema';
			case 'settings.theme_light': return 'Chiaro';
			case 'settings.theme_dark': return 'Scuro';
			case 'settings.amoled_mode': return 'Modalità AMOLED';
			case 'settings.amoled_mode_descr': return 'Usa uno sfondo nero puro quando possibile. Questo aiuterà leggermente la batteria dei dispositivi con schermi AMOLED';
			case 'settings.dynamic_colors': return 'Colori dinamici';
			case 'settings.dynamic_colors_descr': return 'Usa il colore di accento del tuo sistema quando possibile';
			case 'settings.accent_color': return 'Colore di accento';
			case 'settings.accent_color_descr': return 'Scegli il colore che l\'app utilizzerà per enfatizzare determinate parti dell\'interfaccia';
			case 'settings.swipe_actions.title': return 'Azioni di scorrimento';
			case 'settings.swipe_actions.choose_description': return 'Scegli quale azione verrà attivata quando fai scorrere un elemento di transazione nell\'elenco utilizzando questa direzione di scorrimento';
			case 'settings.swipe_actions.swipe_left': return 'Scorri verso sinistra';
			case 'settings.swipe_actions.swipe_right': return 'Scorri verso destra';
			case 'settings.swipe_actions.none': return 'Nessuna azione';
			case 'settings.swipe_actions.toggle_reconciled': return 'Attiva/disattiva riconciliato';
			case 'settings.swipe_actions.toggle_pending': return 'Attiva/disattiva in sospeso';
			case 'settings.swipe_actions.toggle_voided': return 'Attivazione/disattivazione annullata';
			case 'settings.swipe_actions.toggle_unreconciled': return 'Attiva/disattiva non riconciliato';
			case 'settings.swipe_actions.remove_status': return 'Rimuovi lo stato';
			case 'settings.security.title': return 'Sicurezza';
			case 'settings.security.private_mode_at_launch': return 'Modalità privata all\'avvio';
			case 'settings.security.private_mode_at_launch_descr': return 'Avvia l\'app in modalità privata per impostazione predefinita';
			case 'settings.security.private_mode': return 'Modalità privata';
			case 'settings.security.private_mode_descr': return 'Nascondi tutti i valori monetari';
			case 'settings.security.private_mode_activated': return 'Modalità privata attivata';
			case 'settings.security.private_mode_deactivated': return 'Modalità privata disattivata';
			case 'more.title': return 'Altro';
			case 'more.title_long': return 'Altre azioni';
			case 'more.data.display': return 'Dati';
			case 'more.data.display_descr': return 'Esporta e importa i tuoi dati per non perdere nulla';
			case 'more.data.delete_all': return 'Elimina i miei dati';
			case 'more.data.delete_all_header1': return 'Fermati subito padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return 'Sei sicuro di voler continuare? Tutti i tuoi dati verranno eliminati in modo permanente e non potranno essere recuperati';
			case 'more.data.delete_all_header2': return 'Un ultimo passo ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'Eliminando un account eliminerai tutti i tuoi dati personali memorizzati. I tuoi conti, transazioni, budget e categorie verranno eliminati e non potranno essere recuperati. Sei d\'accordo?';
			case 'more.about_us.display': return 'Informazioni sull\'app';
			case 'more.about_us.description': return 'Consulta i termini e altre informazioni rilevanti su Monekin. Entra in contatto con la comunità segnalando bug, lasciando suggerimenti...';
			case 'more.about_us.legal.display': return 'Informazioni legali';
			case 'more.about_us.legal.privacy': return 'Informativa sulla privacy';
			case 'more.about_us.legal.terms': return 'Termini di utilizzo';
			case 'more.about_us.legal.licenses': return 'Licenze';
			case 'more.about_us.project.display': return 'Progetto';
			case 'more.about_us.project.contributors': return 'Collaboratori';
			case 'more.about_us.project.contributors_descr': return 'Tutti gli sviluppatori che hanno fatto crescere Monekin';
			case 'more.about_us.project.contact': return 'Contattaci';
			case 'more.help_us.display': return 'Aiutaci';
			case 'more.help_us.description': return 'Scopri come puoi aiutare Monekin a migliorare sempre di più';
			case 'more.help_us.rate_us': return 'Valutaci';
			case 'more.help_us.rate_us_descr': return 'Ogni valutazione è benvenuta!';
			case 'more.help_us.share': return 'Condividi Monekin';
			case 'more.help_us.share_descr': return 'Condividi la nostra app con amici e famiglia';
			case 'more.help_us.share_text': return 'Monekin! La migliore app di finanza personale. Scaricala qui';
			case 'more.help_us.thanks': return 'Grazie!';
			case 'more.help_us.thanks_long': return 'I tuoi contributi a Monekin e ad altri progetti open source, grandi e piccoli, rendono possibili grandi progetti come questo. Grazie per aver dedicato tempo a contribuire.';
			case 'more.help_us.donate': return 'Fai una donazione';
			case 'more.help_us.donate_descr': return 'Con la tua donazione aiuterai l\'app a continuare a ricevere miglioramenti. Quale modo migliore per ringraziare il lavoro svolto se non invitandomi per un caffè?';
			case 'more.help_us.donate_success': return 'Donazione effettuata. Grazie mille per il tuo contributo! ❤️';
			case 'more.help_us.donate_err': return 'Oops! Sembra che ci sia stato un errore nel ricevere il tuo pagamento';
			case 'more.help_us.report': return 'Segnala bug, lascia suggerimenti...';
			default: return null;
		}
	}
}


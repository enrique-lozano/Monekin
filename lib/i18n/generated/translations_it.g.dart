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
	@override late final _TranslationsTargetTimelineStatusesIt target_timeline_statuses = _TranslationsTargetTimelineStatusesIt._(_root);
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
	@override String get details => 'Dettagli';
	@override String get balance => 'Saldo';
	@override String get account => 'Conto';
	@override String get accounts => 'Conti';
	@override String get categories => 'Categorie';
	@override String get category => 'Categoria';
	@override String get today => 'Oggi';
	@override String get yesterday => 'Ieri';
	@override String get filters => 'Filtri';
	@override String get empty_warn => 'Ops! È davvero vuoto';
	@override String get search_no_results => 'Nessun articolo corrisponde ai tuoi criteri di ricerca';
	@override String get insufficient_data => 'Dati insufficienti';
	@override String get show_more_fields => 'Mostra più campi';
	@override String get show_less_fields => 'Mostra meno campi';
	@override String get tap_to_search => 'Tocca per cercare';
	@override late final _TranslationsGeneralLeaveWithoutSavingIt leave_without_saving = _TranslationsGeneralLeaveWithoutSavingIt._(_root);
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
	@override String get currency_settings => 'Impostazioni valuta';
	@override String get currency_manager => 'Gestore valute';
	@override String get currency_manager_descr => 'Configura la tua valuta e i suoi tassi di cambio con altre';
	@override String get preferred_currency => 'Valuta preferita/base';
	@override String get tap_to_change_preferred_currency => 'Tocca per modificare';
	@override String get change_preferred_currency_title => 'Cambia valuta preferita';
	@override String get change_preferred_currency_msg => 'Tutte le statistiche e i budget saranno visualizzati in questa valuta d\'ora in poi. Conti e transazioni manterranno la valuta che avevano. Tutti i tassi di cambio salvati verranno eliminati se esegui questa azione. Desideri continuare?';
	@override late final _TranslationsCurrenciesExchangeRateFormIt exchange_rate_form = _TranslationsCurrenciesExchangeRateFormIt._(_root);
	@override late final _TranslationsCurrenciesTypesIt types = _TranslationsCurrenciesTypesIt._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormIt currency_form = _TranslationsCurrenciesCurrencyFormIt._(_root);
	@override String get delete_all_success => 'Tassi di cambio eliminati con successo';
	@override String get historical => 'Tassi storici';
	@override String get historical_empty => 'Nessun tasso di cambio storico trovato per questa valuta';
	@override String get exchange_rate => 'Tasso di cambio';
	@override String get exchange_rates => 'Tassi di cambio';
	@override String get min_exchange_rate => 'Tasso di cambio minimo';
	@override String get max_exchange_rate => 'Tasso di cambio massimo';
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
	@override late final _TranslationsBudgetsTargetTimelineStatusesIt target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesIt._(_root);
	@override late final _TranslationsBudgetsProgressIt progress = _TranslationsBudgetsProgressIt._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesIt implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get active => 'Attivo';
	@override String get past => 'Passato';
	@override String get future => 'Futuro';
}

// Path: backup
class _TranslationsBackupIt implements TranslationsBackupEn {
	_TranslationsBackupIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => 'Nessun file selezionato';
	@override String get no_directory_selected => 'Nessuna directory selezionata';
	@override late final _TranslationsBackupExportIt export = _TranslationsBackupExportIt._(_root);
	@override late final _TranslationsBackupImportIt import = _TranslationsBackupImportIt._(_root);
	@override late final _TranslationsBackupAboutIt about = _TranslationsBackupAboutIt._(_root);
}

// Path: settings
class _TranslationsSettingsIt implements TranslationsSettingsEn {
	_TranslationsSettingsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Impostazioni e Personalizzazione';
	@override String get title_short => 'Impostazioni';
	@override String get description => 'Tema, Lingua, Dati e altro';
	@override String get edit_profile => 'Modifica profilo';
	@override late final _TranslationsSettingsGeneralIt general = _TranslationsSettingsGeneralIt._(_root);
	@override late final _TranslationsSettingsSecurityIt security = _TranslationsSettingsSecurityIt._(_root);
	@override late final _TranslationsSettingsTransactionsIt transactions = _TranslationsSettingsTransactionsIt._(_root);
	@override late final _TranslationsSettingsAppearanceIt appearance = _TranslationsSettingsAppearanceIt._(_root);
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

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingIt implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Uscire senza salvare?';
	@override String get message => 'Hai modifiche non salvate, sei sicuro di voler uscire senza salvarle?';
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
	@override String get all => 'Tutte le transazioni';
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
	@override String get title => 'Filtri delle transazioni';
	@override String get from_value => 'Da importo';
	@override String get to_value => 'Fino a importo';
	@override String from_value_def({required Object x}) => 'Da ${x}';
	@override String to_value_def({required Object x}) => 'Fino a ${x}';
	@override String from_date_def({required Object date}) => 'Dalla data ${date}';
	@override String to_date_def({required Object date}) => 'Fino alla data ${date}';
	@override String get reset => 'Ripristina filtri';
	@override late final _TranslationsTransactionFiltersSavedIt saved = _TranslationsTransactionFiltersSavedIt._(_root);
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

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormIt implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'La valuta non può essere uguale alla valuta dell\'utente';
	@override String get override_existing_warn => 'Esiste già un tasso di cambio per questa valuta in questa data. Se continui, quello precedente verrà sovrascritto';
	@override String get specify_a_currency => 'Per favore specifica una valuta';
	@override String get add => 'Aggiungi tasso di cambio';
	@override String get add_success => 'Tasso di cambio aggiunto con successo';
	@override String get edit => 'Modifica tasso di cambio';
	@override String get edit_success => 'Tasso di cambio modificato con successo';
	@override String get remove_all => 'Elimina tutti i tassi di cambio';
	@override String get remove_all_warning => 'Questa azione è irreversibile e cancellerà tutti i tassi di cambio per questa valuta';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesIt implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Tipo di valuta';
	@override String get fiat => 'FIAT';
	@override String get crypto => 'Criptovaluta';
	@override String get other => 'Altro';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormIt implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome da visualizzare';
	@override String get code => 'Codice valuta';
	@override String get symbol => 'Simbolo';
	@override String get decimal_digits => 'Cifre decimali';
	@override String get create => 'Crea valuta';
	@override String get create_success => 'Valuta creata con successo';
	@override String get edit => 'Modifica valuta';
	@override String get edit_success => 'Valuta modificata correttamente';
	@override String get delete => 'Elimina valuta';
	@override String get delete_success => 'Valuta eliminata correttamente';
	@override String get already_exists => 'Esiste già una valuta con questo codice. Potresti volerlo modificare';
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
	@override String get create_success => 'Budget creato correttamente';
	@override String get edit => 'Modifica budget';
	@override String get edit_success => 'Budget modificato correttamente';
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
	@override String get expend_evolution => 'Evoluzione della spesa';
	@override String get no_transactions => 'Sembra che tu non abbia effettuato spese relative a questo budget';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesIt implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get active => 'Budget attivo';
	@override String get past => 'Budget passato';
	@override String get future => 'Budget futuro';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressIt implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsIt labels = _TranslationsBudgetsProgressLabelsIt._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionIt description = _TranslationsBudgetsProgressDescriptionIt._(_root);
}

// Path: backup.export
class _TranslationsBackupExportIt implements TranslationsBackupExportEn {
	_TranslationsBackupExportIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Esporta i tuoi dati';
	@override String get title_short => 'Esporta';
	@override String get type_of_export => 'Tipo di esportazione';
	@override String get other_options => 'Opzioni';
	@override String get all => 'Backup completo';
	@override String get all_descr => 'Esporta tutti i tuoi dati (conti, transazioni, budget, impostazioni...). Importali di nuovo in qualsiasi momento per non perdere nulla.';
	@override String get transactions => 'Backup transazioni';
	@override String get transactions_descr => 'Esporta le tue transazioni in CSV in modo da poterle analizzare più facilmente in altri programmi o applicazioni.';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '1 transazione da esportare',
		other: '${n} transazioni da esportare',
	);
	@override String get description => 'Scarica i tuoi dati in diversi formati';
	@override String get send_file => 'Invia file';
	@override String get see_folder => 'Vedi cartella';
	@override String success({required Object x}) => 'File salvato/scaricato con successo in ${x}';
	@override String get error => 'Errore durante il download del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
	@override String get dialog_title => 'Salva/Invia file';
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
	@override String get error => 'Errore durante l\'importazione del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
	@override String get cancelled => 'Importazione annullata dall\'utente';
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

// Path: settings.general
class _TranslationsSettingsGeneralIt implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Impostazioni generali';
	@override String get menu_descr => 'Lingua, privacy e altro';
	@override late final _TranslationsSettingsGeneralLanguageIt language = _TranslationsSettingsGeneralLanguageIt._(_root);
	@override late final _TranslationsSettingsGeneralLocaleIt locale = _TranslationsSettingsGeneralLocaleIt._(_root);
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

// Path: settings.transactions
class _TranslationsSettingsTransactionsIt implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Transazioni';
	@override String get menu_descr => 'Configura il comportamento delle tue transazioni';
	@override String get title => 'Impostazioni transazioni';
	@override late final _TranslationsSettingsTransactionsSwipeActionsIt swipe_actions = _TranslationsSettingsTransactionsSwipeActionsIt._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesIt default_values = _TranslationsSettingsTransactionsDefaultValuesIt._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeIt default_type = _TranslationsSettingsTransactionsDefaultTypeIt._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceIt implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Tema e stile';
	@override String get menu_descr => 'Selezione del tema, colori e altre cose relative all\'aspetto dell\'app';
	@override String get theme_and_colors => 'Tema e colori';
	@override late final _TranslationsSettingsAppearanceThemeIt theme = _TranslationsSettingsAppearanceThemeIt._(_root);
	@override String get amoled_mode => 'Modalità AMOLED';
	@override String get amoled_mode_descr => 'Usa uno sfondo nero puro quando possibile. Questo aiuterà leggermente la batteria dei dispositivi con schermi AMOLED';
	@override String get dynamic_colors => 'Colori dinamici';
	@override String get dynamic_colors_descr => 'Usa il colore di accento del tuo sistema quando possibile';
	@override String get accent_color => 'Colore di accento';
	@override String get accent_color_descr => 'Scegli il colore che l\'app utilizzerà per enfatizzare determinate parti dell\'interfaccia';
	@override String get text => 'Testo';
	@override String get font => 'Font';
	@override String get font_platform => 'Piattaforma';
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
	@override String get description => 'Trova i termini di Monekin, informazioni importanti e connettiti segnalando bug o condividendo idee';
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

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedIt implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtri salvati';
	@override String get new_title => 'Nuovo filtro';
	@override String get edit_title => 'Modifica filtro';
	@override String get name_label => 'Nome del filtro';
	@override String get name_hint => 'Il mio filtro personalizzato';
	@override String get save_dialog_title => 'Salva filtro';
	@override String get save_tooltip => 'Salva filtro corrente';
	@override String get load_tooltip => 'Carica filtro salvato';
	@override String get empty_title => 'Nessun filtro salvato trovato';
	@override String get empty_description => 'Salva i filtri qui per accedervi rapidamente in seguito.';
	@override String get save_success => 'Filtro salvato con successo';
	@override String get delete_success => 'Filtro eliminato con successo';
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

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsIt implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'In linea';
	@override String get active_overspending => 'Spesa eccessiva';
	@override String get success => 'Raggiunto';
	@override String get fail => 'Budget superato';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionIt implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Puoi spendere ${dailyAmount} al giorno per i restanti ${remainingDays} giorni';
	@override String active_overspending({required Object dailyAmount, required Object remainingDays}) => 'Per tornare in linea, dovresti limitare la tua spesa a ${dailyAmount} al giorno per i restanti ${remainingDays} giorni';
	@override String active_exceeded({required Object amount}) => 'Hai già superato il limite del budget di ${amount}. Se non trovi entrate per questo budget, dovresti smettere di spendere per il resto del periodo';
	@override String get success => 'Ottimo lavoro! Questo budget è terminato con successo. Continua a creare budget per gestire le tue spese';
	@override String fail({required Object amount}) => 'Hai superato il budget di ${amount}. Cerca di fare più attenzione la prossima volta!';
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

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageIt implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get section => 'Lingua e testi';
	@override String get title => 'Lingua dell\'app';
	@override String get descr => 'Lingua in cui i testi verranno visualizzati nell\'app';
	@override String get help => 'Se vuoi collaborare con le traduzioni di questa app, puoi consultare <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>la nostra guida</a>';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleIt implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Regione';
	@override String get auto => 'Sistema';
	@override String get descr => 'Imposta il formato da utilizzare per date, numeri...';
	@override String get warn => 'Quando cambi regione l\'app si aggiornerà';
	@override String get first_day_of_week => 'Primo giorno della settimana';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsIt implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsIt._(this._root);

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

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesIt implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

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
class _TranslationsSettingsTransactionsDefaultTypeIt implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Type';
	@override String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeIt implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tema';
	@override String get auto => 'Sistema';
	@override String get light => 'Chiaro';
	@override String get dark => 'Scuro';
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

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = 'Annulla';
		map['ui_actions.confirm'] = 'Conferma';
		map['ui_actions.continue_text'] = 'Continua';
		map['ui_actions.save'] = 'Salva';
		map['ui_actions.save_changes'] = 'Salva modifiche';
		map['ui_actions.close_and_save'] = 'Salva e chiudi';
		map['ui_actions.add'] = 'Aggiungi';
		map['ui_actions.edit'] = 'Modifica';
		map['ui_actions.delete'] = 'Elimina';
		map['ui_actions.see_more'] = 'Vedi altro';
		map['ui_actions.select_all'] = 'Seleziona tutto';
		map['ui_actions.deselect_all'] = 'Deseleziona tutto';
		map['ui_actions.select'] = 'Seleziona';
		map['ui_actions.search'] = 'Cerca';
		map['ui_actions.filter'] = 'Filtra';
		map['ui_actions.reset'] = 'Ripristina';
		map['ui_actions.submit'] = 'Invia';
		map['ui_actions.next'] = 'Avanti';
		map['ui_actions.previous'] = 'Precedente';
		map['ui_actions.back'] = 'Indietro';
		map['ui_actions.reload'] = 'Ricarica';
		map['ui_actions.view'] = 'Visualizza';
		map['ui_actions.download'] = 'Scarica';
		map['ui_actions.upload'] = 'Carica';
		map['ui_actions.retry'] = 'Riprova';
		map['ui_actions.copy'] = 'Copia';
		map['ui_actions.paste'] = 'Incolla';
		map['ui_actions.undo'] = 'Annulla';
		map['ui_actions.redo'] = 'Ripristina';
		map['ui_actions.open'] = 'Apri';
		map['ui_actions.close'] = 'Chiudi';
		map['ui_actions.apply'] = 'Applica';
		map['ui_actions.discard'] = 'Ignora';
		map['ui_actions.refresh'] = 'Aggiorna';
		map['ui_actions.share'] = 'Condividi';
		map['general.or'] = 'o';
		map['general.understood'] = 'Capito';
		map['general.unspecified'] = 'Non specificato';
		map['general.quick_actions'] = 'Azioni rapide';
		map['general.details'] = 'Dettagli';
		map['general.balance'] = 'Saldo';
		map['general.account'] = 'Conto';
		map['general.accounts'] = 'Conti';
		map['general.categories'] = 'Categorie';
		map['general.category'] = 'Categoria';
		map['general.today'] = 'Oggi';
		map['general.yesterday'] = 'Ieri';
		map['general.filters'] = 'Filtri';
		map['general.empty_warn'] = 'Ops! È davvero vuoto';
		map['general.search_no_results'] = 'Nessun articolo corrisponde ai tuoi criteri di ricerca';
		map['general.insufficient_data'] = 'Dati insufficienti';
		map['general.show_more_fields'] = 'Mostra più campi';
		map['general.show_less_fields'] = 'Mostra meno campi';
		map['general.tap_to_search'] = 'Tocca per cercare';
		map['general.leave_without_saving.title'] = 'Uscire senza salvare?';
		map['general.leave_without_saving.message'] = 'Hai modifiche non salvate, sei sicuro di voler uscire senza salvarle?';
		map['general.clipboard.success'] = ({required Object x}) => '${x} copiato negli appunti';
		map['general.clipboard.error'] = 'Errore di copia';
		map['general.time.start_date'] = 'Data di inizio';
		map['general.time.end_date'] = 'Data di fine';
		map['general.time.from_date'] = 'Dalla data';
		map['general.time.until_date'] = 'Fino alla data';
		map['general.time.date'] = 'Data';
		map['general.time.datetime'] = 'Data e ora';
		map['general.time.time'] = 'Ora';
		map['general.time.each'] = 'Ogni';
		map['general.time.after'] = 'Dopo';
		map['general.time.ranges.display'] = 'Intervallo di tempo';
		map['general.time.ranges.it_repeat'] = 'Si ripete';
		map['general.time.ranges.it_ends'] = 'Termina';
		map['general.time.ranges.forever'] = 'Sempre';
		map['general.time.ranges.types.cycle'] = 'Cicli';
		map['general.time.ranges.types.last_days'] = 'Ultimi giorni';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '${x} giorni precedenti';
		map['general.time.ranges.types.all'] = 'Sempre';
		map['general.time.ranges.types.date_range'] = 'Intervallo personalizzato';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range}',
				other: 'Ogni ${n} ${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range} fino al ${day}',
				other: 'Ogni ${n} ${range} fino al ${day}',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range} ${limit} volte',
				other: 'Ogni ${n} ${range} ${limit} volte',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ogni ${range} una volta',
				other: 'Ogni ${n} ${range} una volta',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Mese',
				other: 'Mesi',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Anno',
				other: 'Anni',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Giorno',
				other: 'Giorni',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Settimana',
				other: 'Settimane',
			);
		map['general.time.periodicity.display'] = 'Ricorrenza';
		map['general.time.periodicity.no_repeat'] = 'Non si ripete';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Ripetizione',
				other: 'Ripetizioni',
			);
		map['general.time.periodicity.diary'] = 'Giornaliera';
		map['general.time.periodicity.monthly'] = 'Mensile';
		map['general.time.periodicity.annually'] = 'Annuale';
		map['general.time.periodicity.quaterly'] = 'Trimestrale';
		map['general.time.periodicity.weekly'] = 'Settimanale';
		map['general.time.periodicity.custom'] = 'Personalizzata';
		map['general.time.periodicity.infinite'] = 'Sempre';
		map['general.time.current.monthly'] = 'Questo mese';
		map['general.time.current.annually'] = 'Quest\'anno';
		map['general.time.current.quaterly'] = 'Questo trimestre';
		map['general.time.current.weekly'] = 'Questa settimana';
		map['general.time.current.infinite'] = 'Per sempre';
		map['general.time.current.custom'] = 'Intervallo personalizzato';
		map['general.time.all.diary'] = 'Ogni giorno';
		map['general.time.all.monthly'] = 'Ogni mese';
		map['general.time.all.annually'] = 'Ogni anno';
		map['general.time.all.quaterly'] = 'Ogni trimestre';
		map['general.time.all.weekly'] = 'Ogni settimana';
		map['general.transaction_order.display'] = 'Ordina transazioni';
		map['general.transaction_order.category'] = 'Per categoria';
		map['general.transaction_order.quantity'] = 'Per quantità';
		map['general.transaction_order.date'] = 'Per data';
		map['general.validations.form_error'] = 'Correggi i campi indicati per continuare';
		map['general.validations.required'] = 'Campo obbligatorio';
		map['general.validations.positive'] = 'Deve essere positivo';
		map['general.validations.min_number'] = ({required Object x}) => 'Deve essere maggiore di ${x}';
		map['general.validations.max_number'] = ({required Object x}) => 'Deve essere minore di ${x}';
		map['intro.start'] = 'Inizia';
		map['intro.skip'] = 'Salta';
		map['intro.next'] = 'Avanti';
		map['intro.select_your_currency'] = 'Seleziona la tua valuta';
		map['intro.welcome_subtitle'] = 'Il tuo gestore di finanze personali';
		map['intro.welcome_subtitle2'] = '100% open, 100% gratuito';
		map['intro.welcome_footer'] = 'Effettuando l\'accesso accetti l\'<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>informativa sulla privacy</a> e i <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Termini di utilizzo</a> dell\'applicazione';
		map['intro.offline_descr_title'] = 'CONTO OFFLINE:';
		map['intro.offline_descr'] = 'I tuoi dati saranno conservati solo sul tuo dispositivo e saranno al sicuro finché non disinstallerai l\'app o cambierai telefono. Per prevenire la perdita di dati, si consiglia di effettuare un backup regolarmente dalle impostazioni dell\'app.';
		map['intro.offline_start'] = 'Avvia sessione offline';
		map['intro.sl1_title'] = 'Seleziona la tua valuta';
		map['intro.sl1_descr'] = 'La tua valuta predefinita sarà utilizzata nei rapporti e nei grafici generali. Potrai cambiare la valuta e la lingua dell\'app in qualsiasi momento nelle impostazioni dell\'applicazione';
		map['intro.sl2_title'] = 'Sicura, privata e affidabile';
		map['intro.sl2_descr'] = 'I tuoi dati sono solo tuoi. Conserviamo le informazioni direttamente sul tuo dispositivo, senza passare per server esterni. Questo rende possibile usare l\'app anche senza internet';
		map['intro.sl2_descr2'] = 'Inoltre, il codice sorgente dell\'applicazione è pubblico, chiunque può collaborare e vedere come funziona';
		map['intro.last_slide_title'] = 'Tutto pronto';
		map['intro.last_slide_descr'] = 'Con Monekin, puoi finalmente raggiungere l\'indipendenza finanziaria che tanto desideri. Avrai grafici, budget, consigli, statistiche e molto altro sul tuo denaro.';
		map['intro.last_slide_descr2'] = 'Speriamo che la tua esperienza ti piaccia! Non esitare a contattarci in caso di dubbi, suggerimenti...';
		map['home.title'] = 'Dashboard';
		map['home.filter_transactions'] = 'Filtra transazioni';
		map['home.hello_day'] = 'Buongiorno,';
		map['home.hello_night'] = 'Buonasera,';
		map['home.total_balance'] = 'Saldo totale';
		map['home.my_accounts'] = 'I miei conti';
		map['home.active_accounts'] = 'Conti attivi';
		map['home.no_accounts'] = 'Nessun conto creato ancora';
		map['home.no_accounts_descr'] = 'Inizia a usare tutta la magia di Monekin. Crea almeno un conto per iniziare ad aggiungere transazioni';
		map['home.last_transactions'] = 'Ultime transazioni';
		map['home.should_create_account_header'] = 'Oops!';
		map['home.should_create_account_message'] = 'Devi avere almeno un conto non archiviato prima di poter iniziare a creare transazioni';
		map['financial_health.display'] = 'Salute finanziaria';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Ottima!';
					case GenderContext.female:
						return 'Ottima!';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Buona';
					case GenderContext.female:
						return 'Buona';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Media';
					case GenderContext.female:
						return 'Media';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Discreta';
					case GenderContext.female:
						return 'Discreta';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Molto Cattiva';
					case GenderContext.female:
						return 'Molto Cattiva';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Dati insufficienti';
					case GenderContext.female:
						return 'Dati insufficienti';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = 'Sembra che non abbiamo abbastanza spese per calcolare la tua salute finanziaria. Aggiungi alcune spese/entrate in questo periodo per permetterci di aiutarti!';
		map['financial_health.review.descr.very_good'] = 'Congratulazioni! La tua salute finanziaria è eccezionale. Speriamo che continui la tua buona serie e continui a imparare con Monekin';
		map['financial_health.review.descr.good'] = 'Ottimo! La tua salute finanziaria è buona. Visita la scheda di analisi per vedere come risparmiare ancora di più!';
		map['financial_health.review.descr.normal'] = 'La tua salute finanziaria è più o meno nella media del resto della popolazione per questo periodo';
		map['financial_health.review.descr.bad'] = 'Sembra che la tua situazione finanziaria non sia ancora delle migliori. Esplora il resto dei grafici per saperne di più sulle tue finanze';
		map['financial_health.review.descr.very_bad'] = 'Mmm, la tua salute finanziaria è ben al di sotto di quanto dovrebbe essere. Esplora il resto dei grafici per saperne di più sulle tue finanze';
		map['financial_health.months_without_income.title'] = 'Tasso di sopravvivenza';
		map['financial_health.months_without_income.subtitle'] = 'Dato il tuo saldo, il tempo che potresti resistere senza entrate';
		map['financial_health.months_without_income.text_zero'] = 'Non potresti sopravvivere un mese senza entrate a questo tasso di spese!';
		map['financial_health.months_without_income.text_one'] = 'Potresti a malapena sopravvivere circa un mese senza entrate a questo tasso di spese!';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => 'Potresti sopravvivere circa <b>${n} mesi</b> senza entrate a questo tasso di spesa.';
		map['financial_health.months_without_income.text_infinite'] = 'Potresti sopravvivere circa <b>tutta la vita</b> senza entrate a questo tasso di spesa.';
		map['financial_health.months_without_income.suggestion'] = 'Ricorda che è consigliabile mantenere questo rapporto al di sopra dei 5 mesi almeno. Se vedi che non hai un cuscinetto di risparmio sufficiente, riduci le spese non necessarie.';
		map['financial_health.months_without_income.insufficient_data'] = 'Sembra che non abbiamo abbastanza spese per calcolare quanti mesi potresti sopravvivere senza entrate. Inserisci alcune transazioni e torna qui per controllare la tua salute finanziaria';
		map['financial_health.savings_percentage.title'] = 'Percentuale di risparmio';
		map['financial_health.savings_percentage.subtitle'] = 'Quale parte del tuo reddito non viene spesa in questo periodo';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => 'Congratulazioni! Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Sembra che tu sia già un esperto, continua così!';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => 'Congratulazioni, sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo.';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => 'Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Tuttavia, pensiamo che tu possa fare ancora molto di più!';
		map['financial_health.savings_percentage.text.very_bad'] = 'Wow, non sei riuscito a risparmiare nulla durante questo periodo.';
		map['financial_health.savings_percentage.suggestion'] = 'Ricorda che è consigliabile risparmiare almeno il 15-20% di ciò che guadagni.';
		map['stats.title'] = 'Statistiche';
		map['stats.balance'] = 'Saldo';
		map['stats.final_balance'] = 'Saldo finale';
		map['stats.balance_by_account'] = 'Saldo per conto';
		map['stats.balance_by_account_subtitle'] = 'Dove ho la maggior parte dei miei soldi?';
		map['stats.balance_by_currency'] = 'Saldo per valuta';
		map['stats.balance_by_currency_subtitle'] = 'Quanti soldi ho in valuta estera?';
		map['stats.balance_evolution'] = 'Andamento del saldo';
		map['stats.balance_evolution_subtitle'] = 'Ho più soldi di prima?';
		map['stats.compared_to_previous_period'] = 'Rispetto al periodo precedente';
		map['stats.cash_flow'] = 'Flusso di cassa';
		map['stats.cash_flow_subtitle'] = 'Sto spendendo meno di quanto guadagno?';
		map['stats.by_periods'] = 'Per periodi';
		map['stats.by_categories'] = 'Per categorie';
		map['stats.by_tags'] = 'Per etichette';
		map['stats.distribution'] = 'Distribuzione';
		map['stats.finance_health_resume'] = 'Riepilogo';
		map['stats.finance_health_breakdown'] = 'Ripartizione';
		map['icon_selector.name'] = 'Nome:';
		map['icon_selector.icon'] = 'Icona';
		map['icon_selector.color'] = 'Colore';
		map['icon_selector.select_icon'] = 'Seleziona un\'icona';
		map['icon_selector.select_color'] = 'Seleziona un colore';
		map['icon_selector.custom_color'] = 'Colore personalizzato';
		map['icon_selector.current_color_selection'] = 'Selezione attuale';
		map['icon_selector.select_account_icon'] = 'Identifica il tuo conto';
		map['icon_selector.select_category_icon'] = 'Identifica la tua categoria';
		map['icon_selector.scopes.transport'] = 'Trasporto';
		map['icon_selector.scopes.money'] = 'Denaro';
		map['icon_selector.scopes.food'] = 'Cibo';
		map['icon_selector.scopes.medical'] = 'Salute';
		map['icon_selector.scopes.entertainment'] = 'Tempo libero';
		map['icon_selector.scopes.technology'] = 'Tecnologia';
		map['icon_selector.scopes.other'] = 'Altro';
		map['icon_selector.scopes.logos_financial_institutions'] = 'Istituzioni finanziarie';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Transazione',
				other: 'Transazioni',
			);
		map['transaction.create'] = 'Nuova transazione';
		map['transaction.new_income'] = 'Nuova entrata';
		map['transaction.new_expense'] = 'Nuova spesa';
		map['transaction.new_success'] = 'Transazione creata con successo';
		map['transaction.edit'] = 'Modifica transazione';
		map['transaction.edit_success'] = 'Transazione modificata con successo';
		map['transaction.edit_multiple'] = 'Modifica transazioni';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x} transazioni modificate con successo';
		map['transaction.duplicate'] = 'Clona transazione';
		map['transaction.duplicate_short'] = 'Clona';
		map['transaction.duplicate_warning_message'] = 'Verrà creata una transazione identica a questa con la stessa data, vuoi continuare?';
		map['transaction.duplicate_success'] = 'Transazione clonata con successo';
		map['transaction.delete'] = 'Elimina transazione';
		map['transaction.delete_warning_message'] = 'Questa azione è irreversibile. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate';
		map['transaction.delete_success'] = 'Transazione eliminata correttamente';
		map['transaction.delete_multiple'] = 'Elimina transazioni';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => 'Questa azione è irreversibile ed eliminerà ${x} transazioni. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x} transazioni eliminate correttamente';
		map['transaction.details'] = 'Dettagli movimento';
		map['transaction.next_payments.accept'] = 'Accetta';
		map['transaction.next_payments.skip'] = 'Salta';
		map['transaction.next_payments.skip_success'] = 'Transazione saltata con successo';
		map['transaction.next_payments.skip_dialog_title'] = 'Salta transazione';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => 'Questa azione è irreversibile. Sposteremo la data del prossimo movimento al ${date}';
		map['transaction.next_payments.accept_today'] = 'Accetta oggi';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => 'Accetta alla data richiesta (${date})';
		map['transaction.next_payments.accept_dialog_title'] = 'Accetta transazione';
		map['transaction.next_payments.accept_dialog_msg_single'] = 'Il nuovo stato della transazione sarà nullo. Potrai ri-modificare lo stato di questa transazione quando vuoi';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => 'Questa azione creerà una nuova transazione con data ${date}. Potrai controllare i dettagli di questa transazione sulla pagina delle transazioni';
		map['transaction.next_payments.recurrent_rule_finished'] = 'La regola ricorrente è stata completata, non ci sono più pagamenti da effettuare!';
		map['transaction.list.all'] = 'Tutte le transazioni';
		map['transaction.list.empty'] = 'Nessuna transazione trovata da mostrare qui. Aggiungi alcune transazioni nell\'app e magari sarai più fortunato la prossima volta.';
		map['transaction.list.searcher_placeholder'] = 'Cerca per categoria, descrizione...';
		map['transaction.list.searcher_no_results'] = 'Nessuna transazione trovata corrispondente ai criteri di ricerca';
		map['transaction.list.loading'] = 'Caricamento di altre transazioni...';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: '${n} selezionato',
				other: '${n} selezionati',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: '${n} transazione selezionata',
				other: '${n} transazioni selezionate',
			);
		map['transaction.list.bulk_edit.dates'] = 'Modifica date';
		map['transaction.list.bulk_edit.categories'] = 'Modifica categorie';
		map['transaction.list.bulk_edit.status'] = 'Modifica stati';
		map['transaction.filters.title'] = 'Filtri delle transazioni';
		map['transaction.filters.from_value'] = 'Da importo';
		map['transaction.filters.to_value'] = 'Fino a importo';
		map['transaction.filters.from_value_def'] = ({required Object x}) => 'Da ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => 'Fino a ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => 'Dalla data ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => 'Fino alla data ${date}';
		map['transaction.filters.reset'] = 'Ripristina filtri';
		map['transaction.filters.saved.title'] = 'Filtri salvati';
		map['transaction.filters.saved.new_title'] = 'Nuovo filtro';
		map['transaction.filters.saved.edit_title'] = 'Modifica filtro';
		map['transaction.filters.saved.name_label'] = 'Nome del filtro';
		map['transaction.filters.saved.name_hint'] = 'Il mio filtro personalizzato';
		map['transaction.filters.saved.save_dialog_title'] = 'Salva filtro';
		map['transaction.filters.saved.save_tooltip'] = 'Salva filtro corrente';
		map['transaction.filters.saved.load_tooltip'] = 'Carica filtro salvato';
		map['transaction.filters.saved.empty_title'] = 'Nessun filtro salvato trovato';
		map['transaction.filters.saved.empty_description'] = 'Salva i filtri qui per accedervi rapidamente in seguito.';
		map['transaction.filters.saved.save_success'] = 'Filtro salvato con successo';
		map['transaction.filters.saved.delete_success'] = 'Filtro eliminato con successo';
		map['transaction.form.validators.zero'] = 'Il valore di una transazione non può essere uguale a zero';
		map['transaction.form.validators.date_max'] = 'La data selezionata è successiva a quella attuale. La transazione verrà aggiunta come in sospeso';
		map['transaction.form.validators.date_after_account_creation'] = 'Non puoi creare una transazione la cui data sia precedente alla data di creazione del conto a cui appartiene';
		map['transaction.form.validators.negative_transfer'] = 'Il valore monetario di un trasferimento non può essere negativo';
		map['transaction.form.validators.transfer_between_same_accounts'] = 'Il conto di origine e quello di destinazione non possono essere gli stessi';
		map['transaction.form.title'] = 'Titolo transazione';
		map['transaction.form.title_short'] = 'Titolo';
		map['transaction.form.value'] = 'Valore della transazione';
		map['transaction.form.tap_to_see_more'] = 'Tocca per vedere più dettagli';
		map['transaction.form.no_tags'] = '-- Nessuna etichetta --';
		map['transaction.form.description'] = 'Descrizione';
		map['transaction.form.description_info'] = 'Tocca qui per inserire una descrizione più dettagliata su questa transazione';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => 'Tasso di cambio per ${currency}';
		map['transaction.form.exchange_to_preferred_in_date'] = 'Alla data della transazione';
		map['transaction.reversed.title'] = 'Transazione inversa';
		map['transaction.reversed.title_short'] = 'Trans. inversa';
		map['transaction.reversed.description_for_expenses'] = 'Nonostante sia una transazione di spesa, ha un importo positivo. Questi tipi di transazioni possono essere utilizzati per rappresentare la restituzione di una spesa precedentemente registrata, come un rimborso o il pagamento di un debito.';
		map['transaction.reversed.description_for_incomes'] = 'Nonostante sia una transazione di entrata, ha un importo negativo. Questi tipi di transazioni possono essere utilizzati per annullare o correggere un\'entrata registrata in modo errato, per riflettere una restituzione o un rimborso di denaro o per registrare il pagamento di debiti.';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Stato',
				other: 'Stati',
			);
		map['transaction.status.display_long'] = 'Stato transazione';
		map['transaction.status.tr_status'] = ({required Object status}) => 'Transazione ${status}';
		map['transaction.status.none'] = 'Senza stato';
		map['transaction.status.none_descr'] = 'Transazione senza uno stato specifico';
		map['transaction.status.reconciled'] = 'Riconciliata';
		map['transaction.status.reconciled_descr'] = 'Questa transazione è già stata convalidata e corrisponde a una transazione reale della tua banca';
		map['transaction.status.unreconciled'] = 'Non riconciliata';
		map['transaction.status.unreconciled_descr'] = 'Questa transazione non è ancora stata convalidata e pertanto non appare ancora nei tuoi conti bancari reali. Tuttavia, conta per il calcolo dei saldi e delle statistiche in Monekin';
		map['transaction.status.pending'] = 'In sospeso';
		map['transaction.status.pending_descr'] = 'Questa transazione è in sospeso e pertanto non verrà presa in considerazione nel calcolo dei saldi e delle statistiche';
		map['transaction.status.voided'] = 'Annullata';
		map['transaction.status.voided_descr'] = 'Transazione annullata/cancellata a causa di errore di pagamento o qualsiasi altra ragione. Non verrà presa in considerazione nel calcolo dei saldi e delle statistiche';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Tipo di transazione',
				other: 'Tipi di transazione',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Entrata',
				other: 'Entrate',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Spesa',
				other: 'Spese',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Trasferimento',
				other: 'Trasferimenti',
			);
		map['transfer.display'] = 'Trasferimento';
		map['transfer.transfers'] = 'Trasferimenti';
		map['transfer.transfer_to'] = ({required Object account}) => 'Trasferimento a ${account}';
		map['transfer.create'] = 'Nuovo Trasferimento';
		map['transfer.need_two_accounts_warning_header'] = 'Ops!';
		map['transfer.need_two_accounts_warning_message'] = 'Sono necessari almeno due conti per eseguire questa azione. Se devi regolare o modificare il saldo attuale di questo conto, clicca sul pulsante modifica';
		map['transfer.form.from'] = 'Conto di origine';
		map['transfer.form.to'] = 'Conto di destinazione';
		map['transfer.form.value_in_destiny.title'] = 'Importo trasferito a destinazione';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} al conto di destinazione';
		map['recurrent_transactions.title'] = 'Transazioni ricorrenti';
		map['recurrent_transactions.title_short'] = 'Trans. ric.';
		map['recurrent_transactions.empty'] = 'Sembra che tu non abbia transazioni ricorrenti. Crea una transazione ricorrente mensile, annuale o settimanale e apparirà qui';
		map['recurrent_transactions.total_expense_title'] = 'Spesa totale per periodo';
		map['recurrent_transactions.total_expense_descr'] = '* Senza considerare la data di inizio e fine di ciascuna ricorrenza';
		map['recurrent_transactions.details.title'] = 'Transazione ricorrente';
		map['recurrent_transactions.details.descr'] = 'I prossimi movimenti per questa transazione sono mostrati di seguito. Puoi accettare il primo movimento o saltarlo';
		map['recurrent_transactions.details.last_payment_info'] = 'Questo movimento è l\'ultimo della regola ricorrente, quindi questa regola verrà automaticamente eliminata confermando questa azione';
		map['recurrent_transactions.details.delete_header'] = 'Elimina transazione ricorrente';
		map['recurrent_transactions.details.delete_message'] = 'Questa azione è irreversibile e non influenzerà le transazioni che hai già confermato/pagato';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => 'Ritardato di ${x}g';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => 'Tra ${x} giorni';
		map['account.details'] = 'Dettagli conto';
		map['account.date'] = 'Data di apertura';
		map['account.close_date'] = 'Data di chiusura';
		map['account.reopen'] = 'Riapri conto';
		map['account.reopen_short'] = 'Riapri';
		map['account.reopen_descr'] = 'Sei sicuro di voler riaprire questo conto?';
		map['account.balance'] = 'Saldo del conto';
		map['account.n_transactions'] = 'Numero di transazioni';
		map['account.add_money'] = 'Aggiungi denaro';
		map['account.withdraw_money'] = 'Preleva denaro';
		map['account.no_accounts'] = 'Nessuna transazione trovata da mostrare qui. Aggiungi una transazione cliccando sul pulsante \'+\' in basso';
		map['account.types.title'] = 'Tipo di conto';
		map['account.types.warning'] = 'Una volta scelto il tipo di conto, non potrà essere modificato in futuro';
		map['account.types.normal'] = 'Conto normale';
		map['account.types.normal_descr'] = 'Utile per registrare le tue finanze quotidiane. È il conto più comune, ti permette di aggiungere spese, entrate...';
		map['account.types.saving'] = 'Conto risparmio';
		map['account.types.saving_descr'] = 'Potrai solo aggiungere e prelevare denaro da esso da altri conti. Perfetto per iniziare a risparmiare denaro';
		map['account.form.name'] = 'Nome conto';
		map['account.form.name_placeholder'] = 'Es: Conto risparmio';
		map['account.form.notes'] = 'Note';
		map['account.form.notes_placeholder'] = 'Digita alcune note/descrizione su questo conto';
		map['account.form.initial_balance'] = 'Saldo iniziale';
		map['account.form.current_balance'] = 'Saldo attuale';
		map['account.form.create'] = 'Crea conto';
		map['account.form.edit'] = 'Modifica conto';
		map['account.form.currency_not_found_warn'] = 'Non hai informazioni sui tassi di cambio per questa valuta. Verrà utilizzato 1.0 come tasso di cambio predefinito. Puoi modificarlo nelle impostazioni';
		map['account.form.already_exists'] = 'Ne esiste già un altro con lo stesso nome, per favore scrivine un altro';
		map['account.form.tr_before_opening_date'] = 'Ci sono transazioni in questo conto con una data precedente alla data di apertura';
		map['account.form.iban'] = 'IBAN';
		map['account.form.swift'] = 'SWIFT';
		map['account.delete.warning_header'] = 'Eliminare conto?';
		map['account.delete.warning_text'] = 'Questa azione eliminerà questo conto e tutte le sue transazioni';
		map['account.delete.success'] = 'Conto eliminato con successo';
		map['account.close.title'] = 'Chiudi conto';
		map['account.close.title_short'] = 'Chiudi';
		map['account.close.warn'] = 'Questo conto non apparirà più in determinati elenchi e non potrai creare transazioni in esso con una data successiva a quella specificata di seguito. Questa azione non influisce su transazioni o saldo, e puoi anche riaprire questo conto in qualsiasi momento.';
		map['account.close.should_have_zero_balance'] = 'Devi avere un saldo attuale di 0 in questo conto per chiuderlo. Per favore modifica il conto prima di continuare';
		map['account.close.should_have_no_transactions'] = 'Questo conto ha transazioni dopo la data di chiusura specificata. Eliminale o modifica la data di chiusura del conto prima di continuare';
		map['account.close.success'] = 'Conto chiuso con successo';
		map['account.close.unarchive_succes'] = 'Conto riaperto con successo';
		map['account.select.one'] = 'Seleziona un conto';
		map['account.select.all'] = 'Tutti i conti';
		map['account.select.multiple'] = 'Seleziona conti';
		map['currencies.currency_converter'] = 'Convertitore di valuta';
		map['currencies.currency'] = 'Valuta';
		map['currencies.currency_settings'] = 'Impostazioni valuta';
		map['currencies.currency_manager'] = 'Gestore valute';
		map['currencies.currency_manager_descr'] = 'Configura la tua valuta e i suoi tassi di cambio con altre';
		map['currencies.preferred_currency'] = 'Valuta preferita/base';
		map['currencies.tap_to_change_preferred_currency'] = 'Tocca per modificare';
		map['currencies.change_preferred_currency_title'] = 'Cambia valuta preferita';
		map['currencies.change_preferred_currency_msg'] = 'Tutte le statistiche e i budget saranno visualizzati in questa valuta d\'ora in poi. Conti e transazioni manterranno la valuta che avevano. Tutti i tassi di cambio salvati verranno eliminati se esegui questa azione. Desideri continuare?';
		map['currencies.exchange_rate_form.equal_to_preferred_warn'] = 'La valuta non può essere uguale alla valuta dell\'utente';
		map['currencies.exchange_rate_form.override_existing_warn'] = 'Esiste già un tasso di cambio per questa valuta in questa data. Se continui, quello precedente verrà sovrascritto';
		map['currencies.exchange_rate_form.specify_a_currency'] = 'Per favore specifica una valuta';
		map['currencies.exchange_rate_form.add'] = 'Aggiungi tasso di cambio';
		map['currencies.exchange_rate_form.add_success'] = 'Tasso di cambio aggiunto con successo';
		map['currencies.exchange_rate_form.edit'] = 'Modifica tasso di cambio';
		map['currencies.exchange_rate_form.edit_success'] = 'Tasso di cambio modificato con successo';
		map['currencies.exchange_rate_form.remove_all'] = 'Elimina tutti i tassi di cambio';
		map['currencies.exchange_rate_form.remove_all_warning'] = 'Questa azione è irreversibile e cancellerà tutti i tassi di cambio per questa valuta';
		map['currencies.types.display'] = 'Tipo di valuta';
		map['currencies.types.fiat'] = 'FIAT';
		map['currencies.types.crypto'] = 'Criptovaluta';
		map['currencies.types.other'] = 'Altro';
		map['currencies.currency_form.name'] = 'Nome da visualizzare';
		map['currencies.currency_form.code'] = 'Codice valuta';
		map['currencies.currency_form.symbol'] = 'Simbolo';
		map['currencies.currency_form.decimal_digits'] = 'Cifre decimali';
		map['currencies.currency_form.create'] = 'Crea valuta';
		map['currencies.currency_form.create_success'] = 'Valuta creata con successo';
		map['currencies.currency_form.edit'] = 'Modifica valuta';
		map['currencies.currency_form.edit_success'] = 'Valuta modificata correttamente';
		map['currencies.currency_form.delete'] = 'Elimina valuta';
		map['currencies.currency_form.delete_success'] = 'Valuta eliminata correttamente';
		map['currencies.currency_form.already_exists'] = 'Esiste già una valuta con questo codice. Potresti volerlo modificare';
		map['currencies.delete_all_success'] = 'Tassi di cambio eliminati con successo';
		map['currencies.historical'] = 'Tassi storici';
		map['currencies.historical_empty'] = 'Nessun tasso di cambio storico trovato per questa valuta';
		map['currencies.exchange_rate'] = 'Tasso di cambio';
		map['currencies.exchange_rates'] = 'Tassi di cambio';
		map['currencies.min_exchange_rate'] = 'Tasso di cambio minimo';
		map['currencies.max_exchange_rate'] = 'Tasso di cambio massimo';
		map['currencies.empty'] = 'Aggiungi tassi di cambio qui in modo che se hai conti in valute diverse dalla tua valuta base i nostri grafici siano più accurati';
		map['currencies.select_a_currency'] = 'Seleziona una valuta';
		map['currencies.search'] = 'Cerca per nome o per codice valuta';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: 'Etichetta',
				other: 'Etichette',
			);
		map['tags.form.name'] = 'Nome etichetta';
		map['tags.form.description'] = 'Descrizione';
		map['tags.select.title'] = 'Seleziona etichette';
		map['tags.select.all'] = 'Tutte le etichette';
		map['tags.empty_list'] = 'Non hai ancora creato alcuna etichetta. Etichette e categorie sono un ottimo modo per categorizzare i tuoi movimenti';
		map['tags.without_tags'] = 'Senza etichette';
		map['tags.add'] = 'Aggiungi etichetta';
		map['tags.create'] = 'Crea etichetta';
		map['tags.create_success'] = 'Etichetta creata con successo';
		map['tags.already_exists'] = 'Questo nome di etichetta esiste già. Potresti volerla modificare';
		map['tags.edit'] = 'Modifica etichetta';
		map['tags.edit_success'] = 'Etichetta modificata con successo';
		map['tags.delete_success'] = 'Categoria eliminata con successo';
		map['tags.delete_warning_header'] = 'Eliminare etichetta?';
		map['tags.delete_warning_message'] = 'Questa azione non eliminerà le transazioni che hanno questa etichetta.';
		map['categories.unknown'] = 'Categoria sconosciuta';
		map['categories.create'] = 'Crea categoria';
		map['categories.create_success'] = 'Categoria creata correttamente';
		map['categories.new_category'] = 'Nuova categoria';
		map['categories.already_exists'] = 'Il nome di questa categoria esiste già. Magari vuoi modificarla';
		map['categories.edit'] = 'Modifica categoria';
		map['categories.edit_success'] = 'Categoria modificata correttamente';
		map['categories.name'] = 'Nome categoria';
		map['categories.type'] = 'Tipo di categoria';
		map['categories.both_types'] = 'Entrambi i tipi';
		map['categories.subcategories'] = 'Sottocategorie';
		map['categories.subcategories_add'] = 'Aggiungi sottocategoria';
		map['categories.make_parent'] = 'Rendi categoria';
		map['categories.make_child'] = 'Rendi una sottocategoria';
		map['categories.make_child_warning1'] = ({required Object destiny}) => 'Questa categoria e le sue sottocategorie diventeranno sottocategorie di <b>${destiny}</b>.';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => 'Le loro transazioni <b>(${x})</b> saranno spostate nelle nuove sottocategorie create all\'interno della categoria <b>${destiny}</b>.';
		map['categories.make_child_success'] = 'Sottocategorie create con successo';
		map['categories.merge'] = 'Unisci con un\'altra categoria';
		map['categories.merge_warning1'] = ({required Object x, required Object from, required Object destiny}) => 'Tutte le transazioni (${x}) associate alla categoria <b>${from}</b> verranno spostate nella categoria <b>${destiny}</b>';
		map['categories.merge_warning2'] = ({required Object from}) => 'La categoria <b>${from}</b> verrà eliminata irreversibilmente.';
		map['categories.merge_success'] = 'Categoria unita con successo';
		map['categories.delete_success'] = 'Categoria eliminata correttamente';
		map['categories.delete_warning_header'] = 'Eliminare categoria?';
		map['categories.delete_warning_message'] = ({required Object x}) => 'Questa azione eliminerà irreversibilmente tutte le transazioni <b>(${x})</b> relative a questa categoria.';
		map['categories.select.title'] = 'Seleziona categorie';
		map['categories.select.select_one'] = 'Seleziona una categoria';
		map['categories.select.select_subcategory'] = 'Scegli una sottocategoria';
		map['categories.select.without_subcategory'] = 'Senza sottocategoria';
		map['categories.select.all'] = 'Tutte le categorie';
		map['categories.select.all_short'] = 'Tutte';
		map['budgets.title'] = 'Budget';
		map['budgets.repeated'] = 'Ricorrente';
		map['budgets.one_time'] = 'Una tantum';
		map['budgets.annual'] = 'Annuali';
		map['budgets.week'] = 'Settimanali';
		map['budgets.month'] = 'Mensili';
		map['budgets.actives'] = 'Attivi';
		map['budgets.pending'] = 'In attesa di inizio';
		map['budgets.finish'] = 'Terminati';
		map['budgets.from_budgeted'] = 'rimanenti di ';
		map['budgets.days_left'] = 'giorni rimasti';
		map['budgets.days_to_start'] = 'giorni all\'inizio';
		map['budgets.since_expiration'] = 'giorni dalla scadenza';
		map['budgets.no_budgets'] = 'Sembra che non ci siano budget da visualizzare in questa sezione. Inizia creando un budget cliccando sul pulsante in basso';
		map['budgets.delete'] = 'Elimina budget';
		map['budgets.delete_warning'] = 'Questa azione è irreversibile. Categorie e transazioni relative a questa quotazione non verranno eliminate';
		map['budgets.form.title'] = 'Aggiungi un budget';
		map['budgets.form.name'] = 'Nome budget';
		map['budgets.form.value'] = 'Quantità limite';
		map['budgets.form.create'] = 'Aggiungi budget';
		map['budgets.form.create_success'] = 'Budget creato correttamente';
		map['budgets.form.edit'] = 'Modifica budget';
		map['budgets.form.edit_success'] = 'Budget modificato correttamente';
		map['budgets.form.negative_warn'] = 'I budget non possono avere un importo negativo';
		map['budgets.details.title'] = 'Dettagli budget';
		map['budgets.details.statistics'] = 'Statistiche';
		map['budgets.details.budget_value'] = 'A budget';
		map['budgets.details.expend_evolution'] = 'Evoluzione della spesa';
		map['budgets.details.no_transactions'] = 'Sembra che tu non abbia effettuato spese relative a questo budget';
		map['budgets.target_timeline_statuses.active'] = 'Budget attivo';
		map['budgets.target_timeline_statuses.past'] = 'Budget passato';
		map['budgets.target_timeline_statuses.future'] = 'Budget futuro';
		map['budgets.progress.labels.active_on_track'] = 'In linea';
		map['budgets.progress.labels.active_overspending'] = 'Spesa eccessiva';
		map['budgets.progress.labels.success'] = 'Raggiunto';
		map['budgets.progress.labels.fail'] = 'Budget superato';
		map['budgets.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'Puoi spendere ${dailyAmount} al giorno per i restanti ${remainingDays} giorni';
		map['budgets.progress.description.active_overspending'] = ({required Object dailyAmount, required Object remainingDays}) => 'Per tornare in linea, dovresti limitare la tua spesa a ${dailyAmount} al giorno per i restanti ${remainingDays} giorni';
		map['budgets.progress.description.active_exceeded'] = ({required Object amount}) => 'Hai già superato il limite del budget di ${amount}. Se non trovi entrate per questo budget, dovresti smettere di spendere per il resto del periodo';
		map['budgets.progress.description.success'] = 'Ottimo lavoro! Questo budget è terminato con successo. Continua a creare budget per gestire le tue spese';
		map['budgets.progress.description.fail'] = ({required Object amount}) => 'Hai superato il budget di ${amount}. Cerca di fare più attenzione la prossima volta!';
		map['target_timeline_statuses.active'] = 'Attivo';
		map['target_timeline_statuses.past'] = 'Passato';
		map['target_timeline_statuses.future'] = 'Futuro';
		map['backup.no_file_selected'] = 'Nessun file selezionato';
		map['backup.no_directory_selected'] = 'Nessuna directory selezionata';
		map['backup.export.title'] = 'Esporta i tuoi dati';
		map['backup.export.title_short'] = 'Esporta';
		map['backup.export.type_of_export'] = 'Tipo di esportazione';
		map['backup.export.other_options'] = 'Opzioni';
		map['backup.export.all'] = 'Backup completo';
		map['backup.export.all_descr'] = 'Esporta tutti i tuoi dati (conti, transazioni, budget, impostazioni...). Importali di nuovo in qualsiasi momento per non perdere nulla.';
		map['backup.export.transactions'] = 'Backup transazioni';
		map['backup.export.transactions_descr'] = 'Esporta le tue transazioni in CSV in modo da poterle analizzare più facilmente in altri programmi o applicazioni.';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
				one: '1 transazione da esportare',
				other: '${n} transazioni da esportare',
			);
		map['backup.export.description'] = 'Scarica i tuoi dati in diversi formati';
		map['backup.export.send_file'] = 'Invia file';
		map['backup.export.see_folder'] = 'Vedi cartella';
		map['backup.export.success'] = ({required Object x}) => 'File salvato/scaricato con successo in ${x}';
		map['backup.export.error'] = 'Errore durante il download del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
		map['backup.export.dialog_title'] = 'Salva/Invia file';
		map['backup.import.title'] = 'Importa i tuoi dati';
		map['backup.import.title_short'] = 'Importa';
		map['backup.import.restore_backup'] = 'Ripristina backup';
		map['backup.import.restore_backup_descr'] = 'Importa un database precedentemente salvato da Monekin. Questa azione sostituirà tutti i dati attuali dell\'applicazione con i nuovi dati';
		map['backup.import.restore_backup_warn_description'] = 'Importando un nuovo database, perderai tutti i dati attualmente salvati nell\'app. Si consiglia di effettuare un backup prima di continuare. Non caricare qui alcun file la cui origine non conosci, carica solo file che hai precedentemente scaricato da Monekin';
		map['backup.import.restore_backup_warn_title'] = 'Sovrascrivi tutti i dati';
		map['backup.import.select_other_file'] = 'Seleziona un altro file';
		map['backup.import.tap_to_select_file'] = 'Tocca per selezionare un file';
		map['backup.import.manual_import.title'] = 'Importazione manuale';
		map['backup.import.manual_import.descr'] = 'Importa manualmente le transazioni da un file .csv';
		map['backup.import.manual_import.default_account'] = 'Conto predefinito';
		map['backup.import.manual_import.remove_default_account'] = 'Rimuovi conto predefinito';
		map['backup.import.manual_import.default_category'] = 'Categoria predefinita';
		map['backup.import.manual_import.select_a_column'] = 'Seleziona una colonna dal .csv';
		map['backup.import.manual_import.steps.0'] = 'Seleziona il tuo file';
		map['backup.import.manual_import.steps.1'] = 'Colonna per la quantità';
		map['backup.import.manual_import.steps.2'] = 'Colonna per il conto';
		map['backup.import.manual_import.steps.3'] = 'Colonna per la categoria';
		map['backup.import.manual_import.steps.4'] = 'Colonna per la data';
		map['backup.import.manual_import.steps.5'] = 'altre colonne';
		map['backup.import.manual_import.steps_descr.0'] = 'Seleziona un file .csv dal tuo dispositivo. Assicurati che abbia una prima riga che descriva il nome di ciascuna colonna';
		map['backup.import.manual_import.steps_descr.1'] = 'Seleziona la colonna in cui è specificato il valore di ogni transazione. Usa valori negativi per le spese e valori positivi per le entrate. Usa un punto come separatore decimale';
		map['backup.import.manual_import.steps_descr.2'] = 'Seleziona la colonna in cui è specificato il conto a cui appartiene ogni transazione. Puoi anche selezionare un conto predefinito nel caso in cui non riusciamo a trovare il conto che desideri. Se non viene specificato un conto predefinito, ne creeremo uno con lo stesso nome';
		map['backup.import.manual_import.steps_descr.3'] = 'Specifica la colonna in cui si trova il nome della categoria della transazione. Devi specificare una categoria predefinita in modo da assegnare questa categoria alle transazioni, nel caso in cui la categoria non possa essere trovata';
		map['backup.import.manual_import.steps_descr.4'] = 'Seleziona la colonna in cui è specificata la data di ogni transazione. Se non specificato, le transazioni verranno create con la data attuale';
		map['backup.import.manual_import.steps_descr.5'] = 'Specifica le colonne per altri attributi opzionali della transazione';
		map['backup.import.manual_import.success'] = ({required Object x}) => '${x} transazioni importate con successo';
		map['backup.import.success'] = 'Importazione eseguita con successo';
		map['backup.import.error'] = 'Errore durante l\'importazione del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com';
		map['backup.import.cancelled'] = 'Importazione annullata dall\'utente';
		map['backup.about.title'] = 'Informazioni sul tuo database';
		map['backup.about.create_date'] = 'Data di creazione';
		map['backup.about.modify_date'] = 'Ultima modifica';
		map['backup.about.last_backup'] = 'Ultimo backup';
		map['backup.about.size'] = 'Dimensione';
		map['settings.title_long'] = 'Impostazioni e Personalizzazione';
		map['settings.title_short'] = 'Impostazioni';
		map['settings.description'] = 'Tema, Lingua, Dati e altro';
		map['settings.edit_profile'] = 'Modifica profilo';
		map['settings.general.menu_title'] = 'Impostazioni generali';
		map['settings.general.menu_descr'] = 'Lingua, privacy e altro';
		map['settings.general.language.section'] = 'Lingua e testi';
		map['settings.general.language.title'] = 'Lingua dell\'app';
		map['settings.general.language.descr'] = 'Lingua in cui i testi verranno visualizzati nell\'app';
		map['settings.general.language.help'] = 'Se vuoi collaborare con le traduzioni di questa app, puoi consultare <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>la nostra guida</a>';
		map['settings.general.locale.title'] = 'Regione';
		map['settings.general.locale.auto'] = 'Sistema';
		map['settings.general.locale.descr'] = 'Imposta il formato da utilizzare per date, numeri...';
		map['settings.general.locale.warn'] = 'Quando cambi regione l\'app si aggiornerà';
		map['settings.general.locale.first_day_of_week'] = 'Primo giorno della settimana';
		map['settings.security.title'] = 'Sicurezza';
		map['settings.security.private_mode_at_launch'] = 'Modalità privata all\'avvio';
		map['settings.security.private_mode_at_launch_descr'] = 'Avvia l\'app in modalità privata per impostazione predefinita';
		map['settings.security.private_mode'] = 'Modalità privata';
		map['settings.security.private_mode_descr'] = 'Nascondi tutti i valori monetari';
		map['settings.security.private_mode_activated'] = 'Modalità privata attivata';
		map['settings.security.private_mode_deactivated'] = 'Modalità privata disattivata';
		map['settings.transactions.menu_title'] = 'Transazioni';
		map['settings.transactions.menu_descr'] = 'Configura il comportamento delle tue transazioni';
		map['settings.transactions.title'] = 'Impostazioni transazioni';
		map['settings.transactions.swipe_actions.title'] = 'Azioni di scorrimento';
		map['settings.transactions.swipe_actions.choose_description'] = 'Scegli quale azione verrà attivata quando fai scorrere un elemento di transazione nell\'elenco utilizzando questa direzione di scorrimento';
		map['settings.transactions.swipe_actions.swipe_left'] = 'Scorri verso sinistra';
		map['settings.transactions.swipe_actions.swipe_right'] = 'Scorri verso destra';
		map['settings.transactions.swipe_actions.none'] = 'Nessuna azione';
		map['settings.transactions.swipe_actions.toggle_reconciled'] = 'Attiva/disattiva riconciliato';
		map['settings.transactions.swipe_actions.toggle_pending'] = 'Attiva/disattiva in sospeso';
		map['settings.transactions.swipe_actions.toggle_voided'] = 'Attivazione/disattivazione annullata';
		map['settings.transactions.swipe_actions.toggle_unreconciled'] = 'Attiva/disattiva non riconciliato';
		map['settings.transactions.swipe_actions.remove_status'] = 'Rimuovi lo stato';
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
		map['settings.appearance.menu_title'] = 'Tema e stile';
		map['settings.appearance.menu_descr'] = 'Selezione del tema, colori e altre cose relative all\'aspetto dell\'app';
		map['settings.appearance.theme_and_colors'] = 'Tema e colori';
		map['settings.appearance.theme.title'] = 'Tema';
		map['settings.appearance.theme.auto'] = 'Sistema';
		map['settings.appearance.theme.light'] = 'Chiaro';
		map['settings.appearance.theme.dark'] = 'Scuro';
		map['settings.appearance.amoled_mode'] = 'Modalità AMOLED';
		map['settings.appearance.amoled_mode_descr'] = 'Usa uno sfondo nero puro quando possibile. Questo aiuterà leggermente la batteria dei dispositivi con schermi AMOLED';
		map['settings.appearance.dynamic_colors'] = 'Colori dinamici';
		map['settings.appearance.dynamic_colors_descr'] = 'Usa il colore di accento del tuo sistema quando possibile';
		map['settings.appearance.accent_color'] = 'Colore di accento';
		map['settings.appearance.accent_color_descr'] = 'Scegli il colore che l\'app utilizzerà per enfatizzare determinate parti dell\'interfaccia';
		map['settings.appearance.text'] = 'Testo';
		map['settings.appearance.font'] = 'Font';
		map['settings.appearance.font_platform'] = 'Piattaforma';
		map['more.title'] = 'Altro';
		map['more.title_long'] = 'Altre azioni';
		map['more.data.display'] = 'Dati';
		map['more.data.display_descr'] = 'Esporta e importa i tuoi dati per non perdere nulla';
		map['more.data.delete_all'] = 'Elimina i miei dati';
		map['more.data.delete_all_header1'] = 'Fermati subito padawan ⚠️⚠️';
		map['more.data.delete_all_message1'] = 'Sei sicuro di voler continuare? Tutti i tuoi dati verranno eliminati in modo permanente e non potranno essere recuperati';
		map['more.data.delete_all_header2'] = 'Un ultimo passo ⚠️⚠️';
		map['more.data.delete_all_message2'] = 'Eliminando un account eliminerai tutti i tuoi dati personali memorizzati. I tuoi conti, transazioni, budget e categorie verranno eliminati e non potranno essere recuperati. Sei d\'accordo?';
		map['more.about_us.display'] = 'Informazioni sull\'app';
		map['more.about_us.description'] = 'Trova i termini di Monekin, informazioni importanti e connettiti segnalando bug o condividendo idee';
		map['more.about_us.legal.display'] = 'Informazioni legali';
		map['more.about_us.legal.privacy'] = 'Informativa sulla privacy';
		map['more.about_us.legal.terms'] = 'Termini di utilizzo';
		map['more.about_us.legal.licenses'] = 'Licenze';
		map['more.about_us.project.display'] = 'Progetto';
		map['more.about_us.project.contributors'] = 'Collaboratori';
		map['more.about_us.project.contributors_descr'] = 'Tutti gli sviluppatori che hanno fatto crescere Monekin';
		map['more.about_us.project.contact'] = 'Contattaci';
		map['more.help_us.display'] = 'Aiutaci';
		map['more.help_us.description'] = 'Scopri come puoi aiutare Monekin a migliorare sempre di più';
		map['more.help_us.rate_us'] = 'Valutaci';
		map['more.help_us.rate_us_descr'] = 'Ogni valutazione è benvenuta!';
		map['more.help_us.share'] = 'Condividi Monekin';
		map['more.help_us.share_descr'] = 'Condividi la nostra app con amici e famiglia';
		map['more.help_us.share_text'] = 'Monekin! La migliore app di finanza personale. Scaricala qui';
		map['more.help_us.thanks'] = 'Grazie!';
		map['more.help_us.thanks_long'] = 'I tuoi contributi a Monekin e ad altri progetti open source, grandi e piccoli, rendono possibili grandi progetti come questo. Grazie per aver dedicato tempo a contribuire.';
		map['more.help_us.donate'] = 'Fai una donazione';
		map['more.help_us.donate_descr'] = 'Con la tua donazione aiuterai l\'app a continuare a ricevere miglioramenti. Quale modo migliore per ringraziare il lavoro svolto se non invitandomi per un caffè?';
		map['more.help_us.donate_success'] = 'Donazione effettuata. Grazie mille per il tuo contributo! ❤️';
		map['more.help_us.donate_err'] = 'Oops! Sembra che ci sia stato un errore nel ricevere il tuo pagamento';
		map['more.help_us.report'] = 'Segnala bug, lascia suggerimenti...';

		_map = map;
		return map;
	}
}


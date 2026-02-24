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
class TranslationsIt with BaseTranslations<AppLocale, Translations> implements Translations {
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
	@override late final _TranslationsGoalsIt goals = _TranslationsGoalsIt._(_root);
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
	@override String get delete_success => 'Elemento eliminato con successo';
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
	@override String get status => 'Stato del bilancio';
	@override String get repeated => 'Ricorrente';
	@override String get one_time => 'Una tantum';
	@override String get actives => 'Attivi';
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

// Path: goals
class _TranslationsGoalsIt implements TranslationsGoalsEn {
	_TranslationsGoalsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Obiettivi';
	@override String get status => 'Stato dell\'obiettivo';
	@override late final _TranslationsGoalsTypeIt type = _TranslationsGoalsTypeIt._(_root);
	@override String get empty_title => 'Nessun obiettivo trovato';
	@override String get empty_description => 'Crea un nuovo obiettivo per iniziare a monitorare i tuoi risparmi!';
	@override String get delete => 'Elimina obiettivo';
	@override String get delete_warning => 'Questa azione è irreversibile. Le categorie e le transazioni riferite a questo obiettivo non verranno eliminate';
	@override late final _TranslationsGoalsFormIt form = _TranslationsGoalsFormIt._(_root);
	@override late final _TranslationsGoalsDetailsIt details = _TranslationsGoalsDetailsIt._(_root);
	@override late final _TranslationsGoalsTargetTimelineStatusesIt target_timeline_statuses = _TranslationsGoalsTargetTimelineStatusesIt._(_root);
	@override late final _TranslationsGoalsProgressIt progress = _TranslationsGoalsProgressIt._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesIt implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get active => 'Attivo';
	@override String get past => 'Terminato';
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
	@override String get past => 'Budget terminato';
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

// Path: goals.type
class _TranslationsGoalsTypeIt implements TranslationsGoalsTypeEn {
	_TranslationsGoalsTypeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get display => 'Tipo di obiettivo';
	@override late final _TranslationsGoalsTypeIncomeIt income = _TranslationsGoalsTypeIncomeIt._(_root);
	@override late final _TranslationsGoalsTypeExpenseIt expense = _TranslationsGoalsTypeExpenseIt._(_root);
}

// Path: goals.form
class _TranslationsGoalsFormIt implements TranslationsGoalsFormEn {
	_TranslationsGoalsFormIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get new_title => 'Nuovo obiettivo';
	@override String get edit_title => 'Modifica obiettivo';
	@override String get target_amount => 'Importo obiettivo';
	@override String get initial_amount => 'Importo iniziale';
	@override String get name => 'Nome';
	@override String get name_hint => 'Il mio obiettivo di risparmio';
	@override String get create_success => 'Obiettivo creato con successo';
	@override String get edit_success => 'Obiettivo modificato con successo';
	@override String get negative_warn => 'L\'importo dell\'obiettivo non può essere negativo';
}

// Path: goals.details
class _TranslationsGoalsDetailsIt implements TranslationsGoalsDetailsEn {
	_TranslationsGoalsDetailsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dettagli obiettivo';
	@override String get statistics => 'Statistiche';
	@override String get goal_value => 'Valore obiettivo';
	@override String get evolution => 'Evoluzione';
	@override String get no_transactions => 'Sembra che tu non abbia effettuato alcuna transazione relativa a questo obiettivo';
}

// Path: goals.target_timeline_statuses
class _TranslationsGoalsTargetTimelineStatusesIt implements TranslationsGoalsTargetTimelineStatusesEn {
	_TranslationsGoalsTargetTimelineStatusesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get active => 'Obiettivo attivo';
	@override String get past => 'Obiettivo terminato';
	@override String get future => 'Obiettivo futuro';
}

// Path: goals.progress
class _TranslationsGoalsProgressIt implements TranslationsGoalsProgressEn {
	_TranslationsGoalsProgressIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGoalsProgressLabelsIt labels = _TranslationsGoalsProgressLabelsIt._(_root);
	@override late final _TranslationsGoalsProgressDescriptionIt description = _TranslationsGoalsProgressDescriptionIt._(_root);
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
	@override String get show_all_decimals => 'Mostra tutti i decimali';
	@override String get show_all_decimals_descr => 'Mostra tutti i decimali anche se sono zeri finali';
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
	@override late final _TranslationsSettingsTransactionsStyleIt style = _TranslationsSettingsTransactionsStyleIt._(_root);
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
	@override String get active_indeterminate => 'Attivo';
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
	@override String active_indeterminate({required Object amount}) => 'Ti restano ${amount} da spendere.';
	@override String active_exceeded({required Object amount}) => 'Hai già superato il limite del budget di ${amount}. Se non trovi entrate per questo budget, dovresti smettere di spendere per il resto del periodo';
	@override String get success => 'Ottimo lavoro! Questo budget è terminato con successo. Continua a creare budget per gestire le tue spese';
	@override String fail({required Object amount}) => 'Hai superato il budget di ${amount}. Cerca di fare più attenzione la prossima volta!';
}

// Path: goals.type.income
class _TranslationsGoalsTypeIncomeIt implements TranslationsGoalsTypeIncomeEn {
	_TranslationsGoalsTypeIncomeIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Obiettivo di Risparmio';
	@override String get descr => 'Ideale per risparmiare denaro. Hai successo quando il saldo supera il tuo obiettivo.';
}

// Path: goals.type.expense
class _TranslationsGoalsTypeExpenseIt implements TranslationsGoalsTypeExpenseEn {
	_TranslationsGoalsTypeExpenseIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Obiettivo di Spesa';
	@override String get descr => 'Traccia quanto spendi e mira a raggiungere un importo obiettivo. Funziona bene per donazioni...';
}

// Path: goals.progress.labels
class _TranslationsGoalsProgressLabelsIt implements TranslationsGoalsProgressLabelsEn {
	_TranslationsGoalsProgressLabelsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'In pista';
	@override String get active_behind_schedule => 'In ritardo rispetto al programma';
	@override String get active_indeterminate => 'Attivo';
	@override String get success => 'Obiettivo raggiunto';
	@override String get fail => 'Obiettivo fallito';
}

// Path: goals.progress.description
class _TranslationsGoalsProgressDescriptionIt implements TranslationsGoalsProgressDescriptionEn {
	_TranslationsGoalsProgressDescriptionIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Sei sulla buona strada per raggiungere il tuo obiettivo! Devi risparmiare ${dailyAmount} al giorno per i restanti ${remainingDays} giorni';
	@override String active_behind_schedule({required Object dailyAmount, required Object remainingDays}) => 'Sei in ritardo sulla tabella di marcia. Devi risparmiare ${dailyAmount} al giorno per raggiungere il tuo obiettivo in ${remainingDays} giorni';
	@override String active_indeterminate({required Object amount}) => 'Ti servono ${amount} in più per raggiungere il tuo obiettivo.';
	@override String get success => 'Congratulazioni! Hai raggiunto il tuo obiettivo.';
	@override String fail({required Object amount}) => 'Hai mancato il tuo obiettivo di ${amount}.';
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
		'Seleziona la colonna in cui è specificato il valore di ogni transazione. Usa valori negativi per le spese e valori positivi per le entrate.',
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

// Path: settings.transactions.style
class _TranslationsSettingsTransactionsStyleIt implements TranslationsSettingsTransactionsStyleEn {
	_TranslationsSettingsTransactionsStyleIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Stile transazione';
	@override String get subtitle => 'Configura l\'aspetto delle transazioni nelle liste dell\'app';
	@override String get show_tags => 'Mostra Tag';
	@override String get show_time => 'Mostra Ora';
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
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ui_actions.cancel' => 'Annulla',
			'ui_actions.confirm' => 'Conferma',
			'ui_actions.continue_text' => 'Continua',
			'ui_actions.save' => 'Salva',
			'ui_actions.save_changes' => 'Salva modifiche',
			'ui_actions.close_and_save' => 'Salva e chiudi',
			'ui_actions.add' => 'Aggiungi',
			'ui_actions.edit' => 'Modifica',
			'ui_actions.delete' => 'Elimina',
			'ui_actions.see_more' => 'Vedi altro',
			'ui_actions.select_all' => 'Seleziona tutto',
			'ui_actions.deselect_all' => 'Deseleziona tutto',
			'ui_actions.select' => 'Seleziona',
			'ui_actions.search' => 'Cerca',
			'ui_actions.filter' => 'Filtra',
			'ui_actions.reset' => 'Ripristina',
			'ui_actions.submit' => 'Invia',
			'ui_actions.next' => 'Avanti',
			'ui_actions.previous' => 'Precedente',
			'ui_actions.back' => 'Indietro',
			'ui_actions.reload' => 'Ricarica',
			'ui_actions.view' => 'Visualizza',
			'ui_actions.download' => 'Scarica',
			'ui_actions.upload' => 'Carica',
			'ui_actions.retry' => 'Riprova',
			'ui_actions.copy' => 'Copia',
			'ui_actions.paste' => 'Incolla',
			'ui_actions.undo' => 'Annulla',
			'ui_actions.redo' => 'Ripristina',
			'ui_actions.open' => 'Apri',
			'ui_actions.close' => 'Chiudi',
			'ui_actions.apply' => 'Applica',
			'ui_actions.discard' => 'Ignora',
			'ui_actions.refresh' => 'Aggiorna',
			'ui_actions.share' => 'Condividi',
			'general.or' => 'o',
			'general.understood' => 'Capito',
			'general.unspecified' => 'Non specificato',
			'general.quick_actions' => 'Azioni rapide',
			'general.details' => 'Dettagli',
			'general.balance' => 'Saldo',
			'general.account' => 'Conto',
			'general.accounts' => 'Conti',
			'general.categories' => 'Categorie',
			'general.category' => 'Categoria',
			'general.today' => 'Oggi',
			'general.yesterday' => 'Ieri',
			'general.filters' => 'Filtri',
			'general.empty_warn' => 'Ops! È davvero vuoto',
			'general.search_no_results' => 'Nessun articolo corrisponde ai tuoi criteri di ricerca',
			'general.insufficient_data' => 'Dati insufficienti',
			'general.show_more_fields' => 'Mostra più campi',
			'general.show_less_fields' => 'Mostra meno campi',
			'general.tap_to_search' => 'Tocca per cercare',
			'general.delete_success' => 'Elemento eliminato con successo',
			'general.leave_without_saving.title' => 'Uscire senza salvare?',
			'general.leave_without_saving.message' => 'Hai modifiche non salvate, sei sicuro di voler uscire senza salvarle?',
			'general.clipboard.success' => ({required Object x}) => '${x} copiato negli appunti',
			'general.clipboard.error' => 'Errore di copia',
			'general.time.start_date' => 'Data di inizio',
			'general.time.end_date' => 'Data di fine',
			'general.time.from_date' => 'Dalla data',
			'general.time.until_date' => 'Fino alla data',
			'general.time.date' => 'Data',
			'general.time.datetime' => 'Data e ora',
			'general.time.time' => 'Ora',
			'general.time.each' => 'Ogni',
			'general.time.after' => 'Dopo',
			'general.time.ranges.display' => 'Intervallo di tempo',
			'general.time.ranges.it_repeat' => 'Si ripete',
			'general.time.ranges.it_ends' => 'Termina',
			'general.time.ranges.forever' => 'Sempre',
			'general.time.ranges.types.cycle' => 'Cicli',
			'general.time.ranges.types.last_days' => 'Ultimi giorni',
			'general.time.ranges.types.last_days_form' => ({required Object x}) => '${x} giorni precedenti',
			'general.time.ranges.types.all' => 'Sempre',
			'general.time.ranges.types.date_range' => 'Intervallo personalizzato',
			'general.time.ranges.each_range' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Ogni ${range}', other: 'Ogni ${n} ${range}', ), 
			'general.time.ranges.each_range_until_date' => ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Ogni ${range} fino al ${day}', other: 'Ogni ${n} ${range} fino al ${day}', ), 
			'general.time.ranges.each_range_until_times' => ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Ogni ${range} ${limit} volte', other: 'Ogni ${n} ${range} ${limit} volte', ), 
			'general.time.ranges.each_range_until_once' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Ogni ${range} una volta', other: 'Ogni ${n} ${range} una volta', ), 
			'general.time.ranges.month' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Mese', other: 'Mesi', ), 
			'general.time.ranges.year' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Anno', other: 'Anni', ), 
			'general.time.ranges.day' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Giorno', other: 'Giorni', ), 
			'general.time.ranges.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Settimana', other: 'Settimane', ), 
			'general.time.periodicity.display' => 'Ricorrenza',
			'general.time.periodicity.no_repeat' => 'Non si ripete',
			'general.time.periodicity.repeat' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Ripetizione', other: 'Ripetizioni', ), 
			'general.time.periodicity.diary' => 'Giornaliera',
			'general.time.periodicity.monthly' => 'Mensile',
			'general.time.periodicity.annually' => 'Annuale',
			'general.time.periodicity.quaterly' => 'Trimestrale',
			'general.time.periodicity.weekly' => 'Settimanale',
			'general.time.periodicity.custom' => 'Personalizzata',
			'general.time.periodicity.infinite' => 'Sempre',
			'general.time.current.monthly' => 'Questo mese',
			'general.time.current.annually' => 'Quest\'anno',
			'general.time.current.quaterly' => 'Questo trimestre',
			'general.time.current.weekly' => 'Questa settimana',
			'general.time.current.infinite' => 'Per sempre',
			'general.time.current.custom' => 'Intervallo personalizzato',
			'general.time.all.diary' => 'Ogni giorno',
			'general.time.all.monthly' => 'Ogni mese',
			'general.time.all.annually' => 'Ogni anno',
			'general.time.all.quaterly' => 'Ogni trimestre',
			'general.time.all.weekly' => 'Ogni settimana',
			'general.transaction_order.display' => 'Ordina transazioni',
			'general.transaction_order.category' => 'Per categoria',
			'general.transaction_order.quantity' => 'Per quantità',
			'general.transaction_order.date' => 'Per data',
			'general.validations.form_error' => 'Correggi i campi indicati per continuare',
			'general.validations.required' => 'Campo obbligatorio',
			'general.validations.positive' => 'Deve essere positivo',
			'general.validations.min_number' => ({required Object x}) => 'Deve essere maggiore di ${x}',
			'general.validations.max_number' => ({required Object x}) => 'Deve essere minore di ${x}',
			'intro.start' => 'Inizia',
			'intro.skip' => 'Salta',
			'intro.next' => 'Avanti',
			'intro.select_your_currency' => 'Seleziona la tua valuta',
			'intro.welcome_subtitle' => 'Il tuo gestore di finanze personali',
			'intro.welcome_subtitle2' => '100% open, 100% gratuito',
			'intro.welcome_footer' => 'Effettuando l\'accesso accetti l\'<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>informativa sulla privacy</a> e i <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Termini di utilizzo</a> dell\'applicazione',
			'intro.offline_descr_title' => 'CONTO OFFLINE:',
			'intro.offline_descr' => 'I tuoi dati saranno conservati solo sul tuo dispositivo e saranno al sicuro finché non disinstallerai l\'app o cambierai telefono. Per prevenire la perdita di dati, si consiglia di effettuare un backup regolarmente dalle impostazioni dell\'app.',
			'intro.offline_start' => 'Avvia sessione offline',
			'intro.sl1_title' => 'Seleziona la tua valuta',
			'intro.sl1_descr' => 'La tua valuta predefinita sarà utilizzata nei rapporti e nei grafici generali. Potrai cambiare la valuta e la lingua dell\'app in qualsiasi momento nelle impostazioni dell\'applicazione',
			'intro.sl2_title' => 'Sicura, privata e affidabile',
			'intro.sl2_descr' => 'I tuoi dati sono solo tuoi. Conserviamo le informazioni direttamente sul tuo dispositivo, senza passare per server esterni. Questo rende possibile usare l\'app anche senza internet',
			'intro.sl2_descr2' => 'Inoltre, il codice sorgente dell\'applicazione è pubblico, chiunque può collaborare e vedere come funziona',
			'intro.last_slide_title' => 'Tutto pronto',
			'intro.last_slide_descr' => 'Con Monekin, puoi finalmente raggiungere l\'indipendenza finanziaria che tanto desideri. Avrai grafici, budget, consigli, statistiche e molto altro sul tuo denaro.',
			'intro.last_slide_descr2' => 'Speriamo che la tua esperienza ti piaccia! Non esitare a contattarci in caso di dubbi, suggerimenti...',
			'home.title' => 'Dashboard',
			'home.filter_transactions' => 'Filtra transazioni',
			'home.hello_day' => 'Buongiorno,',
			'home.hello_night' => 'Buonasera,',
			'home.total_balance' => 'Saldo totale',
			'home.my_accounts' => 'I miei conti',
			'home.active_accounts' => 'Conti attivi',
			'home.no_accounts' => 'Nessun conto creato ancora',
			'home.no_accounts_descr' => 'Inizia a usare tutta la magia di Monekin. Crea almeno un conto per iniziare ad aggiungere transazioni',
			'home.last_transactions' => 'Ultime transazioni',
			'home.should_create_account_header' => 'Oops!',
			'home.should_create_account_message' => 'Devi avere almeno un conto non archiviato prima di poter iniziare a creare transazioni',
			'financial_health.display' => 'Salute finanziaria',
			'financial_health.review.very_good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Ottima!'; case GenderContext.female: return 'Ottima!'; } }, 
			'financial_health.review.good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Buona'; case GenderContext.female: return 'Buona'; } }, 
			'financial_health.review.normal' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Media'; case GenderContext.female: return 'Media'; } }, 
			'financial_health.review.bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Discreta'; case GenderContext.female: return 'Discreta'; } }, 
			'financial_health.review.very_bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Molto Cattiva'; case GenderContext.female: return 'Molto Cattiva'; } }, 
			'financial_health.review.insufficient_data' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Dati insufficienti'; case GenderContext.female: return 'Dati insufficienti'; } }, 
			'financial_health.review.descr.insufficient_data' => 'Sembra che non abbiamo abbastanza spese per calcolare la tua salute finanziaria. Aggiungi alcune spese/entrate in questo periodo per permetterci di aiutarti!',
			'financial_health.review.descr.very_good' => 'Congratulazioni! La tua salute finanziaria è eccezionale. Speriamo che continui la tua buona serie e continui a imparare con Monekin',
			'financial_health.review.descr.good' => 'Ottimo! La tua salute finanziaria è buona. Visita la scheda di analisi per vedere come risparmiare ancora di più!',
			'financial_health.review.descr.normal' => 'La tua salute finanziaria è più o meno nella media del resto della popolazione per questo periodo',
			'financial_health.review.descr.bad' => 'Sembra che la tua situazione finanziaria non sia ancora delle migliori. Esplora il resto dei grafici per saperne di più sulle tue finanze',
			'financial_health.review.descr.very_bad' => 'Mmm, la tua salute finanziaria è ben al di sotto di quanto dovrebbe essere. Esplora il resto dei grafici per saperne di più sulle tue finanze',
			'financial_health.months_without_income.title' => 'Tasso di sopravvivenza',
			'financial_health.months_without_income.subtitle' => 'Dato il tuo saldo, il tempo che potresti resistere senza entrate',
			'financial_health.months_without_income.text_zero' => 'Non potresti sopravvivere un mese senza entrate a questo tasso di spese!',
			'financial_health.months_without_income.text_one' => 'Potresti a malapena sopravvivere circa un mese senza entrate a questo tasso di spese!',
			'financial_health.months_without_income.text_other' => ({required Object n}) => 'Potresti sopravvivere circa <b>${n} mesi</b> senza entrate a questo tasso di spesa.',
			'financial_health.months_without_income.text_infinite' => 'Potresti sopravvivere circa <b>tutta la vita</b> senza entrate a questo tasso di spesa.',
			'financial_health.months_without_income.suggestion' => 'Ricorda che è consigliabile mantenere questo rapporto al di sopra dei 5 mesi almeno. Se vedi che non hai un cuscinetto di risparmio sufficiente, riduci le spese non necessarie.',
			'financial_health.months_without_income.insufficient_data' => 'Sembra che non abbiamo abbastanza spese per calcolare quanti mesi potresti sopravvivere senza entrate. Inserisci alcune transazioni e torna qui per controllare la tua salute finanziaria',
			'financial_health.savings_percentage.title' => 'Percentuale di risparmio',
			'financial_health.savings_percentage.subtitle' => 'Quale parte del tuo reddito non viene spesa in questo periodo',
			'financial_health.savings_percentage.text.good' => ({required Object value}) => 'Congratulazioni! Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Sembra che tu sia già un esperto, continua così!',
			'financial_health.savings_percentage.text.normal' => ({required Object value}) => 'Congratulazioni, sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo.',
			'financial_health.savings_percentage.text.bad' => ({required Object value}) => 'Sei riuscito a risparmiare il <b>${value}%</b> del tuo reddito durante questo periodo. Tuttavia, pensiamo che tu possa fare ancora molto di più!',
			'financial_health.savings_percentage.text.very_bad' => 'Wow, non sei riuscito a risparmiare nulla durante questo periodo.',
			'financial_health.savings_percentage.suggestion' => 'Ricorda che è consigliabile risparmiare almeno il 15-20% di ciò che guadagni.',
			'stats.title' => 'Statistiche',
			'stats.balance' => 'Saldo',
			'stats.final_balance' => 'Saldo finale',
			'stats.balance_by_account' => 'Saldo per conto',
			'stats.balance_by_account_subtitle' => 'Dove ho la maggior parte dei miei soldi?',
			'stats.balance_by_currency' => 'Saldo per valuta',
			'stats.balance_by_currency_subtitle' => 'Quanti soldi ho in valuta estera?',
			'stats.balance_evolution' => 'Andamento del saldo',
			'stats.balance_evolution_subtitle' => 'Ho più soldi di prima?',
			'stats.compared_to_previous_period' => 'Rispetto al periodo precedente',
			'stats.cash_flow' => 'Flusso di cassa',
			'stats.cash_flow_subtitle' => 'Sto spendendo meno di quanto guadagno?',
			'stats.by_periods' => 'Per periodi',
			'stats.by_categories' => 'Per categorie',
			'stats.by_tags' => 'Per etichette',
			'stats.distribution' => 'Distribuzione',
			'stats.finance_health_resume' => 'Riepilogo',
			'stats.finance_health_breakdown' => 'Ripartizione',
			'icon_selector.name' => 'Nome:',
			'icon_selector.icon' => 'Icona',
			'icon_selector.color' => 'Colore',
			'icon_selector.select_icon' => 'Seleziona un\'icona',
			'icon_selector.select_color' => 'Seleziona un colore',
			'icon_selector.custom_color' => 'Colore personalizzato',
			'icon_selector.current_color_selection' => 'Selezione attuale',
			'icon_selector.select_account_icon' => 'Identifica il tuo conto',
			'icon_selector.select_category_icon' => 'Identifica la tua categoria',
			'icon_selector.scopes.transport' => 'Trasporto',
			'icon_selector.scopes.money' => 'Denaro',
			'icon_selector.scopes.food' => 'Cibo',
			'icon_selector.scopes.medical' => 'Salute',
			'icon_selector.scopes.entertainment' => 'Tempo libero',
			'icon_selector.scopes.technology' => 'Tecnologia',
			'icon_selector.scopes.other' => 'Altro',
			'icon_selector.scopes.logos_financial_institutions' => 'Istituzioni finanziarie',
			'transaction.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Transazione', other: 'Transazioni', ), 
			'transaction.create' => 'Nuova transazione',
			'transaction.new_income' => 'Nuova entrata',
			'transaction.new_expense' => 'Nuova spesa',
			'transaction.new_success' => 'Transazione creata con successo',
			'transaction.edit' => 'Modifica transazione',
			'transaction.edit_success' => 'Transazione modificata con successo',
			'transaction.edit_multiple' => 'Modifica transazioni',
			'transaction.edit_multiple_success' => ({required Object x}) => '${x} transazioni modificate con successo',
			'transaction.duplicate' => 'Clona transazione',
			'transaction.duplicate_short' => 'Clona',
			'transaction.duplicate_warning_message' => 'Verrà creata una transazione identica a questa con la stessa data, vuoi continuare?',
			'transaction.duplicate_success' => 'Transazione clonata con successo',
			'transaction.delete' => 'Elimina transazione',
			'transaction.delete_warning_message' => 'Questa azione è irreversibile. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate',
			'transaction.delete_success' => 'Transazione eliminata correttamente',
			'transaction.delete_multiple' => 'Elimina transazioni',
			'transaction.delete_multiple_warning_message' => ({required Object x}) => 'Questa azione è irreversibile ed eliminerà ${x} transazioni. Il saldo attuale dei tuoi conti e tutte le tue statistiche saranno ricalcolate',
			'transaction.delete_multiple_success' => ({required Object x}) => '${x} transazioni eliminate correttamente',
			'transaction.details' => 'Dettagli movimento',
			'transaction.next_payments.accept' => 'Accetta',
			'transaction.next_payments.skip' => 'Salta',
			'transaction.next_payments.skip_success' => 'Transazione saltata con successo',
			'transaction.next_payments.skip_dialog_title' => 'Salta transazione',
			'transaction.next_payments.skip_dialog_msg' => ({required Object date}) => 'Questa azione è irreversibile. Sposteremo la data del prossimo movimento al ${date}',
			'transaction.next_payments.accept_today' => 'Accetta oggi',
			'transaction.next_payments.accept_in_required_date' => ({required Object date}) => 'Accetta alla data richiesta (${date})',
			'transaction.next_payments.accept_dialog_title' => 'Accetta transazione',
			'transaction.next_payments.accept_dialog_msg_single' => 'Il nuovo stato della transazione sarà nullo. Potrai ri-modificare lo stato di questa transazione quando vuoi',
			'transaction.next_payments.accept_dialog_msg' => ({required Object date}) => 'Questa azione creerà una nuova transazione con data ${date}. Potrai controllare i dettagli di questa transazione sulla pagina delle transazioni',
			'transaction.next_payments.recurrent_rule_finished' => 'La regola ricorrente è stata completata, non ci sono più pagamenti da effettuare!',
			'transaction.list.all' => 'Tutte le transazioni',
			'transaction.list.empty' => 'Nessuna transazione trovata da mostrare qui. Aggiungi alcune transazioni nell\'app e magari sarai più fortunato la prossima volta.',
			'transaction.list.searcher_placeholder' => 'Cerca per categoria, descrizione...',
			'transaction.list.searcher_no_results' => 'Nessuna transazione trovata corrispondente ai criteri di ricerca',
			'transaction.list.loading' => 'Caricamento di altre transazioni...',
			'transaction.list.selected_short' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} selezionato', other: '${n} selezionati', ), 
			'transaction.list.selected_long' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} transazione selezionata', other: '${n} transazioni selezionate', ), 
			'transaction.list.bulk_edit.dates' => 'Modifica date',
			'transaction.list.bulk_edit.categories' => 'Modifica categorie',
			'transaction.list.bulk_edit.status' => 'Modifica stati',
			'transaction.filters.title' => 'Filtri delle transazioni',
			'transaction.filters.from_value' => 'Da importo',
			'transaction.filters.to_value' => 'Fino a importo',
			'transaction.filters.from_value_def' => ({required Object x}) => 'Da ${x}',
			'transaction.filters.to_value_def' => ({required Object x}) => 'Fino a ${x}',
			'transaction.filters.from_date_def' => ({required Object date}) => 'Dalla data ${date}',
			'transaction.filters.to_date_def' => ({required Object date}) => 'Fino alla data ${date}',
			'transaction.filters.reset' => 'Ripristina filtri',
			'transaction.filters.saved.title' => 'Filtri salvati',
			'transaction.filters.saved.new_title' => 'Nuovo filtro',
			'transaction.filters.saved.edit_title' => 'Modifica filtro',
			'transaction.filters.saved.name_label' => 'Nome del filtro',
			'transaction.filters.saved.name_hint' => 'Il mio filtro personalizzato',
			'transaction.filters.saved.save_dialog_title' => 'Salva filtro',
			'transaction.filters.saved.save_tooltip' => 'Salva filtro corrente',
			'transaction.filters.saved.load_tooltip' => 'Carica filtro salvato',
			'transaction.filters.saved.empty_title' => 'Nessun filtro salvato trovato',
			'transaction.filters.saved.empty_description' => 'Salva i filtri qui per accedervi rapidamente in seguito.',
			'transaction.filters.saved.save_success' => 'Filtro salvato con successo',
			'transaction.filters.saved.delete_success' => 'Filtro eliminato con successo',
			'transaction.form.validators.zero' => 'Il valore di una transazione non può essere uguale a zero',
			'transaction.form.validators.date_max' => 'La data selezionata è successiva a quella attuale. La transazione verrà aggiunta come in sospeso',
			'transaction.form.validators.date_after_account_creation' => 'Non puoi creare una transazione la cui data sia precedente alla data di creazione del conto a cui appartiene',
			'transaction.form.validators.negative_transfer' => 'Il valore monetario di un trasferimento non può essere negativo',
			'transaction.form.validators.transfer_between_same_accounts' => 'Il conto di origine e quello di destinazione non possono essere gli stessi',
			'transaction.form.title' => 'Titolo transazione',
			'transaction.form.title_short' => 'Titolo',
			'transaction.form.value' => 'Valore della transazione',
			'transaction.form.tap_to_see_more' => 'Tocca per vedere più dettagli',
			'transaction.form.no_tags' => '-- Nessuna etichetta --',
			'transaction.form.description' => 'Descrizione',
			'transaction.form.description_info' => 'Tocca qui per inserire una descrizione più dettagliata su questa transazione',
			'transaction.form.exchange_to_preferred_title' => ({required Object currency}) => 'Tasso di cambio per ${currency}',
			'transaction.form.exchange_to_preferred_in_date' => 'Alla data della transazione',
			'transaction.reversed.title' => 'Transazione inversa',
			'transaction.reversed.title_short' => 'Trans. inversa',
			'transaction.reversed.description_for_expenses' => 'Nonostante sia una transazione di spesa, ha un importo positivo. Questi tipi di transazioni possono essere utilizzati per rappresentare la restituzione di una spesa precedentemente registrata, come un rimborso o il pagamento di un debito.',
			'transaction.reversed.description_for_incomes' => 'Nonostante sia una transazione di entrata, ha un importo negativo. Questi tipi di transazioni possono essere utilizzati per annullare o correggere un\'entrata registrata in modo errato, per riflettere una restituzione o un rimborso di denaro o per registrare il pagamento di debiti.',
			'transaction.status.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Stato', other: 'Stati', ), 
			'transaction.status.display_long' => 'Stato transazione',
			'transaction.status.tr_status' => ({required Object status}) => 'Transazione ${status}',
			'transaction.status.none' => 'Senza stato',
			'transaction.status.none_descr' => 'Transazione senza uno stato specifico',
			'transaction.status.reconciled' => 'Riconciliata',
			'transaction.status.reconciled_descr' => 'Questa transazione è già stata convalidata e corrisponde a una transazione reale della tua banca',
			'transaction.status.unreconciled' => 'Non riconciliata',
			'transaction.status.unreconciled_descr' => 'Questa transazione non è ancora stata convalidata e pertanto non appare ancora nei tuoi conti bancari reali. Tuttavia, conta per il calcolo dei saldi e delle statistiche in Monekin',
			'transaction.status.pending' => 'In sospeso',
			'transaction.status.pending_descr' => 'Questa transazione è in sospeso e pertanto non verrà presa in considerazione nel calcolo dei saldi e delle statistiche',
			'transaction.status.voided' => 'Annullata',
			'transaction.status.voided_descr' => 'Transazione annullata/cancellata a causa di errore di pagamento o qualsiasi altra ragione. Non verrà presa in considerazione nel calcolo dei saldi e delle statistiche',
			'transaction.types.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Tipo di transazione', other: 'Tipi di transazione', ), 
			'transaction.types.income' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Entrata', other: 'Entrate', ), 
			'transaction.types.expense' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Spesa', other: 'Spese', ), 
			'transaction.types.transfer' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Trasferimento', other: 'Trasferimenti', ), 
			'transfer.display' => 'Trasferimento',
			'transfer.transfers' => 'Trasferimenti',
			'transfer.transfer_to' => ({required Object account}) => 'Trasferimento a ${account}',
			'transfer.create' => 'Nuovo Trasferimento',
			'transfer.need_two_accounts_warning_header' => 'Ops!',
			'transfer.need_two_accounts_warning_message' => 'Sono necessari almeno due conti per eseguire questa azione. Se devi regolare o modificare il saldo attuale di questo conto, clicca sul pulsante modifica',
			'transfer.form.from' => 'Conto di origine',
			'transfer.form.to' => 'Conto di destinazione',
			'transfer.form.value_in_destiny.title' => 'Importo trasferito a destinazione',
			'transfer.form.value_in_destiny.amount_short' => ({required Object amount}) => '${amount} al conto di destinazione',
			'recurrent_transactions.title' => 'Transazioni ricorrenti',
			'recurrent_transactions.title_short' => 'Trans. ric.',
			'recurrent_transactions.empty' => 'Sembra che tu non abbia transazioni ricorrenti. Crea una transazione ricorrente mensile, annuale o settimanale e apparirà qui',
			'recurrent_transactions.total_expense_title' => 'Spesa totale per periodo',
			'recurrent_transactions.total_expense_descr' => '* Senza considerare la data di inizio e fine di ciascuna ricorrenza',
			'recurrent_transactions.details.title' => 'Transazione ricorrente',
			'recurrent_transactions.details.descr' => 'I prossimi movimenti per questa transazione sono mostrati di seguito. Puoi accettare il primo movimento o saltarlo',
			'recurrent_transactions.details.last_payment_info' => 'Questo movimento è l\'ultimo della regola ricorrente, quindi questa regola verrà automaticamente eliminata confermando questa azione',
			'recurrent_transactions.details.delete_header' => 'Elimina transazione ricorrente',
			'recurrent_transactions.details.delete_message' => 'Questa azione è irreversibile e non influenzerà le transazioni che hai già confermato/pagato',
			'recurrent_transactions.status.delayed_by' => ({required Object x}) => 'Ritardato di ${x}g',
			'recurrent_transactions.status.coming_in' => ({required Object x}) => 'Tra ${x} giorni',
			'account.details' => 'Dettagli conto',
			'account.date' => 'Data di apertura',
			'account.close_date' => 'Data di chiusura',
			'account.reopen' => 'Riapri conto',
			'account.reopen_short' => 'Riapri',
			'account.reopen_descr' => 'Sei sicuro di voler riaprire questo conto?',
			'account.balance' => 'Saldo del conto',
			'account.n_transactions' => 'Numero di transazioni',
			'account.add_money' => 'Aggiungi denaro',
			'account.withdraw_money' => 'Preleva denaro',
			'account.no_accounts' => 'Nessuna transazione trovata da mostrare qui. Aggiungi una transazione cliccando sul pulsante \'+\' in basso',
			'account.types.title' => 'Tipo di conto',
			'account.types.warning' => 'Una volta scelto il tipo di conto, non potrà essere modificato in futuro',
			'account.types.normal' => 'Conto normale',
			'account.types.normal_descr' => 'Utile per registrare le tue finanze quotidiane. È il conto più comune, ti permette di aggiungere spese, entrate...',
			'account.types.saving' => 'Conto risparmio',
			'account.types.saving_descr' => 'Potrai solo aggiungere e prelevare denaro da esso da altri conti. Perfetto per iniziare a risparmiare denaro',
			'account.form.name' => 'Nome conto',
			'account.form.name_placeholder' => 'Es: Conto risparmio',
			'account.form.notes' => 'Note',
			'account.form.notes_placeholder' => 'Digita alcune note/descrizione su questo conto',
			'account.form.initial_balance' => 'Saldo iniziale',
			'account.form.current_balance' => 'Saldo attuale',
			'account.form.create' => 'Crea conto',
			'account.form.edit' => 'Modifica conto',
			'account.form.currency_not_found_warn' => 'Non hai informazioni sui tassi di cambio per questa valuta. Verrà utilizzato 1.0 come tasso di cambio predefinito. Puoi modificarlo nelle impostazioni',
			'account.form.already_exists' => 'Ne esiste già un altro con lo stesso nome, per favore scrivine un altro',
			'account.form.tr_before_opening_date' => 'Ci sono transazioni in questo conto con una data precedente alla data di apertura',
			'account.form.iban' => 'IBAN',
			'account.form.swift' => 'SWIFT',
			'account.delete.warning_header' => 'Eliminare conto?',
			'account.delete.warning_text' => 'Questa azione eliminerà questo conto e tutte le sue transazioni',
			'account.delete.success' => 'Conto eliminato con successo',
			'account.close.title' => 'Chiudi conto',
			'account.close.title_short' => 'Chiudi',
			'account.close.warn' => 'Questo conto non apparirà più in determinati elenchi e non potrai creare transazioni in esso con una data successiva a quella specificata di seguito. Questa azione non influisce su transazioni o saldo, e puoi anche riaprire questo conto in qualsiasi momento.',
			'account.close.should_have_zero_balance' => 'Devi avere un saldo attuale di 0 in questo conto per chiuderlo. Per favore modifica il conto prima di continuare',
			'account.close.should_have_no_transactions' => 'Questo conto ha transazioni dopo la data di chiusura specificata. Eliminale o modifica la data di chiusura del conto prima di continuare',
			'account.close.success' => 'Conto chiuso con successo',
			'account.close.unarchive_succes' => 'Conto riaperto con successo',
			'account.select.one' => 'Seleziona un conto',
			'account.select.all' => 'Tutti i conti',
			'account.select.multiple' => 'Seleziona conti',
			'currencies.currency_converter' => 'Convertitore di valuta',
			'currencies.currency' => 'Valuta',
			'currencies.currency_settings' => 'Impostazioni valuta',
			'currencies.currency_manager' => 'Gestore valute',
			'currencies.currency_manager_descr' => 'Configura la tua valuta e i suoi tassi di cambio con altre',
			'currencies.preferred_currency' => 'Valuta preferita/base',
			'currencies.tap_to_change_preferred_currency' => 'Tocca per modificare',
			'currencies.change_preferred_currency_title' => 'Cambia valuta preferita',
			'currencies.change_preferred_currency_msg' => 'Tutte le statistiche e i budget saranno visualizzati in questa valuta d\'ora in poi. Conti e transazioni manterranno la valuta che avevano. Tutti i tassi di cambio salvati verranno eliminati se esegui questa azione. Desideri continuare?',
			'currencies.exchange_rate_form.equal_to_preferred_warn' => 'La valuta non può essere uguale alla valuta dell\'utente',
			'currencies.exchange_rate_form.override_existing_warn' => 'Esiste già un tasso di cambio per questa valuta in questa data. Se continui, quello precedente verrà sovrascritto',
			'currencies.exchange_rate_form.specify_a_currency' => 'Per favore specifica una valuta',
			'currencies.exchange_rate_form.add' => 'Aggiungi tasso di cambio',
			'currencies.exchange_rate_form.add_success' => 'Tasso di cambio aggiunto con successo',
			'currencies.exchange_rate_form.edit' => 'Modifica tasso di cambio',
			'currencies.exchange_rate_form.edit_success' => 'Tasso di cambio modificato con successo',
			'currencies.exchange_rate_form.remove_all' => 'Elimina tutti i tassi di cambio',
			'currencies.exchange_rate_form.remove_all_warning' => 'Questa azione è irreversibile e cancellerà tutti i tassi di cambio per questa valuta',
			'currencies.types.display' => 'Tipo di valuta',
			'currencies.types.fiat' => 'FIAT',
			'currencies.types.crypto' => 'Criptovaluta',
			'currencies.types.other' => 'Altro',
			'currencies.currency_form.name' => 'Nome da visualizzare',
			'currencies.currency_form.code' => 'Codice valuta',
			'currencies.currency_form.symbol' => 'Simbolo',
			'currencies.currency_form.decimal_digits' => 'Cifre decimali',
			'currencies.currency_form.create' => 'Crea valuta',
			'currencies.currency_form.create_success' => 'Valuta creata con successo',
			'currencies.currency_form.edit' => 'Modifica valuta',
			'currencies.currency_form.edit_success' => 'Valuta modificata correttamente',
			'currencies.currency_form.delete' => 'Elimina valuta',
			'currencies.currency_form.delete_success' => 'Valuta eliminata correttamente',
			'currencies.currency_form.already_exists' => 'Esiste già una valuta con questo codice. Potresti volerlo modificare',
			'currencies.delete_all_success' => 'Tassi di cambio eliminati con successo',
			'currencies.historical' => 'Tassi storici',
			'currencies.historical_empty' => 'Nessun tasso di cambio storico trovato per questa valuta',
			'currencies.exchange_rate' => 'Tasso di cambio',
			'currencies.exchange_rates' => 'Tassi di cambio',
			'currencies.min_exchange_rate' => 'Tasso di cambio minimo',
			'currencies.max_exchange_rate' => 'Tasso di cambio massimo',
			'currencies.empty' => 'Aggiungi tassi di cambio qui in modo che se hai conti in valute diverse dalla tua valuta base i nostri grafici siano più accurati',
			'currencies.select_a_currency' => 'Seleziona una valuta',
			'currencies.search' => 'Cerca per nome o per codice valuta',
			'tags.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Etichetta', other: 'Etichette', ), 
			'tags.form.name' => 'Nome etichetta',
			'tags.form.description' => 'Descrizione',
			'tags.select.title' => 'Seleziona etichette',
			'tags.select.all' => 'Tutte le etichette',
			'tags.empty_list' => 'Non hai ancora creato alcuna etichetta. Etichette e categorie sono un ottimo modo per categorizzare i tuoi movimenti',
			'tags.without_tags' => 'Senza etichette',
			'tags.add' => 'Aggiungi etichetta',
			'tags.create' => 'Crea etichetta',
			'tags.create_success' => 'Etichetta creata con successo',
			'tags.already_exists' => 'Questo nome di etichetta esiste già. Potresti volerla modificare',
			'tags.edit' => 'Modifica etichetta',
			'tags.edit_success' => 'Etichetta modificata con successo',
			'tags.delete_success' => 'Categoria eliminata con successo',
			'tags.delete_warning_header' => 'Eliminare etichetta?',
			'tags.delete_warning_message' => 'Questa azione non eliminerà le transazioni che hanno questa etichetta.',
			'categories.unknown' => 'Categoria sconosciuta',
			'categories.create' => 'Crea categoria',
			'categories.create_success' => 'Categoria creata correttamente',
			'categories.new_category' => 'Nuova categoria',
			'categories.already_exists' => 'Il nome di questa categoria esiste già. Magari vuoi modificarla',
			'categories.edit' => 'Modifica categoria',
			'categories.edit_success' => 'Categoria modificata correttamente',
			'categories.name' => 'Nome categoria',
			'categories.type' => 'Tipo di categoria',
			'categories.both_types' => 'Entrambi i tipi',
			'categories.subcategories' => 'Sottocategorie',
			'categories.subcategories_add' => 'Aggiungi sottocategoria',
			'categories.make_parent' => 'Rendi categoria',
			'categories.make_child' => 'Rendi una sottocategoria',
			'categories.make_child_warning1' => ({required Object destiny}) => 'Questa categoria e le sue sottocategorie diventeranno sottocategorie di <b>${destiny}</b>.',
			'categories.make_child_warning2' => ({required Object x, required Object destiny}) => 'Le loro transazioni <b>(${x})</b> saranno spostate nelle nuove sottocategorie create all\'interno della categoria <b>${destiny}</b>.',
			'categories.make_child_success' => 'Sottocategorie create con successo',
			'categories.merge' => 'Unisci con un\'altra categoria',
			'categories.merge_warning1' => ({required Object x, required Object from, required Object destiny}) => 'Tutte le transazioni (${x}) associate alla categoria <b>${from}</b> verranno spostate nella categoria <b>${destiny}</b>',
			'categories.merge_warning2' => ({required Object from}) => 'La categoria <b>${from}</b> verrà eliminata irreversibilmente.',
			'categories.merge_success' => 'Categoria unita con successo',
			'categories.delete_success' => 'Categoria eliminata correttamente',
			'categories.delete_warning_header' => 'Eliminare categoria?',
			'categories.delete_warning_message' => ({required Object x}) => 'Questa azione eliminerà irreversibilmente tutte le transazioni <b>(${x})</b> relative a questa categoria.',
			'categories.select.title' => 'Seleziona categorie',
			'categories.select.select_one' => 'Seleziona una categoria',
			'categories.select.select_subcategory' => 'Scegli una sottocategoria',
			'categories.select.without_subcategory' => 'Senza sottocategoria',
			'categories.select.all' => 'Tutte le categorie',
			'categories.select.all_short' => 'Tutte',
			'budgets.title' => 'Budget',
			'budgets.status' => 'Stato del bilancio',
			'budgets.repeated' => 'Ricorrente',
			'budgets.one_time' => 'Una tantum',
			'budgets.actives' => 'Attivi',
			'budgets.from_budgeted' => 'rimanenti di ',
			'budgets.days_left' => 'giorni rimasti',
			'budgets.days_to_start' => 'giorni all\'inizio',
			'budgets.since_expiration' => 'giorni dalla scadenza',
			'budgets.no_budgets' => 'Sembra che non ci siano budget da visualizzare in questa sezione. Inizia creando un budget cliccando sul pulsante in basso',
			'budgets.delete' => 'Elimina budget',
			'budgets.delete_warning' => 'Questa azione è irreversibile. Categorie e transazioni relative a questa quotazione non verranno eliminate',
			'budgets.form.title' => 'Aggiungi un budget',
			'budgets.form.name' => 'Nome budget',
			'budgets.form.value' => 'Quantità limite',
			'budgets.form.create' => 'Aggiungi budget',
			'budgets.form.create_success' => 'Budget creato correttamente',
			'budgets.form.edit' => 'Modifica budget',
			'budgets.form.edit_success' => 'Budget modificato correttamente',
			'budgets.form.negative_warn' => 'I budget non possono avere un importo negativo',
			'budgets.details.title' => 'Dettagli budget',
			'budgets.details.statistics' => 'Statistiche',
			'budgets.details.budget_value' => 'A budget',
			'budgets.details.expend_evolution' => 'Evoluzione della spesa',
			'budgets.details.no_transactions' => 'Sembra che tu non abbia effettuato spese relative a questo budget',
			'budgets.target_timeline_statuses.active' => 'Budget attivo',
			'budgets.target_timeline_statuses.past' => 'Budget terminato',
			'budgets.target_timeline_statuses.future' => 'Budget futuro',
			'budgets.progress.labels.active_on_track' => 'In linea',
			'budgets.progress.labels.active_overspending' => 'Spesa eccessiva',
			'budgets.progress.labels.active_indeterminate' => 'Attivo',
			'budgets.progress.labels.success' => 'Raggiunto',
			'budgets.progress.labels.fail' => 'Budget superato',
			'budgets.progress.description.active_on_track' => ({required Object dailyAmount, required Object remainingDays}) => 'Puoi spendere ${dailyAmount} al giorno per i restanti ${remainingDays} giorni',
			'budgets.progress.description.active_overspending' => ({required Object dailyAmount, required Object remainingDays}) => 'Per tornare in linea, dovresti limitare la tua spesa a ${dailyAmount} al giorno per i restanti ${remainingDays} giorni',
			'budgets.progress.description.active_indeterminate' => ({required Object amount}) => 'Ti restano ${amount} da spendere.',
			'budgets.progress.description.active_exceeded' => ({required Object amount}) => 'Hai già superato il limite del budget di ${amount}. Se non trovi entrate per questo budget, dovresti smettere di spendere per il resto del periodo',
			'budgets.progress.description.success' => 'Ottimo lavoro! Questo budget è terminato con successo. Continua a creare budget per gestire le tue spese',
			'budgets.progress.description.fail' => ({required Object amount}) => 'Hai superato il budget di ${amount}. Cerca di fare più attenzione la prossima volta!',
			'goals.title' => 'Obiettivi',
			'goals.status' => 'Stato dell\'obiettivo',
			'goals.type.display' => 'Tipo di obiettivo',
			'goals.type.income.title' => 'Obiettivo di Risparmio',
			'goals.type.income.descr' => 'Ideale per risparmiare denaro. Hai successo quando il saldo supera il tuo obiettivo.',
			'goals.type.expense.title' => 'Obiettivo di Spesa',
			'goals.type.expense.descr' => 'Traccia quanto spendi e mira a raggiungere un importo obiettivo. Funziona bene per donazioni...',
			'goals.empty_title' => 'Nessun obiettivo trovato',
			'goals.empty_description' => 'Crea un nuovo obiettivo per iniziare a monitorare i tuoi risparmi!',
			'goals.delete' => 'Elimina obiettivo',
			'goals.delete_warning' => 'Questa azione è irreversibile. Le categorie e le transazioni riferite a questo obiettivo non verranno eliminate',
			'goals.form.new_title' => 'Nuovo obiettivo',
			'goals.form.edit_title' => 'Modifica obiettivo',
			'goals.form.target_amount' => 'Importo obiettivo',
			'goals.form.initial_amount' => 'Importo iniziale',
			_ => null,
		} ?? switch (path) {
			'goals.form.name' => 'Nome',
			'goals.form.name_hint' => 'Il mio obiettivo di risparmio',
			'goals.form.create_success' => 'Obiettivo creato con successo',
			'goals.form.edit_success' => 'Obiettivo modificato con successo',
			'goals.form.negative_warn' => 'L\'importo dell\'obiettivo non può essere negativo',
			'goals.details.title' => 'Dettagli obiettivo',
			'goals.details.statistics' => 'Statistiche',
			'goals.details.goal_value' => 'Valore obiettivo',
			'goals.details.evolution' => 'Evoluzione',
			'goals.details.no_transactions' => 'Sembra che tu non abbia effettuato alcuna transazione relativa a questo obiettivo',
			'goals.target_timeline_statuses.active' => 'Obiettivo attivo',
			'goals.target_timeline_statuses.past' => 'Obiettivo terminato',
			'goals.target_timeline_statuses.future' => 'Obiettivo futuro',
			'goals.progress.labels.active_on_track' => 'In pista',
			'goals.progress.labels.active_behind_schedule' => 'In ritardo rispetto al programma',
			'goals.progress.labels.active_indeterminate' => 'Attivo',
			'goals.progress.labels.success' => 'Obiettivo raggiunto',
			'goals.progress.labels.fail' => 'Obiettivo fallito',
			'goals.progress.description.active_on_track' => ({required Object dailyAmount, required Object remainingDays}) => 'Sei sulla buona strada per raggiungere il tuo obiettivo! Devi risparmiare ${dailyAmount} al giorno per i restanti ${remainingDays} giorni',
			'goals.progress.description.active_behind_schedule' => ({required Object dailyAmount, required Object remainingDays}) => 'Sei in ritardo sulla tabella di marcia. Devi risparmiare ${dailyAmount} al giorno per raggiungere il tuo obiettivo in ${remainingDays} giorni',
			'goals.progress.description.active_indeterminate' => ({required Object amount}) => 'Ti servono ${amount} in più per raggiungere il tuo obiettivo.',
			'goals.progress.description.success' => 'Congratulazioni! Hai raggiunto il tuo obiettivo.',
			'goals.progress.description.fail' => ({required Object amount}) => 'Hai mancato il tuo obiettivo di ${amount}.',
			'target_timeline_statuses.active' => 'Attivo',
			'target_timeline_statuses.past' => 'Terminato',
			'target_timeline_statuses.future' => 'Futuro',
			'backup.no_file_selected' => 'Nessun file selezionato',
			'backup.no_directory_selected' => 'Nessuna directory selezionata',
			'backup.export.title' => 'Esporta i tuoi dati',
			'backup.export.title_short' => 'Esporta',
			'backup.export.type_of_export' => 'Tipo di esportazione',
			'backup.export.other_options' => 'Opzioni',
			'backup.export.all' => 'Backup completo',
			'backup.export.all_descr' => 'Esporta tutti i tuoi dati (conti, transazioni, budget, impostazioni...). Importali di nuovo in qualsiasi momento per non perdere nulla.',
			'backup.export.transactions' => 'Backup transazioni',
			'backup.export.transactions_descr' => 'Esporta le tue transazioni in CSV in modo da poterle analizzare più facilmente in altri programmi o applicazioni.',
			'backup.export.transactions_to_export' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '1 transazione da esportare', other: '${n} transazioni da esportare', ), 
			'backup.export.description' => 'Scarica i tuoi dati in diversi formati',
			'backup.export.send_file' => 'Invia file',
			'backup.export.see_folder' => 'Vedi cartella',
			'backup.export.success' => ({required Object x}) => 'File salvato/scaricato con successo in ${x}',
			'backup.export.error' => 'Errore durante il download del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com',
			'backup.export.dialog_title' => 'Salva/Invia file',
			'backup.import.title' => 'Importa i tuoi dati',
			'backup.import.title_short' => 'Importa',
			'backup.import.restore_backup' => 'Ripristina backup',
			'backup.import.restore_backup_descr' => 'Importa un database precedentemente salvato da Monekin. Questa azione sostituirà tutti i dati attuali dell\'applicazione con i nuovi dati',
			'backup.import.restore_backup_warn_description' => 'Importando un nuovo database, perderai tutti i dati attualmente salvati nell\'app. Si consiglia di effettuare un backup prima di continuare. Non caricare qui alcun file la cui origine non conosci, carica solo file che hai precedentemente scaricato da Monekin',
			'backup.import.restore_backup_warn_title' => 'Sovrascrivi tutti i dati',
			'backup.import.select_other_file' => 'Seleziona un altro file',
			'backup.import.tap_to_select_file' => 'Tocca per selezionare un file',
			'backup.import.manual_import.title' => 'Importazione manuale',
			'backup.import.manual_import.descr' => 'Importa manualmente le transazioni da un file .csv',
			'backup.import.manual_import.default_account' => 'Conto predefinito',
			'backup.import.manual_import.remove_default_account' => 'Rimuovi conto predefinito',
			'backup.import.manual_import.default_category' => 'Categoria predefinita',
			'backup.import.manual_import.select_a_column' => 'Seleziona una colonna dal .csv',
			'backup.import.manual_import.steps.0' => 'Seleziona il tuo file',
			'backup.import.manual_import.steps.1' => 'Colonna per la quantità',
			'backup.import.manual_import.steps.2' => 'Colonna per il conto',
			'backup.import.manual_import.steps.3' => 'Colonna per la categoria',
			'backup.import.manual_import.steps.4' => 'Colonna per la data',
			'backup.import.manual_import.steps.5' => 'altre colonne',
			'backup.import.manual_import.steps_descr.0' => 'Seleziona un file .csv dal tuo dispositivo. Assicurati che abbia una prima riga che descriva il nome di ciascuna colonna',
			'backup.import.manual_import.steps_descr.1' => 'Seleziona la colonna in cui è specificato il valore di ogni transazione. Usa valori negativi per le spese e valori positivi per le entrate.',
			'backup.import.manual_import.steps_descr.2' => 'Seleziona la colonna in cui è specificato il conto a cui appartiene ogni transazione. Puoi anche selezionare un conto predefinito nel caso in cui non riusciamo a trovare il conto che desideri. Se non viene specificato un conto predefinito, ne creeremo uno con lo stesso nome',
			'backup.import.manual_import.steps_descr.3' => 'Specifica la colonna in cui si trova il nome della categoria della transazione. Devi specificare una categoria predefinita in modo da assegnare questa categoria alle transazioni, nel caso in cui la categoria non possa essere trovata',
			'backup.import.manual_import.steps_descr.4' => 'Seleziona la colonna in cui è specificata la data di ogni transazione. Se non specificato, le transazioni verranno create con la data attuale',
			'backup.import.manual_import.steps_descr.5' => 'Specifica le colonne per altri attributi opzionali della transazione',
			'backup.import.manual_import.success' => ({required Object x}) => '${x} transazioni importate con successo',
			'backup.import.success' => 'Importazione eseguita con successo',
			'backup.import.error' => 'Errore durante l\'importazione del file. Contatta lo sviluppatore tramite lozin.technologies@gmail.com',
			'backup.import.cancelled' => 'Importazione annullata dall\'utente',
			'backup.about.title' => 'Informazioni sul tuo database',
			'backup.about.create_date' => 'Data di creazione',
			'backup.about.modify_date' => 'Ultima modifica',
			'backup.about.last_backup' => 'Ultimo backup',
			'backup.about.size' => 'Dimensione',
			'settings.title_long' => 'Impostazioni e Personalizzazione',
			'settings.title_short' => 'Impostazioni',
			'settings.description' => 'Tema, Lingua, Dati e altro',
			'settings.edit_profile' => 'Modifica profilo',
			'settings.general.menu_title' => 'Impostazioni generali',
			'settings.general.menu_descr' => 'Lingua, privacy e altro',
			'settings.general.show_all_decimals' => 'Mostra tutti i decimali',
			'settings.general.show_all_decimals_descr' => 'Mostra tutti i decimali anche se sono zeri finali',
			'settings.general.language.section' => 'Lingua e testi',
			'settings.general.language.title' => 'Lingua dell\'app',
			'settings.general.language.descr' => 'Lingua in cui i testi verranno visualizzati nell\'app',
			'settings.general.language.help' => 'Se vuoi collaborare con le traduzioni di questa app, puoi consultare <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>la nostra guida</a>',
			'settings.general.locale.title' => 'Regione',
			'settings.general.locale.auto' => 'Sistema',
			'settings.general.locale.descr' => 'Imposta il formato da utilizzare per date, numeri...',
			'settings.general.locale.warn' => 'Quando cambi regione l\'app si aggiornerà',
			'settings.general.locale.first_day_of_week' => 'Primo giorno della settimana',
			'settings.security.title' => 'Sicurezza',
			'settings.security.private_mode_at_launch' => 'Modalità privata all\'avvio',
			'settings.security.private_mode_at_launch_descr' => 'Avvia l\'app in modalità privata per impostazione predefinita',
			'settings.security.private_mode' => 'Modalità privata',
			'settings.security.private_mode_descr' => 'Nascondi tutti i valori monetari',
			'settings.security.private_mode_activated' => 'Modalità privata attivata',
			'settings.security.private_mode_deactivated' => 'Modalità privata disattivata',
			'settings.transactions.menu_title' => 'Transazioni',
			'settings.transactions.menu_descr' => 'Configura il comportamento delle tue transazioni',
			'settings.transactions.title' => 'Impostazioni transazioni',
			'settings.transactions.style.title' => 'Stile transazione',
			'settings.transactions.style.subtitle' => 'Configura l\'aspetto delle transazioni nelle liste dell\'app',
			'settings.transactions.style.show_tags' => 'Mostra Tag',
			'settings.transactions.style.show_time' => 'Mostra Ora',
			'settings.transactions.swipe_actions.title' => 'Azioni di scorrimento',
			'settings.transactions.swipe_actions.choose_description' => 'Scegli quale azione verrà attivata quando fai scorrere un elemento di transazione nell\'elenco utilizzando questa direzione di scorrimento',
			'settings.transactions.swipe_actions.swipe_left' => 'Scorri verso sinistra',
			'settings.transactions.swipe_actions.swipe_right' => 'Scorri verso destra',
			'settings.transactions.swipe_actions.none' => 'Nessuna azione',
			'settings.transactions.swipe_actions.toggle_reconciled' => 'Attiva/disattiva riconciliato',
			'settings.transactions.swipe_actions.toggle_pending' => 'Attiva/disattiva in sospeso',
			'settings.transactions.swipe_actions.toggle_voided' => 'Attivazione/disattivazione annullata',
			'settings.transactions.swipe_actions.toggle_unreconciled' => 'Attiva/disattiva non riconciliato',
			'settings.transactions.swipe_actions.remove_status' => 'Rimuovi lo stato',
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
			'settings.appearance.menu_title' => 'Tema e stile',
			'settings.appearance.menu_descr' => 'Selezione del tema, colori e altre cose relative all\'aspetto dell\'app',
			'settings.appearance.theme_and_colors' => 'Tema e colori',
			'settings.appearance.theme.title' => 'Tema',
			'settings.appearance.theme.auto' => 'Sistema',
			'settings.appearance.theme.light' => 'Chiaro',
			'settings.appearance.theme.dark' => 'Scuro',
			'settings.appearance.amoled_mode' => 'Modalità AMOLED',
			'settings.appearance.amoled_mode_descr' => 'Usa uno sfondo nero puro quando possibile. Questo aiuterà leggermente la batteria dei dispositivi con schermi AMOLED',
			'settings.appearance.dynamic_colors' => 'Colori dinamici',
			'settings.appearance.dynamic_colors_descr' => 'Usa il colore di accento del tuo sistema quando possibile',
			'settings.appearance.accent_color' => 'Colore di accento',
			'settings.appearance.accent_color_descr' => 'Scegli il colore che l\'app utilizzerà per enfatizzare determinate parti dell\'interfaccia',
			'settings.appearance.text' => 'Testo',
			'settings.appearance.font' => 'Font',
			'settings.appearance.font_platform' => 'Piattaforma',
			'more.title' => 'Altro',
			'more.title_long' => 'Altre azioni',
			'more.data.display' => 'Dati',
			'more.data.display_descr' => 'Esporta e importa i tuoi dati per non perdere nulla',
			'more.data.delete_all' => 'Elimina i miei dati',
			'more.data.delete_all_header1' => 'Fermati subito padawan ⚠️⚠️',
			'more.data.delete_all_message1' => 'Sei sicuro di voler continuare? Tutti i tuoi dati verranno eliminati in modo permanente e non potranno essere recuperati',
			'more.data.delete_all_header2' => 'Un ultimo passo ⚠️⚠️',
			'more.data.delete_all_message2' => 'Eliminando un account eliminerai tutti i tuoi dati personali memorizzati. I tuoi conti, transazioni, budget e categorie verranno eliminati e non potranno essere recuperati. Sei d\'accordo?',
			'more.about_us.display' => 'Informazioni sull\'app',
			'more.about_us.description' => 'Trova i termini di Monekin, informazioni importanti e connettiti segnalando bug o condividendo idee',
			'more.about_us.legal.display' => 'Informazioni legali',
			'more.about_us.legal.privacy' => 'Informativa sulla privacy',
			'more.about_us.legal.terms' => 'Termini di utilizzo',
			'more.about_us.legal.licenses' => 'Licenze',
			'more.about_us.project.display' => 'Progetto',
			'more.about_us.project.contributors' => 'Collaboratori',
			'more.about_us.project.contributors_descr' => 'Tutti gli sviluppatori che hanno fatto crescere Monekin',
			'more.about_us.project.contact' => 'Contattaci',
			'more.help_us.display' => 'Aiutaci',
			'more.help_us.description' => 'Scopri come puoi aiutare Monekin a migliorare sempre di più',
			'more.help_us.rate_us' => 'Valutaci',
			'more.help_us.rate_us_descr' => 'Ogni valutazione è benvenuta!',
			'more.help_us.share' => 'Condividi Monekin',
			'more.help_us.share_descr' => 'Condividi la nostra app con amici e famiglia',
			'more.help_us.share_text' => 'Monekin! La migliore app di finanza personale. Scaricala qui',
			'more.help_us.thanks' => 'Grazie!',
			'more.help_us.thanks_long' => 'I tuoi contributi a Monekin e ad altri progetti open source, grandi e piccoli, rendono possibili grandi progetti come questo. Grazie per aver dedicato tempo a contribuire.',
			'more.help_us.donate' => 'Fai una donazione',
			'more.help_us.donate_descr' => 'Con la tua donazione aiuterai l\'app a continuare a ricevere miglioramenti. Quale modo migliore per ringraziare il lavoro svolto se non invitandomi per un caffè?',
			'more.help_us.donate_success' => 'Donazione effettuata. Grazie mille per il tuo contributo! ❤️',
			'more.help_us.donate_err' => 'Oops! Sembra che ci sia stato un errore nel ricevere il tuo pagamento',
			'more.help_us.report' => 'Segnala bug, lascia suggerimenti...',
			_ => null,
		};
	}
}

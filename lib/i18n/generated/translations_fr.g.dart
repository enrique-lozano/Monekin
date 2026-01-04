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
class TranslationsFr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsFr ui_actions = _TranslationsUiActionsFr._(_root);
	@override late final _TranslationsGeneralFr general = _TranslationsGeneralFr._(_root);
	@override late final _TranslationsIntroFr intro = _TranslationsIntroFr._(_root);
	@override late final _TranslationsHomeFr home = _TranslationsHomeFr._(_root);
	@override late final _TranslationsFinancialHealthFr financial_health = _TranslationsFinancialHealthFr._(_root);
	@override late final _TranslationsStatsFr stats = _TranslationsStatsFr._(_root);
	@override late final _TranslationsIconSelectorFr icon_selector = _TranslationsIconSelectorFr._(_root);
	@override late final _TranslationsTransactionFr transaction = _TranslationsTransactionFr._(_root);
	@override late final _TranslationsTransferFr transfer = _TranslationsTransferFr._(_root);
	@override late final _TranslationsRecurrentTransactionsFr recurrent_transactions = _TranslationsRecurrentTransactionsFr._(_root);
	@override late final _TranslationsAccountFr account = _TranslationsAccountFr._(_root);
	@override late final _TranslationsCurrenciesFr currencies = _TranslationsCurrenciesFr._(_root);
	@override late final _TranslationsTagsFr tags = _TranslationsTagsFr._(_root);
	@override late final _TranslationsCategoriesFr categories = _TranslationsCategoriesFr._(_root);
	@override late final _TranslationsBudgetsFr budgets = _TranslationsBudgetsFr._(_root);
	@override late final _TranslationsTargetTimelineStatusesFr target_timeline_statuses = _TranslationsTargetTimelineStatusesFr._(_root);
	@override late final _TranslationsBackupFr backup = _TranslationsBackupFr._(_root);
	@override late final _TranslationsSettingsFr settings = _TranslationsSettingsFr._(_root);
	@override late final _TranslationsMoreFr more = _TranslationsMoreFr._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsFr implements TranslationsUiActionsEn {
	_TranslationsUiActionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuler';
	@override String get confirm => 'Confirmer';
	@override String get continue_text => 'Continuer';
	@override String get save => 'Enregistrer';
	@override String get save_changes => 'Enregistrer les modifications';
	@override String get close_and_save => 'Enregistrer et fermer';
	@override String get add => 'Ajouter';
	@override String get edit => 'Modifier';
	@override String get delete => 'Supprimer';
	@override String get see_more => 'Voir plus';
	@override String get select_all => 'Tout sélectionner';
	@override String get deselect_all => 'Tout désélectionner';
	@override String get select => 'Sélectionner';
	@override String get search => 'Rechercher';
	@override String get filter => 'Filtrer';
	@override String get reset => 'Réinitialiser';
	@override String get submit => 'Valider';
	@override String get next => 'Suivant';
	@override String get previous => 'Précédent';
	@override String get back => 'Retour';
	@override String get reload => 'Recharger';
	@override String get view => 'Voir';
	@override String get download => 'Télécharger';
	@override String get upload => 'Téléverser';
	@override String get retry => 'Réessayer';
	@override String get copy => 'Copier';
	@override String get paste => 'Coller';
	@override String get undo => 'Annuler';
	@override String get redo => 'Rétablir';
	@override String get open => 'Ouvrir';
	@override String get close => 'Fermer';
	@override String get apply => 'Appliquer';
	@override String get discard => 'Abandonner';
	@override String get refresh => 'Actualiser';
	@override String get share => 'Partager';
}

// Path: general
class _TranslationsGeneralFr implements TranslationsGeneralEn {
	_TranslationsGeneralFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get or => 'ou';
	@override String get understood => 'Compris';
	@override String get unspecified => 'Non spécifié';
	@override String get quick_actions => 'Actions rapides';
	@override String get details => 'Détails';
	@override String get balance => 'Solde';
	@override String get account => 'Compte';
	@override String get accounts => 'Comptes';
	@override String get categories => 'Catégories';
	@override String get category => 'Catégorie';
	@override String get today => 'Aujourd\'hui';
	@override String get yesterday => 'Hier';
	@override String get filters => 'Filtres';
	@override String get empty_warn => 'Oups ! C\'est très vide';
	@override String get search_no_results => 'Aucun élément ne correspond à vos critères de recherche';
	@override String get insufficient_data => 'Données insuffisantes';
	@override String get show_more_fields => 'Afficher plus de champs';
	@override String get show_less_fields => 'Afficher moins de champs';
	@override String get tap_to_search => 'Touchez pour rechercher';
	@override late final _TranslationsGeneralLeaveWithoutSavingFr leave_without_saving = _TranslationsGeneralLeaveWithoutSavingFr._(_root);
	@override late final _TranslationsGeneralClipboardFr clipboard = _TranslationsGeneralClipboardFr._(_root);
	@override late final _TranslationsGeneralTimeFr time = _TranslationsGeneralTimeFr._(_root);
	@override late final _TranslationsGeneralTransactionOrderFr transaction_order = _TranslationsGeneralTransactionOrderFr._(_root);
	@override late final _TranslationsGeneralValidationsFr validations = _TranslationsGeneralValidationsFr._(_root);
}

// Path: intro
class _TranslationsIntroFr implements TranslationsIntroEn {
	_TranslationsIntroFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get start => 'Commencer';
	@override String get skip => 'Ignorer';
	@override String get next => 'Suivant';
	@override String get select_your_currency => 'Sélectionnez votre devise';
	@override String get welcome_subtitle => 'Votre gestionnaire de finances personnelles';
	@override String get welcome_subtitle2 => '100 % open, 100 % gratuit';
	@override String get welcome_footer => 'En vous connectant, vous acceptez la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>politique de confidentialité</a> et les <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>conditions d\'utilisation</a> de l\'application';
	@override String get offline_descr_title => 'COMPTE HORS LIGNE :';
	@override String get offline_descr => 'Vos données ne seront stockées que sur votre appareil, et seront en sécurité tant que vous ne désinstallez pas l\'application ou ne changez pas de téléphone. Pour éviter toute perte de données, il est recommandé de réaliser régulièrement une sauvegarde depuis les paramètres de l\'application.';
	@override String get offline_start => 'Démarrer une session hors ligne';
	@override String get sl1_title => 'Choisissez votre devise';
	@override String get sl1_descr => 'Votre devise par défaut sera utilisée dans les rapports et graphiques généraux. Vous pourrez changer la devise et la langue de l\'application plus tard à tout moment dans les paramètres.';
	@override String get sl2_title => 'Sûr, privé et fiable';
	@override String get sl2_descr => 'Vos données n\'appartiennent qu\'à vous. Nous stockons les informations directement sur votre appareil, sans passer par des serveurs externes. Cela permet d\'utiliser l\'application même sans Internet.';
	@override String get sl2_descr2 => 'De plus, le code source de l\'application est public ; tout le monde peut y collaborer et voir comment elle fonctionne.';
	@override String get last_slide_title => 'Tout est prêt';
	@override String get last_slide_descr => 'Avec Monekin, vous pouvez enfin atteindre l\'indépendance financière que vous désirez tant. Vous disposerez de graphiques, budgets, conseils, statistiques et bien plus encore sur votre argent.';
	@override String get last_slide_descr2 => 'Nous espérons que vous apprécierez votre expérience ! N\'hésitez pas à nous contacter en cas de doutes, de suggestions...';
}

// Path: home
class _TranslationsHomeFr implements TranslationsHomeEn {
	_TranslationsHomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tableau de bord';
	@override String get filter_transactions => 'Filtrer les transactions';
	@override String get hello_day => 'Bonjour,';
	@override String get hello_night => 'Bonsoir,';
	@override String get total_balance => 'Solde total';
	@override String get my_accounts => 'Mes comptes';
	@override String get active_accounts => 'Comptes actifs';
	@override String get no_accounts => 'Aucun compte créé pour le moment';
	@override String get no_accounts_descr => 'Commencez à profiter de toute la magie de Monekin. Créez au moins un compte pour commencer à ajouter des transactions.';
	@override String get last_transactions => 'Dernières transactions';
	@override String get should_create_account_header => 'Oups !';
	@override String get should_create_account_message => 'Vous devez avoir au moins un compte non archivé avant de pouvoir créer des transactions';
}

// Path: financial_health
class _TranslationsFinancialHealthFr implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Santé financière';
	@override late final _TranslationsFinancialHealthReviewFr review = _TranslationsFinancialHealthReviewFr._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeFr months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeFr._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageFr savings_percentage = _TranslationsFinancialHealthSavingsPercentageFr._(_root);
}

// Path: stats
class _TranslationsStatsFr implements TranslationsStatsEn {
	_TranslationsStatsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiques';
	@override String get balance => 'Solde';
	@override String get final_balance => 'Solde final';
	@override String get balance_by_account => 'Solde par compte';
	@override String get balance_by_account_subtitle => 'Où ai-je le plus d\'argent ?';
	@override String get balance_by_currency => 'Solde par devise';
	@override String get balance_by_currency_subtitle => 'Combien d\'argent ai-je en devise étrangère ?';
	@override String get balance_evolution => 'Évolution du solde';
	@override String get balance_evolution_subtitle => 'Ai-je plus d\'argent qu\'avant ?';
	@override String get compared_to_previous_period => 'Par rapport à la période précédente';
	@override String get cash_flow => 'Flux de trésorerie';
	@override String get cash_flow_subtitle => 'Est-ce que je dépense moins que ce que je gagne ?';
	@override String get by_periods => 'Par périodes';
	@override String get by_categories => 'Par catégories';
	@override String get by_tags => 'Par tags';
	@override String get distribution => 'Répartition';
	@override String get finance_health_resume => 'Résumé';
	@override String get finance_health_breakdown => 'Détail';
}

// Path: icon_selector
class _TranslationsIconSelectorFr implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom :';
	@override String get icon => 'Icône';
	@override String get color => 'Couleur';
	@override String get select_icon => 'Sélectionner une icône';
	@override String get select_color => 'Sélectionner une couleur';
	@override String get custom_color => 'Couleur personnalisée';
	@override String get current_color_selection => 'Sélection actuelle';
	@override String get select_account_icon => 'Identifiez votre compte';
	@override String get select_category_icon => 'Identifiez votre catégorie';
	@override late final _TranslationsIconSelectorScopesFr scopes = _TranslationsIconSelectorScopesFr._(_root);
}

// Path: transaction
class _TranslationsTransactionFr implements TranslationsTransactionEn {
	_TranslationsTransactionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Transaction',
		other: 'Transactions',
	);
	@override String get create => 'Nouvelle transaction';
	@override String get new_income => 'Nouvelle recette';
	@override String get new_expense => 'Nouvelle dépense';
	@override String get new_success => 'Transaction créée avec succès';
	@override String get edit => 'Modifier la transaction';
	@override String get edit_success => 'Transaction modifiée avec succès';
	@override String get edit_multiple => 'Modifier des transactions';
	@override String edit_multiple_success({required Object x}) => '${x} transactions modifiées avec succès';
	@override String get duplicate => 'Cloner la transaction';
	@override String get duplicate_short => 'Cloner';
	@override String get duplicate_warning_message => 'Une transaction identique à celle-ci sera créée avec la même date, voulez-vous continuer ?';
	@override String get duplicate_success => 'Transaction clonée avec succès';
	@override String get delete => 'Supprimer la transaction';
	@override String get delete_warning_message => 'Cette action est irréversible. Le solde actuel de vos comptes et toutes vos statistiques seront recalculés';
	@override String get delete_success => 'Transaction supprimée avec succès';
	@override String get delete_multiple => 'Supprimer des transactions';
	@override String delete_multiple_warning_message({required Object x}) => 'Cette action est irréversible et supprimera ${x} transactions. Le solde actuel de vos comptes et toutes vos statistiques seront recalculés';
	@override String delete_multiple_success({required Object x}) => '${x} transactions supprimées avec succès';
	@override String get details => 'Détails du mouvement';
	@override late final _TranslationsTransactionNextPaymentsFr next_payments = _TranslationsTransactionNextPaymentsFr._(_root);
	@override late final _TranslationsTransactionListFr list = _TranslationsTransactionListFr._(_root);
	@override late final _TranslationsTransactionFiltersFr filters = _TranslationsTransactionFiltersFr._(_root);
	@override late final _TranslationsTransactionFormFr form = _TranslationsTransactionFormFr._(_root);
	@override late final _TranslationsTransactionReversedFr reversed = _TranslationsTransactionReversedFr._(_root);
	@override late final _TranslationsTransactionStatusFr status = _TranslationsTransactionStatusFr._(_root);
	@override late final _TranslationsTransactionTypesFr types = _TranslationsTransactionTypesFr._(_root);
}

// Path: transfer
class _TranslationsTransferFr implements TranslationsTransferEn {
	_TranslationsTransferFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Virement';
	@override String get transfers => 'Virements';
	@override String transfer_to({required Object account}) => 'Virement vers ${account}';
	@override String get create => 'Nouveau virement';
	@override String get need_two_accounts_warning_header => 'Oups !';
	@override String get need_two_accounts_warning_message => 'Au moins deux comptes sont nécessaires pour effectuer cette action. Si vous devez ajuster ou modifier le solde actuel de ce compte, cliquez sur le bouton de modification';
	@override late final _TranslationsTransferFormFr form = _TranslationsTransferFormFr._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsFr implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transactions récurrentes';
	@override String get title_short => 'Trans. récurrentes';
	@override String get empty => 'Il semble que vous n\'ayez pas de transactions récurrentes. Créez une transaction récurrente mensuelle, annuelle ou hebdomadaire et elle apparaîtra ici';
	@override String get total_expense_title => 'Dépense totale par période';
	@override String get total_expense_descr => '* Sans tenir compte de la date de début et de fin de chaque récurrence';
	@override late final _TranslationsRecurrentTransactionsDetailsFr details = _TranslationsRecurrentTransactionsDetailsFr._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusFr status = _TranslationsRecurrentTransactionsStatusFr._(_root);
}

// Path: account
class _TranslationsAccountFr implements TranslationsAccountEn {
	_TranslationsAccountFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get details => 'Détails du compte';
	@override String get date => 'Date d\'ouverture';
	@override String get close_date => 'Date de clôture';
	@override String get reopen => 'Rouvrir le compte';
	@override String get reopen_short => 'Rouvrir';
	@override String get reopen_descr => 'Êtes-vous sûr de vouloir rouvrir ce compte ?';
	@override String get balance => 'Solde du compte';
	@override String get n_transactions => 'Nombre de transactions';
	@override String get add_money => 'Ajouter de l\'argent';
	@override String get withdraw_money => 'Retirer de l\'argent';
	@override String get no_accounts => 'Aucun compte trouvé à afficher ici. Ajoutez un compte en cliquant sur le bouton « + » en bas';
	@override late final _TranslationsAccountTypesFr types = _TranslationsAccountTypesFr._(_root);
	@override late final _TranslationsAccountFormFr form = _TranslationsAccountFormFr._(_root);
	@override late final _TranslationsAccountDeleteFr delete = _TranslationsAccountDeleteFr._(_root);
	@override late final _TranslationsAccountCloseFr close = _TranslationsAccountCloseFr._(_root);
	@override late final _TranslationsAccountSelectFr select = _TranslationsAccountSelectFr._(_root);
}

// Path: currencies
class _TranslationsCurrenciesFr implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Convertisseur de devises';
	@override String get currency => 'Devise';
	@override String get currency_settings => 'Paramètres de devise';
	@override String get currency_manager => 'Gestionnaire de devises';
	@override String get currency_manager_descr => 'Configurez votre devise et ses taux de change avec les autres';
	@override String get preferred_currency => 'Devise de base/préférée';
	@override String get tap_to_change_preferred_currency => 'Appuyez pour modifier';
	@override String get change_preferred_currency_title => 'Changer la devise préférée';
	@override String get change_preferred_currency_msg => 'Toutes les statistiques et budgets seront affichés dans cette devise à partir de maintenant. Les comptes et transactions conserveront la devise qu\'ils avaient. Tous les taux de change enregistrés seront supprimés si vous effectuez cette action. Voulez-vous continuer ?';
	@override late final _TranslationsCurrenciesExchangeRateFormFr exchange_rate_form = _TranslationsCurrenciesExchangeRateFormFr._(_root);
	@override late final _TranslationsCurrenciesTypesFr types = _TranslationsCurrenciesTypesFr._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormFr currency_form = _TranslationsCurrenciesCurrencyFormFr._(_root);
	@override String get delete_all_success => 'Taux de change supprimés avec succès';
	@override String get historical => 'Taux historiques';
	@override String get historical_empty => 'Aucun taux de change historique trouvé pour cette devise';
	@override String get exchange_rate => 'Taux de change';
	@override String get exchange_rates => 'Taux de change';
	@override String get min_exchange_rate => 'Taux de change minimum';
	@override String get max_exchange_rate => 'Taux de change maximum';
	@override String get empty => 'Ajoutez ici des taux de change pour que, si vous avez des comptes dans d\'autres devises que votre devise de base, nos graphiques soient plus précis';
	@override String get select_a_currency => 'Sélectionnez une devise';
	@override String get search => 'Rechercher par nom ou par code de devise';
}

// Path: tags
class _TranslationsTagsFr implements TranslationsTagsEn {
	_TranslationsTagsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Tag',
		other: 'Tags',
	);
	@override late final _TranslationsTagsFormFr form = _TranslationsTagsFormFr._(_root);
	@override late final _TranslationsTagsSelectFr select = _TranslationsTagsSelectFr._(_root);
	@override String get empty_list => 'Vous n\'avez encore créé aucun tag. Les tags et catégories sont un excellent moyen de catégoriser vos mouvements';
	@override String get without_tags => 'Sans tag';
	@override String get add => 'Ajouter un tag';
	@override String get create => 'Créer une étiquette';
	@override String get create_success => 'Étiquette créée avec succès';
	@override String get already_exists => 'Ce nom de tag existe déjà. Vous voulez peut-être le modifier';
	@override String get edit => 'Modifier le tag';
	@override String get edit_success => 'Tag modifié avec succès';
	@override String get delete_success => 'Tag supprimé avec succès';
	@override String get delete_warning_header => 'Supprimer le tag ?';
	@override String get delete_warning_message => 'Cette action ne supprimera pas les transactions qui ont ce tag.';
}

// Path: categories
class _TranslationsCategoriesFr implements TranslationsCategoriesEn {
	_TranslationsCategoriesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Catégorie inconnue';
	@override String get create => 'Créer une catégorie';
	@override String get create_success => 'Catégorie créée avec succès';
	@override String get new_category => 'Nouvelle catégorie';
	@override String get already_exists => 'Le nom de cette catégorie existe déjà. Vous voulez peut-être la modifier';
	@override String get edit => 'Modifier la catégorie';
	@override String get edit_success => 'Catégorie modifiée avec succès';
	@override String get name => 'Nom de la catégorie';
	@override String get type => 'Type de catégorie';
	@override String get both_types => 'Les deux types';
	@override String get subcategories => 'Sous-catégories';
	@override String get subcategories_add => 'Ajouter une sous-catégorie';
	@override String get make_parent => 'Transformer en catégorie';
	@override String get make_child => 'Transformer en sous-catégorie';
	@override String make_child_warning1({required Object destiny}) => 'Cette catégorie et ses sous-catégories deviendront des sous-catégories de <b>${destiny}</b>.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'Leurs transactions <b>(${x})</b> seront déplacées vers les nouvelles sous-catégories créées dans la catégorie <b>${destiny}</b>.';
	@override String get make_child_success => 'Sous-catégories créées avec succès';
	@override String get merge => 'Fusionner avec une autre catégorie';
	@override String merge_warning1({required Object x, required Object from, required Object destiny}) => 'Toutes les transactions (${x}) associées à la catégorie <b>${from}</b> seront déplacées vers la catégorie <b>${destiny}</b>';
	@override String merge_warning2({required Object from}) => 'La catégorie <b>${from}</b> sera définitivement supprimée.';
	@override String get merge_success => 'Catégorie fusionnée avec succès';
	@override String get delete_success => 'Catégorie supprimée avec succès';
	@override String get delete_warning_header => 'Supprimer la catégorie ?';
	@override String delete_warning_message({required Object x}) => 'Cette action supprimera définitivement toutes les transactions <b>(${x})</b> liées à cette catégorie.';
	@override late final _TranslationsCategoriesSelectFr select = _TranslationsCategoriesSelectFr._(_root);
}

// Path: budgets
class _TranslationsBudgetsFr implements TranslationsBudgetsEn {
	_TranslationsBudgetsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Budgets';
	@override String get repeated => 'Récurrents';
	@override String get one_time => 'Une fois';
	@override String get annual => 'Annuels';
	@override String get week => 'Hebdomadaires';
	@override String get month => 'Mensuels';
	@override String get actives => 'Actifs';
	@override String get pending => 'En attente de démarrage';
	@override String get finish => 'Terminés';
	@override String get from_budgeted => 'restant sur ';
	@override String get days_left => 'jours restants';
	@override String get days_to_start => 'jours avant le début';
	@override String get since_expiration => 'jours depuis l\'expiration';
	@override String get no_budgets => 'Il ne semble pas y avoir de budgets à afficher dans cette section. Commencez par créer un budget en cliquant sur le bouton ci-dessous';
	@override String get delete => 'Supprimer le budget';
	@override String get delete_warning => 'Cette action est irréversible. Les catégories et transactions faisant référence à ce budget ne seront pas supprimées';
	@override late final _TranslationsBudgetsFormFr form = _TranslationsBudgetsFormFr._(_root);
	@override late final _TranslationsBudgetsDetailsFr details = _TranslationsBudgetsDetailsFr._(_root);
	@override late final _TranslationsBudgetsTargetTimelineStatusesFr target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesFr._(_root);
	@override late final _TranslationsBudgetsProgressFr progress = _TranslationsBudgetsProgressFr._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesFr implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get active => 'Actif';
	@override String get past => 'Passé';
	@override String get future => 'Futur';
}

// Path: backup
class _TranslationsBackupFr implements TranslationsBackupEn {
	_TranslationsBackupFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => 'Aucun fichier sélectionné';
	@override String get no_directory_selected => 'Aucun dossier sélectionné';
	@override late final _TranslationsBackupExportFr export = _TranslationsBackupExportFr._(_root);
	@override late final _TranslationsBackupImportFr import = _TranslationsBackupImportFr._(_root);
	@override late final _TranslationsBackupAboutFr about = _TranslationsBackupAboutFr._(_root);
}

// Path: settings
class _TranslationsSettingsFr implements TranslationsSettingsEn {
	_TranslationsSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Paramètres et Personnalisation';
	@override String get title_short => 'Paramètres';
	@override String get description => 'Thème, Langue, Données et plus';
	@override String get edit_profile => 'Modifier le profil';
	@override late final _TranslationsSettingsGeneralFr general = _TranslationsSettingsGeneralFr._(_root);
	@override late final _TranslationsSettingsSecurityFr security = _TranslationsSettingsSecurityFr._(_root);
	@override late final _TranslationsSettingsTransactionsFr transactions = _TranslationsSettingsTransactionsFr._(_root);
	@override late final _TranslationsSettingsAppearanceFr appearance = _TranslationsSettingsAppearanceFr._(_root);
}

// Path: more
class _TranslationsMoreFr implements TranslationsMoreEn {
	_TranslationsMoreFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plus';
	@override String get title_long => 'Plus d\'actions';
	@override late final _TranslationsMoreDataFr data = _TranslationsMoreDataFr._(_root);
	@override late final _TranslationsMoreAboutUsFr about_us = _TranslationsMoreAboutUsFr._(_root);
	@override late final _TranslationsMoreHelpUsFr help_us = _TranslationsMoreHelpUsFr._(_root);
}

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingFr implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Partir sans économiser ?';
	@override String get message => 'Vous avez des modifications non enregistrées, êtes-vous sûr de vouloir quitter sans les enregistrer ?';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardFr implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} copié dans le presse-papiers';
	@override String get error => 'Erreur lors de la copie';
}

// Path: general.time
class _TranslationsGeneralTimeFr implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Date de début';
	@override String get end_date => 'Date de fin';
	@override String get from_date => 'À partir de la date';
	@override String get until_date => 'Jusqu\'à la date';
	@override String get date => 'Date';
	@override String get datetime => 'Date et heure';
	@override String get time => 'Heure';
	@override String get each => 'Chaque';
	@override String get after => 'Après';
	@override late final _TranslationsGeneralTimeRangesFr ranges = _TranslationsGeneralTimeRangesFr._(_root);
	@override late final _TranslationsGeneralTimePeriodicityFr periodicity = _TranslationsGeneralTimePeriodicityFr._(_root);
	@override late final _TranslationsGeneralTimeCurrentFr current = _TranslationsGeneralTimeCurrentFr._(_root);
	@override late final _TranslationsGeneralTimeAllFr all = _TranslationsGeneralTimeAllFr._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderFr implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Trier les transactions';
	@override String get category => 'Par catégorie';
	@override String get quantity => 'Par montant';
	@override String get date => 'Par date';
}

// Path: general.validations
class _TranslationsGeneralValidationsFr implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Corrigez les champs indiqués pour continuer';
	@override String get required => 'Champ obligatoire';
	@override String get positive => 'Doit être positif';
	@override String min_number({required Object x}) => 'Doit être supérieur à ${x}';
	@override String max_number({required Object x}) => 'Doit être inférieur à ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewFr implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Excellent !';
			case GenderContext.female:
				return 'Excellent !';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Bon';
			case GenderContext.female:
				return 'Bon';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Moyen';
			case GenderContext.female:
				return 'Moyen';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Passable';
			case GenderContext.female:
				return 'Passable';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Très mauvais';
			case GenderContext.female:
				return 'Très mauvais';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Données insuffisantes';
			case GenderContext.female:
				return 'Données insuffisantes';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrFr descr = _TranslationsFinancialHealthReviewDescrFr._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeFr implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Taux de survie';
	@override String get subtitle => 'Compte tenu de votre solde, durée pendant laquelle vous pourriez vivre sans revenus';
	@override String get text_zero => 'Vous ne pourriez pas tenir un mois sans revenus avec ce niveau de dépenses !';
	@override String get text_one => 'Vous pourriez difficilement tenir environ un mois sans revenus avec ce niveau de dépenses !';
	@override String text_other({required Object n}) => 'Vous pourriez survivre environ <b>${n} mois</b> sans revenus avec ce niveau de dépenses.';
	@override String get text_infinite => 'Vous pourriez survivre <b>toute votre vie</b> sans revenus avec ce niveau de dépenses.';
	@override String get suggestion => 'N\'oubliez pas qu\'il est recommandé de garder ce ratio au-dessus d\'au moins 5 mois. Si vous voyez que vous n\'avez pas un coussin d\'épargne suffisant, réduisez les dépenses inutiles.';
	@override String get insufficient_data => 'On dirait que nous n\'avons pas assez de dépenses pour calculer combien de mois vous pourriez survivre sans revenus. Saisissez quelques transactions et revenez ici pour vérifier votre santé financière.';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageFr implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pourcentage d\'épargne';
	@override String get subtitle => 'Quelle part de vos revenus n\'est pas dépensée sur cette période';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextFr text = _TranslationsFinancialHealthSavingsPercentageTextFr._(_root);
	@override String get suggestion => 'N\'oubliez pas qu\'il est conseillé d\'épargner au moins 15 à 20 % de ce que vous gagnez.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesFr implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Transport';
	@override String get money => 'Argent';
	@override String get food => 'Alimentation';
	@override String get medical => 'Santé';
	@override String get entertainment => 'Loisirs';
	@override String get technology => 'Technologie';
	@override String get other => 'Autres';
	@override String get logos_financial_institutions => 'Institutions financières';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsFr implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get accept => 'Accepter';
	@override String get skip => 'Ignorer';
	@override String get skip_success => 'Transaction ignorée avec succès';
	@override String get skip_dialog_title => 'Ignorer la transaction';
	@override String skip_dialog_msg({required Object date}) => 'Cette action est irréversible. Nous déplacerons la date du prochain mouvement au ${date}';
	@override String get accept_today => 'Accepter aujourd\'hui';
	@override String accept_in_required_date({required Object date}) => 'Accepter à la date prévue (${date})';
	@override String get accept_dialog_title => 'Accepter la transaction';
	@override String get accept_dialog_msg_single => 'Le nouveau statut de la transaction sera nul. Vous pourrez rééditer le statut de cette transaction quand vous le souhaitez';
	@override String accept_dialog_msg({required Object date}) => 'Cette action créera une nouvelle transaction avec la date ${date}. Vous pourrez consulter les détails de cette transaction sur la page des transactions';
	@override String get recurrent_rule_finished => 'La règle récurrente est terminée, il n\'y a plus de paiements à effectuer !';
}

// Path: transaction.list
class _TranslationsTransactionListFr implements TranslationsTransactionListEn {
	_TranslationsTransactionListFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get all => 'Toutes les transactions';
	@override String get empty => 'Aucune transaction trouvée à afficher ici. Ajoutez quelques transactions dans l\'application et vous aurez peut-être plus de chance la prochaine fois.';
	@override String get searcher_placeholder => 'Rechercher par catégorie, description...';
	@override String get searcher_no_results => 'Aucune transaction ne correspond aux critères de recherche';
	@override String get loading => 'Chargement de nouvelles transactions...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} sélectionnée',
		other: '${n} sélectionnées',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} transaction sélectionnée',
		other: '${n} transactions sélectionnées',
	);
	@override late final _TranslationsTransactionListBulkEditFr bulk_edit = _TranslationsTransactionListBulkEditFr._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersFr implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtres de transactions';
	@override String get from_value => 'Montant minimum';
	@override String get to_value => 'Montant maximum';
	@override String from_value_def({required Object x}) => 'À partir de ${x}';
	@override String to_value_def({required Object x}) => 'Jusqu\'à ${x}';
	@override String from_date_def({required Object date}) => 'À partir du ${date}';
	@override String to_date_def({required Object date}) => 'Jusqu\'au ${date}';
	@override String get reset => 'Réinitialiser les filtres';
	@override late final _TranslationsTransactionFiltersSavedFr saved = _TranslationsTransactionFiltersSavedFr._(_root);
}

// Path: transaction.form
class _TranslationsTransactionFormFr implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsFr validators = _TranslationsTransactionFormValidatorsFr._(_root);
	@override String get title => 'Titre de la transaction';
	@override String get title_short => 'Titre';
	@override String get value => 'Montant de la transaction';
	@override String get tap_to_see_more => 'Touchez pour voir plus de détails';
	@override String get no_tags => '-- Aucun tag --';
	@override String get description => 'Description';
	@override String get description_info => 'Touchez ici pour saisir une description plus détaillée de cette transaction';
	@override String exchange_to_preferred_title({required Object currency}) => 'Taux de change vers ${currency}';
	@override String get exchange_to_preferred_in_date => 'À la date de la transaction';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedFr implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaction inversée';
	@override String get title_short => 'Trans. inverse';
	@override String get description_for_expenses => 'Bien qu\'il s\'agisse d\'une dépense, elle a un montant positif. Ce type de transaction peut être utilisé pour représenter le retour d\'une dépense déjà enregistrée, comme un remboursement ou le paiement d\'une dette.';
	@override String get description_for_incomes => 'Bien qu\'il s\'agisse d\'une recette, elle a un montant négatif. Ce type de transaction peut être utilisé pour annuler ou corriger un revenu enregistré de manière incorrecte, pour refléter un retour ou un remboursement d\'argent ou pour enregistrer le paiement de dettes.';
}

// Path: transaction.status
class _TranslationsTransactionStatusFr implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Statut',
		other: 'Statuts',
	);
	@override String get display_long => 'Statut de la transaction';
	@override String tr_status({required Object status}) => 'Transaction ${status}';
	@override String get none => 'Sans statut';
	@override String get none_descr => 'Transaction sans état spécifique';
	@override String get reconciled => 'Rapprochée';
	@override String get reconciled_descr => 'Cette transaction a déjà été validée et correspond à une transaction réelle de votre banque';
	@override String get unreconciled => 'Non rapprochée';
	@override String get unreconciled_descr => 'Cette transaction n\'a pas encore été validée et n\'apparaît donc pas encore dans vos comptes bancaires réels. Cependant, elle est prise en compte pour le calcul des soldes et des statistiques dans Monekin';
	@override String get pending => 'En attente';
	@override String get pending_descr => 'Cette transaction est en attente et ne sera donc pas prise en compte dans le calcul des soldes et des statistiques';
	@override String get voided => 'Annulée';
	@override String get voided_descr => 'Transaction annulée en raison d\'une erreur de paiement ou pour toute autre raison. Elle ne sera pas prise en compte dans le calcul des soldes et des statistiques';
}

// Path: transaction.types
class _TranslationsTransactionTypesFr implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Type de transaction',
		other: 'Types de transactions',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Recette',
		other: 'Recettes',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Dépense',
		other: 'Dépenses',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Virement',
		other: 'Virements',
	);
}

// Path: transfer.form
class _TranslationsTransferFormFr implements TranslationsTransferFormEn {
	_TranslationsTransferFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get from => 'Compte d\'origine';
	@override String get to => 'Compte de destination';
	@override late final _TranslationsTransferFormValueInDestinyFr value_in_destiny = _TranslationsTransferFormValueInDestinyFr._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsFr implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaction récurrente';
	@override String get descr => 'Les prochains mouvements pour cette transaction sont indiqués ci-dessous. Vous pouvez accepter le premier mouvement ou l\'ignorer';
	@override String get last_payment_info => 'Ce mouvement est le dernier de la règle récurrente, cette règle sera donc automatiquement supprimée lors de la confirmation de cette action';
	@override String get delete_header => 'Supprimer la transaction récurrente';
	@override String get delete_message => 'Cette action est irréversible et n\'affectera pas les transactions que vous avez déjà confirmées/payées';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusFr implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Retard de ${x} j';
	@override String coming_in({required Object x}) => 'Dans ${x} jours';
}

// Path: account.types
class _TranslationsAccountTypesFr implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Type de compte';
	@override String get warning => 'Une fois le type de compte choisi, il ne pourra plus être modifié dans le futur';
	@override String get normal => 'Compte normal';
	@override String get normal_descr => 'Utile pour enregistrer vos finances du quotidien. C\'est le type de compte le plus courant, il vous permet d\'ajouter des dépenses, des recettes...';
	@override String get saving => 'Compte d\'épargne';
	@override String get saving_descr => 'Vous ne pourrez y ajouter et y retirer de l\'argent qu\'à partir d\'autres comptes. Parfait pour commencer à économiser';
}

// Path: account.form
class _TranslationsAccountFormFr implements TranslationsAccountFormEn {
	_TranslationsAccountFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom du compte';
	@override String get name_placeholder => 'Ex : Compte épargne';
	@override String get notes => 'Notes';
	@override String get notes_placeholder => 'Saisissez des notes/une description à propos de ce compte';
	@override String get initial_balance => 'Solde initial';
	@override String get current_balance => 'Solde actuel';
	@override String get create => 'Créer le compte';
	@override String get edit => 'Modifier le compte';
	@override String get currency_not_found_warn => 'Vous n\'avez pas d\'informations sur les taux de change pour cette devise. 1.0 sera utilisé comme taux de change par défaut. Vous pouvez modifier cela dans les paramètres';
	@override String get already_exists => 'Un autre compte avec le même nom existe déjà, veuillez en choisir un autre';
	@override String get tr_before_opening_date => 'Il existe des transactions sur ce compte avec une date antérieure à la date d\'ouverture';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteFr implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Supprimer le compte ?';
	@override String get warning_text => 'Cette action supprimera ce compte et toutes ses transactions';
	@override String get success => 'Compte supprimé avec succès';
}

// Path: account.close
class _TranslationsAccountCloseFr implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Clôturer le compte';
	@override String get title_short => 'Clôturer';
	@override String get warn => 'Ce compte n\'apparaîtra plus dans certains listings et vous ne pourrez pas créer de transactions dessus avec une date postérieure à celle spécifiée ci-dessous. Cette action n\'affecte aucune transaction ni aucun solde, et vous pourrez rouvrir ce compte à tout moment.';
	@override String get should_have_zero_balance => 'Le solde actuel de ce compte doit être de 0 pour pouvoir le clôturer. Veuillez modifier le compte avant de continuer';
	@override String get should_have_no_transactions => 'Ce compte comporte des transactions après la date de clôture spécifiée. Supprimez-les ou modifiez la date de clôture du compte avant de continuer';
	@override String get success => 'Compte clôturé avec succès';
	@override String get unarchive_succes => 'Compte rouvert avec succès';
}

// Path: account.select
class _TranslationsAccountSelectFr implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get one => 'Sélectionnez un compte';
	@override String get all => 'Tous les comptes';
	@override String get multiple => 'Sélectionnez des comptes';
}

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormFr implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'La devise ne peut pas être identique à la devise de l\'utilisateur';
	@override String get override_existing_warn => 'Un taux de change pour cette devise à cette date existe déjà. Si vous continuez, le précédent sera écrasé';
	@override String get specify_a_currency => 'Veuillez spécifier une devise';
	@override String get add => 'Ajouter un taux de change';
	@override String get add_success => 'Taux de change ajouté avec succès';
	@override String get edit => 'Modifier le taux de change';
	@override String get edit_success => 'Taux de change modifié avec succès';
	@override String get remove_all => 'Supprimer tous les taux de change';
	@override String get remove_all_warning => 'Cette action est irréversible et supprimera tous les taux de change de cette devise';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesFr implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Type de devise';
	@override String get fiat => 'DÉCRET';
	@override String get crypto => 'Crypto-monnaie';
	@override String get other => 'Autre';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormFr implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom d\'affichage';
	@override String get code => 'Code de devise';
	@override String get symbol => 'Symbole';
	@override String get decimal_digits => 'Chiffres décimaux';
	@override String get create => 'Créer une devise';
	@override String get create_success => 'Devise créée avec succès';
	@override String get edit => 'Modifier la devise';
	@override String get edit_success => 'Devise modifiée avec succès';
	@override String get delete => 'Supprimer la devise';
	@override String get delete_success => 'Devise supprimée avec succès';
	@override String get already_exists => 'Une devise avec ce code existe déjà. Vous voudrez peut-être le modifier';
}

// Path: tags.form
class _TranslationsTagsFormFr implements TranslationsTagsFormEn {
	_TranslationsTagsFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom du tag';
	@override String get description => 'Description';
}

// Path: tags.select
class _TranslationsTagsSelectFr implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sélectionnez des tags';
	@override String get all => 'Tous les tags';
}

// Path: categories.select
class _TranslationsCategoriesSelectFr implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sélectionner des catégories';
	@override String get select_one => 'Sélectionner une catégorie';
	@override String get select_subcategory => 'Choisir une sous-catégorie';
	@override String get without_subcategory => 'Sans sous-catégorie';
	@override String get all => 'Toutes les catégories';
	@override String get all_short => 'Toutes';
}

// Path: budgets.form
class _TranslationsBudgetsFormFr implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajouter un budget';
	@override String get name => 'Nom du budget';
	@override String get value => 'Montant limite';
	@override String get create => 'Ajouter un budget';
	@override String get create_success => 'Budget créé avec succès';
	@override String get edit => 'Modifier le budget';
	@override String get edit_success => 'Budget modifié avec succès';
	@override String get negative_warn => 'Les budgets ne peuvent pas avoir un montant négatif';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsFr implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Détails du budget';
	@override String get statistics => 'Statistiques';
	@override String get budget_value => 'Budgeté';
	@override String get expend_evolution => 'Évolution des dépenses';
	@override String get no_transactions => 'Il semble que vous n\'ayez pas encore fait de dépenses liées à ce budget';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesFr implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get active => 'Budget actif';
	@override String get past => 'Budget passé';
	@override String get future => 'Budget futur';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressFr implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsFr labels = _TranslationsBudgetsProgressLabelsFr._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionFr description = _TranslationsBudgetsProgressDescriptionFr._(_root);
}

// Path: backup.export
class _TranslationsBackupExportFr implements TranslationsBackupExportEn {
	_TranslationsBackupExportFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exporter vos données';
	@override String get title_short => 'Exporter';
	@override String get type_of_export => 'Type d\'export';
	@override String get other_options => 'Options';
	@override String get all => 'Sauvegarde complète';
	@override String get all_descr => 'Exportez toutes vos données (comptes, transactions, budgets, paramètres...). Importez-les à nouveau à tout moment pour ne rien perdre.';
	@override String get transactions => 'Sauvegarde des transactions';
	@override String get transactions_descr => 'Exportez vos transactions en CSV pour pouvoir les analyser plus facilement dans d\'autres programmes ou applications.';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '1 transaction à exporter',
		other: '${n} transactions à exporter',
	);
	@override String get description => 'Téléchargez vos données dans différents formats';
	@override String get send_file => 'Envoyer le fichier';
	@override String get see_folder => 'Voir le dossier';
	@override String success({required Object x}) => 'Fichier enregistré avec succès dans ${x}';
	@override String get error => 'Erreur lors du téléchargement du fichier. Veuillez contacter le développeur via lozin.technologies@gmail.com';
}

// Path: backup.import
class _TranslationsBackupImportFr implements TranslationsBackupImportEn {
	_TranslationsBackupImportFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importer vos données';
	@override String get title_short => 'Importer';
	@override String get restore_backup => 'Restaurer une sauvegarde';
	@override String get restore_backup_descr => 'Importez une base de données Monekin préalablement sauvegardée. Cette action remplacera toutes les données actuelles de l\'application par les nouvelles données';
	@override String get restore_backup_warn_description => 'Lors de l\'import d\'une nouvelle base de données, vous perdrez toutes les données actuellement enregistrées dans l\'application. Il est recommandé de réaliser une sauvegarde avant de continuer. N\'importez ici aucun fichier dont vous ne connaissez pas l\'origine ; importez uniquement des fichiers que vous avez préalablement téléchargés depuis Monekin';
	@override String get restore_backup_warn_title => 'Écraser toutes les données';
	@override String get select_other_file => 'Sélectionner un autre fichier';
	@override String get tap_to_select_file => 'Touchez pour sélectionner un fichier';
	@override late final _TranslationsBackupImportManualImportFr manual_import = _TranslationsBackupImportManualImportFr._(_root);
	@override String get success => 'Import réalisé avec succès';
	@override String get error => 'Erreur lors de l\'import du fichier. Veuillez contacter le développeur via lozin.technologies@gmail.com';
}

// Path: backup.about
class _TranslationsBackupAboutFr implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informations sur votre base de données';
	@override String get create_date => 'Date de création';
	@override String get modify_date => 'Dernière modification';
	@override String get last_backup => 'Dernière sauvegarde';
	@override String get size => 'Taille';
}

// Path: settings.general
class _TranslationsSettingsGeneralFr implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Paramètres généraux';
	@override String get menu_descr => 'Langue, confidentialité et plus';
	@override late final _TranslationsSettingsGeneralLanguageFr language = _TranslationsSettingsGeneralLanguageFr._(_root);
	@override late final _TranslationsSettingsGeneralLocaleFr locale = _TranslationsSettingsGeneralLocaleFr._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityFr implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sécurité';
	@override String get private_mode_at_launch => 'Mode privé au démarrage';
	@override String get private_mode_at_launch_descr => 'Lancer l\'application en mode privé par défaut';
	@override String get private_mode => 'Mode privé';
	@override String get private_mode_descr => 'Masquer toutes les valeurs monétaires';
	@override String get private_mode_activated => 'Mode privé activé';
	@override String get private_mode_deactivated => 'Mode privé désactivé';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsFr implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Transactions';
	@override String get menu_descr => 'Configurer le comportement de vos transactions';
	@override String get title => 'Paramètres des transactions';
	@override late final _TranslationsSettingsTransactionsSwipeActionsFr swipe_actions = _TranslationsSettingsTransactionsSwipeActionsFr._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesFr default_values = _TranslationsSettingsTransactionsDefaultValuesFr._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeFr default_type = _TranslationsSettingsTransactionsDefaultTypeFr._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceFr implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Thème et style';
	@override String get menu_descr => 'Sélection du thème, couleurs et autres éléments liés à l\'apparence de l\'application';
	@override String get theme_and_colors => 'Thème et couleurs';
	@override late final _TranslationsSettingsAppearanceThemeFr theme = _TranslationsSettingsAppearanceThemeFr._(_root);
	@override String get amoled_mode => 'Mode AMOLED';
	@override String get amoled_mode_descr => 'Utiliser un fond noir pur lorsque c\'est possible. Cela aidera légèrement la batterie des appareils avec écran AMOLED';
	@override String get dynamic_colors => 'Couleurs dynamiques';
	@override String get dynamic_colors_descr => 'Utiliser la couleur d\'accent de votre système lorsque c\'est possible';
	@override String get accent_color => 'Couleur d\'accent';
	@override String get accent_color_descr => 'Choisissez la couleur que l\'application utilisera pour mettre en évidence certaines parties de l\'interface';
	@override String get text => 'Texte';
	@override String get font => 'Police';
	@override String get font_platform => 'Plateforme';
}

// Path: more.data
class _TranslationsMoreDataFr implements TranslationsMoreDataEn {
	_TranslationsMoreDataFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Données';
	@override String get display_descr => 'Exportez et importez vos données pour ne rien perdre';
	@override String get delete_all => 'Supprimer mes données';
	@override String get delete_all_header1 => 'Stop là padawan ⚠️⚠️';
	@override String get delete_all_message1 => 'Êtes-vous sûr de vouloir continuer ? Toutes vos données seront définitivement supprimées et ne pourront pas être récupérées';
	@override String get delete_all_header2 => 'Une dernière étape ⚠️⚠️';
	@override String get delete_all_message2 => 'En supprimant un compte vous supprimerez toutes vos données personnelles enregistrées. Vos comptes, transactions, budgets et catégories seront supprimés et ne pourront pas être récupérés. Êtes-vous d\'accord ?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsFr implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Informations sur l\'application';
	@override String get description => 'Consultez les conditions et autres informations importantes sur Monekin. Rejoignez la communauté en signalant des bugs, en laissant des suggestions...';
	@override late final _TranslationsMoreAboutUsLegalFr legal = _TranslationsMoreAboutUsLegalFr._(_root);
	@override late final _TranslationsMoreAboutUsProjectFr project = _TranslationsMoreAboutUsProjectFr._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsFr implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Aidez-nous';
	@override String get description => 'Découvrez comment vous pouvez aider Monekin à devenir toujours meilleur';
	@override String get rate_us => 'Notez-nous';
	@override String get rate_us_descr => 'Toutes les notes sont les bienvenues !';
	@override String get share => 'Partager Monekin';
	@override String get share_descr => 'Partagez notre application avec vos amis et votre famille';
	@override String get share_text => 'Monekin ! La meilleure application de finances personnelles. Téléchargez-la ici';
	@override String get thanks => 'Merci !';
	@override String get thanks_long => 'Vos contributions à Monekin et aux autres projets open source, grandes ou petites, rendent possibles de super projets comme celui-ci. Merci de prendre le temps de contribuer.';
	@override String get donate => 'Faire un don';
	@override String get donate_descr => 'Avec votre don, vous aiderez l\'application à continuer de recevoir des améliorations. Quelle meilleure façon de remercier le travail accompli qu\'en m\'invitant à un café ?';
	@override String get donate_success => 'Don effectué. Merci beaucoup pour votre contribution ! ❤️';
	@override String get donate_err => 'Oups ! Il semble qu\'il y ait eu une erreur lors de la réception de votre paiement';
	@override String get report => 'Signaler des bugs, laisser des suggestions...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesFr implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Plage de temps';
	@override String get it_repeat => 'Répète';
	@override String get it_ends => 'Se termine';
	@override String get forever => 'Pour toujours';
	@override late final _TranslationsGeneralTimeRangesTypesFr types = _TranslationsGeneralTimeRangesTypesFr._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Chaque ${range}',
		other: 'Tous les ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Chaque ${range} jusqu\'au ${day}',
		other: 'Tous les ${n} ${range} jusqu\'au ${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Chaque ${range} ${limit} fois',
		other: 'Tous les ${n} ${range} ${limit} fois',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Chaque ${range} une fois',
		other: 'Tous les ${n} ${range} une fois',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Mois',
		other: 'Mois',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'An',
		other: 'Ans',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Jour',
		other: 'Jours',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Semaine',
		other: 'Semaines',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityFr implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Récurrence';
	@override String get no_repeat => 'Ne pas répéter';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Répétition',
		other: 'Répétitions',
	);
	@override String get diary => 'Quotidienne';
	@override String get monthly => 'Mensuelle';
	@override String get annually => 'Annuelle';
	@override String get quaterly => 'Trimestrielle';
	@override String get weekly => 'Hebdomadaire';
	@override String get custom => 'Personnalisé';
	@override String get infinite => 'Toujours';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentFr implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Ce mois-ci';
	@override String get annually => 'Cette année';
	@override String get quaterly => 'Ce trimestre';
	@override String get weekly => 'Cette semaine';
	@override String get infinite => 'Pour toujours';
	@override String get custom => 'Plage personnalisée';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllFr implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Chaque jour';
	@override String get monthly => 'Chaque mois';
	@override String get annually => 'Chaque année';
	@override String get quaterly => 'Chaque trimestre';
	@override String get weekly => 'Chaque semaine';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrFr implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'On dirait que nous n\'avons pas assez de dépenses pour calculer votre santé financière. Ajoutez quelques dépenses/recettes sur cette période pour que nous puissions vous aider !';
	@override String get very_good => 'Félicitations ! Votre santé financière est excellente. Nous espérons que vous continuerez sur cette lancée et à apprendre avec Monekin.';
	@override String get good => 'Super ! Votre santé financière est bonne. Visitez l\'onglet d\'analyse pour voir comment économiser encore plus !';
	@override String get normal => 'Votre santé financière est plus ou moins dans la moyenne de la population pour cette période.';
	@override String get bad => 'Il semble que votre situation financière ne soit pas encore optimale. Explorez le reste des graphiques pour en savoir plus sur vos finances.';
	@override String get very_bad => 'Hmm, votre santé financière est bien en dessous de ce qu\'elle devrait être. Explorez le reste des graphiques pour en savoir plus sur vos finances.';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextFr implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Félicitations ! Vous avez réussi à épargner <b>${value} %</b> de vos revenus sur cette période. Il semble que vous soyez déjà un expert, continuez comme ça !';
	@override String normal({required Object value}) => 'Félicitations, vous avez réussi à épargner <b>${value} %</b> de vos revenus sur cette période.';
	@override String bad({required Object value}) => 'Vous avez réussi à épargner <b>${value} %</b> de vos revenus sur cette période. Cependant, nous pensons que vous pouvez encore faire beaucoup mieux !';
	@override String get very_bad => 'Oups, vous n\'avez réussi à rien épargner sur cette période.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditFr implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Modifier les dates';
	@override String get categories => 'Modifier les catégories';
	@override String get status => 'Modifier les statuts';
}

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedFr implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtres enregistrés';
	@override String get new_title => 'Nouveau filtre';
	@override String get edit_title => 'Modifier le filtre';
	@override String get name_label => 'Nom du filtre';
	@override String get name_hint => 'Mon filtre personnalisé';
	@override String get save_dialog_title => 'Enregistrer le filtre';
	@override String get save_tooltip => 'Enregistrer le filtre actuel';
	@override String get load_tooltip => 'Charger un filtre enregistré';
	@override String get empty_title => 'Aucun filtre enregistré trouvé';
	@override String get empty_description => 'Enregistrez des filtres ici pour y accéder rapidement plus tard.';
	@override String get save_success => 'Filtre enregistré avec succès';
	@override String get delete_success => 'Filtre supprimé avec succès';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsFr implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get zero => 'La valeur d\'une transaction ne peut pas être égale à zéro';
	@override String get date_max => 'La date sélectionnée est postérieure à la date actuelle. La transaction sera ajoutée comme en attente';
	@override String get date_after_account_creation => 'Vous ne pouvez pas créer une transaction dont la date est antérieure à la date de création du compte auquel elle appartient';
	@override String get negative_transfer => 'Le montant d\'un virement ne peut pas être négatif';
	@override String get transfer_between_same_accounts => 'Le compte d\'origine et le compte de destination ne peuvent pas être identiques';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyFr implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Montant transféré au compte de destination';
	@override String amount_short({required Object amount}) => '${amount} vers le compte cible';
}

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsFr implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'En bonne voie';
	@override String get active_overspending => 'Dépenses excessives';
	@override String get success => 'Atteint';
	@override String get fail => 'Budget dépassé';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionFr implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Vous pouvez dépenser ${dailyAmount} par jour pour les ${remainingDays} jours restants';
	@override String active_overspending({required Object dailyAmount, required Object remainingDays}) => 'Pour revenir sur la bonne voie, vous devriez limiter vos dépenses à ${dailyAmount} par jour pour les ${remainingDays} jours restants';
	@override String active_exceeded({required Object amount}) => 'Vous avez déjà dépassé votre limite budgétaire de ${amount}. Si vous ne trouvez aucun revenu pour ce budget, vous devriez arrêter de dépenser pour le reste de sa période';
	@override String get success => 'Bon travail ! Ce budget est terminé avec succès. Continuez à créer des budgets pour gérer vos dépenses';
	@override String fail({required Object amount}) => 'Vous avez dépassé le budget de ${amount}. Essayez d\'être plus prudent la prochaine fois !';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportFr implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Import manuel';
	@override String get descr => 'Importez des transactions depuis un fichier .csv manuellement';
	@override String get default_account => 'Compte par défaut';
	@override String get remove_default_account => 'Supprimer le compte par défaut';
	@override String get default_category => 'Catégorie par défaut';
	@override String get select_a_column => 'Sélectionnez une colonne du .csv';
	@override List<String> get steps => [
		'Sélectionnez votre fichier',
		'Colonne pour le montant',
		'Colonne pour le compte',
		'Colonne pour la catégorie',
		'Colonne pour la date',
		'autres colonnes',
	];
	@override List<String> get steps_descr => [
		'Sélectionnez un fichier .csv depuis votre appareil. Assurez-vous qu\'il possède une première ligne décrivant le nom de chaque colonne',
		'Sélectionnez la colonne où la valeur de chaque transaction est spécifiée. Utilisez des valeurs négatives pour les dépenses et positives pour les recettes. Utilisez un point comme séparateur décimal',
		'Sélectionnez la colonne où est spécifié le compte auquel appartient chaque transaction. Vous pouvez également sélectionner un compte par défaut au cas où nous ne pourrions pas trouver le compte souhaité. Si aucun compte par défaut n\'est spécifié, nous en créerons un avec le même nom',
		'Indiquez la colonne où se trouve le nom de la catégorie de la transaction. Vous devez spécifier une catégorie par défaut pour que nous l\'assignions aux transactions si la catégorie ne peut pas être trouvée',
		'Sélectionnez la colonne où la date de chaque transaction est spécifiée. Si elle n\'est pas indiquée, les transactions seront créées avec la date actuelle',
		'Indiquez les colonnes pour les autres attributs optionnels de la transaction',
	];
	@override String success({required Object x}) => '${x} transactions importées avec succès';
}

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageFr implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get section => 'Langue et textes';
	@override String get title => 'Langue de l\'application';
	@override String get descr => 'Langue dans laquelle les textes seront affichés dans l\'application';
	@override String get help => 'Si vous souhaitez contribuer aux traductions de cette application, vous pouvez consulter <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>notre guide</a>';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleFr implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Région';
	@override String get auto => 'Système';
	@override String get descr => 'Définissez le format à utiliser pour les dates, les nombres...';
	@override String get warn => 'Lors du changement de région, l\'application va se mettre à jour';
	@override String get first_day_of_week => 'Premier jour de la semaine';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsFr implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Actions de balayage';
	@override String get choose_description => 'Choisissez l\'action qui sera déclenchée lorsque vous balayez un élément de transaction dans la liste dans cette direction';
	@override String get swipe_left => 'Balayage vers la gauche';
	@override String get swipe_right => 'Balayage vers la droite';
	@override String get none => 'Aucune action';
	@override String get toggle_reconciled => 'Basculer rapprochée';
	@override String get toggle_pending => 'Basculer en attente';
	@override String get toggle_voided => 'Basculer annulée';
	@override String get toggle_unreconciled => 'Basculer non rapprochée';
	@override String get remove_status => 'Supprimer le statut';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesFr implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Valeurs par défaut du formulaire';
	@override String get page_title => 'Nouvelle transaction : Valeurs par défaut';
	@override String get reuse_last_transaction => 'Réutiliser les valeurs de la dernière transaction';
	@override String get reuse_last_transaction_descr => 'Remplir automatiquement le formulaire avec certaines valeurs de la dernière transaction créée';
	@override String get fields_to_reuse => 'Champs à réutiliser';
	@override String get reuse_last_values_modal_descr => 'Sélectionnez les champs qui doivent être pré-remplis avec les valeurs de la dernière transaction créée.';
	@override String get default_values_separator => 'Valeurs par défaut';
	@override String get default_category => 'Catégorie par défaut';
	@override String get default_status => 'Statut par défaut';
	@override String get default_tags => 'Étiquettes par défaut';
	@override String get no_tags_selected => 'Aucune étiquette sélectionnée';
}

// Path: settings.transactions.default_type
class _TranslationsSettingsTransactionsDefaultTypeFr implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Type par défaut';
	@override String get modal_title => 'Sélectionner le type par défaut';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeFr implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thème';
	@override String get auto => 'Système';
	@override String get light => 'Clair';
	@override String get dark => 'Sombre';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalFr implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Informations légales';
	@override String get privacy => 'Politique de confidentialité';
	@override String get terms => 'Conditions d\'utilisation';
	@override String get licenses => 'Licences';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectFr implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Projet';
	@override String get contributors => 'Collaborateurs';
	@override String get contributors_descr => 'Tous les développeurs qui ont fait grandir Monekin';
	@override String get contact => 'Contactez-nous';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesFr implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Cycles';
	@override String get last_days => 'Derniers jours';
	@override String last_days_form({required Object x}) => '${x} jours précédents';
	@override String get all => 'Toujours';
	@override String get date_range => 'Plage personnalisée';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = 'Annuler';
		map['ui_actions.confirm'] = 'Confirmer';
		map['ui_actions.continue_text'] = 'Continuer';
		map['ui_actions.save'] = 'Enregistrer';
		map['ui_actions.save_changes'] = 'Enregistrer les modifications';
		map['ui_actions.close_and_save'] = 'Enregistrer et fermer';
		map['ui_actions.add'] = 'Ajouter';
		map['ui_actions.edit'] = 'Modifier';
		map['ui_actions.delete'] = 'Supprimer';
		map['ui_actions.see_more'] = 'Voir plus';
		map['ui_actions.select_all'] = 'Tout sélectionner';
		map['ui_actions.deselect_all'] = 'Tout désélectionner';
		map['ui_actions.select'] = 'Sélectionner';
		map['ui_actions.search'] = 'Rechercher';
		map['ui_actions.filter'] = 'Filtrer';
		map['ui_actions.reset'] = 'Réinitialiser';
		map['ui_actions.submit'] = 'Valider';
		map['ui_actions.next'] = 'Suivant';
		map['ui_actions.previous'] = 'Précédent';
		map['ui_actions.back'] = 'Retour';
		map['ui_actions.reload'] = 'Recharger';
		map['ui_actions.view'] = 'Voir';
		map['ui_actions.download'] = 'Télécharger';
		map['ui_actions.upload'] = 'Téléverser';
		map['ui_actions.retry'] = 'Réessayer';
		map['ui_actions.copy'] = 'Copier';
		map['ui_actions.paste'] = 'Coller';
		map['ui_actions.undo'] = 'Annuler';
		map['ui_actions.redo'] = 'Rétablir';
		map['ui_actions.open'] = 'Ouvrir';
		map['ui_actions.close'] = 'Fermer';
		map['ui_actions.apply'] = 'Appliquer';
		map['ui_actions.discard'] = 'Abandonner';
		map['ui_actions.refresh'] = 'Actualiser';
		map['ui_actions.share'] = 'Partager';
		map['general.or'] = 'ou';
		map['general.understood'] = 'Compris';
		map['general.unspecified'] = 'Non spécifié';
		map['general.quick_actions'] = 'Actions rapides';
		map['general.details'] = 'Détails';
		map['general.balance'] = 'Solde';
		map['general.account'] = 'Compte';
		map['general.accounts'] = 'Comptes';
		map['general.categories'] = 'Catégories';
		map['general.category'] = 'Catégorie';
		map['general.today'] = 'Aujourd\'hui';
		map['general.yesterday'] = 'Hier';
		map['general.filters'] = 'Filtres';
		map['general.empty_warn'] = 'Oups ! C\'est très vide';
		map['general.search_no_results'] = 'Aucun élément ne correspond à vos critères de recherche';
		map['general.insufficient_data'] = 'Données insuffisantes';
		map['general.show_more_fields'] = 'Afficher plus de champs';
		map['general.show_less_fields'] = 'Afficher moins de champs';
		map['general.tap_to_search'] = 'Touchez pour rechercher';
		map['general.leave_without_saving.title'] = 'Partir sans économiser ?';
		map['general.leave_without_saving.message'] = 'Vous avez des modifications non enregistrées, êtes-vous sûr de vouloir quitter sans les enregistrer ?';
		map['general.clipboard.success'] = ({required Object x}) => '${x} copié dans le presse-papiers';
		map['general.clipboard.error'] = 'Erreur lors de la copie';
		map['general.time.start_date'] = 'Date de début';
		map['general.time.end_date'] = 'Date de fin';
		map['general.time.from_date'] = 'À partir de la date';
		map['general.time.until_date'] = 'Jusqu\'à la date';
		map['general.time.date'] = 'Date';
		map['general.time.datetime'] = 'Date et heure';
		map['general.time.time'] = 'Heure';
		map['general.time.each'] = 'Chaque';
		map['general.time.after'] = 'Après';
		map['general.time.ranges.display'] = 'Plage de temps';
		map['general.time.ranges.it_repeat'] = 'Répète';
		map['general.time.ranges.it_ends'] = 'Se termine';
		map['general.time.ranges.forever'] = 'Pour toujours';
		map['general.time.ranges.types.cycle'] = 'Cycles';
		map['general.time.ranges.types.last_days'] = 'Derniers jours';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '${x} jours précédents';
		map['general.time.ranges.types.all'] = 'Toujours';
		map['general.time.ranges.types.date_range'] = 'Plage personnalisée';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Chaque ${range}',
				other: 'Tous les ${n} ${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Chaque ${range} jusqu\'au ${day}',
				other: 'Tous les ${n} ${range} jusqu\'au ${day}',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Chaque ${range} ${limit} fois',
				other: 'Tous les ${n} ${range} ${limit} fois',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Chaque ${range} une fois',
				other: 'Tous les ${n} ${range} une fois',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Mois',
				other: 'Mois',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'An',
				other: 'Ans',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Jour',
				other: 'Jours',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Semaine',
				other: 'Semaines',
			);
		map['general.time.periodicity.display'] = 'Récurrence';
		map['general.time.periodicity.no_repeat'] = 'Ne pas répéter';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Répétition',
				other: 'Répétitions',
			);
		map['general.time.periodicity.diary'] = 'Quotidienne';
		map['general.time.periodicity.monthly'] = 'Mensuelle';
		map['general.time.periodicity.annually'] = 'Annuelle';
		map['general.time.periodicity.quaterly'] = 'Trimestrielle';
		map['general.time.periodicity.weekly'] = 'Hebdomadaire';
		map['general.time.periodicity.custom'] = 'Personnalisé';
		map['general.time.periodicity.infinite'] = 'Toujours';
		map['general.time.current.monthly'] = 'Ce mois-ci';
		map['general.time.current.annually'] = 'Cette année';
		map['general.time.current.quaterly'] = 'Ce trimestre';
		map['general.time.current.weekly'] = 'Cette semaine';
		map['general.time.current.infinite'] = 'Pour toujours';
		map['general.time.current.custom'] = 'Plage personnalisée';
		map['general.time.all.diary'] = 'Chaque jour';
		map['general.time.all.monthly'] = 'Chaque mois';
		map['general.time.all.annually'] = 'Chaque année';
		map['general.time.all.quaterly'] = 'Chaque trimestre';
		map['general.time.all.weekly'] = 'Chaque semaine';
		map['general.transaction_order.display'] = 'Trier les transactions';
		map['general.transaction_order.category'] = 'Par catégorie';
		map['general.transaction_order.quantity'] = 'Par montant';
		map['general.transaction_order.date'] = 'Par date';
		map['general.validations.form_error'] = 'Corrigez les champs indiqués pour continuer';
		map['general.validations.required'] = 'Champ obligatoire';
		map['general.validations.positive'] = 'Doit être positif';
		map['general.validations.min_number'] = ({required Object x}) => 'Doit être supérieur à ${x}';
		map['general.validations.max_number'] = ({required Object x}) => 'Doit être inférieur à ${x}';
		map['intro.start'] = 'Commencer';
		map['intro.skip'] = 'Ignorer';
		map['intro.next'] = 'Suivant';
		map['intro.select_your_currency'] = 'Sélectionnez votre devise';
		map['intro.welcome_subtitle'] = 'Votre gestionnaire de finances personnelles';
		map['intro.welcome_subtitle2'] = '100 % open, 100 % gratuit';
		map['intro.welcome_footer'] = 'En vous connectant, vous acceptez la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>politique de confidentialité</a> et les <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>conditions d\'utilisation</a> de l\'application';
		map['intro.offline_descr_title'] = 'COMPTE HORS LIGNE :';
		map['intro.offline_descr'] = 'Vos données ne seront stockées que sur votre appareil, et seront en sécurité tant que vous ne désinstallez pas l\'application ou ne changez pas de téléphone. Pour éviter toute perte de données, il est recommandé de réaliser régulièrement une sauvegarde depuis les paramètres de l\'application.';
		map['intro.offline_start'] = 'Démarrer une session hors ligne';
		map['intro.sl1_title'] = 'Choisissez votre devise';
		map['intro.sl1_descr'] = 'Votre devise par défaut sera utilisée dans les rapports et graphiques généraux. Vous pourrez changer la devise et la langue de l\'application plus tard à tout moment dans les paramètres.';
		map['intro.sl2_title'] = 'Sûr, privé et fiable';
		map['intro.sl2_descr'] = 'Vos données n\'appartiennent qu\'à vous. Nous stockons les informations directement sur votre appareil, sans passer par des serveurs externes. Cela permet d\'utiliser l\'application même sans Internet.';
		map['intro.sl2_descr2'] = 'De plus, le code source de l\'application est public ; tout le monde peut y collaborer et voir comment elle fonctionne.';
		map['intro.last_slide_title'] = 'Tout est prêt';
		map['intro.last_slide_descr'] = 'Avec Monekin, vous pouvez enfin atteindre l\'indépendance financière que vous désirez tant. Vous disposerez de graphiques, budgets, conseils, statistiques et bien plus encore sur votre argent.';
		map['intro.last_slide_descr2'] = 'Nous espérons que vous apprécierez votre expérience ! N\'hésitez pas à nous contacter en cas de doutes, de suggestions...';
		map['home.title'] = 'Tableau de bord';
		map['home.filter_transactions'] = 'Filtrer les transactions';
		map['home.hello_day'] = 'Bonjour,';
		map['home.hello_night'] = 'Bonsoir,';
		map['home.total_balance'] = 'Solde total';
		map['home.my_accounts'] = 'Mes comptes';
		map['home.active_accounts'] = 'Comptes actifs';
		map['home.no_accounts'] = 'Aucun compte créé pour le moment';
		map['home.no_accounts_descr'] = 'Commencez à profiter de toute la magie de Monekin. Créez au moins un compte pour commencer à ajouter des transactions.';
		map['home.last_transactions'] = 'Dernières transactions';
		map['home.should_create_account_header'] = 'Oups !';
		map['home.should_create_account_message'] = 'Vous devez avoir au moins un compte non archivé avant de pouvoir créer des transactions';
		map['financial_health.display'] = 'Santé financière';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Excellent !';
					case GenderContext.female:
						return 'Excellent !';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Bon';
					case GenderContext.female:
						return 'Bon';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Moyen';
					case GenderContext.female:
						return 'Moyen';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Passable';
					case GenderContext.female:
						return 'Passable';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Très mauvais';
					case GenderContext.female:
						return 'Très mauvais';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Données insuffisantes';
					case GenderContext.female:
						return 'Données insuffisantes';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = 'On dirait que nous n\'avons pas assez de dépenses pour calculer votre santé financière. Ajoutez quelques dépenses/recettes sur cette période pour que nous puissions vous aider !';
		map['financial_health.review.descr.very_good'] = 'Félicitations ! Votre santé financière est excellente. Nous espérons que vous continuerez sur cette lancée et à apprendre avec Monekin.';
		map['financial_health.review.descr.good'] = 'Super ! Votre santé financière est bonne. Visitez l\'onglet d\'analyse pour voir comment économiser encore plus !';
		map['financial_health.review.descr.normal'] = 'Votre santé financière est plus ou moins dans la moyenne de la population pour cette période.';
		map['financial_health.review.descr.bad'] = 'Il semble que votre situation financière ne soit pas encore optimale. Explorez le reste des graphiques pour en savoir plus sur vos finances.';
		map['financial_health.review.descr.very_bad'] = 'Hmm, votre santé financière est bien en dessous de ce qu\'elle devrait être. Explorez le reste des graphiques pour en savoir plus sur vos finances.';
		map['financial_health.months_without_income.title'] = 'Taux de survie';
		map['financial_health.months_without_income.subtitle'] = 'Compte tenu de votre solde, durée pendant laquelle vous pourriez vivre sans revenus';
		map['financial_health.months_without_income.text_zero'] = 'Vous ne pourriez pas tenir un mois sans revenus avec ce niveau de dépenses !';
		map['financial_health.months_without_income.text_one'] = 'Vous pourriez difficilement tenir environ un mois sans revenus avec ce niveau de dépenses !';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => 'Vous pourriez survivre environ <b>${n} mois</b> sans revenus avec ce niveau de dépenses.';
		map['financial_health.months_without_income.text_infinite'] = 'Vous pourriez survivre <b>toute votre vie</b> sans revenus avec ce niveau de dépenses.';
		map['financial_health.months_without_income.suggestion'] = 'N\'oubliez pas qu\'il est recommandé de garder ce ratio au-dessus d\'au moins 5 mois. Si vous voyez que vous n\'avez pas un coussin d\'épargne suffisant, réduisez les dépenses inutiles.';
		map['financial_health.months_without_income.insufficient_data'] = 'On dirait que nous n\'avons pas assez de dépenses pour calculer combien de mois vous pourriez survivre sans revenus. Saisissez quelques transactions et revenez ici pour vérifier votre santé financière.';
		map['financial_health.savings_percentage.title'] = 'Pourcentage d\'épargne';
		map['financial_health.savings_percentage.subtitle'] = 'Quelle part de vos revenus n\'est pas dépensée sur cette période';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => 'Félicitations ! Vous avez réussi à épargner <b>${value} %</b> de vos revenus sur cette période. Il semble que vous soyez déjà un expert, continuez comme ça !';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => 'Félicitations, vous avez réussi à épargner <b>${value} %</b> de vos revenus sur cette période.';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => 'Vous avez réussi à épargner <b>${value} %</b> de vos revenus sur cette période. Cependant, nous pensons que vous pouvez encore faire beaucoup mieux !';
		map['financial_health.savings_percentage.text.very_bad'] = 'Oups, vous n\'avez réussi à rien épargner sur cette période.';
		map['financial_health.savings_percentage.suggestion'] = 'N\'oubliez pas qu\'il est conseillé d\'épargner au moins 15 à 20 % de ce que vous gagnez.';
		map['stats.title'] = 'Statistiques';
		map['stats.balance'] = 'Solde';
		map['stats.final_balance'] = 'Solde final';
		map['stats.balance_by_account'] = 'Solde par compte';
		map['stats.balance_by_account_subtitle'] = 'Où ai-je le plus d\'argent ?';
		map['stats.balance_by_currency'] = 'Solde par devise';
		map['stats.balance_by_currency_subtitle'] = 'Combien d\'argent ai-je en devise étrangère ?';
		map['stats.balance_evolution'] = 'Évolution du solde';
		map['stats.balance_evolution_subtitle'] = 'Ai-je plus d\'argent qu\'avant ?';
		map['stats.compared_to_previous_period'] = 'Par rapport à la période précédente';
		map['stats.cash_flow'] = 'Flux de trésorerie';
		map['stats.cash_flow_subtitle'] = 'Est-ce que je dépense moins que ce que je gagne ?';
		map['stats.by_periods'] = 'Par périodes';
		map['stats.by_categories'] = 'Par catégories';
		map['stats.by_tags'] = 'Par tags';
		map['stats.distribution'] = 'Répartition';
		map['stats.finance_health_resume'] = 'Résumé';
		map['stats.finance_health_breakdown'] = 'Détail';
		map['icon_selector.name'] = 'Nom :';
		map['icon_selector.icon'] = 'Icône';
		map['icon_selector.color'] = 'Couleur';
		map['icon_selector.select_icon'] = 'Sélectionner une icône';
		map['icon_selector.select_color'] = 'Sélectionner une couleur';
		map['icon_selector.custom_color'] = 'Couleur personnalisée';
		map['icon_selector.current_color_selection'] = 'Sélection actuelle';
		map['icon_selector.select_account_icon'] = 'Identifiez votre compte';
		map['icon_selector.select_category_icon'] = 'Identifiez votre catégorie';
		map['icon_selector.scopes.transport'] = 'Transport';
		map['icon_selector.scopes.money'] = 'Argent';
		map['icon_selector.scopes.food'] = 'Alimentation';
		map['icon_selector.scopes.medical'] = 'Santé';
		map['icon_selector.scopes.entertainment'] = 'Loisirs';
		map['icon_selector.scopes.technology'] = 'Technologie';
		map['icon_selector.scopes.other'] = 'Autres';
		map['icon_selector.scopes.logos_financial_institutions'] = 'Institutions financières';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Transaction',
				other: 'Transactions',
			);
		map['transaction.create'] = 'Nouvelle transaction';
		map['transaction.new_income'] = 'Nouvelle recette';
		map['transaction.new_expense'] = 'Nouvelle dépense';
		map['transaction.new_success'] = 'Transaction créée avec succès';
		map['transaction.edit'] = 'Modifier la transaction';
		map['transaction.edit_success'] = 'Transaction modifiée avec succès';
		map['transaction.edit_multiple'] = 'Modifier des transactions';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x} transactions modifiées avec succès';
		map['transaction.duplicate'] = 'Cloner la transaction';
		map['transaction.duplicate_short'] = 'Cloner';
		map['transaction.duplicate_warning_message'] = 'Une transaction identique à celle-ci sera créée avec la même date, voulez-vous continuer ?';
		map['transaction.duplicate_success'] = 'Transaction clonée avec succès';
		map['transaction.delete'] = 'Supprimer la transaction';
		map['transaction.delete_warning_message'] = 'Cette action est irréversible. Le solde actuel de vos comptes et toutes vos statistiques seront recalculés';
		map['transaction.delete_success'] = 'Transaction supprimée avec succès';
		map['transaction.delete_multiple'] = 'Supprimer des transactions';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => 'Cette action est irréversible et supprimera ${x} transactions. Le solde actuel de vos comptes et toutes vos statistiques seront recalculés';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x} transactions supprimées avec succès';
		map['transaction.details'] = 'Détails du mouvement';
		map['transaction.next_payments.accept'] = 'Accepter';
		map['transaction.next_payments.skip'] = 'Ignorer';
		map['transaction.next_payments.skip_success'] = 'Transaction ignorée avec succès';
		map['transaction.next_payments.skip_dialog_title'] = 'Ignorer la transaction';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => 'Cette action est irréversible. Nous déplacerons la date du prochain mouvement au ${date}';
		map['transaction.next_payments.accept_today'] = 'Accepter aujourd\'hui';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => 'Accepter à la date prévue (${date})';
		map['transaction.next_payments.accept_dialog_title'] = 'Accepter la transaction';
		map['transaction.next_payments.accept_dialog_msg_single'] = 'Le nouveau statut de la transaction sera nul. Vous pourrez rééditer le statut de cette transaction quand vous le souhaitez';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => 'Cette action créera une nouvelle transaction avec la date ${date}. Vous pourrez consulter les détails de cette transaction sur la page des transactions';
		map['transaction.next_payments.recurrent_rule_finished'] = 'La règle récurrente est terminée, il n\'y a plus de paiements à effectuer !';
		map['transaction.list.all'] = 'Toutes les transactions';
		map['transaction.list.empty'] = 'Aucune transaction trouvée à afficher ici. Ajoutez quelques transactions dans l\'application et vous aurez peut-être plus de chance la prochaine fois.';
		map['transaction.list.searcher_placeholder'] = 'Rechercher par catégorie, description...';
		map['transaction.list.searcher_no_results'] = 'Aucune transaction ne correspond aux critères de recherche';
		map['transaction.list.loading'] = 'Chargement de nouvelles transactions...';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: '${n} sélectionnée',
				other: '${n} sélectionnées',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: '${n} transaction sélectionnée',
				other: '${n} transactions sélectionnées',
			);
		map['transaction.list.bulk_edit.dates'] = 'Modifier les dates';
		map['transaction.list.bulk_edit.categories'] = 'Modifier les catégories';
		map['transaction.list.bulk_edit.status'] = 'Modifier les statuts';
		map['transaction.filters.title'] = 'Filtres de transactions';
		map['transaction.filters.from_value'] = 'Montant minimum';
		map['transaction.filters.to_value'] = 'Montant maximum';
		map['transaction.filters.from_value_def'] = ({required Object x}) => 'À partir de ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => 'Jusqu\'à ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => 'À partir du ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => 'Jusqu\'au ${date}';
		map['transaction.filters.reset'] = 'Réinitialiser les filtres';
		map['transaction.filters.saved.title'] = 'Filtres enregistrés';
		map['transaction.filters.saved.new_title'] = 'Nouveau filtre';
		map['transaction.filters.saved.edit_title'] = 'Modifier le filtre';
		map['transaction.filters.saved.name_label'] = 'Nom du filtre';
		map['transaction.filters.saved.name_hint'] = 'Mon filtre personnalisé';
		map['transaction.filters.saved.save_dialog_title'] = 'Enregistrer le filtre';
		map['transaction.filters.saved.save_tooltip'] = 'Enregistrer le filtre actuel';
		map['transaction.filters.saved.load_tooltip'] = 'Charger un filtre enregistré';
		map['transaction.filters.saved.empty_title'] = 'Aucun filtre enregistré trouvé';
		map['transaction.filters.saved.empty_description'] = 'Enregistrez des filtres ici pour y accéder rapidement plus tard.';
		map['transaction.filters.saved.save_success'] = 'Filtre enregistré avec succès';
		map['transaction.filters.saved.delete_success'] = 'Filtre supprimé avec succès';
		map['transaction.form.validators.zero'] = 'La valeur d\'une transaction ne peut pas être égale à zéro';
		map['transaction.form.validators.date_max'] = 'La date sélectionnée est postérieure à la date actuelle. La transaction sera ajoutée comme en attente';
		map['transaction.form.validators.date_after_account_creation'] = 'Vous ne pouvez pas créer une transaction dont la date est antérieure à la date de création du compte auquel elle appartient';
		map['transaction.form.validators.negative_transfer'] = 'Le montant d\'un virement ne peut pas être négatif';
		map['transaction.form.validators.transfer_between_same_accounts'] = 'Le compte d\'origine et le compte de destination ne peuvent pas être identiques';
		map['transaction.form.title'] = 'Titre de la transaction';
		map['transaction.form.title_short'] = 'Titre';
		map['transaction.form.value'] = 'Montant de la transaction';
		map['transaction.form.tap_to_see_more'] = 'Touchez pour voir plus de détails';
		map['transaction.form.no_tags'] = '-- Aucun tag --';
		map['transaction.form.description'] = 'Description';
		map['transaction.form.description_info'] = 'Touchez ici pour saisir une description plus détaillée de cette transaction';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => 'Taux de change vers ${currency}';
		map['transaction.form.exchange_to_preferred_in_date'] = 'À la date de la transaction';
		map['transaction.reversed.title'] = 'Transaction inversée';
		map['transaction.reversed.title_short'] = 'Trans. inverse';
		map['transaction.reversed.description_for_expenses'] = 'Bien qu\'il s\'agisse d\'une dépense, elle a un montant positif. Ce type de transaction peut être utilisé pour représenter le retour d\'une dépense déjà enregistrée, comme un remboursement ou le paiement d\'une dette.';
		map['transaction.reversed.description_for_incomes'] = 'Bien qu\'il s\'agisse d\'une recette, elle a un montant négatif. Ce type de transaction peut être utilisé pour annuler ou corriger un revenu enregistré de manière incorrecte, pour refléter un retour ou un remboursement d\'argent ou pour enregistrer le paiement de dettes.';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Statut',
				other: 'Statuts',
			);
		map['transaction.status.display_long'] = 'Statut de la transaction';
		map['transaction.status.tr_status'] = ({required Object status}) => 'Transaction ${status}';
		map['transaction.status.none'] = 'Sans statut';
		map['transaction.status.none_descr'] = 'Transaction sans état spécifique';
		map['transaction.status.reconciled'] = 'Rapprochée';
		map['transaction.status.reconciled_descr'] = 'Cette transaction a déjà été validée et correspond à une transaction réelle de votre banque';
		map['transaction.status.unreconciled'] = 'Non rapprochée';
		map['transaction.status.unreconciled_descr'] = 'Cette transaction n\'a pas encore été validée et n\'apparaît donc pas encore dans vos comptes bancaires réels. Cependant, elle est prise en compte pour le calcul des soldes et des statistiques dans Monekin';
		map['transaction.status.pending'] = 'En attente';
		map['transaction.status.pending_descr'] = 'Cette transaction est en attente et ne sera donc pas prise en compte dans le calcul des soldes et des statistiques';
		map['transaction.status.voided'] = 'Annulée';
		map['transaction.status.voided_descr'] = 'Transaction annulée en raison d\'une erreur de paiement ou pour toute autre raison. Elle ne sera pas prise en compte dans le calcul des soldes et des statistiques';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Type de transaction',
				other: 'Types de transactions',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Recette',
				other: 'Recettes',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Dépense',
				other: 'Dépenses',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Virement',
				other: 'Virements',
			);
		map['transfer.display'] = 'Virement';
		map['transfer.transfers'] = 'Virements';
		map['transfer.transfer_to'] = ({required Object account}) => 'Virement vers ${account}';
		map['transfer.create'] = 'Nouveau virement';
		map['transfer.need_two_accounts_warning_header'] = 'Oups !';
		map['transfer.need_two_accounts_warning_message'] = 'Au moins deux comptes sont nécessaires pour effectuer cette action. Si vous devez ajuster ou modifier le solde actuel de ce compte, cliquez sur le bouton de modification';
		map['transfer.form.from'] = 'Compte d\'origine';
		map['transfer.form.to'] = 'Compte de destination';
		map['transfer.form.value_in_destiny.title'] = 'Montant transféré au compte de destination';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} vers le compte cible';
		map['recurrent_transactions.title'] = 'Transactions récurrentes';
		map['recurrent_transactions.title_short'] = 'Trans. récurrentes';
		map['recurrent_transactions.empty'] = 'Il semble que vous n\'ayez pas de transactions récurrentes. Créez une transaction récurrente mensuelle, annuelle ou hebdomadaire et elle apparaîtra ici';
		map['recurrent_transactions.total_expense_title'] = 'Dépense totale par période';
		map['recurrent_transactions.total_expense_descr'] = '* Sans tenir compte de la date de début et de fin de chaque récurrence';
		map['recurrent_transactions.details.title'] = 'Transaction récurrente';
		map['recurrent_transactions.details.descr'] = 'Les prochains mouvements pour cette transaction sont indiqués ci-dessous. Vous pouvez accepter le premier mouvement ou l\'ignorer';
		map['recurrent_transactions.details.last_payment_info'] = 'Ce mouvement est le dernier de la règle récurrente, cette règle sera donc automatiquement supprimée lors de la confirmation de cette action';
		map['recurrent_transactions.details.delete_header'] = 'Supprimer la transaction récurrente';
		map['recurrent_transactions.details.delete_message'] = 'Cette action est irréversible et n\'affectera pas les transactions que vous avez déjà confirmées/payées';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => 'Retard de ${x} j';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => 'Dans ${x} jours';
		map['account.details'] = 'Détails du compte';
		map['account.date'] = 'Date d\'ouverture';
		map['account.close_date'] = 'Date de clôture';
		map['account.reopen'] = 'Rouvrir le compte';
		map['account.reopen_short'] = 'Rouvrir';
		map['account.reopen_descr'] = 'Êtes-vous sûr de vouloir rouvrir ce compte ?';
		map['account.balance'] = 'Solde du compte';
		map['account.n_transactions'] = 'Nombre de transactions';
		map['account.add_money'] = 'Ajouter de l\'argent';
		map['account.withdraw_money'] = 'Retirer de l\'argent';
		map['account.no_accounts'] = 'Aucun compte trouvé à afficher ici. Ajoutez un compte en cliquant sur le bouton « + » en bas';
		map['account.types.title'] = 'Type de compte';
		map['account.types.warning'] = 'Une fois le type de compte choisi, il ne pourra plus être modifié dans le futur';
		map['account.types.normal'] = 'Compte normal';
		map['account.types.normal_descr'] = 'Utile pour enregistrer vos finances du quotidien. C\'est le type de compte le plus courant, il vous permet d\'ajouter des dépenses, des recettes...';
		map['account.types.saving'] = 'Compte d\'épargne';
		map['account.types.saving_descr'] = 'Vous ne pourrez y ajouter et y retirer de l\'argent qu\'à partir d\'autres comptes. Parfait pour commencer à économiser';
		map['account.form.name'] = 'Nom du compte';
		map['account.form.name_placeholder'] = 'Ex : Compte épargne';
		map['account.form.notes'] = 'Notes';
		map['account.form.notes_placeholder'] = 'Saisissez des notes/une description à propos de ce compte';
		map['account.form.initial_balance'] = 'Solde initial';
		map['account.form.current_balance'] = 'Solde actuel';
		map['account.form.create'] = 'Créer le compte';
		map['account.form.edit'] = 'Modifier le compte';
		map['account.form.currency_not_found_warn'] = 'Vous n\'avez pas d\'informations sur les taux de change pour cette devise. 1.0 sera utilisé comme taux de change par défaut. Vous pouvez modifier cela dans les paramètres';
		map['account.form.already_exists'] = 'Un autre compte avec le même nom existe déjà, veuillez en choisir un autre';
		map['account.form.tr_before_opening_date'] = 'Il existe des transactions sur ce compte avec une date antérieure à la date d\'ouverture';
		map['account.form.iban'] = 'IBAN';
		map['account.form.swift'] = 'SWIFT';
		map['account.delete.warning_header'] = 'Supprimer le compte ?';
		map['account.delete.warning_text'] = 'Cette action supprimera ce compte et toutes ses transactions';
		map['account.delete.success'] = 'Compte supprimé avec succès';
		map['account.close.title'] = 'Clôturer le compte';
		map['account.close.title_short'] = 'Clôturer';
		map['account.close.warn'] = 'Ce compte n\'apparaîtra plus dans certains listings et vous ne pourrez pas créer de transactions dessus avec une date postérieure à celle spécifiée ci-dessous. Cette action n\'affecte aucune transaction ni aucun solde, et vous pourrez rouvrir ce compte à tout moment.';
		map['account.close.should_have_zero_balance'] = 'Le solde actuel de ce compte doit être de 0 pour pouvoir le clôturer. Veuillez modifier le compte avant de continuer';
		map['account.close.should_have_no_transactions'] = 'Ce compte comporte des transactions après la date de clôture spécifiée. Supprimez-les ou modifiez la date de clôture du compte avant de continuer';
		map['account.close.success'] = 'Compte clôturé avec succès';
		map['account.close.unarchive_succes'] = 'Compte rouvert avec succès';
		map['account.select.one'] = 'Sélectionnez un compte';
		map['account.select.all'] = 'Tous les comptes';
		map['account.select.multiple'] = 'Sélectionnez des comptes';
		map['currencies.currency_converter'] = 'Convertisseur de devises';
		map['currencies.currency'] = 'Devise';
		map['currencies.currency_settings'] = 'Paramètres de devise';
		map['currencies.currency_manager'] = 'Gestionnaire de devises';
		map['currencies.currency_manager_descr'] = 'Configurez votre devise et ses taux de change avec les autres';
		map['currencies.preferred_currency'] = 'Devise de base/préférée';
		map['currencies.tap_to_change_preferred_currency'] = 'Appuyez pour modifier';
		map['currencies.change_preferred_currency_title'] = 'Changer la devise préférée';
		map['currencies.change_preferred_currency_msg'] = 'Toutes les statistiques et budgets seront affichés dans cette devise à partir de maintenant. Les comptes et transactions conserveront la devise qu\'ils avaient. Tous les taux de change enregistrés seront supprimés si vous effectuez cette action. Voulez-vous continuer ?';
		map['currencies.exchange_rate_form.equal_to_preferred_warn'] = 'La devise ne peut pas être identique à la devise de l\'utilisateur';
		map['currencies.exchange_rate_form.override_existing_warn'] = 'Un taux de change pour cette devise à cette date existe déjà. Si vous continuez, le précédent sera écrasé';
		map['currencies.exchange_rate_form.specify_a_currency'] = 'Veuillez spécifier une devise';
		map['currencies.exchange_rate_form.add'] = 'Ajouter un taux de change';
		map['currencies.exchange_rate_form.add_success'] = 'Taux de change ajouté avec succès';
		map['currencies.exchange_rate_form.edit'] = 'Modifier le taux de change';
		map['currencies.exchange_rate_form.edit_success'] = 'Taux de change modifié avec succès';
		map['currencies.exchange_rate_form.remove_all'] = 'Supprimer tous les taux de change';
		map['currencies.exchange_rate_form.remove_all_warning'] = 'Cette action est irréversible et supprimera tous les taux de change de cette devise';
		map['currencies.types.display'] = 'Type de devise';
		map['currencies.types.fiat'] = 'DÉCRET';
		map['currencies.types.crypto'] = 'Crypto-monnaie';
		map['currencies.types.other'] = 'Autre';
		map['currencies.currency_form.name'] = 'Nom d\'affichage';
		map['currencies.currency_form.code'] = 'Code de devise';
		map['currencies.currency_form.symbol'] = 'Symbole';
		map['currencies.currency_form.decimal_digits'] = 'Chiffres décimaux';
		map['currencies.currency_form.create'] = 'Créer une devise';
		map['currencies.currency_form.create_success'] = 'Devise créée avec succès';
		map['currencies.currency_form.edit'] = 'Modifier la devise';
		map['currencies.currency_form.edit_success'] = 'Devise modifiée avec succès';
		map['currencies.currency_form.delete'] = 'Supprimer la devise';
		map['currencies.currency_form.delete_success'] = 'Devise supprimée avec succès';
		map['currencies.currency_form.already_exists'] = 'Une devise avec ce code existe déjà. Vous voudrez peut-être le modifier';
		map['currencies.delete_all_success'] = 'Taux de change supprimés avec succès';
		map['currencies.historical'] = 'Taux historiques';
		map['currencies.historical_empty'] = 'Aucun taux de change historique trouvé pour cette devise';
		map['currencies.exchange_rate'] = 'Taux de change';
		map['currencies.exchange_rates'] = 'Taux de change';
		map['currencies.min_exchange_rate'] = 'Taux de change minimum';
		map['currencies.max_exchange_rate'] = 'Taux de change maximum';
		map['currencies.empty'] = 'Ajoutez ici des taux de change pour que, si vous avez des comptes dans d\'autres devises que votre devise de base, nos graphiques soient plus précis';
		map['currencies.select_a_currency'] = 'Sélectionnez une devise';
		map['currencies.search'] = 'Rechercher par nom ou par code de devise';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: 'Tag',
				other: 'Tags',
			);
		map['tags.form.name'] = 'Nom du tag';
		map['tags.form.description'] = 'Description';
		map['tags.select.title'] = 'Sélectionnez des tags';
		map['tags.select.all'] = 'Tous les tags';
		map['tags.empty_list'] = 'Vous n\'avez encore créé aucun tag. Les tags et catégories sont un excellent moyen de catégoriser vos mouvements';
		map['tags.without_tags'] = 'Sans tag';
		map['tags.add'] = 'Ajouter un tag';
		map['tags.create'] = 'Créer une étiquette';
		map['tags.create_success'] = 'Étiquette créée avec succès';
		map['tags.already_exists'] = 'Ce nom de tag existe déjà. Vous voulez peut-être le modifier';
		map['tags.edit'] = 'Modifier le tag';
		map['tags.edit_success'] = 'Tag modifié avec succès';
		map['tags.delete_success'] = 'Tag supprimé avec succès';
		map['tags.delete_warning_header'] = 'Supprimer le tag ?';
		map['tags.delete_warning_message'] = 'Cette action ne supprimera pas les transactions qui ont ce tag.';
		map['categories.unknown'] = 'Catégorie inconnue';
		map['categories.create'] = 'Créer une catégorie';
		map['categories.create_success'] = 'Catégorie créée avec succès';
		map['categories.new_category'] = 'Nouvelle catégorie';
		map['categories.already_exists'] = 'Le nom de cette catégorie existe déjà. Vous voulez peut-être la modifier';
		map['categories.edit'] = 'Modifier la catégorie';
		map['categories.edit_success'] = 'Catégorie modifiée avec succès';
		map['categories.name'] = 'Nom de la catégorie';
		map['categories.type'] = 'Type de catégorie';
		map['categories.both_types'] = 'Les deux types';
		map['categories.subcategories'] = 'Sous-catégories';
		map['categories.subcategories_add'] = 'Ajouter une sous-catégorie';
		map['categories.make_parent'] = 'Transformer en catégorie';
		map['categories.make_child'] = 'Transformer en sous-catégorie';
		map['categories.make_child_warning1'] = ({required Object destiny}) => 'Cette catégorie et ses sous-catégories deviendront des sous-catégories de <b>${destiny}</b>.';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => 'Leurs transactions <b>(${x})</b> seront déplacées vers les nouvelles sous-catégories créées dans la catégorie <b>${destiny}</b>.';
		map['categories.make_child_success'] = 'Sous-catégories créées avec succès';
		map['categories.merge'] = 'Fusionner avec une autre catégorie';
		map['categories.merge_warning1'] = ({required Object x, required Object from, required Object destiny}) => 'Toutes les transactions (${x}) associées à la catégorie <b>${from}</b> seront déplacées vers la catégorie <b>${destiny}</b>';
		map['categories.merge_warning2'] = ({required Object from}) => 'La catégorie <b>${from}</b> sera définitivement supprimée.';
		map['categories.merge_success'] = 'Catégorie fusionnée avec succès';
		map['categories.delete_success'] = 'Catégorie supprimée avec succès';
		map['categories.delete_warning_header'] = 'Supprimer la catégorie ?';
		map['categories.delete_warning_message'] = ({required Object x}) => 'Cette action supprimera définitivement toutes les transactions <b>(${x})</b> liées à cette catégorie.';
		map['categories.select.title'] = 'Sélectionner des catégories';
		map['categories.select.select_one'] = 'Sélectionner une catégorie';
		map['categories.select.select_subcategory'] = 'Choisir une sous-catégorie';
		map['categories.select.without_subcategory'] = 'Sans sous-catégorie';
		map['categories.select.all'] = 'Toutes les catégories';
		map['categories.select.all_short'] = 'Toutes';
		map['budgets.title'] = 'Budgets';
		map['budgets.repeated'] = 'Récurrents';
		map['budgets.one_time'] = 'Une fois';
		map['budgets.annual'] = 'Annuels';
		map['budgets.week'] = 'Hebdomadaires';
		map['budgets.month'] = 'Mensuels';
		map['budgets.actives'] = 'Actifs';
		map['budgets.pending'] = 'En attente de démarrage';
		map['budgets.finish'] = 'Terminés';
		map['budgets.from_budgeted'] = 'restant sur ';
		map['budgets.days_left'] = 'jours restants';
		map['budgets.days_to_start'] = 'jours avant le début';
		map['budgets.since_expiration'] = 'jours depuis l\'expiration';
		map['budgets.no_budgets'] = 'Il ne semble pas y avoir de budgets à afficher dans cette section. Commencez par créer un budget en cliquant sur le bouton ci-dessous';
		map['budgets.delete'] = 'Supprimer le budget';
		map['budgets.delete_warning'] = 'Cette action est irréversible. Les catégories et transactions faisant référence à ce budget ne seront pas supprimées';
		map['budgets.form.title'] = 'Ajouter un budget';
		map['budgets.form.name'] = 'Nom du budget';
		map['budgets.form.value'] = 'Montant limite';
		map['budgets.form.create'] = 'Ajouter un budget';
		map['budgets.form.create_success'] = 'Budget créé avec succès';
		map['budgets.form.edit'] = 'Modifier le budget';
		map['budgets.form.edit_success'] = 'Budget modifié avec succès';
		map['budgets.form.negative_warn'] = 'Les budgets ne peuvent pas avoir un montant négatif';
		map['budgets.details.title'] = 'Détails du budget';
		map['budgets.details.statistics'] = 'Statistiques';
		map['budgets.details.budget_value'] = 'Budgeté';
		map['budgets.details.expend_evolution'] = 'Évolution des dépenses';
		map['budgets.details.no_transactions'] = 'Il semble que vous n\'ayez pas encore fait de dépenses liées à ce budget';
		map['budgets.target_timeline_statuses.active'] = 'Budget actif';
		map['budgets.target_timeline_statuses.past'] = 'Budget passé';
		map['budgets.target_timeline_statuses.future'] = 'Budget futur';
		map['budgets.progress.labels.active_on_track'] = 'En bonne voie';
		map['budgets.progress.labels.active_overspending'] = 'Dépenses excessives';
		map['budgets.progress.labels.success'] = 'Atteint';
		map['budgets.progress.labels.fail'] = 'Budget dépassé';
		map['budgets.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'Vous pouvez dépenser ${dailyAmount} par jour pour les ${remainingDays} jours restants';
		map['budgets.progress.description.active_overspending'] = ({required Object dailyAmount, required Object remainingDays}) => 'Pour revenir sur la bonne voie, vous devriez limiter vos dépenses à ${dailyAmount} par jour pour les ${remainingDays} jours restants';
		map['budgets.progress.description.active_exceeded'] = ({required Object amount}) => 'Vous avez déjà dépassé votre limite budgétaire de ${amount}. Si vous ne trouvez aucun revenu pour ce budget, vous devriez arrêter de dépenser pour le reste de sa période';
		map['budgets.progress.description.success'] = 'Bon travail ! Ce budget est terminé avec succès. Continuez à créer des budgets pour gérer vos dépenses';
		map['budgets.progress.description.fail'] = ({required Object amount}) => 'Vous avez dépassé le budget de ${amount}. Essayez d\'être plus prudent la prochaine fois !';
		map['target_timeline_statuses.active'] = 'Actif';
		map['target_timeline_statuses.past'] = 'Passé';
		map['target_timeline_statuses.future'] = 'Futur';
		map['backup.no_file_selected'] = 'Aucun fichier sélectionné';
		map['backup.no_directory_selected'] = 'Aucun dossier sélectionné';
		map['backup.export.title'] = 'Exporter vos données';
		map['backup.export.title_short'] = 'Exporter';
		map['backup.export.type_of_export'] = 'Type d\'export';
		map['backup.export.other_options'] = 'Options';
		map['backup.export.all'] = 'Sauvegarde complète';
		map['backup.export.all_descr'] = 'Exportez toutes vos données (comptes, transactions, budgets, paramètres...). Importez-les à nouveau à tout moment pour ne rien perdre.';
		map['backup.export.transactions'] = 'Sauvegarde des transactions';
		map['backup.export.transactions_descr'] = 'Exportez vos transactions en CSV pour pouvoir les analyser plus facilement dans d\'autres programmes ou applications.';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
				one: '1 transaction à exporter',
				other: '${n} transactions à exporter',
			);
		map['backup.export.description'] = 'Téléchargez vos données dans différents formats';
		map['backup.export.send_file'] = 'Envoyer le fichier';
		map['backup.export.see_folder'] = 'Voir le dossier';
		map['backup.export.success'] = ({required Object x}) => 'Fichier enregistré avec succès dans ${x}';
		map['backup.export.error'] = 'Erreur lors du téléchargement du fichier. Veuillez contacter le développeur via lozin.technologies@gmail.com';
		map['backup.import.title'] = 'Importer vos données';
		map['backup.import.title_short'] = 'Importer';
		map['backup.import.restore_backup'] = 'Restaurer une sauvegarde';
		map['backup.import.restore_backup_descr'] = 'Importez une base de données Monekin préalablement sauvegardée. Cette action remplacera toutes les données actuelles de l\'application par les nouvelles données';
		map['backup.import.restore_backup_warn_description'] = 'Lors de l\'import d\'une nouvelle base de données, vous perdrez toutes les données actuellement enregistrées dans l\'application. Il est recommandé de réaliser une sauvegarde avant de continuer. N\'importez ici aucun fichier dont vous ne connaissez pas l\'origine ; importez uniquement des fichiers que vous avez préalablement téléchargés depuis Monekin';
		map['backup.import.restore_backup_warn_title'] = 'Écraser toutes les données';
		map['backup.import.select_other_file'] = 'Sélectionner un autre fichier';
		map['backup.import.tap_to_select_file'] = 'Touchez pour sélectionner un fichier';
		map['backup.import.manual_import.title'] = 'Import manuel';
		map['backup.import.manual_import.descr'] = 'Importez des transactions depuis un fichier .csv manuellement';
		map['backup.import.manual_import.default_account'] = 'Compte par défaut';
		map['backup.import.manual_import.remove_default_account'] = 'Supprimer le compte par défaut';
		map['backup.import.manual_import.default_category'] = 'Catégorie par défaut';
		map['backup.import.manual_import.select_a_column'] = 'Sélectionnez une colonne du .csv';
		map['backup.import.manual_import.steps.0'] = 'Sélectionnez votre fichier';
		map['backup.import.manual_import.steps.1'] = 'Colonne pour le montant';
		map['backup.import.manual_import.steps.2'] = 'Colonne pour le compte';
		map['backup.import.manual_import.steps.3'] = 'Colonne pour la catégorie';
		map['backup.import.manual_import.steps.4'] = 'Colonne pour la date';
		map['backup.import.manual_import.steps.5'] = 'autres colonnes';
		map['backup.import.manual_import.steps_descr.0'] = 'Sélectionnez un fichier .csv depuis votre appareil. Assurez-vous qu\'il possède une première ligne décrivant le nom de chaque colonne';
		map['backup.import.manual_import.steps_descr.1'] = 'Sélectionnez la colonne où la valeur de chaque transaction est spécifiée. Utilisez des valeurs négatives pour les dépenses et positives pour les recettes. Utilisez un point comme séparateur décimal';
		map['backup.import.manual_import.steps_descr.2'] = 'Sélectionnez la colonne où est spécifié le compte auquel appartient chaque transaction. Vous pouvez également sélectionner un compte par défaut au cas où nous ne pourrions pas trouver le compte souhaité. Si aucun compte par défaut n\'est spécifié, nous en créerons un avec le même nom';
		map['backup.import.manual_import.steps_descr.3'] = 'Indiquez la colonne où se trouve le nom de la catégorie de la transaction. Vous devez spécifier une catégorie par défaut pour que nous l\'assignions aux transactions si la catégorie ne peut pas être trouvée';
		map['backup.import.manual_import.steps_descr.4'] = 'Sélectionnez la colonne où la date de chaque transaction est spécifiée. Si elle n\'est pas indiquée, les transactions seront créées avec la date actuelle';
		map['backup.import.manual_import.steps_descr.5'] = 'Indiquez les colonnes pour les autres attributs optionnels de la transaction';
		map['backup.import.manual_import.success'] = ({required Object x}) => '${x} transactions importées avec succès';
		map['backup.import.success'] = 'Import réalisé avec succès';
		map['backup.import.error'] = 'Erreur lors de l\'import du fichier. Veuillez contacter le développeur via lozin.technologies@gmail.com';
		map['backup.about.title'] = 'Informations sur votre base de données';
		map['backup.about.create_date'] = 'Date de création';
		map['backup.about.modify_date'] = 'Dernière modification';
		map['backup.about.last_backup'] = 'Dernière sauvegarde';
		map['backup.about.size'] = 'Taille';
		map['settings.title_long'] = 'Paramètres et Personnalisation';
		map['settings.title_short'] = 'Paramètres';
		map['settings.description'] = 'Thème, Langue, Données et plus';
		map['settings.edit_profile'] = 'Modifier le profil';
		map['settings.general.menu_title'] = 'Paramètres généraux';
		map['settings.general.menu_descr'] = 'Langue, confidentialité et plus';
		map['settings.general.language.section'] = 'Langue et textes';
		map['settings.general.language.title'] = 'Langue de l\'application';
		map['settings.general.language.descr'] = 'Langue dans laquelle les textes seront affichés dans l\'application';
		map['settings.general.language.help'] = 'Si vous souhaitez contribuer aux traductions de cette application, vous pouvez consulter <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>notre guide</a>';
		map['settings.general.locale.title'] = 'Région';
		map['settings.general.locale.auto'] = 'Système';
		map['settings.general.locale.descr'] = 'Définissez le format à utiliser pour les dates, les nombres...';
		map['settings.general.locale.warn'] = 'Lors du changement de région, l\'application va se mettre à jour';
		map['settings.general.locale.first_day_of_week'] = 'Premier jour de la semaine';
		map['settings.security.title'] = 'Sécurité';
		map['settings.security.private_mode_at_launch'] = 'Mode privé au démarrage';
		map['settings.security.private_mode_at_launch_descr'] = 'Lancer l\'application en mode privé par défaut';
		map['settings.security.private_mode'] = 'Mode privé';
		map['settings.security.private_mode_descr'] = 'Masquer toutes les valeurs monétaires';
		map['settings.security.private_mode_activated'] = 'Mode privé activé';
		map['settings.security.private_mode_deactivated'] = 'Mode privé désactivé';
		map['settings.transactions.menu_title'] = 'Transactions';
		map['settings.transactions.menu_descr'] = 'Configurer le comportement de vos transactions';
		map['settings.transactions.title'] = 'Paramètres des transactions';
		map['settings.transactions.swipe_actions.title'] = 'Actions de balayage';
		map['settings.transactions.swipe_actions.choose_description'] = 'Choisissez l\'action qui sera déclenchée lorsque vous balayez un élément de transaction dans la liste dans cette direction';
		map['settings.transactions.swipe_actions.swipe_left'] = 'Balayage vers la gauche';
		map['settings.transactions.swipe_actions.swipe_right'] = 'Balayage vers la droite';
		map['settings.transactions.swipe_actions.none'] = 'Aucune action';
		map['settings.transactions.swipe_actions.toggle_reconciled'] = 'Basculer rapprochée';
		map['settings.transactions.swipe_actions.toggle_pending'] = 'Basculer en attente';
		map['settings.transactions.swipe_actions.toggle_voided'] = 'Basculer annulée';
		map['settings.transactions.swipe_actions.toggle_unreconciled'] = 'Basculer non rapprochée';
		map['settings.transactions.swipe_actions.remove_status'] = 'Supprimer le statut';
		map['settings.transactions.default_values.title'] = 'Valeurs par défaut du formulaire';
		map['settings.transactions.default_values.page_title'] = 'Nouvelle transaction : Valeurs par défaut';
		map['settings.transactions.default_values.reuse_last_transaction'] = 'Réutiliser les valeurs de la dernière transaction';
		map['settings.transactions.default_values.reuse_last_transaction_descr'] = 'Remplir automatiquement le formulaire avec certaines valeurs de la dernière transaction créée';
		map['settings.transactions.default_values.fields_to_reuse'] = 'Champs à réutiliser';
		map['settings.transactions.default_values.reuse_last_values_modal_descr'] = 'Sélectionnez les champs qui doivent être pré-remplis avec les valeurs de la dernière transaction créée.';
		map['settings.transactions.default_values.default_values_separator'] = 'Valeurs par défaut';
		map['settings.transactions.default_values.default_category'] = 'Catégorie par défaut';
		map['settings.transactions.default_values.default_status'] = 'Statut par défaut';
		map['settings.transactions.default_values.default_tags'] = 'Étiquettes par défaut';
		map['settings.transactions.default_values.no_tags_selected'] = 'Aucune étiquette sélectionnée';
		map['settings.transactions.default_type.title'] = 'Type par défaut';
		map['settings.transactions.default_type.modal_title'] = 'Sélectionner le type par défaut';
		map['settings.appearance.menu_title'] = 'Thème et style';
		map['settings.appearance.menu_descr'] = 'Sélection du thème, couleurs et autres éléments liés à l\'apparence de l\'application';
		map['settings.appearance.theme_and_colors'] = 'Thème et couleurs';
		map['settings.appearance.theme.title'] = 'Thème';
		map['settings.appearance.theme.auto'] = 'Système';
		map['settings.appearance.theme.light'] = 'Clair';
		map['settings.appearance.theme.dark'] = 'Sombre';
		map['settings.appearance.amoled_mode'] = 'Mode AMOLED';
		map['settings.appearance.amoled_mode_descr'] = 'Utiliser un fond noir pur lorsque c\'est possible. Cela aidera légèrement la batterie des appareils avec écran AMOLED';
		map['settings.appearance.dynamic_colors'] = 'Couleurs dynamiques';
		map['settings.appearance.dynamic_colors_descr'] = 'Utiliser la couleur d\'accent de votre système lorsque c\'est possible';
		map['settings.appearance.accent_color'] = 'Couleur d\'accent';
		map['settings.appearance.accent_color_descr'] = 'Choisissez la couleur que l\'application utilisera pour mettre en évidence certaines parties de l\'interface';
		map['settings.appearance.text'] = 'Texte';
		map['settings.appearance.font'] = 'Police';
		map['settings.appearance.font_platform'] = 'Plateforme';
		map['more.title'] = 'Plus';
		map['more.title_long'] = 'Plus d\'actions';
		map['more.data.display'] = 'Données';
		map['more.data.display_descr'] = 'Exportez et importez vos données pour ne rien perdre';
		map['more.data.delete_all'] = 'Supprimer mes données';
		map['more.data.delete_all_header1'] = 'Stop là padawan ⚠️⚠️';
		map['more.data.delete_all_message1'] = 'Êtes-vous sûr de vouloir continuer ? Toutes vos données seront définitivement supprimées et ne pourront pas être récupérées';
		map['more.data.delete_all_header2'] = 'Une dernière étape ⚠️⚠️';
		map['more.data.delete_all_message2'] = 'En supprimant un compte vous supprimerez toutes vos données personnelles enregistrées. Vos comptes, transactions, budgets et catégories seront supprimés et ne pourront pas être récupérés. Êtes-vous d\'accord ?';
		map['more.about_us.display'] = 'Informations sur l\'application';
		map['more.about_us.description'] = 'Consultez les conditions et autres informations importantes sur Monekin. Rejoignez la communauté en signalant des bugs, en laissant des suggestions...';
		map['more.about_us.legal.display'] = 'Informations légales';
		map['more.about_us.legal.privacy'] = 'Politique de confidentialité';
		map['more.about_us.legal.terms'] = 'Conditions d\'utilisation';
		map['more.about_us.legal.licenses'] = 'Licences';
		map['more.about_us.project.display'] = 'Projet';
		map['more.about_us.project.contributors'] = 'Collaborateurs';
		map['more.about_us.project.contributors_descr'] = 'Tous les développeurs qui ont fait grandir Monekin';
		map['more.about_us.project.contact'] = 'Contactez-nous';
		map['more.help_us.display'] = 'Aidez-nous';
		map['more.help_us.description'] = 'Découvrez comment vous pouvez aider Monekin à devenir toujours meilleur';
		map['more.help_us.rate_us'] = 'Notez-nous';
		map['more.help_us.rate_us_descr'] = 'Toutes les notes sont les bienvenues !';
		map['more.help_us.share'] = 'Partager Monekin';
		map['more.help_us.share_descr'] = 'Partagez notre application avec vos amis et votre famille';
		map['more.help_us.share_text'] = 'Monekin ! La meilleure application de finances personnelles. Téléchargez-la ici';
		map['more.help_us.thanks'] = 'Merci !';
		map['more.help_us.thanks_long'] = 'Vos contributions à Monekin et aux autres projets open source, grandes ou petites, rendent possibles de super projets comme celui-ci. Merci de prendre le temps de contribuer.';
		map['more.help_us.donate'] = 'Faire un don';
		map['more.help_us.donate_descr'] = 'Avec votre don, vous aiderez l\'application à continuer de recevoir des améliorations. Quelle meilleure façon de remercier le travail accompli qu\'en m\'invitant à un café ?';
		map['more.help_us.donate_success'] = 'Don effectué. Merci beaucoup pour votre contribution ! ❤️';
		map['more.help_us.donate_err'] = 'Oups ! Il semble qu\'il y ait eu une erreur lors de la réception de votre paiement';
		map['more.help_us.report'] = 'Signaler des bugs, laisser des suggestions...';

		_map = map;
		return map;
	}
}


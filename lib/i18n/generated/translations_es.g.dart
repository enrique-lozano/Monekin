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
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsEs ui_actions = _TranslationsUiActionsEs._(_root);
	@override late final _TranslationsGeneralEs general = _TranslationsGeneralEs._(_root);
	@override late final _TranslationsIntroEs intro = _TranslationsIntroEs._(_root);
	@override late final _TranslationsHomeEs home = _TranslationsHomeEs._(_root);
	@override late final _TranslationsFinancialHealthEs financial_health = _TranslationsFinancialHealthEs._(_root);
	@override late final _TranslationsStatsEs stats = _TranslationsStatsEs._(_root);
	@override late final _TranslationsIconSelectorEs icon_selector = _TranslationsIconSelectorEs._(_root);
	@override late final _TranslationsTransactionEs transaction = _TranslationsTransactionEs._(_root);
	@override late final _TranslationsTransferEs transfer = _TranslationsTransferEs._(_root);
	@override late final _TranslationsRecurrentTransactionsEs recurrent_transactions = _TranslationsRecurrentTransactionsEs._(_root);
	@override late final _TranslationsAccountEs account = _TranslationsAccountEs._(_root);
	@override late final _TranslationsCurrenciesEs currencies = _TranslationsCurrenciesEs._(_root);
	@override late final _TranslationsTagsEs tags = _TranslationsTagsEs._(_root);
	@override late final _TranslationsCategoriesEs categories = _TranslationsCategoriesEs._(_root);
	@override late final _TranslationsBudgetsEs budgets = _TranslationsBudgetsEs._(_root);
	@override late final _TranslationsGoalsEs goals = _TranslationsGoalsEs._(_root);
	@override late final _TranslationsTargetTimelineStatusesEs target_timeline_statuses = _TranslationsTargetTimelineStatusesEs._(_root);
	@override late final _TranslationsBackupEs backup = _TranslationsBackupEs._(_root);
	@override late final _TranslationsSettingsEs settings = _TranslationsSettingsEs._(_root);
	@override late final _TranslationsMoreEs more = _TranslationsMoreEs._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsEs implements TranslationsUiActionsEn {
	_TranslationsUiActionsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Confirmar';
	@override String get continue_text => 'Continuar';
	@override String get save => 'Guardar';
	@override String get save_changes => 'Guardar cambios';
	@override String get close_and_save => 'Guardar y cerrar';
	@override String get add => 'Añadir';
	@override String get edit => 'Editar';
	@override String get delete => 'Eliminar';
	@override String get see_more => 'Ver más';
	@override String get select_all => 'Seleccionar todo';
	@override String get deselect_all => 'Deseleccionar todo';
	@override String get select => 'Seleccionar';
	@override String get search => 'Buscar';
	@override String get filter => 'Filter';
	@override String get reset => 'Restablecer';
	@override String get submit => 'Enviar';
	@override String get next => 'Siguiente';
	@override String get previous => 'Anterior';
	@override String get back => 'Atrás';
	@override String get reload => 'Recargar';
	@override String get view => 'Ver';
	@override String get download => 'Descargar';
	@override String get upload => 'Subir';
	@override String get retry => 'Reintentar';
	@override String get copy => 'Copiar';
	@override String get paste => 'Pegar';
	@override String get undo => 'Deshacer';
	@override String get redo => 'Rehacer';
	@override String get open => 'Abrir';
	@override String get close => 'Cerrar';
	@override String get apply => 'Aplicar';
	@override String get discard => 'Descartar';
	@override String get refresh => 'Actualizar';
	@override String get share => 'Compartir';
}

// Path: general
class _TranslationsGeneralEs implements TranslationsGeneralEn {
	_TranslationsGeneralEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get or => 'o';
	@override String get understood => 'Entendido';
	@override String get unspecified => 'Sin especificar';
	@override String get quick_actions => 'Acciones rápidas';
	@override String get details => 'Detalles';
	@override String get balance => 'Balance';
	@override String get account => 'Cuenta';
	@override String get accounts => 'Cuentas';
	@override String get categories => 'Categorías';
	@override String get category => 'Categoría';
	@override String get today => 'Hoy';
	@override String get yesterday => 'Ayer';
	@override String get filters => 'Filtros';
	@override String get empty_warn => 'Ops! Esto esta muy vacio';
	@override String get search_no_results => 'No hay elementos que coincidan con tus criterios de búsqueda';
	@override String get insufficient_data => 'Datos insuficientes';
	@override String get show_more_fields => 'Show more fields';
	@override String get show_less_fields => 'Show less fields';
	@override String get tap_to_search => 'Toca para buscar';
	@override String get delete_success => 'Elemento eliminado con éxito';
	@override late final _TranslationsGeneralLeaveWithoutSavingEs leave_without_saving = _TranslationsGeneralLeaveWithoutSavingEs._(_root);
	@override late final _TranslationsGeneralClipboardEs clipboard = _TranslationsGeneralClipboardEs._(_root);
	@override late final _TranslationsGeneralTimeEs time = _TranslationsGeneralTimeEs._(_root);
	@override late final _TranslationsGeneralTransactionOrderEs transaction_order = _TranslationsGeneralTransactionOrderEs._(_root);
	@override late final _TranslationsGeneralValidationsEs validations = _TranslationsGeneralValidationsEs._(_root);
}

// Path: intro
class _TranslationsIntroEs implements TranslationsIntroEn {
	_TranslationsIntroEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get start => 'Empecemos';
	@override String get skip => 'Saltar';
	@override String get next => 'Siguiente';
	@override String get select_your_currency => 'Selecciona tu divisa';
	@override String get welcome_subtitle => 'Tu gestor de finanzas personales';
	@override String get welcome_subtitle2 => '100% libre, 100% gratis';
	@override String get welcome_footer => 'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación';
	@override String get offline_descr_title => 'CUENTA SIN CONEXIÓN:';
	@override String get offline_descr => 'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
	@override String get offline_start => 'Iniciar sesión offline';
	@override String get sl1_title => 'Selecciona tu divisa';
	@override String get sl1_descr => 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
	@override String get sl2_title => 'Seguro, privado y confiable';
	@override String get sl2_descr => 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
	@override String get sl2_descr2 => 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
	@override String get last_slide_title => 'Todo listo!';
	@override String get last_slide_descr => 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
	@override String get last_slide_descr2 => 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
}

// Path: home
class _TranslationsHomeEs implements TranslationsHomeEn {
	_TranslationsHomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inicio';
	@override String get filter_transactions => 'Filtrar transacciones';
	@override String get hello_day => 'Buenos días,';
	@override String get hello_night => 'Buenas noches,';
	@override String get total_balance => 'Saldo total';
	@override String get my_accounts => 'Mis cuentas';
	@override String get active_accounts => 'Cuentas activas';
	@override String get no_accounts => 'Aun no hay cuentas creadas';
	@override String get no_accounts_descr => 'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones';
	@override String get last_transactions => 'Últimas transacciones';
	@override String get should_create_account_header => 'Ops!';
	@override String get should_create_account_message => 'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones';
}

// Path: financial_health
class _TranslationsFinancialHealthEs implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Salud financiera';
	@override late final _TranslationsFinancialHealthReviewEs review = _TranslationsFinancialHealthReviewEs._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeEs months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeEs._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageEs savings_percentage = _TranslationsFinancialHealthSavingsPercentageEs._(_root);
}

// Path: stats
class _TranslationsStatsEs implements TranslationsStatsEn {
	_TranslationsStatsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estadísticas';
	@override String get balance => 'Saldo';
	@override String get final_balance => 'Saldo final';
	@override String get balance_by_account => 'Saldo por cuentas';
	@override String get balance_by_account_subtitle => '¿Donde tengo la mayor parte de mi dinero?';
	@override String get balance_by_currency => 'Saldo por divisas';
	@override String get balance_by_currency_subtitle => '¿Cuanto dinero tengo en moneda extranjera?';
	@override String get balance_evolution => 'Tendencia de saldo';
	@override String get balance_evolution_subtitle => '¿Tengo más dinero que antes?';
	@override String get compared_to_previous_period => 'Frente al periodo anterior';
	@override String get cash_flow => 'Flujo de caja';
	@override String get cash_flow_subtitle => '¿Estoy gastando menos de lo que gano?';
	@override String get by_periods => 'Por periodos';
	@override String get by_categories => 'Por categorías';
	@override String get by_tags => 'Por etiquetas';
	@override String get distribution => 'Distribución';
	@override String get finance_health_resume => 'Resumen';
	@override String get finance_health_breakdown => 'Desglose';
}

// Path: icon_selector
class _TranslationsIconSelectorEs implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre:';
	@override String get icon => 'Icono';
	@override String get color => 'Color';
	@override String get select_icon => 'Selecciona un icono';
	@override String get select_color => 'Selecciona un color';
	@override String get custom_color => 'Color personalizado';
	@override String get current_color_selection => 'Selección actual';
	@override String get select_account_icon => 'Identifica tu cuenta';
	@override String get select_category_icon => 'Identifica tu categoría';
	@override late final _TranslationsIconSelectorScopesEs scopes = _TranslationsIconSelectorScopesEs._(_root);
}

// Path: transaction
class _TranslationsTransactionEs implements TranslationsTransactionEn {
	_TranslationsTransactionEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Transacción',
		other: 'Transacciones',
	);
	@override String get create => 'Nueva transacción';
	@override String get new_income => 'Nuevo ingreso';
	@override String get new_expense => 'Nuevo gasto';
	@override String get new_success => 'Transacción creada correctamente';
	@override String get edit => 'Editar transacción';
	@override String get edit_success => 'Transacción editada correctamente';
	@override String get edit_multiple => 'Editar transacciones';
	@override String edit_multiple_success({required Object x}) => '${x} transacciones editadas correctamente';
	@override String get duplicate => 'Clonar transacción';
	@override String get duplicate_short => 'Clonar';
	@override String get duplicate_warning_message => 'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?';
	@override String get duplicate_success => 'Transacción clonada con exito';
	@override String get delete => 'Eliminar transacción';
	@override String get delete_warning_message => 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
	@override String get delete_success => 'Transacción eliminada correctamente';
	@override String get delete_multiple => 'Eliminar transacciones';
	@override String delete_multiple_warning_message({required Object x}) => 'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
	@override String delete_multiple_success({required Object x}) => '${x} transacciones eliminadas correctamente';
	@override String get details => 'Detalles del movimiento';
	@override late final _TranslationsTransactionNextPaymentsEs next_payments = _TranslationsTransactionNextPaymentsEs._(_root);
	@override late final _TranslationsTransactionListEs list = _TranslationsTransactionListEs._(_root);
	@override late final _TranslationsTransactionFiltersEs filters = _TranslationsTransactionFiltersEs._(_root);
	@override late final _TranslationsTransactionFormEs form = _TranslationsTransactionFormEs._(_root);
	@override late final _TranslationsTransactionReversedEs reversed = _TranslationsTransactionReversedEs._(_root);
	@override late final _TranslationsTransactionStatusEs status = _TranslationsTransactionStatusEs._(_root);
	@override late final _TranslationsTransactionTypesEs types = _TranslationsTransactionTypesEs._(_root);
}

// Path: transfer
class _TranslationsTransferEs implements TranslationsTransferEn {
	_TranslationsTransferEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Transferencia';
	@override String get transfers => 'Transferencias';
	@override String transfer_to({required Object account}) => 'Transferencia hacia ${account}';
	@override String get create => 'Nueva transferencia';
	@override String get need_two_accounts_warning_header => 'Ops!';
	@override String get need_two_accounts_warning_message => 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
	@override late final _TranslationsTransferFormEs form = _TranslationsTransferFormEs._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsEs implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Movimientos recurrentes';
	@override String get title_short => 'Mov. recurrentes';
	@override String get empty => 'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
	@override String get total_expense_title => 'Gasto total por periodo';
	@override String get total_expense_descr => '* Sin considerar la fecha de inicio y fin de cada recurrencia';
	@override late final _TranslationsRecurrentTransactionsDetailsEs details = _TranslationsRecurrentTransactionsDetailsEs._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusEs status = _TranslationsRecurrentTransactionsStatusEs._(_root);
}

// Path: account
class _TranslationsAccountEs implements TranslationsAccountEn {
	_TranslationsAccountEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get details => 'Detalles de la cuenta';
	@override String get date => 'Fecha de apertura';
	@override String get close_date => 'Fecha de cierre';
	@override String get reopen => 'Reabrir cuenta';
	@override String get reopen_short => 'Reabrir';
	@override String get reopen_descr => '¿Seguro que quieres volver a abrir esta cuenta?';
	@override String get balance => 'Saldo de la cuenta';
	@override String get n_transactions => 'Número de transacciones';
	@override String get add_money => 'Añadir dinero';
	@override String get withdraw_money => 'Retirar dinero';
	@override String get no_accounts => 'No se han encontrado cuentas que mostrar aquí. Añade una cuenta pulsando el botón \'+\' de la parte inferior';
	@override late final _TranslationsAccountTypesEs types = _TranslationsAccountTypesEs._(_root);
	@override late final _TranslationsAccountFormEs form = _TranslationsAccountFormEs._(_root);
	@override late final _TranslationsAccountDeleteEs delete = _TranslationsAccountDeleteEs._(_root);
	@override late final _TranslationsAccountCloseEs close = _TranslationsAccountCloseEs._(_root);
	@override late final _TranslationsAccountSelectEs select = _TranslationsAccountSelectEs._(_root);
}

// Path: currencies
class _TranslationsCurrenciesEs implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Conversor de divisas';
	@override String get currency => 'Divisa';
	@override String get currency_settings => 'Configuración de la divisa';
	@override String get currency_manager => 'Administrador de divisas';
	@override String get currency_manager_descr => 'Configura tu divisa y sus tipos de cambio con otras';
	@override String get preferred_currency => 'Divisa predeterminada/base';
	@override String get tap_to_change_preferred_currency => 'Toca para cambiar';
	@override String get change_preferred_currency_title => 'Cambiar divisa predeterminada';
	@override String get change_preferred_currency_msg => 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
	@override late final _TranslationsCurrenciesExchangeRateFormEs exchange_rate_form = _TranslationsCurrenciesExchangeRateFormEs._(_root);
	@override late final _TranslationsCurrenciesTypesEs types = _TranslationsCurrenciesTypesEs._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormEs currency_form = _TranslationsCurrenciesCurrencyFormEs._(_root);
	@override String get delete_all_success => 'Tipos de cambio borrados con exito';
	@override String get historical => 'Histórico de tasas';
	@override String get historical_empty => 'No se encontraron tipos de cambio históricos para esta divisa';
	@override String get exchange_rate => 'Tipo de cambio';
	@override String get exchange_rates => 'Tipos de cambio';
	@override String get min_exchange_rate => 'Tipo de cambio mínimo';
	@override String get max_exchange_rate => 'Tipo de cambio máximo';
	@override String get empty => 'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos';
	@override String get select_a_currency => 'Selecciona una divisa';
	@override String get search => 'Busca por nombre o por código de la divisa';
}

// Path: tags
class _TranslationsTagsEs implements TranslationsTagsEn {
	_TranslationsTagsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Etiqueta',
		other: 'Etiquetas',
	);
	@override late final _TranslationsTagsFormEs form = _TranslationsTagsFormEs._(_root);
	@override late final _TranslationsTagsSelectEs select = _TranslationsTagsSelectEs._(_root);
	@override String get empty_list => 'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos';
	@override String get without_tags => 'Sin etiquetas';
	@override String get add => 'Añadir etiqueta';
	@override String get create => 'Crear etiqueta';
	@override String get create_success => 'Etiqueta creada correctamente';
	@override String get already_exists => 'El nombre de esta etiqueta ya existe. Puede que quieras editarla';
	@override String get edit => 'Editar etiqueta';
	@override String get edit_success => 'Etiqueta editada correctamente';
	@override String get delete_success => 'Categoría eliminada correctamente';
	@override String get delete_warning_header => '¿Eliminar etiqueta?';
	@override String get delete_warning_message => 'Esta acción no borrará las transacciones que poseen esta etiqueta.';
}

// Path: categories
class _TranslationsCategoriesEs implements TranslationsCategoriesEn {
	_TranslationsCategoriesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Categoría desconocida';
	@override String get create => 'Crear categoría';
	@override String get create_success => 'Categoría creada correctamente';
	@override String get new_category => 'Nueva categoría';
	@override String get already_exists => 'El nombre de esta categoría ya existe. Puede que quieras editarla';
	@override String get edit => 'Editar categoría';
	@override String get edit_success => 'Categoría editada correctamente';
	@override String get name => 'Nombre de la categoría';
	@override String get type => 'Tipo de categoría';
	@override String get both_types => 'Ambos tipos';
	@override String get subcategories => 'Subcategorías';
	@override String get subcategories_add => 'Añadir subcategoría';
	@override String get make_parent => 'Convertir en categoría';
	@override String get make_child => 'Convertir en subcategoría';
	@override String make_child_warning1({required Object destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.';
	@override String get make_child_success => 'Subcategorías creadas con exito';
	@override String get merge => 'Fusionar con otra categoría';
	@override String merge_warning1({required Object x, required Object from, required Object destiny}) => 'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.';
	@override String merge_warning2({required Object from}) => 'La categoría <b>${from}</b> será eliminada de forma irreversible.';
	@override String get merge_success => 'Categoría fusionada correctamente';
	@override String get delete_success => 'Categoría eliminada correctamente';
	@override String get delete_warning_header => '¿Eliminar categoría?';
	@override String delete_warning_message({required Object x}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.';
	@override late final _TranslationsCategoriesSelectEs select = _TranslationsCategoriesSelectEs._(_root);
}

// Path: budgets
class _TranslationsBudgetsEs implements TranslationsBudgetsEn {
	_TranslationsBudgetsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Presupuestos';
	@override String get status => 'Estado del presupuesto';
	@override String get repeated => 'Periódicos';
	@override String get one_time => 'Una vez';
	@override String get actives => 'Activos';
	@override String get from_budgeted => 'De un total de ';
	@override String get days_left => 'días restantes';
	@override String get days_to_start => 'días para empezar';
	@override String get since_expiration => 'días desde su expiración';
	@override String get no_budgets => 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
	@override String get delete => 'Eliminar presupuesto';
	@override String get delete_warning => 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
	@override late final _TranslationsBudgetsFormEs form = _TranslationsBudgetsFormEs._(_root);
	@override late final _TranslationsBudgetsDetailsEs details = _TranslationsBudgetsDetailsEs._(_root);
	@override late final _TranslationsBudgetsTargetTimelineStatusesEs target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesEs._(_root);
	@override late final _TranslationsBudgetsProgressEs progress = _TranslationsBudgetsProgressEs._(_root);
}

// Path: goals
class _TranslationsGoalsEs implements TranslationsGoalsEn {
	_TranslationsGoalsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Objetivos';
	@override String get status => 'Estado del objetivo';
	@override late final _TranslationsGoalsTypeEs type = _TranslationsGoalsTypeEs._(_root);
	@override String get empty_title => 'No se encontraron objetivos';
	@override String get empty_description => '¡Crea un nuevo objetivo para empezar a seguir tus ahorros!';
	@override String get delete => 'Borrar objetivo';
	@override String get delete_warning => 'Esta acción es irreversible. Categorías y transacciones referentes a este objetivo no serán eliminados';
	@override late final _TranslationsGoalsFormEs form = _TranslationsGoalsFormEs._(_root);
	@override late final _TranslationsGoalsDetailsEs details = _TranslationsGoalsDetailsEs._(_root);
	@override late final _TranslationsGoalsTargetTimelineStatusesEs target_timeline_statuses = _TranslationsGoalsTargetTimelineStatusesEs._(_root);
	@override late final _TranslationsGoalsProgressEs progress = _TranslationsGoalsProgressEs._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesEs implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get active => 'Activo';
	@override String get past => 'Finalizado';
	@override String get future => 'Futuro';
}

// Path: backup
class _TranslationsBackupEs implements TranslationsBackupEn {
	_TranslationsBackupEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => 'Ningún archivo seleccionado';
	@override String get no_directory_selected => 'Ningún directorio seleccionado';
	@override late final _TranslationsBackupExportEs export = _TranslationsBackupExportEs._(_root);
	@override late final _TranslationsBackupImportEs import = _TranslationsBackupImportEs._(_root);
	@override late final _TranslationsBackupAboutEs about = _TranslationsBackupAboutEs._(_root);
}

// Path: settings
class _TranslationsSettingsEs implements TranslationsSettingsEn {
	_TranslationsSettingsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Ajustes y Personalización';
	@override String get title_short => 'Configuración';
	@override String get description => 'Tema, Idioma, Datos y más';
	@override String get edit_profile => 'Editar perfil';
	@override late final _TranslationsSettingsGeneralEs general = _TranslationsSettingsGeneralEs._(_root);
	@override late final _TranslationsSettingsSecurityEs security = _TranslationsSettingsSecurityEs._(_root);
	@override late final _TranslationsSettingsTransactionsEs transactions = _TranslationsSettingsTransactionsEs._(_root);
	@override late final _TranslationsSettingsAppearanceEs appearance = _TranslationsSettingsAppearanceEs._(_root);
}

// Path: more
class _TranslationsMoreEs implements TranslationsMoreEn {
	_TranslationsMoreEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Más';
	@override String get title_long => 'Más acciones';
	@override late final _TranslationsMoreDataEs data = _TranslationsMoreDataEs._(_root);
	@override late final _TranslationsMoreAboutUsEs about_us = _TranslationsMoreAboutUsEs._(_root);
	@override late final _TranslationsMoreHelpUsEs help_us = _TranslationsMoreHelpUsEs._(_root);
}

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingEs implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Salir sin guardar?';
	@override String get message => 'Tienes cambios sin guardar, ¿estás seguro de que quieres continuar y salir sin guardarlos?';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardEs implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} copiado al portapapeles';
	@override String get error => 'Error al copiar';
}

// Path: general.time
class _TranslationsGeneralTimeEs implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Fecha de inicio';
	@override String get end_date => 'Fecha de fin';
	@override String get from_date => 'Desde fecha';
	@override String get until_date => 'Hasta fecha';
	@override String get date => 'Fecha';
	@override String get datetime => 'Fecha y hora';
	@override String get time => 'Hora';
	@override String get each => 'Cada';
	@override String get after => 'Tras';
	@override late final _TranslationsGeneralTimeRangesEs ranges = _TranslationsGeneralTimeRangesEs._(_root);
	@override late final _TranslationsGeneralTimePeriodicityEs periodicity = _TranslationsGeneralTimePeriodicityEs._(_root);
	@override late final _TranslationsGeneralTimeCurrentEs current = _TranslationsGeneralTimeCurrentEs._(_root);
	@override late final _TranslationsGeneralTimeAllEs all = _TranslationsGeneralTimeAllEs._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderEs implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ordenar transacciones';
	@override String get category => 'Por categoría';
	@override String get quantity => 'Por cantidad';
	@override String get date => 'Por fecha';
}

// Path: general.validations
class _TranslationsGeneralValidationsEs implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Corrije los campos indicados en el formulario para continuar';
	@override String get required => 'Campo obligatorio';
	@override String get positive => 'Debe ser positivo';
	@override String min_number({required Object x}) => 'Debe ser mayor que ${x}';
	@override String max_number({required Object x}) => 'Debe ser menor que ${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewEs implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Excelente!';
			case GenderContext.female:
				return 'Excelente!';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Bueno';
			case GenderContext.female:
				return 'Buena';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'En la media';
			case GenderContext.female:
				return 'En la media';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Regular';
			case GenderContext.female:
				return 'Regular';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Muy malo';
			case GenderContext.female:
				return 'Muy mala';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Datos insuficientes';
			case GenderContext.female:
				return 'Datos insuficientes';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrEs descr = _TranslationsFinancialHealthReviewDescrEs._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeEs implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ratio de supervivencia';
	@override String get subtitle => 'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos';
	@override String get text_zero => '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!';
	@override String get text_one => '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!';
	@override String text_other({required Object n}) => 'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.';
	@override String get text_infinite => 'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.';
	@override String get suggestion => 'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.';
	@override String get insufficient_data => 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageEs implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Porcentaje de ahorro';
	@override String get subtitle => 'Que parte de tus ingresos no son gastados en este periodo';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextEs text = _TranslationsFinancialHealthSavingsPercentageTextEs._(_root);
	@override String get suggestion => 'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesEs implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Transporte';
	@override String get money => 'Dinero';
	@override String get food => 'Comida';
	@override String get medical => 'Salud';
	@override String get entertainment => 'Entretenimiento';
	@override String get technology => 'Technología';
	@override String get other => 'Otros';
	@override String get logos_financial_institutions => 'Financial institutions';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsEs implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get accept => 'Aceptar';
	@override String get skip => 'Saltar';
	@override String get skip_success => 'Transacción saltada con exito';
	@override String get skip_dialog_title => 'Saltar transacción';
	@override String skip_dialog_msg({required Object date}) => 'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}';
	@override String get accept_today => 'Aceptar hoy';
	@override String accept_in_required_date({required Object date}) => 'Aceptar en la fecha requerida (${date})';
	@override String get accept_dialog_title => 'Aceptar transacción';
	@override String get accept_dialog_msg_single => 'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees';
	@override String accept_dialog_msg({required Object date}) => 'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones';
	@override String get recurrent_rule_finished => 'La regla recurrente se ha completado, ya no hay mas pagos a realizar!';
}

// Path: transaction.list
class _TranslationsTransactionListEs implements TranslationsTransactionListEn {
	_TranslationsTransactionListEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todas las transacciones';
	@override String get empty => 'No se han encontrado transacciones que mostrar aquí. Añade unas cuantas transacciones en la app y quizas tengas más suerte la proxima vez';
	@override String get searcher_placeholder => 'Busca por categoría, descripción...';
	@override String get searcher_no_results => 'No se han encontrado transacciones que coincidan con los criterios de busqueda';
	@override String get loading => 'Cargando más transacciones...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} seleccionada',
		other: '${n} seleccionadas',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} transacción seleccionada',
		other: '${n} transacciones seleccionadas',
	);
	@override late final _TranslationsTransactionListBulkEditEs bulk_edit = _TranslationsTransactionListBulkEditEs._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersEs implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtros de transacciones';
	@override String get from_value => 'Desde monto';
	@override String get to_value => 'Hasta monto';
	@override String from_value_def({required Object x}) => 'Desde ${x}';
	@override String to_value_def({required Object x}) => 'Hasta ${x}';
	@override String from_date_def({required Object date}) => 'Desde el ${date}';
	@override String to_date_def({required Object date}) => 'Hasta el ${date}';
	@override String get reset => 'Restablecer filtros';
	@override late final _TranslationsTransactionFiltersSavedEs saved = _TranslationsTransactionFiltersSavedEs._(_root);
}

// Path: transaction.form
class _TranslationsTransactionFormEs implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsEs validators = _TranslationsTransactionFormValidatorsEs._(_root);
	@override String get title => 'Título de la transacción';
	@override String get title_short => 'Título';
	@override String get value => 'Valor de la transacción';
	@override String get tap_to_see_more => 'Toca para ver más detalles';
	@override String get no_tags => '-- Sin etiquetas --';
	@override String get description => 'Descripción';
	@override String get description_info => 'Toca aquí para escribir una descripción mas detallada sobre esta transacción';
	@override String exchange_to_preferred_title({required Object currency}) => 'Cambio a ${currency}';
	@override String get exchange_to_preferred_in_date => 'El día de la transacción';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedEs implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transacción invertida';
	@override String get title_short => 'Tr. invertida';
	@override String get description_for_expenses => 'A pesar de ser una transacción de tipo gasto, esta transacción tiene un monto positivo. Este tipo de transacciones pueden usarse para representar la devolución de un gasto previamente registrado, como un reembolso o que te realicen el pago de una deuda.';
	@override String get description_for_incomes => 'A pesar de ser una transacción de tipo ingreso, esta transacción tiene un monto negativo. Este tipo de transacciones pueden usarse para anular o corregir un ingreso que fue registrado incorrectamente, para reflejar una devolución o reembolso de dinero o para registrar el pago de deudas.';
}

// Path: transaction.status
class _TranslationsTransactionStatusEs implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Estado',
		other: 'Estados',
	);
	@override String get display_long => 'Estado de la transacción';
	@override String tr_status({required Object status}) => 'Transacción ${status}';
	@override String get none => 'Sin estado';
	@override String get none_descr => 'Transacción sin un estado concreto';
	@override String get reconciled => 'Reconciliada';
	@override String get reconciled_descr => 'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco';
	@override String get unreconciled => 'No reconciliada';
	@override String get unreconciled_descr => 'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin';
	@override String get pending => 'Pendiente';
	@override String get pending_descr => 'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas';
	@override String get voided => 'Nula';
	@override String get voided_descr => 'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas';
}

// Path: transaction.types
class _TranslationsTransactionTypesEs implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Tipo de transacción',
		other: 'Tipos de transacción',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Ingreso',
		other: 'Ingresos',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Gasto',
		other: 'Gastos',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Transferencia',
		other: 'Transferencias',
	);
}

// Path: transfer.form
class _TranslationsTransferFormEs implements TranslationsTransferFormEn {
	_TranslationsTransferFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get from => 'Cuenta origen';
	@override String get to => 'Cuenta destino';
	@override late final _TranslationsTransferFormValueInDestinyEs value_in_destiny = _TranslationsTransferFormValueInDestinyEs._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsEs implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Transaccion recurrente';
	@override String get descr => 'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento';
	@override String get last_payment_info => 'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción';
	@override String get delete_header => 'Eliminar transacción recurrente';
	@override String get delete_message => 'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusEs implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => 'Atrasado por ${x}d';
	@override String coming_in({required Object x}) => 'En ${x} días';
}

// Path: account.types
class _TranslationsAccountTypesEs implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tipo de cuenta';
	@override String get warning => 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
	@override String get normal => 'Cuenta corriente';
	@override String get normal_descr => 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
	@override String get saving => 'Cuenta de ahorros';
	@override String get saving_descr => 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
}

// Path: account.form
class _TranslationsAccountFormEs implements TranslationsAccountFormEn {
	_TranslationsAccountFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre de la cuenta';
	@override String get name_placeholder => 'Ej: Cuenta de ahorros';
	@override String get notes => 'Notas';
	@override String get notes_placeholder => 'Escribe algunas notas/descripciones sobre esta cuenta';
	@override String get initial_balance => 'Balance inicial';
	@override String get current_balance => 'Balance actual';
	@override String get create => 'Crear cuenta';
	@override String get edit => 'Editar cuenta';
	@override String get currency_not_found_warn => 'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes';
	@override String get already_exists => 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
	@override String get tr_before_opening_date => 'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteEs implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get warning_header => '¿Eliminar cuenta?';
	@override String get warning_text => 'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.';
	@override String get success => 'Cuenta eliminada correctamente';
}

// Path: account.close
class _TranslationsAccountCloseEs implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cerrar cuenta';
	@override String get title_short => 'Cerrar';
	@override String get warn => 'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras';
	@override String get should_have_zero_balance => 'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar';
	@override String get should_have_no_transactions => 'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar';
	@override String get success => 'Cuenta cerrada exitosamente';
	@override String get unarchive_succes => 'Cuenta re-abierta exitosamente';
}

// Path: account.select
class _TranslationsAccountSelectEs implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get one => 'Selecciona una cuenta';
	@override String get all => 'Todas las cuentas';
	@override String get multiple => 'Selecciona cuentas';
}

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormEs implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'La divisa seleccionada no puede ser la misma que la divisa predeterminada';
	@override String get override_existing_warn => 'Ya existe un tipo de cambio para esta moneda en esta fecha. Si continúas se sobrescribirá el anterior.';
	@override String get specify_a_currency => 'Por favor, especifica una divisa';
	@override String get add => 'Añadir tipo de cambio';
	@override String get add_success => 'Tipo de cambio añadido correctamente';
	@override String get edit => 'Editar tipo de cambio';
	@override String get edit_success => 'Tipo de cambio editado correctamente';
	@override String get remove_all => 'Eliminar todos los tipos de cambio';
	@override String get remove_all_warning => 'Esta acción es irreversible y eliminará todos los tipos de cambio de esta moneda.';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesEs implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Tipo de moneda';
	@override String get fiat => 'FÍAT';
	@override String get crypto => 'Criptomoneda';
	@override String get other => 'Otro';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormEs implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre a mostrar';
	@override String get code => 'Código de la divisa';
	@override String get symbol => 'Símbolo';
	@override String get decimal_digits => 'Dígitos decimales';
	@override String get create => 'Crear divisa';
	@override String get create_success => 'Divisa creada exitosamente';
	@override String get edit => 'Editar divisa';
	@override String get edit_success => 'Divisa editada correctamente';
	@override String get delete => 'Eliminar moneda';
	@override String get delete_success => 'Moneda eliminada exitosamente';
	@override String get already_exists => 'Ya existe una divisa con este código. Quizás quieras editarlo';
}

// Path: tags.form
class _TranslationsTagsFormEs implements TranslationsTagsFormEn {
	_TranslationsTagsFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre de la etiqueta';
	@override String get name_hint => 'Ej.: Comida';
	@override String get forbidden_char_error => 'El nombre no puede contener \';\'';
	@override String get description => 'Descripción';
}

// Path: tags.select
class _TranslationsTagsSelectEs implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecciona etiquetas';
	@override String get all => 'Todas las etiquetas';
}

// Path: categories.select
class _TranslationsCategoriesSelectEs implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Selecciona categorías';
	@override String get select_one => 'Selecciona una categoría';
	@override String get select_subcategory => 'Elige una subcategoría';
	@override String get without_subcategory => 'Sin subcategoría';
	@override String get all => 'Todas las categorías';
	@override String get all_short => 'Todas';
}

// Path: budgets.form
class _TranslationsBudgetsFormEs implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuevo presupuesto';
	@override String get name => 'Nombre';
	@override String get value => 'Límite';
	@override String get create => 'Crear presupuesto';
	@override String get create_success => 'Presupuesto creado correctamente';
	@override String get edit => 'Editar presupuesto';
	@override String get edit_success => 'Presupuesto editado correctamente';
	@override String get negative_warn => 'El límite de un presupuesto no puede ser negativo';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsEs implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles del presupuesto';
	@override String get statistics => 'Estadísticas';
	@override String get budget_value => 'Presupuestado';
	@override String get expend_evolution => 'Evolución del gasto';
	@override String get no_transactions => 'Parece que no has realizado ningún gasto relativo a este presupuesto';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesEs implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get active => 'Presupuesto activo';
	@override String get past => 'Presupuesto finalizado';
	@override String get future => 'Presupuesto futuro';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressEs implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsEs labels = _TranslationsBudgetsProgressLabelsEs._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionEs description = _TranslationsBudgetsProgressDescriptionEs._(_root);
}

// Path: goals.type
class _TranslationsGoalsTypeEs implements TranslationsGoalsTypeEn {
	_TranslationsGoalsTypeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Tipo de objetivo';
	@override late final _TranslationsGoalsTypeIncomeEs income = _TranslationsGoalsTypeIncomeEs._(_root);
	@override late final _TranslationsGoalsTypeExpenseEs expense = _TranslationsGoalsTypeExpenseEs._(_root);
}

// Path: goals.form
class _TranslationsGoalsFormEs implements TranslationsGoalsFormEn {
	_TranslationsGoalsFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get new_title => 'Nuevo objetivo';
	@override String get edit_title => 'Editar objetivo';
	@override String get target_amount => 'Cantidad objetivo';
	@override String get initial_amount => 'Cantidad inicial';
	@override String get name => 'Nombre';
	@override String get name_hint => 'Mi objetivo de ahorro';
	@override String get create_success => 'Objetivo creado correctamente';
	@override String get edit_success => 'Objetivo editado correctamente';
	@override String get negative_warn => 'La cantidad del objetivo no puede ser negativa';
}

// Path: goals.details
class _TranslationsGoalsDetailsEs implements TranslationsGoalsDetailsEn {
	_TranslationsGoalsDetailsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles del objetivo';
	@override String get statistics => 'Estadísticas';
	@override String get goal_value => 'Objetivo';
	@override String get evolution => 'Evolución';
	@override String get no_transactions => 'Parece que no has realizado movimientos relacionados con este objetivo';
}

// Path: goals.target_timeline_statuses
class _TranslationsGoalsTargetTimelineStatusesEs implements TranslationsGoalsTargetTimelineStatusesEn {
	_TranslationsGoalsTargetTimelineStatusesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get active => 'Objetivo activo';
	@override String get past => 'Objetivo finalizado';
	@override String get future => 'Objetivo futuro';
}

// Path: goals.progress
class _TranslationsGoalsProgressEs implements TranslationsGoalsProgressEn {
	_TranslationsGoalsProgressEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGoalsProgressLabelsEs labels = _TranslationsGoalsProgressLabelsEs._(_root);
	@override late final _TranslationsGoalsProgressDescriptionEs description = _TranslationsGoalsProgressDescriptionEs._(_root);
}

// Path: backup.export
class _TranslationsBackupExportEs implements TranslationsBackupExportEn {
	_TranslationsBackupExportEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exportar datos';
	@override String get title_short => 'Exportar';
	@override String get type_of_export => 'Tipo de exportación';
	@override String get other_options => 'Opciones';
	@override String get all => 'Respaldo total';
	@override String get all_descr => 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
	@override String get transactions => 'Respaldo de transacciones';
	@override String get transactions_descr => 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '1 transacción para exportar',
		other: '${n} transacciones para exportar',
	);
	@override String get description => 'Exporta tus datos en diferentes formatos';
	@override String get send_file => 'Enviar archivo';
	@override String get see_folder => 'Ver carpeta';
	@override String success({required Object x}) => 'Archivo guardado correctamente en ${x}';
	@override String get error => 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
	@override String get dialog_title => 'Guardar/Enviar archivo';
}

// Path: backup.import
class _TranslationsBackupImportEs implements TranslationsBackupImportEn {
	_TranslationsBackupImportEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importar tus datos';
	@override String get title_short => 'Importar';
	@override String get restore_backup => 'Restaurar copia de seguridad';
	@override String get restore_backup_descr => 'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos';
	@override String get restore_backup_warn_description => 'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin';
	@override String get restore_backup_warn_title => 'Sobreescribir todos los datos';
	@override String get select_other_file => 'Selecciona otro fichero';
	@override String get tap_to_select_file => 'Pulsa para seleccionar un archivo';
	@override late final _TranslationsBackupImportManualImportEs manual_import = _TranslationsBackupImportManualImportEs._(_root);
	@override String get success => 'Importación realizada con exito';
	@override String get error => 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
	@override String get cancelled => 'La importación fue cancelada por el usuario';
}

// Path: backup.about
class _TranslationsBackupAboutEs implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Información sobre tu base de datos';
	@override String get create_date => 'Fecha de creación';
	@override String get modify_date => 'Última modificación';
	@override String get last_backup => 'Última copia de seguridad';
	@override String get size => 'Tamaño';
}

// Path: settings.general
class _TranslationsSettingsGeneralEs implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Ajustes generales';
	@override String get menu_descr => 'Idioma, privacidad y más';
	@override String get show_all_decimals => 'Mostrar todos los decimales';
	@override String get show_all_decimals_descr => 'Mostrar todos los decimales incluso si hay ceros finales';
	@override late final _TranslationsSettingsGeneralLanguageEs language = _TranslationsSettingsGeneralLanguageEs._(_root);
	@override late final _TranslationsSettingsGeneralLocaleEs locale = _TranslationsSettingsGeneralLocaleEs._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityEs implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seguridad';
	@override String get private_mode_at_launch => 'Modo privado al arrancar';
	@override String get private_mode_at_launch_descr => 'Arranca la app en modo privado por defecto';
	@override String get private_mode => 'Modo privado';
	@override String get private_mode_descr => 'Oculta todos los valores monetarios';
	@override String get private_mode_activated => 'Modo privado activado';
	@override String get private_mode_deactivated => 'Modo privado desactivado';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsEs implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Transacciones';
	@override String get menu_descr => 'Configura el comportamiento de tus transacciones';
	@override String get title => 'Ajustes de transacciones';
	@override late final _TranslationsSettingsTransactionsStyleEs style = _TranslationsSettingsTransactionsStyleEs._(_root);
	@override late final _TranslationsSettingsTransactionsSwipeActionsEs swipe_actions = _TranslationsSettingsTransactionsSwipeActionsEs._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesEs default_values = _TranslationsSettingsTransactionsDefaultValuesEs._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeEs default_type = _TranslationsSettingsTransactionsDefaultTypeEs._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceEs implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Tema y estilo';
	@override String get menu_descr => 'Selección de tema, colores y otras cosas relacionadas con la apariencia de la aplicación';
	@override String get theme_and_colors => 'Tema y colores';
	@override late final _TranslationsSettingsAppearanceThemeEs theme = _TranslationsSettingsAppearanceThemeEs._(_root);
	@override String get amoled_mode => 'Modo AMOLED';
	@override String get amoled_mode_descr => 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
	@override String get dynamic_colors => 'Colores dinámicos';
	@override String get dynamic_colors_descr => 'Usar el color de acento de su sistema siempre que sea posible';
	@override String get accent_color => 'Color de acento';
	@override String get accent_color_descr => 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
	@override String get text => 'Texto';
	@override String get font => 'Fuente';
	@override String get font_platform => 'Plataforma';
}

// Path: more.data
class _TranslationsMoreDataEs implements TranslationsMoreDataEn {
	_TranslationsMoreDataEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Datos';
	@override String get display_descr => 'Exporta y importa tus datos para no perder nada';
	@override String get delete_all => 'Eliminar mis datos';
	@override String get delete_all_header1 => 'Alto ahí padawan ⚠️⚠️';
	@override String get delete_all_message1 => '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
	@override String get delete_all_header2 => 'Un último paso ⚠️⚠️';
	@override String get delete_all_message2 => 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsEs implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Información de la app';
	@override String get description => 'Consulta información relevante sobre Monekin. Conecta reportando errores o compartiendo ideas';
	@override late final _TranslationsMoreAboutUsLegalEs legal = _TranslationsMoreAboutUsLegalEs._(_root);
	@override late final _TranslationsMoreAboutUsProjectEs project = _TranslationsMoreAboutUsProjectEs._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsEs implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Ayúdanos';
	@override String get description => 'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor';
	@override String get rate_us => 'Califícanos';
	@override String get rate_us_descr => '¡Cualquier valoración es bienvenida!';
	@override String get share => 'Comparte Monekin';
	@override String get share_descr => 'Comparte nuestra app a amigos y familiares';
	@override String get share_text => 'Monekin! La mejor app de finanzas personales. Descargala aquí';
	@override String get thanks => '¡Gracias!';
	@override String get donate => 'Haz una donación';
	@override String get donate_descr => 'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?';
	@override String get donate_success => 'Donación realizada. Muchas gracias por tu contribución! ❤️';
	@override String get donate_err => 'Ups! Parece que ha habido un error a la hora de recibir tu pago';
	@override String get report => 'Reporta errores, deja sugerencias...';
	@override String get thanks_long => 'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesEs implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Rango temporal';
	@override String get it_repeat => 'Se repite';
	@override String get it_ends => 'Termina';
	@override String get forever => 'Para siempre';
	@override late final _TranslationsGeneralTimeRangesTypesEs types = _TranslationsGeneralTimeRangesTypesEs._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range}',
		other: 'Cada ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range} hasta el ${day}',
		other: 'Cada ${n} ${range} hasta el ${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range} ${limit} veces',
		other: 'Cada ${n} ${range} ${limit} veces',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Cada ${range} una vez',
		other: 'Cada ${n} ${range} una vez',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Mes',
		other: 'Meses',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Año',
		other: 'Años',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Día',
		other: 'Días',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Semana',
		other: 'Semanas',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityEs implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Periodicidad';
	@override String get no_repeat => 'Sin repetición';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Repetición',
		other: 'Repeticiones',
	);
	@override String get diary => 'Diaría';
	@override String get monthly => 'Mensual';
	@override String get annually => 'Anual';
	@override String get quaterly => 'Trimestral';
	@override String get weekly => 'Semanal';
	@override String get custom => 'Personalizado';
	@override String get infinite => 'Siempre';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentEs implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Este mes';
	@override String get annually => 'Este año';
	@override String get quaterly => 'Este trimestre';
	@override String get weekly => 'Esta semana';
	@override String get infinite => 'Desde siempre';
	@override String get custom => 'Rango personalizado';
	@override String get diary => 'Este día';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllEs implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Todos los días';
	@override String get monthly => 'Todos los meses';
	@override String get annually => 'Todos los años';
	@override String get quaterly => 'Todos los trimestres';
	@override String get weekly => 'Todas las semanas';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrEs implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!';
	@override String get very_good => 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
	@override String get good => 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
	@override String get normal => 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
	@override String get bad => 'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas';
	@override String get very_bad => 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextEs implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!';
	@override String normal({required Object value}) => 'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.';
	@override String bad({required Object value}) => 'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!';
	@override String get very_bad => 'Vaya, no has conseguido ahorrar nada durante este periodo.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditEs implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Editar fechas';
	@override String get categories => 'Editar categorías';
	@override String get status => 'Editar estados';
}

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedEs implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtros guardados';
	@override String get new_title => 'Nuevo filtro';
	@override String get edit_title => 'Editar filtro';
	@override String get name_label => 'Nombre del filtro';
	@override String get name_hint => 'Mi filtro personalizado';
	@override String get save_dialog_title => 'Guardar filtro';
	@override String get save_tooltip => 'Guardar filtro actual';
	@override String get load_tooltip => 'Cargar filtro guardado';
	@override String get empty_title => 'No se encontraron filtros guardados';
	@override String get empty_description => 'Guarda filtros aquí para acceder a ellos rápidamente más tarde.';
	@override String get save_success => 'Filtro guardado correctamente';
	@override String get delete_success => 'Filtro eliminado correctamente';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsEs implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get zero => 'El valor de una transacción no puede ser igual a cero';
	@override String get date_max => 'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente';
	@override String get date_after_account_creation => 'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece';
	@override String get negative_transfer => 'El valor monetario de una transferencia no puede ser negativo';
	@override String get transfer_between_same_accounts => 'Las cuentas de origen y destino no pueden coincidir';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyEs implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cantidad transferida en destino';
	@override String amount_short({required Object amount}) => '${amount} a cuenta de destino';
}

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsEs implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'Vas bien';
	@override String get active_overspending => 'Gastando de más';
	@override String get active_indeterminate => 'Activo';
	@override String get success => 'Objetivo cumplido';
	@override String get fail => 'Presupuesto excedido';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionEs implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => 'Puedes gastar ${dailyAmount} al día durante los ${remainingDays} días restantes para cumplir con el presupuesto';
	@override String active_overspending({required Object dailyAmount, required Object remainingDays}) => 'Para volver al camino correcto, deberías limitar tu gasto a ${dailyAmount} al día durante los ${remainingDays} días restantes de este presuesto';
	@override String active_indeterminate({required Object amount}) => 'Te queda ${amount} para gastar.';
	@override String active_exceeded({required Object amount}) => 'Ya has excedido el límite de tu presupuesto por ${amount}. Si no encuentras ningún ingreso para este presupuesto, deberías dejar de gastar durante el resto de su periodo';
	@override String get success => '¡Buen trabajo! Este presupuesto ha finalizado con éxito. Sigue creando presupuestos para gestionar tus gastos';
	@override String fail({required Object amount}) => 'Has excedido el presupuesto por ${amount}. ¡Intenta tener más cuidado la próxima vez!';
}

// Path: goals.type.income
class _TranslationsGoalsTypeIncomeEs implements TranslationsGoalsTypeIncomeEn {
	_TranslationsGoalsTypeIncomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Objetivo de ahorro';
	@override String get descr => 'Ideal para ahorrar dinero. Tienes éxito cuando el saldo supera tu objetivo.';
}

// Path: goals.type.expense
class _TranslationsGoalsTypeExpenseEs implements TranslationsGoalsTypeExpenseEn {
	_TranslationsGoalsTypeExpenseEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Objetivo de gasto';
	@override String get descr => 'Sigue cuánto gastas y apunta a alcanzar una cantidad objetivo. Funciona bien para donaciones, caridad, gastos de ocio...';
}

// Path: goals.progress.labels
class _TranslationsGoalsProgressLabelsEs implements TranslationsGoalsProgressLabelsEn {
	_TranslationsGoalsProgressLabelsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'En camino';
	@override String get active_behind_schedule => 'Por detrás';
	@override String get active_indeterminate => 'Activo';
	@override String get success => 'Objetivo alcanzado';
	@override String get fail => 'Objetivo fallido';
}

// Path: goals.progress.description
class _TranslationsGoalsProgressDescriptionEs implements TranslationsGoalsProgressDescriptionEn {
	_TranslationsGoalsProgressDescriptionEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object dailyAmount, required Object remainingDays}) => '¡Vas por buen camino! Tienes que ahorrar ${dailyAmount} al día durante los ${remainingDays} días restantes';
	@override String active_behind_schedule({required Object dailyAmount, required Object remainingDays}) => 'Vas con retraso. Tienes que ahorrar ${dailyAmount} al día para alcanzar tu objetivo en ${remainingDays} días';
	@override String active_indeterminate({required Object amount}) => 'Necesitas ${amount} más para alcanzar tu objetivo.';
	@override String get success => '¡Felicidades! Has alcanzado tu objetivo.';
	@override String fail({required Object amount}) => 'No has alcanzado tu objetivo por ${amount}.';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportEs implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importación manual';
	@override String get descr => 'Importa transacciones desde un fichero .csv de forma manual';
	@override String get default_account => 'Cuenta por defecto';
	@override String get remove_default_account => 'Eliminar cuenta por defecto';
	@override String get default_category => 'Categoría por defecto';
	@override String get default_tags => 'Etiquetas por defecto';
	@override String get select_a_column => 'Selecciona una columna del .csv';
	@override String get date_format => 'Formato de fecha';
	@override String get note_column => 'Columna de nota';
	@override String get title_column => 'Columna de título';
	@override String get tag_separator => 'Separador de etiquetas en el .csv';
	@override List<String> get steps => [
		'Selecciona tu fichero',
		'Columna para la cantidad',
		'Columna para la cuenta',
		'Columna para la categoría',
		'Columna para las etiquetas',
		'Columna para la fecha',
		'Otras columnas',
	];
	@override List<String> get steps_descr => [
		'Selecciona un fichero .csv de tu dispositivo. Asegúrate de que este tenga una primera fila que describa el nombre de cada columna.',
		'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos.',
		'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre.',
		'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar.',
		'Especifica la columna donde se encuentran las etiquetas de transacción. En caso de no especificarse, las transacciones se crearán con etiquetas predeterminadas.',
		'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual.',
		'Especifica las columnas para otros atributos optativos de las transacciones.',
	];
	@override String success({required Object x}) => 'Se han importado correctamente ${x} transacciones';
}

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageEs implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get section => 'Idioma y textos';
	@override String get title => 'Idioma de la aplicación';
	@override String get descr => 'Idioma en el que se mostrarán los textos en la aplicación';
	@override String get help => 'Si quieres colaborar con las traducciones de esta app puedes consultar <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>nuestra guía</a> ';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleEs implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Región';
	@override String get auto => 'Sistema';
	@override String get descr => 'Establecer el formato a utilizar para fechas, números...';
	@override String get warn => 'Al cambiar la región, la aplicación se actualizará';
	@override String get first_day_of_week => 'Primer día de la semana';
}

// Path: settings.transactions.style
class _TranslationsSettingsTransactionsStyleEs implements TranslationsSettingsTransactionsStyleEn {
	_TranslationsSettingsTransactionsStyleEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estilo de transacción';
	@override String get subtitle => 'Configura cómo se ven las transacciones en las listas';
	@override String get show_tags => 'Ver Etiquetas';
	@override String get show_time => 'Ver Hora';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsEs implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Acciones al deslizar el dedo';
	@override String get choose_description => 'Elije qué acción se activará cuando deslices una transacción del listado de transacciones usando esta dirección de deslizamiento';
	@override String get swipe_left => 'Desliza hacia la izquierda';
	@override String get swipe_right => 'Desliza hacia la derecha';
	@override String get none => 'No action';
	@override String get toggle_reconciled => 'Alternar conciliado';
	@override String get toggle_pending => 'Alternar pendiente';
	@override String get toggle_voided => 'Alternar anulado';
	@override String get toggle_unreconciled => 'Alternar no reconciliado';
	@override String get remove_status => 'Eliminar estado';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesEs implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Valores por defecto';
	@override String get page_title => 'Nueva transacción: Valores por defecto';
	@override String get reuse_last_transaction => 'Reutilizar valores de la última transacción';
	@override String get reuse_last_transaction_descr => 'Rellenar automáticamente el formulario con valores de la última transacción creada';
	@override String get fields_to_reuse => 'Campos a reutilizar';
	@override String get reuse_last_values_modal_descr => 'Selecciona los campos que deben rellenarse con los valores de la última transacción creada.';
	@override String get default_values_separator => 'Valores por defecto';
	@override String get default_category => 'Categoría por defecto';
	@override String get default_status => 'Estado por defecto';
	@override String get default_tags => 'Etiquetas por defecto';
	@override String get no_tags_selected => 'Sin etiquetas seleccionadas';
}

// Path: settings.transactions.default_type
class _TranslationsSettingsTransactionsDefaultTypeEs implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tipo por defecto';
	@override String get modal_title => 'Seleccionar tipo por defecto';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeEs implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tema';
	@override String get auto => 'Sistema';
	@override String get light => 'Claro';
	@override String get dark => 'Oscuro';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalEs implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Información legal';
	@override String get privacy => 'Política de privacidad';
	@override String get terms => 'Términos de uso';
	@override String get licenses => 'Licencias';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectEs implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get display => 'Proyecto';
	@override String get contributors => 'Colaboradores';
	@override String get contributors_descr => 'Todos los desarrolladores que han hecho que Monekin crezca';
	@override String get contact => 'Contacta con nosotros';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesEs implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Ciclos';
	@override String get last_days => 'Últimos días';
	@override String last_days_form({required Object x}) => '${x} días anteriores';
	@override String get all => 'Siempre';
	@override String get date_range => 'Rango personalizado';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ui_actions.cancel' => 'Cancelar',
			'ui_actions.confirm' => 'Confirmar',
			'ui_actions.continue_text' => 'Continuar',
			'ui_actions.save' => 'Guardar',
			'ui_actions.save_changes' => 'Guardar cambios',
			'ui_actions.close_and_save' => 'Guardar y cerrar',
			'ui_actions.add' => 'Añadir',
			'ui_actions.edit' => 'Editar',
			'ui_actions.delete' => 'Eliminar',
			'ui_actions.see_more' => 'Ver más',
			'ui_actions.select_all' => 'Seleccionar todo',
			'ui_actions.deselect_all' => 'Deseleccionar todo',
			'ui_actions.select' => 'Seleccionar',
			'ui_actions.search' => 'Buscar',
			'ui_actions.filter' => 'Filter',
			'ui_actions.reset' => 'Restablecer',
			'ui_actions.submit' => 'Enviar',
			'ui_actions.next' => 'Siguiente',
			'ui_actions.previous' => 'Anterior',
			'ui_actions.back' => 'Atrás',
			'ui_actions.reload' => 'Recargar',
			'ui_actions.view' => 'Ver',
			'ui_actions.download' => 'Descargar',
			'ui_actions.upload' => 'Subir',
			'ui_actions.retry' => 'Reintentar',
			'ui_actions.copy' => 'Copiar',
			'ui_actions.paste' => 'Pegar',
			'ui_actions.undo' => 'Deshacer',
			'ui_actions.redo' => 'Rehacer',
			'ui_actions.open' => 'Abrir',
			'ui_actions.close' => 'Cerrar',
			'ui_actions.apply' => 'Aplicar',
			'ui_actions.discard' => 'Descartar',
			'ui_actions.refresh' => 'Actualizar',
			'ui_actions.share' => 'Compartir',
			'general.or' => 'o',
			'general.understood' => 'Entendido',
			'general.unspecified' => 'Sin especificar',
			'general.quick_actions' => 'Acciones rápidas',
			'general.details' => 'Detalles',
			'general.balance' => 'Balance',
			'general.account' => 'Cuenta',
			'general.accounts' => 'Cuentas',
			'general.categories' => 'Categorías',
			'general.category' => 'Categoría',
			'general.today' => 'Hoy',
			'general.yesterday' => 'Ayer',
			'general.filters' => 'Filtros',
			'general.empty_warn' => 'Ops! Esto esta muy vacio',
			'general.search_no_results' => 'No hay elementos que coincidan con tus criterios de búsqueda',
			'general.insufficient_data' => 'Datos insuficientes',
			'general.show_more_fields' => 'Show more fields',
			'general.show_less_fields' => 'Show less fields',
			'general.tap_to_search' => 'Toca para buscar',
			'general.delete_success' => 'Elemento eliminado con éxito',
			'general.leave_without_saving.title' => '¿Salir sin guardar?',
			'general.leave_without_saving.message' => 'Tienes cambios sin guardar, ¿estás seguro de que quieres continuar y salir sin guardarlos?',
			'general.clipboard.success' => ({required Object x}) => '${x} copiado al portapapeles',
			'general.clipboard.error' => 'Error al copiar',
			'general.time.start_date' => 'Fecha de inicio',
			'general.time.end_date' => 'Fecha de fin',
			'general.time.from_date' => 'Desde fecha',
			'general.time.until_date' => 'Hasta fecha',
			'general.time.date' => 'Fecha',
			'general.time.datetime' => 'Fecha y hora',
			'general.time.time' => 'Hora',
			'general.time.each' => 'Cada',
			'general.time.after' => 'Tras',
			'general.time.ranges.display' => 'Rango temporal',
			'general.time.ranges.it_repeat' => 'Se repite',
			'general.time.ranges.it_ends' => 'Termina',
			'general.time.ranges.forever' => 'Para siempre',
			'general.time.ranges.types.cycle' => 'Ciclos',
			'general.time.ranges.types.last_days' => 'Últimos días',
			'general.time.ranges.types.last_days_form' => ({required Object x}) => '${x} días anteriores',
			'general.time.ranges.types.all' => 'Siempre',
			'general.time.ranges.types.date_range' => 'Rango personalizado',
			'general.time.ranges.each_range' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Cada ${range}', other: 'Cada ${n} ${range}', ), 
			'general.time.ranges.each_range_until_date' => ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Cada ${range} hasta el ${day}', other: 'Cada ${n} ${range} hasta el ${day}', ), 
			'general.time.ranges.each_range_until_times' => ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Cada ${range} ${limit} veces', other: 'Cada ${n} ${range} ${limit} veces', ), 
			'general.time.ranges.each_range_until_once' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Cada ${range} una vez', other: 'Cada ${n} ${range} una vez', ), 
			'general.time.ranges.month' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Mes', other: 'Meses', ), 
			'general.time.ranges.year' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Año', other: 'Años', ), 
			'general.time.ranges.day' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Día', other: 'Días', ), 
			'general.time.ranges.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Semana', other: 'Semanas', ), 
			'general.time.periodicity.display' => 'Periodicidad',
			'general.time.periodicity.no_repeat' => 'Sin repetición',
			'general.time.periodicity.repeat' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Repetición', other: 'Repeticiones', ), 
			'general.time.periodicity.diary' => 'Diaría',
			'general.time.periodicity.monthly' => 'Mensual',
			'general.time.periodicity.annually' => 'Anual',
			'general.time.periodicity.quaterly' => 'Trimestral',
			'general.time.periodicity.weekly' => 'Semanal',
			'general.time.periodicity.custom' => 'Personalizado',
			'general.time.periodicity.infinite' => 'Siempre',
			'general.time.current.monthly' => 'Este mes',
			'general.time.current.annually' => 'Este año',
			'general.time.current.quaterly' => 'Este trimestre',
			'general.time.current.weekly' => 'Esta semana',
			'general.time.current.infinite' => 'Desde siempre',
			'general.time.current.custom' => 'Rango personalizado',
			'general.time.current.diary' => 'Este día',
			'general.time.all.diary' => 'Todos los días',
			'general.time.all.monthly' => 'Todos los meses',
			'general.time.all.annually' => 'Todos los años',
			'general.time.all.quaterly' => 'Todos los trimestres',
			'general.time.all.weekly' => 'Todas las semanas',
			'general.transaction_order.display' => 'Ordenar transacciones',
			'general.transaction_order.category' => 'Por categoría',
			'general.transaction_order.quantity' => 'Por cantidad',
			'general.transaction_order.date' => 'Por fecha',
			'general.validations.form_error' => 'Corrije los campos indicados en el formulario para continuar',
			'general.validations.required' => 'Campo obligatorio',
			'general.validations.positive' => 'Debe ser positivo',
			'general.validations.min_number' => ({required Object x}) => 'Debe ser mayor que ${x}',
			'general.validations.max_number' => ({required Object x}) => 'Debe ser menor que ${x}',
			'intro.start' => 'Empecemos',
			'intro.skip' => 'Saltar',
			'intro.next' => 'Siguiente',
			'intro.select_your_currency' => 'Selecciona tu divisa',
			'intro.welcome_subtitle' => 'Tu gestor de finanzas personales',
			'intro.welcome_subtitle2' => '100% libre, 100% gratis',
			'intro.welcome_footer' => 'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación',
			'intro.offline_descr_title' => 'CUENTA SIN CONEXIÓN:',
			'intro.offline_descr' => 'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.',
			'intro.offline_start' => 'Iniciar sesión offline',
			'intro.sl1_title' => 'Selecciona tu divisa',
			'intro.sl1_descr' => 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación',
			'intro.sl2_title' => 'Seguro, privado y confiable',
			'intro.sl2_descr' => 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet',
			'intro.sl2_descr2' => 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona',
			'intro.last_slide_title' => 'Todo listo!',
			'intro.last_slide_descr' => 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.',
			'intro.last_slide_descr2' => 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...',
			'home.title' => 'Inicio',
			'home.filter_transactions' => 'Filtrar transacciones',
			'home.hello_day' => 'Buenos días,',
			'home.hello_night' => 'Buenas noches,',
			'home.total_balance' => 'Saldo total',
			'home.my_accounts' => 'Mis cuentas',
			'home.active_accounts' => 'Cuentas activas',
			'home.no_accounts' => 'Aun no hay cuentas creadas',
			'home.no_accounts_descr' => 'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones',
			'home.last_transactions' => 'Últimas transacciones',
			'home.should_create_account_header' => 'Ops!',
			'home.should_create_account_message' => 'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones',
			'financial_health.display' => 'Salud financiera',
			'financial_health.review.very_good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Excelente!'; case GenderContext.female: return 'Excelente!'; } }, 
			'financial_health.review.good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Bueno'; case GenderContext.female: return 'Buena'; } }, 
			'financial_health.review.normal' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'En la media'; case GenderContext.female: return 'En la media'; } }, 
			'financial_health.review.bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Regular'; case GenderContext.female: return 'Regular'; } }, 
			'financial_health.review.very_bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Muy malo'; case GenderContext.female: return 'Muy mala'; } }, 
			'financial_health.review.insufficient_data' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Datos insuficientes'; case GenderContext.female: return 'Datos insuficientes'; } }, 
			'financial_health.review.descr.insufficient_data' => 'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!',
			'financial_health.review.descr.very_good' => 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin',
			'financial_health.review.descr.good' => 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!',
			'financial_health.review.descr.normal' => 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo',
			'financial_health.review.descr.bad' => 'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas',
			'financial_health.review.descr.very_bad' => 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos',
			'financial_health.months_without_income.title' => 'Ratio de supervivencia',
			'financial_health.months_without_income.subtitle' => 'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos',
			'financial_health.months_without_income.text_zero' => '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!',
			'financial_health.months_without_income.text_one' => '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!',
			'financial_health.months_without_income.text_other' => ({required Object n}) => 'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.',
			'financial_health.months_without_income.text_infinite' => 'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.',
			'financial_health.months_without_income.suggestion' => 'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.',
			'financial_health.months_without_income.insufficient_data' => 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera',
			'financial_health.savings_percentage.title' => 'Porcentaje de ahorro',
			'financial_health.savings_percentage.subtitle' => 'Que parte de tus ingresos no son gastados en este periodo',
			'financial_health.savings_percentage.text.good' => ({required Object value}) => 'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!',
			'financial_health.savings_percentage.text.normal' => ({required Object value}) => 'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.',
			'financial_health.savings_percentage.text.bad' => ({required Object value}) => 'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!',
			'financial_health.savings_percentage.text.very_bad' => 'Vaya, no has conseguido ahorrar nada durante este periodo.',
			'financial_health.savings_percentage.suggestion' => 'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.',
			'stats.title' => 'Estadísticas',
			'stats.balance' => 'Saldo',
			'stats.final_balance' => 'Saldo final',
			'stats.balance_by_account' => 'Saldo por cuentas',
			'stats.balance_by_account_subtitle' => '¿Donde tengo la mayor parte de mi dinero?',
			'stats.balance_by_currency' => 'Saldo por divisas',
			'stats.balance_by_currency_subtitle' => '¿Cuanto dinero tengo en moneda extranjera?',
			'stats.balance_evolution' => 'Tendencia de saldo',
			'stats.balance_evolution_subtitle' => '¿Tengo más dinero que antes?',
			'stats.compared_to_previous_period' => 'Frente al periodo anterior',
			'stats.cash_flow' => 'Flujo de caja',
			'stats.cash_flow_subtitle' => '¿Estoy gastando menos de lo que gano?',
			'stats.by_periods' => 'Por periodos',
			'stats.by_categories' => 'Por categorías',
			'stats.by_tags' => 'Por etiquetas',
			'stats.distribution' => 'Distribución',
			'stats.finance_health_resume' => 'Resumen',
			'stats.finance_health_breakdown' => 'Desglose',
			'icon_selector.name' => 'Nombre:',
			'icon_selector.icon' => 'Icono',
			'icon_selector.color' => 'Color',
			'icon_selector.select_icon' => 'Selecciona un icono',
			'icon_selector.select_color' => 'Selecciona un color',
			'icon_selector.custom_color' => 'Color personalizado',
			'icon_selector.current_color_selection' => 'Selección actual',
			'icon_selector.select_account_icon' => 'Identifica tu cuenta',
			'icon_selector.select_category_icon' => 'Identifica tu categoría',
			'icon_selector.scopes.transport' => 'Transporte',
			'icon_selector.scopes.money' => 'Dinero',
			'icon_selector.scopes.food' => 'Comida',
			'icon_selector.scopes.medical' => 'Salud',
			'icon_selector.scopes.entertainment' => 'Entretenimiento',
			'icon_selector.scopes.technology' => 'Technología',
			'icon_selector.scopes.other' => 'Otros',
			'icon_selector.scopes.logos_financial_institutions' => 'Financial institutions',
			'transaction.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Transacción', other: 'Transacciones', ), 
			'transaction.create' => 'Nueva transacción',
			'transaction.new_income' => 'Nuevo ingreso',
			'transaction.new_expense' => 'Nuevo gasto',
			'transaction.new_success' => 'Transacción creada correctamente',
			'transaction.edit' => 'Editar transacción',
			'transaction.edit_success' => 'Transacción editada correctamente',
			'transaction.edit_multiple' => 'Editar transacciones',
			'transaction.edit_multiple_success' => ({required Object x}) => '${x} transacciones editadas correctamente',
			'transaction.duplicate' => 'Clonar transacción',
			'transaction.duplicate_short' => 'Clonar',
			'transaction.duplicate_warning_message' => 'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?',
			'transaction.duplicate_success' => 'Transacción clonada con exito',
			'transaction.delete' => 'Eliminar transacción',
			'transaction.delete_warning_message' => 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas',
			'transaction.delete_success' => 'Transacción eliminada correctamente',
			'transaction.delete_multiple' => 'Eliminar transacciones',
			'transaction.delete_multiple_warning_message' => ({required Object x}) => 'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas',
			'transaction.delete_multiple_success' => ({required Object x}) => '${x} transacciones eliminadas correctamente',
			'transaction.details' => 'Detalles del movimiento',
			'transaction.next_payments.accept' => 'Aceptar',
			'transaction.next_payments.skip' => 'Saltar',
			'transaction.next_payments.skip_success' => 'Transacción saltada con exito',
			'transaction.next_payments.skip_dialog_title' => 'Saltar transacción',
			'transaction.next_payments.skip_dialog_msg' => ({required Object date}) => 'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}',
			'transaction.next_payments.accept_today' => 'Aceptar hoy',
			'transaction.next_payments.accept_in_required_date' => ({required Object date}) => 'Aceptar en la fecha requerida (${date})',
			'transaction.next_payments.accept_dialog_title' => 'Aceptar transacción',
			'transaction.next_payments.accept_dialog_msg_single' => 'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees',
			'transaction.next_payments.accept_dialog_msg' => ({required Object date}) => 'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones',
			'transaction.next_payments.recurrent_rule_finished' => 'La regla recurrente se ha completado, ya no hay mas pagos a realizar!',
			'transaction.list.all' => 'Todas las transacciones',
			'transaction.list.empty' => 'No se han encontrado transacciones que mostrar aquí. Añade unas cuantas transacciones en la app y quizas tengas más suerte la proxima vez',
			'transaction.list.searcher_placeholder' => 'Busca por categoría, descripción...',
			'transaction.list.searcher_no_results' => 'No se han encontrado transacciones que coincidan con los criterios de busqueda',
			'transaction.list.loading' => 'Cargando más transacciones...',
			'transaction.list.selected_short' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} seleccionada', other: '${n} seleccionadas', ), 
			'transaction.list.selected_long' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} transacción seleccionada', other: '${n} transacciones seleccionadas', ), 
			'transaction.list.bulk_edit.dates' => 'Editar fechas',
			'transaction.list.bulk_edit.categories' => 'Editar categorías',
			'transaction.list.bulk_edit.status' => 'Editar estados',
			'transaction.filters.title' => 'Filtros de transacciones',
			'transaction.filters.from_value' => 'Desde monto',
			'transaction.filters.to_value' => 'Hasta monto',
			'transaction.filters.from_value_def' => ({required Object x}) => 'Desde ${x}',
			'transaction.filters.to_value_def' => ({required Object x}) => 'Hasta ${x}',
			'transaction.filters.from_date_def' => ({required Object date}) => 'Desde el ${date}',
			'transaction.filters.to_date_def' => ({required Object date}) => 'Hasta el ${date}',
			'transaction.filters.reset' => 'Restablecer filtros',
			'transaction.filters.saved.title' => 'Filtros guardados',
			'transaction.filters.saved.new_title' => 'Nuevo filtro',
			'transaction.filters.saved.edit_title' => 'Editar filtro',
			'transaction.filters.saved.name_label' => 'Nombre del filtro',
			'transaction.filters.saved.name_hint' => 'Mi filtro personalizado',
			'transaction.filters.saved.save_dialog_title' => 'Guardar filtro',
			'transaction.filters.saved.save_tooltip' => 'Guardar filtro actual',
			'transaction.filters.saved.load_tooltip' => 'Cargar filtro guardado',
			'transaction.filters.saved.empty_title' => 'No se encontraron filtros guardados',
			'transaction.filters.saved.empty_description' => 'Guarda filtros aquí para acceder a ellos rápidamente más tarde.',
			'transaction.filters.saved.save_success' => 'Filtro guardado correctamente',
			'transaction.filters.saved.delete_success' => 'Filtro eliminado correctamente',
			'transaction.form.validators.zero' => 'El valor de una transacción no puede ser igual a cero',
			'transaction.form.validators.date_max' => 'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente',
			'transaction.form.validators.date_after_account_creation' => 'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece',
			'transaction.form.validators.negative_transfer' => 'El valor monetario de una transferencia no puede ser negativo',
			'transaction.form.validators.transfer_between_same_accounts' => 'Las cuentas de origen y destino no pueden coincidir',
			'transaction.form.title' => 'Título de la transacción',
			'transaction.form.title_short' => 'Título',
			'transaction.form.value' => 'Valor de la transacción',
			'transaction.form.tap_to_see_more' => 'Toca para ver más detalles',
			'transaction.form.no_tags' => '-- Sin etiquetas --',
			'transaction.form.description' => 'Descripción',
			'transaction.form.description_info' => 'Toca aquí para escribir una descripción mas detallada sobre esta transacción',
			'transaction.form.exchange_to_preferred_title' => ({required Object currency}) => 'Cambio a ${currency}',
			'transaction.form.exchange_to_preferred_in_date' => 'El día de la transacción',
			'transaction.reversed.title' => 'Transacción invertida',
			'transaction.reversed.title_short' => 'Tr. invertida',
			'transaction.reversed.description_for_expenses' => 'A pesar de ser una transacción de tipo gasto, esta transacción tiene un monto positivo. Este tipo de transacciones pueden usarse para representar la devolución de un gasto previamente registrado, como un reembolso o que te realicen el pago de una deuda.',
			'transaction.reversed.description_for_incomes' => 'A pesar de ser una transacción de tipo ingreso, esta transacción tiene un monto negativo. Este tipo de transacciones pueden usarse para anular o corregir un ingreso que fue registrado incorrectamente, para reflejar una devolución o reembolso de dinero o para registrar el pago de deudas.',
			'transaction.status.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Estado', other: 'Estados', ), 
			'transaction.status.display_long' => 'Estado de la transacción',
			'transaction.status.tr_status' => ({required Object status}) => 'Transacción ${status}',
			'transaction.status.none' => 'Sin estado',
			'transaction.status.none_descr' => 'Transacción sin un estado concreto',
			'transaction.status.reconciled' => 'Reconciliada',
			'transaction.status.reconciled_descr' => 'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco',
			'transaction.status.unreconciled' => 'No reconciliada',
			'transaction.status.unreconciled_descr' => 'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin',
			'transaction.status.pending' => 'Pendiente',
			'transaction.status.pending_descr' => 'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas',
			'transaction.status.voided' => 'Nula',
			'transaction.status.voided_descr' => 'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas',
			'transaction.types.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Tipo de transacción', other: 'Tipos de transacción', ), 
			'transaction.types.income' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Ingreso', other: 'Ingresos', ), 
			'transaction.types.expense' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Gasto', other: 'Gastos', ), 
			'transaction.types.transfer' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Transferencia', other: 'Transferencias', ), 
			'transfer.display' => 'Transferencia',
			'transfer.transfers' => 'Transferencias',
			'transfer.transfer_to' => ({required Object account}) => 'Transferencia hacia ${account}',
			'transfer.create' => 'Nueva transferencia',
			'transfer.need_two_accounts_warning_header' => 'Ops!',
			'transfer.need_two_accounts_warning_message' => 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar',
			'transfer.form.from' => 'Cuenta origen',
			'transfer.form.to' => 'Cuenta destino',
			'transfer.form.value_in_destiny.title' => 'Cantidad transferida en destino',
			'transfer.form.value_in_destiny.amount_short' => ({required Object amount}) => '${amount} a cuenta de destino',
			'recurrent_transactions.title' => 'Movimientos recurrentes',
			'recurrent_transactions.title_short' => 'Mov. recurrentes',
			'recurrent_transactions.empty' => 'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí',
			'recurrent_transactions.total_expense_title' => 'Gasto total por periodo',
			'recurrent_transactions.total_expense_descr' => '* Sin considerar la fecha de inicio y fin de cada recurrencia',
			'recurrent_transactions.details.title' => 'Transaccion recurrente',
			'recurrent_transactions.details.descr' => 'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento',
			'recurrent_transactions.details.last_payment_info' => 'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción',
			'recurrent_transactions.details.delete_header' => 'Eliminar transacción recurrente',
			'recurrent_transactions.details.delete_message' => 'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado',
			'recurrent_transactions.status.delayed_by' => ({required Object x}) => 'Atrasado por ${x}d',
			'recurrent_transactions.status.coming_in' => ({required Object x}) => 'En ${x} días',
			'account.details' => 'Detalles de la cuenta',
			'account.date' => 'Fecha de apertura',
			'account.close_date' => 'Fecha de cierre',
			'account.reopen' => 'Reabrir cuenta',
			'account.reopen_short' => 'Reabrir',
			'account.reopen_descr' => '¿Seguro que quieres volver a abrir esta cuenta?',
			'account.balance' => 'Saldo de la cuenta',
			'account.n_transactions' => 'Número de transacciones',
			'account.add_money' => 'Añadir dinero',
			'account.withdraw_money' => 'Retirar dinero',
			'account.no_accounts' => 'No se han encontrado cuentas que mostrar aquí. Añade una cuenta pulsando el botón \'+\' de la parte inferior',
			'account.types.title' => 'Tipo de cuenta',
			'account.types.warning' => 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro',
			'account.types.normal' => 'Cuenta corriente',
			'account.types.normal_descr' => 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...',
			'account.types.saving' => 'Cuenta de ahorros',
			'account.types.saving_descr' => 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar',
			'account.form.name' => 'Nombre de la cuenta',
			'account.form.name_placeholder' => 'Ej: Cuenta de ahorros',
			'account.form.notes' => 'Notas',
			'account.form.notes_placeholder' => 'Escribe algunas notas/descripciones sobre esta cuenta',
			'account.form.initial_balance' => 'Balance inicial',
			'account.form.current_balance' => 'Balance actual',
			'account.form.create' => 'Crear cuenta',
			'account.form.edit' => 'Editar cuenta',
			'account.form.currency_not_found_warn' => 'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes',
			'account.form.already_exists' => 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro',
			'account.form.tr_before_opening_date' => 'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura',
			'account.form.iban' => 'IBAN',
			'account.form.swift' => 'SWIFT',
			'account.delete.warning_header' => '¿Eliminar cuenta?',
			'account.delete.warning_text' => 'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.',
			'account.delete.success' => 'Cuenta eliminada correctamente',
			'account.close.title' => 'Cerrar cuenta',
			'account.close.title_short' => 'Cerrar',
			'account.close.warn' => 'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras',
			'account.close.should_have_zero_balance' => 'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar',
			'account.close.should_have_no_transactions' => 'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar',
			'account.close.success' => 'Cuenta cerrada exitosamente',
			'account.close.unarchive_succes' => 'Cuenta re-abierta exitosamente',
			'account.select.one' => 'Selecciona una cuenta',
			'account.select.all' => 'Todas las cuentas',
			'account.select.multiple' => 'Selecciona cuentas',
			'currencies.currency_converter' => 'Conversor de divisas',
			'currencies.currency' => 'Divisa',
			'currencies.currency_settings' => 'Configuración de la divisa',
			'currencies.currency_manager' => 'Administrador de divisas',
			'currencies.currency_manager_descr' => 'Configura tu divisa y sus tipos de cambio con otras',
			'currencies.preferred_currency' => 'Divisa predeterminada/base',
			'currencies.tap_to_change_preferred_currency' => 'Toca para cambiar',
			'currencies.change_preferred_currency_title' => 'Cambiar divisa predeterminada',
			'currencies.change_preferred_currency_msg' => 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?',
			'currencies.exchange_rate_form.equal_to_preferred_warn' => 'La divisa seleccionada no puede ser la misma que la divisa predeterminada',
			'currencies.exchange_rate_form.override_existing_warn' => 'Ya existe un tipo de cambio para esta moneda en esta fecha. Si continúas se sobrescribirá el anterior.',
			'currencies.exchange_rate_form.specify_a_currency' => 'Por favor, especifica una divisa',
			'currencies.exchange_rate_form.add' => 'Añadir tipo de cambio',
			'currencies.exchange_rate_form.add_success' => 'Tipo de cambio añadido correctamente',
			'currencies.exchange_rate_form.edit' => 'Editar tipo de cambio',
			'currencies.exchange_rate_form.edit_success' => 'Tipo de cambio editado correctamente',
			'currencies.exchange_rate_form.remove_all' => 'Eliminar todos los tipos de cambio',
			'currencies.exchange_rate_form.remove_all_warning' => 'Esta acción es irreversible y eliminará todos los tipos de cambio de esta moneda.',
			'currencies.types.display' => 'Tipo de moneda',
			'currencies.types.fiat' => 'FÍAT',
			'currencies.types.crypto' => 'Criptomoneda',
			'currencies.types.other' => 'Otro',
			'currencies.currency_form.name' => 'Nombre a mostrar',
			'currencies.currency_form.code' => 'Código de la divisa',
			'currencies.currency_form.symbol' => 'Símbolo',
			'currencies.currency_form.decimal_digits' => 'Dígitos decimales',
			'currencies.currency_form.create' => 'Crear divisa',
			'currencies.currency_form.create_success' => 'Divisa creada exitosamente',
			'currencies.currency_form.edit' => 'Editar divisa',
			'currencies.currency_form.edit_success' => 'Divisa editada correctamente',
			'currencies.currency_form.delete' => 'Eliminar moneda',
			'currencies.currency_form.delete_success' => 'Moneda eliminada exitosamente',
			'currencies.currency_form.already_exists' => 'Ya existe una divisa con este código. Quizás quieras editarlo',
			'currencies.delete_all_success' => 'Tipos de cambio borrados con exito',
			'currencies.historical' => 'Histórico de tasas',
			'currencies.historical_empty' => 'No se encontraron tipos de cambio históricos para esta divisa',
			'currencies.exchange_rate' => 'Tipo de cambio',
			'currencies.exchange_rates' => 'Tipos de cambio',
			'currencies.min_exchange_rate' => 'Tipo de cambio mínimo',
			'currencies.max_exchange_rate' => 'Tipo de cambio máximo',
			'currencies.empty' => 'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos',
			'currencies.select_a_currency' => 'Selecciona una divisa',
			'currencies.search' => 'Busca por nombre o por código de la divisa',
			'tags.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Etiqueta', other: 'Etiquetas', ), 
			'tags.form.name' => 'Nombre de la etiqueta',
			'tags.form.name_hint' => 'Ej.: Comida',
			'tags.form.forbidden_char_error' => 'El nombre no puede contener \';\'',
			'tags.form.description' => 'Descripción',
			'tags.select.title' => 'Selecciona etiquetas',
			'tags.select.all' => 'Todas las etiquetas',
			'tags.empty_list' => 'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos',
			'tags.without_tags' => 'Sin etiquetas',
			'tags.add' => 'Añadir etiqueta',
			'tags.create' => 'Crear etiqueta',
			'tags.create_success' => 'Etiqueta creada correctamente',
			'tags.already_exists' => 'El nombre de esta etiqueta ya existe. Puede que quieras editarla',
			'tags.edit' => 'Editar etiqueta',
			'tags.edit_success' => 'Etiqueta editada correctamente',
			'tags.delete_success' => 'Categoría eliminada correctamente',
			'tags.delete_warning_header' => '¿Eliminar etiqueta?',
			'tags.delete_warning_message' => 'Esta acción no borrará las transacciones que poseen esta etiqueta.',
			'categories.unknown' => 'Categoría desconocida',
			'categories.create' => 'Crear categoría',
			'categories.create_success' => 'Categoría creada correctamente',
			'categories.new_category' => 'Nueva categoría',
			'categories.already_exists' => 'El nombre de esta categoría ya existe. Puede que quieras editarla',
			'categories.edit' => 'Editar categoría',
			'categories.edit_success' => 'Categoría editada correctamente',
			'categories.name' => 'Nombre de la categoría',
			'categories.type' => 'Tipo de categoría',
			'categories.both_types' => 'Ambos tipos',
			'categories.subcategories' => 'Subcategorías',
			'categories.subcategories_add' => 'Añadir subcategoría',
			'categories.make_parent' => 'Convertir en categoría',
			'categories.make_child' => 'Convertir en subcategoría',
			'categories.make_child_warning1' => ({required Object destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.',
			'categories.make_child_warning2' => ({required Object x, required Object destiny}) => 'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.',
			'categories.make_child_success' => 'Subcategorías creadas con exito',
			'categories.merge' => 'Fusionar con otra categoría',
			'categories.merge_warning1' => ({required Object x, required Object from, required Object destiny}) => 'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.',
			'categories.merge_warning2' => ({required Object from}) => 'La categoría <b>${from}</b> será eliminada de forma irreversible.',
			'categories.merge_success' => 'Categoría fusionada correctamente',
			'categories.delete_success' => 'Categoría eliminada correctamente',
			'categories.delete_warning_header' => '¿Eliminar categoría?',
			'categories.delete_warning_message' => ({required Object x}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.',
			'categories.select.title' => 'Selecciona categorías',
			'categories.select.select_one' => 'Selecciona una categoría',
			'categories.select.select_subcategory' => 'Elige una subcategoría',
			'categories.select.without_subcategory' => 'Sin subcategoría',
			'categories.select.all' => 'Todas las categorías',
			'categories.select.all_short' => 'Todas',
			'budgets.title' => 'Presupuestos',
			'budgets.status' => 'Estado del presupuesto',
			'budgets.repeated' => 'Periódicos',
			'budgets.one_time' => 'Una vez',
			'budgets.actives' => 'Activos',
			'budgets.from_budgeted' => 'De un total de ',
			'budgets.days_left' => 'días restantes',
			'budgets.days_to_start' => 'días para empezar',
			'budgets.since_expiration' => 'días desde su expiración',
			'budgets.no_budgets' => 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior',
			'budgets.delete' => 'Eliminar presupuesto',
			'budgets.delete_warning' => 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados',
			'budgets.form.title' => 'Nuevo presupuesto',
			'budgets.form.name' => 'Nombre',
			'budgets.form.value' => 'Límite',
			'budgets.form.create' => 'Crear presupuesto',
			'budgets.form.create_success' => 'Presupuesto creado correctamente',
			'budgets.form.edit' => 'Editar presupuesto',
			'budgets.form.edit_success' => 'Presupuesto editado correctamente',
			'budgets.form.negative_warn' => 'El límite de un presupuesto no puede ser negativo',
			'budgets.details.title' => 'Detalles del presupuesto',
			'budgets.details.statistics' => 'Estadísticas',
			'budgets.details.budget_value' => 'Presupuestado',
			'budgets.details.expend_evolution' => 'Evolución del gasto',
			'budgets.details.no_transactions' => 'Parece que no has realizado ningún gasto relativo a este presupuesto',
			'budgets.target_timeline_statuses.active' => 'Presupuesto activo',
			'budgets.target_timeline_statuses.past' => 'Presupuesto finalizado',
			'budgets.target_timeline_statuses.future' => 'Presupuesto futuro',
			'budgets.progress.labels.active_on_track' => 'Vas bien',
			'budgets.progress.labels.active_overspending' => 'Gastando de más',
			'budgets.progress.labels.active_indeterminate' => 'Activo',
			'budgets.progress.labels.success' => 'Objetivo cumplido',
			'budgets.progress.labels.fail' => 'Presupuesto excedido',
			'budgets.progress.description.active_on_track' => ({required Object dailyAmount, required Object remainingDays}) => 'Puedes gastar ${dailyAmount} al día durante los ${remainingDays} días restantes para cumplir con el presupuesto',
			'budgets.progress.description.active_overspending' => ({required Object dailyAmount, required Object remainingDays}) => 'Para volver al camino correcto, deberías limitar tu gasto a ${dailyAmount} al día durante los ${remainingDays} días restantes de este presuesto',
			'budgets.progress.description.active_indeterminate' => ({required Object amount}) => 'Te queda ${amount} para gastar.',
			'budgets.progress.description.active_exceeded' => ({required Object amount}) => 'Ya has excedido el límite de tu presupuesto por ${amount}. Si no encuentras ningún ingreso para este presupuesto, deberías dejar de gastar durante el resto de su periodo',
			'budgets.progress.description.success' => '¡Buen trabajo! Este presupuesto ha finalizado con éxito. Sigue creando presupuestos para gestionar tus gastos',
			'budgets.progress.description.fail' => ({required Object amount}) => 'Has excedido el presupuesto por ${amount}. ¡Intenta tener más cuidado la próxima vez!',
			'goals.title' => 'Objetivos',
			'goals.status' => 'Estado del objetivo',
			'goals.type.display' => 'Tipo de objetivo',
			'goals.type.income.title' => 'Objetivo de ahorro',
			'goals.type.income.descr' => 'Ideal para ahorrar dinero. Tienes éxito cuando el saldo supera tu objetivo.',
			'goals.type.expense.title' => 'Objetivo de gasto',
			'goals.type.expense.descr' => 'Sigue cuánto gastas y apunta a alcanzar una cantidad objetivo. Funciona bien para donaciones, caridad, gastos de ocio...',
			'goals.empty_title' => 'No se encontraron objetivos',
			'goals.empty_description' => '¡Crea un nuevo objetivo para empezar a seguir tus ahorros!',
			'goals.delete' => 'Borrar objetivo',
			'goals.delete_warning' => 'Esta acción es irreversible. Categorías y transacciones referentes a este objetivo no serán eliminados',
			'goals.form.new_title' => 'Nuevo objetivo',
			_ => null,
		} ?? switch (path) {
			'goals.form.edit_title' => 'Editar objetivo',
			'goals.form.target_amount' => 'Cantidad objetivo',
			'goals.form.initial_amount' => 'Cantidad inicial',
			'goals.form.name' => 'Nombre',
			'goals.form.name_hint' => 'Mi objetivo de ahorro',
			'goals.form.create_success' => 'Objetivo creado correctamente',
			'goals.form.edit_success' => 'Objetivo editado correctamente',
			'goals.form.negative_warn' => 'La cantidad del objetivo no puede ser negativa',
			'goals.details.title' => 'Detalles del objetivo',
			'goals.details.statistics' => 'Estadísticas',
			'goals.details.goal_value' => 'Objetivo',
			'goals.details.evolution' => 'Evolución',
			'goals.details.no_transactions' => 'Parece que no has realizado movimientos relacionados con este objetivo',
			'goals.target_timeline_statuses.active' => 'Objetivo activo',
			'goals.target_timeline_statuses.past' => 'Objetivo finalizado',
			'goals.target_timeline_statuses.future' => 'Objetivo futuro',
			'goals.progress.labels.active_on_track' => 'En camino',
			'goals.progress.labels.active_behind_schedule' => 'Por detrás',
			'goals.progress.labels.active_indeterminate' => 'Activo',
			'goals.progress.labels.success' => 'Objetivo alcanzado',
			'goals.progress.labels.fail' => 'Objetivo fallido',
			'goals.progress.description.active_on_track' => ({required Object dailyAmount, required Object remainingDays}) => '¡Vas por buen camino! Tienes que ahorrar ${dailyAmount} al día durante los ${remainingDays} días restantes',
			'goals.progress.description.active_behind_schedule' => ({required Object dailyAmount, required Object remainingDays}) => 'Vas con retraso. Tienes que ahorrar ${dailyAmount} al día para alcanzar tu objetivo en ${remainingDays} días',
			'goals.progress.description.active_indeterminate' => ({required Object amount}) => 'Necesitas ${amount} más para alcanzar tu objetivo.',
			'goals.progress.description.success' => '¡Felicidades! Has alcanzado tu objetivo.',
			'goals.progress.description.fail' => ({required Object amount}) => 'No has alcanzado tu objetivo por ${amount}.',
			'target_timeline_statuses.active' => 'Activo',
			'target_timeline_statuses.past' => 'Finalizado',
			'target_timeline_statuses.future' => 'Futuro',
			'backup.no_file_selected' => 'Ningún archivo seleccionado',
			'backup.no_directory_selected' => 'Ningún directorio seleccionado',
			'backup.export.title' => 'Exportar datos',
			'backup.export.title_short' => 'Exportar',
			'backup.export.type_of_export' => 'Tipo de exportación',
			'backup.export.other_options' => 'Opciones',
			'backup.export.all' => 'Respaldo total',
			'backup.export.all_descr' => 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.',
			'backup.export.transactions' => 'Respaldo de transacciones',
			'backup.export.transactions_descr' => 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.',
			'backup.export.transactions_to_export' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '1 transacción para exportar', other: '${n} transacciones para exportar', ), 
			'backup.export.description' => 'Exporta tus datos en diferentes formatos',
			'backup.export.send_file' => 'Enviar archivo',
			'backup.export.see_folder' => 'Ver carpeta',
			'backup.export.success' => ({required Object x}) => 'Archivo guardado correctamente en ${x}',
			'backup.export.error' => 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com',
			'backup.export.dialog_title' => 'Guardar/Enviar archivo',
			'backup.import.title' => 'Importar tus datos',
			'backup.import.title_short' => 'Importar',
			'backup.import.restore_backup' => 'Restaurar copia de seguridad',
			'backup.import.restore_backup_descr' => 'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos',
			'backup.import.restore_backup_warn_description' => 'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin',
			'backup.import.restore_backup_warn_title' => 'Sobreescribir todos los datos',
			'backup.import.select_other_file' => 'Selecciona otro fichero',
			'backup.import.tap_to_select_file' => 'Pulsa para seleccionar un archivo',
			'backup.import.manual_import.title' => 'Importación manual',
			'backup.import.manual_import.descr' => 'Importa transacciones desde un fichero .csv de forma manual',
			'backup.import.manual_import.default_account' => 'Cuenta por defecto',
			'backup.import.manual_import.remove_default_account' => 'Eliminar cuenta por defecto',
			'backup.import.manual_import.default_category' => 'Categoría por defecto',
			'backup.import.manual_import.default_tags' => 'Etiquetas por defecto',
			'backup.import.manual_import.select_a_column' => 'Selecciona una columna del .csv',
			'backup.import.manual_import.date_format' => 'Formato de fecha',
			'backup.import.manual_import.note_column' => 'Columna de nota',
			'backup.import.manual_import.title_column' => 'Columna de título',
			'backup.import.manual_import.tag_separator' => 'Separador de etiquetas en el .csv',
			'backup.import.manual_import.steps.0' => 'Selecciona tu fichero',
			'backup.import.manual_import.steps.1' => 'Columna para la cantidad',
			'backup.import.manual_import.steps.2' => 'Columna para la cuenta',
			'backup.import.manual_import.steps.3' => 'Columna para la categoría',
			'backup.import.manual_import.steps.4' => 'Columna para las etiquetas',
			'backup.import.manual_import.steps.5' => 'Columna para la fecha',
			'backup.import.manual_import.steps.6' => 'Otras columnas',
			'backup.import.manual_import.steps_descr.0' => 'Selecciona un fichero .csv de tu dispositivo. Asegúrate de que este tenga una primera fila que describa el nombre de cada columna.',
			'backup.import.manual_import.steps_descr.1' => 'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos.',
			'backup.import.manual_import.steps_descr.2' => 'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre.',
			'backup.import.manual_import.steps_descr.3' => 'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar.',
			'backup.import.manual_import.steps_descr.4' => 'Especifica la columna donde se encuentran las etiquetas de transacción. En caso de no especificarse, las transacciones se crearán con etiquetas predeterminadas.',
			'backup.import.manual_import.steps_descr.5' => 'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual.',
			'backup.import.manual_import.steps_descr.6' => 'Especifica las columnas para otros atributos optativos de las transacciones.',
			'backup.import.manual_import.success' => ({required Object x}) => 'Se han importado correctamente ${x} transacciones',
			'backup.import.success' => 'Importación realizada con exito',
			'backup.import.error' => 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com',
			'backup.import.cancelled' => 'La importación fue cancelada por el usuario',
			'backup.about.title' => 'Información sobre tu base de datos',
			'backup.about.create_date' => 'Fecha de creación',
			'backup.about.modify_date' => 'Última modificación',
			'backup.about.last_backup' => 'Última copia de seguridad',
			'backup.about.size' => 'Tamaño',
			'settings.title_long' => 'Ajustes y Personalización',
			'settings.title_short' => 'Configuración',
			'settings.description' => 'Tema, Idioma, Datos y más',
			'settings.edit_profile' => 'Editar perfil',
			'settings.general.menu_title' => 'Ajustes generales',
			'settings.general.menu_descr' => 'Idioma, privacidad y más',
			'settings.general.show_all_decimals' => 'Mostrar todos los decimales',
			'settings.general.show_all_decimals_descr' => 'Mostrar todos los decimales incluso si hay ceros finales',
			'settings.general.language.section' => 'Idioma y textos',
			'settings.general.language.title' => 'Idioma de la aplicación',
			'settings.general.language.descr' => 'Idioma en el que se mostrarán los textos en la aplicación',
			'settings.general.language.help' => 'Si quieres colaborar con las traducciones de esta app puedes consultar <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>nuestra guía</a> ',
			'settings.general.locale.title' => 'Región',
			'settings.general.locale.auto' => 'Sistema',
			'settings.general.locale.descr' => 'Establecer el formato a utilizar para fechas, números...',
			'settings.general.locale.warn' => 'Al cambiar la región, la aplicación se actualizará',
			'settings.general.locale.first_day_of_week' => 'Primer día de la semana',
			'settings.security.title' => 'Seguridad',
			'settings.security.private_mode_at_launch' => 'Modo privado al arrancar',
			'settings.security.private_mode_at_launch_descr' => 'Arranca la app en modo privado por defecto',
			'settings.security.private_mode' => 'Modo privado',
			'settings.security.private_mode_descr' => 'Oculta todos los valores monetarios',
			'settings.security.private_mode_activated' => 'Modo privado activado',
			'settings.security.private_mode_deactivated' => 'Modo privado desactivado',
			'settings.transactions.menu_title' => 'Transacciones',
			'settings.transactions.menu_descr' => 'Configura el comportamiento de tus transacciones',
			'settings.transactions.title' => 'Ajustes de transacciones',
			'settings.transactions.style.title' => 'Estilo de transacción',
			'settings.transactions.style.subtitle' => 'Configura cómo se ven las transacciones en las listas',
			'settings.transactions.style.show_tags' => 'Ver Etiquetas',
			'settings.transactions.style.show_time' => 'Ver Hora',
			'settings.transactions.swipe_actions.title' => 'Acciones al deslizar el dedo',
			'settings.transactions.swipe_actions.choose_description' => 'Elije qué acción se activará cuando deslices una transacción del listado de transacciones usando esta dirección de deslizamiento',
			'settings.transactions.swipe_actions.swipe_left' => 'Desliza hacia la izquierda',
			'settings.transactions.swipe_actions.swipe_right' => 'Desliza hacia la derecha',
			'settings.transactions.swipe_actions.none' => 'No action',
			'settings.transactions.swipe_actions.toggle_reconciled' => 'Alternar conciliado',
			'settings.transactions.swipe_actions.toggle_pending' => 'Alternar pendiente',
			'settings.transactions.swipe_actions.toggle_voided' => 'Alternar anulado',
			'settings.transactions.swipe_actions.toggle_unreconciled' => 'Alternar no reconciliado',
			'settings.transactions.swipe_actions.remove_status' => 'Eliminar estado',
			'settings.transactions.default_values.title' => 'Valores por defecto',
			'settings.transactions.default_values.page_title' => 'Nueva transacción: Valores por defecto',
			'settings.transactions.default_values.reuse_last_transaction' => 'Reutilizar valores de la última transacción',
			'settings.transactions.default_values.reuse_last_transaction_descr' => 'Rellenar automáticamente el formulario con valores de la última transacción creada',
			'settings.transactions.default_values.fields_to_reuse' => 'Campos a reutilizar',
			'settings.transactions.default_values.reuse_last_values_modal_descr' => 'Selecciona los campos que deben rellenarse con los valores de la última transacción creada.',
			'settings.transactions.default_values.default_values_separator' => 'Valores por defecto',
			'settings.transactions.default_values.default_category' => 'Categoría por defecto',
			'settings.transactions.default_values.default_status' => 'Estado por defecto',
			'settings.transactions.default_values.default_tags' => 'Etiquetas por defecto',
			'settings.transactions.default_values.no_tags_selected' => 'Sin etiquetas seleccionadas',
			'settings.transactions.default_type.title' => 'Tipo por defecto',
			'settings.transactions.default_type.modal_title' => 'Seleccionar tipo por defecto',
			'settings.appearance.menu_title' => 'Tema y estilo',
			'settings.appearance.menu_descr' => 'Selección de tema, colores y otras cosas relacionadas con la apariencia de la aplicación',
			'settings.appearance.theme_and_colors' => 'Tema y colores',
			'settings.appearance.theme.title' => 'Tema',
			'settings.appearance.theme.auto' => 'Sistema',
			'settings.appearance.theme.light' => 'Claro',
			'settings.appearance.theme.dark' => 'Oscuro',
			'settings.appearance.amoled_mode' => 'Modo AMOLED',
			'settings.appearance.amoled_mode_descr' => 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED',
			'settings.appearance.dynamic_colors' => 'Colores dinámicos',
			'settings.appearance.dynamic_colors_descr' => 'Usar el color de acento de su sistema siempre que sea posible',
			'settings.appearance.accent_color' => 'Color de acento',
			'settings.appearance.accent_color_descr' => 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz',
			'settings.appearance.text' => 'Texto',
			'settings.appearance.font' => 'Fuente',
			'settings.appearance.font_platform' => 'Plataforma',
			'more.title' => 'Más',
			'more.title_long' => 'Más acciones',
			'more.data.display' => 'Datos',
			'more.data.display_descr' => 'Exporta y importa tus datos para no perder nada',
			'more.data.delete_all' => 'Eliminar mis datos',
			'more.data.delete_all_header1' => 'Alto ahí padawan ⚠️⚠️',
			'more.data.delete_all_message1' => '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados',
			'more.data.delete_all_header2' => 'Un último paso ⚠️⚠️',
			'more.data.delete_all_message2' => 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?',
			'more.about_us.display' => 'Información de la app',
			'more.about_us.description' => 'Consulta información relevante sobre Monekin. Conecta reportando errores o compartiendo ideas',
			'more.about_us.legal.display' => 'Información legal',
			'more.about_us.legal.privacy' => 'Política de privacidad',
			'more.about_us.legal.terms' => 'Términos de uso',
			'more.about_us.legal.licenses' => 'Licencias',
			'more.about_us.project.display' => 'Proyecto',
			'more.about_us.project.contributors' => 'Colaboradores',
			'more.about_us.project.contributors_descr' => 'Todos los desarrolladores que han hecho que Monekin crezca',
			'more.about_us.project.contact' => 'Contacta con nosotros',
			'more.help_us.display' => 'Ayúdanos',
			'more.help_us.description' => 'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor',
			'more.help_us.rate_us' => 'Califícanos',
			'more.help_us.rate_us_descr' => '¡Cualquier valoración es bienvenida!',
			'more.help_us.share' => 'Comparte Monekin',
			'more.help_us.share_descr' => 'Comparte nuestra app a amigos y familiares',
			'more.help_us.share_text' => 'Monekin! La mejor app de finanzas personales. Descargala aquí',
			'more.help_us.thanks' => '¡Gracias!',
			'more.help_us.donate' => 'Haz una donación',
			'more.help_us.donate_descr' => 'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?',
			'more.help_us.donate_success' => 'Donación realizada. Muchas gracias por tu contribución! ❤️',
			'more.help_us.donate_err' => 'Ups! Parece que ha habido un error a la hora de recibir tu pago',
			'more.help_us.report' => 'Reporta errores, deja sugerencias...',
			'more.help_us.thanks_long' => 'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.',
			_ => null,
		};
	}
}

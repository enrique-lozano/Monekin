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
class TranslationsEs implements Translations {
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
	@override String get select_a_column => 'Selecciona una columna del .csv';
	@override List<String> get steps => [
		'Selecciona tu fichero',
		'Columna para la cantidad',
		'Columna para la cuenta',
		'Columna para la categoría',
		'Columna para la fecha',
		'Otras columnas',
	];
	@override List<String> get steps_descr => [
		'Selecciona un fichero .csv de tu dispositivo. Asegurate de que este tenga una primera fila que describa el nombre de cada columna',
		'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos. Usa un punto como separador decimal',
		'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre',
		'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar',
		'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual',
		'Especifica las columnas para otros atributos optativos de las transacciones',
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
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = 'Cancelar';
		map['ui_actions.confirm'] = 'Confirmar';
		map['ui_actions.continue_text'] = 'Continuar';
		map['ui_actions.save'] = 'Guardar';
		map['ui_actions.save_changes'] = 'Guardar cambios';
		map['ui_actions.close_and_save'] = 'Guardar y cerrar';
		map['ui_actions.add'] = 'Añadir';
		map['ui_actions.edit'] = 'Editar';
		map['ui_actions.delete'] = 'Eliminar';
		map['ui_actions.see_more'] = 'Ver más';
		map['ui_actions.select_all'] = 'Seleccionar todo';
		map['ui_actions.deselect_all'] = 'Deseleccionar todo';
		map['ui_actions.select'] = 'Seleccionar';
		map['ui_actions.search'] = 'Buscar';
		map['ui_actions.filter'] = 'Filter';
		map['ui_actions.reset'] = 'Restablecer';
		map['ui_actions.submit'] = 'Enviar';
		map['ui_actions.next'] = 'Siguiente';
		map['ui_actions.previous'] = 'Anterior';
		map['ui_actions.back'] = 'Atrás';
		map['ui_actions.reload'] = 'Recargar';
		map['ui_actions.view'] = 'Ver';
		map['ui_actions.download'] = 'Descargar';
		map['ui_actions.upload'] = 'Subir';
		map['ui_actions.retry'] = 'Reintentar';
		map['ui_actions.copy'] = 'Copiar';
		map['ui_actions.paste'] = 'Pegar';
		map['ui_actions.undo'] = 'Deshacer';
		map['ui_actions.redo'] = 'Rehacer';
		map['ui_actions.open'] = 'Abrir';
		map['ui_actions.close'] = 'Cerrar';
		map['ui_actions.apply'] = 'Aplicar';
		map['ui_actions.discard'] = 'Descartar';
		map['ui_actions.refresh'] = 'Actualizar';
		map['ui_actions.share'] = 'Compartir';
		map['general.or'] = 'o';
		map['general.understood'] = 'Entendido';
		map['general.unspecified'] = 'Sin especificar';
		map['general.quick_actions'] = 'Acciones rápidas';
		map['general.details'] = 'Detalles';
		map['general.balance'] = 'Balance';
		map['general.account'] = 'Cuenta';
		map['general.accounts'] = 'Cuentas';
		map['general.categories'] = 'Categorías';
		map['general.category'] = 'Categoría';
		map['general.today'] = 'Hoy';
		map['general.yesterday'] = 'Ayer';
		map['general.filters'] = 'Filtros';
		map['general.empty_warn'] = 'Ops! Esto esta muy vacio';
		map['general.search_no_results'] = 'No hay elementos que coincidan con tus criterios de búsqueda';
		map['general.insufficient_data'] = 'Datos insuficientes';
		map['general.show_more_fields'] = 'Show more fields';
		map['general.show_less_fields'] = 'Show less fields';
		map['general.tap_to_search'] = 'Toca para buscar';
		map['general.delete_success'] = 'Elemento eliminado con éxito';
		map['general.leave_without_saving.title'] = '¿Salir sin guardar?';
		map['general.leave_without_saving.message'] = 'Tienes cambios sin guardar, ¿estás seguro de que quieres continuar y salir sin guardarlos?';
		map['general.clipboard.success'] = ({required Object x}) => '${x} copiado al portapapeles';
		map['general.clipboard.error'] = 'Error al copiar';
		map['general.time.start_date'] = 'Fecha de inicio';
		map['general.time.end_date'] = 'Fecha de fin';
		map['general.time.from_date'] = 'Desde fecha';
		map['general.time.until_date'] = 'Hasta fecha';
		map['general.time.date'] = 'Fecha';
		map['general.time.datetime'] = 'Fecha y hora';
		map['general.time.time'] = 'Hora';
		map['general.time.each'] = 'Cada';
		map['general.time.after'] = 'Tras';
		map['general.time.ranges.display'] = 'Rango temporal';
		map['general.time.ranges.it_repeat'] = 'Se repite';
		map['general.time.ranges.it_ends'] = 'Termina';
		map['general.time.ranges.forever'] = 'Para siempre';
		map['general.time.ranges.types.cycle'] = 'Ciclos';
		map['general.time.ranges.types.last_days'] = 'Últimos días';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '${x} días anteriores';
		map['general.time.ranges.types.all'] = 'Siempre';
		map['general.time.ranges.types.date_range'] = 'Rango personalizado';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range}',
				other: 'Cada ${n} ${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} hasta el ${day}',
				other: 'Cada ${n} ${range} hasta el ${day}',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} ${limit} veces',
				other: 'Cada ${n} ${range} ${limit} veces',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} una vez',
				other: 'Cada ${n} ${range} una vez',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Mes',
				other: 'Meses',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Año',
				other: 'Años',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Día',
				other: 'Días',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Semana',
				other: 'Semanas',
			);
		map['general.time.periodicity.display'] = 'Periodicidad';
		map['general.time.periodicity.no_repeat'] = 'Sin repetición';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Repetición',
				other: 'Repeticiones',
			);
		map['general.time.periodicity.diary'] = 'Diaría';
		map['general.time.periodicity.monthly'] = 'Mensual';
		map['general.time.periodicity.annually'] = 'Anual';
		map['general.time.periodicity.quaterly'] = 'Trimestral';
		map['general.time.periodicity.weekly'] = 'Semanal';
		map['general.time.periodicity.custom'] = 'Personalizado';
		map['general.time.periodicity.infinite'] = 'Siempre';
		map['general.time.current.monthly'] = 'Este mes';
		map['general.time.current.annually'] = 'Este año';
		map['general.time.current.quaterly'] = 'Este trimestre';
		map['general.time.current.weekly'] = 'Esta semana';
		map['general.time.current.infinite'] = 'Desde siempre';
		map['general.time.current.custom'] = 'Rango personalizado';
		map['general.time.current.diary'] = 'Este día';
		map['general.time.all.diary'] = 'Todos los días';
		map['general.time.all.monthly'] = 'Todos los meses';
		map['general.time.all.annually'] = 'Todos los años';
		map['general.time.all.quaterly'] = 'Todos los trimestres';
		map['general.time.all.weekly'] = 'Todas las semanas';
		map['general.transaction_order.display'] = 'Ordenar transacciones';
		map['general.transaction_order.category'] = 'Por categoría';
		map['general.transaction_order.quantity'] = 'Por cantidad';
		map['general.transaction_order.date'] = 'Por fecha';
		map['general.validations.form_error'] = 'Corrije los campos indicados en el formulario para continuar';
		map['general.validations.required'] = 'Campo obligatorio';
		map['general.validations.positive'] = 'Debe ser positivo';
		map['general.validations.min_number'] = ({required Object x}) => 'Debe ser mayor que ${x}';
		map['general.validations.max_number'] = ({required Object x}) => 'Debe ser menor que ${x}';
		map['intro.start'] = 'Empecemos';
		map['intro.skip'] = 'Saltar';
		map['intro.next'] = 'Siguiente';
		map['intro.select_your_currency'] = 'Selecciona tu divisa';
		map['intro.welcome_subtitle'] = 'Tu gestor de finanzas personales';
		map['intro.welcome_subtitle2'] = '100% libre, 100% gratis';
		map['intro.welcome_footer'] = 'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación';
		map['intro.offline_descr_title'] = 'CUENTA SIN CONEXIÓN:';
		map['intro.offline_descr'] = 'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
		map['intro.offline_start'] = 'Iniciar sesión offline';
		map['intro.sl1_title'] = 'Selecciona tu divisa';
		map['intro.sl1_descr'] = 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
		map['intro.sl2_title'] = 'Seguro, privado y confiable';
		map['intro.sl2_descr'] = 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
		map['intro.sl2_descr2'] = 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
		map['intro.last_slide_title'] = 'Todo listo!';
		map['intro.last_slide_descr'] = 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
		map['intro.last_slide_descr2'] = 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
		map['home.title'] = 'Inicio';
		map['home.filter_transactions'] = 'Filtrar transacciones';
		map['home.hello_day'] = 'Buenos días,';
		map['home.hello_night'] = 'Buenas noches,';
		map['home.total_balance'] = 'Saldo total';
		map['home.my_accounts'] = 'Mis cuentas';
		map['home.active_accounts'] = 'Cuentas activas';
		map['home.no_accounts'] = 'Aun no hay cuentas creadas';
		map['home.no_accounts_descr'] = 'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones';
		map['home.last_transactions'] = 'Últimas transacciones';
		map['home.should_create_account_header'] = 'Ops!';
		map['home.should_create_account_message'] = 'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones';
		map['financial_health.display'] = 'Salud financiera';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Excelente!';
					case GenderContext.female:
						return 'Excelente!';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Bueno';
					case GenderContext.female:
						return 'Buena';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'En la media';
					case GenderContext.female:
						return 'En la media';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Regular';
					case GenderContext.female:
						return 'Regular';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Muy malo';
					case GenderContext.female:
						return 'Muy mala';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Datos insuficientes';
					case GenderContext.female:
						return 'Datos insuficientes';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = 'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!';
		map['financial_health.review.descr.very_good'] = 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
		map['financial_health.review.descr.good'] = 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
		map['financial_health.review.descr.normal'] = 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
		map['financial_health.review.descr.bad'] = 'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas';
		map['financial_health.review.descr.very_bad'] = 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos';
		map['financial_health.months_without_income.title'] = 'Ratio de supervivencia';
		map['financial_health.months_without_income.subtitle'] = 'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos';
		map['financial_health.months_without_income.text_zero'] = '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!';
		map['financial_health.months_without_income.text_one'] = '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => 'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.';
		map['financial_health.months_without_income.text_infinite'] = 'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.';
		map['financial_health.months_without_income.suggestion'] = 'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.';
		map['financial_health.months_without_income.insufficient_data'] = 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
		map['financial_health.savings_percentage.title'] = 'Porcentaje de ahorro';
		map['financial_health.savings_percentage.subtitle'] = 'Que parte de tus ingresos no son gastados en este periodo';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => 'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => 'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => 'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!';
		map['financial_health.savings_percentage.text.very_bad'] = 'Vaya, no has conseguido ahorrar nada durante este periodo.';
		map['financial_health.savings_percentage.suggestion'] = 'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.';
		map['stats.title'] = 'Estadísticas';
		map['stats.balance'] = 'Saldo';
		map['stats.final_balance'] = 'Saldo final';
		map['stats.balance_by_account'] = 'Saldo por cuentas';
		map['stats.balance_by_account_subtitle'] = '¿Donde tengo la mayor parte de mi dinero?';
		map['stats.balance_by_currency'] = 'Saldo por divisas';
		map['stats.balance_by_currency_subtitle'] = '¿Cuanto dinero tengo en moneda extranjera?';
		map['stats.balance_evolution'] = 'Tendencia de saldo';
		map['stats.balance_evolution_subtitle'] = '¿Tengo más dinero que antes?';
		map['stats.compared_to_previous_period'] = 'Frente al periodo anterior';
		map['stats.cash_flow'] = 'Flujo de caja';
		map['stats.cash_flow_subtitle'] = '¿Estoy gastando menos de lo que gano?';
		map['stats.by_periods'] = 'Por periodos';
		map['stats.by_categories'] = 'Por categorías';
		map['stats.by_tags'] = 'Por etiquetas';
		map['stats.distribution'] = 'Distribución';
		map['stats.finance_health_resume'] = 'Resumen';
		map['stats.finance_health_breakdown'] = 'Desglose';
		map['icon_selector.name'] = 'Nombre:';
		map['icon_selector.icon'] = 'Icono';
		map['icon_selector.color'] = 'Color';
		map['icon_selector.select_icon'] = 'Selecciona un icono';
		map['icon_selector.select_color'] = 'Selecciona un color';
		map['icon_selector.custom_color'] = 'Color personalizado';
		map['icon_selector.current_color_selection'] = 'Selección actual';
		map['icon_selector.select_account_icon'] = 'Identifica tu cuenta';
		map['icon_selector.select_category_icon'] = 'Identifica tu categoría';
		map['icon_selector.scopes.transport'] = 'Transporte';
		map['icon_selector.scopes.money'] = 'Dinero';
		map['icon_selector.scopes.food'] = 'Comida';
		map['icon_selector.scopes.medical'] = 'Salud';
		map['icon_selector.scopes.entertainment'] = 'Entretenimiento';
		map['icon_selector.scopes.technology'] = 'Technología';
		map['icon_selector.scopes.other'] = 'Otros';
		map['icon_selector.scopes.logos_financial_institutions'] = 'Financial institutions';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Transacción',
				other: 'Transacciones',
			);
		map['transaction.create'] = 'Nueva transacción';
		map['transaction.new_income'] = 'Nuevo ingreso';
		map['transaction.new_expense'] = 'Nuevo gasto';
		map['transaction.new_success'] = 'Transacción creada correctamente';
		map['transaction.edit'] = 'Editar transacción';
		map['transaction.edit_success'] = 'Transacción editada correctamente';
		map['transaction.edit_multiple'] = 'Editar transacciones';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x} transacciones editadas correctamente';
		map['transaction.duplicate'] = 'Clonar transacción';
		map['transaction.duplicate_short'] = 'Clonar';
		map['transaction.duplicate_warning_message'] = 'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?';
		map['transaction.duplicate_success'] = 'Transacción clonada con exito';
		map['transaction.delete'] = 'Eliminar transacción';
		map['transaction.delete_warning_message'] = 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
		map['transaction.delete_success'] = 'Transacción eliminada correctamente';
		map['transaction.delete_multiple'] = 'Eliminar transacciones';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => 'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x} transacciones eliminadas correctamente';
		map['transaction.details'] = 'Detalles del movimiento';
		map['transaction.next_payments.accept'] = 'Aceptar';
		map['transaction.next_payments.skip'] = 'Saltar';
		map['transaction.next_payments.skip_success'] = 'Transacción saltada con exito';
		map['transaction.next_payments.skip_dialog_title'] = 'Saltar transacción';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => 'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}';
		map['transaction.next_payments.accept_today'] = 'Aceptar hoy';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => 'Aceptar en la fecha requerida (${date})';
		map['transaction.next_payments.accept_dialog_title'] = 'Aceptar transacción';
		map['transaction.next_payments.accept_dialog_msg_single'] = 'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => 'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones';
		map['transaction.next_payments.recurrent_rule_finished'] = 'La regla recurrente se ha completado, ya no hay mas pagos a realizar!';
		map['transaction.list.all'] = 'Todas las transacciones';
		map['transaction.list.empty'] = 'No se han encontrado transacciones que mostrar aquí. Añade unas cuantas transacciones en la app y quizas tengas más suerte la proxima vez';
		map['transaction.list.searcher_placeholder'] = 'Busca por categoría, descripción...';
		map['transaction.list.searcher_no_results'] = 'No se han encontrado transacciones que coincidan con los criterios de busqueda';
		map['transaction.list.loading'] = 'Cargando más transacciones...';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '${n} seleccionada',
				other: '${n} seleccionadas',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '${n} transacción seleccionada',
				other: '${n} transacciones seleccionadas',
			);
		map['transaction.list.bulk_edit.dates'] = 'Editar fechas';
		map['transaction.list.bulk_edit.categories'] = 'Editar categorías';
		map['transaction.list.bulk_edit.status'] = 'Editar estados';
		map['transaction.filters.title'] = 'Filtros de transacciones';
		map['transaction.filters.from_value'] = 'Desde monto';
		map['transaction.filters.to_value'] = 'Hasta monto';
		map['transaction.filters.from_value_def'] = ({required Object x}) => 'Desde ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => 'Hasta ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => 'Desde el ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => 'Hasta el ${date}';
		map['transaction.filters.reset'] = 'Restablecer filtros';
		map['transaction.filters.saved.title'] = 'Filtros guardados';
		map['transaction.filters.saved.new_title'] = 'Nuevo filtro';
		map['transaction.filters.saved.edit_title'] = 'Editar filtro';
		map['transaction.filters.saved.name_label'] = 'Nombre del filtro';
		map['transaction.filters.saved.name_hint'] = 'Mi filtro personalizado';
		map['transaction.filters.saved.save_dialog_title'] = 'Guardar filtro';
		map['transaction.filters.saved.save_tooltip'] = 'Guardar filtro actual';
		map['transaction.filters.saved.load_tooltip'] = 'Cargar filtro guardado';
		map['transaction.filters.saved.empty_title'] = 'No se encontraron filtros guardados';
		map['transaction.filters.saved.empty_description'] = 'Guarda filtros aquí para acceder a ellos rápidamente más tarde.';
		map['transaction.filters.saved.save_success'] = 'Filtro guardado correctamente';
		map['transaction.filters.saved.delete_success'] = 'Filtro eliminado correctamente';
		map['transaction.form.validators.zero'] = 'El valor de una transacción no puede ser igual a cero';
		map['transaction.form.validators.date_max'] = 'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente';
		map['transaction.form.validators.date_after_account_creation'] = 'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece';
		map['transaction.form.validators.negative_transfer'] = 'El valor monetario de una transferencia no puede ser negativo';
		map['transaction.form.validators.transfer_between_same_accounts'] = 'Las cuentas de origen y destino no pueden coincidir';
		map['transaction.form.title'] = 'Título de la transacción';
		map['transaction.form.title_short'] = 'Título';
		map['transaction.form.value'] = 'Valor de la transacción';
		map['transaction.form.tap_to_see_more'] = 'Toca para ver más detalles';
		map['transaction.form.no_tags'] = '-- Sin etiquetas --';
		map['transaction.form.description'] = 'Descripción';
		map['transaction.form.description_info'] = 'Toca aquí para escribir una descripción mas detallada sobre esta transacción';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => 'Cambio a ${currency}';
		map['transaction.form.exchange_to_preferred_in_date'] = 'El día de la transacción';
		map['transaction.reversed.title'] = 'Transacción invertida';
		map['transaction.reversed.title_short'] = 'Tr. invertida';
		map['transaction.reversed.description_for_expenses'] = 'A pesar de ser una transacción de tipo gasto, esta transacción tiene un monto positivo. Este tipo de transacciones pueden usarse para representar la devolución de un gasto previamente registrado, como un reembolso o que te realicen el pago de una deuda.';
		map['transaction.reversed.description_for_incomes'] = 'A pesar de ser una transacción de tipo ingreso, esta transacción tiene un monto negativo. Este tipo de transacciones pueden usarse para anular o corregir un ingreso que fue registrado incorrectamente, para reflejar una devolución o reembolso de dinero o para registrar el pago de deudas.';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Estado',
				other: 'Estados',
			);
		map['transaction.status.display_long'] = 'Estado de la transacción';
		map['transaction.status.tr_status'] = ({required Object status}) => 'Transacción ${status}';
		map['transaction.status.none'] = 'Sin estado';
		map['transaction.status.none_descr'] = 'Transacción sin un estado concreto';
		map['transaction.status.reconciled'] = 'Reconciliada';
		map['transaction.status.reconciled_descr'] = 'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco';
		map['transaction.status.unreconciled'] = 'No reconciliada';
		map['transaction.status.unreconciled_descr'] = 'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin';
		map['transaction.status.pending'] = 'Pendiente';
		map['transaction.status.pending_descr'] = 'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas';
		map['transaction.status.voided'] = 'Nula';
		map['transaction.status.voided_descr'] = 'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Tipo de transacción',
				other: 'Tipos de transacción',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Ingreso',
				other: 'Ingresos',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Gasto',
				other: 'Gastos',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Transferencia',
				other: 'Transferencias',
			);
		map['transfer.display'] = 'Transferencia';
		map['transfer.transfers'] = 'Transferencias';
		map['transfer.transfer_to'] = ({required Object account}) => 'Transferencia hacia ${account}';
		map['transfer.create'] = 'Nueva transferencia';
		map['transfer.need_two_accounts_warning_header'] = 'Ops!';
		map['transfer.need_two_accounts_warning_message'] = 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
		map['transfer.form.from'] = 'Cuenta origen';
		map['transfer.form.to'] = 'Cuenta destino';
		map['transfer.form.value_in_destiny.title'] = 'Cantidad transferida en destino';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} a cuenta de destino';
		map['recurrent_transactions.title'] = 'Movimientos recurrentes';
		map['recurrent_transactions.title_short'] = 'Mov. recurrentes';
		map['recurrent_transactions.empty'] = 'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
		map['recurrent_transactions.total_expense_title'] = 'Gasto total por periodo';
		map['recurrent_transactions.total_expense_descr'] = '* Sin considerar la fecha de inicio y fin de cada recurrencia';
		map['recurrent_transactions.details.title'] = 'Transaccion recurrente';
		map['recurrent_transactions.details.descr'] = 'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento';
		map['recurrent_transactions.details.last_payment_info'] = 'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción';
		map['recurrent_transactions.details.delete_header'] = 'Eliminar transacción recurrente';
		map['recurrent_transactions.details.delete_message'] = 'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => 'Atrasado por ${x}d';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => 'En ${x} días';
		map['account.details'] = 'Detalles de la cuenta';
		map['account.date'] = 'Fecha de apertura';
		map['account.close_date'] = 'Fecha de cierre';
		map['account.reopen'] = 'Reabrir cuenta';
		map['account.reopen_short'] = 'Reabrir';
		map['account.reopen_descr'] = '¿Seguro que quieres volver a abrir esta cuenta?';
		map['account.balance'] = 'Saldo de la cuenta';
		map['account.n_transactions'] = 'Número de transacciones';
		map['account.add_money'] = 'Añadir dinero';
		map['account.withdraw_money'] = 'Retirar dinero';
		map['account.no_accounts'] = 'No se han encontrado cuentas que mostrar aquí. Añade una cuenta pulsando el botón \'+\' de la parte inferior';
		map['account.types.title'] = 'Tipo de cuenta';
		map['account.types.warning'] = 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
		map['account.types.normal'] = 'Cuenta corriente';
		map['account.types.normal_descr'] = 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
		map['account.types.saving'] = 'Cuenta de ahorros';
		map['account.types.saving_descr'] = 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
		map['account.form.name'] = 'Nombre de la cuenta';
		map['account.form.name_placeholder'] = 'Ej: Cuenta de ahorros';
		map['account.form.notes'] = 'Notas';
		map['account.form.notes_placeholder'] = 'Escribe algunas notas/descripciones sobre esta cuenta';
		map['account.form.initial_balance'] = 'Balance inicial';
		map['account.form.current_balance'] = 'Balance actual';
		map['account.form.create'] = 'Crear cuenta';
		map['account.form.edit'] = 'Editar cuenta';
		map['account.form.currency_not_found_warn'] = 'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes';
		map['account.form.already_exists'] = 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
		map['account.form.tr_before_opening_date'] = 'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura';
		map['account.form.iban'] = 'IBAN';
		map['account.form.swift'] = 'SWIFT';
		map['account.delete.warning_header'] = '¿Eliminar cuenta?';
		map['account.delete.warning_text'] = 'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.';
		map['account.delete.success'] = 'Cuenta eliminada correctamente';
		map['account.close.title'] = 'Cerrar cuenta';
		map['account.close.title_short'] = 'Cerrar';
		map['account.close.warn'] = 'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras';
		map['account.close.should_have_zero_balance'] = 'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar';
		map['account.close.should_have_no_transactions'] = 'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar';
		map['account.close.success'] = 'Cuenta cerrada exitosamente';
		map['account.close.unarchive_succes'] = 'Cuenta re-abierta exitosamente';
		map['account.select.one'] = 'Selecciona una cuenta';
		map['account.select.all'] = 'Todas las cuentas';
		map['account.select.multiple'] = 'Selecciona cuentas';
		map['currencies.currency_converter'] = 'Conversor de divisas';
		map['currencies.currency'] = 'Divisa';
		map['currencies.currency_settings'] = 'Configuración de la divisa';
		map['currencies.currency_manager'] = 'Administrador de divisas';
		map['currencies.currency_manager_descr'] = 'Configura tu divisa y sus tipos de cambio con otras';
		map['currencies.preferred_currency'] = 'Divisa predeterminada/base';
		map['currencies.tap_to_change_preferred_currency'] = 'Toca para cambiar';
		map['currencies.change_preferred_currency_title'] = 'Cambiar divisa predeterminada';
		map['currencies.change_preferred_currency_msg'] = 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
		map['currencies.exchange_rate_form.equal_to_preferred_warn'] = 'La divisa seleccionada no puede ser la misma que la divisa predeterminada';
		map['currencies.exchange_rate_form.override_existing_warn'] = 'Ya existe un tipo de cambio para esta moneda en esta fecha. Si continúas se sobrescribirá el anterior.';
		map['currencies.exchange_rate_form.specify_a_currency'] = 'Por favor, especifica una divisa';
		map['currencies.exchange_rate_form.add'] = 'Añadir tipo de cambio';
		map['currencies.exchange_rate_form.add_success'] = 'Tipo de cambio añadido correctamente';
		map['currencies.exchange_rate_form.edit'] = 'Editar tipo de cambio';
		map['currencies.exchange_rate_form.edit_success'] = 'Tipo de cambio editado correctamente';
		map['currencies.exchange_rate_form.remove_all'] = 'Eliminar todos los tipos de cambio';
		map['currencies.exchange_rate_form.remove_all_warning'] = 'Esta acción es irreversible y eliminará todos los tipos de cambio de esta moneda.';
		map['currencies.types.display'] = 'Tipo de moneda';
		map['currencies.types.fiat'] = 'FÍAT';
		map['currencies.types.crypto'] = 'Criptomoneda';
		map['currencies.types.other'] = 'Otro';
		map['currencies.currency_form.name'] = 'Nombre a mostrar';
		map['currencies.currency_form.code'] = 'Código de la divisa';
		map['currencies.currency_form.symbol'] = 'Símbolo';
		map['currencies.currency_form.decimal_digits'] = 'Dígitos decimales';
		map['currencies.currency_form.create'] = 'Crear divisa';
		map['currencies.currency_form.create_success'] = 'Divisa creada exitosamente';
		map['currencies.currency_form.edit'] = 'Editar divisa';
		map['currencies.currency_form.edit_success'] = 'Divisa editada correctamente';
		map['currencies.currency_form.delete'] = 'Eliminar moneda';
		map['currencies.currency_form.delete_success'] = 'Moneda eliminada exitosamente';
		map['currencies.currency_form.already_exists'] = 'Ya existe una divisa con este código. Quizás quieras editarlo';
		map['currencies.delete_all_success'] = 'Tipos de cambio borrados con exito';
		map['currencies.historical'] = 'Histórico de tasas';
		map['currencies.historical_empty'] = 'No se encontraron tipos de cambio históricos para esta divisa';
		map['currencies.exchange_rate'] = 'Tipo de cambio';
		map['currencies.exchange_rates'] = 'Tipos de cambio';
		map['currencies.min_exchange_rate'] = 'Tipo de cambio mínimo';
		map['currencies.max_exchange_rate'] = 'Tipo de cambio máximo';
		map['currencies.empty'] = 'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos';
		map['currencies.select_a_currency'] = 'Selecciona una divisa';
		map['currencies.search'] = 'Busca por nombre o por código de la divisa';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Etiqueta',
				other: 'Etiquetas',
			);
		map['tags.form.name'] = 'Nombre de la etiqueta';
		map['tags.form.description'] = 'Descripción';
		map['tags.select.title'] = 'Selecciona etiquetas';
		map['tags.select.all'] = 'Todas las etiquetas';
		map['tags.empty_list'] = 'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos';
		map['tags.without_tags'] = 'Sin etiquetas';
		map['tags.add'] = 'Añadir etiqueta';
		map['tags.create'] = 'Crear etiqueta';
		map['tags.create_success'] = 'Etiqueta creada correctamente';
		map['tags.already_exists'] = 'El nombre de esta etiqueta ya existe. Puede que quieras editarla';
		map['tags.edit'] = 'Editar etiqueta';
		map['tags.edit_success'] = 'Etiqueta editada correctamente';
		map['tags.delete_success'] = 'Categoría eliminada correctamente';
		map['tags.delete_warning_header'] = '¿Eliminar etiqueta?';
		map['tags.delete_warning_message'] = 'Esta acción no borrará las transacciones que poseen esta etiqueta.';
		map['categories.unknown'] = 'Categoría desconocida';
		map['categories.create'] = 'Crear categoría';
		map['categories.create_success'] = 'Categoría creada correctamente';
		map['categories.new_category'] = 'Nueva categoría';
		map['categories.already_exists'] = 'El nombre de esta categoría ya existe. Puede que quieras editarla';
		map['categories.edit'] = 'Editar categoría';
		map['categories.edit_success'] = 'Categoría editada correctamente';
		map['categories.name'] = 'Nombre de la categoría';
		map['categories.type'] = 'Tipo de categoría';
		map['categories.both_types'] = 'Ambos tipos';
		map['categories.subcategories'] = 'Subcategorías';
		map['categories.subcategories_add'] = 'Añadir subcategoría';
		map['categories.make_parent'] = 'Convertir en categoría';
		map['categories.make_child'] = 'Convertir en subcategoría';
		map['categories.make_child_warning1'] = ({required Object destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => 'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.';
		map['categories.make_child_success'] = 'Subcategorías creadas con exito';
		map['categories.merge'] = 'Fusionar con otra categoría';
		map['categories.merge_warning1'] = ({required Object x, required Object from, required Object destiny}) => 'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.';
		map['categories.merge_warning2'] = ({required Object from}) => 'La categoría <b>${from}</b> será eliminada de forma irreversible.';
		map['categories.merge_success'] = 'Categoría fusionada correctamente';
		map['categories.delete_success'] = 'Categoría eliminada correctamente';
		map['categories.delete_warning_header'] = '¿Eliminar categoría?';
		map['categories.delete_warning_message'] = ({required Object x}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.';
		map['categories.select.title'] = 'Selecciona categorías';
		map['categories.select.select_one'] = 'Selecciona una categoría';
		map['categories.select.select_subcategory'] = 'Elige una subcategoría';
		map['categories.select.without_subcategory'] = 'Sin subcategoría';
		map['categories.select.all'] = 'Todas las categorías';
		map['categories.select.all_short'] = 'Todas';
		map['budgets.title'] = 'Presupuestos';
		map['budgets.status'] = 'Estado del presupuesto';
		map['budgets.repeated'] = 'Periódicos';
		map['budgets.one_time'] = 'Una vez';
		map['budgets.actives'] = 'Activos';
		map['budgets.from_budgeted'] = 'De un total de ';
		map['budgets.days_left'] = 'días restantes';
		map['budgets.days_to_start'] = 'días para empezar';
		map['budgets.since_expiration'] = 'días desde su expiración';
		map['budgets.no_budgets'] = 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
		map['budgets.delete'] = 'Eliminar presupuesto';
		map['budgets.delete_warning'] = 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
		map['budgets.form.title'] = 'Nuevo presupuesto';
		map['budgets.form.name'] = 'Nombre';
		map['budgets.form.value'] = 'Límite';
		map['budgets.form.create'] = 'Crear presupuesto';
		map['budgets.form.create_success'] = 'Presupuesto creado correctamente';
		map['budgets.form.edit'] = 'Editar presupuesto';
		map['budgets.form.edit_success'] = 'Presupuesto editado correctamente';
		map['budgets.form.negative_warn'] = 'El límite de un presupuesto no puede ser negativo';
		map['budgets.details.title'] = 'Detalles del presupuesto';
		map['budgets.details.statistics'] = 'Estadísticas';
		map['budgets.details.budget_value'] = 'Presupuestado';
		map['budgets.details.expend_evolution'] = 'Evolución del gasto';
		map['budgets.details.no_transactions'] = 'Parece que no has realizado ningún gasto relativo a este presupuesto';
		map['budgets.target_timeline_statuses.active'] = 'Presupuesto activo';
		map['budgets.target_timeline_statuses.past'] = 'Presupuesto finalizado';
		map['budgets.target_timeline_statuses.future'] = 'Presupuesto futuro';
		map['budgets.progress.labels.active_on_track'] = 'Vas bien';
		map['budgets.progress.labels.active_overspending'] = 'Gastando de más';
		map['budgets.progress.labels.active_indeterminate'] = 'Activo';
		map['budgets.progress.labels.success'] = 'Objetivo cumplido';
		map['budgets.progress.labels.fail'] = 'Presupuesto excedido';
		map['budgets.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => 'Puedes gastar ${dailyAmount} al día durante los ${remainingDays} días restantes para cumplir con el presupuesto';
		map['budgets.progress.description.active_overspending'] = ({required Object dailyAmount, required Object remainingDays}) => 'Para volver al camino correcto, deberías limitar tu gasto a ${dailyAmount} al día durante los ${remainingDays} días restantes de este presuesto';
		map['budgets.progress.description.active_indeterminate'] = ({required Object amount}) => 'Te queda ${amount} para gastar.';
		map['budgets.progress.description.active_exceeded'] = ({required Object amount}) => 'Ya has excedido el límite de tu presupuesto por ${amount}. Si no encuentras ningún ingreso para este presupuesto, deberías dejar de gastar durante el resto de su periodo';
		map['budgets.progress.description.success'] = '¡Buen trabajo! Este presupuesto ha finalizado con éxito. Sigue creando presupuestos para gestionar tus gastos';
		map['budgets.progress.description.fail'] = ({required Object amount}) => 'Has excedido el presupuesto por ${amount}. ¡Intenta tener más cuidado la próxima vez!';
		map['goals.title'] = 'Objetivos';
		map['goals.status'] = 'Estado del objetivo';
		map['goals.type.display'] = 'Tipo de objetivo';
		map['goals.type.income.title'] = 'Objetivo de ahorro';
		map['goals.type.income.descr'] = 'Ideal para ahorrar dinero. Tienes éxito cuando el saldo supera tu objetivo.';
		map['goals.type.expense.title'] = 'Objetivo de gasto';
		map['goals.type.expense.descr'] = 'Sigue cuánto gastas y apunta a alcanzar una cantidad objetivo. Funciona bien para donaciones, caridad, gastos de ocio...';
		map['goals.empty_title'] = 'No se encontraron objetivos';
		map['goals.empty_description'] = '¡Crea un nuevo objetivo para empezar a seguir tus ahorros!';
		map['goals.delete'] = 'Borrar objetivo';
		map['goals.delete_warning'] = 'Esta acción es irreversible. Categorías y transacciones referentes a este objetivo no serán eliminados';
		map['goals.form.new_title'] = 'Nuevo objetivo';
		map['goals.form.edit_title'] = 'Editar objetivo';
		map['goals.form.target_amount'] = 'Cantidad objetivo';
		map['goals.form.initial_amount'] = 'Cantidad inicial';
		map['goals.form.name'] = 'Nombre';
		map['goals.form.name_hint'] = 'Mi objetivo de ahorro';
		map['goals.form.create_success'] = 'Objetivo creado correctamente';
		map['goals.form.edit_success'] = 'Objetivo editado correctamente';
		map['goals.form.negative_warn'] = 'La cantidad del objetivo no puede ser negativa';
		map['goals.details.title'] = 'Detalles del objetivo';
		map['goals.details.statistics'] = 'Estadísticas';
		map['goals.details.goal_value'] = 'Objetivo';
		map['goals.details.evolution'] = 'Evolución';
		map['goals.details.no_transactions'] = 'Parece que no has realizado movimientos relacionados con este objetivo';
		map['goals.target_timeline_statuses.active'] = 'Objetivo activo';
		map['goals.target_timeline_statuses.past'] = 'Objetivo finalizado';
		map['goals.target_timeline_statuses.future'] = 'Objetivo futuro';
		map['goals.progress.labels.active_on_track'] = 'En camino';
		map['goals.progress.labels.active_behind_schedule'] = 'Por detrás';
		map['goals.progress.labels.active_indeterminate'] = 'Activo';
		map['goals.progress.labels.success'] = 'Objetivo alcanzado';
		map['goals.progress.labels.fail'] = 'Objetivo fallido';
		map['goals.progress.description.active_on_track'] = ({required Object dailyAmount, required Object remainingDays}) => '¡Vas por buen camino! Tienes que ahorrar ${dailyAmount} al día durante los ${remainingDays} días restantes';
		map['goals.progress.description.active_behind_schedule'] = ({required Object dailyAmount, required Object remainingDays}) => 'Vas con retraso. Tienes que ahorrar ${dailyAmount} al día para alcanzar tu objetivo en ${remainingDays} días';
		map['goals.progress.description.active_indeterminate'] = ({required Object amount}) => 'Necesitas ${amount} más para alcanzar tu objetivo.';
		map['goals.progress.description.success'] = '¡Felicidades! Has alcanzado tu objetivo.';
		map['goals.progress.description.fail'] = ({required Object amount}) => 'No has alcanzado tu objetivo por ${amount}.';
		map['target_timeline_statuses.active'] = 'Activo';
		map['target_timeline_statuses.past'] = 'Finalizado';
		map['target_timeline_statuses.future'] = 'Futuro';
		map['backup.no_file_selected'] = 'Ningún archivo seleccionado';
		map['backup.no_directory_selected'] = 'Ningún directorio seleccionado';
		map['backup.export.title'] = 'Exportar datos';
		map['backup.export.title_short'] = 'Exportar';
		map['backup.export.type_of_export'] = 'Tipo de exportación';
		map['backup.export.other_options'] = 'Opciones';
		map['backup.export.all'] = 'Respaldo total';
		map['backup.export.all_descr'] = 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
		map['backup.export.transactions'] = 'Respaldo de transacciones';
		map['backup.export.transactions_descr'] = 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '1 transacción para exportar',
				other: '${n} transacciones para exportar',
			);
		map['backup.export.description'] = 'Exporta tus datos en diferentes formatos';
		map['backup.export.send_file'] = 'Enviar archivo';
		map['backup.export.see_folder'] = 'Ver carpeta';
		map['backup.export.success'] = ({required Object x}) => 'Archivo guardado correctamente en ${x}';
		map['backup.export.error'] = 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
		map['backup.export.dialog_title'] = 'Guardar/Enviar archivo';
		map['backup.import.title'] = 'Importar tus datos';
		map['backup.import.title_short'] = 'Importar';
		map['backup.import.restore_backup'] = 'Restaurar copia de seguridad';
		map['backup.import.restore_backup_descr'] = 'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos';
		map['backup.import.restore_backup_warn_description'] = 'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin';
		map['backup.import.restore_backup_warn_title'] = 'Sobreescribir todos los datos';
		map['backup.import.select_other_file'] = 'Selecciona otro fichero';
		map['backup.import.tap_to_select_file'] = 'Pulsa para seleccionar un archivo';
		map['backup.import.manual_import.title'] = 'Importación manual';
		map['backup.import.manual_import.descr'] = 'Importa transacciones desde un fichero .csv de forma manual';
		map['backup.import.manual_import.default_account'] = 'Cuenta por defecto';
		map['backup.import.manual_import.remove_default_account'] = 'Eliminar cuenta por defecto';
		map['backup.import.manual_import.default_category'] = 'Categoría por defecto';
		map['backup.import.manual_import.select_a_column'] = 'Selecciona una columna del .csv';
		map['backup.import.manual_import.steps.0'] = 'Selecciona tu fichero';
		map['backup.import.manual_import.steps.1'] = 'Columna para la cantidad';
		map['backup.import.manual_import.steps.2'] = 'Columna para la cuenta';
		map['backup.import.manual_import.steps.3'] = 'Columna para la categoría';
		map['backup.import.manual_import.steps.4'] = 'Columna para la fecha';
		map['backup.import.manual_import.steps.5'] = 'Otras columnas';
		map['backup.import.manual_import.steps_descr.0'] = 'Selecciona un fichero .csv de tu dispositivo. Asegurate de que este tenga una primera fila que describa el nombre de cada columna';
		map['backup.import.manual_import.steps_descr.1'] = 'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos. Usa un punto como separador decimal';
		map['backup.import.manual_import.steps_descr.2'] = 'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre';
		map['backup.import.manual_import.steps_descr.3'] = 'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar';
		map['backup.import.manual_import.steps_descr.4'] = 'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual';
		map['backup.import.manual_import.steps_descr.5'] = 'Especifica las columnas para otros atributos optativos de las transacciones';
		map['backup.import.manual_import.success'] = ({required Object x}) => 'Se han importado correctamente ${x} transacciones';
		map['backup.import.success'] = 'Importación realizada con exito';
		map['backup.import.error'] = 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
		map['backup.import.cancelled'] = 'La importación fue cancelada por el usuario';
		map['backup.about.title'] = 'Información sobre tu base de datos';
		map['backup.about.create_date'] = 'Fecha de creación';
		map['backup.about.modify_date'] = 'Última modificación';
		map['backup.about.last_backup'] = 'Última copia de seguridad';
		map['backup.about.size'] = 'Tamaño';
		map['settings.title_long'] = 'Ajustes y Personalización';
		map['settings.title_short'] = 'Configuración';
		map['settings.description'] = 'Tema, Idioma, Datos y más';
		map['settings.edit_profile'] = 'Editar perfil';
		map['settings.general.menu_title'] = 'Ajustes generales';
		map['settings.general.menu_descr'] = 'Idioma, privacidad y más';
		map['settings.general.show_all_decimals'] = 'Mostrar todos los decimales';
		map['settings.general.show_all_decimals_descr'] = 'Mostrar todos los decimales incluso si hay ceros finales';
		map['settings.general.language.section'] = 'Idioma y textos';
		map['settings.general.language.title'] = 'Idioma de la aplicación';
		map['settings.general.language.descr'] = 'Idioma en el que se mostrarán los textos en la aplicación';
		map['settings.general.language.help'] = 'Si quieres colaborar con las traducciones de esta app puedes consultar <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>nuestra guía</a> ';
		map['settings.general.locale.title'] = 'Región';
		map['settings.general.locale.auto'] = 'Sistema';
		map['settings.general.locale.descr'] = 'Establecer el formato a utilizar para fechas, números...';
		map['settings.general.locale.warn'] = 'Al cambiar la región, la aplicación se actualizará';
		map['settings.general.locale.first_day_of_week'] = 'Primer día de la semana';
		map['settings.security.title'] = 'Seguridad';
		map['settings.security.private_mode_at_launch'] = 'Modo privado al arrancar';
		map['settings.security.private_mode_at_launch_descr'] = 'Arranca la app en modo privado por defecto';
		map['settings.security.private_mode'] = 'Modo privado';
		map['settings.security.private_mode_descr'] = 'Oculta todos los valores monetarios';
		map['settings.security.private_mode_activated'] = 'Modo privado activado';
		map['settings.security.private_mode_deactivated'] = 'Modo privado desactivado';
		map['settings.transactions.menu_title'] = 'Transacciones';
		map['settings.transactions.menu_descr'] = 'Configura el comportamiento de tus transacciones';
		map['settings.transactions.title'] = 'Ajustes de transacciones';
		map['settings.transactions.style.title'] = 'Estilo de transacción';
		map['settings.transactions.style.subtitle'] = 'Configura cómo se ven las transacciones en las listas';
		map['settings.transactions.style.show_tags'] = 'Ver Etiquetas';
		map['settings.transactions.style.show_time'] = 'Ver Hora';
		map['settings.transactions.swipe_actions.title'] = 'Acciones al deslizar el dedo';
		map['settings.transactions.swipe_actions.choose_description'] = 'Elije qué acción se activará cuando deslices una transacción del listado de transacciones usando esta dirección de deslizamiento';
		map['settings.transactions.swipe_actions.swipe_left'] = 'Desliza hacia la izquierda';
		map['settings.transactions.swipe_actions.swipe_right'] = 'Desliza hacia la derecha';
		map['settings.transactions.swipe_actions.none'] = 'No action';
		map['settings.transactions.swipe_actions.toggle_reconciled'] = 'Alternar conciliado';
		map['settings.transactions.swipe_actions.toggle_pending'] = 'Alternar pendiente';
		map['settings.transactions.swipe_actions.toggle_voided'] = 'Alternar anulado';
		map['settings.transactions.swipe_actions.toggle_unreconciled'] = 'Alternar no reconciliado';
		map['settings.transactions.swipe_actions.remove_status'] = 'Eliminar estado';
		map['settings.transactions.default_values.title'] = 'Valores por defecto';
		map['settings.transactions.default_values.page_title'] = 'Nueva transacción: Valores por defecto';
		map['settings.transactions.default_values.reuse_last_transaction'] = 'Reutilizar valores de la última transacción';
		map['settings.transactions.default_values.reuse_last_transaction_descr'] = 'Rellenar automáticamente el formulario con valores de la última transacción creada';
		map['settings.transactions.default_values.fields_to_reuse'] = 'Campos a reutilizar';
		map['settings.transactions.default_values.reuse_last_values_modal_descr'] = 'Selecciona los campos que deben rellenarse con los valores de la última transacción creada.';
		map['settings.transactions.default_values.default_values_separator'] = 'Valores por defecto';
		map['settings.transactions.default_values.default_category'] = 'Categoría por defecto';
		map['settings.transactions.default_values.default_status'] = 'Estado por defecto';
		map['settings.transactions.default_values.default_tags'] = 'Etiquetas por defecto';
		map['settings.transactions.default_values.no_tags_selected'] = 'Sin etiquetas seleccionadas';
		map['settings.transactions.default_type.title'] = 'Tipo por defecto';
		map['settings.transactions.default_type.modal_title'] = 'Seleccionar tipo por defecto';
		map['settings.appearance.menu_title'] = 'Tema y estilo';
		map['settings.appearance.menu_descr'] = 'Selección de tema, colores y otras cosas relacionadas con la apariencia de la aplicación';
		map['settings.appearance.theme_and_colors'] = 'Tema y colores';
		map['settings.appearance.theme.title'] = 'Tema';
		map['settings.appearance.theme.auto'] = 'Sistema';
		map['settings.appearance.theme.light'] = 'Claro';
		map['settings.appearance.theme.dark'] = 'Oscuro';
		map['settings.appearance.amoled_mode'] = 'Modo AMOLED';
		map['settings.appearance.amoled_mode_descr'] = 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
		map['settings.appearance.dynamic_colors'] = 'Colores dinámicos';
		map['settings.appearance.dynamic_colors_descr'] = 'Usar el color de acento de su sistema siempre que sea posible';
		map['settings.appearance.accent_color'] = 'Color de acento';
		map['settings.appearance.accent_color_descr'] = 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
		map['settings.appearance.text'] = 'Texto';
		map['settings.appearance.font'] = 'Fuente';
		map['settings.appearance.font_platform'] = 'Plataforma';
		map['more.title'] = 'Más';
		map['more.title_long'] = 'Más acciones';
		map['more.data.display'] = 'Datos';
		map['more.data.display_descr'] = 'Exporta y importa tus datos para no perder nada';
		map['more.data.delete_all'] = 'Eliminar mis datos';
		map['more.data.delete_all_header1'] = 'Alto ahí padawan ⚠️⚠️';
		map['more.data.delete_all_message1'] = '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
		map['more.data.delete_all_header2'] = 'Un último paso ⚠️⚠️';
		map['more.data.delete_all_message2'] = 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
		map['more.about_us.display'] = 'Información de la app';
		map['more.about_us.description'] = 'Consulta información relevante sobre Monekin. Conecta reportando errores o compartiendo ideas';
		map['more.about_us.legal.display'] = 'Información legal';
		map['more.about_us.legal.privacy'] = 'Política de privacidad';
		map['more.about_us.legal.terms'] = 'Términos de uso';
		map['more.about_us.legal.licenses'] = 'Licencias';
		map['more.about_us.project.display'] = 'Proyecto';
		map['more.about_us.project.contributors'] = 'Colaboradores';
		map['more.about_us.project.contributors_descr'] = 'Todos los desarrolladores que han hecho que Monekin crezca';
		map['more.about_us.project.contact'] = 'Contacta con nosotros';
		map['more.help_us.display'] = 'Ayúdanos';
		map['more.help_us.description'] = 'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor';
		map['more.help_us.rate_us'] = 'Califícanos';
		map['more.help_us.rate_us_descr'] = '¡Cualquier valoración es bienvenida!';
		map['more.help_us.share'] = 'Comparte Monekin';
		map['more.help_us.share_descr'] = 'Comparte nuestra app a amigos y familiares';
		map['more.help_us.share_text'] = 'Monekin! La mejor app de finanzas personales. Descargala aquí';
		map['more.help_us.thanks'] = '¡Gracias!';
		map['more.help_us.donate'] = 'Haz una donación';
		map['more.help_us.donate_descr'] = 'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?';
		map['more.help_us.donate_success'] = 'Donación realizada. Muchas gracias por tu contribución! ❤️';
		map['more.help_us.donate_err'] = 'Ups! Parece que ha habido un error a la hora de recibir tu pago';
		map['more.help_us.report'] = 'Reporta errores, deja sugerencias...';
		map['more.help_us.thanks_long'] = 'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.';

		_map = map;
		return map;
	}
}


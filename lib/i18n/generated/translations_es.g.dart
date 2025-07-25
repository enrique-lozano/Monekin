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
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
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
	@override String get details => 'Detalles';
	@override String get share => 'Compartir';
  @override String get none => 'Ninguno';
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
	@override String get balance => 'Balance';
	@override String get account => 'Cuenta';
	@override String get accounts => 'Cuentas';
	@override String get categories => 'Categorías';
	@override String get category => 'Categoría';
	@override String get today => 'Hoy';
	@override String get yesterday => 'Ayer';
	@override String get filters => 'Filtros';
	@override String get empty_warn => 'Ops! Esto esta muy vacio';
	@override String get insufficient_data => 'Datos insuficientes';
	@override String get show_more_fields => 'Show more fields';
	@override String get show_less_fields => 'Show less fields';
	@override String get tap_to_search => 'Toca para buscar';
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
	@override String get no_accounts => 'No se han encontrado cuentas que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
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
	@override String get currency_manager => 'Administrador de divisas';
	@override String get currency_manager_descr => 'Configura tu divisa y sus tipos de cambio con otras';
	@override String get preferred_currency => 'Divisa predeterminada/base';
	@override String get change_preferred_currency_title => 'Cambiar divisa predeterminada';
	@override String get change_preferred_currency_msg => 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
	@override late final _TranslationsCurrenciesFormEs form = _TranslationsCurrenciesFormEs._(_root);
	@override String get delete_all_success => 'Tipos de cambio borrados con exito';
	@override String get historical => 'Histórico de tasas';
	@override String get exchange_rate => 'Tipo de cambio';
	@override String get exchange_rates => 'Tipos de cambio';
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
	@override String get repeated => 'Periódicos';
	@override String get one_time => 'Una vez';
	@override String get annual => 'Anuales';
	@override String get week => 'Semanales';
	@override String get month => 'Mensuales';
	@override String get actives => 'Activos';
	@override String get pending => 'Pendientes de comenzar';
	@override String get finish => 'Finalizados';
	@override String get from_budgeted => 'De un total de ';
	@override String get days_left => 'días restantes';
	@override String get days_to_start => 'días para empezar';
	@override String get since_expiration => 'días desde su expiración';
	@override String get no_budgets => 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
	@override String get delete => 'Eliminar presupuesto';
	@override String get delete_warning => 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
	@override late final _TranslationsBudgetsFormEs form = _TranslationsBudgetsFormEs._(_root);
	@override late final _TranslationsBudgetsDetailsEs details = _TranslationsBudgetsDetailsEs._(_root);
}

// Path: backup
class _TranslationsBackupEs implements TranslationsBackupEn {
	_TranslationsBackupEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportEs export = _TranslationsBackupExportEs._(_root);
	@override late final _TranslationsBackupImportEs import = _TranslationsBackupImportEs._(_root);
	@override late final _TranslationsBackupAboutEs about = _TranslationsBackupAboutEs._(_root);
}

// Path: settings
class _TranslationsSettingsEs implements TranslationsSettingsEn {
	_TranslationsSettingsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Configuración y apariencia';
	@override String get title_short => 'Configuración';
	@override String get description => 'Tema de la aplicación, textos y otras configuraciones generales';
	@override String get edit_profile => 'Editar perfil';
	@override String get lang_section => 'Idioma y textos';
	@override String get lang_title => 'Idioma de la aplicación';
	@override String get lang_descr => 'Idioma en el que se mostrarán los textos en la aplicación';
	@override String get lang_help => 'Si quieres colaborar con las traducciones de esta app puedes consultar <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>nuestra guía</a> ';
	@override String get locale => 'Región';
	@override String get locale_descr => 'Establecer el formato a utilizar para fechas, números...';
	@override String get locale_warn => 'Al cambiar la región, la aplicación se actualizará';
	@override String get first_day_of_week => 'Primer día de la semana';
	@override String get theme_and_colors => 'Tema y colores';
	@override String get theme => 'Tema';
	@override String get theme_auto => 'Sistema';
	@override String get theme_light => 'Claro';
	@override String get theme_dark => 'Oscuro';
	@override String get amoled_mode => 'Modo AMOLED';
	@override String get amoled_mode_descr => 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
	@override String get dynamic_colors => 'Colores dinámicos';
	@override String get dynamic_colors_descr => 'Usar el color de acento de su sistema siempre que sea posible';
	@override String get accent_color => 'Color de acento';
	@override String get accent_color_descr => 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
	@override late final _TranslationsSettingsSecurityEs security = _TranslationsSettingsSecurityEs._(_root);
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
	@override String get from_value => 'Desde monto';
	@override String get to_value => 'Hasta monto';
	@override String from_value_def({required Object x}) => 'Desde ${x}';
	@override String to_value_def({required Object x}) => 'Hasta ${x}';
	@override String from_date_def({required Object date}) => 'Desde el ${date}';
	@override String to_date_def({required Object date}) => 'Hasta el ${date}';
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

// Path: currencies.form
class _TranslationsCurrenciesFormEs implements TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'The currency can not be equal to the user currency';
	@override String get specify_a_currency => 'Por favor, especifica una divisa';
	@override String get add => 'Añadir tipo de cambio';
	@override String get add_success => 'Tipo de cambio añadido correctamente';
	@override String get edit => 'Editar tipo de cambio';
	@override String get edit_success => 'Tipo de cambio editado correctamente';
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
	@override String get title => 'Añade un presupuesto';
	@override String get name => 'Nombre del presupuesto';
	@override String get value => 'Cantidad límite';
	@override String get create => 'Añade el presupuesto';
	@override String get edit => 'Editar presupuesto';
	@override String get negative_warn => 'Los presupuestos no pueden tener un valor límite negativo';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsEs implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Detalles del presupuesto';
	@override String get statistics => 'Estadísticas';
	@override String get budget_value => 'Presupuestado';
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => 'Puedes gastar ${dailyAmount}/día por los ${remainingDays} días restantes';
	@override String get expend_evolution => 'Evolución del gasto';
	@override String get no_transactions => 'Parece que no has realizado ningún gasto relativo a este presupuesto';
}

// Path: backup.export
class _TranslationsBackupExportEs implements TranslationsBackupExportEn {
	_TranslationsBackupExportEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exportar datos';
	@override String get title_short => 'Exportar';
	@override String get all => 'Respaldo total';
	@override String get all_descr => 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
	@override String get transactions => 'Respaldo de transacciones';
	@override String get transactions_descr => 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
	@override String get description => 'Exporta tus datos en diferentes formatos';
	@override String get dialog_title => 'Guardar/Enviar archivo';
	@override String success({required Object x}) => 'Archivo guardado/enviado correctamente en ${x}';
	@override String get error => 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
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
	@override String get cancelled => 'La importación fue cancelada por el usuario';
	@override String get error => 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
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
	@override String get description => 'Consulta los terminos y otra información relevante sobre Monekin. Ponte en contacto con la comunidad reportando errores, dejando sugerencias...';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return 'Cancelar';
			case 'ui_actions.confirm': return 'Confirmar';
			case 'ui_actions.continue_text': return 'Continuar';
			case 'ui_actions.save': return 'Guardar';
			case 'ui_actions.save_changes': return 'Guardar cambios';
			case 'ui_actions.close_and_save': return 'Guardar y cerrar';
			case 'ui_actions.add': return 'Añadir';
			case 'ui_actions.edit': return 'Editar';
			case 'ui_actions.delete': return 'Eliminar';
			case 'ui_actions.see_more': return 'Ver más';
			case 'ui_actions.select_all': return 'Seleccionar todo';
			case 'ui_actions.deselect_all': return 'Deseleccionar todo';
			case 'ui_actions.select': return 'Seleccionar';
			case 'ui_actions.search': return 'Buscar';
			case 'ui_actions.filter': return 'Filter';
			case 'ui_actions.reset': return 'Restablecer';
			case 'ui_actions.submit': return 'Enviar';
			case 'ui_actions.next': return 'Siguiente';
			case 'ui_actions.previous': return 'Anterior';
			case 'ui_actions.back': return 'Atrás';
			case 'ui_actions.reload': return 'Recargar';
			case 'ui_actions.view': return 'Ver';
			case 'ui_actions.download': return 'Descargar';
			case 'ui_actions.upload': return 'Subir';
			case 'ui_actions.retry': return 'Reintentar';
			case 'ui_actions.copy': return 'Copiar';
			case 'ui_actions.paste': return 'Pegar';
			case 'ui_actions.undo': return 'Deshacer';
			case 'ui_actions.redo': return 'Rehacer';
			case 'ui_actions.open': return 'Abrir';
			case 'ui_actions.close': return 'Cerrar';
			case 'ui_actions.apply': return 'Aplicar';
			case 'ui_actions.discard': return 'Descartar';
			case 'ui_actions.refresh': return 'Actualizar';
			case 'ui_actions.details': return 'Detalles';
			case 'ui_actions.share': return 'Compartir';
			case 'general.or': return 'o';
			case 'general.understood': return 'Entendido';
			case 'general.unspecified': return 'Sin especificar';
			case 'general.quick_actions': return 'Acciones rápidas';
			case 'general.balance': return 'Balance';
			case 'general.account': return 'Cuenta';
			case 'general.accounts': return 'Cuentas';
			case 'general.categories': return 'Categorías';
			case 'general.category': return 'Categoría';
			case 'general.today': return 'Hoy';
			case 'general.yesterday': return 'Ayer';
			case 'general.filters': return 'Filtros';
			case 'general.empty_warn': return 'Ops! Esto esta muy vacio';
			case 'general.insufficient_data': return 'Datos insuficientes';
			case 'general.show_more_fields': return 'Show more fields';
			case 'general.show_less_fields': return 'Show less fields';
			case 'general.tap_to_search': return 'Toca para buscar';
			case 'general.clipboard.success': return ({required Object x}) => '${x} copiado al portapapeles';
			case 'general.clipboard.error': return 'Error al copiar';
			case 'general.time.start_date': return 'Fecha de inicio';
			case 'general.time.end_date': return 'Fecha de fin';
			case 'general.time.from_date': return 'Desde fecha';
			case 'general.time.until_date': return 'Hasta fecha';
			case 'general.time.date': return 'Fecha';
			case 'general.time.datetime': return 'Fecha y hora';
			case 'general.time.time': return 'Hora';
			case 'general.time.each': return 'Cada';
			case 'general.time.after': return 'Tras';
			case 'general.time.ranges.display': return 'Rango temporal';
			case 'general.time.ranges.it_repeat': return 'Se repite';
			case 'general.time.ranges.it_ends': return 'Termina';
			case 'general.time.ranges.forever': return 'Para siempre';
			case 'general.time.ranges.types.cycle': return 'Ciclos';
			case 'general.time.ranges.types.last_days': return 'Últimos días';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '${x} días anteriores';
			case 'general.time.ranges.types.all': return 'Siempre';
			case 'general.time.ranges.types.date_range': return 'Rango personalizado';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range}',
				other: 'Cada ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} hasta el ${day}',
				other: 'Cada ${n} ${range} hasta el ${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} ${limit} veces',
				other: 'Cada ${n} ${range} ${limit} veces',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Cada ${range} una vez',
				other: 'Cada ${n} ${range} una vez',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Mes',
				other: 'Meses',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Año',
				other: 'Años',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Día',
				other: 'Días',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Semana',
				other: 'Semanas',
			);
			case 'general.time.periodicity.display': return 'Periodicidad';
			case 'general.time.periodicity.no_repeat': return 'Sin repetición';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Repetición',
				other: 'Repeticiones',
			);
			case 'general.time.periodicity.diary': return 'Diaría';
			case 'general.time.periodicity.monthly': return 'Mensual';
			case 'general.time.periodicity.annually': return 'Anual';
			case 'general.time.periodicity.quaterly': return 'Trimestral';
			case 'general.time.periodicity.weekly': return 'Semanal';
			case 'general.time.periodicity.custom': return 'Personalizado';
			case 'general.time.periodicity.infinite': return 'Siempre';
			case 'general.time.current.monthly': return 'Este mes';
			case 'general.time.current.annually': return 'Este año';
			case 'general.time.current.quaterly': return 'Este trimestre';
			case 'general.time.current.weekly': return 'Esta semana';
			case 'general.time.current.infinite': return 'Desde siempre';
			case 'general.time.current.custom': return 'Rango personalizado';
			case 'general.time.current.diary': return 'Este día';
			case 'general.time.all.diary': return 'Todos los días';
			case 'general.time.all.monthly': return 'Todos los meses';
			case 'general.time.all.annually': return 'Todos los años';
			case 'general.time.all.quaterly': return 'Todos los trimestres';
			case 'general.time.all.weekly': return 'Todas las semanas';
			case 'general.transaction_order.display': return 'Ordenar transacciones';
			case 'general.transaction_order.category': return 'Por categoría';
			case 'general.transaction_order.quantity': return 'Por cantidad';
			case 'general.transaction_order.date': return 'Por fecha';
			case 'general.validations.form_error': return 'Corrije los campos indicados en el formulario para continuar';
			case 'general.validations.required': return 'Campo obligatorio';
			case 'general.validations.positive': return 'Debe ser positivo';
			case 'general.validations.min_number': return ({required Object x}) => 'Debe ser mayor que ${x}';
			case 'general.validations.max_number': return ({required Object x}) => 'Debe ser menor que ${x}';
			case 'intro.start': return 'Empecemos';
			case 'intro.skip': return 'Saltar';
			case 'intro.next': return 'Siguiente';
			case 'intro.select_your_currency': return 'Selecciona tu divisa';
			case 'intro.welcome_subtitle': return 'Tu gestor de finanzas personales';
			case 'intro.welcome_subtitle2': return '100% libre, 100% gratis';
			case 'intro.welcome_footer': return 'Al iniciar sesión aceptas la <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Política de Privacidad</a> y los <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Términos de uso</a> de la aplicación';
			case 'intro.offline_descr_title': return 'CUENTA SIN CONEXIÓN:';
			case 'intro.offline_descr': return 'Tus datos serán guardados unicamente en tu dispositivo, y estarán seguros mientras no desinstales la app o cambies de telefono. Para prevenir la perdida de datos se recomienda realizar una copia de seguridad regularmente desde los ajustes de la app.';
			case 'intro.offline_start': return 'Iniciar sesión offline';
			case 'intro.sl1_title': return 'Selecciona tu divisa';
			case 'intro.sl1_descr': return 'Para empezar, selecciona tu moneda. Podrás cambiar de divisa y de idioma mas adelante en todo momento en los ajustes de la aplicación';
			case 'intro.sl2_title': return 'Seguro, privado y confiable';
			case 'intro.sl2_descr': return 'Tus datos son solo tuyos. Almacenamos la información directamente en tu dispositivo, sin pasar por servidores externos. Esto hace que puedas usar la aplicación incluso sin Internet';
			case 'intro.sl2_descr2': return 'Además, el código fuente de la aplicación es público, cualquiera puede colaborar en el y ver como funciona';
			case 'intro.last_slide_title': return 'Todo listo!';
			case 'intro.last_slide_descr': return 'Con Monekin, podrás al fin lograr la independencia financiaria que tanto deseas. Podrás ver gráficas, presupuestos, consejos, estadisticas y mucho más sobre tu dinero.';
			case 'intro.last_slide_descr2': return 'Esperemos que disfrutes de tu experiencia! No dudes en contactar con nosotros en caso de dudas, sugerencias...';
			case 'home.title': return 'Inicio';
			case 'home.filter_transactions': return 'Filtrar transacciones';
			case 'home.hello_day': return 'Buenos días,';
			case 'home.hello_night': return 'Buenas noches,';
			case 'home.total_balance': return 'Saldo total';
			case 'home.my_accounts': return 'Mis cuentas';
			case 'home.active_accounts': return 'Cuentas activas';
			case 'home.no_accounts': return 'Aun no hay cuentas creadas';
			case 'home.no_accounts_descr': return 'Empieza a usar toda la magia de Monekin. Crea al menos una cuenta para empezar a añadir tranacciones';
			case 'home.last_transactions': return 'Últimas transacciones';
			case 'home.should_create_account_header': return 'Ops!';
			case 'home.should_create_account_message': return 'Debes tener al menos una cuenta no archivada que no sea de ahorros antes de empezar a crear transacciones';
			case 'financial_health.display': return 'Salud financiera';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Excelente!';
					case GenderContext.female:
						return 'Excelente!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Bueno';
					case GenderContext.female:
						return 'Buena';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'En la media';
					case GenderContext.female:
						return 'En la media';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Regular';
					case GenderContext.female:
						return 'Regular';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Muy malo';
					case GenderContext.female:
						return 'Muy mala';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Datos insuficientes';
					case GenderContext.female:
						return 'Datos insuficientes';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'Parece que no tenemos gastos suficientes para calcular tu salud financiera. Añade unos pocos gastos e ingresos para que podamos ayudarte mas!';
			case 'financial_health.review.descr.very_good': return 'Enhorabuena! Tu salud financiera es formidable. Esperamos que sigas con tu buena racha y que continues aprendiendo con Monekin';
			case 'financial_health.review.descr.good': return 'Genial! Tu salud financiera es buena. Visita la pestaña de análisis para ver como ahorrar aun mas!';
			case 'financial_health.review.descr.normal': return 'Tu salud financiera se encuentra mas o menos en la media del resto de la población para este periodo';
			case 'financial_health.review.descr.bad': return 'Parece que tu situación financiera no es la mejor aun. Explora el resto de pestañas de análisis para conocer mas sobre tus finanzas';
			case 'financial_health.review.descr.very_bad': return 'Mmm, tu salud financera esta muy por debajo de lo que debería. Trata de ver donde esta el problema gracias a los distintos gráficos y estadisticas que te proporcionamos';
			case 'financial_health.months_without_income.title': return 'Ratio de supervivencia';
			case 'financial_health.months_without_income.subtitle': return 'Dado tu saldo, cantidad de tiempo que podrías pasar sin ingresos';
			case 'financial_health.months_without_income.text_zero': return '¡No podrías sobrevivir un mes sin ingresos con este ritmo de gastos!';
			case 'financial_health.months_without_income.text_one': return '¡Apenas podrías sobrevivir aproximadamente un mes sin ingresos con este ritmo de gastos!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'Podrías sobrevivir aproximadamente <b>${n} meses</b> sin ingresos a este ritmo de gasto.';
			case 'financial_health.months_without_income.text_infinite': return 'Podrías sobrevivir aproximadamente <b>casi toda tu vida</b> sin ingresos a este ritmo de gasto.';
			case 'financial_health.months_without_income.suggestion': return 'Recuerda que es recomendable mantener este ratio siempre por encima de 5 meses como mínimo. Si ves que no tienes un colchon de ahorro suficiente, reduce los gastos no necesarios.';
			case 'financial_health.months_without_income.insufficient_data': return 'Parece que no tenemos gastos suficientes para calcular cuantos meses podrías sobrevivir sin ingresos. Introduce unas pocas transacciones y regresa aquí para consultar tu salud financiera';
			case 'financial_health.savings_percentage.title': return 'Porcentaje de ahorro';
			case 'financial_health.savings_percentage.subtitle': return 'Que parte de tus ingresos no son gastados en este periodo';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Enhorabuena! Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Parece que ya eres todo un expert@, sigue asi!';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Enhorabuena, has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo.';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'Has conseguido ahorrar un <b>${value}%</b> de tus ingresos durante este periodo. Sin embargo, creemos que aun puedes hacer mucho mas!';
			case 'financial_health.savings_percentage.text.very_bad': return 'Vaya, no has conseguido ahorrar nada durante este periodo.';
			case 'financial_health.savings_percentage.suggestion': return 'Recuerda que es recomendable ahorrar al menos un 15-20% de lo que ingresas.';
			case 'stats.title': return 'Estadísticas';
			case 'stats.balance': return 'Saldo';
			case 'stats.final_balance': return 'Saldo final';
			case 'stats.balance_by_account': return 'Saldo por cuentas';
			case 'stats.balance_by_account_subtitle': return '¿Donde tengo la mayor parte de mi dinero?';
			case 'stats.balance_by_currency': return 'Saldo por divisas';
			case 'stats.balance_by_currency_subtitle': return '¿Cuanto dinero tengo en moneda extranjera?';
			case 'stats.balance_evolution': return 'Tendencia de saldo';
			case 'stats.balance_evolution_subtitle': return '¿Tengo más dinero que antes?';
			case 'stats.compared_to_previous_period': return 'Frente al periodo anterior';
			case 'stats.cash_flow': return 'Flujo de caja';
			case 'stats.cash_flow_subtitle': return '¿Estoy gastando menos de lo que gano?';
			case 'stats.by_periods': return 'Por periodos';
			case 'stats.by_categories': return 'Por categorías';
			case 'stats.by_tags': return 'Por etiquetas';
			case 'stats.distribution': return 'Distribución';
			case 'stats.finance_health_resume': return 'Resumen';
			case 'stats.finance_health_breakdown': return 'Desglose';
			case 'icon_selector.name': return 'Nombre:';
			case 'icon_selector.icon': return 'Icono';
			case 'icon_selector.color': return 'Color';
			case 'icon_selector.select_icon': return 'Selecciona un icono';
			case 'icon_selector.select_color': return 'Selecciona un color';
			case 'icon_selector.custom_color': return 'Color personalizado';
			case 'icon_selector.current_color_selection': return 'Selección actual';
			case 'icon_selector.select_account_icon': return 'Identifica tu cuenta';
			case 'icon_selector.select_category_icon': return 'Identifica tu categoría';
			case 'icon_selector.scopes.transport': return 'Transporte';
			case 'icon_selector.scopes.money': return 'Dinero';
			case 'icon_selector.scopes.food': return 'Comida';
			case 'icon_selector.scopes.medical': return 'Salud';
			case 'icon_selector.scopes.entertainment': return 'Entretenimiento';
			case 'icon_selector.scopes.technology': return 'Technología';
			case 'icon_selector.scopes.other': return 'Otros';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Financial institutions';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Transacción',
				other: 'Transacciones',
			);
			case 'transaction.create': return 'Nueva transacción';
			case 'transaction.new_income': return 'Nuevo ingreso';
			case 'transaction.new_expense': return 'Nuevo gasto';
			case 'transaction.new_success': return 'Transacción creada correctamente';
			case 'transaction.edit': return 'Editar transacción';
			case 'transaction.edit_success': return 'Transacción editada correctamente';
			case 'transaction.edit_multiple': return 'Editar transacciones';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} transacciones editadas correctamente';
			case 'transaction.duplicate': return 'Clonar transacción';
			case 'transaction.duplicate_short': return 'Clonar';
			case 'transaction.duplicate_warning_message': return 'Se creará una transacción identica a esta con su misma fecha, ¿deseas continuar?';
			case 'transaction.duplicate_success': return 'Transacción clonada con exito';
			case 'transaction.delete': return 'Eliminar transacción';
			case 'transaction.delete_warning_message': return 'Esta acción es irreversible. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
			case 'transaction.delete_success': return 'Transacción eliminada correctamente';
			case 'transaction.delete_multiple': return 'Eliminar transacciones';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'Esta acción es irreversible y borrará definitivamente ${x} transacciones. El balance actual de tus cuentas y todas tus estadisticas serán recalculadas';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} transacciones eliminadas correctamente';
			case 'transaction.details': return 'Detalles del movimiento';
			case 'transaction.next_payments.accept': return 'Aceptar';
			case 'transaction.next_payments.skip': return 'Saltar';
			case 'transaction.next_payments.skip_success': return 'Transacción saltada con exito';
			case 'transaction.next_payments.skip_dialog_title': return 'Saltar transacción';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'Esta acción es irreversible. Desplazaremos la fecha del proximo movimiento al día ${date}';
			case 'transaction.next_payments.accept_today': return 'Aceptar hoy';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Aceptar en la fecha requerida (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'Aceptar transacción';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'El estado de la transacción pasará a ser nulo. Puedes volver a editar el estado de esta transacción cuando lo desees';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'Esta acción creará una transacción nueva con fecha ${date}. Podrás consultar los detalles de esta transacción en la página de transacciones';
			case 'transaction.next_payments.recurrent_rule_finished': return 'La regla recurrente se ha completado, ya no hay mas pagos a realizar!';
			case 'transaction.list.empty': return 'No se han encontrado transacciones que mostrar aquí. Añade unas cuantas transacciones en la app y quizas tengas más suerte la proxima vez';
			case 'transaction.list.searcher_placeholder': return 'Busca por categoría, descripción...';
			case 'transaction.list.searcher_no_results': return 'No se han encontrado transacciones que coincidan con los criterios de busqueda';
			case 'transaction.list.loading': return 'Cargando más transacciones...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '${n} seleccionada',
				other: '${n} seleccionadas',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: '${n} transacción seleccionada',
				other: '${n} transacciones seleccionadas',
			);
			case 'transaction.list.bulk_edit.dates': return 'Editar fechas';
			case 'transaction.list.bulk_edit.categories': return 'Editar categorías';
			case 'transaction.list.bulk_edit.status': return 'Editar estados';
			case 'transaction.filters.from_value': return 'Desde monto';
			case 'transaction.filters.to_value': return 'Hasta monto';
			case 'transaction.filters.from_value_def': return ({required Object x}) => 'Desde ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => 'Hasta ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => 'Desde el ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => 'Hasta el ${date}';
			case 'transaction.form.validators.zero': return 'El valor de una transacción no puede ser igual a cero';
			case 'transaction.form.validators.date_max': return 'La fecha seleccionada es posterior a la actual. Se añadirá la transacción como pendiente';
			case 'transaction.form.validators.date_after_account_creation': return 'No puedes crear una transacción cuya fecha es anterior a la fecha de creación de la cuenta a la que pertenece';
			case 'transaction.form.validators.negative_transfer': return 'El valor monetario de una transferencia no puede ser negativo';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'Las cuentas de origen y destino no pueden coincidir';
			case 'transaction.form.title': return 'Título de la transacción';
			case 'transaction.form.title_short': return 'Título';
			case 'transaction.form.value': return 'Valor de la transacción';
			case 'transaction.form.tap_to_see_more': return 'Toca para ver más detalles';
			case 'transaction.form.no_tags': return '-- Sin etiquetas --';
			case 'transaction.form.description': return 'Descripción';
			case 'transaction.form.description_info': return 'Toca aquí para escribir una descripción mas detallada sobre esta transacción';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => 'Cambio a ${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return 'El día de la transacción';
			case 'transaction.reversed.title': return 'Transacción invertida';
			case 'transaction.reversed.title_short': return 'Tr. invertida';
			case 'transaction.reversed.description_for_expenses': return 'A pesar de ser una transacción de tipo gasto, esta transacción tiene un monto positivo. Este tipo de transacciones pueden usarse para representar la devolución de un gasto previamente registrado, como un reembolso o que te realicen el pago de una deuda.';
			case 'transaction.reversed.description_for_incomes': return 'A pesar de ser una transacción de tipo ingreso, esta transacción tiene un monto negativo. Este tipo de transacciones pueden usarse para anular o corregir un ingreso que fue registrado incorrectamente, para reflejar una devolución o reembolso de dinero o para registrar el pago de deudas.';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Estado',
				other: 'Estados',
			);
			case 'transaction.status.display_long': return 'Estado de la transacción';
			case 'transaction.status.tr_status': return ({required Object status}) => 'Transacción ${status}';
			case 'transaction.status.none': return 'Sin estado';
			case 'transaction.status.none_descr': return 'Transacción sin un estado concreto';
			case 'transaction.status.reconciled': return 'Reconciliada';
			case 'transaction.status.reconciled_descr': return 'Esta transacción ha sido validada ya y se corresponde con una transacción real de su banco';
			case 'transaction.status.unreconciled': return 'No reconciliada';
			case 'transaction.status.unreconciled_descr': return 'Esta transacción aun no ha sido validada y por tanto aun no figura en sus cuentas bancarias reales. Sin embargo, es tenida en cuenta para el calculo de balances y estadisticas en Monekin';
			case 'transaction.status.pending': return 'Pendiente';
			case 'transaction.status.pending_descr': return 'Esta transacción esta pendiente y por tanto no será tenida en cuenta a la hora de calcular balances y estadísticas';
			case 'transaction.status.voided': return 'Nula';
			case 'transaction.status.voided_descr': return 'Transacción nula/cancelada debido a un error en el pago o cualquier otro motivo. No será tenida en cuenta a la hora de calcular balances y estadísticas';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Tipo de transacción',
				other: 'Tipos de transacción',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Ingreso',
				other: 'Ingresos',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Gasto',
				other: 'Gastos',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Transferencia',
				other: 'Transferencias',
			);
			case 'transfer.display': return 'Transferencia';
			case 'transfer.transfers': return 'Transferencias';
			case 'transfer.transfer_to': return ({required Object account}) => 'Transferencia hacia ${account}';
			case 'transfer.create': return 'Nueva transferencia';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return 'Se necesitan al menos dos cuentas para realizar esta acción. Si lo que necesitas es ajustar o editar el balance actual de esta cuenta pulsa el botón de editar';
			case 'transfer.form.from': return 'Cuenta origen';
			case 'transfer.form.to': return 'Cuenta destino';
			case 'transfer.form.value_in_destiny.title': return 'Cantidad transferida en destino';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} a cuenta de destino';
			case 'recurrent_transactions.title': return 'Movimientos recurrentes';
			case 'recurrent_transactions.title_short': return 'Mov. recurrentes';
			case 'recurrent_transactions.empty': return 'Parece que no posees ninguna transacción recurrente. Crea una transacción que se repita mensual, anual o semanalmente y aparecerá aquí';
			case 'recurrent_transactions.total_expense_title': return 'Gasto total por periodo';
			case 'recurrent_transactions.total_expense_descr': return '* Sin considerar la fecha de inicio y fin de cada recurrencia';
			case 'recurrent_transactions.details.title': return 'Transaccion recurrente';
			case 'recurrent_transactions.details.descr': return 'A continuación se muestran próximos movimientos de esta transacción. Podrás aceptar el primero de ellos o saltar este movimiento';
			case 'recurrent_transactions.details.last_payment_info': return 'Este movimiento es el último de la regla recurrente, por lo que se eliminará esta regla de forma automática al confirmar esta acción';
			case 'recurrent_transactions.details.delete_header': return 'Eliminar transacción recurrente';
			case 'recurrent_transactions.details.delete_message': return 'Esta acción es irreversible y no afectará a transacciones que ya hayas confirmado/pagado';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => 'Atrasado por ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => 'En ${x} días';
			case 'account.details': return 'Detalles de la cuenta';
			case 'account.date': return 'Fecha de apertura';
			case 'account.close_date': return 'Fecha de cierre';
			case 'account.reopen': return 'Reabrir cuenta';
			case 'account.reopen_short': return 'Reabrir';
			case 'account.reopen_descr': return '¿Seguro que quieres volver a abrir esta cuenta?';
			case 'account.balance': return 'Saldo de la cuenta';
			case 'account.n_transactions': return 'Número de transacciones';
			case 'account.add_money': return 'Añadir dinero';
			case 'account.withdraw_money': return 'Retirar dinero';
			case 'account.no_accounts': return 'No se han encontrado cuentas que mostrar aquí. Añade una transacción pulsando el botón \'+\' de la parte inferior';
			case 'account.types.title': return 'Tipo de cuenta';
			case 'account.types.warning': return 'Una vez elegido el tipo de cuenta este no podrá cambiarse en un futuro';
			case 'account.types.normal': return 'Cuenta corriente';
			case 'account.types.normal_descr': return 'Útil para registrar tus finanzas del día a día. Es la cuenta mas común, permite añadir gastos, ingresos...';
			case 'account.types.saving': return 'Cuenta de ahorros';
			case 'account.types.saving_descr': return 'Solo podrás añadir y retirar dinero de ella desde otras cuentas. Perfecta para empezar a ahorrar';
			case 'account.form.name': return 'Nombre de la cuenta';
			case 'account.form.name_placeholder': return 'Ej: Cuenta de ahorros';
			case 'account.form.notes': return 'Notas';
			case 'account.form.notes_placeholder': return 'Escribe algunas notas/descripciones sobre esta cuenta';
			case 'account.form.initial_balance': return 'Balance inicial';
			case 'account.form.current_balance': return 'Balance actual';
			case 'account.form.create': return 'Crear cuenta';
			case 'account.form.edit': return 'Editar cuenta';
			case 'account.form.currency_not_found_warn': return 'No posees información sobre tipos de cambio para esta divisa. Se usará 1.0 como tipo de cambio por defecto. Puedes modificar esto en los ajustes';
			case 'account.form.already_exists': return 'Ya existe otra cuenta con el mismo nombre. Por favor, escriba otro';
			case 'account.form.tr_before_opening_date': return 'Existen transacciones en esta cuenta con fecha anterior a la fecha de apertura';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return '¿Eliminar cuenta?';
			case 'account.delete.warning_text': return 'Esta acción borrara esta cuenta y todas sus transacciones. No podrás volver a recuperar esta información tras el borrado.';
			case 'account.delete.success': return 'Cuenta eliminada correctamente';
			case 'account.close.title': return 'Cerrar cuenta';
			case 'account.close.title_short': return 'Cerrar';
			case 'account.close.warn': return 'Esta cuenta ya no aparecerá en ciertos listados y no podrá crear transacciones en ella con fecha posterior a la especificada debajo. Esta acción no afecta a ninguna transacción ni balance, y además, podrás volver a abrir esta cuenta cuando quieras';
			case 'account.close.should_have_zero_balance': return 'Debes tener un saldo actual en la cuenta de 0 para poder cerrarla. Edita esta cuenta antes de continuar';
			case 'account.close.should_have_no_transactions': return 'Esta cuenta posee transacciones posteriores a la fecha de cierre especificada. Borralas o edita la fecha de cierre de la cuenta antes de continuar';
			case 'account.close.success': return 'Cuenta cerrada exitosamente';
			case 'account.close.unarchive_succes': return 'Cuenta re-abierta exitosamente';
			case 'account.select.one': return 'Selecciona una cuenta';
			case 'account.select.all': return 'Todas las cuentas';
			case 'account.select.multiple': return 'Selecciona cuentas';
			case 'currencies.currency_converter': return 'Conversor de divisas';
			case 'currencies.currency': return 'Divisa';
			case 'currencies.currency_manager': return 'Administrador de divisas';
			case 'currencies.currency_manager_descr': return 'Configura tu divisa y sus tipos de cambio con otras';
			case 'currencies.preferred_currency': return 'Divisa predeterminada/base';
			case 'currencies.change_preferred_currency_title': return 'Cambiar divisa predeterminada';
			case 'currencies.change_preferred_currency_msg': return 'Todas las estadisticas y presupuestos serán mostradas en esta divisa a partir de ahora. Las cuentas y transacciones mantendrán la divisa que tenían. Todos los tipos de cambios guardados serán eliminados si ejecutas esta acción, ¿Desea continuar?';
			case 'currencies.form.equal_to_preferred_warn': return 'The currency can not be equal to the user currency';
			case 'currencies.form.specify_a_currency': return 'Por favor, especifica una divisa';
			case 'currencies.form.add': return 'Añadir tipo de cambio';
			case 'currencies.form.add_success': return 'Tipo de cambio añadido correctamente';
			case 'currencies.form.edit': return 'Editar tipo de cambio';
			case 'currencies.form.edit_success': return 'Tipo de cambio editado correctamente';
			case 'currencies.delete_all_success': return 'Tipos de cambio borrados con exito';
			case 'currencies.historical': return 'Histórico de tasas';
			case 'currencies.exchange_rate': return 'Tipo de cambio';
			case 'currencies.exchange_rates': return 'Tipos de cambio';
			case 'currencies.empty': return 'Añade tipos de cambio aqui para que en caso de tener cuentas en otras divisas distintas a tu divisa base nuestros gráficos sean mas exactos';
			case 'currencies.select_a_currency': return 'Selecciona una divisa';
			case 'currencies.search': return 'Busca por nombre o por código de la divisa';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				one: 'Etiqueta',
				other: 'Etiquetas',
			);
			case 'tags.form.name': return 'Nombre de la etiqueta';
			case 'tags.form.description': return 'Descripción';
			case 'tags.select.title': return 'Selecciona etiquetas';
			case 'tags.select.all': return 'Todas las etiquetas';
			case 'tags.empty_list': return 'No has creado ninguna etiqueta aun. Las etiquetas y las categorías son una gran forma de categorizar tus movimientos';
			case 'tags.without_tags': return 'Sin etiquetas';
			case 'tags.add': return 'Añadir etiqueta';
			case 'tags.create': return 'Crear etiqueta';
			case 'tags.create_success': return 'Etiqueta creada correctamente';
			case 'tags.already_exists': return 'El nombre de esta etiqueta ya existe. Puede que quieras editarla';
			case 'tags.edit': return 'Editar etiqueta';
			case 'tags.edit_success': return 'Etiqueta editada correctamente';
			case 'tags.delete_success': return 'Categoría eliminada correctamente';
			case 'tags.delete_warning_header': return '¿Eliminar etiqueta?';
			case 'tags.delete_warning_message': return 'Esta acción no borrará las transacciones que poseen esta etiqueta.';
			case 'categories.unknown': return 'Categoría desconocida';
			case 'categories.create': return 'Crear categoría';
			case 'categories.create_success': return 'Categoría creada correctamente';
			case 'categories.new_category': return 'Nueva categoría';
			case 'categories.already_exists': return 'El nombre de esta categoría ya existe. Puede que quieras editarla';
			case 'categories.edit': return 'Editar categoría';
			case 'categories.edit_success': return 'Categoría editada correctamente';
			case 'categories.name': return 'Nombre de la categoría';
			case 'categories.type': return 'Tipo de categoría';
			case 'categories.both_types': return 'Ambos tipos';
			case 'categories.subcategories': return 'Subcategorías';
			case 'categories.subcategories_add': return 'Añadir subcategoría';
			case 'categories.make_parent': return 'Convertir en categoría';
			case 'categories.make_child': return 'Convertir en subcategoría';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'Esta categoría y sus subcategorías pasarán a ser subcategorías de <b>${destiny}</b>.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'Sus transacciones <b>(${x})</b> pasarán a las nuevas subcategorías creadas dentro de la categoría <b>${destiny}</b>.';
			case 'categories.make_child_success': return 'Subcategorías creadas con exito';
			case 'categories.merge': return 'Fusionar con otra categoría';
			case 'categories.merge_warning1': return ({required Object x, required Object from, required Object destiny}) => 'Todas las transacciones (${x}) asocidadas con la categoría <b>${from}</b> serán movidas a la categoría <b>${destiny}</b>.';
			case 'categories.merge_warning2': return ({required Object from}) => 'La categoría <b>${from}</b> será eliminada de forma irreversible.';
			case 'categories.merge_success': return 'Categoría fusionada correctamente';
			case 'categories.delete_success': return 'Categoría eliminada correctamente';
			case 'categories.delete_warning_header': return '¿Eliminar categoría?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'Esta acción borrará de forma irreversible todas las transacciones <b>(${x})</b> relativas a esta categoría.';
			case 'categories.select.title': return 'Selecciona categorías';
			case 'categories.select.select_one': return 'Selecciona una categoría';
			case 'categories.select.select_subcategory': return 'Elige una subcategoría';
			case 'categories.select.without_subcategory': return 'Sin subcategoría';
			case 'categories.select.all': return 'Todas las categorías';
			case 'categories.select.all_short': return 'Todas';
			case 'budgets.title': return 'Presupuestos';
			case 'budgets.repeated': return 'Periódicos';
			case 'budgets.one_time': return 'Una vez';
			case 'budgets.annual': return 'Anuales';
			case 'budgets.week': return 'Semanales';
			case 'budgets.month': return 'Mensuales';
			case 'budgets.actives': return 'Activos';
			case 'budgets.pending': return 'Pendientes de comenzar';
			case 'budgets.finish': return 'Finalizados';
			case 'budgets.from_budgeted': return 'De un total de ';
			case 'budgets.days_left': return 'días restantes';
			case 'budgets.days_to_start': return 'días para empezar';
			case 'budgets.since_expiration': return 'días desde su expiración';
			case 'budgets.no_budgets': return 'Parece que no hay presupuestos que mostrar en esta sección. Empieza creando un presupuesto pulsando el botón inferior';
			case 'budgets.delete': return 'Eliminar presupuesto';
			case 'budgets.delete_warning': return 'Esta acción es irreversible. Categorías y transacciones referentes a este presupuesto no serán eliminados';
			case 'budgets.form.title': return 'Añade un presupuesto';
			case 'budgets.form.name': return 'Nombre del presupuesto';
			case 'budgets.form.value': return 'Cantidad límite';
			case 'budgets.form.create': return 'Añade el presupuesto';
			case 'budgets.form.edit': return 'Editar presupuesto';
			case 'budgets.form.negative_warn': return 'Los presupuestos no pueden tener un valor límite negativo';
			case 'budgets.details.title': return 'Detalles del presupuesto';
			case 'budgets.details.statistics': return 'Estadísticas';
			case 'budgets.details.budget_value': return 'Presupuestado';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => 'Puedes gastar ${dailyAmount}/día por los ${remainingDays} días restantes';
			case 'budgets.details.expend_evolution': return 'Evolución del gasto';
			case 'budgets.details.no_transactions': return 'Parece que no has realizado ningún gasto relativo a este presupuesto';
			case 'backup.export.title': return 'Exportar datos';
			case 'backup.export.title_short': return 'Exportar';
			case 'backup.export.all': return 'Respaldo total';
			case 'backup.export.all_descr': return 'Exporta todos tus datos (cuentas, transacciones, presupuestos, ajustes...). Importalos de nuevo en cualquier momento para no perder nada.';
			case 'backup.export.transactions': return 'Respaldo de transacciones';
			case 'backup.export.transactions_descr': return 'Exporta tus transacciones en CSV para que puedas analizarlas mas facilmente en otros programas o aplicaciones.';
			case 'backup.export.description': return 'Exporta tus datos en diferentes formatos';
			case 'backup.export.dialog_title': return 'Guardar/Enviar archivo';
			case 'backup.export.success': return ({required Object x}) => 'Archivo guardado/enviado correctamente en ${x}';
			case 'backup.export.error': return 'Error al descargar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
			case 'backup.import.title': return 'Importar tus datos';
			case 'backup.import.title_short': return 'Importar';
			case 'backup.import.restore_backup': return 'Restaurar copia de seguridad';
			case 'backup.import.restore_backup_descr': return 'Importa una base de datos anteriormente guardada desde Monekin. Esta acción remplazará cualquier dato actual de la aplicación por los nuevos datos';
			case 'backup.import.restore_backup_warn_description': return 'Al importar una nueva base de datos, perderas toda la información actualmente guardada en la app. Se recomienda hacer una copia de seguridad antes de continuar. No subas aquí ningún fichero cuyo origen no conozcas, sube solo ficheros que hayas descargado previamente desde Monekin';
			case 'backup.import.restore_backup_warn_title': return 'Sobreescribir todos los datos';
			case 'backup.import.select_other_file': return 'Selecciona otro fichero';
			case 'backup.import.tap_to_select_file': return 'Pulsa para seleccionar un archivo';
			case 'backup.import.manual_import.title': return 'Importación manual';
			case 'backup.import.manual_import.descr': return 'Importa transacciones desde un fichero .csv de forma manual';
			case 'backup.import.manual_import.default_account': return 'Cuenta por defecto';
			case 'backup.import.manual_import.remove_default_account': return 'Eliminar cuenta por defecto';
			case 'backup.import.manual_import.default_category': return 'Categoría por defecto';
			case 'backup.import.manual_import.select_a_column': return 'Selecciona una columna del .csv';
			case 'backup.import.manual_import.steps.0': return 'Selecciona tu fichero';
			case 'backup.import.manual_import.steps.1': return 'Columna para la cantidad';
			case 'backup.import.manual_import.steps.2': return 'Columna para la cuenta';
			case 'backup.import.manual_import.steps.3': return 'Columna para la categoría';
			case 'backup.import.manual_import.steps.4': return 'Columna para la fecha';
			case 'backup.import.manual_import.steps.5': return 'Otras columnas';
			case 'backup.import.manual_import.steps_descr.0': return 'Selecciona un fichero .csv de tu dispositivo. Asegurate de que este tenga una primera fila que describa el nombre de cada columna';
			case 'backup.import.manual_import.steps_descr.1': return 'Selecciona la columna donde se especifica el valor de cada transacción. Usa valores negativos para los gastos y positivos para los ingresos. Usa un punto como separador decimal';
			case 'backup.import.manual_import.steps_descr.2': return 'Selecciona la columna donde se especifica la cuenta a la que pertenece cada transacción. Podrás también seleccionar una cuenta por defecto en el caso de que no encontremos la cuenta que desea. Si no se especifica una cuenta por defecto, crearemos una con el mismo nombre';
			case 'backup.import.manual_import.steps_descr.3': return 'Especifica la columna donde se encuentra el nombre de la categoría de la transacción. Debes especificar una categoría por defecto para que asignemos esta categoría a las transacciones, en caso de que la categoría no se pueda encontrar';
			case 'backup.import.manual_import.steps_descr.4': return 'Selecciona la columna donde se especifica la fecha de cada transacción. En caso de no especificarse, se crearan transacciones con la fecha actual';
			case 'backup.import.manual_import.steps_descr.5': return 'Especifica las columnas para otros atributos optativos de las transacciones';
			case 'backup.import.manual_import.success': return ({required Object x}) => 'Se han importado correctamente ${x} transacciones';
			case 'backup.import.success': return 'Importación realizada con exito';
			case 'backup.import.cancelled': return 'La importación fue cancelada por el usuario';
			case 'backup.import.error': return 'Error al importar el archivo. Por favor contacte con el desarrollador via lozin.technologies@gmail.com';
			case 'backup.about.title': return 'Información sobre tu base de datos';
			case 'backup.about.create_date': return 'Fecha de creación';
			case 'backup.about.modify_date': return 'Última modificación';
			case 'backup.about.last_backup': return 'Última copia de seguridad';
			case 'backup.about.size': return 'Tamaño';
			case 'settings.title_long': return 'Configuración y apariencia';
			case 'settings.title_short': return 'Configuración';
			case 'settings.description': return 'Tema de la aplicación, textos y otras configuraciones generales';
			case 'settings.edit_profile': return 'Editar perfil';
			case 'settings.lang_section': return 'Idioma y textos';
			case 'settings.lang_title': return 'Idioma de la aplicación';
			case 'settings.lang_descr': return 'Idioma en el que se mostrarán los textos en la aplicación';
			case 'settings.lang_help': return 'Si quieres colaborar con las traducciones de esta app puedes consultar <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>nuestra guía</a> ';
			case 'settings.locale': return 'Región';
			case 'settings.locale_descr': return 'Establecer el formato a utilizar para fechas, números...';
			case 'settings.locale_warn': return 'Al cambiar la región, la aplicación se actualizará';
			case 'settings.first_day_of_week': return 'Primer día de la semana';
			case 'settings.theme_and_colors': return 'Tema y colores';
			case 'settings.theme': return 'Tema';
			case 'settings.theme_auto': return 'Sistema';
			case 'settings.theme_light': return 'Claro';
			case 'settings.theme_dark': return 'Oscuro';
			case 'settings.amoled_mode': return 'Modo AMOLED';
			case 'settings.amoled_mode_descr': return 'Usar un fondo negro puro cuando sea posible. Esto ayudará ligeramente a la batería de dispositivos con pantallas AMOLED';
			case 'settings.dynamic_colors': return 'Colores dinámicos';
			case 'settings.dynamic_colors_descr': return 'Usar el color de acento de su sistema siempre que sea posible';
			case 'settings.accent_color': return 'Color de acento';
			case 'settings.accent_color_descr': return 'Elegir el color que la aplicación usará para enfatizar ciertas partes de la interfaz';
			case 'settings.security.title': return 'Seguridad';
			case 'settings.security.private_mode_at_launch': return 'Modo privado al arrancar';
			case 'settings.security.private_mode_at_launch_descr': return 'Arranca la app en modo privado por defecto';
			case 'settings.security.private_mode': return 'Modo privado';
			case 'settings.security.private_mode_descr': return 'Oculta todos los valores monetarios';
			case 'settings.security.private_mode_activated': return 'Modo privado activado';
			case 'settings.security.private_mode_deactivated': return 'Modo privado desactivado';
			case 'more.title': return 'Más';
			case 'more.title_long': return 'Más acciones';
			case 'more.data.display': return 'Datos';
			case 'more.data.display_descr': return 'Exporta y importa tus datos para no perder nada';
			case 'more.data.delete_all': return 'Eliminar mis datos';
			case 'more.data.delete_all_header1': return 'Alto ahí padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return '¿Estas seguro de que quieres continuar? Todos tus datos serán borrados permanentemente y no podrán ser recuperados';
			case 'more.data.delete_all_header2': return 'Un último paso ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'Al eliminar una cuenta eliminarás todos tus datos personales almacenados. Tus cuentas, transacciones, presupuestos y categorías serán borrados y no podrán ser recuperados. ¿Estas de acuerdo?';
			case 'more.about_us.display': return 'Información de la app';
			case 'more.about_us.description': return 'Consulta los terminos y otra información relevante sobre Monekin. Ponte en contacto con la comunidad reportando errores, dejando sugerencias...';
			case 'more.about_us.legal.display': return 'Información legal';
			case 'more.about_us.legal.privacy': return 'Política de privacidad';
			case 'more.about_us.legal.terms': return 'Términos de uso';
			case 'more.about_us.legal.licenses': return 'Licencias';
			case 'more.about_us.project.display': return 'Proyecto';
			case 'more.about_us.project.contributors': return 'Colaboradores';
			case 'more.about_us.project.contributors_descr': return 'Todos los desarrolladores que han hecho que Monekin crezca';
			case 'more.about_us.project.contact': return 'Contacta con nosotros';
			case 'more.help_us.display': return 'Ayúdanos';
			case 'more.help_us.description': return 'Descubre de que formas puedes ayudar a que Monekin sea cada vez mejor';
			case 'more.help_us.rate_us': return 'Califícanos';
			case 'more.help_us.rate_us_descr': return '¡Cualquier valoración es bienvenida!';
			case 'more.help_us.share': return 'Comparte Monekin';
			case 'more.help_us.share_descr': return 'Comparte nuestra app a amigos y familiares';
			case 'more.help_us.share_text': return 'Monekin! La mejor app de finanzas personales. Descargala aquí';
			case 'more.help_us.thanks': return '¡Gracias!';
			case 'more.help_us.donate': return 'Haz una donación';
			case 'more.help_us.donate_descr': return 'Con tu donación ayudaras a que la app siga recibiendo mejoras. ¿Que mejor forma que agradecer el trabajo realizado invitandome a un cafe?';
			case 'more.help_us.donate_success': return 'Donación realizada. Muchas gracias por tu contribución! ❤️';
			case 'more.help_us.donate_err': return 'Ups! Parece que ha habido un error a la hora de recibir tu pago';
			case 'more.help_us.report': return 'Reporta errores, deja sugerencias...';
			case 'more.help_us.thanks_long': return 'Tus contribuciones a Monekin y otros proyectos de código abierto, grandes o pequeños, hacen posibles grandes proyectos como este. Gracias por tomarse el tiempo para contribuir.';
			default: return null;
		}
	}
}


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
class TranslationsZhCn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhCn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsUiActionsZhCn ui_actions = _TranslationsUiActionsZhCn._(_root);
	@override late final _TranslationsGeneralZhCn general = _TranslationsGeneralZhCn._(_root);
	@override late final _TranslationsIntroZhCn intro = _TranslationsIntroZhCn._(_root);
	@override late final _TranslationsHomeZhCn home = _TranslationsHomeZhCn._(_root);
	@override late final _TranslationsFinancialHealthZhCn financial_health = _TranslationsFinancialHealthZhCn._(_root);
	@override late final _TranslationsStatsZhCn stats = _TranslationsStatsZhCn._(_root);
	@override late final _TranslationsIconSelectorZhCn icon_selector = _TranslationsIconSelectorZhCn._(_root);
	@override late final _TranslationsTransactionZhCn transaction = _TranslationsTransactionZhCn._(_root);
	@override late final _TranslationsTransferZhCn transfer = _TranslationsTransferZhCn._(_root);
	@override late final _TranslationsRecurrentTransactionsZhCn recurrent_transactions = _TranslationsRecurrentTransactionsZhCn._(_root);
	@override late final _TranslationsAccountZhCn account = _TranslationsAccountZhCn._(_root);
	@override late final _TranslationsCurrenciesZhCn currencies = _TranslationsCurrenciesZhCn._(_root);
	@override late final _TranslationsTagsZhCn tags = _TranslationsTagsZhCn._(_root);
	@override late final _TranslationsCategoriesZhCn categories = _TranslationsCategoriesZhCn._(_root);
	@override late final _TranslationsBudgetsZhCn budgets = _TranslationsBudgetsZhCn._(_root);
	@override late final _TranslationsBackupZhCn backup = _TranslationsBackupZhCn._(_root);
	@override late final _TranslationsSettingsZhCn settings = _TranslationsSettingsZhCn._(_root);
	@override late final _TranslationsMoreZhCn more = _TranslationsMoreZhCn._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsZhCn implements TranslationsUiActionsEn {
	_TranslationsUiActionsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get cancel => '取消';
	@override String get confirm => '确认';
	@override String get continue_text => '继续';
	@override String get save => '保存';
	@override String get save_changes => '保存更改';
	@override String get close_and_save => '保存并关闭';
	@override String get add => '添加';
	@override String get edit => '编辑';
	@override String get delete => '删除';
	@override String get see_more => '查看更多';
	@override String get select_all => '全选';
	@override String get deselect_all => '取消全选';
	@override String get select => '选择';
	@override String get search => '搜索';
	@override String get filter => '筛选';
	@override String get reset => '重置';
	@override String get submit => '提交';
	@override String get next => '下一步';
	@override String get previous => '上一步';
	@override String get back => '返回';
	@override String get reload => '重新加载';
	@override String get view => '视图';
	@override String get download => '下载';
	@override String get upload => '上传';
	@override String get retry => '重试';
	@override String get copy => '复制';
	@override String get paste => '粘贴';
	@override String get undo => '撤销';
	@override String get redo => '还原';
	@override String get open => '打开';
	@override String get close => '关闭';
	@override String get apply => '应用';
	@override String get discard => '放弃';
	@override String get refresh => '刷新';
	@override String get details => '详情';
	@override String get share => '分享';
}

// Path: general
class _TranslationsGeneralZhCn implements TranslationsGeneralEn {
	_TranslationsGeneralZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get or => '或';
	@override String get understood => '明白';
	@override String get unspecified => '未指定';
	@override String get quick_actions => '快捷行动';
	@override String get balance => '余额';
	@override String get account => '账户';
	@override String get accounts => '账户';
	@override String get categories => '类别';
	@override String get category => '类别';
	@override String get today => '今天';
	@override String get yesterday => '昨天';
	@override String get filters => '筛选';
	@override String get empty_warn => '喔！空空如也';
	@override String get insufficient_data => '数据不足';
	@override String get show_more_fields => '显示更多';
	@override String get show_less_fields => '显示更少';
	@override String get tap_to_search => '点击以搜索';
	@override late final _TranslationsGeneralClipboardZhCn clipboard = _TranslationsGeneralClipboardZhCn._(_root);
	@override late final _TranslationsGeneralTimeZhCn time = _TranslationsGeneralTimeZhCn._(_root);
	@override late final _TranslationsGeneralTransactionOrderZhCn transaction_order = _TranslationsGeneralTransactionOrderZhCn._(_root);
	@override late final _TranslationsGeneralValidationsZhCn validations = _TranslationsGeneralValidationsZhCn._(_root);
}

// Path: intro
class _TranslationsIntroZhCn implements TranslationsIntroEn {
	_TranslationsIntroZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get start => '开始';
	@override String get skip => '跳过';
	@override String get next => '继续';
	@override String get select_your_currency => '选择您的货币';
	@override String get welcome_subtitle => '您的个人财务管家';
	@override String get welcome_subtitle2 => '100% 开放，100% 免费';
	@override String get welcome_footer => '登录即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隐私策略</a>和此 app 的<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>使用条款</a>';
	@override String get offline_descr_title => '本地账户：';
	@override String get offline_descr => '您的数据只会存储于此设备中，只要您不卸载应用或更换手机，数据就会保持安全。为避免数据丢失，建议定期从 app 设置中备份数据。';
	@override String get offline_start => '开始使用本地账户';
	@override String get sl1_title => '选择您的货币';
	@override String get sl1_descr => '您的默认货币会被用于报表和图表中。您之后可以随时更改默认货币和 app 语言';
	@override String get sl2_title => '安全、隐私、可靠';
	@override String get sl2_descr => '您的数据只属于您。我们直接将您的信息存储于此设备，不会连接外部服务器。因此您可以在离线时继续使用此 app';
	@override String get sl2_descr2 => '此外，此 app 的源代码是公开的，任何人都可以查看它如何运行并贡献自己的力量';
	@override String get last_slide_title => '全部就绪';
	@override String get last_slide_descr => '使用 Monekin，您最终可以实现自己想要的财务独立。您将拥有和您的钱相关的图表、预算、提示、统计信息等。';
	@override String get last_slide_descr2 => '祝您使用愉快！如果您有任何疑问或建议，请随时与我们联系……';
}

// Path: home
class _TranslationsHomeZhCn implements TranslationsHomeEn {
	_TranslationsHomeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '面板';
	@override String get filter_transactions => '筛选交易';
	@override String get hello_day => '您好，';
	@override String get hello_night => '晚上好，';
	@override String get total_balance => '总余额';
	@override String get my_accounts => '我的账户';
	@override String get active_accounts => '活动账户';
	@override String get no_accounts => '尚未创建账户';
	@override String get no_accounts_descr => '要开始使用 Monekin，请创建至少一个账户，以便开始添加交易';
	@override String get last_transactions => '最近的交易';
	@override String get should_create_account_header => 'Oops!';
	@override String get should_create_account_message => '在可以开始创建交易之前，您必须拥有至少一个未被归档的账户';
}

// Path: financial_health
class _TranslationsFinancialHealthZhCn implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '财务健康';
	@override late final _TranslationsFinancialHealthReviewZhCn review = _TranslationsFinancialHealthReviewZhCn._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeZhCn months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeZhCn._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageZhCn savings_percentage = _TranslationsFinancialHealthSavingsPercentageZhCn._(_root);
}

// Path: stats
class _TranslationsStatsZhCn implements TranslationsStatsEn {
	_TranslationsStatsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '统计数据';
	@override String get balance => '余额';
	@override String get final_balance => '期末余额';
	@override String get balance_by_account => '账户余额';
	@override String get balance_by_account_subtitle => '我的大部分钱都在哪里？';
	@override String get balance_by_currency => '货币余额';
	@override String get balance_by_currency_subtitle => '我有多少的外币？';
	@override String get balance_evolution => '余额趋势';
	@override String get balance_evolution_subtitle => '我是否比之前更有钱了？';
	@override String get compared_to_previous_period => '与上一段时间相比';
	@override String get cash_flow => '现金流';
	@override String get cash_flow_subtitle => '我的支出是否少于我的收入？';
	@override String get by_periods => '按时间段';
	@override String get by_categories => '按类别';
	@override String get by_tags => '按标签';
	@override String get distribution => '分布';
	@override String get finance_health_resume => '总结';
	@override String get finance_health_breakdown => '分解';
}

// Path: icon_selector
class _TranslationsIconSelectorZhCn implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get name => '名称';
	@override String get icon => '图标';
	@override String get color => '颜色';
	@override String get select_icon => '选择一个图标';
	@override String get select_color => '选择一种颜色';
	@override String get current_color_selection => '当前选择';
	@override String get custom_color => '自定义颜色';
	@override String get select_account_icon => '确认您的账户';
	@override String get select_category_icon => '确认您的类别';
	@override late final _TranslationsIconSelectorScopesZhCn scopes = _TranslationsIconSelectorScopesZhCn._(_root);
}

// Path: transaction
class _TranslationsTransactionZhCn implements TranslationsTransactionEn {
	_TranslationsTransactionZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '交易',
		other: '交易',
	);
	@override String get create => '新交易';
	@override String get new_income => '新收入';
	@override String get new_expense => '新开支';
	@override String get new_success => '交易创建成功';
	@override String get edit => '编辑交易';
	@override String get edit_success => '交易编辑成功';
	@override String get edit_multiple => '批量编辑交易';
	@override String edit_multiple_success({required Object x}) => '${x}笔交易编辑成功';
	@override String get duplicate => '复制交易';
	@override String get duplicate_short => '复制';
	@override String get duplicate_warning_message => '将在同一日期创建一笔完全相同的交易，继续吗？';
	@override String get duplicate_success => '交易复制成功';
	@override String get delete => '删除交易';
	@override String get delete_warning_message => '此操作无法撤回。将重新计算您账户的当前余额及其它所有统计数据';
	@override String get delete_success => '交易删除成功';
	@override String get delete_multiple => '批量删除交易';
	@override String delete_multiple_warning_message({required Object x}) => '此操作无法撤回，并且将删除${x}笔交易。将重新计算您账户的当前余额及其它所有统计数据';
	@override String delete_multiple_success({required Object x}) => '${x}笔交易删除成功';
	@override String get details => '操作详情';
	@override late final _TranslationsTransactionNextPaymentsZhCn next_payments = _TranslationsTransactionNextPaymentsZhCn._(_root);
	@override late final _TranslationsTransactionListZhCn list = _TranslationsTransactionListZhCn._(_root);
	@override late final _TranslationsTransactionFiltersZhCn filters = _TranslationsTransactionFiltersZhCn._(_root);
	@override late final _TranslationsTransactionFormZhCn form = _TranslationsTransactionFormZhCn._(_root);
	@override late final _TranslationsTransactionReversedZhCn reversed = _TranslationsTransactionReversedZhCn._(_root);
	@override late final _TranslationsTransactionStatusZhCn status = _TranslationsTransactionStatusZhCn._(_root);
	@override late final _TranslationsTransactionTypesZhCn types = _TranslationsTransactionTypesZhCn._(_root);
}

// Path: transfer
class _TranslationsTransferZhCn implements TranslationsTransferEn {
	_TranslationsTransferZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '转账';
	@override String get transfers => '转账';
	@override String transfer_to({required Object account}) => '转账至 ${account}';
	@override String get create => '转账';
	@override String get need_two_accounts_warning_header => '哎呀！';
	@override String get need_two_accounts_warning_message => '至少需要两个账户才能执行此操作。如果您需要调整或编辑此账户的当前余额，请点击编辑按钮';
	@override late final _TranslationsTransferFormZhCn form = _TranslationsTransferFormZhCn._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsZhCn implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '循环交易';
	@override String get title_short => '循环交易';
	@override String get empty => '您似乎没有任何循环交易。创建一个每周、每月或每年的循环交易，它会在此显示';
	@override String get total_expense_title => '每一周期的总开支';
	@override String get total_expense_descr => '* 不考虑每一循环的起止日期';
	@override late final _TranslationsRecurrentTransactionsDetailsZhCn details = _TranslationsRecurrentTransactionsDetailsZhCn._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusZhCn status = _TranslationsRecurrentTransactionsStatusZhCn._(_root);
}

// Path: account
class _TranslationsAccountZhCn implements TranslationsAccountEn {
	_TranslationsAccountZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get details => '账户详情';
	@override String get date => '开启日期';
	@override String get close_date => '关闭日期';
	@override String get reopen => '重新开启账户';
	@override String get reopen_short => '重开账户';
	@override String get reopen_descr => '您确定要重新开启此账户吗？';
	@override String get balance => '账户余额';
	@override String get n_transactions => '交易数量';
	@override String get add_money => '增加金额';
	@override String get withdraw_money => '减少金额';
	@override String get no_accounts => '未发现应当显示的交易。请点击底部的 \'+\' 按钮新增一个交易';
	@override late final _TranslationsAccountTypesZhCn types = _TranslationsAccountTypesZhCn._(_root);
	@override late final _TranslationsAccountFormZhCn form = _TranslationsAccountFormZhCn._(_root);
	@override late final _TranslationsAccountDeleteZhCn delete = _TranslationsAccountDeleteZhCn._(_root);
	@override late final _TranslationsAccountCloseZhCn close = _TranslationsAccountCloseZhCn._(_root);
	@override late final _TranslationsAccountSelectZhCn select = _TranslationsAccountSelectZhCn._(_root);
}

// Path: currencies
class _TranslationsCurrenciesZhCn implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => '货币换算';
	@override String get currency => '货币';
	@override String get currency_manager => '货币管理';
	@override String get currency_manager_descr => '设置您的货币及其与其他货币的汇率';
	@override String get preferred_currency => '默认货币';
	@override String get change_preferred_currency_title => '更改默认货币';
	@override String get change_preferred_currency_msg => '从现在起，所有统计数据和预算都将以此货币显示。账户和交易将保留其原有货币单位。如果您执行此操作，所有保存的汇率都将被删除。您想继续吗？';
	@override late final _TranslationsCurrenciesFormZhCn form = _TranslationsCurrenciesFormZhCn._(_root);
	@override String get delete_all_success => '删除汇率成功';
	@override String get historical => '历史汇率';
	@override String get exchange_rate => '汇率';
	@override String get exchange_rates => '汇率';
	@override String get empty => '如果您有账户使用默认货币以外的货币，请在此处添加汇率，以获得更准确的图表';
	@override String get select_a_currency => '选择货币';
	@override String get search => '按名称或货币代码搜索';
}

// Path: tags
class _TranslationsTagsZhCn implements TranslationsTagsEn {
	_TranslationsTagsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '标签',
		other: '标签',
	);
	@override late final _TranslationsTagsFormZhCn form = _TranslationsTagsFormZhCn._(_root);
	@override late final _TranslationsTagsSelectZhCn select = _TranslationsTagsSelectZhCn._(_root);
	@override String get empty_list => '您还没有创建任何标签。标签和类别是对您的动作进行分类的好方法';
	@override String get without_tags => '没有标签';
	@override String get add => '添加标签';
	@override String get create => '创建标签';
	@override String get create_success => '标签创建成功';
	@override String get already_exists => '此标签名已存在。请起一个新的标签名';
	@override String get edit => '编辑标签';
	@override String get edit_success => '标签编辑成功';
	@override String get delete_success => '类别删除成功';
	@override String get delete_warning_header => '删除标签？';
	@override String get delete_warning_message => '此操作不会删除具有此标签的交易。';
}

// Path: categories
class _TranslationsCategoriesZhCn implements TranslationsCategoriesEn {
	_TranslationsCategoriesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get unknown => '未知类别';
	@override String get create => '创建类别';
	@override String get create_success => '类别创建成功';
	@override String get new_category => '新类别';
	@override String get already_exists => '此类别名已存在。请起一个新的类别名';
	@override String get edit => '编辑类别';
	@override String get edit_success => '类别编辑成功';
	@override String get name => '类别名称';
	@override String get type => '类别类型';
	@override String get both_types => '混合类型';
	@override String get subcategories => '子类别';
	@override String get subcategories_add => '新增子类别';
	@override String get make_parent => '移动至类别';
	@override String get make_child => '移动成为子类别';
	@override String make_child_warning1({required Object destiny}) => '此类别及其子类别将成为<b>${destiny}</b>的子类别。';
	@override String make_child_warning2({required Object x, required Object destiny}) => '它们的交易<b>(${x})</b>将被移至<b>${destiny}</b>类别中创建的新子类别。';
	@override String get make_child_success => '子类别创建成功';
	@override String get merge => '与另一个类别合并';
	@override String merge_warning1({required Object from, required Object x, required Object destiny}) => '与类别<b>${from}</b>相关的所有交易 (${x}) 将移至类别<b>${destiny}</b>';
	@override String merge_warning2({required Object from}) => '类别<b>${from}</b>将被无法撤回地删除。 ';
	@override String get merge_success => '类别合并成功';
	@override String get delete_success => '类别删除成功';
	@override String get delete_warning_header => '删除类别？';
	@override String delete_warning_message({required Object x}) => '此操作将无法撤回地删除与此类别相关的所有交易<b>(${x})</b>。';
	@override late final _TranslationsCategoriesSelectZhCn select = _TranslationsCategoriesSelectZhCn._(_root);
}

// Path: budgets
class _TranslationsBudgetsZhCn implements TranslationsBudgetsEn {
	_TranslationsBudgetsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '预算';
	@override String get repeated => '重复的';
	@override String get one_time => '单次的';
	@override String get annual => '年度';
	@override String get week => '每周';
	@override String get month => '每月';
	@override String get actives => '活跃';
	@override String get pending => '待办';
	@override String get finish => '完成';
	@override String get from_budgeted => '预算为';
	@override String get days_left => '天还剩';
	@override String get days_to_start => '天开始';
	@override String get since_expiration => '自到期日起的天数';
	@override String get no_budgets => '未发现应当显示的预算。请点击底部的 \'+\' 按钮新增一个预算';
	@override String get delete => '删除预算';
	@override String get delete_warning => '此操作无法撤回。此预算中的类别和交易不会被删除';
	@override late final _TranslationsBudgetsFormZhCn form = _TranslationsBudgetsFormZhCn._(_root);
	@override late final _TranslationsBudgetsDetailsZhCn details = _TranslationsBudgetsDetailsZhCn._(_root);
}

// Path: backup
class _TranslationsBackupZhCn implements TranslationsBackupEn {
	_TranslationsBackupZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportZhCn export = _TranslationsBackupExportZhCn._(_root);
	@override late final _TranslationsBackupImportZhCn import = _TranslationsBackupImportZhCn._(_root);
	@override late final _TranslationsBackupAboutZhCn about = _TranslationsBackupAboutZhCn._(_root);
}

// Path: settings
class _TranslationsSettingsZhCn implements TranslationsSettingsEn {
	_TranslationsSettingsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title_long => '设置和外观';
	@override String get title_short => '设置';
	@override String get description => 'app 主题、语言和其它常规设置';
	@override String get edit_profile => '编辑个人资料';
	@override String get lang_section => '语言和文字';
	@override String get lang_title => 'app 语言/Language';
	@override String get lang_descr => 'app 中显示文字的语言';
	@override String get lang_help => '如果您想合作翻译此 app，您可参考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我们的指南</a>';
	@override String get locale => '地区';
	@override String get locale_descr => '设置用于日期、数字的格式……';
	@override String get locale_warn => '更改区域时 app 将更新';
	@override String get first_day_of_week => '一周的第一天';
	@override String get theme_and_colors => '主题和颜色';
	@override String get theme => '主题';
	@override String get theme_auto => '系统';
	@override String get theme_light => '明亮主题';
	@override String get theme_dark => '黑暗主题';
	@override String get amoled_mode => 'AMOLED 模式';
	@override String get amoled_mode_descr => '尽可能使用纯黑色壁纸。在 AMOLED 屏幕的设备上能略微省电';
	@override String get dynamic_colors => '动态色彩';
	@override String get dynamic_colors_descr => '尽可能使用系统强调色';
	@override String get accent_color => '强调色';
	@override String get accent_color_descr => '选择 app 用来强调介面某些部分的颜色';
	@override late final _TranslationsSettingsSecurityZhCn security = _TranslationsSettingsSecurityZhCn._(_root);
}

// Path: more
class _TranslationsMoreZhCn implements TranslationsMoreEn {
	_TranslationsMoreZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '更多';
	@override String get title_long => '更多';
	@override late final _TranslationsMoreDataZhCn data = _TranslationsMoreDataZhCn._(_root);
	@override late final _TranslationsMoreAboutUsZhCn about_us = _TranslationsMoreAboutUsZhCn._(_root);
	@override late final _TranslationsMoreHelpUsZhCn help_us = _TranslationsMoreHelpUsZhCn._(_root);
}

// Path: general.clipboard
class _TranslationsGeneralClipboardZhCn implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '已复制 ${x}';
	@override String get error => '复制出错';
}

// Path: general.time
class _TranslationsGeneralTimeZhCn implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get start_date => '开始日期';
	@override String get end_date => '结束日期';
	@override String get from_date => '从';
	@override String get until_date => '到';
	@override String get date => '日期';
	@override String get datetime => '日期时间';
	@override String get time => '时间';
	@override String get each => '每';
	@override String get after => '后';
	@override late final _TranslationsGeneralTimeRangesZhCn ranges = _TranslationsGeneralTimeRangesZhCn._(_root);
	@override late final _TranslationsGeneralTimePeriodicityZhCn periodicity = _TranslationsGeneralTimePeriodicityZhCn._(_root);
	@override late final _TranslationsGeneralTimeCurrentZhCn current = _TranslationsGeneralTimeCurrentZhCn._(_root);
	@override late final _TranslationsGeneralTimeAllZhCn all = _TranslationsGeneralTimeAllZhCn._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderZhCn implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '排序';
	@override String get category => '按类别';
	@override String get quantity => '按数额';
	@override String get date => '按日期';
}

// Path: general.validations
class _TranslationsGeneralValidationsZhCn implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get form_error => '请改正指定的项目后继续';
	@override String get required => '必填项目';
	@override String get positive => '应为正值';
	@override String min_number({required Object x}) => '应大于${x}';
	@override String max_number({required Object x}) => '应小于${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewZhCn implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '很好！';
			case GenderContext.female:
				return '很好！';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '好';
			case GenderContext.female:
				return '好';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '一般';
			case GenderContext.female:
				return '一般';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '不好';
			case GenderContext.female:
				return '不好';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '很不好';
			case GenderContext.female:
				return '很不好';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '数据不足';
			case GenderContext.female:
				return '数据不足';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrZhCn descr = _TranslationsFinancialHealthReviewDescrZhCn._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeZhCn implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '财富自由时长';
	@override String get subtitle => '根据您的余额计算出您可以在无收入的情况下生活的时长';
	@override String get text_zero => '按这样的开支速度，您无法支撑一个月！';
	@override String get text_one => '按这样的开支速度，如果没有收入，您可以大概支撑一个月！';
	@override String text_other({required Object n}) => '按这样的开支速度，如果没有收入，您可以大概支撑 <b>${n}个月</b>。';
	@override String get text_infinite => '按这样的开支速度，即使没有收入，您也可以维持 <b>一辈子</b>。';
	@override String get suggestion => '请记住，建议至少保持这一数字在 5 个月以上。如果您发现您没有足够的储蓄，请减少不必要的开支。';
	@override String get insufficient_data => '看起来我们没有足够的数据来计算您没有收入后，能够支撑几个月。请添加一些支出/收入，再来这里查看您的财务健康情况';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageZhCn implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '储蓄百分比';
	@override String get subtitle => '这段时间内您的收入中哪一部分没有被花掉';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextZhCn text = _TranslationsFinancialHealthSavingsPercentageTextZhCn._(_root);
	@override String get suggestion => '请记住，建议至少将您赚到的 15-20% 存下来。';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesZhCn implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get transport => '交通';
	@override String get money => '金钱';
	@override String get food => '食物';
	@override String get medical => '医疗';
	@override String get entertainment => '休闲';
	@override String get technology => '科技';
	@override String get other => '其它';
	@override String get logos_financial_institutions => '金融机构';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsZhCn implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get accept => '接受';
	@override String get skip => '跳过';
	@override String get skip_success => '已成果跳过交易';
	@override String get skip_dialog_title => '跳过交易';
	@override String skip_dialog_msg({required Object date}) => '此操作无法撤回。我们将把下次的日期移动至${date}';
	@override String get accept_today => '今天接受';
	@override String accept_in_required_date({required Object date}) => '在要求的日期 (${date}) 接受';
	@override String get accept_dialog_title => '接受交易';
	@override String get accept_dialog_msg_single => '此交易的新状态将为null。您可以随时重新编辑此交易的状态';
	@override String accept_dialog_msg({required Object date}) => '此操作将建立日期为 ${date} 的新交易。您可以在交易页面查看此交易的详情';
	@override String get recurrent_rule_finished => '循环规则已完成，没有更多的支付！';
}

// Path: transaction.list
class _TranslationsTransactionListZhCn implements TranslationsTransactionListEn {
	_TranslationsTransactionListZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get empty => '未发现需要显示的交易。请先在 app 中添加一些交易，下次再来查看';
	@override String get searcher_placeholder => '按类别、描述等搜索';
	@override String get searcher_no_results => '未找到符合搜索条件的交易';
	@override String get loading => '正在加载更多的交易……';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '已选择 ${n}',
		other: '已选择 ${n}',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '已选择 ${n} 笔交易',
		other: '已选择 ${n} 笔交易',
	);
	@override late final _TranslationsTransactionListBulkEditZhCn bulk_edit = _TranslationsTransactionListBulkEditZhCn._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersZhCn implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get from_value => '最小金额';
	@override String get to_value => '最大金额';
	@override String from_value_def({required Object x}) => '从 ${x}';
	@override String to_value_def({required Object x}) => '到 ${x}';
	@override String from_date_def({required Object date}) => '从 ${date}';
	@override String to_date_def({required Object date}) => '到 ${date}';
}

// Path: transaction.form
class _TranslationsTransactionFormZhCn implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsZhCn validators = _TranslationsTransactionFormValidatorsZhCn._(_root);
	@override String get title => '交易标题';
	@override String get title_short => '标题';
	@override String get value => '数额';
	@override String get tap_to_see_more => '点击查看更多详情';
	@override String get no_tags => '-- 无标签 --';
	@override String get description => '描述';
	@override String get description_info => '点击此处输入有关此交易的详细描述';
	@override String exchange_to_preferred_title({required Object currency}) => '汇率为${currency}';
	@override String get exchange_to_preferred_in_date => '交易日';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedZhCn implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '逆向交易';
	@override String get title_short => '逆向交易';
	@override String get description_for_expenses => '尽管是一个开支交易，但其数额为正值。此类交易可用于表示已记录开支的返还，例如退款或偿还债务。';
	@override String get description_for_incomes => '尽管是一个收入交易，但其数额为负值。此类交易可用于作废或更正收入记录中的错误，以反映退款或记录偿还债务。';
}

// Path: transaction.status
class _TranslationsTransactionStatusZhCn implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '状态',
		other: '状态',
	);
	@override String get display_long => '交易状态';
	@override String tr_status({required Object status}) => '${status}交易';
	@override String get none => '无状态';
	@override String get none_descr => '没有特定的状态';
	@override String get reconciled => '已核对';
	@override String get reconciled_descr => '此交易已被核实，与您银行的一个真实交易相对应';
	@override String get unreconciled => '未核实';
	@override String get unreconciled_descr => '此交易尚未被核实，因此尚未出现在您的真实银行账户中。然而，在 Monekin 中，它将被用于计算余额和其它统计数据';
	@override String get pending => '待办';
	@override String get pending_descr => '此交易正在等待处理，因此在计算余额和其它统计数据时暂时不会被考虑';
	@override String get voided => '作废';
	@override String get voided_descr => '由于付款错误或其它原因造成的作废或取消的交易。在计算余额和其它统计数据时不会被考虑';
}

// Path: transaction.types
class _TranslationsTransactionTypesZhCn implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '交易类型',
		other: '交易类型',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '收入',
		other: '收入',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '支出',
		other: '支出',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '转账',
		other: '转账',
	);
}

// Path: transfer.form
class _TranslationsTransferFormZhCn implements TranslationsTransferFormEn {
	_TranslationsTransferFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get from => '转出账户';
	@override String get to => '转入账户';
	@override late final _TranslationsTransferFormValueInDestinyZhCn value_in_destiny = _TranslationsTransferFormValueInDestinyZhCn._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsZhCn implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '循环交易';
	@override String get descr => '此交易的未来的动作显示如下。您可以接受第一个动作或跳过此动作';
	@override String get last_payment_info => '此动作是循环规则的最后一个，因此当确认此动作后，这一循环规则将被自动删除';
	@override String get delete_header => '删除循环交易';
	@override String get delete_message => '此操作无法撤回，不会影响您已确认/付款的交易';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusZhCn implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => '延迟 ${x} 天';
	@override String coming_in({required Object x}) => '${x} 天内';
}

// Path: account.types
class _TranslationsAccountTypesZhCn implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '账户类型';
	@override String get warning => '账户类型一旦选择，以后将无法更改';
	@override String get normal => '普通账户';
	@override String get normal_descr => '用于记录日常财务。这是最普通的账户，您可以添加支出、收入……';
	@override String get saving => '储蓄账户';
	@override String get saving_descr => '您只能从此账户中向其它账户中转入/转出（而无法用于消费开支）。非常适合用于存钱';
}

// Path: account.form
class _TranslationsAccountFormZhCn implements TranslationsAccountFormEn {
	_TranslationsAccountFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get name => '账户名称';
	@override String get name_placeholder => '例如：储蓄账户';
	@override String get notes => '备注';
	@override String get notes_placeholder => '输入有关此账户的一些备注/描述';
	@override String get initial_balance => '初始余额';
	@override String get current_balance => '当前余额';
	@override String get create => '创建账户';
	@override String get edit => '编辑账户';
	@override String get currency_not_found_warn => '您没有此货币的汇率信息。将使用默认汇率 1.0。您可以在设置中修改';
	@override String get already_exists => '此账户名已存在，请起一个新的账户名';
	@override String get tr_before_opening_date => '此账户中有早于开户日期的交易';
	@override String get iban => '国际银行账户号码（IBAN）';
	@override String get swift => '银行识别码（SWIFT）';
}

// Path: account.delete
class _TranslationsAccountDeleteZhCn implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get warning_header => '删除账户？';
	@override String get warning_text => '此操作将删除此账户及其所有交易';
	@override String get success => '账户删除成功';
}

// Path: account.close
class _TranslationsAccountCloseZhCn implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '关闭账户';
	@override String get title_short => '关闭';
	@override String get warn => '此账户将不再出现在特定列表中，并且您无法在此账户中创建晚于以下日期的交易。此操作不会影响任何交易或余额，您也可以随时重新开启此账户。';
	@override String get should_have_zero_balance => '此账户中的当前余额必须为 0 才可关闭。请在继续之前编辑账户';
	@override String get should_have_no_transactions => '此账户在指定的关闭日期之后仍有交易。请删除它们或编辑账户关闭日期，然后再继续';
	@override String get success => '账户关闭成功';
	@override String get unarchive_succes => '账户已成功重新开启';
}

// Path: account.select
class _TranslationsAccountSelectZhCn implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get one => '选择一个账户';
	@override String get all => '所有账户';
	@override String get multiple => '选择多个账户';
}

// Path: currencies.form
class _TranslationsCurrenciesFormZhCn implements TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => '货币不能与用户货币相同';
	@override String get specify_a_currency => '请指定货币';
	@override String get add => '添加汇率';
	@override String get add_success => '汇率添加成功';
	@override String get edit => '编辑汇率';
	@override String get edit_success => '汇率编辑成功';
}

// Path: tags.form
class _TranslationsTagsFormZhCn implements TranslationsTagsFormEn {
	_TranslationsTagsFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get name => '标签名';
	@override String get description => '描述';
}

// Path: tags.select
class _TranslationsTagsSelectZhCn implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '选择标签';
	@override String get all => '所有标签';
}

// Path: categories.select
class _TranslationsCategoriesSelectZhCn implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '选择类别';
	@override String get select_one => '选择一个类别';
	@override String get select_subcategory => '选择一个子类别';
	@override String get without_subcategory => '没有子类别';
	@override String get all => '所有类别';
	@override String get all_short => '全部';
}

// Path: budgets.form
class _TranslationsBudgetsFormZhCn implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '创建预算';
	@override String get name => '预算名称';
	@override String get value => '预算额度';
	@override String get create => '创建预算';
	@override String get edit => '编辑预算';
	@override String get negative_warn => '预算额度不能为负数';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsZhCn implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '预算详情';
	@override String get statistics => '统计数据';
	@override String get budget_value => '预算';
	@override String expend_diary_left({required Object remainingDays, required Object dailyAmount}) => '在未来 ${remainingDays} 天中，您每天可以花费 ${dailyAmount}';
	@override String get expend_evolution => '支出变化';
	@override String get no_transactions => '看来您还没有与此预算相关的任何支出';
}

// Path: backup.export
class _TranslationsBackupExportZhCn implements TranslationsBackupExportEn {
	_TranslationsBackupExportZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '导出您的数据';
	@override String get title_short => '导出';
	@override String get all => '完整备份';
	@override String get all_descr => '导出您的所有数据（账户、交易、预算、设置……）。随时再次导入它们，您就不会丟失任何內容。';
	@override String get transactions => '交易备份';
	@override String get transactions_descr => '以 CSV 格式导出您的交易，以便您可以在其它程序或 app 中更轻松地分析。';
	@override String get description => '以不同格式下载（导出）数据';
	@override String get dialog_title => '保存/发送文件';
	@override String success({required Object x}) => '文件已成功保存/下载至 ${x}';
	@override String get error => '下载文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员';
}

// Path: backup.import
class _TranslationsBackupImportZhCn implements TranslationsBackupImportEn {
	_TranslationsBackupImportZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '导入您的数据';
	@override String get title_short => '导入';
	@override String get restore_backup => '恢复备份';
	@override String get restore_backup_descr => '导入一个从 Monekin 保存的数据库。此操作将用新数据覆盖当前 app 数据';
	@override String get restore_backup_warn_description => '导入新数据库时，您将丟失 app 中当前保存的所有数据。建议在继续之前进行备份。请勿在此上传任何来源不明的文件，仅上传您之前从 Monekin 下载的文件';
	@override String get restore_backup_warn_title => '覆盖所有数据';
	@override String get select_other_file => '选择其它文件';
	@override String get tap_to_select_file => '点击选择文件';
	@override late final _TranslationsBackupImportManualImportZhCn manual_import = _TranslationsBackupImportManualImportZhCn._(_root);
	@override String get success => '导入成功';
	@override String get cancelled => '导入被用户取消';
	@override String get error => '导入文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员。';
}

// Path: backup.about
class _TranslationsBackupAboutZhCn implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '有关您的数据库的信息';
	@override String get create_date => '创建日期';
	@override String get modify_date => '上一次更改';
	@override String get last_backup => '上次备份';
	@override String get size => '文件大小';
}

// Path: settings.security
class _TranslationsSettingsSecurityZhCn implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '安全';
	@override String get private_mode_at_launch => '启动隐私模式';
	@override String get private_mode_at_launch_descr => '默认以隐私模式启动 app ';
	@override String get private_mode => '隐私模式';
	@override String get private_mode_descr => '隐藏所有金额';
	@override String get private_mode_activated => '隐私模式已启用';
	@override String get private_mode_deactivated => '隐私模式已禁用';
}

// Path: more.data
class _TranslationsMoreDataZhCn implements TranslationsMoreDataEn {
	_TranslationsMoreDataZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '数据';
	@override String get display_descr => '导出和导入您的数据，这样您不会丟失任何东西';
	@override String get delete_all => '删除我的数据';
	@override String get delete_all_header1 => '停下⚠️⚠️';
	@override String get delete_all_message1 => '您确定要继续吗？您的所有数据将永久删除且无法恢复';
	@override String get delete_all_header2 => '最后一步⚠️⚠️';
	@override String get delete_all_message2 => '删除账户后，您将删除所有保存的个人数据。您的账户、交易、预算和类别将被删除且无法恢复。您同意吗？';
}

// Path: more.about_us
class _TranslationsMoreAboutUsZhCn implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => 'app 信息';
	@override String get description => '查看有关 Monekin 的条款和其它相关信息。与社区取得联系以报告错误、留下建议……';
	@override late final _TranslationsMoreAboutUsLegalZhCn legal = _TranslationsMoreAboutUsLegalZhCn._(_root);
	@override late final _TranslationsMoreAboutUsProjectZhCn project = _TranslationsMoreAboutUsProjectZhCn._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsZhCn implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '帮助我们';
	@override String get description => '了解如何帮助 Monekin 变得越来越好';
	@override String get rate_us => '评价我们';
	@override String get rate_us_descr => '欢迎所有分数和评价！';
	@override String get share => '分享 Monekin';
	@override String get share_descr => '与朋友和家人分享我们的 app ';
	@override String get share_text => 'Monekin！最好的个人理财 app 。此处下载';
	@override String get thanks => '谢谢您！';
	@override String get thanks_long => '您对 Monekin 和其它大大小小的开源项目的贡献成就了这一伟大项目。感谢您花时间做出贡献。';
	@override String get donate => '捐款';
	@override String get donate_descr => '通过您的捐款，您将帮助此 app 持续改进完善。还有什么比请我喝一杯咖啡更好的感谢方式呢？';
	@override String get donate_success => '捐款已完成。非常感谢您的贡献！❤️';
	@override String get donate_err => '糟糕！接收您的付款时出现错误';
	@override String get report => '报告错误，留下建议……';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesZhCn implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '时间范围';
	@override String get it_repeat => '重复';
	@override String get it_ends => '结束';
	@override String get forever => '永久';
	@override late final _TranslationsGeneralTimeRangesTypesZhCn types = _TranslationsGeneralTimeRangesTypesZhCn._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每${range}',
		other: '每${n}${range}',
	);
	@override String each_range_until_date({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每${range}直到${day}',
		other: '每 ${n}${range}直到${day}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每${range}${limit}次',
		other: '每${n}${range}${limit}次',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每${range}一次',
		other: '每${n}${range}一次',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '月',
		other: '月',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '年',
		other: '年',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '天',
		other: '天',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '星期',
		other: '星期',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityZhCn implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '重复';
	@override String get no_repeat => '不重复';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '重复',
		other: '重复',
	);
	@override String get diary => '每天';
	@override String get monthly => '每月';
	@override String get annually => '每年';
	@override String get quaterly => '每季度';
	@override String get weekly => '每周';
	@override String get custom => '自定义';
	@override String get infinite => '总是';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentZhCn implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get monthly => '当月';
	@override String get annually => '今年';
	@override String get quaterly => '本季度';
	@override String get weekly => '本星期';
	@override String get infinite => '永远';
	@override String get custom => '自定义范围';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllZhCn implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get diary => '每天';
	@override String get monthly => '每月';
	@override String get annually => '每年';
	@override String get quaterly => '每季度';
	@override String get weekly => '每周';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrZhCn implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => '看起来我们没有足够的数据来计算您的财务健康情况。请添加一些支出/收入以便我们帮助您！';
	@override String get very_good => '恭喜！您的财务状况非常好。我们希望您能够继续保持，并继续和 Monekin 一起学习。';
	@override String get good => '很好！您的财务健康状况良好。请查看分析页面，了解如何省下更多！';
	@override String get normal => '您的财务健康状况在这一段时间里处于平均水平';
	@override String get bad => '看起来您的财务状况不是很理想。请查看其余的图表以便进一步了解您的财务情况。';
	@override String get very_bad => '嗯，您的财务健康状况远低于应有的水平。请查看其余的图表以便进一步了解您的财务情况。';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextZhCn implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => '恭喜！您在这段时间内成功省下了 <b>${value}%</b> 的收入。看来您已经是一位专家了，请继续保持！';
	@override String normal({required Object value}) => '恭喜，您在这段时间内成功省下了 <b>${value}%</b> 的收入。';
	@override String bad({required Object value}) => '您在这段时间内省下了 <b>${value}%</b> 的收入。但我们认为您可以做得更好！';
	@override String get very_bad => '哇，您在这段时间内并没有任何结余。';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditZhCn implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get dates => '批量编辑日期';
	@override String get categories => '批量编辑类别';
	@override String get status => '批量编辑状态';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsZhCn implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get zero => '交易数额不应为零';
	@override String get date_max => '所选日期晚于当前日期。交易将新增为待办';
	@override String get date_after_account_creation => '无法创建早于账户创建日期的交易';
	@override String get negative_transfer => '转账数额不应为负数';
	@override String get transfer_between_same_accounts => '来源于目标账户不应相同';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyZhCn implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '转账数额';
	@override String amount_short({required Object amount}) => '${amount} 至目标账户';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportZhCn implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '手动导入';
	@override String get descr => '手动从 .csv 文件导入交易';
	@override String get default_account => '默认账户';
	@override String get remove_default_account => '删除默认账户';
	@override String get default_category => '默认类别';
	@override String get select_a_column => '从 .csv 中选择一列';
	@override List<String> get steps => [
		'选择您的文件',
		'数额列',
		'账户列',
		'类别列',
		'日期列',
		'其它列',
	];
	@override List<String> get steps_descr => [
		'从您的设备中选择一个 .csv 文件。确保它的第一行描述了每列的名称。',
		'选择每笔交易数额的列。负值表示支出，正值表示收入。.表示小数点分隔符。',
		'选择每笔交易所属账户的列。您也可以选择默认账户，以防我们找不到您想要的账户。如果未指定默认账户，我们将建立一个同名账户。',
		'选择交易类别名称所在的列。您必须指定一个默认类别，以便我们在找不到此类别时，将默认类别分配给交易。',
		'选择每笔交易日期的列。如果未指定，所有交易将使用当前日期。',
		'选择其它交易属性的数据列',
	];
	@override String success({required Object x}) => '成功导入 ${x} 笔交易';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalZhCn implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '法律信息';
	@override String get privacy => '隐私权政策';
	@override String get terms => '使用条款';
	@override String get licenses => '许可证';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectZhCn implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '项目';
	@override String get contributors => '合作者';
	@override String get contributors_descr => '所有让 Monekin 成长的开发者';
	@override String get contact => '联系我们';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesZhCn implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get cycle => '循环';
	@override String get last_days => 'Last days';
	@override String last_days_form({required Object x}) => '前${x}天';
	@override String get all => '总是';
	@override String get date_range => '自定义范围';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return '取消';
			case 'ui_actions.confirm': return '确认';
			case 'ui_actions.continue_text': return '继续';
			case 'ui_actions.save': return '保存';
			case 'ui_actions.save_changes': return '保存更改';
			case 'ui_actions.close_and_save': return '保存并关闭';
			case 'ui_actions.add': return '添加';
			case 'ui_actions.edit': return '编辑';
			case 'ui_actions.delete': return '删除';
			case 'ui_actions.see_more': return '查看更多';
			case 'ui_actions.select_all': return '全选';
			case 'ui_actions.deselect_all': return '取消全选';
			case 'ui_actions.select': return '选择';
			case 'ui_actions.search': return '搜索';
			case 'ui_actions.filter': return '筛选';
			case 'ui_actions.reset': return '重置';
			case 'ui_actions.submit': return '提交';
			case 'ui_actions.next': return '下一步';
			case 'ui_actions.previous': return '上一步';
			case 'ui_actions.back': return '返回';
			case 'ui_actions.reload': return '重新加载';
			case 'ui_actions.view': return '视图';
			case 'ui_actions.download': return '下载';
			case 'ui_actions.upload': return '上传';
			case 'ui_actions.retry': return '重试';
			case 'ui_actions.copy': return '复制';
			case 'ui_actions.paste': return '粘贴';
			case 'ui_actions.undo': return '撤销';
			case 'ui_actions.redo': return '还原';
			case 'ui_actions.open': return '打开';
			case 'ui_actions.close': return '关闭';
			case 'ui_actions.apply': return '应用';
			case 'ui_actions.discard': return '放弃';
			case 'ui_actions.refresh': return '刷新';
			case 'ui_actions.details': return '详情';
			case 'ui_actions.share': return '分享';
			case 'general.or': return '或';
			case 'general.understood': return '明白';
			case 'general.unspecified': return '未指定';
			case 'general.quick_actions': return '快捷行动';
			case 'general.balance': return '余额';
			case 'general.account': return '账户';
			case 'general.accounts': return '账户';
			case 'general.categories': return '类别';
			case 'general.category': return '类别';
			case 'general.today': return '今天';
			case 'general.yesterday': return '昨天';
			case 'general.filters': return '筛选';
			case 'general.empty_warn': return '喔！空空如也';
			case 'general.insufficient_data': return '数据不足';
			case 'general.show_more_fields': return '显示更多';
			case 'general.show_less_fields': return '显示更少';
			case 'general.tap_to_search': return '点击以搜索';
			case 'general.clipboard.success': return ({required Object x}) => '已复制 ${x}';
			case 'general.clipboard.error': return '复制出错';
			case 'general.time.start_date': return '开始日期';
			case 'general.time.end_date': return '结束日期';
			case 'general.time.from_date': return '从';
			case 'general.time.until_date': return '到';
			case 'general.time.date': return '日期';
			case 'general.time.datetime': return '日期时间';
			case 'general.time.time': return '时间';
			case 'general.time.each': return '每';
			case 'general.time.after': return '后';
			case 'general.time.ranges.display': return '时间范围';
			case 'general.time.ranges.it_repeat': return '重复';
			case 'general.time.ranges.it_ends': return '结束';
			case 'general.time.ranges.forever': return '永久';
			case 'general.time.ranges.types.cycle': return '循环';
			case 'general.time.ranges.types.last_days': return 'Last days';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '前${x}天';
			case 'general.time.ranges.types.all': return '总是';
			case 'general.time.ranges.types.date_range': return '自定义范围';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}',
				other: '每${n}${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}直到${day}',
				other: '每 ${n}${range}直到${day}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}${limit}次',
				other: '每${n}${range}${limit}次',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}一次',
				other: '每${n}${range}一次',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '月',
				other: '月',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '年',
				other: '年',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '天',
				other: '天',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '星期',
				other: '星期',
			);
			case 'general.time.periodicity.display': return '重复';
			case 'general.time.periodicity.no_repeat': return '不重复';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '重复',
				other: '重复',
			);
			case 'general.time.periodicity.diary': return '每天';
			case 'general.time.periodicity.monthly': return '每月';
			case 'general.time.periodicity.annually': return '每年';
			case 'general.time.periodicity.quaterly': return '每季度';
			case 'general.time.periodicity.weekly': return '每周';
			case 'general.time.periodicity.custom': return '自定义';
			case 'general.time.periodicity.infinite': return '总是';
			case 'general.time.current.monthly': return '当月';
			case 'general.time.current.annually': return '今年';
			case 'general.time.current.quaterly': return '本季度';
			case 'general.time.current.weekly': return '本星期';
			case 'general.time.current.infinite': return '永远';
			case 'general.time.current.custom': return '自定义范围';
			case 'general.time.all.diary': return '每天';
			case 'general.time.all.monthly': return '每月';
			case 'general.time.all.annually': return '每年';
			case 'general.time.all.quaterly': return '每季度';
			case 'general.time.all.weekly': return '每周';
			case 'general.transaction_order.display': return '排序';
			case 'general.transaction_order.category': return '按类别';
			case 'general.transaction_order.quantity': return '按数额';
			case 'general.transaction_order.date': return '按日期';
			case 'general.validations.form_error': return '请改正指定的项目后继续';
			case 'general.validations.required': return '必填项目';
			case 'general.validations.positive': return '应为正值';
			case 'general.validations.min_number': return ({required Object x}) => '应大于${x}';
			case 'general.validations.max_number': return ({required Object x}) => '应小于${x}';
			case 'intro.start': return '开始';
			case 'intro.skip': return '跳过';
			case 'intro.next': return '继续';
			case 'intro.select_your_currency': return '选择您的货币';
			case 'intro.welcome_subtitle': return '您的个人财务管家';
			case 'intro.welcome_subtitle2': return '100% 开放，100% 免费';
			case 'intro.welcome_footer': return '登录即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隐私策略</a>和此 app 的<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>使用条款</a>';
			case 'intro.offline_descr_title': return '本地账户：';
			case 'intro.offline_descr': return '您的数据只会存储于此设备中，只要您不卸载应用或更换手机，数据就会保持安全。为避免数据丢失，建议定期从 app 设置中备份数据。';
			case 'intro.offline_start': return '开始使用本地账户';
			case 'intro.sl1_title': return '选择您的货币';
			case 'intro.sl1_descr': return '您的默认货币会被用于报表和图表中。您之后可以随时更改默认货币和 app 语言';
			case 'intro.sl2_title': return '安全、隐私、可靠';
			case 'intro.sl2_descr': return '您的数据只属于您。我们直接将您的信息存储于此设备，不会连接外部服务器。因此您可以在离线时继续使用此 app';
			case 'intro.sl2_descr2': return '此外，此 app 的源代码是公开的，任何人都可以查看它如何运行并贡献自己的力量';
			case 'intro.last_slide_title': return '全部就绪';
			case 'intro.last_slide_descr': return '使用 Monekin，您最终可以实现自己想要的财务独立。您将拥有和您的钱相关的图表、预算、提示、统计信息等。';
			case 'intro.last_slide_descr2': return '祝您使用愉快！如果您有任何疑问或建议，请随时与我们联系……';
			case 'home.title': return '面板';
			case 'home.filter_transactions': return '筛选交易';
			case 'home.hello_day': return '您好，';
			case 'home.hello_night': return '晚上好，';
			case 'home.total_balance': return '总余额';
			case 'home.my_accounts': return '我的账户';
			case 'home.active_accounts': return '活动账户';
			case 'home.no_accounts': return '尚未创建账户';
			case 'home.no_accounts_descr': return '要开始使用 Monekin，请创建至少一个账户，以便开始添加交易';
			case 'home.last_transactions': return '最近的交易';
			case 'home.should_create_account_header': return 'Oops!';
			case 'home.should_create_account_message': return '在可以开始创建交易之前，您必须拥有至少一个未被归档的账户';
			case 'financial_health.display': return '财务健康';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '很好！';
					case GenderContext.female:
						return '很好！';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '好';
					case GenderContext.female:
						return '好';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '一般';
					case GenderContext.female:
						return '一般';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '不好';
					case GenderContext.female:
						return '不好';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '很不好';
					case GenderContext.female:
						return '很不好';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '数据不足';
					case GenderContext.female:
						return '数据不足';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return '看起来我们没有足够的数据来计算您的财务健康情况。请添加一些支出/收入以便我们帮助您！';
			case 'financial_health.review.descr.very_good': return '恭喜！您的财务状况非常好。我们希望您能够继续保持，并继续和 Monekin 一起学习。';
			case 'financial_health.review.descr.good': return '很好！您的财务健康状况良好。请查看分析页面，了解如何省下更多！';
			case 'financial_health.review.descr.normal': return '您的财务健康状况在这一段时间里处于平均水平';
			case 'financial_health.review.descr.bad': return '看起来您的财务状况不是很理想。请查看其余的图表以便进一步了解您的财务情况。';
			case 'financial_health.review.descr.very_bad': return '嗯，您的财务健康状况远低于应有的水平。请查看其余的图表以便进一步了解您的财务情况。';
			case 'financial_health.months_without_income.title': return '财富自由时长';
			case 'financial_health.months_without_income.subtitle': return '根据您的余额计算出您可以在无收入的情况下生活的时长';
			case 'financial_health.months_without_income.text_zero': return '按这样的开支速度，您无法支撑一个月！';
			case 'financial_health.months_without_income.text_one': return '按这样的开支速度，如果没有收入，您可以大概支撑一个月！';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => '按这样的开支速度，如果没有收入，您可以大概支撑 <b>${n}个月</b>。';
			case 'financial_health.months_without_income.text_infinite': return '按这样的开支速度，即使没有收入，您也可以维持 <b>一辈子</b>。';
			case 'financial_health.months_without_income.suggestion': return '请记住，建议至少保持这一数字在 5 个月以上。如果您发现您没有足够的储蓄，请减少不必要的开支。';
			case 'financial_health.months_without_income.insufficient_data': return '看起来我们没有足够的数据来计算您没有收入后，能够支撑几个月。请添加一些支出/收入，再来这里查看您的财务健康情况';
			case 'financial_health.savings_percentage.title': return '储蓄百分比';
			case 'financial_health.savings_percentage.subtitle': return '这段时间内您的收入中哪一部分没有被花掉';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => '恭喜！您在这段时间内成功省下了 <b>${value}%</b> 的收入。看来您已经是一位专家了，请继续保持！';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => '恭喜，您在这段时间内成功省下了 <b>${value}%</b> 的收入。';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => '您在这段时间内省下了 <b>${value}%</b> 的收入。但我们认为您可以做得更好！';
			case 'financial_health.savings_percentage.text.very_bad': return '哇，您在这段时间内并没有任何结余。';
			case 'financial_health.savings_percentage.suggestion': return '请记住，建议至少将您赚到的 15-20% 存下来。';
			case 'stats.title': return '统计数据';
			case 'stats.balance': return '余额';
			case 'stats.final_balance': return '期末余额';
			case 'stats.balance_by_account': return '账户余额';
			case 'stats.balance_by_account_subtitle': return '我的大部分钱都在哪里？';
			case 'stats.balance_by_currency': return '货币余额';
			case 'stats.balance_by_currency_subtitle': return '我有多少的外币？';
			case 'stats.balance_evolution': return '余额趋势';
			case 'stats.balance_evolution_subtitle': return '我是否比之前更有钱了？';
			case 'stats.compared_to_previous_period': return '与上一段时间相比';
			case 'stats.cash_flow': return '现金流';
			case 'stats.cash_flow_subtitle': return '我的支出是否少于我的收入？';
			case 'stats.by_periods': return '按时间段';
			case 'stats.by_categories': return '按类别';
			case 'stats.by_tags': return '按标签';
			case 'stats.distribution': return '分布';
			case 'stats.finance_health_resume': return '总结';
			case 'stats.finance_health_breakdown': return '分解';
			case 'icon_selector.name': return '名称';
			case 'icon_selector.icon': return '图标';
			case 'icon_selector.color': return '颜色';
			case 'icon_selector.select_icon': return '选择一个图标';
			case 'icon_selector.select_color': return '选择一种颜色';
			case 'icon_selector.current_color_selection': return '当前选择';
			case 'icon_selector.custom_color': return '自定义颜色';
			case 'icon_selector.select_account_icon': return '确认您的账户';
			case 'icon_selector.select_category_icon': return '确认您的类别';
			case 'icon_selector.scopes.transport': return '交通';
			case 'icon_selector.scopes.money': return '金钱';
			case 'icon_selector.scopes.food': return '食物';
			case 'icon_selector.scopes.medical': return '医疗';
			case 'icon_selector.scopes.entertainment': return '休闲';
			case 'icon_selector.scopes.technology': return '科技';
			case 'icon_selector.scopes.other': return '其它';
			case 'icon_selector.scopes.logos_financial_institutions': return '金融机构';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易',
				other: '交易',
			);
			case 'transaction.create': return '新交易';
			case 'transaction.new_income': return '新收入';
			case 'transaction.new_expense': return '新开支';
			case 'transaction.new_success': return '交易创建成功';
			case 'transaction.edit': return '编辑交易';
			case 'transaction.edit_success': return '交易编辑成功';
			case 'transaction.edit_multiple': return '批量编辑交易';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x}笔交易编辑成功';
			case 'transaction.duplicate': return '复制交易';
			case 'transaction.duplicate_short': return '复制';
			case 'transaction.duplicate_warning_message': return '将在同一日期创建一笔完全相同的交易，继续吗？';
			case 'transaction.duplicate_success': return '交易复制成功';
			case 'transaction.delete': return '删除交易';
			case 'transaction.delete_warning_message': return '此操作无法撤回。将重新计算您账户的当前余额及其它所有统计数据';
			case 'transaction.delete_success': return '交易删除成功';
			case 'transaction.delete_multiple': return '批量删除交易';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => '此操作无法撤回，并且将删除${x}笔交易。将重新计算您账户的当前余额及其它所有统计数据';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x}笔交易删除成功';
			case 'transaction.details': return '操作详情';
			case 'transaction.next_payments.accept': return '接受';
			case 'transaction.next_payments.skip': return '跳过';
			case 'transaction.next_payments.skip_success': return '已成果跳过交易';
			case 'transaction.next_payments.skip_dialog_title': return '跳过交易';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => '此操作无法撤回。我们将把下次的日期移动至${date}';
			case 'transaction.next_payments.accept_today': return '今天接受';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => '在要求的日期 (${date}) 接受';
			case 'transaction.next_payments.accept_dialog_title': return '接受交易';
			case 'transaction.next_payments.accept_dialog_msg_single': return '此交易的新状态将为null。您可以随时重新编辑此交易的状态';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => '此操作将建立日期为 ${date} 的新交易。您可以在交易页面查看此交易的详情';
			case 'transaction.next_payments.recurrent_rule_finished': return '循环规则已完成，没有更多的支付！';
			case 'transaction.list.empty': return '未发现需要显示的交易。请先在 app 中添加一些交易，下次再来查看';
			case 'transaction.list.searcher_placeholder': return '按类别、描述等搜索';
			case 'transaction.list.searcher_no_results': return '未找到符合搜索条件的交易';
			case 'transaction.list.loading': return '正在加载更多的交易……';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '已选择 ${n}',
				other: '已选择 ${n}',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '已选择 ${n} 笔交易',
				other: '已选择 ${n} 笔交易',
			);
			case 'transaction.list.bulk_edit.dates': return '批量编辑日期';
			case 'transaction.list.bulk_edit.categories': return '批量编辑类别';
			case 'transaction.list.bulk_edit.status': return '批量编辑状态';
			case 'transaction.filters.from_value': return '最小金额';
			case 'transaction.filters.to_value': return '最大金额';
			case 'transaction.filters.from_value_def': return ({required Object x}) => '从 ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => '到 ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => '从 ${date}';
			case 'transaction.filters.to_date_def': return ({required Object date}) => '到 ${date}';
			case 'transaction.form.validators.zero': return '交易数额不应为零';
			case 'transaction.form.validators.date_max': return '所选日期晚于当前日期。交易将新增为待办';
			case 'transaction.form.validators.date_after_account_creation': return '无法创建早于账户创建日期的交易';
			case 'transaction.form.validators.negative_transfer': return '转账数额不应为负数';
			case 'transaction.form.validators.transfer_between_same_accounts': return '来源于目标账户不应相同';
			case 'transaction.form.title': return '交易标题';
			case 'transaction.form.title_short': return '标题';
			case 'transaction.form.value': return '数额';
			case 'transaction.form.tap_to_see_more': return '点击查看更多详情';
			case 'transaction.form.no_tags': return '-- 无标签 --';
			case 'transaction.form.description': return '描述';
			case 'transaction.form.description_info': return '点击此处输入有关此交易的详细描述';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => '汇率为${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return '交易日';
			case 'transaction.reversed.title': return '逆向交易';
			case 'transaction.reversed.title_short': return '逆向交易';
			case 'transaction.reversed.description_for_expenses': return '尽管是一个开支交易，但其数额为正值。此类交易可用于表示已记录开支的返还，例如退款或偿还债务。';
			case 'transaction.reversed.description_for_incomes': return '尽管是一个收入交易，但其数额为负值。此类交易可用于作废或更正收入记录中的错误，以反映退款或记录偿还债务。';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '状态',
				other: '状态',
			);
			case 'transaction.status.display_long': return '交易状态';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status}交易';
			case 'transaction.status.none': return '无状态';
			case 'transaction.status.none_descr': return '没有特定的状态';
			case 'transaction.status.reconciled': return '已核对';
			case 'transaction.status.reconciled_descr': return '此交易已被核实，与您银行的一个真实交易相对应';
			case 'transaction.status.unreconciled': return '未核实';
			case 'transaction.status.unreconciled_descr': return '此交易尚未被核实，因此尚未出现在您的真实银行账户中。然而，在 Monekin 中，它将被用于计算余额和其它统计数据';
			case 'transaction.status.pending': return '待办';
			case 'transaction.status.pending_descr': return '此交易正在等待处理，因此在计算余额和其它统计数据时暂时不会被考虑';
			case 'transaction.status.voided': return '作废';
			case 'transaction.status.voided_descr': return '由于付款错误或其它原因造成的作废或取消的交易。在计算余额和其它统计数据时不会被考虑';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易类型',
				other: '交易类型',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '收入',
				other: '收入',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '支出',
				other: '支出',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '转账',
				other: '转账',
			);
			case 'transfer.display': return '转账';
			case 'transfer.transfers': return '转账';
			case 'transfer.transfer_to': return ({required Object account}) => '转账至 ${account}';
			case 'transfer.create': return '转账';
			case 'transfer.need_two_accounts_warning_header': return '哎呀！';
			case 'transfer.need_two_accounts_warning_message': return '至少需要两个账户才能执行此操作。如果您需要调整或编辑此账户的当前余额，请点击编辑按钮';
			case 'transfer.form.from': return '转出账户';
			case 'transfer.form.to': return '转入账户';
			case 'transfer.form.value_in_destiny.title': return '转账数额';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount} 至目标账户';
			case 'recurrent_transactions.title': return '循环交易';
			case 'recurrent_transactions.title_short': return '循环交易';
			case 'recurrent_transactions.empty': return '您似乎没有任何循环交易。创建一个每周、每月或每年的循环交易，它会在此显示';
			case 'recurrent_transactions.total_expense_title': return '每一周期的总开支';
			case 'recurrent_transactions.total_expense_descr': return '* 不考虑每一循环的起止日期';
			case 'recurrent_transactions.details.title': return '循环交易';
			case 'recurrent_transactions.details.descr': return '此交易的未来的动作显示如下。您可以接受第一个动作或跳过此动作';
			case 'recurrent_transactions.details.last_payment_info': return '此动作是循环规则的最后一个，因此当确认此动作后，这一循环规则将被自动删除';
			case 'recurrent_transactions.details.delete_header': return '删除循环交易';
			case 'recurrent_transactions.details.delete_message': return '此操作无法撤回，不会影响您已确认/付款的交易';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => '延迟 ${x} 天';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => '${x} 天内';
			case 'account.details': return '账户详情';
			case 'account.date': return '开启日期';
			case 'account.close_date': return '关闭日期';
			case 'account.reopen': return '重新开启账户';
			case 'account.reopen_short': return '重开账户';
			case 'account.reopen_descr': return '您确定要重新开启此账户吗？';
			case 'account.balance': return '账户余额';
			case 'account.n_transactions': return '交易数量';
			case 'account.add_money': return '增加金额';
			case 'account.withdraw_money': return '减少金额';
			case 'account.no_accounts': return '未发现应当显示的交易。请点击底部的 \'+\' 按钮新增一个交易';
			case 'account.types.title': return '账户类型';
			case 'account.types.warning': return '账户类型一旦选择，以后将无法更改';
			case 'account.types.normal': return '普通账户';
			case 'account.types.normal_descr': return '用于记录日常财务。这是最普通的账户，您可以添加支出、收入……';
			case 'account.types.saving': return '储蓄账户';
			case 'account.types.saving_descr': return '您只能从此账户中向其它账户中转入/转出（而无法用于消费开支）。非常适合用于存钱';
			case 'account.form.name': return '账户名称';
			case 'account.form.name_placeholder': return '例如：储蓄账户';
			case 'account.form.notes': return '备注';
			case 'account.form.notes_placeholder': return '输入有关此账户的一些备注/描述';
			case 'account.form.initial_balance': return '初始余额';
			case 'account.form.current_balance': return '当前余额';
			case 'account.form.create': return '创建账户';
			case 'account.form.edit': return '编辑账户';
			case 'account.form.currency_not_found_warn': return '您没有此货币的汇率信息。将使用默认汇率 1.0。您可以在设置中修改';
			case 'account.form.already_exists': return '此账户名已存在，请起一个新的账户名';
			case 'account.form.tr_before_opening_date': return '此账户中有早于开户日期的交易';
			case 'account.form.iban': return '国际银行账户号码（IBAN）';
			case 'account.form.swift': return '银行识别码（SWIFT）';
			case 'account.delete.warning_header': return '删除账户？';
			case 'account.delete.warning_text': return '此操作将删除此账户及其所有交易';
			case 'account.delete.success': return '账户删除成功';
			case 'account.close.title': return '关闭账户';
			case 'account.close.title_short': return '关闭';
			case 'account.close.warn': return '此账户将不再出现在特定列表中，并且您无法在此账户中创建晚于以下日期的交易。此操作不会影响任何交易或余额，您也可以随时重新开启此账户。';
			case 'account.close.should_have_zero_balance': return '此账户中的当前余额必须为 0 才可关闭。请在继续之前编辑账户';
			case 'account.close.should_have_no_transactions': return '此账户在指定的关闭日期之后仍有交易。请删除它们或编辑账户关闭日期，然后再继续';
			case 'account.close.success': return '账户关闭成功';
			case 'account.close.unarchive_succes': return '账户已成功重新开启';
			case 'account.select.one': return '选择一个账户';
			case 'account.select.all': return '所有账户';
			case 'account.select.multiple': return '选择多个账户';
			case 'currencies.currency_converter': return '货币换算';
			case 'currencies.currency': return '货币';
			case 'currencies.currency_manager': return '货币管理';
			case 'currencies.currency_manager_descr': return '设置您的货币及其与其他货币的汇率';
			case 'currencies.preferred_currency': return '默认货币';
			case 'currencies.change_preferred_currency_title': return '更改默认货币';
			case 'currencies.change_preferred_currency_msg': return '从现在起，所有统计数据和预算都将以此货币显示。账户和交易将保留其原有货币单位。如果您执行此操作，所有保存的汇率都将被删除。您想继续吗？';
			case 'currencies.form.equal_to_preferred_warn': return '货币不能与用户货币相同';
			case 'currencies.form.specify_a_currency': return '请指定货币';
			case 'currencies.form.add': return '添加汇率';
			case 'currencies.form.add_success': return '汇率添加成功';
			case 'currencies.form.edit': return '编辑汇率';
			case 'currencies.form.edit_success': return '汇率编辑成功';
			case 'currencies.delete_all_success': return '删除汇率成功';
			case 'currencies.historical': return '历史汇率';
			case 'currencies.exchange_rate': return '汇率';
			case 'currencies.exchange_rates': return '汇率';
			case 'currencies.empty': return '如果您有账户使用默认货币以外的货币，请在此处添加汇率，以获得更准确的图表';
			case 'currencies.select_a_currency': return '选择货币';
			case 'currencies.search': return '按名称或货币代码搜索';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '标签',
				other: '标签',
			);
			case 'tags.form.name': return '标签名';
			case 'tags.form.description': return '描述';
			case 'tags.select.title': return '选择标签';
			case 'tags.select.all': return '所有标签';
			case 'tags.empty_list': return '您还没有创建任何标签。标签和类别是对您的动作进行分类的好方法';
			case 'tags.without_tags': return '没有标签';
			case 'tags.add': return '添加标签';
			case 'tags.create': return '创建标签';
			case 'tags.create_success': return '标签创建成功';
			case 'tags.already_exists': return '此标签名已存在。请起一个新的标签名';
			case 'tags.edit': return '编辑标签';
			case 'tags.edit_success': return '标签编辑成功';
			case 'tags.delete_success': return '类别删除成功';
			case 'tags.delete_warning_header': return '删除标签？';
			case 'tags.delete_warning_message': return '此操作不会删除具有此标签的交易。';
			case 'categories.unknown': return '未知类别';
			case 'categories.create': return '创建类别';
			case 'categories.create_success': return '类别创建成功';
			case 'categories.new_category': return '新类别';
			case 'categories.already_exists': return '此类别名已存在。请起一个新的类别名';
			case 'categories.edit': return '编辑类别';
			case 'categories.edit_success': return '类别编辑成功';
			case 'categories.name': return '类别名称';
			case 'categories.type': return '类别类型';
			case 'categories.both_types': return '混合类型';
			case 'categories.subcategories': return '子类别';
			case 'categories.subcategories_add': return '新增子类别';
			case 'categories.make_parent': return '移动至类别';
			case 'categories.make_child': return '移动成为子类别';
			case 'categories.make_child_warning1': return ({required Object destiny}) => '此类别及其子类别将成为<b>${destiny}</b>的子类别。';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => '它们的交易<b>(${x})</b>将被移至<b>${destiny}</b>类别中创建的新子类别。';
			case 'categories.make_child_success': return '子类别创建成功';
			case 'categories.merge': return '与另一个类别合并';
			case 'categories.merge_warning1': return ({required Object from, required Object x, required Object destiny}) => '与类别<b>${from}</b>相关的所有交易 (${x}) 将移至类别<b>${destiny}</b>';
			case 'categories.merge_warning2': return ({required Object from}) => '类别<b>${from}</b>将被无法撤回地删除。 ';
			case 'categories.merge_success': return '类别合并成功';
			case 'categories.delete_success': return '类别删除成功';
			case 'categories.delete_warning_header': return '删除类别？';
			case 'categories.delete_warning_message': return ({required Object x}) => '此操作将无法撤回地删除与此类别相关的所有交易<b>(${x})</b>。';
			case 'categories.select.title': return '选择类别';
			case 'categories.select.select_one': return '选择一个类别';
			case 'categories.select.select_subcategory': return '选择一个子类别';
			case 'categories.select.without_subcategory': return '没有子类别';
			case 'categories.select.all': return '所有类别';
			case 'categories.select.all_short': return '全部';
			case 'budgets.title': return '预算';
			case 'budgets.repeated': return '重复的';
			case 'budgets.one_time': return '单次的';
			case 'budgets.annual': return '年度';
			case 'budgets.week': return '每周';
			case 'budgets.month': return '每月';
			case 'budgets.actives': return '活跃';
			case 'budgets.pending': return '待办';
			case 'budgets.finish': return '完成';
			case 'budgets.from_budgeted': return '预算为';
			case 'budgets.days_left': return '天还剩';
			case 'budgets.days_to_start': return '天开始';
			case 'budgets.since_expiration': return '自到期日起的天数';
			case 'budgets.no_budgets': return '未发现应当显示的预算。请点击底部的 \'+\' 按钮新增一个预算';
			case 'budgets.delete': return '删除预算';
			case 'budgets.delete_warning': return '此操作无法撤回。此预算中的类别和交易不会被删除';
			case 'budgets.form.title': return '创建预算';
			case 'budgets.form.name': return '预算名称';
			case 'budgets.form.value': return '预算额度';
			case 'budgets.form.create': return '创建预算';
			case 'budgets.form.edit': return '编辑预算';
			case 'budgets.form.negative_warn': return '预算额度不能为负数';
			case 'budgets.details.title': return '预算详情';
			case 'budgets.details.statistics': return '统计数据';
			case 'budgets.details.budget_value': return '预算';
			case 'budgets.details.expend_diary_left': return ({required Object remainingDays, required Object dailyAmount}) => '在未来 ${remainingDays} 天中，您每天可以花费 ${dailyAmount}';
			case 'budgets.details.expend_evolution': return '支出变化';
			case 'budgets.details.no_transactions': return '看来您还没有与此预算相关的任何支出';
			case 'backup.export.title': return '导出您的数据';
			case 'backup.export.title_short': return '导出';
			case 'backup.export.all': return '完整备份';
			case 'backup.export.all_descr': return '导出您的所有数据（账户、交易、预算、设置……）。随时再次导入它们，您就不会丟失任何內容。';
			case 'backup.export.transactions': return '交易备份';
			case 'backup.export.transactions_descr': return '以 CSV 格式导出您的交易，以便您可以在其它程序或 app 中更轻松地分析。';
			case 'backup.export.description': return '以不同格式下载（导出）数据';
			case 'backup.export.dialog_title': return '保存/发送文件';
			case 'backup.export.success': return ({required Object x}) => '文件已成功保存/下载至 ${x}';
			case 'backup.export.error': return '下载文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员';
			case 'backup.import.title': return '导入您的数据';
			case 'backup.import.title_short': return '导入';
			case 'backup.import.restore_backup': return '恢复备份';
			case 'backup.import.restore_backup_descr': return '导入一个从 Monekin 保存的数据库。此操作将用新数据覆盖当前 app 数据';
			case 'backup.import.restore_backup_warn_description': return '导入新数据库时，您将丟失 app 中当前保存的所有数据。建议在继续之前进行备份。请勿在此上传任何来源不明的文件，仅上传您之前从 Monekin 下载的文件';
			case 'backup.import.restore_backup_warn_title': return '覆盖所有数据';
			case 'backup.import.select_other_file': return '选择其它文件';
			case 'backup.import.tap_to_select_file': return '点击选择文件';
			case 'backup.import.manual_import.title': return '手动导入';
			case 'backup.import.manual_import.descr': return '手动从 .csv 文件导入交易';
			case 'backup.import.manual_import.default_account': return '默认账户';
			case 'backup.import.manual_import.remove_default_account': return '删除默认账户';
			case 'backup.import.manual_import.default_category': return '默认类别';
			case 'backup.import.manual_import.select_a_column': return '从 .csv 中选择一列';
			case 'backup.import.manual_import.steps.0': return '选择您的文件';
			case 'backup.import.manual_import.steps.1': return '数额列';
			case 'backup.import.manual_import.steps.2': return '账户列';
			case 'backup.import.manual_import.steps.3': return '类别列';
			case 'backup.import.manual_import.steps.4': return '日期列';
			case 'backup.import.manual_import.steps.5': return '其它列';
			case 'backup.import.manual_import.steps_descr.0': return '从您的设备中选择一个 .csv 文件。确保它的第一行描述了每列的名称。';
			case 'backup.import.manual_import.steps_descr.1': return '选择每笔交易数额的列。负值表示支出，正值表示收入。.表示小数点分隔符。';
			case 'backup.import.manual_import.steps_descr.2': return '选择每笔交易所属账户的列。您也可以选择默认账户，以防我们找不到您想要的账户。如果未指定默认账户，我们将建立一个同名账户。';
			case 'backup.import.manual_import.steps_descr.3': return '选择交易类别名称所在的列。您必须指定一个默认类别，以便我们在找不到此类别时，将默认类别分配给交易。';
			case 'backup.import.manual_import.steps_descr.4': return '选择每笔交易日期的列。如果未指定，所有交易将使用当前日期。';
			case 'backup.import.manual_import.steps_descr.5': return '选择其它交易属性的数据列';
			case 'backup.import.manual_import.success': return ({required Object x}) => '成功导入 ${x} 笔交易';
			case 'backup.import.success': return '导入成功';
			case 'backup.import.cancelled': return '导入被用户取消';
			case 'backup.import.error': return '导入文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员。';
			case 'backup.about.title': return '有关您的数据库的信息';
			case 'backup.about.create_date': return '创建日期';
			case 'backup.about.modify_date': return '上一次更改';
			case 'backup.about.last_backup': return '上次备份';
			case 'backup.about.size': return '文件大小';
			case 'settings.title_long': return '设置和外观';
			case 'settings.title_short': return '设置';
			case 'settings.description': return 'app 主题、语言和其它常规设置';
			case 'settings.edit_profile': return '编辑个人资料';
			case 'settings.lang_section': return '语言和文字';
			case 'settings.lang_title': return 'app 语言/Language';
			case 'settings.lang_descr': return 'app 中显示文字的语言';
			case 'settings.lang_help': return '如果您想合作翻译此 app，您可参考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我们的指南</a>';
			case 'settings.locale': return '地区';
			case 'settings.locale_descr': return '设置用于日期、数字的格式……';
			case 'settings.locale_warn': return '更改区域时 app 将更新';
			case 'settings.first_day_of_week': return '一周的第一天';
			case 'settings.theme_and_colors': return '主题和颜色';
			case 'settings.theme': return '主题';
			case 'settings.theme_auto': return '系统';
			case 'settings.theme_light': return '明亮主题';
			case 'settings.theme_dark': return '黑暗主题';
			case 'settings.amoled_mode': return 'AMOLED 模式';
			case 'settings.amoled_mode_descr': return '尽可能使用纯黑色壁纸。在 AMOLED 屏幕的设备上能略微省电';
			case 'settings.dynamic_colors': return '动态色彩';
			case 'settings.dynamic_colors_descr': return '尽可能使用系统强调色';
			case 'settings.accent_color': return '强调色';
			case 'settings.accent_color_descr': return '选择 app 用来强调介面某些部分的颜色';
			case 'settings.security.title': return '安全';
			case 'settings.security.private_mode_at_launch': return '启动隐私模式';
			case 'settings.security.private_mode_at_launch_descr': return '默认以隐私模式启动 app ';
			case 'settings.security.private_mode': return '隐私模式';
			case 'settings.security.private_mode_descr': return '隐藏所有金额';
			case 'settings.security.private_mode_activated': return '隐私模式已启用';
			case 'settings.security.private_mode_deactivated': return '隐私模式已禁用';
			case 'more.title': return '更多';
			case 'more.title_long': return '更多';
			case 'more.data.display': return '数据';
			case 'more.data.display_descr': return '导出和导入您的数据，这样您不会丟失任何东西';
			case 'more.data.delete_all': return '删除我的数据';
			case 'more.data.delete_all_header1': return '停下⚠️⚠️';
			case 'more.data.delete_all_message1': return '您确定要继续吗？您的所有数据将永久删除且无法恢复';
			case 'more.data.delete_all_header2': return '最后一步⚠️⚠️';
			case 'more.data.delete_all_message2': return '删除账户后，您将删除所有保存的个人数据。您的账户、交易、预算和类别将被删除且无法恢复。您同意吗？';
			case 'more.about_us.display': return 'app 信息';
			case 'more.about_us.description': return '查看有关 Monekin 的条款和其它相关信息。与社区取得联系以报告错误、留下建议……';
			case 'more.about_us.legal.display': return '法律信息';
			case 'more.about_us.legal.privacy': return '隐私权政策';
			case 'more.about_us.legal.terms': return '使用条款';
			case 'more.about_us.legal.licenses': return '许可证';
			case 'more.about_us.project.display': return '项目';
			case 'more.about_us.project.contributors': return '合作者';
			case 'more.about_us.project.contributors_descr': return '所有让 Monekin 成长的开发者';
			case 'more.about_us.project.contact': return '联系我们';
			case 'more.help_us.display': return '帮助我们';
			case 'more.help_us.description': return '了解如何帮助 Monekin 变得越来越好';
			case 'more.help_us.rate_us': return '评价我们';
			case 'more.help_us.rate_us_descr': return '欢迎所有分数和评价！';
			case 'more.help_us.share': return '分享 Monekin';
			case 'more.help_us.share_descr': return '与朋友和家人分享我们的 app ';
			case 'more.help_us.share_text': return 'Monekin！最好的个人理财 app 。此处下载';
			case 'more.help_us.thanks': return '谢谢您！';
			case 'more.help_us.thanks_long': return '您对 Monekin 和其它大大小小的开源项目的贡献成就了这一伟大项目。感谢您花时间做出贡献。';
			case 'more.help_us.donate': return '捐款';
			case 'more.help_us.donate_descr': return '通过您的捐款，您将帮助此 app 持续改进完善。还有什么比请我喝一杯咖啡更好的感谢方式呢？';
			case 'more.help_us.donate_success': return '捐款已完成。非常感谢您的贡献！❤️';
			case 'more.help_us.donate_err': return '糟糕！接收您的付款时出现错误';
			case 'more.help_us.report': return '报告错误，留下建议……';
			default: return null;
		}
	}
}


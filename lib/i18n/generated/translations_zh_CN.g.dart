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
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	@override 
	TranslationsZhCn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhCn(meta: meta ?? this.$meta);

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
	@override late final _TranslationsTargetTimelineStatusesZhCn target_timeline_statuses = _TranslationsTargetTimelineStatusesZhCn._(_root);
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
	@override String get details => '细节';
	@override String get balance => '余额';
	@override String get account => '账户';
	@override String get accounts => '账户';
	@override String get categories => '类别';
	@override String get category => '类别';
	@override String get today => '今天';
	@override String get yesterday => '昨天';
	@override String get filters => '筛选';
	@override String get empty_warn => '喔！这里什么都没有';
	@override String get search_no_results => '没有符合您搜索条件的商品';
	@override String get insufficient_data => '数据不足';
	@override String get show_more_fields => '显示更多';
	@override String get show_less_fields => '显示更少';
	@override String get tap_to_search => '点击以搜索';
	@override late final _TranslationsGeneralLeaveWithoutSavingZhCn leave_without_saving = _TranslationsGeneralLeaveWithoutSavingZhCn._(_root);
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
	@override String get welcome_footer => '登录即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隐私策略</a>和此应用的<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>使用条款</a>';
	@override String get offline_descr_title => '本地账户：';
	@override String get offline_descr => '您的数据只会存储于此设备中，只要您不卸载应用或更换手机，数据就会保持安全。为避免数据丢失，建议定期从应用设置中备份数据。';
	@override String get offline_start => '开始使用本地账户';
	@override String get sl1_title => '选择您的货币';
	@override String get sl1_descr => '您的默认货币会被用于报表和图表中。您之后可以随时更改默认货币和应用语言';
	@override String get sl2_title => '安全、隐私、可靠';
	@override String get sl2_descr => '您的数据只属于您。我们直接将您的信息存储于此设备，不会连接外部服务器。因此您可以在离线时继续使用此应用';
	@override String get sl2_descr2 => '此外，此应用的源代码是公开的，任何人都可以查看它如何运行并贡献自己的力量';
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
	@override String get should_create_account_header => '哎呀!';
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
	@override String get custom_color => '自定义颜色';
	@override String get current_color_selection => '当前选择';
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
	@override String get currency_settings => '货币设置';
	@override String get currency_manager => '货币管理';
	@override String get currency_manager_descr => '设置您的货币及其与其他货币的汇率';
	@override String get preferred_currency => '默认货币';
	@override String get tap_to_change_preferred_currency => '点击即可更改';
	@override String get change_preferred_currency_title => '更改默认货币';
	@override String get change_preferred_currency_msg => '从现在起，所有统计数据和预算都将以此货币显示。账户和交易将保留其原有货币单位。如果您执行此操作，所有保存的汇率都将被删除。您想继续吗？';
	@override late final _TranslationsCurrenciesExchangeRateFormZhCn exchange_rate_form = _TranslationsCurrenciesExchangeRateFormZhCn._(_root);
	@override late final _TranslationsCurrenciesTypesZhCn types = _TranslationsCurrenciesTypesZhCn._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormZhCn currency_form = _TranslationsCurrenciesCurrencyFormZhCn._(_root);
	@override String get delete_all_success => '删除汇率成功';
	@override String get historical => '历史汇率';
	@override String get historical_empty => '没有找到该货币的历史汇率';
	@override String get exchange_rate => '汇率';
	@override String get exchange_rates => '汇率';
	@override String get min_exchange_rate => '最低汇率';
	@override String get max_exchange_rate => '最高汇率';
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
	@override late final _TranslationsBudgetsTargetTimelineStatusesZhCn target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesZhCn._(_root);
	@override late final _TranslationsBudgetsProgressZhCn progress = _TranslationsBudgetsProgressZhCn._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesZhCn implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get active => '进行中';
	@override String get past => '已结束';
	@override String get future => '未开始';
}

// Path: backup
class _TranslationsBackupZhCn implements TranslationsBackupEn {
	_TranslationsBackupZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => '未选择文件';
	@override String get no_directory_selected => '未选择目录';
	@override late final _TranslationsBackupExportZhCn export = _TranslationsBackupExportZhCn._(_root);
	@override late final _TranslationsBackupImportZhCn import = _TranslationsBackupImportZhCn._(_root);
	@override late final _TranslationsBackupAboutZhCn about = _TranslationsBackupAboutZhCn._(_root);
}

// Path: settings
class _TranslationsSettingsZhCn implements TranslationsSettingsEn {
	_TranslationsSettingsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title_long => '设置与自定义';
	@override String get title_short => '设置';
	@override String get description => '主题、语言、数据等';
	@override String get edit_profile => '编辑个人资料';
	@override late final _TranslationsSettingsGeneralZhCn general = _TranslationsSettingsGeneralZhCn._(_root);
	@override late final _TranslationsSettingsSecurityZhCn security = _TranslationsSettingsSecurityZhCn._(_root);
	@override late final _TranslationsSettingsTransactionsZhCn transactions = _TranslationsSettingsTransactionsZhCn._(_root);
	@override late final _TranslationsSettingsAppearanceZhCn appearance = _TranslationsSettingsAppearanceZhCn._(_root);
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

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingZhCn implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '不保存就离开？';
	@override String get message => '您有未保存的更改，确定要离开而不保存它们吗？';
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
	@override String get all => '所有交易';
	@override String get empty => '未发现需要显示的交易。请先在应用中添加一些交易，下次再来查看';
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
	@override String get title => '交易过滤器';
	@override String get from_value => '最小金额';
	@override String get to_value => '最大金额';
	@override String from_value_def({required Object x}) => '从 ${x}';
	@override String to_value_def({required Object x}) => '到 ${x}';
	@override String from_date_def({required Object date}) => '从 ${date}';
	@override String to_date_def({required Object date}) => '到 ${date}';
	@override String get reset => '重置过滤器';
	@override late final _TranslationsTransactionFiltersSavedZhCn saved = _TranslationsTransactionFiltersSavedZhCn._(_root);
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

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormZhCn implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => '货币不能与用户货币相同';
	@override String get override_existing_warn => '该货币在该日期的汇率已存在。如果继续，前一个将会被覆盖';
	@override String get specify_a_currency => '请指定货币';
	@override String get add => '添加汇率';
	@override String get add_success => '汇率添加成功';
	@override String get edit => '编辑汇率';
	@override String get edit_success => '汇率编辑成功';
	@override String get remove_all => '删除所有汇率';
	@override String get remove_all_warning => '此操作不可逆转，并将删除该货币的所有汇率';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesZhCn implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get display => '货币类型';
	@override String get fiat => '菲亚特';
	@override String get crypto => '加密货币';
	@override String get other => '其他';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormZhCn implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get name => '显示名称';
	@override String get code => '货币代码';
	@override String get symbol => '象征';
	@override String get decimal_digits => '小数位';
	@override String get create => '创建货币';
	@override String get create_success => '货币创建成功';
	@override String get edit => '编辑货币';
	@override String get edit_success => '货币编辑成功';
	@override String get delete => '删除货币';
	@override String get delete_success => '币种删除成功';
	@override String get already_exists => '具有此代码的货币已存在。您可能想要编辑它';
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
	@override String get create_success => '预算创建成功';
	@override String get edit => '编辑预算';
	@override String get edit_success => '预算编辑成功';
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
	@override String get expend_evolution => '支出变化';
	@override String get no_transactions => '看来您还没有与此预算相关的任何支出';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesZhCn implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get active => '当前预算';
	@override String get past => '过去预算';
	@override String get future => '未来预算';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressZhCn implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsZhCn labels = _TranslationsBudgetsProgressLabelsZhCn._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionZhCn description = _TranslationsBudgetsProgressDescriptionZhCn._(_root);
}

// Path: backup.export
class _TranslationsBackupExportZhCn implements TranslationsBackupExportEn {
	_TranslationsBackupExportZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '导出您的数据';
	@override String get title_short => '导出';
	@override String get type_of_export => '出口类型';
	@override String get other_options => '选项';
	@override String get all => '完整备份';
	@override String get all_descr => '导出您的所有数据（账户、交易、预算、设置……）。随时再次导入它们，您就不会丟失任何內容。';
	@override String get transactions => '交易备份';
	@override String get transactions_descr => '以 CSV 格式导出您的交易，以便您可以在其它程序或应用中更轻松地分析。';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '1 笔交易要导出',
		other: '要导出的 ${n} 笔交易',
	);
	@override String get description => '以不同格式下载（导出）数据';
	@override String get send_file => '发送文件';
	@override String get see_folder => '查看文件夹';
	@override String success({required Object x}) => '文件已成功保存/下载至 ${x}';
	@override String get error => '下载文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员';
	@override String get dialog_title => '保存/发送文件';
}

// Path: backup.import
class _TranslationsBackupImportZhCn implements TranslationsBackupImportEn {
	_TranslationsBackupImportZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '导入您的数据';
	@override String get title_short => '导入';
	@override String get restore_backup => '恢复备份';
	@override String get restore_backup_descr => '导入一个从 Monekin 保存的数据库。此操作将用新数据覆盖当前应用数据';
	@override String get restore_backup_warn_description => '导入新数据库时，您将丟失应用中当前保存的所有数据。建议在继续之前进行备份。请勿在此上传任何来源不明的文件，仅上传您之前从 Monekin 下载的文件';
	@override String get restore_backup_warn_title => '覆盖所有数据';
	@override String get select_other_file => '选择其它文件';
	@override String get tap_to_select_file => '点击选择文件';
	@override late final _TranslationsBackupImportManualImportZhCn manual_import = _TranslationsBackupImportManualImportZhCn._(_root);
	@override String get success => '导入成功';
	@override String get error => '导入文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员。';
	@override String get cancelled => '导入被用户取消';
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

// Path: settings.general
class _TranslationsSettingsGeneralZhCn implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menu_title => '常规设置';
	@override String get menu_descr => '语言、隐私等';
	@override late final _TranslationsSettingsGeneralLanguageZhCn language = _TranslationsSettingsGeneralLanguageZhCn._(_root);
	@override late final _TranslationsSettingsGeneralLocaleZhCn locale = _TranslationsSettingsGeneralLocaleZhCn._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityZhCn implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '安全';
	@override String get private_mode_at_launch => '启动隐私模式';
	@override String get private_mode_at_launch_descr => '默认以隐私模式启动此应用';
	@override String get private_mode => '隐私模式';
	@override String get private_mode_descr => '隐藏所有金额';
	@override String get private_mode_activated => '隐私模式已启用';
	@override String get private_mode_deactivated => '隐私模式已禁用';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsZhCn implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menu_title => '交易';
	@override String get menu_descr => '配置交易的行为';
	@override String get title => '交易设置';
	@override late final _TranslationsSettingsTransactionsSwipeActionsZhCn swipe_actions = _TranslationsSettingsTransactionsSwipeActionsZhCn._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesZhCn default_values = _TranslationsSettingsTransactionsDefaultValuesZhCn._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeZhCn default_type = _TranslationsSettingsTransactionsDefaultTypeZhCn._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceZhCn implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menu_title => '主题与风格';
	@override String get menu_descr => '主题选择、颜色以及与应用程序外观相关的其他内容';
	@override String get theme_and_colors => '主题和颜色';
	@override late final _TranslationsSettingsAppearanceThemeZhCn theme = _TranslationsSettingsAppearanceThemeZhCn._(_root);
	@override String get amoled_mode => 'AMOLED 模式';
	@override String get amoled_mode_descr => '尽可能使用纯黑色壁纸。在 AMOLED 屏幕的设备上能略微省电';
	@override String get dynamic_colors => '动态色彩';
	@override String get dynamic_colors_descr => '尽可能使用系统强调色';
	@override String get accent_color => '强调色';
	@override String get accent_color_descr => '选择应用中用来强调介面某些部分的颜色';
	@override String get text => '文本';
	@override String get font => '字体';
	@override String get font_platform => '平台';
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
	@override String get display => '应用信息';
	@override String get description => '查找 Monekin 的条款、重要信息，并通过报告错误或分享想法与我们联系';
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
	@override String get share_descr => '与朋友和家人分享我们的应用';
	@override String get share_text => 'Monekin！最好的个人理财应用 。此处下载';
	@override String get thanks => '谢谢您！';
	@override String get thanks_long => '您对 Monekin 和其它大大小小的开源项目的贡献成就了这一伟大项目。感谢您花时间做出贡献。';
	@override String get donate => '捐款';
	@override String get donate_descr => '通过您的捐款，您将帮助此应用持续改进完善。还有什么比请我喝一杯咖啡更好的感谢方式呢？';
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

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedZhCn implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '已保存的过滤器';
	@override String get new_title => '新建过滤器';
	@override String get edit_title => '编辑过滤器';
	@override String get name_label => '过滤器名称';
	@override String get name_hint => '我的自定义过滤器';
	@override String get save_dialog_title => '保存过滤器';
	@override String get save_tooltip => '保存当前过滤器';
	@override String get load_tooltip => '加载已保存的过滤器';
	@override String get empty_title => '未找到已保存的过滤器';
	@override String get empty_description => '在此保存过滤器以便稍后快速访问。';
	@override String get save_success => '筛选器保存成功';
	@override String get delete_success => '筛选器删除成功';
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

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsZhCn implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => '正常';
	@override String get active_overspending => '超支';
	@override String get success => '已达成';
	@override String get fail => '超出预算';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionZhCn implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object remainingDays, required Object dailyAmount}) => '在剩余的 ${remainingDays} 天里，您每天可以花费 ${dailyAmount}';
	@override String active_overspending({required Object remainingDays, required Object dailyAmount}) => '为了回到正轨，您应该在剩余的 ${remainingDays} 天里将每天的支出限制在 ${dailyAmount}';
	@override String active_exceeded({required Object amount}) => '您已经超出了预算限额 ${amount}。如果您找不到此预算的任何收入，您应该在其剩余期间停止支出';
	@override String get success => '干得好！该预算已成功完成。继续创建预算以管理您的支出';
	@override String fail({required Object amount}) => '您超出了预算 ${amount}。下次请更加小心！';
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

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageZhCn implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get section => '语言和文字';
	@override String get title => '语言/Language';
	@override String get descr => '应用中显示文字的语言';
	@override String get help => '如果您想合作翻译此应用，您可参考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我们的指南</a>';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleZhCn implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '地区';
	@override String get auto => '系统';
	@override String get descr => '设置用于日期、数字的格式……';
	@override String get warn => '更改区域时应用将更新';
	@override String get first_day_of_week => '一周的第一天';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsZhCn implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '滑动操作';
	@override String get choose_description => '选择当您使用此滑动方向滑动列表中的交易项目时将触发什么操作';
	@override String get swipe_left => '向左滑动';
	@override String get swipe_right => '向右滑动';
	@override String get none => '无动作';
	@override String get toggle_reconciled => '切换已调节';
	@override String get toggle_pending => '切换待处理';
	@override String get toggle_voided => '切换作废';
	@override String get toggle_unreconciled => '切换不可调和';
	@override String get remove_status => '删除状态';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesZhCn implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

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
class _TranslationsSettingsTransactionsDefaultTypeZhCn implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Type';
	@override String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeZhCn implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '主题';
	@override String get auto => '系统';
	@override String get light => '明亮主题';
	@override String get dark => '黑暗主题';
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

/// The flat map containing all translations for locale <zh-CN>.
/// Only for edge cases! For simple maps, use the map function of this library.
/// Note: We use a HashMap because Dart seems to be unable to compile large switch statements.
Map<String, dynamic>? _map;

extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		final map = _map ?? _initFlatMap();
		return map[path];
	}

	/// Initializes the flat map and returns it.
	Map<String, dynamic> _initFlatMap() {
		final map = <String, dynamic>{};
		map['ui_actions.cancel'] = '取消';
		map['ui_actions.confirm'] = '确认';
		map['ui_actions.continue_text'] = '继续';
		map['ui_actions.save'] = '保存';
		map['ui_actions.save_changes'] = '保存更改';
		map['ui_actions.close_and_save'] = '保存并关闭';
		map['ui_actions.add'] = '添加';
		map['ui_actions.edit'] = '编辑';
		map['ui_actions.delete'] = '删除';
		map['ui_actions.see_more'] = '查看更多';
		map['ui_actions.select_all'] = '全选';
		map['ui_actions.deselect_all'] = '取消全选';
		map['ui_actions.select'] = '选择';
		map['ui_actions.search'] = '搜索';
		map['ui_actions.filter'] = '筛选';
		map['ui_actions.reset'] = '重置';
		map['ui_actions.submit'] = '提交';
		map['ui_actions.next'] = '下一步';
		map['ui_actions.previous'] = '上一步';
		map['ui_actions.back'] = '返回';
		map['ui_actions.reload'] = '重新加载';
		map['ui_actions.view'] = '视图';
		map['ui_actions.download'] = '下载';
		map['ui_actions.upload'] = '上传';
		map['ui_actions.retry'] = '重试';
		map['ui_actions.copy'] = '复制';
		map['ui_actions.paste'] = '粘贴';
		map['ui_actions.undo'] = '撤销';
		map['ui_actions.redo'] = '还原';
		map['ui_actions.open'] = '打开';
		map['ui_actions.close'] = '关闭';
		map['ui_actions.apply'] = '应用';
		map['ui_actions.discard'] = '放弃';
		map['ui_actions.refresh'] = '刷新';
		map['ui_actions.share'] = '分享';
		map['general.or'] = '或';
		map['general.understood'] = '明白';
		map['general.unspecified'] = '未指定';
		map['general.quick_actions'] = '快捷行动';
		map['general.details'] = '细节';
		map['general.balance'] = '余额';
		map['general.account'] = '账户';
		map['general.accounts'] = '账户';
		map['general.categories'] = '类别';
		map['general.category'] = '类别';
		map['general.today'] = '今天';
		map['general.yesterday'] = '昨天';
		map['general.filters'] = '筛选';
		map['general.empty_warn'] = '喔！这里什么都没有';
		map['general.search_no_results'] = '没有符合您搜索条件的商品';
		map['general.insufficient_data'] = '数据不足';
		map['general.show_more_fields'] = '显示更多';
		map['general.show_less_fields'] = '显示更少';
		map['general.tap_to_search'] = '点击以搜索';
		map['general.leave_without_saving.title'] = '不保存就离开？';
		map['general.leave_without_saving.message'] = '您有未保存的更改，确定要离开而不保存它们吗？';
		map['general.clipboard.success'] = ({required Object x}) => '已复制 ${x}';
		map['general.clipboard.error'] = '复制出错';
		map['general.time.start_date'] = '开始日期';
		map['general.time.end_date'] = '结束日期';
		map['general.time.from_date'] = '从';
		map['general.time.until_date'] = '到';
		map['general.time.date'] = '日期';
		map['general.time.datetime'] = '日期时间';
		map['general.time.time'] = '时间';
		map['general.time.each'] = '每';
		map['general.time.after'] = '后';
		map['general.time.ranges.display'] = '时间范围';
		map['general.time.ranges.it_repeat'] = '重复';
		map['general.time.ranges.it_ends'] = '结束';
		map['general.time.ranges.forever'] = '永久';
		map['general.time.ranges.types.cycle'] = '循环';
		map['general.time.ranges.types.last_days'] = 'Last days';
		map['general.time.ranges.types.last_days_form'] = ({required Object x}) => '前${x}天';
		map['general.time.ranges.types.all'] = '总是';
		map['general.time.ranges.types.date_range'] = '自定义范围';
		map['general.time.ranges.each_range'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}',
				other: '每${n}${range}',
			);
		map['general.time.ranges.each_range_until_date'] = ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}直到${day}',
				other: '每 ${n}${range}直到${day}',
			);
		map['general.time.ranges.each_range_until_times'] = ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}${limit}次',
				other: '每${n}${range}${limit}次',
			);
		map['general.time.ranges.each_range_until_once'] = ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每${range}一次',
				other: '每${n}${range}一次',
			);
		map['general.time.ranges.month'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '月',
				other: '月',
			);
		map['general.time.ranges.year'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '年',
				other: '年',
			);
		map['general.time.ranges.day'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '天',
				other: '天',
			);
		map['general.time.ranges.week'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '星期',
				other: '星期',
			);
		map['general.time.periodicity.display'] = '重复';
		map['general.time.periodicity.no_repeat'] = '不重复';
		map['general.time.periodicity.repeat'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '重复',
				other: '重复',
			);
		map['general.time.periodicity.diary'] = '每天';
		map['general.time.periodicity.monthly'] = '每月';
		map['general.time.periodicity.annually'] = '每年';
		map['general.time.periodicity.quaterly'] = '每季度';
		map['general.time.periodicity.weekly'] = '每周';
		map['general.time.periodicity.custom'] = '自定义';
		map['general.time.periodicity.infinite'] = '总是';
		map['general.time.current.monthly'] = '当月';
		map['general.time.current.annually'] = '今年';
		map['general.time.current.quaterly'] = '本季度';
		map['general.time.current.weekly'] = '本星期';
		map['general.time.current.infinite'] = '永远';
		map['general.time.current.custom'] = '自定义范围';
		map['general.time.all.diary'] = '每天';
		map['general.time.all.monthly'] = '每月';
		map['general.time.all.annually'] = '每年';
		map['general.time.all.quaterly'] = '每季度';
		map['general.time.all.weekly'] = '每周';
		map['general.transaction_order.display'] = '排序';
		map['general.transaction_order.category'] = '按类别';
		map['general.transaction_order.quantity'] = '按数额';
		map['general.transaction_order.date'] = '按日期';
		map['general.validations.form_error'] = '请改正指定的项目后继续';
		map['general.validations.required'] = '必填项目';
		map['general.validations.positive'] = '应为正值';
		map['general.validations.min_number'] = ({required Object x}) => '应大于${x}';
		map['general.validations.max_number'] = ({required Object x}) => '应小于${x}';
		map['intro.start'] = '开始';
		map['intro.skip'] = '跳过';
		map['intro.next'] = '继续';
		map['intro.select_your_currency'] = '选择您的货币';
		map['intro.welcome_subtitle'] = '您的个人财务管家';
		map['intro.welcome_subtitle2'] = '100% 开放，100% 免费';
		map['intro.welcome_footer'] = '登录即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隐私策略</a>和此应用的<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>使用条款</a>';
		map['intro.offline_descr_title'] = '本地账户：';
		map['intro.offline_descr'] = '您的数据只会存储于此设备中，只要您不卸载应用或更换手机，数据就会保持安全。为避免数据丢失，建议定期从应用设置中备份数据。';
		map['intro.offline_start'] = '开始使用本地账户';
		map['intro.sl1_title'] = '选择您的货币';
		map['intro.sl1_descr'] = '您的默认货币会被用于报表和图表中。您之后可以随时更改默认货币和应用语言';
		map['intro.sl2_title'] = '安全、隐私、可靠';
		map['intro.sl2_descr'] = '您的数据只属于您。我们直接将您的信息存储于此设备，不会连接外部服务器。因此您可以在离线时继续使用此应用';
		map['intro.sl2_descr2'] = '此外，此应用的源代码是公开的，任何人都可以查看它如何运行并贡献自己的力量';
		map['intro.last_slide_title'] = '全部就绪';
		map['intro.last_slide_descr'] = '使用 Monekin，您最终可以实现自己想要的财务独立。您将拥有和您的钱相关的图表、预算、提示、统计信息等。';
		map['intro.last_slide_descr2'] = '祝您使用愉快！如果您有任何疑问或建议，请随时与我们联系……';
		map['home.title'] = '面板';
		map['home.filter_transactions'] = '筛选交易';
		map['home.hello_day'] = '您好，';
		map['home.hello_night'] = '晚上好，';
		map['home.total_balance'] = '总余额';
		map['home.my_accounts'] = '我的账户';
		map['home.active_accounts'] = '活动账户';
		map['home.no_accounts'] = '尚未创建账户';
		map['home.no_accounts_descr'] = '要开始使用 Monekin，请创建至少一个账户，以便开始添加交易';
		map['home.last_transactions'] = '最近的交易';
		map['home.should_create_account_header'] = '哎呀!';
		map['home.should_create_account_message'] = '在可以开始创建交易之前，您必须拥有至少一个未被归档的账户';
		map['financial_health.display'] = '财务健康';
		map['financial_health.review.very_good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '很好！';
					case GenderContext.female:
						return '很好！';
				}
			};
		map['financial_health.review.good'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '好';
					case GenderContext.female:
						return '好';
				}
			};
		map['financial_health.review.normal'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '一般';
					case GenderContext.female:
						return '一般';
				}
			};
		map['financial_health.review.bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '不好';
					case GenderContext.female:
						return '不好';
				}
			};
		map['financial_health.review.very_bad'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '很不好';
					case GenderContext.female:
						return '很不好';
				}
			};
		map['financial_health.review.insufficient_data'] = ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '数据不足';
					case GenderContext.female:
						return '数据不足';
				}
			};
		map['financial_health.review.descr.insufficient_data'] = '看起来我们没有足够的数据来计算您的财务健康情况。请添加一些支出/收入以便我们帮助您！';
		map['financial_health.review.descr.very_good'] = '恭喜！您的财务状况非常好。我们希望您能够继续保持，并继续和 Monekin 一起学习。';
		map['financial_health.review.descr.good'] = '很好！您的财务健康状况良好。请查看分析页面，了解如何省下更多！';
		map['financial_health.review.descr.normal'] = '您的财务健康状况在这一段时间里处于平均水平';
		map['financial_health.review.descr.bad'] = '看起来您的财务状况不是很理想。请查看其余的图表以便进一步了解您的财务情况。';
		map['financial_health.review.descr.very_bad'] = '嗯，您的财务健康状况远低于应有的水平。请查看其余的图表以便进一步了解您的财务情况。';
		map['financial_health.months_without_income.title'] = '财富自由时长';
		map['financial_health.months_without_income.subtitle'] = '根据您的余额计算出您可以在无收入的情况下生活的时长';
		map['financial_health.months_without_income.text_zero'] = '按这样的开支速度，您无法支撑一个月！';
		map['financial_health.months_without_income.text_one'] = '按这样的开支速度，如果没有收入，您可以大概支撑一个月！';
		map['financial_health.months_without_income.text_other'] = ({required Object n}) => '按这样的开支速度，如果没有收入，您可以大概支撑 <b>${n}个月</b>。';
		map['financial_health.months_without_income.text_infinite'] = '按这样的开支速度，即使没有收入，您也可以维持 <b>一辈子</b>。';
		map['financial_health.months_without_income.suggestion'] = '请记住，建议至少保持这一数字在 5 个月以上。如果您发现您没有足够的储蓄，请减少不必要的开支。';
		map['financial_health.months_without_income.insufficient_data'] = '看起来我们没有足够的数据来计算您没有收入后，能够支撑几个月。请添加一些支出/收入，再来这里查看您的财务健康情况';
		map['financial_health.savings_percentage.title'] = '储蓄百分比';
		map['financial_health.savings_percentage.subtitle'] = '这段时间内您的收入中哪一部分没有被花掉';
		map['financial_health.savings_percentage.text.good'] = ({required Object value}) => '恭喜！您在这段时间内成功省下了 <b>${value}%</b> 的收入。看来您已经是一位专家了，请继续保持！';
		map['financial_health.savings_percentage.text.normal'] = ({required Object value}) => '恭喜，您在这段时间内成功省下了 <b>${value}%</b> 的收入。';
		map['financial_health.savings_percentage.text.bad'] = ({required Object value}) => '您在这段时间内省下了 <b>${value}%</b> 的收入。但我们认为您可以做得更好！';
		map['financial_health.savings_percentage.text.very_bad'] = '哇，您在这段时间内并没有任何结余。';
		map['financial_health.savings_percentage.suggestion'] = '请记住，建议至少将您赚到的 15-20% 存下来。';
		map['stats.title'] = '统计数据';
		map['stats.balance'] = '余额';
		map['stats.final_balance'] = '期末余额';
		map['stats.balance_by_account'] = '账户余额';
		map['stats.balance_by_account_subtitle'] = '我的大部分钱都在哪里？';
		map['stats.balance_by_currency'] = '货币余额';
		map['stats.balance_by_currency_subtitle'] = '我有多少的外币？';
		map['stats.balance_evolution'] = '余额趋势';
		map['stats.balance_evolution_subtitle'] = '我是否比之前更有钱了？';
		map['stats.compared_to_previous_period'] = '与上一段时间相比';
		map['stats.cash_flow'] = '现金流';
		map['stats.cash_flow_subtitle'] = '我的支出是否少于我的收入？';
		map['stats.by_periods'] = '按时间段';
		map['stats.by_categories'] = '按类别';
		map['stats.by_tags'] = '按标签';
		map['stats.distribution'] = '分布';
		map['stats.finance_health_resume'] = '总结';
		map['stats.finance_health_breakdown'] = '分解';
		map['icon_selector.name'] = '名称';
		map['icon_selector.icon'] = '图标';
		map['icon_selector.color'] = '颜色';
		map['icon_selector.select_icon'] = '选择一个图标';
		map['icon_selector.select_color'] = '选择一种颜色';
		map['icon_selector.custom_color'] = '自定义颜色';
		map['icon_selector.current_color_selection'] = '当前选择';
		map['icon_selector.select_account_icon'] = '确认您的账户';
		map['icon_selector.select_category_icon'] = '确认您的类别';
		map['icon_selector.scopes.transport'] = '交通';
		map['icon_selector.scopes.money'] = '金钱';
		map['icon_selector.scopes.food'] = '食物';
		map['icon_selector.scopes.medical'] = '医疗';
		map['icon_selector.scopes.entertainment'] = '休闲';
		map['icon_selector.scopes.technology'] = '科技';
		map['icon_selector.scopes.other'] = '其它';
		map['icon_selector.scopes.logos_financial_institutions'] = '金融机构';
		map['transaction.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易',
				other: '交易',
			);
		map['transaction.create'] = '新交易';
		map['transaction.new_income'] = '新收入';
		map['transaction.new_expense'] = '新开支';
		map['transaction.new_success'] = '交易创建成功';
		map['transaction.edit'] = '编辑交易';
		map['transaction.edit_success'] = '交易编辑成功';
		map['transaction.edit_multiple'] = '批量编辑交易';
		map['transaction.edit_multiple_success'] = ({required Object x}) => '${x}笔交易编辑成功';
		map['transaction.duplicate'] = '复制交易';
		map['transaction.duplicate_short'] = '复制';
		map['transaction.duplicate_warning_message'] = '将在同一日期创建一笔完全相同的交易，继续吗？';
		map['transaction.duplicate_success'] = '交易复制成功';
		map['transaction.delete'] = '删除交易';
		map['transaction.delete_warning_message'] = '此操作无法撤回。将重新计算您账户的当前余额及其它所有统计数据';
		map['transaction.delete_success'] = '交易删除成功';
		map['transaction.delete_multiple'] = '批量删除交易';
		map['transaction.delete_multiple_warning_message'] = ({required Object x}) => '此操作无法撤回，并且将删除${x}笔交易。将重新计算您账户的当前余额及其它所有统计数据';
		map['transaction.delete_multiple_success'] = ({required Object x}) => '${x}笔交易删除成功';
		map['transaction.details'] = '操作详情';
		map['transaction.next_payments.accept'] = '接受';
		map['transaction.next_payments.skip'] = '跳过';
		map['transaction.next_payments.skip_success'] = '已成果跳过交易';
		map['transaction.next_payments.skip_dialog_title'] = '跳过交易';
		map['transaction.next_payments.skip_dialog_msg'] = ({required Object date}) => '此操作无法撤回。我们将把下次的日期移动至${date}';
		map['transaction.next_payments.accept_today'] = '今天接受';
		map['transaction.next_payments.accept_in_required_date'] = ({required Object date}) => '在要求的日期 (${date}) 接受';
		map['transaction.next_payments.accept_dialog_title'] = '接受交易';
		map['transaction.next_payments.accept_dialog_msg_single'] = '此交易的新状态将为null。您可以随时重新编辑此交易的状态';
		map['transaction.next_payments.accept_dialog_msg'] = ({required Object date}) => '此操作将建立日期为 ${date} 的新交易。您可以在交易页面查看此交易的详情';
		map['transaction.next_payments.recurrent_rule_finished'] = '循环规则已完成，没有更多的支付！';
		map['transaction.list.all'] = '所有交易';
		map['transaction.list.empty'] = '未发现需要显示的交易。请先在应用中添加一些交易，下次再来查看';
		map['transaction.list.searcher_placeholder'] = '按类别、描述等搜索';
		map['transaction.list.searcher_no_results'] = '未找到符合搜索条件的交易';
		map['transaction.list.loading'] = '正在加载更多的交易……';
		map['transaction.list.selected_short'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '已选择 ${n}',
				other: '已选择 ${n}',
			);
		map['transaction.list.selected_long'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '已选择 ${n} 笔交易',
				other: '已选择 ${n} 笔交易',
			);
		map['transaction.list.bulk_edit.dates'] = '批量编辑日期';
		map['transaction.list.bulk_edit.categories'] = '批量编辑类别';
		map['transaction.list.bulk_edit.status'] = '批量编辑状态';
		map['transaction.filters.title'] = '交易过滤器';
		map['transaction.filters.from_value'] = '最小金额';
		map['transaction.filters.to_value'] = '最大金额';
		map['transaction.filters.from_value_def'] = ({required Object x}) => '从 ${x}';
		map['transaction.filters.to_value_def'] = ({required Object x}) => '到 ${x}';
		map['transaction.filters.from_date_def'] = ({required Object date}) => '从 ${date}';
		map['transaction.filters.to_date_def'] = ({required Object date}) => '到 ${date}';
		map['transaction.filters.reset'] = '重置过滤器';
		map['transaction.filters.saved.title'] = '已保存的过滤器';
		map['transaction.filters.saved.new_title'] = '新建过滤器';
		map['transaction.filters.saved.edit_title'] = '编辑过滤器';
		map['transaction.filters.saved.name_label'] = '过滤器名称';
		map['transaction.filters.saved.name_hint'] = '我的自定义过滤器';
		map['transaction.filters.saved.save_dialog_title'] = '保存过滤器';
		map['transaction.filters.saved.save_tooltip'] = '保存当前过滤器';
		map['transaction.filters.saved.load_tooltip'] = '加载已保存的过滤器';
		map['transaction.filters.saved.empty_title'] = '未找到已保存的过滤器';
		map['transaction.filters.saved.empty_description'] = '在此保存过滤器以便稍后快速访问。';
		map['transaction.filters.saved.save_success'] = '筛选器保存成功';
		map['transaction.filters.saved.delete_success'] = '筛选器删除成功';
		map['transaction.form.validators.zero'] = '交易数额不应为零';
		map['transaction.form.validators.date_max'] = '所选日期晚于当前日期。交易将新增为待办';
		map['transaction.form.validators.date_after_account_creation'] = '无法创建早于账户创建日期的交易';
		map['transaction.form.validators.negative_transfer'] = '转账数额不应为负数';
		map['transaction.form.validators.transfer_between_same_accounts'] = '来源于目标账户不应相同';
		map['transaction.form.title'] = '交易标题';
		map['transaction.form.title_short'] = '标题';
		map['transaction.form.value'] = '数额';
		map['transaction.form.tap_to_see_more'] = '点击查看更多详情';
		map['transaction.form.no_tags'] = '-- 无标签 --';
		map['transaction.form.description'] = '描述';
		map['transaction.form.description_info'] = '点击此处输入有关此交易的详细描述';
		map['transaction.form.exchange_to_preferred_title'] = ({required Object currency}) => '汇率为${currency}';
		map['transaction.form.exchange_to_preferred_in_date'] = '交易日';
		map['transaction.reversed.title'] = '逆向交易';
		map['transaction.reversed.title_short'] = '逆向交易';
		map['transaction.reversed.description_for_expenses'] = '尽管是一个开支交易，但其数额为正值。此类交易可用于表示已记录开支的返还，例如退款或偿还债务。';
		map['transaction.reversed.description_for_incomes'] = '尽管是一个收入交易，但其数额为负值。此类交易可用于作废或更正收入记录中的错误，以反映退款或记录偿还债务。';
		map['transaction.status.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '状态',
				other: '状态',
			);
		map['transaction.status.display_long'] = '交易状态';
		map['transaction.status.tr_status'] = ({required Object status}) => '${status}交易';
		map['transaction.status.none'] = '无状态';
		map['transaction.status.none_descr'] = '没有特定的状态';
		map['transaction.status.reconciled'] = '已核对';
		map['transaction.status.reconciled_descr'] = '此交易已被核实，与您银行的一个真实交易相对应';
		map['transaction.status.unreconciled'] = '未核实';
		map['transaction.status.unreconciled_descr'] = '此交易尚未被核实，因此尚未出现在您的真实银行账户中。然而，在 Monekin 中，它将被用于计算余额和其它统计数据';
		map['transaction.status.pending'] = '待办';
		map['transaction.status.pending_descr'] = '此交易正在等待处理，因此在计算余额和其它统计数据时暂时不会被考虑';
		map['transaction.status.voided'] = '作废';
		map['transaction.status.voided_descr'] = '由于付款错误或其它原因造成的作废或取消的交易。在计算余额和其它统计数据时不会被考虑';
		map['transaction.types.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易类型',
				other: '交易类型',
			);
		map['transaction.types.income'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '收入',
				other: '收入',
			);
		map['transaction.types.expense'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '支出',
				other: '支出',
			);
		map['transaction.types.transfer'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '转账',
				other: '转账',
			);
		map['transfer.display'] = '转账';
		map['transfer.transfers'] = '转账';
		map['transfer.transfer_to'] = ({required Object account}) => '转账至 ${account}';
		map['transfer.create'] = '转账';
		map['transfer.need_two_accounts_warning_header'] = '哎呀！';
		map['transfer.need_two_accounts_warning_message'] = '至少需要两个账户才能执行此操作。如果您需要调整或编辑此账户的当前余额，请点击编辑按钮';
		map['transfer.form.from'] = '转出账户';
		map['transfer.form.to'] = '转入账户';
		map['transfer.form.value_in_destiny.title'] = '转账数额';
		map['transfer.form.value_in_destiny.amount_short'] = ({required Object amount}) => '${amount} 至目标账户';
		map['recurrent_transactions.title'] = '循环交易';
		map['recurrent_transactions.title_short'] = '循环交易';
		map['recurrent_transactions.empty'] = '您似乎没有任何循环交易。创建一个每周、每月或每年的循环交易，它会在此显示';
		map['recurrent_transactions.total_expense_title'] = '每一周期的总开支';
		map['recurrent_transactions.total_expense_descr'] = '* 不考虑每一循环的起止日期';
		map['recurrent_transactions.details.title'] = '循环交易';
		map['recurrent_transactions.details.descr'] = '此交易的未来的动作显示如下。您可以接受第一个动作或跳过此动作';
		map['recurrent_transactions.details.last_payment_info'] = '此动作是循环规则的最后一个，因此当确认此动作后，这一循环规则将被自动删除';
		map['recurrent_transactions.details.delete_header'] = '删除循环交易';
		map['recurrent_transactions.details.delete_message'] = '此操作无法撤回，不会影响您已确认/付款的交易';
		map['recurrent_transactions.status.delayed_by'] = ({required Object x}) => '延迟 ${x} 天';
		map['recurrent_transactions.status.coming_in'] = ({required Object x}) => '${x} 天内';
		map['account.details'] = '账户详情';
		map['account.date'] = '开启日期';
		map['account.close_date'] = '关闭日期';
		map['account.reopen'] = '重新开启账户';
		map['account.reopen_short'] = '重开账户';
		map['account.reopen_descr'] = '您确定要重新开启此账户吗？';
		map['account.balance'] = '账户余额';
		map['account.n_transactions'] = '交易数量';
		map['account.add_money'] = '增加金额';
		map['account.withdraw_money'] = '减少金额';
		map['account.no_accounts'] = '未发现应当显示的交易。请点击底部的 \'+\' 按钮新增一个交易';
		map['account.types.title'] = '账户类型';
		map['account.types.warning'] = '账户类型一旦选择，以后将无法更改';
		map['account.types.normal'] = '普通账户';
		map['account.types.normal_descr'] = '用于记录日常财务。这是最普通的账户，您可以添加支出、收入……';
		map['account.types.saving'] = '储蓄账户';
		map['account.types.saving_descr'] = '您只能从此账户中向其它账户中转入/转出（而无法用于消费开支）。非常适合用于存钱';
		map['account.form.name'] = '账户名称';
		map['account.form.name_placeholder'] = '例如：储蓄账户';
		map['account.form.notes'] = '备注';
		map['account.form.notes_placeholder'] = '输入有关此账户的一些备注/描述';
		map['account.form.initial_balance'] = '初始余额';
		map['account.form.current_balance'] = '当前余额';
		map['account.form.create'] = '创建账户';
		map['account.form.edit'] = '编辑账户';
		map['account.form.currency_not_found_warn'] = '您没有此货币的汇率信息。将使用默认汇率 1.0。您可以在设置中修改';
		map['account.form.already_exists'] = '此账户名已存在，请起一个新的账户名';
		map['account.form.tr_before_opening_date'] = '此账户中有早于开户日期的交易';
		map['account.form.iban'] = '国际银行账户号码（IBAN）';
		map['account.form.swift'] = '银行识别码（SWIFT）';
		map['account.delete.warning_header'] = '删除账户？';
		map['account.delete.warning_text'] = '此操作将删除此账户及其所有交易';
		map['account.delete.success'] = '账户删除成功';
		map['account.close.title'] = '关闭账户';
		map['account.close.title_short'] = '关闭';
		map['account.close.warn'] = '此账户将不再出现在特定列表中，并且您无法在此账户中创建晚于以下日期的交易。此操作不会影响任何交易或余额，您也可以随时重新开启此账户。';
		map['account.close.should_have_zero_balance'] = '此账户中的当前余额必须为 0 才可关闭。请在继续之前编辑账户';
		map['account.close.should_have_no_transactions'] = '此账户在指定的关闭日期之后仍有交易。请删除它们或编辑账户关闭日期，然后再继续';
		map['account.close.success'] = '账户关闭成功';
		map['account.close.unarchive_succes'] = '账户已成功重新开启';
		map['account.select.one'] = '选择一个账户';
		map['account.select.all'] = '所有账户';
		map['account.select.multiple'] = '选择多个账户';
		map['currencies.currency_converter'] = '货币换算';
		map['currencies.currency'] = '货币';
		map['currencies.currency_settings'] = '货币设置';
		map['currencies.currency_manager'] = '货币管理';
		map['currencies.currency_manager_descr'] = '设置您的货币及其与其他货币的汇率';
		map['currencies.preferred_currency'] = '默认货币';
		map['currencies.tap_to_change_preferred_currency'] = '点击即可更改';
		map['currencies.change_preferred_currency_title'] = '更改默认货币';
		map['currencies.change_preferred_currency_msg'] = '从现在起，所有统计数据和预算都将以此货币显示。账户和交易将保留其原有货币单位。如果您执行此操作，所有保存的汇率都将被删除。您想继续吗？';
		map['currencies.exchange_rate_form.equal_to_preferred_warn'] = '货币不能与用户货币相同';
		map['currencies.exchange_rate_form.override_existing_warn'] = '该货币在该日期的汇率已存在。如果继续，前一个将会被覆盖';
		map['currencies.exchange_rate_form.specify_a_currency'] = '请指定货币';
		map['currencies.exchange_rate_form.add'] = '添加汇率';
		map['currencies.exchange_rate_form.add_success'] = '汇率添加成功';
		map['currencies.exchange_rate_form.edit'] = '编辑汇率';
		map['currencies.exchange_rate_form.edit_success'] = '汇率编辑成功';
		map['currencies.exchange_rate_form.remove_all'] = '删除所有汇率';
		map['currencies.exchange_rate_form.remove_all_warning'] = '此操作不可逆转，并将删除该货币的所有汇率';
		map['currencies.types.display'] = '货币类型';
		map['currencies.types.fiat'] = '菲亚特';
		map['currencies.types.crypto'] = '加密货币';
		map['currencies.types.other'] = '其他';
		map['currencies.currency_form.name'] = '显示名称';
		map['currencies.currency_form.code'] = '货币代码';
		map['currencies.currency_form.symbol'] = '象征';
		map['currencies.currency_form.decimal_digits'] = '小数位';
		map['currencies.currency_form.create'] = '创建货币';
		map['currencies.currency_form.create_success'] = '货币创建成功';
		map['currencies.currency_form.edit'] = '编辑货币';
		map['currencies.currency_form.edit_success'] = '货币编辑成功';
		map['currencies.currency_form.delete'] = '删除货币';
		map['currencies.currency_form.delete_success'] = '币种删除成功';
		map['currencies.currency_form.already_exists'] = '具有此代码的货币已存在。您可能想要编辑它';
		map['currencies.delete_all_success'] = '删除汇率成功';
		map['currencies.historical'] = '历史汇率';
		map['currencies.historical_empty'] = '没有找到该货币的历史汇率';
		map['currencies.exchange_rate'] = '汇率';
		map['currencies.exchange_rates'] = '汇率';
		map['currencies.min_exchange_rate'] = '最低汇率';
		map['currencies.max_exchange_rate'] = '最高汇率';
		map['currencies.empty'] = '如果您有账户使用默认货币以外的货币，请在此处添加汇率，以获得更准确的图表';
		map['currencies.select_a_currency'] = '选择货币';
		map['currencies.search'] = '按名称或货币代码搜索';
		map['tags.display'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '标签',
				other: '标签',
			);
		map['tags.form.name'] = '标签名';
		map['tags.form.description'] = '描述';
		map['tags.select.title'] = '选择标签';
		map['tags.select.all'] = '所有标签';
		map['tags.empty_list'] = '您还没有创建任何标签。标签和类别是对您的动作进行分类的好方法';
		map['tags.without_tags'] = '没有标签';
		map['tags.add'] = '添加标签';
		map['tags.create'] = '创建标签';
		map['tags.create_success'] = '标签创建成功';
		map['tags.already_exists'] = '此标签名已存在。请起一个新的标签名';
		map['tags.edit'] = '编辑标签';
		map['tags.edit_success'] = '标签编辑成功';
		map['tags.delete_success'] = '类别删除成功';
		map['tags.delete_warning_header'] = '删除标签？';
		map['tags.delete_warning_message'] = '此操作不会删除具有此标签的交易。';
		map['categories.unknown'] = '未知类别';
		map['categories.create'] = '创建类别';
		map['categories.create_success'] = '类别创建成功';
		map['categories.new_category'] = '新类别';
		map['categories.already_exists'] = '此类别名已存在。请起一个新的类别名';
		map['categories.edit'] = '编辑类别';
		map['categories.edit_success'] = '类别编辑成功';
		map['categories.name'] = '类别名称';
		map['categories.type'] = '类别类型';
		map['categories.both_types'] = '混合类型';
		map['categories.subcategories'] = '子类别';
		map['categories.subcategories_add'] = '新增子类别';
		map['categories.make_parent'] = '移动至类别';
		map['categories.make_child'] = '移动成为子类别';
		map['categories.make_child_warning1'] = ({required Object destiny}) => '此类别及其子类别将成为<b>${destiny}</b>的子类别。';
		map['categories.make_child_warning2'] = ({required Object x, required Object destiny}) => '它们的交易<b>(${x})</b>将被移至<b>${destiny}</b>类别中创建的新子类别。';
		map['categories.make_child_success'] = '子类别创建成功';
		map['categories.merge'] = '与另一个类别合并';
		map['categories.merge_warning1'] = ({required Object from, required Object x, required Object destiny}) => '与类别<b>${from}</b>相关的所有交易 (${x}) 将移至类别<b>${destiny}</b>';
		map['categories.merge_warning2'] = ({required Object from}) => '类别<b>${from}</b>将被无法撤回地删除。 ';
		map['categories.merge_success'] = '类别合并成功';
		map['categories.delete_success'] = '类别删除成功';
		map['categories.delete_warning_header'] = '删除类别？';
		map['categories.delete_warning_message'] = ({required Object x}) => '此操作将无法撤回地删除与此类别相关的所有交易<b>(${x})</b>。';
		map['categories.select.title'] = '选择类别';
		map['categories.select.select_one'] = '选择一个类别';
		map['categories.select.select_subcategory'] = '选择一个子类别';
		map['categories.select.without_subcategory'] = '没有子类别';
		map['categories.select.all'] = '所有类别';
		map['categories.select.all_short'] = '全部';
		map['budgets.title'] = '预算';
		map['budgets.repeated'] = '重复的';
		map['budgets.one_time'] = '单次的';
		map['budgets.annual'] = '年度';
		map['budgets.week'] = '每周';
		map['budgets.month'] = '每月';
		map['budgets.actives'] = '活跃';
		map['budgets.pending'] = '待办';
		map['budgets.finish'] = '完成';
		map['budgets.from_budgeted'] = '预算为';
		map['budgets.days_left'] = '天还剩';
		map['budgets.days_to_start'] = '天开始';
		map['budgets.since_expiration'] = '自到期日起的天数';
		map['budgets.no_budgets'] = '未发现应当显示的预算。请点击底部的 \'+\' 按钮新增一个预算';
		map['budgets.delete'] = '删除预算';
		map['budgets.delete_warning'] = '此操作无法撤回。此预算中的类别和交易不会被删除';
		map['budgets.form.title'] = '创建预算';
		map['budgets.form.name'] = '预算名称';
		map['budgets.form.value'] = '预算额度';
		map['budgets.form.create'] = '创建预算';
		map['budgets.form.create_success'] = '预算创建成功';
		map['budgets.form.edit'] = '编辑预算';
		map['budgets.form.edit_success'] = '预算编辑成功';
		map['budgets.form.negative_warn'] = '预算额度不能为负数';
		map['budgets.details.title'] = '预算详情';
		map['budgets.details.statistics'] = '统计数据';
		map['budgets.details.budget_value'] = '预算';
		map['budgets.details.expend_evolution'] = '支出变化';
		map['budgets.details.no_transactions'] = '看来您还没有与此预算相关的任何支出';
		map['budgets.target_timeline_statuses.active'] = '当前预算';
		map['budgets.target_timeline_statuses.past'] = '过去预算';
		map['budgets.target_timeline_statuses.future'] = '未来预算';
		map['budgets.progress.labels.active_on_track'] = '正常';
		map['budgets.progress.labels.active_overspending'] = '超支';
		map['budgets.progress.labels.success'] = '已达成';
		map['budgets.progress.labels.fail'] = '超出预算';
		map['budgets.progress.description.active_on_track'] = ({required Object remainingDays, required Object dailyAmount}) => '在剩余的 ${remainingDays} 天里，您每天可以花费 ${dailyAmount}';
		map['budgets.progress.description.active_overspending'] = ({required Object remainingDays, required Object dailyAmount}) => '为了回到正轨，您应该在剩余的 ${remainingDays} 天里将每天的支出限制在 ${dailyAmount}';
		map['budgets.progress.description.active_exceeded'] = ({required Object amount}) => '您已经超出了预算限额 ${amount}。如果您找不到此预算的任何收入，您应该在其剩余期间停止支出';
		map['budgets.progress.description.success'] = '干得好！该预算已成功完成。继续创建预算以管理您的支出';
		map['budgets.progress.description.fail'] = ({required Object amount}) => '您超出了预算 ${amount}。下次请更加小心！';
		map['target_timeline_statuses.active'] = '进行中';
		map['target_timeline_statuses.past'] = '已结束';
		map['target_timeline_statuses.future'] = '未开始';
		map['backup.no_file_selected'] = '未选择文件';
		map['backup.no_directory_selected'] = '未选择目录';
		map['backup.export.title'] = '导出您的数据';
		map['backup.export.title_short'] = '导出';
		map['backup.export.type_of_export'] = '出口类型';
		map['backup.export.other_options'] = '选项';
		map['backup.export.all'] = '完整备份';
		map['backup.export.all_descr'] = '导出您的所有数据（账户、交易、预算、设置……）。随时再次导入它们，您就不会丟失任何內容。';
		map['backup.export.transactions'] = '交易备份';
		map['backup.export.transactions_descr'] = '以 CSV 格式导出您的交易，以便您可以在其它程序或应用中更轻松地分析。';
		map['backup.export.transactions_to_export'] = ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '1 笔交易要导出',
				other: '要导出的 ${n} 笔交易',
			);
		map['backup.export.description'] = '以不同格式下载（导出）数据';
		map['backup.export.send_file'] = '发送文件';
		map['backup.export.see_folder'] = '查看文件夹';
		map['backup.export.success'] = ({required Object x}) => '文件已成功保存/下载至 ${x}';
		map['backup.export.error'] = '下载文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员';
		map['backup.export.dialog_title'] = '保存/发送文件';
		map['backup.import.title'] = '导入您的数据';
		map['backup.import.title_short'] = '导入';
		map['backup.import.restore_backup'] = '恢复备份';
		map['backup.import.restore_backup_descr'] = '导入一个从 Monekin 保存的数据库。此操作将用新数据覆盖当前应用数据';
		map['backup.import.restore_backup_warn_description'] = '导入新数据库时，您将丟失应用中当前保存的所有数据。建议在继续之前进行备份。请勿在此上传任何来源不明的文件，仅上传您之前从 Monekin 下载的文件';
		map['backup.import.restore_backup_warn_title'] = '覆盖所有数据';
		map['backup.import.select_other_file'] = '选择其它文件';
		map['backup.import.tap_to_select_file'] = '点击选择文件';
		map['backup.import.manual_import.title'] = '手动导入';
		map['backup.import.manual_import.descr'] = '手动从 .csv 文件导入交易';
		map['backup.import.manual_import.default_account'] = '默认账户';
		map['backup.import.manual_import.remove_default_account'] = '删除默认账户';
		map['backup.import.manual_import.default_category'] = '默认类别';
		map['backup.import.manual_import.select_a_column'] = '从 .csv 中选择一列';
		map['backup.import.manual_import.steps.0'] = '选择您的文件';
		map['backup.import.manual_import.steps.1'] = '数额列';
		map['backup.import.manual_import.steps.2'] = '账户列';
		map['backup.import.manual_import.steps.3'] = '类别列';
		map['backup.import.manual_import.steps.4'] = '日期列';
		map['backup.import.manual_import.steps.5'] = '其它列';
		map['backup.import.manual_import.steps_descr.0'] = '从您的设备中选择一个 .csv 文件。确保它的第一行描述了每列的名称。';
		map['backup.import.manual_import.steps_descr.1'] = '选择每笔交易数额的列。负值表示支出，正值表示收入。.表示小数点分隔符。';
		map['backup.import.manual_import.steps_descr.2'] = '选择每笔交易所属账户的列。您也可以选择默认账户，以防我们找不到您想要的账户。如果未指定默认账户，我们将建立一个同名账户。';
		map['backup.import.manual_import.steps_descr.3'] = '选择交易类别名称所在的列。您必须指定一个默认类别，以便我们在找不到此类别时，将默认类别分配给交易。';
		map['backup.import.manual_import.steps_descr.4'] = '选择每笔交易日期的列。如果未指定，所有交易将使用当前日期。';
		map['backup.import.manual_import.steps_descr.5'] = '选择其它交易属性的数据列';
		map['backup.import.manual_import.success'] = ({required Object x}) => '成功导入 ${x} 笔交易';
		map['backup.import.success'] = '导入成功';
		map['backup.import.error'] = '导入文件时发生错误。请通过 lozin.technologies@gmail.com 联系开发人员。';
		map['backup.import.cancelled'] = '导入被用户取消';
		map['backup.about.title'] = '有关您的数据库的信息';
		map['backup.about.create_date'] = '创建日期';
		map['backup.about.modify_date'] = '上一次更改';
		map['backup.about.last_backup'] = '上次备份';
		map['backup.about.size'] = '文件大小';
		map['settings.title_long'] = '设置与自定义';
		map['settings.title_short'] = '设置';
		map['settings.description'] = '主题、语言、数据等';
		map['settings.edit_profile'] = '编辑个人资料';
		map['settings.general.menu_title'] = '常规设置';
		map['settings.general.menu_descr'] = '语言、隐私等';
		map['settings.general.language.section'] = '语言和文字';
		map['settings.general.language.title'] = '语言/Language';
		map['settings.general.language.descr'] = '应用中显示文字的语言';
		map['settings.general.language.help'] = '如果您想合作翻译此应用，您可参考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我们的指南</a>';
		map['settings.general.locale.title'] = '地区';
		map['settings.general.locale.auto'] = '系统';
		map['settings.general.locale.descr'] = '设置用于日期、数字的格式……';
		map['settings.general.locale.warn'] = '更改区域时应用将更新';
		map['settings.general.locale.first_day_of_week'] = '一周的第一天';
		map['settings.security.title'] = '安全';
		map['settings.security.private_mode_at_launch'] = '启动隐私模式';
		map['settings.security.private_mode_at_launch_descr'] = '默认以隐私模式启动此应用';
		map['settings.security.private_mode'] = '隐私模式';
		map['settings.security.private_mode_descr'] = '隐藏所有金额';
		map['settings.security.private_mode_activated'] = '隐私模式已启用';
		map['settings.security.private_mode_deactivated'] = '隐私模式已禁用';
		map['settings.transactions.menu_title'] = '交易';
		map['settings.transactions.menu_descr'] = '配置交易的行为';
		map['settings.transactions.title'] = '交易设置';
		map['settings.transactions.swipe_actions.title'] = '滑动操作';
		map['settings.transactions.swipe_actions.choose_description'] = '选择当您使用此滑动方向滑动列表中的交易项目时将触发什么操作';
		map['settings.transactions.swipe_actions.swipe_left'] = '向左滑动';
		map['settings.transactions.swipe_actions.swipe_right'] = '向右滑动';
		map['settings.transactions.swipe_actions.none'] = '无动作';
		map['settings.transactions.swipe_actions.toggle_reconciled'] = '切换已调节';
		map['settings.transactions.swipe_actions.toggle_pending'] = '切换待处理';
		map['settings.transactions.swipe_actions.toggle_voided'] = '切换作废';
		map['settings.transactions.swipe_actions.toggle_unreconciled'] = '切换不可调和';
		map['settings.transactions.swipe_actions.remove_status'] = '删除状态';
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
		map['settings.appearance.menu_title'] = '主题与风格';
		map['settings.appearance.menu_descr'] = '主题选择、颜色以及与应用程序外观相关的其他内容';
		map['settings.appearance.theme_and_colors'] = '主题和颜色';
		map['settings.appearance.theme.title'] = '主题';
		map['settings.appearance.theme.auto'] = '系统';
		map['settings.appearance.theme.light'] = '明亮主题';
		map['settings.appearance.theme.dark'] = '黑暗主题';
		map['settings.appearance.amoled_mode'] = 'AMOLED 模式';
		map['settings.appearance.amoled_mode_descr'] = '尽可能使用纯黑色壁纸。在 AMOLED 屏幕的设备上能略微省电';
		map['settings.appearance.dynamic_colors'] = '动态色彩';
		map['settings.appearance.dynamic_colors_descr'] = '尽可能使用系统强调色';
		map['settings.appearance.accent_color'] = '强调色';
		map['settings.appearance.accent_color_descr'] = '选择应用中用来强调介面某些部分的颜色';
		map['settings.appearance.text'] = '文本';
		map['settings.appearance.font'] = '字体';
		map['settings.appearance.font_platform'] = '平台';
		map['more.title'] = '更多';
		map['more.title_long'] = '更多';
		map['more.data.display'] = '数据';
		map['more.data.display_descr'] = '导出和导入您的数据，这样您不会丟失任何东西';
		map['more.data.delete_all'] = '删除我的数据';
		map['more.data.delete_all_header1'] = '停下⚠️⚠️';
		map['more.data.delete_all_message1'] = '您确定要继续吗？您的所有数据将永久删除且无法恢复';
		map['more.data.delete_all_header2'] = '最后一步⚠️⚠️';
		map['more.data.delete_all_message2'] = '删除账户后，您将删除所有保存的个人数据。您的账户、交易、预算和类别将被删除且无法恢复。您同意吗？';
		map['more.about_us.display'] = '应用信息';
		map['more.about_us.description'] = '查找 Monekin 的条款、重要信息，并通过报告错误或分享想法与我们联系';
		map['more.about_us.legal.display'] = '法律信息';
		map['more.about_us.legal.privacy'] = '隐私权政策';
		map['more.about_us.legal.terms'] = '使用条款';
		map['more.about_us.legal.licenses'] = '许可证';
		map['more.about_us.project.display'] = '项目';
		map['more.about_us.project.contributors'] = '合作者';
		map['more.about_us.project.contributors_descr'] = '所有让 Monekin 成长的开发者';
		map['more.about_us.project.contact'] = '联系我们';
		map['more.help_us.display'] = '帮助我们';
		map['more.help_us.description'] = '了解如何帮助 Monekin 变得越来越好';
		map['more.help_us.rate_us'] = '评价我们';
		map['more.help_us.rate_us_descr'] = '欢迎所有分数和评价！';
		map['more.help_us.share'] = '分享 Monekin';
		map['more.help_us.share_descr'] = '与朋友和家人分享我们的应用';
		map['more.help_us.share_text'] = 'Monekin！最好的个人理财应用 。此处下载';
		map['more.help_us.thanks'] = '谢谢您！';
		map['more.help_us.thanks_long'] = '您对 Monekin 和其它大大小小的开源项目的贡献成就了这一伟大项目。感谢您花时间做出贡献。';
		map['more.help_us.donate'] = '捐款';
		map['more.help_us.donate_descr'] = '通过您的捐款，您将帮助此应用持续改进完善。还有什么比请我喝一杯咖啡更好的感谢方式呢？';
		map['more.help_us.donate_success'] = '捐款已完成。非常感谢您的贡献！❤️';
		map['more.help_us.donate_err'] = '糟糕！接收您的付款时出现错误';
		map['more.help_us.report'] = '报告错误，留下建议……';

		_map = map;
		return map;
	}
}


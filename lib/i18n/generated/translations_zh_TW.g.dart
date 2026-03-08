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
class TranslationsZhTw with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhTw({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhTw,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-TW>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhTw _root = this; // ignore: unused_field

	@override 
	TranslationsZhTw $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhTw(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsZhTw ui_actions = _TranslationsUiActionsZhTw._(_root);
	@override late final _TranslationsGeneralZhTw general = _TranslationsGeneralZhTw._(_root);
	@override late final _TranslationsIntroZhTw intro = _TranslationsIntroZhTw._(_root);
	@override late final _TranslationsHomeZhTw home = _TranslationsHomeZhTw._(_root);
	@override late final _TranslationsFinancialHealthZhTw financial_health = _TranslationsFinancialHealthZhTw._(_root);
	@override late final _TranslationsStatsZhTw stats = _TranslationsStatsZhTw._(_root);
	@override late final _TranslationsIconSelectorZhTw icon_selector = _TranslationsIconSelectorZhTw._(_root);
	@override late final _TranslationsTransactionZhTw transaction = _TranslationsTransactionZhTw._(_root);
	@override late final _TranslationsTransferZhTw transfer = _TranslationsTransferZhTw._(_root);
	@override late final _TranslationsRecurrentTransactionsZhTw recurrent_transactions = _TranslationsRecurrentTransactionsZhTw._(_root);
	@override late final _TranslationsAccountZhTw account = _TranslationsAccountZhTw._(_root);
	@override late final _TranslationsCurrenciesZhTw currencies = _TranslationsCurrenciesZhTw._(_root);
	@override late final _TranslationsTagsZhTw tags = _TranslationsTagsZhTw._(_root);
	@override late final _TranslationsCategoriesZhTw categories = _TranslationsCategoriesZhTw._(_root);
	@override late final _TranslationsBudgetsZhTw budgets = _TranslationsBudgetsZhTw._(_root);
	@override late final _TranslationsGoalsZhTw goals = _TranslationsGoalsZhTw._(_root);
	@override late final _TranslationsDebtsZhTw debts = _TranslationsDebtsZhTw._(_root);
	@override late final _TranslationsTargetTimelineStatusesZhTw target_timeline_statuses = _TranslationsTargetTimelineStatusesZhTw._(_root);
	@override late final _TranslationsBackupZhTw backup = _TranslationsBackupZhTw._(_root);
	@override late final _TranslationsSettingsZhTw settings = _TranslationsSettingsZhTw._(_root);
	@override late final _TranslationsMoreZhTw more = _TranslationsMoreZhTw._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsZhTw implements TranslationsUiActionsEn {
	_TranslationsUiActionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get cancel => '取消';
	@override String get confirm => '確認';
	@override String get continue_text => '繼續';
	@override String get save => '保存';
	@override String get save_changes => '儲存變更';
	@override String get close_and_save => '儲存並關閉';
	@override String get add => '添加';
	@override String get edit => '編輯';
	@override String get delete => '刪除';
	@override String get see_more => '查看更多';
	@override String get select_all => '全選';
	@override String get deselect_all => '取消全選';
	@override String get select => '選擇';
	@override String get search => '搜尋';
	@override String get filter => '過濾';
	@override String get reset => '重設';
	@override String get submit => '提交';
	@override String get next => '下一步';
	@override String get previous => '上一步';
	@override String get back => '返回';
	@override String get reload => '重新載入';
	@override String get view => '檢視';
	@override String get download => '下載';
	@override String get upload => '上傳';
	@override String get retry => '重試';
	@override String get copy => '複製';
	@override String get paste => '貼上';
	@override String get undo => '還原';
	@override String get redo => '重做';
	@override String get open => '開啟';
	@override String get close => '關閉';
	@override String get apply => '套用';
	@override String get discard => '捨棄';
	@override String get refresh => '重新整理';
	@override String get share => '分享';
}

// Path: general
class _TranslationsGeneralZhTw implements TranslationsGeneralEn {
	_TranslationsGeneralZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get or => '或';
	@override String get understood => '明白了';
	@override String get unspecified => '未指定';
	@override String get quick_actions => '快速行動';
	@override String get details => '細節';
	@override String get balance => '平衡';
	@override String get account => '帳戶';
	@override String get accounts => '帳戶';
	@override String get categories => '類別';
	@override String get category => '類別';
	@override String get today => '今天';
	@override String get yesterday => '昨天';
	@override String get filters => '過濾';
	@override String get empty_warn => '哦！這裡非常空';
	@override String get search_no_results => '沒有符合您搜索條件的商品';
	@override String get insufficient_data => '數據不足';
	@override String get show_more_fields => '顯示更多欄位';
	@override String get show_less_fields => '顯示較少的欄位';
	@override String get tap_to_search => '點擊即可搜尋';
	@override String get delete_success => '項目刪除成功';
	@override late final _TranslationsGeneralLeaveWithoutSavingZhTw leave_without_saving = _TranslationsGeneralLeaveWithoutSavingZhTw._(_root);
	@override late final _TranslationsGeneralClipboardZhTw clipboard = _TranslationsGeneralClipboardZhTw._(_root);
	@override late final _TranslationsGeneralTimeZhTw time = _TranslationsGeneralTimeZhTw._(_root);
	@override late final _TranslationsGeneralTransactionOrderZhTw transaction_order = _TranslationsGeneralTransactionOrderZhTw._(_root);
	@override late final _TranslationsGeneralValidationsZhTw validations = _TranslationsGeneralValidationsZhTw._(_root);
}

// Path: intro
class _TranslationsIntroZhTw implements TranslationsIntroEn {
	_TranslationsIntroZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get start => '開始';
	@override String get skip => '跳過';
	@override String get next => '下一個';
	@override String get select_your_currency => '選擇您的貨幣';
	@override String get welcome_subtitle => '您的個人財務管家';
	@override String get welcome_subtitle2 => '100% 開放，100% 免費';
	@override String get welcome_footer => '登入即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隱私權政策</a>和<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>應用程式的使用條款</a>';
	@override String get offline_descr_title => '離線帳戶：';
	@override String get offline_descr => '您的資料只會儲存在您的裝置上，只要您不卸載應用程式或更換手機，資料就安全。為防止資料遺失，建議定期從應用程式設定中進行備份。';
	@override String get offline_start => '離線啟動會話';
	@override String get sl1_title => '選擇您的貨幣';
	@override String get sl1_descr => '您的預設貨幣將用於報告和一般圖表。您以後可以隨時在應用程式設定中更改貨幣和應用程式語言';
	@override String get sl2_title => '安全、隱私、可靠';
	@override String get sl2_descr => '您的資料只屬於您。我們將資訊直接儲存在您的設備上，無需通過外部伺服器。這使得即使沒有互聯網也可以使用該應用程式';
	@override String get sl2_descr2 => '此外，該應用程式的源代碼是公開的，任何人都可以對其進行協作並查看它是如何工作的';
	@override String get last_slide_title => '一切準備就緒';
	@override String get last_slide_descr => '有了 Monekin，您終於可以實現您想要的財務獨立。您將擁有圖表、預算、提示、統計數據以及更多有關您的資金的信息。';
	@override String get last_slide_descr2 => '我們希望您享受這次體驗！如有疑問、建議，請隨時與我們聯繫......';
}

// Path: home
class _TranslationsHomeZhTw implements TranslationsHomeEn {
	_TranslationsHomeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '儀表板';
	@override String get filter_transactions => '過濾交易';
	@override String get hello_day => '早安，';
	@override String get hello_night => '晚安，';
	@override String get total_balance => '總餘額';
	@override String get my_accounts => '我的帳戶';
	@override String get active_accounts => '活躍帳戶';
	@override String get no_accounts => '尚未建立帳戶';
	@override String get no_accounts_descr => '開始使用 Monekin 的所有魔力。至少建立一個帳戶以開始添加交易';
	@override String get last_transactions => '最後的交易';
	@override String get should_create_account_header => '哎呀！';
	@override String get should_create_account_message => '您必須至少擁有一個非存檔帳戶才能開始建立交易';
}

// Path: financial_health
class _TranslationsFinancialHealthZhTw implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '財務健康';
	@override late final _TranslationsFinancialHealthReviewZhTw review = _TranslationsFinancialHealthReviewZhTw._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeZhTw months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeZhTw._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageZhTw savings_percentage = _TranslationsFinancialHealthSavingsPercentageZhTw._(_root);
}

// Path: stats
class _TranslationsStatsZhTw implements TranslationsStatsEn {
	_TranslationsStatsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '統計數據';
	@override String get balance => '平衡';
	@override String get final_balance => '最終餘額';
	@override String get balance_by_account => '帳戶餘額';
	@override String get balance_by_account_subtitle => '我的大部分錢都在哪裡？';
	@override String get balance_by_currency => '按貨幣餘额';
	@override String get balance_by_currency_subtitle => '我有多少錢的外幣？';
	@override String get balance_evolution => '平衡趨勢';
	@override String get balance_evolution_subtitle => '我的錢比以前多了嗎？';
	@override String get compared_to_previous_period => '與上一时期相比';
	@override String get cash_flow => '現金流';
	@override String get cash_flow_subtitle => '我的支出是否少于我的收入？';
	@override String get by_periods => '按時期';
	@override String get by_categories => '按類別';
	@override String get by_tags => '按標籤';
	@override String get distribution => '分配';
	@override String get finance_health_resume => '恢復';
	@override String get finance_health_breakdown => '分解';
}

// Path: icon_selector
class _TranslationsIconSelectorZhTw implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '姓名：';
	@override String get icon => '圖示';
	@override String get color => '顏色';
	@override String get select_icon => '選擇一個圖示';
	@override String get select_color => '選擇一種顏色';
	@override String get custom_color => '自訂顏色';
	@override String get current_color_selection => '目前選擇';
	@override String get select_account_icon => '識別您的帳戶';
	@override String get select_category_icon => '確定您的類別';
	@override late final _TranslationsIconSelectorScopesZhTw scopes = _TranslationsIconSelectorScopesZhTw._(_root);
}

// Path: transaction
class _TranslationsTransactionZhTw implements TranslationsTransactionEn {
	_TranslationsTransactionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '交易',
		other: '交易',
	);
	@override String get create => '新交易';
	@override String get new_income => '新收入';
	@override String get new_expense => '新開支';
	@override String get new_success => '交易建立成功';
	@override String get edit => '編輯交易';
	@override String get edit_success => '交易編輯成功';
	@override String get edit_multiple => '編輯交易';
	@override String edit_multiple_success({required Object x}) => '${x}筆交易已成功編輯';
	@override String get duplicate => '複製交易';
	@override String get duplicate_short => '複製';
	@override String get duplicate_warning_message => '將在同一日期建立與此相同的交易，您想繼續嗎？';
	@override String get duplicate_success => '交易複製成功';
	@override String get delete => '刪除交易';
	@override String get delete_warning_message => '此操作不可逆轉。您的帳戶當前餘額和所有統計資料都將重新計算';
	@override String get delete_success => '交易已正確刪除';
	@override String get delete_multiple => '刪除交易';
	@override String delete_multiple_warning_message({required Object x}) => '此操作不可逆轉，將刪除${x}筆交易。您帳戶的當前餘額和所有統計資料都將重新計算';
	@override String delete_multiple_success({required Object x}) => '正確刪除了${x}筆交易';
	@override String get details => '動作詳情';
	@override late final _TranslationsTransactionNextPaymentsZhTw next_payments = _TranslationsTransactionNextPaymentsZhTw._(_root);
	@override late final _TranslationsTransactionListZhTw list = _TranslationsTransactionListZhTw._(_root);
	@override late final _TranslationsTransactionFiltersZhTw filters = _TranslationsTransactionFiltersZhTw._(_root);
	@override late final _TranslationsTransactionFormZhTw form = _TranslationsTransactionFormZhTw._(_root);
	@override late final _TranslationsTransactionReversedZhTw reversed = _TranslationsTransactionReversedZhTw._(_root);
	@override late final _TranslationsTransactionStatusZhTw status = _TranslationsTransactionStatusZhTw._(_root);
	@override late final _TranslationsTransactionTypesZhTw types = _TranslationsTransactionTypesZhTw._(_root);
}

// Path: transfer
class _TranslationsTransferZhTw implements TranslationsTransferEn {
	_TranslationsTransferZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '轉移';
	@override String get transfers => '轉移';
	@override String transfer_to({required Object account}) => '轉移至${account}';
	@override String get create => '轉移';
	@override String get need_two_accounts_warning_header => 'Ops!';
	@override String get need_two_accounts_warning_message => '至少需要兩個帳戶才能執行此操作。如果您需要調整或編輯該帳戶的當前餘額，請點擊編輯按鈕';
	@override late final _TranslationsTransferFormZhTw form = _TranslationsTransferFormZhTw._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsZhTw implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '經常交易';
	@override String get title_short => '經常交易';
	@override String get empty => '您似乎沒有任何經常交易。建立每月、每年或每週的經常交易，它將顯示在此處';
	@override String get total_expense_title => '每個期間的總收入';
	@override String get total_expense_descr => '*不考慮每次重複的開始和結束日期';
	@override late final _TranslationsRecurrentTransactionsDetailsZhTw details = _TranslationsRecurrentTransactionsDetailsZhTw._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusZhTw status = _TranslationsRecurrentTransactionsStatusZhTw._(_root);
}

// Path: account
class _TranslationsAccountZhTw implements TranslationsAccountEn {
	_TranslationsAccountZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get details => '帳戶詳細資料';
	@override String get date => '開業日期';
	@override String get close_date => '截止日期';
	@override String get reopen => '重新開立帳戶';
	@override String get reopen_short => '重新開放';
	@override String get reopen_descr => '您確定要重新開啟此帳戶嗎？';
	@override String get balance => '帳戶餘額';
	@override String get n_transactions => '交易數量';
	@override String get add_money => '增加金額';
	@override String get withdraw_money => '取出金額';
	@override String get no_accounts => '未發現此處顯示的交易。請點選底部的 \'+\' 按鈕新增交易';
	@override late final _TranslationsAccountTypesZhTw types = _TranslationsAccountTypesZhTw._(_root);
	@override late final _TranslationsAccountFormZhTw form = _TranslationsAccountFormZhTw._(_root);
	@override late final _TranslationsAccountDeleteZhTw delete = _TranslationsAccountDeleteZhTw._(_root);
	@override late final _TranslationsAccountCloseZhTw close = _TranslationsAccountCloseZhTw._(_root);
	@override late final _TranslationsAccountSelectZhTw select = _TranslationsAccountSelectZhTw._(_root);
}

// Path: currencies
class _TranslationsCurrenciesZhTw implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => '貨幣換算';
	@override String get currency => '貨幣';
	@override String get currency_settings => '貨幣設置';
	@override String get currency_manager => '貨幣管理';
	@override String get currency_manager_descr => '配置您的貨幣及其與其他貨幣的匯率';
	@override String get preferred_currency => '首選/基礎貨幣';
	@override String get tap_to_change_preferred_currency => '點擊即可更改';
	@override String get change_preferred_currency_title => '更改首選貨幣';
	@override String get change_preferred_currency_msg => '從現在開始，所有統計數據和預算都將以該貨幣顯示。帳戶和交易將保留其所擁有的貨幣。如果您執行此操作，所有保存的匯率都將被刪除。您想繼續嗎？';
	@override late final _TranslationsCurrenciesExchangeRateFormZhTw exchange_rate_form = _TranslationsCurrenciesExchangeRateFormZhTw._(_root);
	@override late final _TranslationsCurrenciesTypesZhTw types = _TranslationsCurrenciesTypesZhTw._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormZhTw currency_form = _TranslationsCurrenciesCurrencyFormZhTw._(_root);
	@override String get delete_all_success => '刪除匯率成功';
	@override String get historical => '歷史利率';
	@override String get historical_empty => '沒有找到該貨幣的歷史匯率';
	@override String get exchange_rate => '匯率';
	@override String get exchange_rates => '匯率';
	@override String get min_exchange_rate => '最低匯率';
	@override String get max_exchange_rate => '最高匯率';
	@override String get empty => '在此處添加匯率，以便如果您的帳戶使用基礎貨幣以外的貨幣，我們的圖表會更加準確';
	@override String get select_a_currency => '選擇貨幣';
	@override String get search => '按名稱或貨幣代碼搜尋';
}

// Path: tags
class _TranslationsTagsZhTw implements TranslationsTagsEn {
	_TranslationsTagsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '標籤',
		other: '標籤',
	);
	@override late final _TranslationsTagsFormZhTw form = _TranslationsTagsFormZhTw._(_root);
	@override late final _TranslationsTagsSelectZhTw select = _TranslationsTagsSelectZhTw._(_root);
	@override String get empty_list => '您還沒有建立任何標籤。標籤和類別是對您的動作進行分類的好方法';
	@override String get without_tags => '沒有標籤';
	@override String get add => '添加標籤';
	@override String get create => '建立標籤';
	@override String get create_success => '標籤建立成功';
	@override String get already_exists => '此標籤名稱已存在。您可能需要編輯它';
	@override String get edit => '編輯標籤';
	@override String get edit_success => '標籤編輯成功';
	@override String get delete_success => '類別刪除成功';
	@override String get delete_warning_header => '刪除標籤？';
	@override String get delete_warning_message => '此操作不會刪除具有此標籤的交易。';
}

// Path: categories
class _TranslationsCategoriesZhTw implements TranslationsCategoriesEn {
	_TranslationsCategoriesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get unknown => '未知類別';
	@override String get create => '建立類別';
	@override String get create_success => '類別建立成功';
	@override String get new_category => '新類別';
	@override String get already_exists => '該類別的名稱已存在。也許您可以編輯';
	@override String get edit => '編輯類別';
	@override String get edit_success => '類別編輯成功';
	@override String get name => '分類名稱';
	@override String get type => '類別類型';
	@override String get both_types => '兩種類型';
	@override String get subcategories => '子類別';
	@override String get subcategories_add => '新增子類別';
	@override String get make_parent => '按類別製作';
	@override String get make_child => '建立一個子類別';
	@override String make_child_warning1({required Object destiny}) => '此類別及其子類別將成為<b>${destiny}</b>的子類別。';
	@override String make_child_warning2({required Object x, required Object destiny}) => '他們的交易<b>(${x})</b>將被移至<b>${destiny}</b>類別中建立的新子類別。';
	@override String get make_child_success => '子類別建立成功';
	@override String get merge => '與另一個類別合併';
	@override String merge_warning1({required Object from, required Object x, required Object destiny}) => '與類別<b>${from}</b>相關的所有交易 (${x}) 將移至類別<b>${destiny}</b>';
	@override String merge_warning2({required Object from}) => '類別<b>${from}</b>將被不可逆轉地刪除。 ';
	@override String get merge_success => '類別合併成功';
	@override String get delete_success => '類別已成功刪除';
	@override String get delete_warning_header => '刪除類別？';
	@override String delete_warning_message({required Object x}) => '此操作將不可逆轉地刪除與此類別相關的所有交易<b>(${x})</b>。';
	@override late final _TranslationsCategoriesSelectZhTw select = _TranslationsCategoriesSelectZhTw._(_root);
}

// Path: budgets
class _TranslationsBudgetsZhTw implements TranslationsBudgetsEn {
	_TranslationsBudgetsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '預算';
	@override String get status => '預算狀況';
	@override String get repeated => '週期性';
	@override String get one_time => '一次性';
	@override String get actives => '活躍';
	@override String get from_budgeted => '從預算';
	@override String get days_left => '還剩幾天';
	@override String get days_to_start => '開始的日子';
	@override String get since_expiration => '自到期日起的天數';
	@override String get no_budgets => '此部分中似乎沒有可顯示的預算。首先單擊下面的按鈕以建立預算';
	@override String get delete => '刪除預算';
	@override String get delete_warning => '此操作不可逆轉。引用此報價的類別和交易不會被刪除';
	@override late final _TranslationsBudgetsFormZhTw form = _TranslationsBudgetsFormZhTw._(_root);
	@override late final _TranslationsBudgetsDetailsZhTw details = _TranslationsBudgetsDetailsZhTw._(_root);
	@override late final _TranslationsBudgetsTargetTimelineStatusesZhTw target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesZhTw._(_root);
	@override late final _TranslationsBudgetsProgressZhTw progress = _TranslationsBudgetsProgressZhTw._(_root);
}

// Path: goals
class _TranslationsGoalsZhTw implements TranslationsGoalsEn {
	_TranslationsGoalsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '目標';
	@override String get status => '目標狀態';
	@override late final _TranslationsGoalsTypeZhTw type = _TranslationsGoalsTypeZhTw._(_root);
	@override String get empty_title => '未找到目標';
	@override String get empty_description => '創建一個新目標以開始追蹤您的儲蓄！';
	@override String get delete => '刪除目標';
	@override String get delete_warning => '此操作不可逆。涉及此目標的類別和交易將不會被刪除';
	@override late final _TranslationsGoalsFormZhTw form = _TranslationsGoalsFormZhTw._(_root);
	@override late final _TranslationsGoalsDetailsZhTw details = _TranslationsGoalsDetailsZhTw._(_root);
	@override late final _TranslationsGoalsTargetTimelineStatusesZhTw target_timeline_statuses = _TranslationsGoalsTargetTimelineStatusesZhTw._(_root);
	@override late final _TranslationsGoalsProgressZhTw progress = _TranslationsGoalsProgressZhTw._(_root);
}

// Path: debts
class _TranslationsDebtsZhTw implements TranslationsDebtsEn {
	_TranslationsDebtsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '債務',
		other: '債務',
	);
	@override late final _TranslationsDebtsFormZhTw form = _TranslationsDebtsFormZhTw._(_root);
	@override late final _TranslationsDebtsDirectionZhTw direction = _TranslationsDebtsDirectionZhTw._(_root);
	@override late final _TranslationsDebtsStatusZhTw status = _TranslationsDebtsStatusZhTw._(_root);
	@override late final _TranslationsDebtsDetailsZhTw details = _TranslationsDebtsDetailsZhTw._(_root);
	@override late final _TranslationsDebtsEmptyZhTw empty = _TranslationsDebtsEmptyZhTw._(_root);
	@override late final _TranslationsDebtsActionsZhTw actions = _TranslationsDebtsActionsZhTw._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesZhTw implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get active => '進行中';
	@override String get past => '已完成';
	@override String get future => '未開始';
}

// Path: backup
class _TranslationsBackupZhTw implements TranslationsBackupEn {
	_TranslationsBackupZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => '未選擇文件';
	@override String get no_directory_selected => '未選擇目錄';
	@override late final _TranslationsBackupExportZhTw export = _TranslationsBackupExportZhTw._(_root);
	@override late final _TranslationsBackupImportZhTw import = _TranslationsBackupImportZhTw._(_root);
	@override late final _TranslationsBackupAboutZhTw about = _TranslationsBackupAboutZhTw._(_root);
}

// Path: settings
class _TranslationsSettingsZhTw implements TranslationsSettingsEn {
	_TranslationsSettingsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title_long => '設定與自訂';
	@override String get title_short => '設定';
	@override String get description => '主題、語言、數據等';
	@override String get edit_profile => '編輯個人資料';
	@override late final _TranslationsSettingsGeneralZhTw general = _TranslationsSettingsGeneralZhTw._(_root);
	@override late final _TranslationsSettingsSecurityZhTw security = _TranslationsSettingsSecurityZhTw._(_root);
	@override late final _TranslationsSettingsTransactionsZhTw transactions = _TranslationsSettingsTransactionsZhTw._(_root);
	@override late final _TranslationsSettingsAppearanceZhTw appearance = _TranslationsSettingsAppearanceZhTw._(_root);
}

// Path: more
class _TranslationsMoreZhTw implements TranslationsMoreEn {
	_TranslationsMoreZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '更多';
	@override String get title_long => '更多';
	@override late final _TranslationsMoreDataZhTw data = _TranslationsMoreDataZhTw._(_root);
	@override late final _TranslationsMoreAboutUsZhTw about_us = _TranslationsMoreAboutUsZhTw._(_root);
	@override late final _TranslationsMoreHelpUsZhTw help_us = _TranslationsMoreHelpUsZhTw._(_root);
}

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingZhTw implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '不保存就離開？';
	@override String get message => '您有未保存的更改，確定要離開而不保存它們嗎？';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardZhTw implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x}已複製到剪貼簿';
	@override String get error => '複製錯誤';
}

// Path: general.time
class _TranslationsGeneralTimeZhTw implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get start_date => '開始日期';
	@override String get end_date => '結束日期';
	@override String get from_date => '從日期';
	@override String get until_date => '截止日期';
	@override String get date => '日期';
	@override String get datetime => '約會時間';
	@override String get time => '時間';
	@override String get each => '每個';
	@override String get after => '後';
	@override late final _TranslationsGeneralTimeRangesZhTw ranges = _TranslationsGeneralTimeRangesZhTw._(_root);
	@override late final _TranslationsGeneralTimePeriodicityZhTw periodicity = _TranslationsGeneralTimePeriodicityZhTw._(_root);
	@override late final _TranslationsGeneralTimeCurrentZhTw current = _TranslationsGeneralTimeCurrentZhTw._(_root);
	@override late final _TranslationsGeneralTimeAllZhTw all = _TranslationsGeneralTimeAllZhTw._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderZhTw implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '訂單交易';
	@override String get category => '按類別';
	@override String get quantity => '按數量';
	@override String get date => '按日期';
}

// Path: general.validations
class _TranslationsGeneralValidationsZhTw implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get form_error => '修正表單中指示的欄位以繼續';
	@override String get required => '必填項目';
	@override String get positive => '應該是積極的';
	@override String min_number({required Object x}) => '應該大於${x}';
	@override String max_number({required Object x}) => '應小於${x}';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewZhTw implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

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
				return '平均';
			case GenderContext.female:
				return '平均';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '一般';
			case GenderContext.female:
				return '一般';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '非常糟糕';
			case GenderContext.female:
				return '非常糟糕';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return '數據不足';
			case GenderContext.female:
				return '數據不足';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrZhTw descr = _TranslationsFinancialHealthReviewDescrZhTw._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeZhTw implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '存活率';
	@override String get subtitle => '考慮到您的餘額，您可以在沒有收入的情況下度過多長時間';
	@override String get text_zero => '按照這樣的開支，沒有收入你一個月都活不下去！';
	@override String get text_one => '按照這樣的收入，如果沒有收入，你幾乎無法生存大約一個月！';
	@override String text_other({required Object n}) => '以這樣的支出速度，如果沒有收入，您大約可以生存 <b>${n}個月</b>。';
	@override String get text_infinite => '以這樣的支出速度，如果沒有收入，您大約可以<b>一生</b>生存。';
	@override String get suggestion => '請記住，建議始終將此比率保持在至少 5 個月以上。如果您發現自己沒有足夠的儲蓄緩衝，請減少不必要的開支。';
	@override String get insufficient_data => '看來我們沒有足夠的開支來計算您在沒有收入的情況下可以生存多少個月。輸入幾筆交易，然後回到這裡檢查您的財務狀況';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageZhTw implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '儲蓄百分比';
	@override String get subtitle => '你的收入中有哪一部分沒有在這段時間花掉';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextZhTw text = _TranslationsFinancialHealthSavingsPercentageTextZhTw._(_root);
	@override String get suggestion => '請記住，建議將收入的至少 15-20% 存起來。';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesZhTw implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get transport => '運輸';
	@override String get money => '錢';
	@override String get food => '食物';
	@override String get medical => '健康';
	@override String get entertainment => '閒暇';
	@override String get technology => '技術';
	@override String get other => '其他的';
	@override String get logos_financial_institutions => '金融機構';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsZhTw implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get accept => '接受';
	@override String get skip => '跳過';
	@override String get skip_success => '成功跳過交易';
	@override String get skip_dialog_title => '跳過交易';
	@override String skip_dialog_msg({required Object date}) => '此操作不可逆轉。我們會將下次移動的日期移至${date}';
	@override String get accept_today => '今天接受';
	@override String accept_in_required_date({required Object date}) => '在要求的日期 (${date}) 接受';
	@override String get accept_dialog_title => '接受交易';
	@override String get accept_dialog_msg_single => '該交易的新狀態將為空。您可以隨時重新編輯該交易的狀態';
	@override String accept_dialog_msg({required Object date}) => '此操作將建立日期為${date}的新交易。您將能夠在交易頁面上查看此交易的詳細資訊';
	@override String get recurrent_rule_finished => '循環規則已完成，無需再支付！';
}

// Path: transaction.list
class _TranslationsTransactionListZhTw implements TranslationsTransactionListEn {
	_TranslationsTransactionListZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get all => '所有交易';
	@override String get empty => '未發現此處顯示的交易。在應用程式中添加一些交易，也許您下次會有更好的運氣';
	@override String get searcher_placeholder => '按類別、描述搜尋...';
	@override String get searcher_no_results => '未找到符合搜尋條件的交易';
	@override String get loading => '正在加載更多交易...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '${n} 已選取',
		other: '${n} 已選取',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '已選擇 ${n} 筆交易',
		other: '選擇 ${n} 筆交易',
	);
	@override late final _TranslationsTransactionListBulkEditZhTw bulk_edit = _TranslationsTransactionListBulkEditZhTw._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersZhTw implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '交易過濾器';
	@override String get from_value => '從金額';
	@override String get to_value => '最多金額';
	@override String from_value_def({required Object x}) => '來自 ${x}';
	@override String to_value_def({required Object x}) => '最多 ${x}';
	@override String from_date_def({required Object date}) => '從${date}開始';
	@override String to_date_def({required Object date}) => '截至 ${date}';
	@override String get reset => '重置過濾器';
	@override late final _TranslationsTransactionFiltersSavedZhTw saved = _TranslationsTransactionFiltersSavedZhTw._(_root);
}

// Path: transaction.form
class _TranslationsTransactionFormZhTw implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsZhTw validators = _TranslationsTransactionFormValidatorsZhTw._(_root);
	@override String get title => '交易標題';
	@override String get title_short => '資質';
	@override String get value => '交易價值';
	@override String get tap_to_see_more => '點擊查看更多詳細資訊';
	@override String get no_tags => '-- 無標籤 --';
	@override String get description => '描述';
	@override String get description_info => '點擊此處輸入有關此交易的更詳細描述';
	@override String exchange_to_preferred_title({required Object currency}) => '匯率為${currency}';
	@override String get exchange_to_preferred_in_date => '交易日';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedZhTw implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '逆向交易';
	@override String get title_short => '逆向交易';
	@override String get description_for_expenses => '儘管是收入交易，但它的金額為正數。這些類型的交易可用於表示先前記錄的收入的返還，例如退款或償還債務。';
	@override String get description_for_incomes => '儘管是一項收入交易，但其金額為負數。這些類型的交易可用於作廢或更正錯誤記錄的收入，反映資金的返還或退款或記錄債務的支付。';
}

// Path: transaction.status
class _TranslationsTransactionStatusZhTw implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '地位',
		other: '狀態',
	);
	@override String get display_long => '交易狀態';
	@override String tr_status({required Object status}) => '${status}交易';
	@override String get none => '無狀態';
	@override String get none_descr => '沒有特定狀態的交易';
	@override String get reconciled => '已驗證';
	@override String get reconciled_descr => '此交易已經過驗證，並且與您銀行的真實交易相對應';
	@override String get unreconciled => '未驗證';
	@override String get unreconciled_descr => '此交易尚未經過驗證，因此尚未出現在您的真實銀行帳戶中。但是，它將計算 Monekin 中的餘額和統計數據';
	@override String get pending => '待辦';
	@override String get pending_descr => '此交易正在等待處理，因此在計算餘額和統計數據時不會考慮它';
	@override String get voided => '作廢';
	@override String get voided_descr => '由於付款錯誤或任何其他原因導致的交易無效/取消。在計算餘額和統計時不會考慮該交易';
}

// Path: transaction.types
class _TranslationsTransactionTypesZhTw implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '交易類型',
		other: '交易類型',
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
		one: '轉移',
		other: '轉移',
	);
}

// Path: transfer.form
class _TranslationsTransferFormZhTw implements TranslationsTransferFormEn {
	_TranslationsTransferFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get from => '原始帳戶';
	@override String get to => '目的地帳戶';
	@override late final _TranslationsTransferFormValueInDestinyZhTw value_in_destiny = _TranslationsTransferFormValueInDestinyZhTw._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsZhTw implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '經常交易';
	@override String get descr => '此交易的下一步動作如下所示。您可以接受第一步動作或跳過此動作';
	@override String get last_payment_info => '此動作是循環規則的最後一個，因此當確認此動作時，該規則將自動刪除';
	@override String get delete_header => '刪除重複交易';
	@override String get delete_message => '此操作不可逆轉，不會影響您已確認/付款的交易';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusZhTw implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => '延遲了 ${x}d';
	@override String coming_in({required Object x}) => '${x} 天後';
}

// Path: account.types
class _TranslationsAccountTypesZhTw implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '帳戶類型';
	@override String get warning => '帳戶類型一旦選擇，以後將無法更改';
	@override String get normal => '普通帳戶';
	@override String get normal_descr => '對於記錄您的日常財務很有用。這是最常見的帳戶，它可以讓您添加支出、收入......';
	@override String get saving => '儲蓄帳戶';
	@override String get saving_descr => '您只能從其他帳戶中添加和提取資金。非常適合開始存錢';
}

// Path: account.form
class _TranslationsAccountFormZhTw implements TranslationsAccountFormEn {
	_TranslationsAccountFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '帳戶名稱';
	@override String get name_placeholder => '例如：儲蓄帳戶';
	@override String get notes => '筆記';
	@override String get notes_placeholder => '輸入有關此帳戶的一些註釋/描述';
	@override String get initial_balance => '初始餘額';
	@override String get current_balance => '當前餘額';
	@override String get create => '建立帳戶';
	@override String get edit => '編輯帳戶';
	@override String get currency_not_found_warn => '您沒有該貨幣的匯率資訊。1.0 將用作預設匯率。您可以在設定中修改';
	@override String get already_exists => '已經有另一個同名，請再寫一個';
	@override String get tr_before_opening_date => '該帳戶中有日期早於開戶日期的交易';
	@override String get iban => 'iban';
	@override String get swift => 'swift';
}

// Path: account.delete
class _TranslationsAccountDeleteZhTw implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get warning_header => '刪除帳戶？';
	@override String get warning_text => '此操作將刪除該帳戶及其所有交易';
	@override String get success => '帳號刪除成功';
}

// Path: account.close
class _TranslationsAccountCloseZhTw implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '關閉帳戶';
	@override String get title_short => '關閉';
	@override String get warn => '此帳戶將不再出現在某些清單中，您將無法在其中建立日期晚於下面指定的日期的交易。此操作不會影響任何交易或餘額，您也可以隨時重新開啟此帳戶時間。 ';
	@override String get should_have_zero_balance => '此帳戶中的當前餘額必須為 0 才能關閉它。請在繼續之前編輯帳戶';
	@override String get should_have_no_transactions => '此帳戶在指定的關閉日期之後有交易。請刪除它們或編輯帳戶關閉日期，然後再繼續';
	@override String get success => '帳戶關閉成功';
	@override String get unarchive_succes => '帳戶已成功重新開設';
}

// Path: account.select
class _TranslationsAccountSelectZhTw implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get one => '選擇一個帳戶';
	@override String get all => '所有帳戶';
	@override String get multiple => '選擇帳戶';
}

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormZhTw implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => '幣種不能等於用戶幣種';
	@override String get override_existing_warn => '該貨幣在該日期的匯率已存在。如果繼續，前一個將會被覆蓋';
	@override String get specify_a_currency => '請指定貨幣';
	@override String get add => '添加匯率';
	@override String get add_success => '匯率新增成功';
	@override String get edit => '編輯匯率';
	@override String get edit_success => '匯率編輯成功';
	@override String get remove_all => '刪除所有匯率';
	@override String get remove_all_warning => '此操作不可逆轉，並將刪除該貨幣的所有匯率';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesZhTw implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '貨幣類型';
	@override String get fiat => '菲亞特';
	@override String get crypto => '加密貨幣';
	@override String get other => '其他';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormZhTw implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '顯示名稱';
	@override String get code => '貨幣代碼';
	@override String get symbol => '象徵';
	@override String get decimal_digits => '小數位';
	@override String get create => '創建貨幣';
	@override String get create_success => '貨幣創建成功';
	@override String get edit => '編輯貨幣';
	@override String get edit_success => '貨幣編輯成功';
	@override String get delete => '刪除貨幣';
	@override String get delete_success => '幣種刪除成功';
	@override String get already_exists => '具有此代碼的貨幣已存在。您可能想要編輯它';
}

// Path: tags.form
class _TranslationsTagsFormZhTw implements TranslationsTagsFormEn {
	_TranslationsTagsFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '標籤名';
	@override String get description => '描述';
}

// Path: tags.select
class _TranslationsTagsSelectZhTw implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '選擇標籤';
	@override String get all => '所有標籤';
}

// Path: categories.select
class _TranslationsCategoriesSelectZhTw implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '選擇類別';
	@override String get select_one => '選擇一個類別';
	@override String get select_subcategory => '選擇一個子類別';
	@override String get without_subcategory => '沒有子類別';
	@override String get all => '所有類別';
	@override String get all_short => '全部';
}

// Path: budgets.form
class _TranslationsBudgetsFormZhTw implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '添加預算';
	@override String get name => '預算名稱';
	@override String get value => '數量限制';
	@override String get create => '添加預算';
	@override String get create_success => '預算創建成功';
	@override String get edit => '編輯預算';
	@override String get edit_success => '預算編輯成功';
	@override String get negative_warn => '預算不能有負數';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsZhTw implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '預算詳情';
	@override String get statistics => '統計數據';
	@override String get budget_value => '預算';
	@override String get expend_evolution => '支出變化';
	@override String get no_transactions => '看來您還沒有做出與此預算相關的任何收入';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesZhTw implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get active => '目前預算';
	@override String get past => '已完成預算';
	@override String get future => '未來預算';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressZhTw implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsZhTw labels = _TranslationsBudgetsProgressLabelsZhTw._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionZhTw description = _TranslationsBudgetsProgressDescriptionZhTw._(_root);
}

// Path: goals.type
class _TranslationsGoalsTypeZhTw implements TranslationsGoalsTypeEn {
	_TranslationsGoalsTypeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '目標類型';
	@override late final _TranslationsGoalsTypeIncomeZhTw income = _TranslationsGoalsTypeIncomeZhTw._(_root);
	@override late final _TranslationsGoalsTypeExpenseZhTw expense = _TranslationsGoalsTypeExpenseZhTw._(_root);
}

// Path: goals.form
class _TranslationsGoalsFormZhTw implements TranslationsGoalsFormEn {
	_TranslationsGoalsFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get new_title => '新目標';
	@override String get edit_title => '編輯目標';
	@override String get target_amount => '目標金額';
	@override String get initial_amount => '初始金額';
	@override String get name => '名稱';
	@override String get name_hint => '我的儲蓄目標';
	@override String get create_success => '目標建立成功';
	@override String get edit_success => '目標編輯成功';
	@override String get negative_warn => '目標金額不能為負數';
}

// Path: goals.details
class _TranslationsGoalsDetailsZhTw implements TranslationsGoalsDetailsEn {
	_TranslationsGoalsDetailsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '目標詳情';
	@override String get statistics => '統計';
	@override String get goal_value => '目標值';
	@override String get evolution => '趨勢';
	@override String get no_transactions => '看來您還沒有進行任何與此目標相關的交易';
}

// Path: goals.target_timeline_statuses
class _TranslationsGoalsTargetTimelineStatusesZhTw implements TranslationsGoalsTargetTimelineStatusesEn {
	_TranslationsGoalsTargetTimelineStatusesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get active => '進行中的目標';
	@override String get past => '已結束的目標';
	@override String get future => '未來的目標';
}

// Path: goals.progress
class _TranslationsGoalsProgressZhTw implements TranslationsGoalsProgressEn {
	_TranslationsGoalsProgressZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGoalsProgressLabelsZhTw labels = _TranslationsGoalsProgressLabelsZhTw._(_root);
	@override late final _TranslationsGoalsProgressDescriptionZhTw description = _TranslationsGoalsProgressDescriptionZhTw._(_root);
}

// Path: debts.form
class _TranslationsDebtsFormZhTw implements TranslationsDebtsFormEn {
	_TranslationsDebtsFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get name => '債務名稱';
	@override String get initial_amount => '初始金額';
	@override String get total_amount => '總金額';
	@override String get step_initial_value => '初始值';
	@override String get step_details => '細節';
	@override late final _TranslationsDebtsFormFromTransactionZhTw from_transaction = _TranslationsDebtsFormFromTransactionZhTw._(_root);
	@override late final _TranslationsDebtsFormFromAmountZhTw from_amount = _TranslationsDebtsFormFromAmountZhTw._(_root);
}

// Path: debts.direction
class _TranslationsDebtsDirectionZhTw implements TranslationsDebtsDirectionEn {
	_TranslationsDebtsDirectionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get lent => '借出';
	@override String get borrowed => '借來的';
}

// Path: debts.status
class _TranslationsDebtsStatusZhTw implements TranslationsDebtsStatusEn {
	_TranslationsDebtsStatusZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get active => '積極的';
	@override String get close => '關閉';
}

// Path: debts.details
class _TranslationsDebtsDetailsZhTw implements TranslationsDebtsDetailsEn {
	_TranslationsDebtsDetailsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get collected_amount => '收取金額';
	@override String get remaining => '其餘的';
	@override String get no_deadline => '無截止日期';
	@override String in_days({required Object x}) => '${x} 天后';
	@override String get due_today => '今天到期';
	@override String days_ago({required Object x}) => '${x} days ago';
	@override String overdue_by({required Object x}) => 'Overdue by ${x} days';
	@override String get per_day => '/ 天';
	@override String get no_transactions => '未找到該債務的交易';
}

// Path: debts.empty
class _TranslationsDebtsEmptyZhTw implements TranslationsDebtsEmptyEn {
	_TranslationsDebtsEmptyZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get no_debts_active => '未發現活躍債務。首先點擊下面的按鈕建立新債務';
	@override String get no_debts_closed => '未發現已結清的債務。当您收回所有债务或支付所有所欠债务时，债务就结束了。';
}

// Path: debts.actions
class _TranslationsDebtsActionsZhTw implements TranslationsDebtsActionsEn {
	_TranslationsDebtsActionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDebtsActionsEditZhTw edit = _TranslationsDebtsActionsEditZhTw._(_root);
	@override late final _TranslationsDebtsActionsDeleteZhTw delete = _TranslationsDebtsActionsDeleteZhTw._(_root);
	@override late final _TranslationsDebtsActionsAddRegisterZhTw add_register = _TranslationsDebtsActionsAddRegisterZhTw._(_root);
	@override late final _TranslationsDebtsActionsLinkTransactionZhTw link_transaction = _TranslationsDebtsActionsLinkTransactionZhTw._(_root);
	@override late final _TranslationsDebtsActionsNewTransactionZhTw new_transaction = _TranslationsDebtsActionsNewTransactionZhTw._(_root);
	@override late final _TranslationsDebtsActionsCreateZhTw create = _TranslationsDebtsActionsCreateZhTw._(_root);
}

// Path: backup.export
class _TranslationsBackupExportZhTw implements TranslationsBackupExportEn {
	_TranslationsBackupExportZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '匯出您的資料';
	@override String get title_short => '匯出';
	@override String get type_of_export => '出口類型';
	@override String get other_options => '選項';
	@override String get all => '完整備份';
	@override String get all_descr => '匯出您的所有資料（帳戶、交易、預算、設定...）。隨時重新匯入它們，這樣您就不會丟失任何內容。';
	@override String get transactions => '交易備份';
	@override String get transactions_descr => '以 CSV 格式匯出您的交易，以便您可以在其他程式或應用程式中更輕鬆地分析它們。';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '1 筆交易要導出',
		other: '要導出的 ${n} 筆交易',
	);
	@override String get description => '以不同格式下載資料';
	@override String get send_file => '發送文件';
	@override String get see_folder => '查看文件夾';
	@override String success({required Object x}) => '檔案已在${x}中成功儲存/下載';
	@override String get error => '下載檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員';
	@override String get dialog_title => '儲存/傳送文件';
}

// Path: backup.import
class _TranslationsBackupImportZhTw implements TranslationsBackupImportEn {
	_TranslationsBackupImportZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '匯入您的資料';
	@override String get title_short => '匯入';
	@override String get restore_backup => '恢復備份';
	@override String get restore_backup_descr => '從 Monekin 匯入先前儲存的資料庫。此操作將用新資料取代任何當前應用程式資料';
	@override String get restore_backup_warn_description => '導入新資料庫時，您將丟失應用程式中當前保存的所有資料。建議在繼續之前進行備份。請勿在此處上傳任何來源不明的文件，僅上傳您之前從其下載的文件 Monekin';
	@override String get restore_backup_warn_title => '覆蓋所有數據';
	@override String get select_other_file => '選擇其他文件';
	@override String get tap_to_select_file => '點選選擇檔案';
	@override late final _TranslationsBackupImportManualImportZhTw manual_import = _TranslationsBackupImportManualImportZhTw._(_root);
	@override String get success => '導入成功';
	@override String get error => '匯入檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員。';
	@override String get cancelled => '導入已被用戶取消';
}

// Path: backup.about
class _TranslationsBackupAboutZhTw implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '有關您的資料庫的資訊';
	@override String get create_date => '建立日期';
	@override String get modify_date => '上一次更改';
	@override String get last_backup => '上次備份';
	@override String get size => '檔案大小';
}

// Path: settings.general
class _TranslationsSettingsGeneralZhTw implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get menu_title => '常規設定';
	@override String get menu_descr => '語言、隱私等';
	@override String get show_all_decimals => '顯示所有小數位';
	@override String get show_all_decimals_descr => '即使是末尾為零，也顯示所有小數位';
	@override late final _TranslationsSettingsGeneralLanguageZhTw language = _TranslationsSettingsGeneralLanguageZhTw._(_root);
	@override late final _TranslationsSettingsGeneralLocaleZhTw locale = _TranslationsSettingsGeneralLocaleZhTw._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityZhTw implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '安全';
	@override String get private_mode_at_launch => '啟動時啟用的隱私模式';
	@override String get private_mode_at_launch_descr => '默認以隱私模式啟動應用程序';
	@override String get private_mode => '隱私模式';
	@override String get private_mode_descr => '隱藏所有貨幣值';
	@override String get private_mode_activated => '隱私模式已啟用';
	@override String get private_mode_deactivated => '隱私模式已禁用';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsZhTw implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get menu_title => '交易';
	@override String get menu_descr => '配置交易行為';
	@override String get title => '交易設定';
	@override late final _TranslationsSettingsTransactionsStyleZhTw style = _TranslationsSettingsTransactionsStyleZhTw._(_root);
	@override late final _TranslationsSettingsTransactionsSwipeActionsZhTw swipe_actions = _TranslationsSettingsTransactionsSwipeActionsZhTw._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesZhTw default_values = _TranslationsSettingsTransactionsDefaultValuesZhTw._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeZhTw default_type = _TranslationsSettingsTransactionsDefaultTypeZhTw._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceZhTw implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get menu_title => '主題與風格';
	@override String get menu_descr => '主題選擇、顏色以及與應用程式外觀相關的其他內容';
	@override String get theme_and_colors => '主題和顏色';
	@override late final _TranslationsSettingsAppearanceThemeZhTw theme = _TranslationsSettingsAppearanceThemeZhTw._(_root);
	@override String get amoled_mode => 'amoled mode';
	@override String get amoled_mode_descr => '盡可能使用純黑色壁紙。這對 AMOLED 螢幕設備的電池略有幫助';
	@override String get dynamic_colors => '動態色彩';
	@override String get dynamic_colors_descr => '盡可能使用系統強調色';
	@override String get accent_color => '強調色';
	@override String get accent_color_descr => '選擇應用程式用來強調介面某些部分的顏色';
	@override String get text => '文本';
	@override String get font => '字體';
	@override String get font_platform => '平台';
}

// Path: more.data
class _TranslationsMoreDataZhTw implements TranslationsMoreDataEn {
	_TranslationsMoreDataZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '數據';
	@override String get display_descr => '匯出和匯入您的數據，這樣您就不會丟失任何東西';
	@override String get delete_all => '刪除我的資料';
	@override String get delete_all_header1 => 'Stop right there padawan ⚠️⚠️';
	@override String get delete_all_message1 => '您確定要繼續嗎？您的所有資料將永久刪除且無法恢復';
	@override String get delete_all_header2 => '最後一步⚠️⚠️';
	@override String get delete_all_message2 => '刪除帳戶後，您將刪除所有儲存的個人資料。您的帳戶、交易、預算和類別將被刪除且無法恢復。您同意嗎？';
}

// Path: more.about_us
class _TranslationsMoreAboutUsZhTw implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '應用程式資訊';
	@override String get description => '查找 Monekin 的條款、重要資訊，並透過回報錯誤或分享想法與我們聯繫';
	@override late final _TranslationsMoreAboutUsLegalZhTw legal = _TranslationsMoreAboutUsLegalZhTw._(_root);
	@override late final _TranslationsMoreAboutUsProjectZhTw project = _TranslationsMoreAboutUsProjectZhTw._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsZhTw implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '幫助我們';
	@override String get description => '了解如何幫助 Monekin 變得越來越好';
	@override String get rate_us => '評價我們';
	@override String get rate_us_descr => '歡迎任何價格！';
	@override String get share => '分享 Monekin';
	@override String get share_descr => '與朋友和家人分享我們的應用程式';
	@override String get share_text => 'Monekin！最好的個人理財應用程式。在這裡下載';
	@override String get thanks => '謝謝你！';
	@override String get thanks_long => '您對 Monekin 和其他大大小小的開源專案的貢獻使得這樣偉大的專案成為可能。感謝您花時間做出貢獻。';
	@override String get donate => '做捐贈';
	@override String get donate_descr => '透過您的捐款，您將幫助該應用程式繼續改進。還有什麼比邀請我喝咖啡來感謝所做的工作更好的方式呢？';
	@override String get donate_success => '捐款已完成。非常感謝您的貢獻！❤️';
	@override String get donate_err => '糟糕！接收您的付款時出現錯誤';
	@override String get report => '報告錯誤、留下建議…';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesZhTw implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '時間範圍';
	@override String get it_repeat => '重複';
	@override String get it_ends => '結束';
	@override String get forever => '永遠';
	@override late final _TranslationsGeneralTimeRangesTypesZhTw types = _TranslationsGeneralTimeRangesTypesZhTw._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '每個${range}',
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
		other: '幾週',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityZhTw implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '週期性';
	@override String get no_repeat => '不再重複';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '重複',
		other: '重複',
	);
	@override String get diary => '日常的';
	@override String get monthly => '每月';
	@override String get annually => '每年';
	@override String get quaterly => '每季';
	@override String get weekly => '每週';
	@override String get custom => '自訂範圍';
	@override String get infinite => '總是';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentZhTw implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get monthly => '這個月';
	@override String get annually => '今年';
	@override String get quaterly => '本季';
	@override String get weekly => '本星期';
	@override String get infinite => '總是';
	@override String get custom => '自訂範圍';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllZhTw implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get diary => '每天';
	@override String get monthly => '每月';
	@override String get annually => '每年';
	@override String get quaterly => '每季';
	@override String get weekly => '每週';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrZhTw implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => '看起來我們沒有足夠的收入來計算您的財務健康狀況。添加這段時間的一些收入/收入，以便我們能夠幫助您！';
	@override String get very_good => '恭喜！您的財務狀況非常好。我們希望您繼續保持良好的勢頭，並繼續與 Monekin 一起學習';
	@override String get good => '太棒了！您的財務狀況良好。請訪問分析選項卡，了解如何節省更多！';
	@override String get normal => '您的財務健康狀況或多或少處於這一時期其他人口的平均水平';
	@override String get bad => '看來您的財務狀況還不是最好的。探索其餘圖表以了解更多有關您財務狀況的信息';
	@override String get very_bad => '嗯，您的財務健康狀況遠低於應有的水平。探索其餘圖表以了解有關您財務狀況的更多信息';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextZhTw implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => '恭喜您！您在這段時間裡成功節省了收入的<b>${value}%</b>。看來您已經是專家了，繼續努力吧！';
	@override String normal({required Object value}) => '恭喜您，在此期間您已成功節省收入的 <b>${value}%</b>。';
	@override String bad({required Object value}) => '在此期間，您已成功節省了收入的 <b>${value}%</b>。但是，我們認為您還可以做得更多！';
	@override String get very_bad => '哇哦，這段時間你什麼都沒保存下來。';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditZhTw implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get dates => '編輯日期';
	@override String get categories => '編輯類別';
	@override String get status => '編輯狀態';
}

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedZhTw implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '已儲存的過濾器';
	@override String get new_title => '新增過濾器';
	@override String get edit_title => '編輯過濾器';
	@override String get name_label => '過濾器名稱';
	@override String get name_hint => '我的自訂過濾器';
	@override String get save_dialog_title => '儲存過濾器';
	@override String get save_tooltip => '儲存目前的過濾器';
	@override String get load_tooltip => '載入已儲存的過濾器';
	@override String get empty_title => '未找到已儲存的過濾器';
	@override String get empty_description => '在此儲存過濾器以便稍後快速存取。';
	@override String get save_success => '篩選器儲存成功';
	@override String get delete_success => '篩選器刪除成功';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsZhTw implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get zero => '一筆交易的價值不能等於零';
	@override String get date_max => '所選日期晚於當前日期。交易將新增為待處理';
	@override String get date_after_account_creation => '您無法建立日期早於所屬帳戶建立日期的交易';
	@override String get negative_transfer => '轉帳的貨幣價值不能為負數';
	@override String get transfer_between_same_accounts => '來源帳號與目標帳號不能符合';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyZhTw implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '目的地轉帳金额';
	@override String amount_short({required Object amount}) => '${amount}至目標帳户';
}

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsZhTw implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => '正常';
	@override String get active_overspending => '超支';
	@override String get active_indeterminate => '積極的';
	@override String get success => '已達成';
	@override String get fail => '超出預算';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionZhTw implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object remainingDays, required Object dailyAmount}) => '在剩餘的 ${remainingDays} 天裡，您每天可以花費 ${dailyAmount}';
	@override String active_overspending({required Object remainingDays, required Object dailyAmount}) => '為了回到正軌，您應該在剩餘的 ${remainingDays} 天裡將每天的支出限制在 ${dailyAmount}';
	@override String active_indeterminate({required Object amount}) => '您還剩 ${amount} 可以消費。';
	@override String active_exceeded({required Object amount}) => '您已經超出了預算限額 ${amount}。如果您找不到此預算的任何收入，您應該在其剩餘期間停止支出';
	@override String get success => '做得好！該預算已成功完成。繼續創建預算以管理您的支出';
	@override String fail({required Object amount}) => '您超出了預算 ${amount}。下次請更加小心！';
}

// Path: goals.type.income
class _TranslationsGoalsTypeIncomeZhTw implements TranslationsGoalsTypeIncomeEn {
	_TranslationsGoalsTypeIncomeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '儲蓄目標';
	@override String get descr => '非常適合儲蓄。當餘額超過目標時，即為成功。';
}

// Path: goals.type.expense
class _TranslationsGoalsTypeExpenseZhTw implements TranslationsGoalsTypeExpenseEn {
	_TranslationsGoalsTypeExpenseZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '支出目標';
	@override String get descr => '跟踪您的支出並以此達到目標金額。適用於捐款、慈善...';
}

// Path: goals.progress.labels
class _TranslationsGoalsProgressLabelsZhTw implements TranslationsGoalsProgressLabelsEn {
	_TranslationsGoalsProgressLabelsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => '步入正軌';
	@override String get active_behind_schedule => '落後於計劃';
	@override String get active_indeterminate => '積極的';
	@override String get success => '目標達成';
	@override String get fail => '目標失敗';
}

// Path: goals.progress.description
class _TranslationsGoalsProgressDescriptionZhTw implements TranslationsGoalsProgressDescriptionEn {
	_TranslationsGoalsProgressDescriptionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object remainingDays, required Object dailyAmount}) => '您正在尋找目標的軌道上！您必須在剩餘的 ${remainingDays} 天內每天節省 ${dailyAmount}';
	@override String active_behind_schedule({required Object dailyAmount, required Object remainingDays}) => '你落後於計劃了。您必須每天節省 ${dailyAmount} 才能在 ${remainingDays} 天后達到您的目標';
	@override String active_indeterminate({required Object amount}) => '您還需要 ${amount} 才能實現目標。';
	@override String get success => '恭喜！你達到了你的目標。';
	@override String fail({required Object amount}) => '您與目標相差了 ${amount}。';
}

// Path: debts.form.from_transaction
class _TranslationsDebtsFormFromTransactionZhTw implements TranslationsDebtsFormFromTransactionEn {
	_TranslationsDebtsFormFromTransactionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '來自一筆交易';
	@override String get select => '選擇交易';
	@override String get tap_to_select => '點選選擇交易';
}

// Path: debts.form.from_amount
class _TranslationsDebtsFormFromAmountZhTw implements TranslationsDebtsFormFromAmountEn {
	_TranslationsDebtsFormFromAmountZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '從初始金額開始';
	@override String get description => '該金額不會作為支出/收入納入統計。它將用於計算餘額和淨值';
}

// Path: debts.actions.edit
class _TranslationsDebtsActionsEditZhTw implements TranslationsDebtsActionsEditEn {
	_TranslationsDebtsActionsEditZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '編輯債務';
	@override String get success => '債務編輯成功';
}

// Path: debts.actions.delete
class _TranslationsDebtsActionsDeleteZhTw implements TranslationsDebtsActionsDeleteEn {
	_TranslationsDebtsActionsDeleteZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get warning_header => '刪除這筆債務嗎？';
	@override String get warning_text => '此操作無法撤銷。關聯交易不會被刪除，但將不再與該債務關聯。';
}

// Path: debts.actions.add_register
class _TranslationsDebtsActionsAddRegisterZhTw implements TranslationsDebtsActionsAddRegisterEn {
	_TranslationsDebtsActionsAddRegisterZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '添加動作';
	@override String get success => '運動添加成功';
	@override String get fab_label => '新增寄存器';
	@override String get modal_title => '新增登記到該債務';
	@override String get modal_subtitle => '選擇以下選項之一將交易與該債務關聯起來';
}

// Path: debts.actions.link_transaction
class _TranslationsDebtsActionsLinkTransactionZhTw implements TranslationsDebtsActionsLinkTransactionEn {
	_TranslationsDebtsActionsLinkTransactionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '連結現有交易';
	@override String get description => '選擇現有記錄將其連結到該債務';
	@override String get success => '與債務掛鉤的交易';
	@override String creating({required Object name}) => '您正在建立與債務 <b>${name}</b> 關聯的交易';
}

// Path: debts.actions.new_transaction
class _TranslationsDebtsActionsNewTransactionZhTw implements TranslationsDebtsActionsNewTransactionEn {
	_TranslationsDebtsActionsNewTransactionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '新增交易';
	@override String get description => '透過建立與該債務相關的新交易來手動新增或減少債務';
}

// Path: debts.actions.create
class _TranslationsDebtsActionsCreateZhTw implements TranslationsDebtsActionsCreateEn {
	_TranslationsDebtsActionsCreateZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '創造債務';
	@override String get success => '債務創建成功';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportZhTw implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '手動導入';
	@override String get descr => '手動從 .csv 檔案匯入交易';
	@override String get default_account => '預設帳戶';
	@override String get remove_default_account => '刪除預設帳戶';
	@override String get default_category => '預設類別';
	@override String get select_a_column => '從 .csv 中選擇一列';
	@override List<String> get steps => [
		'選擇您的文件',
		'數量欄位',
		'帳戶欄位',
		'類別欄位',
		'日期欄位',
		'其他欄位',
	];
	@override List<String> get steps_descr => [
		'從您的裝置中選擇一個 .csv 檔案。確保它的第一行描述了每列的名稱。',
		'選擇每筆交易價值的欄位。使用負值表示支出，使用正值表示收入。',
		'選擇每筆交易所屬帳戶的列。您也可以選擇預設帳戶，以防我們找不到您想要的帳戶。如果未指定預設帳戶，我們將建立一個同名帳戶。',
		'選擇交易類別名稱所在的欄位。您必須指定一個預設類別，以便我們將此類別指派給交易，以防找不到該類別。',
		'選擇每筆交易日期的欄位。如果未指定，交易將使用當前日期建立。',
		'選擇其他交易屬性的資料列',
	];
	@override String success({required Object x}) => '已成功導入${x}筆交易';
}

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageZhTw implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get section => '語言和文本';
	@override String get title => '應用程式語言';
	@override String get descr => '應用程式中顯示文字的語言';
	@override String get help => '如果您想與此應用程式的翻譯合作，您可以參考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我們的指南</a>';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleZhTw implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '地區';
	@override String get auto => '系統';
	@override String get descr => '設定用於日期、數字的格式...';
	@override String get warn => '更改區域時應用程式將更新';
	@override String get first_day_of_week => '一週的第一天';
}

// Path: settings.transactions.style
class _TranslationsSettingsTransactionsStyleZhTw implements TranslationsSettingsTransactionsStyleEn {
	_TranslationsSettingsTransactionsStyleZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '交易樣式';
	@override String get subtitle => '設定交易在應用程式列表中的顯示方式';
	@override String get show_tags => '顯示標籤';
	@override String get show_time => '顯示時間';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsZhTw implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '滑動操作';
	@override String get choose_description => '選擇當您使用此滑動方向滑動列表中的交易項目時將觸發什麼操作';
	@override String get swipe_left => '向左滑動';
	@override String get swipe_right => '向右滑動';
	@override String get none => '無動作';
	@override String get toggle_reconciled => '切換已調節';
	@override String get toggle_pending => '切換待處理';
	@override String get toggle_voided => '切換作廢';
	@override String get toggle_unreconciled => '切換不可調和';
	@override String get remove_status => '刪除狀態';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesZhTw implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

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
class _TranslationsSettingsTransactionsDefaultTypeZhTw implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Type';
	@override String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeZhTw implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '主題';
	@override String get auto => '系統';
	@override String get light => '明亮主題';
	@override String get dark => '黑暗主題';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalZhTw implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '法律資訊';
	@override String get privacy => '隱私權政策';
	@override String get terms => '使用條款';
	@override String get licenses => '許可證';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectZhTw implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get display => '專案';
	@override String get contributors => '合作者';
	@override String get contributors_descr => '所有讓 Monekin 成長的開發者';
	@override String get contact => '聯絡我們';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesZhTw implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get cycle => '循環';
	@override String get last_days => '最後一天';
	@override String last_days_form({required Object x}) => '前${x}天';
	@override String get all => '總是';
	@override String get date_range => '自訂範圍';
}

/// The flat map containing all translations for locale <zh-TW>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhTw {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ui_actions.cancel' => '取消',
			'ui_actions.confirm' => '確認',
			'ui_actions.continue_text' => '繼續',
			'ui_actions.save' => '保存',
			'ui_actions.save_changes' => '儲存變更',
			'ui_actions.close_and_save' => '儲存並關閉',
			'ui_actions.add' => '添加',
			'ui_actions.edit' => '編輯',
			'ui_actions.delete' => '刪除',
			'ui_actions.see_more' => '查看更多',
			'ui_actions.select_all' => '全選',
			'ui_actions.deselect_all' => '取消全選',
			'ui_actions.select' => '選擇',
			'ui_actions.search' => '搜尋',
			'ui_actions.filter' => '過濾',
			'ui_actions.reset' => '重設',
			'ui_actions.submit' => '提交',
			'ui_actions.next' => '下一步',
			'ui_actions.previous' => '上一步',
			'ui_actions.back' => '返回',
			'ui_actions.reload' => '重新載入',
			'ui_actions.view' => '檢視',
			'ui_actions.download' => '下載',
			'ui_actions.upload' => '上傳',
			'ui_actions.retry' => '重試',
			'ui_actions.copy' => '複製',
			'ui_actions.paste' => '貼上',
			'ui_actions.undo' => '還原',
			'ui_actions.redo' => '重做',
			'ui_actions.open' => '開啟',
			'ui_actions.close' => '關閉',
			'ui_actions.apply' => '套用',
			'ui_actions.discard' => '捨棄',
			'ui_actions.refresh' => '重新整理',
			'ui_actions.share' => '分享',
			'general.or' => '或',
			'general.understood' => '明白了',
			'general.unspecified' => '未指定',
			'general.quick_actions' => '快速行動',
			'general.details' => '細節',
			'general.balance' => '平衡',
			'general.account' => '帳戶',
			'general.accounts' => '帳戶',
			'general.categories' => '類別',
			'general.category' => '類別',
			'general.today' => '今天',
			'general.yesterday' => '昨天',
			'general.filters' => '過濾',
			'general.empty_warn' => '哦！這裡非常空',
			'general.search_no_results' => '沒有符合您搜索條件的商品',
			'general.insufficient_data' => '數據不足',
			'general.show_more_fields' => '顯示更多欄位',
			'general.show_less_fields' => '顯示較少的欄位',
			'general.tap_to_search' => '點擊即可搜尋',
			'general.delete_success' => '項目刪除成功',
			'general.leave_without_saving.title' => '不保存就離開？',
			'general.leave_without_saving.message' => '您有未保存的更改，確定要離開而不保存它們嗎？',
			'general.clipboard.success' => ({required Object x}) => '${x}已複製到剪貼簿',
			'general.clipboard.error' => '複製錯誤',
			'general.time.start_date' => '開始日期',
			'general.time.end_date' => '結束日期',
			'general.time.from_date' => '從日期',
			'general.time.until_date' => '截止日期',
			'general.time.date' => '日期',
			'general.time.datetime' => '約會時間',
			'general.time.time' => '時間',
			'general.time.each' => '每個',
			'general.time.after' => '後',
			'general.time.ranges.display' => '時間範圍',
			'general.time.ranges.it_repeat' => '重複',
			'general.time.ranges.it_ends' => '結束',
			'general.time.ranges.forever' => '永遠',
			'general.time.ranges.types.cycle' => '循環',
			'general.time.ranges.types.last_days' => '最後一天',
			'general.time.ranges.types.last_days_form' => ({required Object x}) => '前${x}天',
			'general.time.ranges.types.all' => '總是',
			'general.time.ranges.types.date_range' => '自訂範圍',
			'general.time.ranges.each_range' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '每個${range}', other: '每${n}${range}', ), 
			'general.time.ranges.each_range_until_date' => ({required num n, required Object range, required Object day}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '每${range}直到${day}', other: '每 ${n}${range}直到${day}', ), 
			'general.time.ranges.each_range_until_times' => ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '每${range}${limit}次', other: '每${n}${range}${limit}次', ), 
			'general.time.ranges.each_range_until_once' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '每${range}一次', other: '每${n}${range}一次', ), 
			'general.time.ranges.month' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '月', other: '月', ), 
			'general.time.ranges.year' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '年', other: '年', ), 
			'general.time.ranges.day' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '天', other: '天', ), 
			'general.time.ranges.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '星期', other: '幾週', ), 
			'general.time.periodicity.display' => '週期性',
			'general.time.periodicity.no_repeat' => '不再重複',
			'general.time.periodicity.repeat' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '重複', other: '重複', ), 
			'general.time.periodicity.diary' => '日常的',
			'general.time.periodicity.monthly' => '每月',
			'general.time.periodicity.annually' => '每年',
			'general.time.periodicity.quaterly' => '每季',
			'general.time.periodicity.weekly' => '每週',
			'general.time.periodicity.custom' => '自訂範圍',
			'general.time.periodicity.infinite' => '總是',
			'general.time.current.monthly' => '這個月',
			'general.time.current.annually' => '今年',
			'general.time.current.quaterly' => '本季',
			'general.time.current.weekly' => '本星期',
			'general.time.current.infinite' => '總是',
			'general.time.current.custom' => '自訂範圍',
			'general.time.all.diary' => '每天',
			'general.time.all.monthly' => '每月',
			'general.time.all.annually' => '每年',
			'general.time.all.quaterly' => '每季',
			'general.time.all.weekly' => '每週',
			'general.transaction_order.display' => '訂單交易',
			'general.transaction_order.category' => '按類別',
			'general.transaction_order.quantity' => '按數量',
			'general.transaction_order.date' => '按日期',
			'general.validations.form_error' => '修正表單中指示的欄位以繼續',
			'general.validations.required' => '必填項目',
			'general.validations.positive' => '應該是積極的',
			'general.validations.min_number' => ({required Object x}) => '應該大於${x}',
			'general.validations.max_number' => ({required Object x}) => '應小於${x}',
			'intro.start' => '開始',
			'intro.skip' => '跳過',
			'intro.next' => '下一個',
			'intro.select_your_currency' => '選擇您的貨幣',
			'intro.welcome_subtitle' => '您的個人財務管家',
			'intro.welcome_subtitle2' => '100% 開放，100% 免費',
			'intro.welcome_footer' => '登入即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隱私權政策</a>和<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>應用程式的使用條款</a>',
			'intro.offline_descr_title' => '離線帳戶：',
			'intro.offline_descr' => '您的資料只會儲存在您的裝置上，只要您不卸載應用程式或更換手機，資料就安全。為防止資料遺失，建議定期從應用程式設定中進行備份。',
			'intro.offline_start' => '離線啟動會話',
			'intro.sl1_title' => '選擇您的貨幣',
			'intro.sl1_descr' => '您的預設貨幣將用於報告和一般圖表。您以後可以隨時在應用程式設定中更改貨幣和應用程式語言',
			'intro.sl2_title' => '安全、隱私、可靠',
			'intro.sl2_descr' => '您的資料只屬於您。我們將資訊直接儲存在您的設備上，無需通過外部伺服器。這使得即使沒有互聯網也可以使用該應用程式',
			'intro.sl2_descr2' => '此外，該應用程式的源代碼是公開的，任何人都可以對其進行協作並查看它是如何工作的',
			'intro.last_slide_title' => '一切準備就緒',
			'intro.last_slide_descr' => '有了 Monekin，您終於可以實現您想要的財務獨立。您將擁有圖表、預算、提示、統計數據以及更多有關您的資金的信息。',
			'intro.last_slide_descr2' => '我們希望您享受這次體驗！如有疑問、建議，請隨時與我們聯繫......',
			'home.title' => '儀表板',
			'home.filter_transactions' => '過濾交易',
			'home.hello_day' => '早安，',
			'home.hello_night' => '晚安，',
			'home.total_balance' => '總餘額',
			'home.my_accounts' => '我的帳戶',
			'home.active_accounts' => '活躍帳戶',
			'home.no_accounts' => '尚未建立帳戶',
			'home.no_accounts_descr' => '開始使用 Monekin 的所有魔力。至少建立一個帳戶以開始添加交易',
			'home.last_transactions' => '最後的交易',
			'home.should_create_account_header' => '哎呀！',
			'home.should_create_account_message' => '您必須至少擁有一個非存檔帳戶才能開始建立交易',
			'financial_health.display' => '財務健康',
			'financial_health.review.very_good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return '很好！'; case GenderContext.female: return '很好！'; } }, 
			'financial_health.review.good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return '好'; case GenderContext.female: return '好'; } }, 
			'financial_health.review.normal' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return '平均'; case GenderContext.female: return '平均'; } }, 
			'financial_health.review.bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return '一般'; case GenderContext.female: return '一般'; } }, 
			'financial_health.review.very_bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return '非常糟糕'; case GenderContext.female: return '非常糟糕'; } }, 
			'financial_health.review.insufficient_data' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return '數據不足'; case GenderContext.female: return '數據不足'; } }, 
			'financial_health.review.descr.insufficient_data' => '看起來我們沒有足夠的收入來計算您的財務健康狀況。添加這段時間的一些收入/收入，以便我們能夠幫助您！',
			'financial_health.review.descr.very_good' => '恭喜！您的財務狀況非常好。我們希望您繼續保持良好的勢頭，並繼續與 Monekin 一起學習',
			'financial_health.review.descr.good' => '太棒了！您的財務狀況良好。請訪問分析選項卡，了解如何節省更多！',
			'financial_health.review.descr.normal' => '您的財務健康狀況或多或少處於這一時期其他人口的平均水平',
			'financial_health.review.descr.bad' => '看來您的財務狀況還不是最好的。探索其餘圖表以了解更多有關您財務狀況的信息',
			'financial_health.review.descr.very_bad' => '嗯，您的財務健康狀況遠低於應有的水平。探索其餘圖表以了解有關您財務狀況的更多信息',
			'financial_health.months_without_income.title' => '存活率',
			'financial_health.months_without_income.subtitle' => '考慮到您的餘額，您可以在沒有收入的情況下度過多長時間',
			'financial_health.months_without_income.text_zero' => '按照這樣的開支，沒有收入你一個月都活不下去！',
			'financial_health.months_without_income.text_one' => '按照這樣的收入，如果沒有收入，你幾乎無法生存大約一個月！',
			'financial_health.months_without_income.text_other' => ({required Object n}) => '以這樣的支出速度，如果沒有收入，您大約可以生存 <b>${n}個月</b>。',
			'financial_health.months_without_income.text_infinite' => '以這樣的支出速度，如果沒有收入，您大約可以<b>一生</b>生存。',
			'financial_health.months_without_income.suggestion' => '請記住，建議始終將此比率保持在至少 5 個月以上。如果您發現自己沒有足夠的儲蓄緩衝，請減少不必要的開支。',
			'financial_health.months_without_income.insufficient_data' => '看來我們沒有足夠的開支來計算您在沒有收入的情況下可以生存多少個月。輸入幾筆交易，然後回到這裡檢查您的財務狀況',
			'financial_health.savings_percentage.title' => '儲蓄百分比',
			'financial_health.savings_percentage.subtitle' => '你的收入中有哪一部分沒有在這段時間花掉',
			'financial_health.savings_percentage.text.good' => ({required Object value}) => '恭喜您！您在這段時間裡成功節省了收入的<b>${value}%</b>。看來您已經是專家了，繼續努力吧！',
			'financial_health.savings_percentage.text.normal' => ({required Object value}) => '恭喜您，在此期間您已成功節省收入的 <b>${value}%</b>。',
			'financial_health.savings_percentage.text.bad' => ({required Object value}) => '在此期間，您已成功節省了收入的 <b>${value}%</b>。但是，我們認為您還可以做得更多！',
			'financial_health.savings_percentage.text.very_bad' => '哇哦，這段時間你什麼都沒保存下來。',
			'financial_health.savings_percentage.suggestion' => '請記住，建議將收入的至少 15-20% 存起來。',
			'stats.title' => '統計數據',
			'stats.balance' => '平衡',
			'stats.final_balance' => '最終餘額',
			'stats.balance_by_account' => '帳戶餘額',
			'stats.balance_by_account_subtitle' => '我的大部分錢都在哪裡？',
			'stats.balance_by_currency' => '按貨幣餘额',
			'stats.balance_by_currency_subtitle' => '我有多少錢的外幣？',
			'stats.balance_evolution' => '平衡趨勢',
			'stats.balance_evolution_subtitle' => '我的錢比以前多了嗎？',
			'stats.compared_to_previous_period' => '與上一时期相比',
			'stats.cash_flow' => '現金流',
			'stats.cash_flow_subtitle' => '我的支出是否少于我的收入？',
			'stats.by_periods' => '按時期',
			'stats.by_categories' => '按類別',
			'stats.by_tags' => '按標籤',
			'stats.distribution' => '分配',
			'stats.finance_health_resume' => '恢復',
			'stats.finance_health_breakdown' => '分解',
			'icon_selector.name' => '姓名：',
			'icon_selector.icon' => '圖示',
			'icon_selector.color' => '顏色',
			'icon_selector.select_icon' => '選擇一個圖示',
			'icon_selector.select_color' => '選擇一種顏色',
			'icon_selector.custom_color' => '自訂顏色',
			'icon_selector.current_color_selection' => '目前選擇',
			'icon_selector.select_account_icon' => '識別您的帳戶',
			'icon_selector.select_category_icon' => '確定您的類別',
			'icon_selector.scopes.transport' => '運輸',
			'icon_selector.scopes.money' => '錢',
			'icon_selector.scopes.food' => '食物',
			'icon_selector.scopes.medical' => '健康',
			'icon_selector.scopes.entertainment' => '閒暇',
			'icon_selector.scopes.technology' => '技術',
			'icon_selector.scopes.other' => '其他的',
			'icon_selector.scopes.logos_financial_institutions' => '金融機構',
			'transaction.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '交易', other: '交易', ), 
			'transaction.create' => '新交易',
			'transaction.new_income' => '新收入',
			'transaction.new_expense' => '新開支',
			'transaction.new_success' => '交易建立成功',
			'transaction.edit' => '編輯交易',
			'transaction.edit_success' => '交易編輯成功',
			'transaction.edit_multiple' => '編輯交易',
			'transaction.edit_multiple_success' => ({required Object x}) => '${x}筆交易已成功編輯',
			'transaction.duplicate' => '複製交易',
			'transaction.duplicate_short' => '複製',
			'transaction.duplicate_warning_message' => '將在同一日期建立與此相同的交易，您想繼續嗎？',
			'transaction.duplicate_success' => '交易複製成功',
			'transaction.delete' => '刪除交易',
			'transaction.delete_warning_message' => '此操作不可逆轉。您的帳戶當前餘額和所有統計資料都將重新計算',
			'transaction.delete_success' => '交易已正確刪除',
			'transaction.delete_multiple' => '刪除交易',
			'transaction.delete_multiple_warning_message' => ({required Object x}) => '此操作不可逆轉，將刪除${x}筆交易。您帳戶的當前餘額和所有統計資料都將重新計算',
			'transaction.delete_multiple_success' => ({required Object x}) => '正確刪除了${x}筆交易',
			'transaction.details' => '動作詳情',
			'transaction.next_payments.accept' => '接受',
			'transaction.next_payments.skip' => '跳過',
			'transaction.next_payments.skip_success' => '成功跳過交易',
			'transaction.next_payments.skip_dialog_title' => '跳過交易',
			'transaction.next_payments.skip_dialog_msg' => ({required Object date}) => '此操作不可逆轉。我們會將下次移動的日期移至${date}',
			'transaction.next_payments.accept_today' => '今天接受',
			'transaction.next_payments.accept_in_required_date' => ({required Object date}) => '在要求的日期 (${date}) 接受',
			'transaction.next_payments.accept_dialog_title' => '接受交易',
			'transaction.next_payments.accept_dialog_msg_single' => '該交易的新狀態將為空。您可以隨時重新編輯該交易的狀態',
			'transaction.next_payments.accept_dialog_msg' => ({required Object date}) => '此操作將建立日期為${date}的新交易。您將能夠在交易頁面上查看此交易的詳細資訊',
			'transaction.next_payments.recurrent_rule_finished' => '循環規則已完成，無需再支付！',
			'transaction.list.all' => '所有交易',
			'transaction.list.empty' => '未發現此處顯示的交易。在應用程式中添加一些交易，也許您下次會有更好的運氣',
			'transaction.list.searcher_placeholder' => '按類別、描述搜尋...',
			'transaction.list.searcher_no_results' => '未找到符合搜尋條件的交易',
			'transaction.list.loading' => '正在加載更多交易...',
			'transaction.list.selected_short' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '${n} 已選取', other: '${n} 已選取', ), 
			'transaction.list.selected_long' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '已選擇 ${n} 筆交易', other: '選擇 ${n} 筆交易', ), 
			'transaction.list.bulk_edit.dates' => '編輯日期',
			'transaction.list.bulk_edit.categories' => '編輯類別',
			'transaction.list.bulk_edit.status' => '編輯狀態',
			'transaction.filters.title' => '交易過濾器',
			'transaction.filters.from_value' => '從金額',
			'transaction.filters.to_value' => '最多金額',
			'transaction.filters.from_value_def' => ({required Object x}) => '來自 ${x}',
			'transaction.filters.to_value_def' => ({required Object x}) => '最多 ${x}',
			'transaction.filters.from_date_def' => ({required Object date}) => '從${date}開始',
			'transaction.filters.to_date_def' => ({required Object date}) => '截至 ${date}',
			'transaction.filters.reset' => '重置過濾器',
			'transaction.filters.saved.title' => '已儲存的過濾器',
			'transaction.filters.saved.new_title' => '新增過濾器',
			'transaction.filters.saved.edit_title' => '編輯過濾器',
			'transaction.filters.saved.name_label' => '過濾器名稱',
			'transaction.filters.saved.name_hint' => '我的自訂過濾器',
			'transaction.filters.saved.save_dialog_title' => '儲存過濾器',
			'transaction.filters.saved.save_tooltip' => '儲存目前的過濾器',
			'transaction.filters.saved.load_tooltip' => '載入已儲存的過濾器',
			'transaction.filters.saved.empty_title' => '未找到已儲存的過濾器',
			'transaction.filters.saved.empty_description' => '在此儲存過濾器以便稍後快速存取。',
			'transaction.filters.saved.save_success' => '篩選器儲存成功',
			'transaction.filters.saved.delete_success' => '篩選器刪除成功',
			'transaction.form.validators.zero' => '一筆交易的價值不能等於零',
			'transaction.form.validators.date_max' => '所選日期晚於當前日期。交易將新增為待處理',
			'transaction.form.validators.date_after_account_creation' => '您無法建立日期早於所屬帳戶建立日期的交易',
			'transaction.form.validators.negative_transfer' => '轉帳的貨幣價值不能為負數',
			'transaction.form.validators.transfer_between_same_accounts' => '來源帳號與目標帳號不能符合',
			'transaction.form.title' => '交易標題',
			'transaction.form.title_short' => '資質',
			'transaction.form.value' => '交易價值',
			'transaction.form.tap_to_see_more' => '點擊查看更多詳細資訊',
			'transaction.form.no_tags' => '-- 無標籤 --',
			'transaction.form.description' => '描述',
			'transaction.form.description_info' => '點擊此處輸入有關此交易的更詳細描述',
			'transaction.form.exchange_to_preferred_title' => ({required Object currency}) => '匯率為${currency}',
			'transaction.form.exchange_to_preferred_in_date' => '交易日',
			'transaction.reversed.title' => '逆向交易',
			'transaction.reversed.title_short' => '逆向交易',
			'transaction.reversed.description_for_expenses' => '儘管是收入交易，但它的金額為正數。這些類型的交易可用於表示先前記錄的收入的返還，例如退款或償還債務。',
			'transaction.reversed.description_for_incomes' => '儘管是一項收入交易，但其金額為負數。這些類型的交易可用於作廢或更正錯誤記錄的收入，反映資金的返還或退款或記錄債務的支付。',
			'transaction.status.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '地位', other: '狀態', ), 
			'transaction.status.display_long' => '交易狀態',
			'transaction.status.tr_status' => ({required Object status}) => '${status}交易',
			'transaction.status.none' => '無狀態',
			'transaction.status.none_descr' => '沒有特定狀態的交易',
			'transaction.status.reconciled' => '已驗證',
			'transaction.status.reconciled_descr' => '此交易已經過驗證，並且與您銀行的真實交易相對應',
			'transaction.status.unreconciled' => '未驗證',
			'transaction.status.unreconciled_descr' => '此交易尚未經過驗證，因此尚未出現在您的真實銀行帳戶中。但是，它將計算 Monekin 中的餘額和統計數據',
			'transaction.status.pending' => '待辦',
			'transaction.status.pending_descr' => '此交易正在等待處理，因此在計算餘額和統計數據時不會考慮它',
			'transaction.status.voided' => '作廢',
			'transaction.status.voided_descr' => '由於付款錯誤或任何其他原因導致的交易無效/取消。在計算餘額和統計時不會考慮該交易',
			'transaction.types.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '交易類型', other: '交易類型', ), 
			'transaction.types.income' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '收入', other: '收入', ), 
			'transaction.types.expense' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '支出', other: '支出', ), 
			'transaction.types.transfer' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '轉移', other: '轉移', ), 
			'transfer.display' => '轉移',
			'transfer.transfers' => '轉移',
			'transfer.transfer_to' => ({required Object account}) => '轉移至${account}',
			'transfer.create' => '轉移',
			'transfer.need_two_accounts_warning_header' => 'Ops!',
			'transfer.need_two_accounts_warning_message' => '至少需要兩個帳戶才能執行此操作。如果您需要調整或編輯該帳戶的當前餘額，請點擊編輯按鈕',
			'transfer.form.from' => '原始帳戶',
			'transfer.form.to' => '目的地帳戶',
			'transfer.form.value_in_destiny.title' => '目的地轉帳金额',
			'transfer.form.value_in_destiny.amount_short' => ({required Object amount}) => '${amount}至目標帳户',
			'recurrent_transactions.title' => '經常交易',
			'recurrent_transactions.title_short' => '經常交易',
			'recurrent_transactions.empty' => '您似乎沒有任何經常交易。建立每月、每年或每週的經常交易，它將顯示在此處',
			'recurrent_transactions.total_expense_title' => '每個期間的總收入',
			'recurrent_transactions.total_expense_descr' => '*不考慮每次重複的開始和結束日期',
			'recurrent_transactions.details.title' => '經常交易',
			'recurrent_transactions.details.descr' => '此交易的下一步動作如下所示。您可以接受第一步動作或跳過此動作',
			'recurrent_transactions.details.last_payment_info' => '此動作是循環規則的最後一個，因此當確認此動作時，該規則將自動刪除',
			'recurrent_transactions.details.delete_header' => '刪除重複交易',
			'recurrent_transactions.details.delete_message' => '此操作不可逆轉，不會影響您已確認/付款的交易',
			'recurrent_transactions.status.delayed_by' => ({required Object x}) => '延遲了 ${x}d',
			'recurrent_transactions.status.coming_in' => ({required Object x}) => '${x} 天後',
			'account.details' => '帳戶詳細資料',
			'account.date' => '開業日期',
			'account.close_date' => '截止日期',
			'account.reopen' => '重新開立帳戶',
			'account.reopen_short' => '重新開放',
			'account.reopen_descr' => '您確定要重新開啟此帳戶嗎？',
			'account.balance' => '帳戶餘額',
			'account.n_transactions' => '交易數量',
			'account.add_money' => '增加金額',
			'account.withdraw_money' => '取出金額',
			'account.no_accounts' => '未發現此處顯示的交易。請點選底部的 \'+\' 按鈕新增交易',
			'account.types.title' => '帳戶類型',
			'account.types.warning' => '帳戶類型一旦選擇，以後將無法更改',
			'account.types.normal' => '普通帳戶',
			'account.types.normal_descr' => '對於記錄您的日常財務很有用。這是最常見的帳戶，它可以讓您添加支出、收入......',
			'account.types.saving' => '儲蓄帳戶',
			'account.types.saving_descr' => '您只能從其他帳戶中添加和提取資金。非常適合開始存錢',
			'account.form.name' => '帳戶名稱',
			'account.form.name_placeholder' => '例如：儲蓄帳戶',
			'account.form.notes' => '筆記',
			'account.form.notes_placeholder' => '輸入有關此帳戶的一些註釋/描述',
			'account.form.initial_balance' => '初始餘額',
			'account.form.current_balance' => '當前餘額',
			'account.form.create' => '建立帳戶',
			'account.form.edit' => '編輯帳戶',
			'account.form.currency_not_found_warn' => '您沒有該貨幣的匯率資訊。1.0 將用作預設匯率。您可以在設定中修改',
			'account.form.already_exists' => '已經有另一個同名，請再寫一個',
			'account.form.tr_before_opening_date' => '該帳戶中有日期早於開戶日期的交易',
			'account.form.iban' => 'iban',
			'account.form.swift' => 'swift',
			'account.delete.warning_header' => '刪除帳戶？',
			'account.delete.warning_text' => '此操作將刪除該帳戶及其所有交易',
			'account.delete.success' => '帳號刪除成功',
			'account.close.title' => '關閉帳戶',
			'account.close.title_short' => '關閉',
			'account.close.warn' => '此帳戶將不再出現在某些清單中，您將無法在其中建立日期晚於下面指定的日期的交易。此操作不會影響任何交易或餘額，您也可以隨時重新開啟此帳戶時間。 ',
			'account.close.should_have_zero_balance' => '此帳戶中的當前餘額必須為 0 才能關閉它。請在繼續之前編輯帳戶',
			'account.close.should_have_no_transactions' => '此帳戶在指定的關閉日期之後有交易。請刪除它們或編輯帳戶關閉日期，然後再繼續',
			'account.close.success' => '帳戶關閉成功',
			'account.close.unarchive_succes' => '帳戶已成功重新開設',
			'account.select.one' => '選擇一個帳戶',
			'account.select.all' => '所有帳戶',
			'account.select.multiple' => '選擇帳戶',
			'currencies.currency_converter' => '貨幣換算',
			'currencies.currency' => '貨幣',
			'currencies.currency_settings' => '貨幣設置',
			'currencies.currency_manager' => '貨幣管理',
			'currencies.currency_manager_descr' => '配置您的貨幣及其與其他貨幣的匯率',
			'currencies.preferred_currency' => '首選/基礎貨幣',
			'currencies.tap_to_change_preferred_currency' => '點擊即可更改',
			'currencies.change_preferred_currency_title' => '更改首選貨幣',
			'currencies.change_preferred_currency_msg' => '從現在開始，所有統計數據和預算都將以該貨幣顯示。帳戶和交易將保留其所擁有的貨幣。如果您執行此操作，所有保存的匯率都將被刪除。您想繼續嗎？',
			'currencies.exchange_rate_form.equal_to_preferred_warn' => '幣種不能等於用戶幣種',
			'currencies.exchange_rate_form.override_existing_warn' => '該貨幣在該日期的匯率已存在。如果繼續，前一個將會被覆蓋',
			'currencies.exchange_rate_form.specify_a_currency' => '請指定貨幣',
			'currencies.exchange_rate_form.add' => '添加匯率',
			'currencies.exchange_rate_form.add_success' => '匯率新增成功',
			'currencies.exchange_rate_form.edit' => '編輯匯率',
			'currencies.exchange_rate_form.edit_success' => '匯率編輯成功',
			'currencies.exchange_rate_form.remove_all' => '刪除所有匯率',
			'currencies.exchange_rate_form.remove_all_warning' => '此操作不可逆轉，並將刪除該貨幣的所有匯率',
			'currencies.types.display' => '貨幣類型',
			'currencies.types.fiat' => '菲亞特',
			'currencies.types.crypto' => '加密貨幣',
			'currencies.types.other' => '其他',
			'currencies.currency_form.name' => '顯示名稱',
			'currencies.currency_form.code' => '貨幣代碼',
			'currencies.currency_form.symbol' => '象徵',
			'currencies.currency_form.decimal_digits' => '小數位',
			'currencies.currency_form.create' => '創建貨幣',
			'currencies.currency_form.create_success' => '貨幣創建成功',
			'currencies.currency_form.edit' => '編輯貨幣',
			'currencies.currency_form.edit_success' => '貨幣編輯成功',
			'currencies.currency_form.delete' => '刪除貨幣',
			'currencies.currency_form.delete_success' => '幣種刪除成功',
			'currencies.currency_form.already_exists' => '具有此代碼的貨幣已存在。您可能想要編輯它',
			'currencies.delete_all_success' => '刪除匯率成功',
			'currencies.historical' => '歷史利率',
			'currencies.historical_empty' => '沒有找到該貨幣的歷史匯率',
			'currencies.exchange_rate' => '匯率',
			'currencies.exchange_rates' => '匯率',
			'currencies.min_exchange_rate' => '最低匯率',
			'currencies.max_exchange_rate' => '最高匯率',
			'currencies.empty' => '在此處添加匯率，以便如果您的帳戶使用基礎貨幣以外的貨幣，我們的圖表會更加準確',
			'currencies.select_a_currency' => '選擇貨幣',
			'currencies.search' => '按名稱或貨幣代碼搜尋',
			'tags.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '標籤', other: '標籤', ), 
			'tags.form.name' => '標籤名',
			'tags.form.description' => '描述',
			'tags.select.title' => '選擇標籤',
			'tags.select.all' => '所有標籤',
			'tags.empty_list' => '您還沒有建立任何標籤。標籤和類別是對您的動作進行分類的好方法',
			'tags.without_tags' => '沒有標籤',
			'tags.add' => '添加標籤',
			'tags.create' => '建立標籤',
			'tags.create_success' => '標籤建立成功',
			'tags.already_exists' => '此標籤名稱已存在。您可能需要編輯它',
			'tags.edit' => '編輯標籤',
			'tags.edit_success' => '標籤編輯成功',
			'tags.delete_success' => '類別刪除成功',
			'tags.delete_warning_header' => '刪除標籤？',
			'tags.delete_warning_message' => '此操作不會刪除具有此標籤的交易。',
			'categories.unknown' => '未知類別',
			'categories.create' => '建立類別',
			'categories.create_success' => '類別建立成功',
			'categories.new_category' => '新類別',
			'categories.already_exists' => '該類別的名稱已存在。也許您可以編輯',
			'categories.edit' => '編輯類別',
			'categories.edit_success' => '類別編輯成功',
			'categories.name' => '分類名稱',
			'categories.type' => '類別類型',
			'categories.both_types' => '兩種類型',
			'categories.subcategories' => '子類別',
			'categories.subcategories_add' => '新增子類別',
			'categories.make_parent' => '按類別製作',
			'categories.make_child' => '建立一個子類別',
			'categories.make_child_warning1' => ({required Object destiny}) => '此類別及其子類別將成為<b>${destiny}</b>的子類別。',
			'categories.make_child_warning2' => ({required Object x, required Object destiny}) => '他們的交易<b>(${x})</b>將被移至<b>${destiny}</b>類別中建立的新子類別。',
			'categories.make_child_success' => '子類別建立成功',
			'categories.merge' => '與另一個類別合併',
			'categories.merge_warning1' => ({required Object from, required Object x, required Object destiny}) => '與類別<b>${from}</b>相關的所有交易 (${x}) 將移至類別<b>${destiny}</b>',
			'categories.merge_warning2' => ({required Object from}) => '類別<b>${from}</b>將被不可逆轉地刪除。 ',
			'categories.merge_success' => '類別合併成功',
			'categories.delete_success' => '類別已成功刪除',
			'categories.delete_warning_header' => '刪除類別？',
			'categories.delete_warning_message' => ({required Object x}) => '此操作將不可逆轉地刪除與此類別相關的所有交易<b>(${x})</b>。',
			'categories.select.title' => '選擇類別',
			'categories.select.select_one' => '選擇一個類別',
			'categories.select.select_subcategory' => '選擇一個子類別',
			'categories.select.without_subcategory' => '沒有子類別',
			'categories.select.all' => '所有類別',
			'categories.select.all_short' => '全部',
			'budgets.title' => '預算',
			'budgets.status' => '預算狀況',
			'budgets.repeated' => '週期性',
			'budgets.one_time' => '一次性',
			'budgets.actives' => '活躍',
			'budgets.from_budgeted' => '從預算',
			'budgets.days_left' => '還剩幾天',
			'budgets.days_to_start' => '開始的日子',
			'budgets.since_expiration' => '自到期日起的天數',
			'budgets.no_budgets' => '此部分中似乎沒有可顯示的預算。首先單擊下面的按鈕以建立預算',
			'budgets.delete' => '刪除預算',
			'budgets.delete_warning' => '此操作不可逆轉。引用此報價的類別和交易不會被刪除',
			'budgets.form.title' => '添加預算',
			'budgets.form.name' => '預算名稱',
			'budgets.form.value' => '數量限制',
			'budgets.form.create' => '添加預算',
			'budgets.form.create_success' => '預算創建成功',
			'budgets.form.edit' => '編輯預算',
			'budgets.form.edit_success' => '預算編輯成功',
			'budgets.form.negative_warn' => '預算不能有負數',
			'budgets.details.title' => '預算詳情',
			'budgets.details.statistics' => '統計數據',
			'budgets.details.budget_value' => '預算',
			'budgets.details.expend_evolution' => '支出變化',
			'budgets.details.no_transactions' => '看來您還沒有做出與此預算相關的任何收入',
			'budgets.target_timeline_statuses.active' => '目前預算',
			'budgets.target_timeline_statuses.past' => '已完成預算',
			'budgets.target_timeline_statuses.future' => '未來預算',
			'budgets.progress.labels.active_on_track' => '正常',
			'budgets.progress.labels.active_overspending' => '超支',
			'budgets.progress.labels.active_indeterminate' => '積極的',
			'budgets.progress.labels.success' => '已達成',
			'budgets.progress.labels.fail' => '超出預算',
			'budgets.progress.description.active_on_track' => ({required Object remainingDays, required Object dailyAmount}) => '在剩餘的 ${remainingDays} 天裡，您每天可以花費 ${dailyAmount}',
			'budgets.progress.description.active_overspending' => ({required Object remainingDays, required Object dailyAmount}) => '為了回到正軌，您應該在剩餘的 ${remainingDays} 天裡將每天的支出限制在 ${dailyAmount}',
			'budgets.progress.description.active_indeterminate' => ({required Object amount}) => '您還剩 ${amount} 可以消費。',
			'budgets.progress.description.active_exceeded' => ({required Object amount}) => '您已經超出了預算限額 ${amount}。如果您找不到此預算的任何收入，您應該在其剩餘期間停止支出',
			'budgets.progress.description.success' => '做得好！該預算已成功完成。繼續創建預算以管理您的支出',
			'budgets.progress.description.fail' => ({required Object amount}) => '您超出了預算 ${amount}。下次請更加小心！',
			'goals.title' => '目標',
			'goals.status' => '目標狀態',
			'goals.type.display' => '目標類型',
			'goals.type.income.title' => '儲蓄目標',
			'goals.type.income.descr' => '非常適合儲蓄。當餘額超過目標時，即為成功。',
			'goals.type.expense.title' => '支出目標',
			'goals.type.expense.descr' => '跟踪您的支出並以此達到目標金額。適用於捐款、慈善...',
			'goals.empty_title' => '未找到目標',
			'goals.empty_description' => '創建一個新目標以開始追蹤您的儲蓄！',
			'goals.delete' => '刪除目標',
			'goals.delete_warning' => '此操作不可逆。涉及此目標的類別和交易將不會被刪除',
			'goals.form.new_title' => '新目標',
			'goals.form.edit_title' => '編輯目標',
			'goals.form.target_amount' => '目標金額',
			'goals.form.initial_amount' => '初始金額',
			_ => null,
		} ?? switch (path) {
			'goals.form.name' => '名稱',
			'goals.form.name_hint' => '我的儲蓄目標',
			'goals.form.create_success' => '目標建立成功',
			'goals.form.edit_success' => '目標編輯成功',
			'goals.form.negative_warn' => '目標金額不能為負數',
			'goals.details.title' => '目標詳情',
			'goals.details.statistics' => '統計',
			'goals.details.goal_value' => '目標值',
			'goals.details.evolution' => '趨勢',
			'goals.details.no_transactions' => '看來您還沒有進行任何與此目標相關的交易',
			'goals.target_timeline_statuses.active' => '進行中的目標',
			'goals.target_timeline_statuses.past' => '已結束的目標',
			'goals.target_timeline_statuses.future' => '未來的目標',
			'goals.progress.labels.active_on_track' => '步入正軌',
			'goals.progress.labels.active_behind_schedule' => '落後於計劃',
			'goals.progress.labels.active_indeterminate' => '積極的',
			'goals.progress.labels.success' => '目標達成',
			'goals.progress.labels.fail' => '目標失敗',
			'goals.progress.description.active_on_track' => ({required Object remainingDays, required Object dailyAmount}) => '您正在尋找目標的軌道上！您必須在剩餘的 ${remainingDays} 天內每天節省 ${dailyAmount}',
			'goals.progress.description.active_behind_schedule' => ({required Object dailyAmount, required Object remainingDays}) => '你落後於計劃了。您必須每天節省 ${dailyAmount} 才能在 ${remainingDays} 天后達到您的目標',
			'goals.progress.description.active_indeterminate' => ({required Object amount}) => '您還需要 ${amount} 才能實現目標。',
			'goals.progress.description.success' => '恭喜！你達到了你的目標。',
			'goals.progress.description.fail' => ({required Object amount}) => '您與目標相差了 ${amount}。',
			'debts.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '債務', other: '債務', ), 
			'debts.form.name' => '債務名稱',
			'debts.form.initial_amount' => '初始金額',
			'debts.form.total_amount' => '總金額',
			'debts.form.step_initial_value' => '初始值',
			'debts.form.step_details' => '細節',
			'debts.form.from_transaction.title' => '來自一筆交易',
			'debts.form.from_transaction.select' => '選擇交易',
			'debts.form.from_transaction.tap_to_select' => '點選選擇交易',
			'debts.form.from_amount.title' => '從初始金額開始',
			'debts.form.from_amount.description' => '該金額不會作為支出/收入納入統計。它將用於計算餘額和淨值',
			'debts.direction.lent' => '借出',
			'debts.direction.borrowed' => '借來的',
			'debts.status.active' => '積極的',
			'debts.status.close' => '關閉',
			'debts.details.collected_amount' => '收取金額',
			'debts.details.remaining' => '其餘的',
			'debts.details.no_deadline' => '無截止日期',
			'debts.details.in_days' => ({required Object x}) => '${x} 天后',
			'debts.details.due_today' => '今天到期',
			'debts.details.days_ago' => ({required Object x}) => '${x} days ago',
			'debts.details.overdue_by' => ({required Object x}) => 'Overdue by ${x} days',
			'debts.details.per_day' => '/ 天',
			'debts.details.no_transactions' => '未找到該債務的交易',
			'debts.empty.no_debts_active' => '未發現活躍債務。首先點擊下面的按鈕建立新債務',
			'debts.empty.no_debts_closed' => '未發現已結清的債務。当您收回所有债务或支付所有所欠债务时，债务就结束了。',
			'debts.actions.edit.title' => '編輯債務',
			'debts.actions.edit.success' => '債務編輯成功',
			'debts.actions.delete.warning_header' => '刪除這筆債務嗎？',
			'debts.actions.delete.warning_text' => '此操作無法撤銷。關聯交易不會被刪除，但將不再與該債務關聯。',
			'debts.actions.add_register.title' => '添加動作',
			'debts.actions.add_register.success' => '運動添加成功',
			'debts.actions.add_register.fab_label' => '新增寄存器',
			'debts.actions.add_register.modal_title' => '新增登記到該債務',
			'debts.actions.add_register.modal_subtitle' => '選擇以下選項之一將交易與該債務關聯起來',
			'debts.actions.link_transaction.title' => '連結現有交易',
			'debts.actions.link_transaction.description' => '選擇現有記錄將其連結到該債務',
			'debts.actions.link_transaction.success' => '與債務掛鉤的交易',
			'debts.actions.link_transaction.creating' => ({required Object name}) => '您正在建立與債務 <b>${name}</b> 關聯的交易',
			'debts.actions.new_transaction.title' => '新增交易',
			'debts.actions.new_transaction.description' => '透過建立與該債務相關的新交易來手動新增或減少債務',
			'debts.actions.create.title' => '創造債務',
			'debts.actions.create.success' => '債務創建成功',
			'target_timeline_statuses.active' => '進行中',
			'target_timeline_statuses.past' => '已完成',
			'target_timeline_statuses.future' => '未開始',
			'backup.no_file_selected' => '未選擇文件',
			'backup.no_directory_selected' => '未選擇目錄',
			'backup.export.title' => '匯出您的資料',
			'backup.export.title_short' => '匯出',
			'backup.export.type_of_export' => '出口類型',
			'backup.export.other_options' => '選項',
			'backup.export.all' => '完整備份',
			'backup.export.all_descr' => '匯出您的所有資料（帳戶、交易、預算、設定...）。隨時重新匯入它們，這樣您就不會丟失任何內容。',
			'backup.export.transactions' => '交易備份',
			'backup.export.transactions_descr' => '以 CSV 格式匯出您的交易，以便您可以在其他程式或應用程式中更輕鬆地分析它們。',
			'backup.export.transactions_to_export' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '1 筆交易要導出', other: '要導出的 ${n} 筆交易', ), 
			'backup.export.description' => '以不同格式下載資料',
			'backup.export.send_file' => '發送文件',
			'backup.export.see_folder' => '查看文件夾',
			'backup.export.success' => ({required Object x}) => '檔案已在${x}中成功儲存/下載',
			'backup.export.error' => '下載檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員',
			'backup.export.dialog_title' => '儲存/傳送文件',
			'backup.import.title' => '匯入您的資料',
			'backup.import.title_short' => '匯入',
			'backup.import.restore_backup' => '恢復備份',
			'backup.import.restore_backup_descr' => '從 Monekin 匯入先前儲存的資料庫。此操作將用新資料取代任何當前應用程式資料',
			'backup.import.restore_backup_warn_description' => '導入新資料庫時，您將丟失應用程式中當前保存的所有資料。建議在繼續之前進行備份。請勿在此處上傳任何來源不明的文件，僅上傳您之前從其下載的文件 Monekin',
			'backup.import.restore_backup_warn_title' => '覆蓋所有數據',
			'backup.import.select_other_file' => '選擇其他文件',
			'backup.import.tap_to_select_file' => '點選選擇檔案',
			'backup.import.manual_import.title' => '手動導入',
			'backup.import.manual_import.descr' => '手動從 .csv 檔案匯入交易',
			'backup.import.manual_import.default_account' => '預設帳戶',
			'backup.import.manual_import.remove_default_account' => '刪除預設帳戶',
			'backup.import.manual_import.default_category' => '預設類別',
			'backup.import.manual_import.select_a_column' => '從 .csv 中選擇一列',
			'backup.import.manual_import.steps.0' => '選擇您的文件',
			'backup.import.manual_import.steps.1' => '數量欄位',
			'backup.import.manual_import.steps.2' => '帳戶欄位',
			'backup.import.manual_import.steps.3' => '類別欄位',
			'backup.import.manual_import.steps.4' => '日期欄位',
			'backup.import.manual_import.steps.5' => '其他欄位',
			'backup.import.manual_import.steps_descr.0' => '從您的裝置中選擇一個 .csv 檔案。確保它的第一行描述了每列的名稱。',
			'backup.import.manual_import.steps_descr.1' => '選擇每筆交易價值的欄位。使用負值表示支出，使用正值表示收入。',
			'backup.import.manual_import.steps_descr.2' => '選擇每筆交易所屬帳戶的列。您也可以選擇預設帳戶，以防我們找不到您想要的帳戶。如果未指定預設帳戶，我們將建立一個同名帳戶。',
			'backup.import.manual_import.steps_descr.3' => '選擇交易類別名稱所在的欄位。您必須指定一個預設類別，以便我們將此類別指派給交易，以防找不到該類別。',
			'backup.import.manual_import.steps_descr.4' => '選擇每筆交易日期的欄位。如果未指定，交易將使用當前日期建立。',
			'backup.import.manual_import.steps_descr.5' => '選擇其他交易屬性的資料列',
			'backup.import.manual_import.success' => ({required Object x}) => '已成功導入${x}筆交易',
			'backup.import.success' => '導入成功',
			'backup.import.error' => '匯入檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員。',
			'backup.import.cancelled' => '導入已被用戶取消',
			'backup.about.title' => '有關您的資料庫的資訊',
			'backup.about.create_date' => '建立日期',
			'backup.about.modify_date' => '上一次更改',
			'backup.about.last_backup' => '上次備份',
			'backup.about.size' => '檔案大小',
			'settings.title_long' => '設定與自訂',
			'settings.title_short' => '設定',
			'settings.description' => '主題、語言、數據等',
			'settings.edit_profile' => '編輯個人資料',
			'settings.general.menu_title' => '常規設定',
			'settings.general.menu_descr' => '語言、隱私等',
			'settings.general.show_all_decimals' => '顯示所有小數位',
			'settings.general.show_all_decimals_descr' => '即使是末尾為零，也顯示所有小數位',
			'settings.general.language.section' => '語言和文本',
			'settings.general.language.title' => '應用程式語言',
			'settings.general.language.descr' => '應用程式中顯示文字的語言',
			'settings.general.language.help' => '如果您想與此應用程式的翻譯合作，您可以參考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我們的指南</a>',
			'settings.general.locale.title' => '地區',
			'settings.general.locale.auto' => '系統',
			'settings.general.locale.descr' => '設定用於日期、數字的格式...',
			'settings.general.locale.warn' => '更改區域時應用程式將更新',
			'settings.general.locale.first_day_of_week' => '一週的第一天',
			'settings.security.title' => '安全',
			'settings.security.private_mode_at_launch' => '啟動時啟用的隱私模式',
			'settings.security.private_mode_at_launch_descr' => '默認以隱私模式啟動應用程序',
			'settings.security.private_mode' => '隱私模式',
			'settings.security.private_mode_descr' => '隱藏所有貨幣值',
			'settings.security.private_mode_activated' => '隱私模式已啟用',
			'settings.security.private_mode_deactivated' => '隱私模式已禁用',
			'settings.transactions.menu_title' => '交易',
			'settings.transactions.menu_descr' => '配置交易行為',
			'settings.transactions.title' => '交易設定',
			'settings.transactions.style.title' => '交易樣式',
			'settings.transactions.style.subtitle' => '設定交易在應用程式列表中的顯示方式',
			'settings.transactions.style.show_tags' => '顯示標籤',
			'settings.transactions.style.show_time' => '顯示時間',
			'settings.transactions.swipe_actions.title' => '滑動操作',
			'settings.transactions.swipe_actions.choose_description' => '選擇當您使用此滑動方向滑動列表中的交易項目時將觸發什麼操作',
			'settings.transactions.swipe_actions.swipe_left' => '向左滑動',
			'settings.transactions.swipe_actions.swipe_right' => '向右滑動',
			'settings.transactions.swipe_actions.none' => '無動作',
			'settings.transactions.swipe_actions.toggle_reconciled' => '切換已調節',
			'settings.transactions.swipe_actions.toggle_pending' => '切換待處理',
			'settings.transactions.swipe_actions.toggle_voided' => '切換作廢',
			'settings.transactions.swipe_actions.toggle_unreconciled' => '切換不可調和',
			'settings.transactions.swipe_actions.remove_status' => '刪除狀態',
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
			'settings.appearance.menu_title' => '主題與風格',
			'settings.appearance.menu_descr' => '主題選擇、顏色以及與應用程式外觀相關的其他內容',
			'settings.appearance.theme_and_colors' => '主題和顏色',
			'settings.appearance.theme.title' => '主題',
			'settings.appearance.theme.auto' => '系統',
			'settings.appearance.theme.light' => '明亮主題',
			'settings.appearance.theme.dark' => '黑暗主題',
			'settings.appearance.amoled_mode' => 'amoled mode',
			'settings.appearance.amoled_mode_descr' => '盡可能使用純黑色壁紙。這對 AMOLED 螢幕設備的電池略有幫助',
			'settings.appearance.dynamic_colors' => '動態色彩',
			'settings.appearance.dynamic_colors_descr' => '盡可能使用系統強調色',
			'settings.appearance.accent_color' => '強調色',
			'settings.appearance.accent_color_descr' => '選擇應用程式用來強調介面某些部分的顏色',
			'settings.appearance.text' => '文本',
			'settings.appearance.font' => '字體',
			'settings.appearance.font_platform' => '平台',
			'more.title' => '更多',
			'more.title_long' => '更多',
			'more.data.display' => '數據',
			'more.data.display_descr' => '匯出和匯入您的數據，這樣您就不會丟失任何東西',
			'more.data.delete_all' => '刪除我的資料',
			'more.data.delete_all_header1' => 'Stop right there padawan ⚠️⚠️',
			'more.data.delete_all_message1' => '您確定要繼續嗎？您的所有資料將永久刪除且無法恢復',
			'more.data.delete_all_header2' => '最後一步⚠️⚠️',
			'more.data.delete_all_message2' => '刪除帳戶後，您將刪除所有儲存的個人資料。您的帳戶、交易、預算和類別將被刪除且無法恢復。您同意嗎？',
			'more.about_us.display' => '應用程式資訊',
			'more.about_us.description' => '查找 Monekin 的條款、重要資訊，並透過回報錯誤或分享想法與我們聯繫',
			'more.about_us.legal.display' => '法律資訊',
			'more.about_us.legal.privacy' => '隱私權政策',
			'more.about_us.legal.terms' => '使用條款',
			'more.about_us.legal.licenses' => '許可證',
			'more.about_us.project.display' => '專案',
			'more.about_us.project.contributors' => '合作者',
			'more.about_us.project.contributors_descr' => '所有讓 Monekin 成長的開發者',
			'more.about_us.project.contact' => '聯絡我們',
			'more.help_us.display' => '幫助我們',
			'more.help_us.description' => '了解如何幫助 Monekin 變得越來越好',
			'more.help_us.rate_us' => '評價我們',
			'more.help_us.rate_us_descr' => '歡迎任何價格！',
			'more.help_us.share' => '分享 Monekin',
			'more.help_us.share_descr' => '與朋友和家人分享我們的應用程式',
			'more.help_us.share_text' => 'Monekin！最好的個人理財應用程式。在這裡下載',
			'more.help_us.thanks' => '謝謝你！',
			'more.help_us.thanks_long' => '您對 Monekin 和其他大大小小的開源專案的貢獻使得這樣偉大的專案成為可能。感謝您花時間做出貢獻。',
			'more.help_us.donate' => '做捐贈',
			'more.help_us.donate_descr' => '透過您的捐款，您將幫助該應用程式繼續改進。還有什麼比邀請我喝咖啡來感謝所做的工作更好的方式呢？',
			'more.help_us.donate_success' => '捐款已完成。非常感謝您的貢獻！❤️',
			'more.help_us.donate_err' => '糟糕！接收您的付款時出現錯誤',
			'more.help_us.report' => '報告錯誤、留下建議…',
			_ => null,
		};
	}
}

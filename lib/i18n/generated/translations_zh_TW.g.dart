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
class TranslationsZhTw implements Translations {
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
	@override String get details => '詳細資訊';
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
	@override String get balance => '平衡';
	@override String get account => '帳戶';
	@override String get accounts => '帳戶';
	@override String get categories => '類別';
	@override String get category => '類別';
	@override String get today => '今天';
	@override String get yesterday => '昨天';
	@override String get filters => '過濾';
	@override String get empty_warn => '哦！這裡非常空';
	@override String get insufficient_data => '數據不足';
	@override String get show_more_fields => '顯示更多欄位';
	@override String get show_less_fields => '顯示較少的欄位';
	@override String get tap_to_search => '點擊即可搜尋';
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
	@override String get currency_manager => '貨幣管理';
	@override String get currency_manager_descr => '配置您的貨幣及其與其他貨幣的匯率';
	@override String get preferred_currency => '首選/基礎貨幣';
	@override String get change_preferred_currency_title => '更改首選貨幣';
	@override String get change_preferred_currency_msg => '從現在開始，所有統計數據和預算都將以該貨幣顯示。帳戶和交易將保留其所擁有的貨幣。如果您執行此操作，所有保存的匯率都將被刪除。您想繼續嗎？';
	@override late final _TranslationsCurrenciesFormZhTw form = _TranslationsCurrenciesFormZhTw._(_root);
	@override String get delete_all_success => '刪除匯率成功';
	@override String get historical => '歷史利率';
	@override String get exchange_rate => '匯率';
	@override String get exchange_rates => '匯率';
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
	@override String get repeated => '週期性';
	@override String get one_time => '一次性';
	@override String get annual => '年度';
	@override String get week => '每週';
	@override String get month => '每月';
	@override String get actives => '活躍';
	@override String get pending => '等待開始';
	@override String get finish => '完成的';
	@override String get from_budgeted => '從預算';
	@override String get days_left => '還剩幾天';
	@override String get days_to_start => '開始的日子';
	@override String get since_expiration => '自到期日起的天數';
	@override String get no_budgets => '此部分中似乎沒有可顯示的預算。首先單擊下面的按鈕以建立預算';
	@override String get delete => '刪除預算';
	@override String get delete_warning => '此操作不可逆轉。引用此報價的類別和交易不會被刪除';
	@override late final _TranslationsBudgetsFormZhTw form = _TranslationsBudgetsFormZhTw._(_root);
	@override late final _TranslationsBudgetsDetailsZhTw details = _TranslationsBudgetsDetailsZhTw._(_root);
}

// Path: backup
class _TranslationsBackupZhTw implements TranslationsBackupEn {
	_TranslationsBackupZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportZhTw export = _TranslationsBackupExportZhTw._(_root);
	@override late final _TranslationsBackupImportZhTw import = _TranslationsBackupImportZhTw._(_root);
	@override late final _TranslationsBackupAboutZhTw about = _TranslationsBackupAboutZhTw._(_root);
}

// Path: settings
class _TranslationsSettingsZhTw implements TranslationsSettingsEn {
	_TranslationsSettingsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title_long => '設定和外觀';
	@override String get title_short => '設定';
	@override String get description => '應用程式主題、文字和其他常規設定';
	@override String get edit_profile => '編輯個人資料';
	@override String get lang_section => '語言和文本';
	@override String get lang_title => '應用程式語言';
	@override String get lang_descr => '應用程式中顯示文字的語言';
	@override String get lang_help => '如果您想與此應用程式的翻譯合作，您可以參考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我們的指南</a>';
	@override String get locale => '地區';
	@override String get locale_auto => '系統';
	@override String get locale_descr => '設定用於日期、數字的格式...';
	@override String get locale_warn => '更改區域時應用程式將更新';
	@override String get first_day_of_week => '一週的第一天';
	@override String get theme_and_colors => '主題和顏色';
	@override String get theme => '主題';
	@override String get theme_auto => '系統';
	@override String get theme_light => '明亮主題';
	@override String get theme_dark => '黑暗主題';
	@override String get amoled_mode => 'amoled mode';
	@override String get amoled_mode_descr => '盡可能使用純黑色壁紙。這對 AMOLED 螢幕設備的電池略有幫助';
	@override String get dynamic_colors => '動態色彩';
	@override String get dynamic_colors_descr => '盡可能使用系統強調色';
	@override String get accent_color => '強調色';
	@override String get accent_color_descr => '選擇應用程式用來強調介面某些部分的顏色';
	@override late final _TranslationsSettingsSwipeActionsZhTw swipe_actions = _TranslationsSettingsSwipeActionsZhTw._(_root);
	@override late final _TranslationsSettingsSecurityZhTw security = _TranslationsSettingsSecurityZhTw._(_root);
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
	@override String get from_value => '從金額';
	@override String get to_value => '最多金額';
	@override String from_value_def({required Object x}) => '來自 ${x}';
	@override String to_value_def({required Object x}) => '最多 ${x}';
	@override String from_date_def({required Object date}) => '從${date}開始';
	@override String to_date_def({required Object date}) => '截至 ${date}';
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

// Path: currencies.form
class _TranslationsCurrenciesFormZhTw implements TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => '幣種不能等於用戶幣種';
	@override String get specify_a_currency => '請指定貨幣';
	@override String get add => '添加匯率';
	@override String get add_success => '匯率新增成功';
	@override String get edit => '編輯匯率';
	@override String get edit_success => '匯率編輯成功';
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
	@override String get edit => '編輯預算';
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
	@override String expend_diary_left({required Object dailyAmount, required Object remainingDays}) => '您每天可以花費${dailyAmount}/天，持續${remainingDays}天';
	@override String get expend_evolution => '支出變化';
	@override String get no_transactions => '看來您還沒有做出與此預算相關的任何收入';
}

// Path: backup.export
class _TranslationsBackupExportZhTw implements TranslationsBackupExportEn {
	_TranslationsBackupExportZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '匯出您的資料';
	@override String get title_short => '匯出';
	@override String get all => '完整備份';
	@override String get all_descr => '匯出您的所有資料（帳戶、交易、預算、設定...）。隨時重新匯入它們，這樣您就不會丟失任何內容。';
	@override String get transactions => '交易備份';
	@override String get transactions_descr => '以 CSV 格式匯出您的交易，以便您可以在其他程式或應用程式中更輕鬆地分析它們。';
	@override String get description => '以不同格式下載資料';
	@override String get dialog_title => '儲存/傳送文件';
	@override String success({required Object x}) => '檔案已在${x}中成功儲存/下載';
	@override String get error => '下載檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員';
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
	@override String get cancelled => '導入已被用戶取消';
	@override String get error => '匯入檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員。';
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

// Path: settings.swipe_actions
class _TranslationsSettingsSwipeActionsZhTw implements TranslationsSettingsSwipeActionsEn {
	_TranslationsSettingsSwipeActionsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '滑動操作';
	@override String get swipe_left => '向左滑動';
	@override String get swipe_right => '向右滑動';
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
	@override String get description => '查看有關 Monekin 的條款和其他相關資訊。透過報告錯誤、留下建議與社區取得聯繫......';
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
		'選擇每筆交易價值的欄位。使用負值表示支出，使用正值表示收入。使用點作為小數點分隔符號。',
		'選擇每筆交易所屬帳戶的列。您也可以選擇預設帳戶，以防我們找不到您想要的帳戶。如果未指定預設帳戶，我們將建立一個同名帳戶。',
		'選擇交易類別名稱所在的欄位。您必須指定一個預設類別，以便我們將此類別指派給交易，以防找不到該類別。',
		'選擇每筆交易日期的欄位。如果未指定，交易將使用當前日期建立。',
		'選擇其他交易屬性的資料列',
	];
	@override String success({required Object x}) => '已成功導入${x}筆交易';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZhTw {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return '取消';
			case 'ui_actions.confirm': return '確認';
			case 'ui_actions.continue_text': return '繼續';
			case 'ui_actions.save': return '保存';
			case 'ui_actions.save_changes': return '儲存變更';
			case 'ui_actions.close_and_save': return '儲存並關閉';
			case 'ui_actions.add': return '添加';
			case 'ui_actions.edit': return '編輯';
			case 'ui_actions.delete': return '刪除';
			case 'ui_actions.see_more': return '查看更多';
			case 'ui_actions.select_all': return '全選';
			case 'ui_actions.deselect_all': return '取消全選';
			case 'ui_actions.select': return '選擇';
			case 'ui_actions.search': return '搜尋';
			case 'ui_actions.filter': return '過濾';
			case 'ui_actions.reset': return '重設';
			case 'ui_actions.submit': return '提交';
			case 'ui_actions.next': return '下一步';
			case 'ui_actions.previous': return '上一步';
			case 'ui_actions.back': return '返回';
			case 'ui_actions.reload': return '重新載入';
			case 'ui_actions.view': return '檢視';
			case 'ui_actions.download': return '下載';
			case 'ui_actions.upload': return '上傳';
			case 'ui_actions.retry': return '重試';
			case 'ui_actions.copy': return '複製';
			case 'ui_actions.paste': return '貼上';
			case 'ui_actions.undo': return '還原';
			case 'ui_actions.redo': return '重做';
			case 'ui_actions.open': return '開啟';
			case 'ui_actions.close': return '關閉';
			case 'ui_actions.apply': return '套用';
			case 'ui_actions.discard': return '捨棄';
			case 'ui_actions.refresh': return '重新整理';
			case 'ui_actions.details': return '詳細資訊';
			case 'ui_actions.share': return '分享';
			case 'general.or': return '或';
			case 'general.understood': return '明白了';
			case 'general.unspecified': return '未指定';
			case 'general.quick_actions': return '快速行動';
			case 'general.balance': return '平衡';
			case 'general.account': return '帳戶';
			case 'general.accounts': return '帳戶';
			case 'general.categories': return '類別';
			case 'general.category': return '類別';
			case 'general.today': return '今天';
			case 'general.yesterday': return '昨天';
			case 'general.filters': return '過濾';
			case 'general.empty_warn': return '哦！這裡非常空';
			case 'general.insufficient_data': return '數據不足';
			case 'general.show_more_fields': return '顯示更多欄位';
			case 'general.show_less_fields': return '顯示較少的欄位';
			case 'general.tap_to_search': return '點擊即可搜尋';
			case 'general.clipboard.success': return ({required Object x}) => '${x}已複製到剪貼簿';
			case 'general.clipboard.error': return '複製錯誤';
			case 'general.time.start_date': return '開始日期';
			case 'general.time.end_date': return '結束日期';
			case 'general.time.from_date': return '從日期';
			case 'general.time.until_date': return '截止日期';
			case 'general.time.date': return '日期';
			case 'general.time.datetime': return '約會時間';
			case 'general.time.time': return '時間';
			case 'general.time.each': return '每個';
			case 'general.time.after': return '後';
			case 'general.time.ranges.display': return '時間範圍';
			case 'general.time.ranges.it_repeat': return '重複';
			case 'general.time.ranges.it_ends': return '結束';
			case 'general.time.ranges.forever': return '永遠';
			case 'general.time.ranges.types.cycle': return '循環';
			case 'general.time.ranges.types.last_days': return '最後一天';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => '前${x}天';
			case 'general.time.ranges.types.all': return '總是';
			case 'general.time.ranges.types.date_range': return '自訂範圍';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '每個${range}',
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
				other: '幾週',
			);
			case 'general.time.periodicity.display': return '週期性';
			case 'general.time.periodicity.no_repeat': return '不再重複';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '重複',
				other: '重複',
			);
			case 'general.time.periodicity.diary': return '日常的';
			case 'general.time.periodicity.monthly': return '每月';
			case 'general.time.periodicity.annually': return '每年';
			case 'general.time.periodicity.quaterly': return '每季';
			case 'general.time.periodicity.weekly': return '每週';
			case 'general.time.periodicity.custom': return '自訂範圍';
			case 'general.time.periodicity.infinite': return '總是';
			case 'general.time.current.monthly': return '這個月';
			case 'general.time.current.annually': return '今年';
			case 'general.time.current.quaterly': return '本季';
			case 'general.time.current.weekly': return '本星期';
			case 'general.time.current.infinite': return '總是';
			case 'general.time.current.custom': return '自訂範圍';
			case 'general.time.all.diary': return '每天';
			case 'general.time.all.monthly': return '每月';
			case 'general.time.all.annually': return '每年';
			case 'general.time.all.quaterly': return '每季';
			case 'general.time.all.weekly': return '每週';
			case 'general.transaction_order.display': return '訂單交易';
			case 'general.transaction_order.category': return '按類別';
			case 'general.transaction_order.quantity': return '按數量';
			case 'general.transaction_order.date': return '按日期';
			case 'general.validations.form_error': return '修正表單中指示的欄位以繼續';
			case 'general.validations.required': return '必填項目';
			case 'general.validations.positive': return '應該是積極的';
			case 'general.validations.min_number': return ({required Object x}) => '應該大於${x}';
			case 'general.validations.max_number': return ({required Object x}) => '應小於${x}';
			case 'intro.start': return '開始';
			case 'intro.skip': return '跳過';
			case 'intro.next': return '下一個';
			case 'intro.select_your_currency': return '選擇您的貨幣';
			case 'intro.welcome_subtitle': return '您的個人財務管家';
			case 'intro.welcome_subtitle2': return '100% 開放，100% 免費';
			case 'intro.welcome_footer': return '登入即表示您同意<a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>隱私權政策</a>和<a href= \'https: //github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>應用程式的使用條款</a>';
			case 'intro.offline_descr_title': return '離線帳戶：';
			case 'intro.offline_descr': return '您的資料只會儲存在您的裝置上，只要您不卸載應用程式或更換手機，資料就安全。為防止資料遺失，建議定期從應用程式設定中進行備份。';
			case 'intro.offline_start': return '離線啟動會話';
			case 'intro.sl1_title': return '選擇您的貨幣';
			case 'intro.sl1_descr': return '您的預設貨幣將用於報告和一般圖表。您以後可以隨時在應用程式設定中更改貨幣和應用程式語言';
			case 'intro.sl2_title': return '安全、隱私、可靠';
			case 'intro.sl2_descr': return '您的資料只屬於您。我們將資訊直接儲存在您的設備上，無需通過外部伺服器。這使得即使沒有互聯網也可以使用該應用程式';
			case 'intro.sl2_descr2': return '此外，該應用程式的源代碼是公開的，任何人都可以對其進行協作並查看它是如何工作的';
			case 'intro.last_slide_title': return '一切準備就緒';
			case 'intro.last_slide_descr': return '有了 Monekin，您終於可以實現您想要的財務獨立。您將擁有圖表、預算、提示、統計數據以及更多有關您的資金的信息。';
			case 'intro.last_slide_descr2': return '我們希望您享受這次體驗！如有疑問、建議，請隨時與我們聯繫......';
			case 'home.title': return '儀表板';
			case 'home.filter_transactions': return '過濾交易';
			case 'home.hello_day': return '早安，';
			case 'home.hello_night': return '晚安，';
			case 'home.total_balance': return '總餘額';
			case 'home.my_accounts': return '我的帳戶';
			case 'home.active_accounts': return '活躍帳戶';
			case 'home.no_accounts': return '尚未建立帳戶';
			case 'home.no_accounts_descr': return '開始使用 Monekin 的所有魔力。至少建立一個帳戶以開始添加交易';
			case 'home.last_transactions': return '最後的交易';
			case 'home.should_create_account_header': return '哎呀！';
			case 'home.should_create_account_message': return '您必須至少擁有一個非存檔帳戶才能開始建立交易';
			case 'financial_health.display': return '財務健康';
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
						return '平均';
					case GenderContext.female:
						return '平均';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '一般';
					case GenderContext.female:
						return '一般';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '非常糟糕';
					case GenderContext.female:
						return '非常糟糕';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return '數據不足';
					case GenderContext.female:
						return '數據不足';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return '看起來我們沒有足夠的收入來計算您的財務健康狀況。添加這段時間的一些收入/收入，以便我們能夠幫助您！';
			case 'financial_health.review.descr.very_good': return '恭喜！您的財務狀況非常好。我們希望您繼續保持良好的勢頭，並繼續與 Monekin 一起學習';
			case 'financial_health.review.descr.good': return '太棒了！您的財務狀況良好。請訪問分析選項卡，了解如何節省更多！';
			case 'financial_health.review.descr.normal': return '您的財務健康狀況或多或少處於這一時期其他人口的平均水平';
			case 'financial_health.review.descr.bad': return '看來您的財務狀況還不是最好的。探索其餘圖表以了解更多有關您財務狀況的信息';
			case 'financial_health.review.descr.very_bad': return '嗯，您的財務健康狀況遠低於應有的水平。探索其餘圖表以了解有關您財務狀況的更多信息';
			case 'financial_health.months_without_income.title': return '存活率';
			case 'financial_health.months_without_income.subtitle': return '考慮到您的餘額，您可以在沒有收入的情況下度過多長時間';
			case 'financial_health.months_without_income.text_zero': return '按照這樣的開支，沒有收入你一個月都活不下去！';
			case 'financial_health.months_without_income.text_one': return '按照這樣的收入，如果沒有收入，你幾乎無法生存大約一個月！';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => '以這樣的支出速度，如果沒有收入，您大約可以生存 <b>${n}個月</b>。';
			case 'financial_health.months_without_income.text_infinite': return '以這樣的支出速度，如果沒有收入，您大約可以<b>一生</b>生存。';
			case 'financial_health.months_without_income.suggestion': return '請記住，建議始終將此比率保持在至少 5 個月以上。如果您發現自己沒有足夠的儲蓄緩衝，請減少不必要的開支。';
			case 'financial_health.months_without_income.insufficient_data': return '看來我們沒有足夠的開支來計算您在沒有收入的情況下可以生存多少個月。輸入幾筆交易，然後回到這裡檢查您的財務狀況';
			case 'financial_health.savings_percentage.title': return '儲蓄百分比';
			case 'financial_health.savings_percentage.subtitle': return '你的收入中有哪一部分沒有在這段時間花掉';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => '恭喜您！您在這段時間裡成功節省了收入的<b>${value}%</b>。看來您已經是專家了，繼續努力吧！';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => '恭喜您，在此期間您已成功節省收入的 <b>${value}%</b>。';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => '在此期間，您已成功節省了收入的 <b>${value}%</b>。但是，我們認為您還可以做得更多！';
			case 'financial_health.savings_percentage.text.very_bad': return '哇哦，這段時間你什麼都沒保存下來。';
			case 'financial_health.savings_percentage.suggestion': return '請記住，建議將收入的至少 15-20% 存起來。';
			case 'stats.title': return '統計數據';
			case 'stats.balance': return '平衡';
			case 'stats.final_balance': return '最終餘額';
			case 'stats.balance_by_account': return '帳戶餘額';
			case 'stats.balance_by_account_subtitle': return '我的大部分錢都在哪裡？';
			case 'stats.balance_by_currency': return '按貨幣餘额';
			case 'stats.balance_by_currency_subtitle': return '我有多少錢的外幣？';
			case 'stats.balance_evolution': return '平衡趨勢';
			case 'stats.balance_evolution_subtitle': return '我的錢比以前多了嗎？';
			case 'stats.compared_to_previous_period': return '與上一时期相比';
			case 'stats.cash_flow': return '現金流';
			case 'stats.cash_flow_subtitle': return '我的支出是否少于我的收入？';
			case 'stats.by_periods': return '按時期';
			case 'stats.by_categories': return '按類別';
			case 'stats.by_tags': return '按標籤';
			case 'stats.distribution': return '分配';
			case 'stats.finance_health_resume': return '恢復';
			case 'stats.finance_health_breakdown': return '分解';
			case 'icon_selector.name': return '姓名：';
			case 'icon_selector.icon': return '圖示';
			case 'icon_selector.color': return '顏色';
			case 'icon_selector.select_icon': return '選擇一個圖示';
			case 'icon_selector.select_color': return '選擇一種顏色';
			case 'icon_selector.custom_color': return '自訂顏色';
			case 'icon_selector.current_color_selection': return '目前選擇';
			case 'icon_selector.select_account_icon': return '識別您的帳戶';
			case 'icon_selector.select_category_icon': return '確定您的類別';
			case 'icon_selector.scopes.transport': return '運輸';
			case 'icon_selector.scopes.money': return '錢';
			case 'icon_selector.scopes.food': return '食物';
			case 'icon_selector.scopes.medical': return '健康';
			case 'icon_selector.scopes.entertainment': return '閒暇';
			case 'icon_selector.scopes.technology': return '技術';
			case 'icon_selector.scopes.other': return '其他的';
			case 'icon_selector.scopes.logos_financial_institutions': return '金融機構';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易',
				other: '交易',
			);
			case 'transaction.create': return '新交易';
			case 'transaction.new_income': return '新收入';
			case 'transaction.new_expense': return '新開支';
			case 'transaction.new_success': return '交易建立成功';
			case 'transaction.edit': return '編輯交易';
			case 'transaction.edit_success': return '交易編輯成功';
			case 'transaction.edit_multiple': return '編輯交易';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x}筆交易已成功編輯';
			case 'transaction.duplicate': return '複製交易';
			case 'transaction.duplicate_short': return '複製';
			case 'transaction.duplicate_warning_message': return '將在同一日期建立與此相同的交易，您想繼續嗎？';
			case 'transaction.duplicate_success': return '交易複製成功';
			case 'transaction.delete': return '刪除交易';
			case 'transaction.delete_warning_message': return '此操作不可逆轉。您的帳戶當前餘額和所有統計資料都將重新計算';
			case 'transaction.delete_success': return '交易已正確刪除';
			case 'transaction.delete_multiple': return '刪除交易';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => '此操作不可逆轉，將刪除${x}筆交易。您帳戶的當前餘額和所有統計資料都將重新計算';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '正確刪除了${x}筆交易';
			case 'transaction.details': return '動作詳情';
			case 'transaction.next_payments.accept': return '接受';
			case 'transaction.next_payments.skip': return '跳過';
			case 'transaction.next_payments.skip_success': return '成功跳過交易';
			case 'transaction.next_payments.skip_dialog_title': return '跳過交易';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => '此操作不可逆轉。我們會將下次移動的日期移至${date}';
			case 'transaction.next_payments.accept_today': return '今天接受';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => '在要求的日期 (${date}) 接受';
			case 'transaction.next_payments.accept_dialog_title': return '接受交易';
			case 'transaction.next_payments.accept_dialog_msg_single': return '該交易的新狀態將為空。您可以隨時重新編輯該交易的狀態';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => '此操作將建立日期為${date}的新交易。您將能夠在交易頁面上查看此交易的詳細資訊';
			case 'transaction.next_payments.recurrent_rule_finished': return '循環規則已完成，無需再支付！';
			case 'transaction.list.empty': return '未發現此處顯示的交易。在應用程式中添加一些交易，也許您下次會有更好的運氣';
			case 'transaction.list.searcher_placeholder': return '按類別、描述搜尋...';
			case 'transaction.list.searcher_no_results': return '未找到符合搜尋條件的交易';
			case 'transaction.list.loading': return '正在加載更多交易...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '${n} 已選取',
				other: '${n} 已選取',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '已選擇 ${n} 筆交易',
				other: '選擇 ${n} 筆交易',
			);
			case 'transaction.list.bulk_edit.dates': return '編輯日期';
			case 'transaction.list.bulk_edit.categories': return '編輯類別';
			case 'transaction.list.bulk_edit.status': return '編輯狀態';
			case 'transaction.filters.from_value': return '從金額';
			case 'transaction.filters.to_value': return '最多金額';
			case 'transaction.filters.from_value_def': return ({required Object x}) => '來自 ${x}';
			case 'transaction.filters.to_value_def': return ({required Object x}) => '最多 ${x}';
			case 'transaction.filters.from_date_def': return ({required Object date}) => '從${date}開始';
			case 'transaction.filters.to_date_def': return ({required Object date}) => '截至 ${date}';
			case 'transaction.form.validators.zero': return '一筆交易的價值不能等於零';
			case 'transaction.form.validators.date_max': return '所選日期晚於當前日期。交易將新增為待處理';
			case 'transaction.form.validators.date_after_account_creation': return '您無法建立日期早於所屬帳戶建立日期的交易';
			case 'transaction.form.validators.negative_transfer': return '轉帳的貨幣價值不能為負數';
			case 'transaction.form.validators.transfer_between_same_accounts': return '來源帳號與目標帳號不能符合';
			case 'transaction.form.title': return '交易標題';
			case 'transaction.form.title_short': return '資質';
			case 'transaction.form.value': return '交易價值';
			case 'transaction.form.tap_to_see_more': return '點擊查看更多詳細資訊';
			case 'transaction.form.no_tags': return '-- 無標籤 --';
			case 'transaction.form.description': return '描述';
			case 'transaction.form.description_info': return '點擊此處輸入有關此交易的更詳細描述';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => '匯率為${currency}';
			case 'transaction.form.exchange_to_preferred_in_date': return '交易日';
			case 'transaction.reversed.title': return '逆向交易';
			case 'transaction.reversed.title_short': return '逆向交易';
			case 'transaction.reversed.description_for_expenses': return '儘管是收入交易，但它的金額為正數。這些類型的交易可用於表示先前記錄的收入的返還，例如退款或償還債務。';
			case 'transaction.reversed.description_for_incomes': return '儘管是一項收入交易，但其金額為負數。這些類型的交易可用於作廢或更正錯誤記錄的收入，反映資金的返還或退款或記錄債務的支付。';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '地位',
				other: '狀態',
			);
			case 'transaction.status.display_long': return '交易狀態';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status}交易';
			case 'transaction.status.none': return '無狀態';
			case 'transaction.status.none_descr': return '沒有特定狀態的交易';
			case 'transaction.status.reconciled': return '已驗證';
			case 'transaction.status.reconciled_descr': return '此交易已經過驗證，並且與您銀行的真實交易相對應';
			case 'transaction.status.unreconciled': return '未驗證';
			case 'transaction.status.unreconciled_descr': return '此交易尚未經過驗證，因此尚未出現在您的真實銀行帳戶中。但是，它將計算 Monekin 中的餘額和統計數據';
			case 'transaction.status.pending': return '待辦';
			case 'transaction.status.pending_descr': return '此交易正在等待處理，因此在計算餘額和統計數據時不會考慮它';
			case 'transaction.status.voided': return '作廢';
			case 'transaction.status.voided_descr': return '由於付款錯誤或任何其他原因導致的交易無效/取消。在計算餘額和統計時不會考慮該交易';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '交易類型',
				other: '交易類型',
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
				one: '轉移',
				other: '轉移',
			);
			case 'transfer.display': return '轉移';
			case 'transfer.transfers': return '轉移';
			case 'transfer.transfer_to': return ({required Object account}) => '轉移至${account}';
			case 'transfer.create': return '轉移';
			case 'transfer.need_two_accounts_warning_header': return 'Ops!';
			case 'transfer.need_two_accounts_warning_message': return '至少需要兩個帳戶才能執行此操作。如果您需要調整或編輯該帳戶的當前餘額，請點擊編輯按鈕';
			case 'transfer.form.from': return '原始帳戶';
			case 'transfer.form.to': return '目的地帳戶';
			case 'transfer.form.value_in_destiny.title': return '目的地轉帳金额';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => '${amount}至目標帳户';
			case 'recurrent_transactions.title': return '經常交易';
			case 'recurrent_transactions.title_short': return '經常交易';
			case 'recurrent_transactions.empty': return '您似乎沒有任何經常交易。建立每月、每年或每週的經常交易，它將顯示在此處';
			case 'recurrent_transactions.total_expense_title': return '每個期間的總收入';
			case 'recurrent_transactions.total_expense_descr': return '*不考慮每次重複的開始和結束日期';
			case 'recurrent_transactions.details.title': return '經常交易';
			case 'recurrent_transactions.details.descr': return '此交易的下一步動作如下所示。您可以接受第一步動作或跳過此動作';
			case 'recurrent_transactions.details.last_payment_info': return '此動作是循環規則的最後一個，因此當確認此動作時，該規則將自動刪除';
			case 'recurrent_transactions.details.delete_header': return '刪除重複交易';
			case 'recurrent_transactions.details.delete_message': return '此操作不可逆轉，不會影響您已確認/付款的交易';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => '延遲了 ${x}d';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => '${x} 天後';
			case 'account.details': return '帳戶詳細資料';
			case 'account.date': return '開業日期';
			case 'account.close_date': return '截止日期';
			case 'account.reopen': return '重新開立帳戶';
			case 'account.reopen_short': return '重新開放';
			case 'account.reopen_descr': return '您確定要重新開啟此帳戶嗎？';
			case 'account.balance': return '帳戶餘額';
			case 'account.n_transactions': return '交易數量';
			case 'account.add_money': return '增加金額';
			case 'account.withdraw_money': return '取出金額';
			case 'account.no_accounts': return '未發現此處顯示的交易。請點選底部的 \'+\' 按鈕新增交易';
			case 'account.types.title': return '帳戶類型';
			case 'account.types.warning': return '帳戶類型一旦選擇，以後將無法更改';
			case 'account.types.normal': return '普通帳戶';
			case 'account.types.normal_descr': return '對於記錄您的日常財務很有用。這是最常見的帳戶，它可以讓您添加支出、收入......';
			case 'account.types.saving': return '儲蓄帳戶';
			case 'account.types.saving_descr': return '您只能從其他帳戶中添加和提取資金。非常適合開始存錢';
			case 'account.form.name': return '帳戶名稱';
			case 'account.form.name_placeholder': return '例如：儲蓄帳戶';
			case 'account.form.notes': return '筆記';
			case 'account.form.notes_placeholder': return '輸入有關此帳戶的一些註釋/描述';
			case 'account.form.initial_balance': return '初始餘額';
			case 'account.form.current_balance': return '當前餘額';
			case 'account.form.create': return '建立帳戶';
			case 'account.form.edit': return '編輯帳戶';
			case 'account.form.currency_not_found_warn': return '您沒有該貨幣的匯率資訊。1.0 將用作預設匯率。您可以在設定中修改';
			case 'account.form.already_exists': return '已經有另一個同名，請再寫一個';
			case 'account.form.tr_before_opening_date': return '該帳戶中有日期早於開戶日期的交易';
			case 'account.form.iban': return 'iban';
			case 'account.form.swift': return 'swift';
			case 'account.delete.warning_header': return '刪除帳戶？';
			case 'account.delete.warning_text': return '此操作將刪除該帳戶及其所有交易';
			case 'account.delete.success': return '帳號刪除成功';
			case 'account.close.title': return '關閉帳戶';
			case 'account.close.title_short': return '關閉';
			case 'account.close.warn': return '此帳戶將不再出現在某些清單中，您將無法在其中建立日期晚於下面指定的日期的交易。此操作不會影響任何交易或餘額，您也可以隨時重新開啟此帳戶時間。 ';
			case 'account.close.should_have_zero_balance': return '此帳戶中的當前餘額必須為 0 才能關閉它。請在繼續之前編輯帳戶';
			case 'account.close.should_have_no_transactions': return '此帳戶在指定的關閉日期之後有交易。請刪除它們或編輯帳戶關閉日期，然後再繼續';
			case 'account.close.success': return '帳戶關閉成功';
			case 'account.close.unarchive_succes': return '帳戶已成功重新開設';
			case 'account.select.one': return '選擇一個帳戶';
			case 'account.select.all': return '所有帳戶';
			case 'account.select.multiple': return '選擇帳戶';
			case 'currencies.currency_converter': return '貨幣換算';
			case 'currencies.currency': return '貨幣';
			case 'currencies.currency_manager': return '貨幣管理';
			case 'currencies.currency_manager_descr': return '配置您的貨幣及其與其他貨幣的匯率';
			case 'currencies.preferred_currency': return '首選/基礎貨幣';
			case 'currencies.change_preferred_currency_title': return '更改首選貨幣';
			case 'currencies.change_preferred_currency_msg': return '從現在開始，所有統計數據和預算都將以該貨幣顯示。帳戶和交易將保留其所擁有的貨幣。如果您執行此操作，所有保存的匯率都將被刪除。您想繼續嗎？';
			case 'currencies.form.equal_to_preferred_warn': return '幣種不能等於用戶幣種';
			case 'currencies.form.specify_a_currency': return '請指定貨幣';
			case 'currencies.form.add': return '添加匯率';
			case 'currencies.form.add_success': return '匯率新增成功';
			case 'currencies.form.edit': return '編輯匯率';
			case 'currencies.form.edit_success': return '匯率編輯成功';
			case 'currencies.delete_all_success': return '刪除匯率成功';
			case 'currencies.historical': return '歷史利率';
			case 'currencies.exchange_rate': return '匯率';
			case 'currencies.exchange_rates': return '匯率';
			case 'currencies.empty': return '在此處添加匯率，以便如果您的帳戶使用基礎貨幣以外的貨幣，我們的圖表會更加準確';
			case 'currencies.select_a_currency': return '選擇貨幣';
			case 'currencies.search': return '按名稱或貨幣代碼搜尋';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
				one: '標籤',
				other: '標籤',
			);
			case 'tags.form.name': return '標籤名';
			case 'tags.form.description': return '描述';
			case 'tags.select.title': return '選擇標籤';
			case 'tags.select.all': return '所有標籤';
			case 'tags.empty_list': return '您還沒有建立任何標籤。標籤和類別是對您的動作進行分類的好方法';
			case 'tags.without_tags': return '沒有標籤';
			case 'tags.add': return '添加標籤';
			case 'tags.create': return '建立標籤';
			case 'tags.create_success': return '標籤建立成功';
			case 'tags.already_exists': return '此標籤名稱已存在。您可能需要編輯它';
			case 'tags.edit': return '編輯標籤';
			case 'tags.edit_success': return '標籤編輯成功';
			case 'tags.delete_success': return '類別刪除成功';
			case 'tags.delete_warning_header': return '刪除標籤？';
			case 'tags.delete_warning_message': return '此操作不會刪除具有此標籤的交易。';
			case 'categories.unknown': return '未知類別';
			case 'categories.create': return '建立類別';
			case 'categories.create_success': return '類別建立成功';
			case 'categories.new_category': return '新類別';
			case 'categories.already_exists': return '該類別的名稱已存在。也許您可以編輯';
			case 'categories.edit': return '編輯類別';
			case 'categories.edit_success': return '類別編輯成功';
			case 'categories.name': return '分類名稱';
			case 'categories.type': return '類別類型';
			case 'categories.both_types': return '兩種類型';
			case 'categories.subcategories': return '子類別';
			case 'categories.subcategories_add': return '新增子類別';
			case 'categories.make_parent': return '按類別製作';
			case 'categories.make_child': return '建立一個子類別';
			case 'categories.make_child_warning1': return ({required Object destiny}) => '此類別及其子類別將成為<b>${destiny}</b>的子類別。';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => '他們的交易<b>(${x})</b>將被移至<b>${destiny}</b>類別中建立的新子類別。';
			case 'categories.make_child_success': return '子類別建立成功';
			case 'categories.merge': return '與另一個類別合併';
			case 'categories.merge_warning1': return ({required Object from, required Object x, required Object destiny}) => '與類別<b>${from}</b>相關的所有交易 (${x}) 將移至類別<b>${destiny}</b>';
			case 'categories.merge_warning2': return ({required Object from}) => '類別<b>${from}</b>將被不可逆轉地刪除。 ';
			case 'categories.merge_success': return '類別合併成功';
			case 'categories.delete_success': return '類別已成功刪除';
			case 'categories.delete_warning_header': return '刪除類別？';
			case 'categories.delete_warning_message': return ({required Object x}) => '此操作將不可逆轉地刪除與此類別相關的所有交易<b>(${x})</b>。';
			case 'categories.select.title': return '選擇類別';
			case 'categories.select.select_one': return '選擇一個類別';
			case 'categories.select.select_subcategory': return '選擇一個子類別';
			case 'categories.select.without_subcategory': return '沒有子類別';
			case 'categories.select.all': return '所有類別';
			case 'categories.select.all_short': return '全部';
			case 'budgets.title': return '預算';
			case 'budgets.repeated': return '週期性';
			case 'budgets.one_time': return '一次性';
			case 'budgets.annual': return '年度';
			case 'budgets.week': return '每週';
			case 'budgets.month': return '每月';
			case 'budgets.actives': return '活躍';
			case 'budgets.pending': return '等待開始';
			case 'budgets.finish': return '完成的';
			case 'budgets.from_budgeted': return '從預算';
			case 'budgets.days_left': return '還剩幾天';
			case 'budgets.days_to_start': return '開始的日子';
			case 'budgets.since_expiration': return '自到期日起的天數';
			case 'budgets.no_budgets': return '此部分中似乎沒有可顯示的預算。首先單擊下面的按鈕以建立預算';
			case 'budgets.delete': return '刪除預算';
			case 'budgets.delete_warning': return '此操作不可逆轉。引用此報價的類別和交易不會被刪除';
			case 'budgets.form.title': return '添加預算';
			case 'budgets.form.name': return '預算名稱';
			case 'budgets.form.value': return '數量限制';
			case 'budgets.form.create': return '添加預算';
			case 'budgets.form.edit': return '編輯預算';
			case 'budgets.form.negative_warn': return '預算不能有負數';
			case 'budgets.details.title': return '預算詳情';
			case 'budgets.details.statistics': return '統計數據';
			case 'budgets.details.budget_value': return '預算';
			case 'budgets.details.expend_diary_left': return ({required Object dailyAmount, required Object remainingDays}) => '您每天可以花費${dailyAmount}/天，持續${remainingDays}天';
			case 'budgets.details.expend_evolution': return '支出變化';
			case 'budgets.details.no_transactions': return '看來您還沒有做出與此預算相關的任何收入';
			case 'backup.export.title': return '匯出您的資料';
			case 'backup.export.title_short': return '匯出';
			case 'backup.export.all': return '完整備份';
			case 'backup.export.all_descr': return '匯出您的所有資料（帳戶、交易、預算、設定...）。隨時重新匯入它們，這樣您就不會丟失任何內容。';
			case 'backup.export.transactions': return '交易備份';
			case 'backup.export.transactions_descr': return '以 CSV 格式匯出您的交易，以便您可以在其他程式或應用程式中更輕鬆地分析它們。';
			case 'backup.export.description': return '以不同格式下載資料';
			case 'backup.export.dialog_title': return '儲存/傳送文件';
			case 'backup.export.success': return ({required Object x}) => '檔案已在${x}中成功儲存/下載';
			case 'backup.export.error': return '下載檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員';
			case 'backup.import.title': return '匯入您的資料';
			case 'backup.import.title_short': return '匯入';
			case 'backup.import.restore_backup': return '恢復備份';
			case 'backup.import.restore_backup_descr': return '從 Monekin 匯入先前儲存的資料庫。此操作將用新資料取代任何當前應用程式資料';
			case 'backup.import.restore_backup_warn_description': return '導入新資料庫時，您將丟失應用程式中當前保存的所有資料。建議在繼續之前進行備份。請勿在此處上傳任何來源不明的文件，僅上傳您之前從其下載的文件 Monekin';
			case 'backup.import.restore_backup_warn_title': return '覆蓋所有數據';
			case 'backup.import.select_other_file': return '選擇其他文件';
			case 'backup.import.tap_to_select_file': return '點選選擇檔案';
			case 'backup.import.manual_import.title': return '手動導入';
			case 'backup.import.manual_import.descr': return '手動從 .csv 檔案匯入交易';
			case 'backup.import.manual_import.default_account': return '預設帳戶';
			case 'backup.import.manual_import.remove_default_account': return '刪除預設帳戶';
			case 'backup.import.manual_import.default_category': return '預設類別';
			case 'backup.import.manual_import.select_a_column': return '從 .csv 中選擇一列';
			case 'backup.import.manual_import.steps.0': return '選擇您的文件';
			case 'backup.import.manual_import.steps.1': return '數量欄位';
			case 'backup.import.manual_import.steps.2': return '帳戶欄位';
			case 'backup.import.manual_import.steps.3': return '類別欄位';
			case 'backup.import.manual_import.steps.4': return '日期欄位';
			case 'backup.import.manual_import.steps.5': return '其他欄位';
			case 'backup.import.manual_import.steps_descr.0': return '從您的裝置中選擇一個 .csv 檔案。確保它的第一行描述了每列的名稱。';
			case 'backup.import.manual_import.steps_descr.1': return '選擇每筆交易價值的欄位。使用負值表示支出，使用正值表示收入。使用點作為小數點分隔符號。';
			case 'backup.import.manual_import.steps_descr.2': return '選擇每筆交易所屬帳戶的列。您也可以選擇預設帳戶，以防我們找不到您想要的帳戶。如果未指定預設帳戶，我們將建立一個同名帳戶。';
			case 'backup.import.manual_import.steps_descr.3': return '選擇交易類別名稱所在的欄位。您必須指定一個預設類別，以便我們將此類別指派給交易，以防找不到該類別。';
			case 'backup.import.manual_import.steps_descr.4': return '選擇每筆交易日期的欄位。如果未指定，交易將使用當前日期建立。';
			case 'backup.import.manual_import.steps_descr.5': return '選擇其他交易屬性的資料列';
			case 'backup.import.manual_import.success': return ({required Object x}) => '已成功導入${x}筆交易';
			case 'backup.import.success': return '導入成功';
			case 'backup.import.cancelled': return '導入已被用戶取消';
			case 'backup.import.error': return '匯入檔案時發生錯誤。請透過 lozin.technologies@gmail.com 聯絡開發人員。';
			case 'backup.about.title': return '有關您的資料庫的資訊';
			case 'backup.about.create_date': return '建立日期';
			case 'backup.about.modify_date': return '上一次更改';
			case 'backup.about.last_backup': return '上次備份';
			case 'backup.about.size': return '檔案大小';
			case 'settings.title_long': return '設定和外觀';
			case 'settings.title_short': return '設定';
			case 'settings.description': return '應用程式主題、文字和其他常規設定';
			case 'settings.edit_profile': return '編輯個人資料';
			case 'settings.lang_section': return '語言和文本';
			case 'settings.lang_title': return '應用程式語言';
			case 'settings.lang_descr': return '應用程式中顯示文字的語言';
			case 'settings.lang_help': return '如果您想與此應用程式的翻譯合作，您可以參考<a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>我們的指南</a>';
			case 'settings.locale': return '地區';
			case 'settings.locale_auto': return '系統';
			case 'settings.locale_descr': return '設定用於日期、數字的格式...';
			case 'settings.locale_warn': return '更改區域時應用程式將更新';
			case 'settings.first_day_of_week': return '一週的第一天';
			case 'settings.theme_and_colors': return '主題和顏色';
			case 'settings.theme': return '主題';
			case 'settings.theme_auto': return '系統';
			case 'settings.theme_light': return '明亮主題';
			case 'settings.theme_dark': return '黑暗主題';
			case 'settings.amoled_mode': return 'amoled mode';
			case 'settings.amoled_mode_descr': return '盡可能使用純黑色壁紙。這對 AMOLED 螢幕設備的電池略有幫助';
			case 'settings.dynamic_colors': return '動態色彩';
			case 'settings.dynamic_colors_descr': return '盡可能使用系統強調色';
			case 'settings.accent_color': return '強調色';
			case 'settings.accent_color_descr': return '選擇應用程式用來強調介面某些部分的顏色';
			case 'settings.swipe_actions.title': return '滑動操作';
			case 'settings.swipe_actions.swipe_left': return '向左滑動';
			case 'settings.swipe_actions.swipe_right': return '向右滑動';
			case 'settings.security.title': return '安全';
			case 'settings.security.private_mode_at_launch': return '啟動時啟用的隱私模式';
			case 'settings.security.private_mode_at_launch_descr': return '默認以隱私模式啟動應用程序';
			case 'settings.security.private_mode': return '隱私模式';
			case 'settings.security.private_mode_descr': return '隱藏所有貨幣值';
			case 'settings.security.private_mode_activated': return '隱私模式已啟用';
			case 'settings.security.private_mode_deactivated': return '隱私模式已禁用';
			case 'more.title': return '更多';
			case 'more.title_long': return '更多';
			case 'more.data.display': return '數據';
			case 'more.data.display_descr': return '匯出和匯入您的數據，這樣您就不會丟失任何東西';
			case 'more.data.delete_all': return '刪除我的資料';
			case 'more.data.delete_all_header1': return 'Stop right there padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return '您確定要繼續嗎？您的所有資料將永久刪除且無法恢復';
			case 'more.data.delete_all_header2': return '最後一步⚠️⚠️';
			case 'more.data.delete_all_message2': return '刪除帳戶後，您將刪除所有儲存的個人資料。您的帳戶、交易、預算和類別將被刪除且無法恢復。您同意嗎？';
			case 'more.about_us.display': return '應用程式資訊';
			case 'more.about_us.description': return '查看有關 Monekin 的條款和其他相關資訊。透過報告錯誤、留下建議與社區取得聯繫......';
			case 'more.about_us.legal.display': return '法律資訊';
			case 'more.about_us.legal.privacy': return '隱私權政策';
			case 'more.about_us.legal.terms': return '使用條款';
			case 'more.about_us.legal.licenses': return '許可證';
			case 'more.about_us.project.display': return '專案';
			case 'more.about_us.project.contributors': return '合作者';
			case 'more.about_us.project.contributors_descr': return '所有讓 Monekin 成長的開發者';
			case 'more.about_us.project.contact': return '聯絡我們';
			case 'more.help_us.display': return '幫助我們';
			case 'more.help_us.description': return '了解如何幫助 Monekin 變得越來越好';
			case 'more.help_us.rate_us': return '評價我們';
			case 'more.help_us.rate_us_descr': return '歡迎任何價格！';
			case 'more.help_us.share': return '分享 Monekin';
			case 'more.help_us.share_descr': return '與朋友和家人分享我們的應用程式';
			case 'more.help_us.share_text': return 'Monekin！最好的個人理財應用程式。在這裡下載';
			case 'more.help_us.thanks': return '謝謝你！';
			case 'more.help_us.thanks_long': return '您對 Monekin 和其他大大小小的開源專案的貢獻使得這樣偉大的專案成為可能。感謝您花時間做出貢獻。';
			case 'more.help_us.donate': return '做捐贈';
			case 'more.help_us.donate_descr': return '透過您的捐款，您將幫助該應用程式繼續改進。還有什麼比邀請我喝咖啡來感謝所做的工作更好的方式呢？';
			case 'more.help_us.donate_success': return '捐款已完成。非常感謝您的貢獻！❤️';
			case 'more.help_us.donate_err': return '糟糕！接收您的付款時出現錯誤';
			case 'more.help_us.report': return '報告錯誤、留下建議…';
			default: return null;
		}
	}
}


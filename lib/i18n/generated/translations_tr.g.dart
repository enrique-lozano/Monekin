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
class TranslationsTr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.tr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <tr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsTr _root = this; // ignore: unused_field

	@override 
	TranslationsTr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsTr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsUiActionsTr ui_actions = _TranslationsUiActionsTr._(_root);
	@override late final _TranslationsGeneralTr general = _TranslationsGeneralTr._(_root);
	@override late final _TranslationsIntroTr intro = _TranslationsIntroTr._(_root);
	@override late final _TranslationsHomeTr home = _TranslationsHomeTr._(_root);
	@override late final _TranslationsFinancialHealthTr financial_health = _TranslationsFinancialHealthTr._(_root);
	@override late final _TranslationsStatsTr stats = _TranslationsStatsTr._(_root);
	@override late final _TranslationsIconSelectorTr icon_selector = _TranslationsIconSelectorTr._(_root);
	@override late final _TranslationsTransactionTr transaction = _TranslationsTransactionTr._(_root);
	@override late final _TranslationsTransferTr transfer = _TranslationsTransferTr._(_root);
	@override late final _TranslationsRecurrentTransactionsTr recurrent_transactions = _TranslationsRecurrentTransactionsTr._(_root);
	@override late final _TranslationsAccountTr account = _TranslationsAccountTr._(_root);
	@override late final _TranslationsCurrenciesTr currencies = _TranslationsCurrenciesTr._(_root);
	@override late final _TranslationsTagsTr tags = _TranslationsTagsTr._(_root);
	@override late final _TranslationsCategoriesTr categories = _TranslationsCategoriesTr._(_root);
	@override late final _TranslationsBudgetsTr budgets = _TranslationsBudgetsTr._(_root);
	@override late final _TranslationsGoalsTr goals = _TranslationsGoalsTr._(_root);
	@override late final _TranslationsTargetTimelineStatusesTr target_timeline_statuses = _TranslationsTargetTimelineStatusesTr._(_root);
	@override late final _TranslationsBackupTr backup = _TranslationsBackupTr._(_root);
	@override late final _TranslationsSettingsTr settings = _TranslationsSettingsTr._(_root);
	@override late final _TranslationsMoreTr more = _TranslationsMoreTr._(_root);
}

// Path: ui_actions
class _TranslationsUiActionsTr implements TranslationsUiActionsEn {
	_TranslationsUiActionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'İptal';
	@override String get confirm => 'Onayla';
	@override String get continue_text => 'Devam Et';
	@override String get save => 'Kaydet';
	@override String get save_changes => 'Değişiklikleri Kaydet';
	@override String get close_and_save => 'Kaydet ve Kapat';
	@override String get add => 'Ekle';
	@override String get edit => 'Düzenle';
	@override String get delete => 'Sil';
	@override String get see_more => 'Daha Fazla Gör';
	@override String get select_all => 'Tümünü Seç';
	@override String get deselect_all => 'Tüm Seçimi Kaldır';
	@override String get select => 'Seç';
	@override String get search => 'Ara';
	@override String get filter => 'Filtrele';
	@override String get reset => 'Sıfırla';
	@override String get submit => 'Gönder';
	@override String get next => 'Sonraki';
	@override String get previous => 'Önceki';
	@override String get back => 'Geri';
	@override String get reload => 'Yenile';
	@override String get view => 'Görüntüle';
	@override String get download => 'İndir';
	@override String get upload => 'Yükle';
	@override String get retry => 'Tekrar Dene';
	@override String get copy => 'Kopyala';
	@override String get paste => 'Yapıştır';
	@override String get undo => 'Geri Al';
	@override String get redo => 'İleri Al';
	@override String get open => 'Aç';
	@override String get close => 'Kapat';
	@override String get apply => 'Uygula';
	@override String get discard => 'Vazgeç';
	@override String get refresh => 'Yenile';
	@override String get share => 'Paylaş';
}

// Path: general
class _TranslationsGeneralTr implements TranslationsGeneralEn {
	_TranslationsGeneralTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get or => 'veya';
	@override String get understood => 'Anlaşıldı';
	@override String get unspecified => 'Belirtilmemiş';
	@override String get quick_actions => 'Hızlı İşlemler';
	@override String get details => 'Detaylar';
	@override String get balance => 'Bakiye';
	@override String get account => 'Hesap';
	@override String get accounts => 'Hesaplar';
	@override String get categories => 'Kategoriler';
	@override String get category => 'Kategori';
	@override String get today => 'Bugün';
	@override String get yesterday => 'Dün';
	@override String get filters => 'Filtreler';
	@override String get empty_warn => 'Ups! Burası çok boş';
	@override String get search_no_results => 'Arama kriterlerinizle eşleşen öğe yok';
	@override String get insufficient_data => 'Yetersiz veri';
	@override String get show_more_fields => 'Daha fazla alan göster';
	@override String get show_less_fields => 'Daha az alan göster';
	@override String get tap_to_search => 'Aramak için dokunun';
	@override String get delete_success => 'Öğe başarıyla silindi';
	@override late final _TranslationsGeneralLeaveWithoutSavingTr leave_without_saving = _TranslationsGeneralLeaveWithoutSavingTr._(_root);
	@override late final _TranslationsGeneralClipboardTr clipboard = _TranslationsGeneralClipboardTr._(_root);
	@override late final _TranslationsGeneralTimeTr time = _TranslationsGeneralTimeTr._(_root);
	@override late final _TranslationsGeneralTransactionOrderTr transaction_order = _TranslationsGeneralTransactionOrderTr._(_root);
	@override late final _TranslationsGeneralValidationsTr validations = _TranslationsGeneralValidationsTr._(_root);
}

// Path: intro
class _TranslationsIntroTr implements TranslationsIntroEn {
	_TranslationsIntroTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get start => 'Başla';
	@override String get skip => 'Atla';
	@override String get next => 'İleri';
	@override String get select_your_currency => 'Para birimini seçin';
	@override String get welcome_subtitle => 'Kişisel finans yöneticiniz';
	@override String get welcome_subtitle2 => '%100 açık, %100 ücretsiz';
	@override String get welcome_footer => 'Giriş yaparak, uygulamanın <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Gizlilik Politikası</a> ve <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Kullanım Şartları</a>\'nı kabul etmiş olursunuz';
	@override String get offline_descr_title => 'ÇEVRİMDIŞI HESAP:';
	@override String get offline_descr => 'Verileriniz yalnızca cihazınızda saklanacak ve uygulamayı kaldırmadığınız veya telefon değiştirmediniz sürece güvende olacaktır. Veri kaybını önlemek için, uygulama ayarlarından düzenli olarak yedekleme yapılması önerilir.';
	@override String get offline_start => 'Çevrimdışı oturum başlat';
	@override String get sl1_title => 'Para birimini seçin';
	@override String get sl1_descr => 'Varsayılan para biriminiz raporlarda ve genel grafiklerde kullanılacaktır. Uygulama ayarlarından daha sonra istediğiniz zaman para birimini ve uygulama dilini değiştirebileceksiniz';
	@override String get sl2_title => 'Güvenli, gizli ve güvenilir';
	@override String get sl2_descr => 'Verileriniz yalnızca size aittir. Bilgileri harici sunuculara gitmeden doğrudan cihazınızda saklarız. Bu, uygulamayı internet olmadan bile kullanmayı mümkün kılar';
	@override String get sl2_descr2 => 'Ayrıca, uygulamanın kaynak kodu herkese açıktır, herkes üzerinde işbirliği yapabilir ve nasıl çalıştığını görebilir';
	@override String get last_slide_title => 'Her şey hazır';
	@override String get last_slide_descr => 'Monekin ile sonunda çok istediğiniz finansal bağımsızlığa ulaşabilirsiniz. Paranız hakkında grafiklere, bütçelere, ipuçlarına, istatistiklere ve çok daha fazlasına sahip olacaksınız.';
	@override String get last_slide_descr2 => 'Umarız deneyiminizden keyif alırsınız! Şüpheleriniz, önerileriniz durumunda bizimle iletişime geçmekten çekinmeyin...';
}

// Path: home
class _TranslationsHomeTr implements TranslationsHomeEn {
	_TranslationsHomeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gösterge Paneli';
	@override String get filter_transactions => 'İşlemleri filtrele';
	@override String get hello_day => 'Günaydın,';
	@override String get hello_night => 'İyi geceler,';
	@override String get total_balance => 'Toplam bakiye';
	@override String get my_accounts => 'Hesaplarım';
	@override String get active_accounts => 'Aktif hesaplar';
	@override String get no_accounts => 'Henüz hesap oluşturulmadı';
	@override String get no_accounts_descr => 'Monekin\'in tüm sihrini kullanmaya başlayın. İşlem eklemeye başlamak için en az bir hesap oluşturun';
	@override String get last_transactions => 'Son işlemler';
	@override String get should_create_account_header => 'Ups!';
	@override String get should_create_account_message => 'İşlem oluşturmaya başlamadan önce en az bir arşivlenmemiş hesabınız olmalıdır';
}

// Path: financial_health
class _TranslationsFinancialHealthTr implements TranslationsFinancialHealthEn {
	_TranslationsFinancialHealthTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Finansal sağlık';
	@override late final _TranslationsFinancialHealthReviewTr review = _TranslationsFinancialHealthReviewTr._(_root);
	@override late final _TranslationsFinancialHealthMonthsWithoutIncomeTr months_without_income = _TranslationsFinancialHealthMonthsWithoutIncomeTr._(_root);
	@override late final _TranslationsFinancialHealthSavingsPercentageTr savings_percentage = _TranslationsFinancialHealthSavingsPercentageTr._(_root);
}

// Path: stats
class _TranslationsStatsTr implements TranslationsStatsEn {
	_TranslationsStatsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'İstatistikler';
	@override String get balance => 'Bakiye';
	@override String get final_balance => 'Son bakiye';
	@override String get balance_by_account => 'Hesaplara göre bakiye';
	@override String get balance_by_account_subtitle => 'Paramın çoğunu nerede tutuyorum?';
	@override String get balance_by_currency => 'Para birimine göre bakiye';
	@override String get balance_by_currency_subtitle => 'Yabancı para biriminde ne kadar param var?';
	@override String get balance_evolution => 'Bakiye trendi';
	@override String get balance_evolution_subtitle => 'Eskisinden daha çok param var mı?';
	@override String get compared_to_previous_period => 'Önceki döneme göre';
	@override String get cash_flow => 'Nakit akışı';
	@override String get cash_flow_subtitle => 'Kazandığımdan daha az mı harcıyorum?';
	@override String get by_periods => 'Dönemlere göre';
	@override String get by_categories => 'Kategorilere göre';
	@override String get by_tags => 'Etiketlere göre';
	@override String get distribution => 'Dağıtım';
	@override String get finance_health_resume => 'Özet';
	@override String get finance_health_breakdown => 'Detaylı Analiz';
}

// Path: icon_selector
class _TranslationsIconSelectorTr implements TranslationsIconSelectorEn {
	_TranslationsIconSelectorTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get name => 'İsim:';
	@override String get icon => 'İkon';
	@override String get color => 'Renk';
	@override String get select_icon => 'Bir ikon seçin';
	@override String get select_color => 'Bir renk seçin';
	@override String get custom_color => 'Özel renk';
	@override String get current_color_selection => 'Mevcut seçim';
	@override String get select_account_icon => 'Hesabınızı tanımlayın';
	@override String get select_category_icon => 'Kategorinizi tanımlayın';
	@override late final _TranslationsIconSelectorScopesTr scopes = _TranslationsIconSelectorScopesTr._(_root);
}

// Path: transaction
class _TranslationsTransactionTr implements TranslationsTransactionEn {
	_TranslationsTransactionTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'İşlem',
		other: 'İşlemler',
	);
	@override String get create => 'Yeni işlem';
	@override String get new_income => 'Yeni gelir';
	@override String get new_expense => 'Yeni gider';
	@override String get new_success => 'İşlem başarıyla oluşturuldu';
	@override String get edit => 'İşlemi düzenle';
	@override String get edit_success => 'İşlem başarıyla düzenlendi';
	@override String get edit_multiple => 'İşlemleri düzenle';
	@override String edit_multiple_success({required Object x}) => '${x} işlem başarıyla düzenlendi';
	@override String get duplicate => 'İşlemi kopyala';
	@override String get duplicate_short => 'Kopyala';
	@override String get duplicate_warning_message => 'Aynısı olan bir işlem bu tarih ile oluşturulacaktır, devam etmek istiyor musunuz?';
	@override String get duplicate_success => 'İşlem başarıyla kopyalandı';
	@override String get delete => 'İşlemi sil';
	@override String get delete_warning_message => 'Bu eylem geri alınamaz. Hesaplarınızın mevcut bakiyesi ve tüm istatistikleriniz yeniden hesaplanacaktır';
	@override String get delete_success => 'İşlem başarıyla silindi';
	@override String get delete_multiple => 'İşlemleri sil';
	@override String delete_multiple_warning_message({required Object x}) => 'Bu eylem geri alınamaz ve ${x} işlem silinecektir. Hesaplarınızın mevcut bakiyesi ve tüm istatistikleriniz yeniden hesaplanacaktır';
	@override String delete_multiple_success({required Object x}) => '${x} işlem başarıyla silindi';
	@override String get details => 'Hareket detayları';
	@override late final _TranslationsTransactionNextPaymentsTr next_payments = _TranslationsTransactionNextPaymentsTr._(_root);
	@override late final _TranslationsTransactionListTr list = _TranslationsTransactionListTr._(_root);
	@override late final _TranslationsTransactionFiltersTr filters = _TranslationsTransactionFiltersTr._(_root);
	@override late final _TranslationsTransactionFormTr form = _TranslationsTransactionFormTr._(_root);
	@override late final _TranslationsTransactionReversedTr reversed = _TranslationsTransactionReversedTr._(_root);
	@override late final _TranslationsTransactionStatusTr status = _TranslationsTransactionStatusTr._(_root);
	@override late final _TranslationsTransactionTypesTr types = _TranslationsTransactionTypesTr._(_root);
}

// Path: transfer
class _TranslationsTransferTr implements TranslationsTransferEn {
	_TranslationsTransferTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Transfer';
	@override String get transfers => 'Transferler';
	@override String transfer_to({required Object account}) => '${account} hesabına transfer';
	@override String get create => 'Yeni Transfer';
	@override String get need_two_accounts_warning_header => 'Ups!';
	@override String get need_two_accounts_warning_message => 'Bu eylemi gerçekleştirmek için en az iki hesaba ihtiyaç vardır. Bu hesabın mevcut bakiyesini ayarlamanız veya düzenlemeniz gerekiyorsa, düzenle düğmesine tıklayın';
	@override late final _TranslationsTransferFormTr form = _TranslationsTransferFormTr._(_root);
}

// Path: recurrent_transactions
class _TranslationsRecurrentTransactionsTr implements TranslationsRecurrentTransactionsEn {
	_TranslationsRecurrentTransactionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tekrarlayan işlemler';
	@override String get title_short => 'Tekr. işl.';
	@override String get empty => 'Görünüşe göre tekrarlayan herhangi bir işleminiz yok. Aylık, yıllık veya haftalık tekrarlayan bir işlem oluşturun, burada görünecektir';
	@override String get total_expense_title => 'Dönem başına toplam gider';
	@override String get total_expense_descr => '* Her tekrarın başlangıç ​​ve bitiş tarihi dikkate alınmadan';
	@override late final _TranslationsRecurrentTransactionsDetailsTr details = _TranslationsRecurrentTransactionsDetailsTr._(_root);
	@override late final _TranslationsRecurrentTransactionsStatusTr status = _TranslationsRecurrentTransactionsStatusTr._(_root);
}

// Path: account
class _TranslationsAccountTr implements TranslationsAccountEn {
	_TranslationsAccountTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get details => 'Hesap detayları';
	@override String get date => 'Açılış tarihi';
	@override String get close_date => 'Kapanış tarihi';
	@override String get reopen => 'Hesabı yeniden aç';
	@override String get reopen_short => 'Yeniden aç';
	@override String get reopen_descr => 'Bu hesabı yeniden açmak istediğinizden emin misiniz?';
	@override String get balance => 'Hesap bakiyesi';
	@override String get n_transactions => 'İşlem sayısı';
	@override String get add_money => 'Para ekle';
	@override String get withdraw_money => 'Para çek';
	@override String get no_accounts => 'Burada görüntülenecek işlem bulunamadı. Alttaki \'+\' düğmesine tıklayarak bir işlem ekleyin';
	@override late final _TranslationsAccountTypesTr types = _TranslationsAccountTypesTr._(_root);
	@override late final _TranslationsAccountFormTr form = _TranslationsAccountFormTr._(_root);
	@override late final _TranslationsAccountDeleteTr delete = _TranslationsAccountDeleteTr._(_root);
	@override late final _TranslationsAccountCloseTr close = _TranslationsAccountCloseTr._(_root);
	@override late final _TranslationsAccountSelectTr select = _TranslationsAccountSelectTr._(_root);
}

// Path: currencies
class _TranslationsCurrenciesTr implements TranslationsCurrenciesEn {
	_TranslationsCurrenciesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get currency_converter => 'Para birimi dönüştürücü';
	@override String get currency => 'Para birimi';
	@override String get currency_settings => 'Para birimi ayarları';
	@override String get currency_manager => 'Para birimi yöneticisi';
	@override String get currency_manager_descr => 'Para biriminizi ve diğerleriyle döviz kurlarını yapılandırın';
	@override String get preferred_currency => 'Tercih edilen/temel para birimi';
	@override String get tap_to_change_preferred_currency => 'Değiştirmek için dokunun';
	@override String get change_preferred_currency_title => 'Tercih edilen para birimini değiştir';
	@override String get change_preferred_currency_msg => 'Tüm istatistikler ve bütçeler bundan sonra bu para biriminde görüntülenecektir. Hesaplar ve işlemler sahip oldukları para birimini koruyacaktır. Bu eylemi gerçekleştirirseniz, kaydedilen tüm döviz kurları silinecektir. Devam etmek istiyor musunuz?';
	@override late final _TranslationsCurrenciesExchangeRateFormTr exchange_rate_form = _TranslationsCurrenciesExchangeRateFormTr._(_root);
	@override late final _TranslationsCurrenciesTypesTr types = _TranslationsCurrenciesTypesTr._(_root);
	@override late final _TranslationsCurrenciesCurrencyFormTr currency_form = _TranslationsCurrenciesCurrencyFormTr._(_root);
	@override String get delete_all_success => 'Döviz kurları başarıyla silindi';
	@override String get historical => 'Geçmiş oranlar';
	@override String get historical_empty => 'Bu para birimi için geçmiş döviz kuru bulunamadı';
	@override String get exchange_rate => 'Döviz kuru';
	@override String get exchange_rates => 'Döviz kurları';
	@override String get min_exchange_rate => 'Asgari döviz kuru';
	@override String get max_exchange_rate => 'Maksimum döviz kuru';
	@override String get empty => 'Buraya döviz kurları ekleyin, böylece temel para biriminizden farklı para birimlerinde hesaplarınız varsa grafiklerimiz daha doğru olur';
	@override String get select_a_currency => 'Bir para birimi seçin';
	@override String get search => 'Adına veya para birimi koduna göre arayın';
}

// Path: tags
class _TranslationsTagsTr implements TranslationsTagsEn {
	_TranslationsTagsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Etiket',
		other: 'Etiketler',
	);
	@override late final _TranslationsTagsFormTr form = _TranslationsTagsFormTr._(_root);
	@override late final _TranslationsTagsSelectTr select = _TranslationsTagsSelectTr._(_root);
	@override String get empty_list => 'Henüz etiket oluşturmadınız. Etiketler ve kategoriler, hareketlerinizi kategorize etmek için harika bir yoldur';
	@override String get without_tags => 'Etiketsiz';
	@override String get add => 'Etiket ekle';
	@override String get create => 'Etiket oluştur';
	@override String get create_success => 'Etiket başarıyla oluşturuldu';
	@override String get already_exists => 'Bu etiket adı zaten var. Düzenlemek isteyebilirsiniz';
	@override String get edit => 'Etiketi düzenle';
	@override String get edit_success => 'Etiket başarıyla düzenlendi';
	@override String get delete_success => 'Kategori başarıyla silindi';
	@override String get delete_warning_header => 'Etiket silinsin mi?';
	@override String get delete_warning_message => 'Bu eylem bu etikete sahip işlemleri silmez.';
}

// Path: categories
class _TranslationsCategoriesTr implements TranslationsCategoriesEn {
	_TranslationsCategoriesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get unknown => 'Bilinmeyen kategori';
	@override String get create => 'Kategori oluştur';
	@override String get create_success => 'Kategori başarıyla oluşturuldu';
	@override String get new_category => 'Yeni kategori';
	@override String get already_exists => 'Bu kategorinin adı zaten var. Belki düzenlemek istersiniz';
	@override String get edit => 'Kategoriyi düzenle';
	@override String get edit_success => 'Kategori başarıyla düzenlendi';
	@override String get name => 'Kategori adı';
	@override String get type => 'Kategori türü';
	@override String get both_types => 'Her iki tür';
	@override String get subcategories => 'Alt kategoriler';
	@override String get subcategories_add => 'Alt kategori ekle';
	@override String get make_parent => 'Kategoriye yap';
	@override String get make_child => 'Alt kategori yap';
	@override String make_child_warning1({required Object destiny}) => 'Bu kategori ve alt kategorileri <b>${destiny}</b>\'nin alt kategorileri olacaktır.';
	@override String make_child_warning2({required Object x, required Object destiny}) => 'İşlemleri <b>(${x})</b>, <b>${destiny}</b> kategorisi içinde oluşturulan yeni alt kategorilere taşınacaktır.';
	@override String get make_child_success => 'Alt kategoriler başarıyla oluşturuldu';
	@override String get merge => 'Başka bir kategoriyle birleştir';
	@override String merge_warning1({required Object from, required Object x, required Object destiny}) => '<b>${from}</b> kategorisiyle ilişkili tüm işlemler (${x}), <b>${destiny}</b> kategorisine taşınacaktır.';
	@override String merge_warning2({required Object from}) => '<b>${from}</b> kategorisi geri dönüşü olmayacak şekilde silinecektir.';
	@override String get merge_success => 'Kategori başarıyla birleştirildi';
	@override String get delete_success => 'Kategori başarıyla silindi';
	@override String get delete_warning_header => 'Kategori silinsin mi?';
	@override String delete_warning_message({required Object x}) => 'Bu eylem, bu kategoriyle ilgili tüm işlemleri <b>(${x})</b> geri dönüşü olmayacak şekilde silecektir.';
	@override late final _TranslationsCategoriesSelectTr select = _TranslationsCategoriesSelectTr._(_root);
}

// Path: budgets
class _TranslationsBudgetsTr implements TranslationsBudgetsEn {
	_TranslationsBudgetsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bütçeler';
	@override String get status => 'Bütçe durumu';
	@override String get repeated => 'Tekrarlayan';
	@override String get one_time => 'Tek seferlik';
	@override String get actives => 'Aktifler';
	@override String get from_budgeted => 'kalan ';
	@override String get days_left => 'gün kaldı';
	@override String get days_to_start => 'başlangıca kalan gün';
	@override String get since_expiration => 'son kullanma tarihinden itibaren';
	@override String get no_budgets => 'Bu bölümde görüntülenecek bütçe yok gibi görünüyor. Aşağıdaki düğmeyi tıklayarak bir bütçe oluşturmaya başlayın';
	@override String get delete => 'Bütçeyi sil';
	@override String get delete_warning => 'Bu eylem geri alınamaz. Bu bütçeye atıfta bulunan kategoriler ve işlemler silinmez';
	@override late final _TranslationsBudgetsFormTr form = _TranslationsBudgetsFormTr._(_root);
	@override late final _TranslationsBudgetsDetailsTr details = _TranslationsBudgetsDetailsTr._(_root);
	@override late final _TranslationsBudgetsTargetTimelineStatusesTr target_timeline_statuses = _TranslationsBudgetsTargetTimelineStatusesTr._(_root);
	@override late final _TranslationsBudgetsProgressTr progress = _TranslationsBudgetsProgressTr._(_root);
}

// Path: goals
class _TranslationsGoalsTr implements TranslationsGoalsEn {
	_TranslationsGoalsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hedefler';
	@override String get status => 'Hedef durumu';
	@override late final _TranslationsGoalsTypeTr type = _TranslationsGoalsTypeTr._(_root);
	@override String get empty_title => 'Hedef bulunamadı';
	@override String get empty_description => 'Tasarruflarınızı takip etmek için yeni bir hedef oluşturun!';
	@override String get delete => 'Hedefi sil';
	@override String get delete_warning => 'Bu işlem geri alınamaz. Bu hedefi referans alan kategoriler ve işlemler silinmeyecektir';
	@override late final _TranslationsGoalsFormTr form = _TranslationsGoalsFormTr._(_root);
	@override late final _TranslationsGoalsDetailsTr details = _TranslationsGoalsDetailsTr._(_root);
	@override late final _TranslationsGoalsTargetTimelineStatusesTr target_timeline_statuses = _TranslationsGoalsTargetTimelineStatusesTr._(_root);
	@override late final _TranslationsGoalsProgressTr progress = _TranslationsGoalsProgressTr._(_root);
}

// Path: target_timeline_statuses
class _TranslationsTargetTimelineStatusesTr implements TranslationsTargetTimelineStatusesEn {
	_TranslationsTargetTimelineStatusesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktif';
	@override String get past => 'Tamamlandı';
	@override String get future => 'Gelecek';
}

// Path: backup
class _TranslationsBackupTr implements TranslationsBackupEn {
	_TranslationsBackupTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get no_file_selected => 'Hiçbir dosya seçilmedi';
	@override String get no_directory_selected => 'Hiçbir dizin seçilmedi';
	@override late final _TranslationsBackupExportTr export = _TranslationsBackupExportTr._(_root);
	@override late final _TranslationsBackupImportTr import = _TranslationsBackupImportTr._(_root);
	@override late final _TranslationsBackupAboutTr about = _TranslationsBackupAboutTr._(_root);
}

// Path: settings
class _TranslationsSettingsTr implements TranslationsSettingsEn {
	_TranslationsSettingsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Ayarlar ve Özelleştirme';
	@override String get title_short => 'Ayarlar';
	@override String get description => 'Tema, Dil, Veriler ve daha fazlası';
	@override String get edit_profile => 'Profili düzenle';
	@override late final _TranslationsSettingsGeneralTr general = _TranslationsSettingsGeneralTr._(_root);
	@override late final _TranslationsSettingsSecurityTr security = _TranslationsSettingsSecurityTr._(_root);
	@override late final _TranslationsSettingsTransactionsTr transactions = _TranslationsSettingsTransactionsTr._(_root);
	@override late final _TranslationsSettingsAppearanceTr appearance = _TranslationsSettingsAppearanceTr._(_root);
}

// Path: more
class _TranslationsMoreTr implements TranslationsMoreEn {
	_TranslationsMoreTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Daha Fazla';
	@override String get title_long => 'Daha fazla eylem';
	@override late final _TranslationsMoreDataTr data = _TranslationsMoreDataTr._(_root);
	@override late final _TranslationsMoreAboutUsTr about_us = _TranslationsMoreAboutUsTr._(_root);
	@override late final _TranslationsMoreHelpUsTr help_us = _TranslationsMoreHelpUsTr._(_root);
}

// Path: general.leave_without_saving
class _TranslationsGeneralLeaveWithoutSavingTr implements TranslationsGeneralLeaveWithoutSavingEn {
	_TranslationsGeneralLeaveWithoutSavingTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kaydetmeden ayrılmak mı istiyorsunuz?';
	@override String get message => 'Kaydedilmemiş değişiklikleriniz var, bunları kaydetmeden ayrılmak istediğinizden emin misiniz?';
}

// Path: general.clipboard
class _TranslationsGeneralClipboardTr implements TranslationsGeneralClipboardEn {
	_TranslationsGeneralClipboardTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String success({required Object x}) => '${x} panoya kopyalandı';
	@override String get error => 'Kopyalama hatası';
}

// Path: general.time
class _TranslationsGeneralTimeTr implements TranslationsGeneralTimeEn {
	_TranslationsGeneralTimeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get start_date => 'Başlangıç tarihi';
	@override String get end_date => 'Bitiş tarihi';
	@override String get from_date => 'Başlangıç tarihi';
	@override String get until_date => 'Bitiş tarihi';
	@override String get date => 'Tarih';
	@override String get datetime => 'Tarih ve saat';
	@override String get time => 'Saat';
	@override String get each => 'Her';
	@override String get after => 'Sonra';
	@override late final _TranslationsGeneralTimeRangesTr ranges = _TranslationsGeneralTimeRangesTr._(_root);
	@override late final _TranslationsGeneralTimePeriodicityTr periodicity = _TranslationsGeneralTimePeriodicityTr._(_root);
	@override late final _TranslationsGeneralTimeCurrentTr current = _TranslationsGeneralTimeCurrentTr._(_root);
	@override late final _TranslationsGeneralTimeAllTr all = _TranslationsGeneralTimeAllTr._(_root);
}

// Path: general.transaction_order
class _TranslationsGeneralTransactionOrderTr implements TranslationsGeneralTransactionOrderEn {
	_TranslationsGeneralTransactionOrderTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'İşlemleri sırala';
	@override String get category => 'Kategoriye göre';
	@override String get quantity => 'Miktara göre';
	@override String get date => 'Tarihe göre';
}

// Path: general.validations
class _TranslationsGeneralValidationsTr implements TranslationsGeneralValidationsEn {
	_TranslationsGeneralValidationsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get form_error => 'Devam etmek için belirtilen alanları düzeltin';
	@override String get required => 'Gerekli alan';
	@override String get positive => 'Pozitif olmalı';
	@override String min_number({required Object x}) => '${x} değerinden büyük olmalı';
	@override String max_number({required Object x}) => '${x} değerinden küçük olmalı';
}

// Path: financial_health.review
class _TranslationsFinancialHealthReviewTr implements TranslationsFinancialHealthReviewEn {
	_TranslationsFinancialHealthReviewTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String very_good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Çok iyi!';
			case GenderContext.female:
				return 'Çok iyi!';
		}
	}
	@override String good({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'İyi';
			case GenderContext.female:
				return 'İyi';
		}
	}
	@override String normal({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Ortalama';
			case GenderContext.female:
				return 'Ortalama';
		}
	}
	@override String bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Fena';
			case GenderContext.female:
				return 'Fena';
		}
	}
	@override String very_bad({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Çok Kötü';
			case GenderContext.female:
				return 'Çok Kötü';
		}
	}
	@override String insufficient_data({required GenderContext context}) {
		switch (context) {
			case GenderContext.male:
				return 'Yetersiz veri';
			case GenderContext.female:
				return 'Yetersiz veri';
		}
	}
	@override late final _TranslationsFinancialHealthReviewDescrTr descr = _TranslationsFinancialHealthReviewDescrTr._(_root);
}

// Path: financial_health.months_without_income
class _TranslationsFinancialHealthMonthsWithoutIncomeTr implements TranslationsFinancialHealthMonthsWithoutIncomeEn {
	_TranslationsFinancialHealthMonthsWithoutIncomeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hayatta kalma oranı';
	@override String get subtitle => 'Bakiyeniz göz önüne alındığında, gelirsiz kalabileceğiniz süre';
	@override String get text_zero => 'Bu gider oranında gelirsiz bir ay bile dayanamazsınız!';
	@override String get text_one => 'Bu gider oranında yaklaşık bir ay gelirsiz yaşayabilirsiniz!';
	@override String text_other({required Object n}) => 'Bu harcama oranında yaklaşık <b>${n} ay</b> gelir olmadan yaşayabilirsiniz.';
	@override String get text_infinite => 'Bu harcama oranında yaklaşık <b>tüm hayatınız boyunca</b> gelir olmadan yaşayabilirsiniz.';
	@override String get suggestion => 'Bu oranın her zaman en az 5 ayın üzerinde tutulması gerektiğini unutmayın. Yeterli birikiminiz olmadığını görürseniz, gereksiz harcamaları azaltın.';
	@override String get insufficient_data => 'Gelirsiz kaç ay hayatta kalabileceğinizi hesaplamak için yeterli giderimiz yok gibi görünüyor. Birkaç işlem girin ve finansal sağlığınızı kontrol etmek için buraya geri gelin';
}

// Path: financial_health.savings_percentage
class _TranslationsFinancialHealthSavingsPercentageTr implements TranslationsFinancialHealthSavingsPercentageEn {
	_TranslationsFinancialHealthSavingsPercentageTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tasarruf yüzdesi';
	@override String get subtitle => 'Gelirinizin ne kadarı bu dönemde harcanmıyor';
	@override late final _TranslationsFinancialHealthSavingsPercentageTextTr text = _TranslationsFinancialHealthSavingsPercentageTextTr._(_root);
	@override String get suggestion => 'Kazandığınızın en az %15-20\'sini biriktirmenin tavsiye edildiğini unutmayın.';
}

// Path: icon_selector.scopes
class _TranslationsIconSelectorScopesTr implements TranslationsIconSelectorScopesEn {
	_TranslationsIconSelectorScopesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get transport => 'Ulaşım';
	@override String get money => 'Para';
	@override String get food => 'Gıda';
	@override String get medical => 'Sağlık';
	@override String get entertainment => 'Eğlence';
	@override String get technology => 'Teknoloji';
	@override String get other => 'Diğerleri';
	@override String get logos_financial_institutions => 'Finans kuruluşları';
}

// Path: transaction.next_payments
class _TranslationsTransactionNextPaymentsTr implements TranslationsTransactionNextPaymentsEn {
	_TranslationsTransactionNextPaymentsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get accept => 'Kabul et';
	@override String get skip => 'Atla';
	@override String get skip_success => 'İşlem başarıyla atlandı';
	@override String get skip_dialog_title => 'İşlemi atla';
	@override String skip_dialog_msg({required Object date}) => 'Bu eylem geri alınamaz. Bir sonraki hareketin tarihini ${date} olarak değiştireceğiz';
	@override String get accept_today => 'Bugün kabul et';
	@override String accept_in_required_date({required Object date}) => 'Gerekli tarihte kabul et (${date})';
	@override String get accept_dialog_title => 'İşlemi kabul et';
	@override String get accept_dialog_msg_single => 'İşlemin yeni durumu boş olacaktır. İstediğiniz zaman bu işlemin durumunu yeniden düzenleyebilirsiniz';
	@override String accept_dialog_msg({required Object date}) => 'Bu eylem ${date} tarihli yeni bir işlem oluşturacaktır. İşlem sayfasında bu işlemin detaylarını kontrol edebileceksiniz';
	@override String get recurrent_rule_finished => 'Tekrarlama kuralı tamamlandı, yapılacak başka ödeme yok!';
}

// Path: transaction.list
class _TranslationsTransactionListTr implements TranslationsTransactionListEn {
	_TranslationsTransactionListTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get all => 'Tüm İşlemler';
	@override String get empty => 'Burada görüntülenecek işlem bulunamadı. Uygulamaya birkaç işlem ekleyin, belki bir dahaki sefere daha şanslı olursunuz.';
	@override String get searcher_placeholder => 'Kategoriye, açıklamaya göre ara...';
	@override String get searcher_no_results => 'Arama kriterlerine uyan işlem bulunamadı';
	@override String get loading => 'Daha fazla işlem yükleniyor...';
	@override String selected_short({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: '${n} seçildi',
		other: '${n} seçildi',
	);
	@override String selected_long({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: '${n} işlem seçildi',
		other: '${n} işlem seçildi',
	);
	@override late final _TranslationsTransactionListBulkEditTr bulk_edit = _TranslationsTransactionListBulkEditTr._(_root);
}

// Path: transaction.filters
class _TranslationsTransactionFiltersTr implements TranslationsTransactionFiltersEn {
	_TranslationsTransactionFiltersTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'İşlem filtreleri';
	@override String get from_value => 'Miktardan';
	@override String get to_value => 'Miktara kadar';
	@override String from_value_def({required Object x}) => '${x} dan';
	@override String to_value_def({required Object x}) => '${x} a kadar';
	@override String from_date_def({required Object date}) => '${date} tarihinden';
	@override String to_date_def({required Object date}) => '${date} tarihine kadar';
	@override String get reset => 'Filtreleri sıfırla';
	@override late final _TranslationsTransactionFiltersSavedTr saved = _TranslationsTransactionFiltersSavedTr._(_root);
}

// Path: transaction.form
class _TranslationsTransactionFormTr implements TranslationsTransactionFormEn {
	_TranslationsTransactionFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTransactionFormValidatorsTr validators = _TranslationsTransactionFormValidatorsTr._(_root);
	@override String get title => 'İşlem başlığı';
	@override String get title_short => 'Başlık';
	@override String get value => 'İşlem değeri';
	@override String get tap_to_see_more => 'Daha fazla detay görmek için dokunun';
	@override String get no_tags => '-- Etiket yok --';
	@override String get description => 'Açıklama';
	@override String get description_info => 'Bu işlem hakkında daha detaylı bir açıklama girmek için buraya dokunun';
	@override String exchange_to_preferred_title({required Object currency}) => '${currency} için kur';
	@override String get exchange_to_preferred_in_date => 'İşlem tarihinde';
}

// Path: transaction.reversed
class _TranslationsTransactionReversedTr implements TranslationsTransactionReversedEn {
	_TranslationsTransactionReversedTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ters işlem';
	@override String get title_short => 'Ters. iş.';
	@override String get description_for_expenses => 'Bir gider işlemi olmasına rağmen, pozitif bir tutara sahiptir. Bu tür işlemler, bir geri ödeme veya bir borcun ödenmesi gibi daha önce kaydedilmiş bir giderin iadesini temsil etmek için kullanılabilir.';
	@override String get description_for_incomes => 'Bir gelir işlemi olmasına rağmen, negatif bir tutara sahiptir. Bu tür işlemler, hatalı kaydedilmiş bir geliri geçersiz kılmak veya düzeltmek, para iadesini veya geri ödemesini yansıtmak veya borç ödemesini kaydetmek için kullanılabilir.';
}

// Path: transaction.status
class _TranslationsTransactionStatusTr implements TranslationsTransactionStatusEn {
	_TranslationsTransactionStatusTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Durum',
		other: 'Durumlar',
	);
	@override String get display_long => 'İşlem durumu';
	@override String tr_status({required Object status}) => '${status} işlemi';
	@override String get none => 'Durumsuz';
	@override String get none_descr => 'Belirli bir durumu olmayan işlem';
	@override String get reconciled => 'Mutabık';
	@override String get reconciled_descr => 'Bu işlem zaten onaylandı ve bankanızdaki gerçek bir işleme karşılık geliyor';
	@override String get unreconciled => 'Mutabık değil';
	@override String get unreconciled_descr => 'Bu işlem henüz doğrulanmadı ve bu nedenle henüz gerçek banka hesaplarınızda görünmüyor. Ancak, Monekin\'deki bakiyelerin ve istatistiklerin hesaplanması için sayılır';
	@override String get pending => 'Beklemede';
	@override String get pending_descr => 'Bu işlem bekliyor ve bu nedenle bakiyeler ve istatistikler hesaplanırken dikkate alınmayacaktır';
	@override String get voided => 'İptal Edildi';
	@override String get voided_descr => 'Ödeme hatası veya başka herhangi bir nedenden dolayı geçersiz kılınan/iptal edilen işlem. Bakiyeler ve istatistikler hesaplanırken dikkate alınmayacaktır';
}

// Path: transaction.types
class _TranslationsTransactionTypesTr implements TranslationsTransactionTypesEn {
	_TranslationsTransactionTypesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String display({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'İşlem türü',
		other: 'İşlem türleri',
	);
	@override String income({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Gelir',
		other: 'Gelirler',
	);
	@override String expense({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Gider',
		other: 'Giderler',
	);
	@override String transfer({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Transfer',
		other: 'Transferler',
	);
}

// Path: transfer.form
class _TranslationsTransferFormTr implements TranslationsTransferFormEn {
	_TranslationsTransferFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get from => 'Kaynak hesap';
	@override String get to => 'Hedef hesap';
	@override late final _TranslationsTransferFormValueInDestinyTr value_in_destiny = _TranslationsTransferFormValueInDestinyTr._(_root);
}

// Path: recurrent_transactions.details
class _TranslationsRecurrentTransactionsDetailsTr implements TranslationsRecurrentTransactionsDetailsEn {
	_TranslationsRecurrentTransactionsDetailsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tekrarlayan işlem';
	@override String get descr => 'Bu işlem için sonraki hareketler aşağıda gösterilmektedir. İlk hareketi kabul edebilir veya bu hareketi atlayabilirsiniz';
	@override String get last_payment_info => 'Bu hareket, tekrar kuralının sonuncusudur, bu nedenle bu eylemi onaylarken bu kural otomatik olarak silinecektir';
	@override String get delete_header => 'Tekrarlayan işlemi sil';
	@override String get delete_message => 'Bu eylem geri alınamaz ve zaten onayladığınız/ödediğiniz işlemleri etkilemez';
}

// Path: recurrent_transactions.status
class _TranslationsRecurrentTransactionsStatusTr implements TranslationsRecurrentTransactionsStatusEn {
	_TranslationsRecurrentTransactionsStatusTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String delayed_by({required Object x}) => '${x}g gecikti';
	@override String coming_in({required Object x}) => '${x} gün içinde';
}

// Path: account.types
class _TranslationsAccountTypesTr implements TranslationsAccountTypesEn {
	_TranslationsAccountTypesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hesap türü';
	@override String get warning => 'Hesap türü seçildikten sonra gelecekte değiştirilemez';
	@override String get normal => 'Normal hesap';
	@override String get normal_descr => 'Günlük mali durumunuzu kaydetmek için kullanışlıdır. En yaygın hesaptır, giderler, gelirler eklemenize olanak tanır...';
	@override String get saving => 'Tasarruf hesabı';
	@override String get saving_descr => 'Yalnızca diğer hesaplardan para ekleyebilecek ve çekebileceksiniz. Para biriktirmeye başlamak için mükemmel';
}

// Path: account.form
class _TranslationsAccountFormTr implements TranslationsAccountFormEn {
	_TranslationsAccountFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hesap adı';
	@override String get name_placeholder => 'Örn: Tasarruf hesabı';
	@override String get notes => 'Notlar';
	@override String get notes_placeholder => 'Bu hesap hakkında bazı notlar/açıklama yazın';
	@override String get initial_balance => 'Başlangıç ​​bakiyesi';
	@override String get current_balance => 'Mevcut bakiye';
	@override String get create => 'Hesap oluştur';
	@override String get edit => 'Hesabı düzenle';
	@override String get currency_not_found_warn => 'Bu para birimi için döviz kurları hakkında bilginiz yok. Varsayılan döviz kuru olarak 1.0 kullanılacaktır. Bunu ayarlardan değiştirebilirsiniz';
	@override String get already_exists => 'Aynı ada sahip başka bir hesap zaten var, lütfen başka bir tane yazın';
	@override String get tr_before_opening_date => 'Bu hesapta açılış tarihinden önce bir tarihe sahip işlemler var';
	@override String get iban => 'IBAN';
	@override String get swift => 'SWIFT';
}

// Path: account.delete
class _TranslationsAccountDeleteTr implements TranslationsAccountDeleteEn {
	_TranslationsAccountDeleteTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get warning_header => 'Hesap silinsin mi?';
	@override String get warning_text => 'Bu eylem bu hesabı ve tüm işlemlerini silecektir';
	@override String get success => 'Hesap başarıyla silindi';
}

// Path: account.close
class _TranslationsAccountCloseTr implements TranslationsAccountCloseEn {
	_TranslationsAccountCloseTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hesabı kapat';
	@override String get title_short => 'Kapat';
	@override String get warn => 'Bu hesap artık belirli listelerde görünmeyecek ve aşağıda belirtilen tarihten sonra bu hesapta işlem oluşturamayacaksınız. Bu eylem herhangi bir işlemi veya bakiyeyi etkilemez ve ayrıca bu hesabı istediğiniz zaman yeniden açabilirsiniz.';
	@override String get should_have_zero_balance => 'Kapatmak için bu hesabın mevcut bakiyesi 0 olmalıdır. Lütfen devam etmeden önce hesabı düzenleyin';
	@override String get should_have_no_transactions => 'Bu hesap, belirtilen kapanış tarihinden sonra işlemlere sahip. Devam etmeden önce bunları silin veya hesabın kapanış tarihini düzenleyin';
	@override String get success => 'Hesap başarıyla kapatıldı';
	@override String get unarchive_succes => 'Hesap başarıyla yeniden açıldı';
}

// Path: account.select
class _TranslationsAccountSelectTr implements TranslationsAccountSelectEn {
	_TranslationsAccountSelectTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get one => 'Bir hesap seçin';
	@override String get all => 'Tüm hesaplar';
	@override String get multiple => 'Hesapları seçin';
}

// Path: currencies.exchange_rate_form
class _TranslationsCurrenciesExchangeRateFormTr implements TranslationsCurrenciesExchangeRateFormEn {
	_TranslationsCurrenciesExchangeRateFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'Para birimi, kullanıcı para birimine eşit olamaz';
	@override String get override_existing_warn => 'Bu tarihte bu para birimi için bir döviz kuru zaten mevcut. Devam ederseniz öncekinin üzerine yazılacak';
	@override String get specify_a_currency => 'Lütfen bir para birimi belirtin';
	@override String get add => 'Döviz kuru ekle';
	@override String get add_success => 'Döviz kuru başarıyla eklendi';
	@override String get edit => 'Döviz kurunu düzenle';
	@override String get edit_success => 'Döviz kuru başarıyla düzenlendi';
	@override String get remove_all => 'Tüm döviz kurlarını sil';
	@override String get remove_all_warning => 'Bu işlem geri alınamaz ve bu para biriminin tüm döviz kurlarını silecektir';
}

// Path: currencies.types
class _TranslationsCurrenciesTypesTr implements TranslationsCurrenciesTypesEn {
	_TranslationsCurrenciesTypesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Para birimi türü';
	@override String get fiat => 'FIAT';
	@override String get crypto => 'Kripto para birimi';
	@override String get other => 'Diğer';
}

// Path: currencies.currency_form
class _TranslationsCurrenciesCurrencyFormTr implements TranslationsCurrenciesCurrencyFormEn {
	_TranslationsCurrenciesCurrencyFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Ekran adı';
	@override String get code => 'Para Birimi Kodu';
	@override String get symbol => 'Sembol';
	@override String get decimal_digits => 'Ondalık Basamaklar';
	@override String get create => 'Para birimi oluştur';
	@override String get create_success => 'Para birimi başarıyla oluşturuldu';
	@override String get edit => 'Para birimini düzenle';
	@override String get edit_success => 'Para birimi başarıyla düzenlendi';
	@override String get delete => 'Para birimini sil';
	@override String get delete_success => 'Para birimi başarıyla silindi';
	@override String get already_exists => 'Bu koda sahip bir para birimi zaten mevcut. Düzenlemek isteyebilirsiniz';
}

// Path: tags.form
class _TranslationsTagsFormTr implements TranslationsTagsFormEn {
	_TranslationsTagsFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Etiket adı';
	@override String get name_hint => 'Örn.: Yemek';
	@override String get forbidden_char_error => 'Etiket adı \';\' içeremez';
	@override String get description => 'Açıklama';
}

// Path: tags.select
class _TranslationsTagsSelectTr implements TranslationsTagsSelectEn {
	_TranslationsTagsSelectTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Etiketleri seçin';
	@override String get all => 'Tüm etiketler';
}

// Path: categories.select
class _TranslationsCategoriesSelectTr implements TranslationsCategoriesSelectEn {
	_TranslationsCategoriesSelectTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kategori seçin';
	@override String get select_one => 'Bir kategori seçin';
	@override String get select_subcategory => 'Bir alt kategori seçin';
	@override String get without_subcategory => 'Alt kategori olmadan';
	@override String get all => 'Tüm kategoriler';
	@override String get all_short => 'Tümü';
}

// Path: budgets.form
class _TranslationsBudgetsFormTr implements TranslationsBudgetsFormEn {
	_TranslationsBudgetsFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bütçe ekle';
	@override String get name => 'Bütçe adı';
	@override String get value => 'Limit miktarı';
	@override String get create => 'Bütçe ekle';
	@override String get create_success => 'Bütçe başarıyla oluşturuldu';
	@override String get edit => 'Bütçeyi düzenle';
	@override String get edit_success => 'Bütçe başarıyla düzenlendi';
	@override String get negative_warn => 'Bütçeler negatif miktara sahip olamaz';
}

// Path: budgets.details
class _TranslationsBudgetsDetailsTr implements TranslationsBudgetsDetailsEn {
	_TranslationsBudgetsDetailsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bütçe Detayları';
	@override String get statistics => 'İstatistikler';
	@override String get budget_value => 'Bütçelenen';
	@override String get expend_evolution => 'Harcama gelişimi';
	@override String get no_transactions => 'Bu bütçeyle ilgili herhangi bir harcama yapmamışsınız gibi görünüyor';
}

// Path: budgets.target_timeline_statuses
class _TranslationsBudgetsTargetTimelineStatusesTr implements TranslationsBudgetsTargetTimelineStatusesEn {
	_TranslationsBudgetsTargetTimelineStatusesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktif bütçe';
	@override String get past => 'Tamamlanan bütçe';
	@override String get future => 'Gelecek bütçe';
}

// Path: budgets.progress
class _TranslationsBudgetsProgressTr implements TranslationsBudgetsProgressEn {
	_TranslationsBudgetsProgressTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBudgetsProgressLabelsTr labels = _TranslationsBudgetsProgressLabelsTr._(_root);
	@override late final _TranslationsBudgetsProgressDescriptionTr description = _TranslationsBudgetsProgressDescriptionTr._(_root);
}

// Path: goals.type
class _TranslationsGoalsTypeTr implements TranslationsGoalsTypeEn {
	_TranslationsGoalsTypeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Hedef Türü';
	@override late final _TranslationsGoalsTypeIncomeTr income = _TranslationsGoalsTypeIncomeTr._(_root);
	@override late final _TranslationsGoalsTypeExpenseTr expense = _TranslationsGoalsTypeExpenseTr._(_root);
}

// Path: goals.form
class _TranslationsGoalsFormTr implements TranslationsGoalsFormEn {
	_TranslationsGoalsFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get new_title => 'Yeni Hedef';
	@override String get edit_title => 'Hedefi Düzenle';
	@override String get target_amount => 'Hedef Tutar';
	@override String get initial_amount => 'Başlangıç Tutarı';
	@override String get name => 'İsim';
	@override String get name_hint => 'Tasarruf Hedefim';
	@override String get create_success => 'Hedef başarıyla oluşturuldu';
	@override String get edit_success => 'Hedef başarıyla düzenlendi';
	@override String get negative_warn => 'Hedef tutar negatif olamaz';
}

// Path: goals.details
class _TranslationsGoalsDetailsTr implements TranslationsGoalsDetailsEn {
	_TranslationsGoalsDetailsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hedef Detayları';
	@override String get statistics => 'İstatistikler';
	@override String get goal_value => 'Hedef Değeri';
	@override String get evolution => 'Gelişim';
	@override String get no_transactions => 'Bu hedefle ilgili herhangi bir işlem yapmamışsınız gibi görünüyor';
}

// Path: goals.target_timeline_statuses
class _TranslationsGoalsTargetTimelineStatusesTr implements TranslationsGoalsTargetTimelineStatusesEn {
	_TranslationsGoalsTargetTimelineStatusesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get active => 'Aktif hedef';
	@override String get past => 'Tamamlanmış hedef';
	@override String get future => 'Gelecek hedef';
}

// Path: goals.progress
class _TranslationsGoalsProgressTr implements TranslationsGoalsProgressEn {
	_TranslationsGoalsProgressTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsGoalsProgressLabelsTr labels = _TranslationsGoalsProgressLabelsTr._(_root);
	@override late final _TranslationsGoalsProgressDescriptionTr description = _TranslationsGoalsProgressDescriptionTr._(_root);
}

// Path: backup.export
class _TranslationsBackupExportTr implements TranslationsBackupExportEn {
	_TranslationsBackupExportTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verilerinizi dışa aktarın';
	@override String get title_short => 'Dışa Aktar';
	@override String get type_of_export => 'İhracat türü';
	@override String get other_options => 'Seçenekler';
	@override String get all => 'Tam yedekleme';
	@override String get all_descr => 'Tüm verilerinizi (hesaplar, işlemler, bütçeler, ayarlar...) dışa aktarın. Herhangi bir şeyi kaybetmemek için bunları istediğiniz zaman tekrar içe aktarın.';
	@override String get transactions => 'İşlemlerin yedeği';
	@override String get transactions_descr => 'İşlemlerinizi CSV olarak dışa aktarın, böylece diğer programlarda veya uygulamalarda daha kolay analiz edebilirsiniz.';
	@override String transactions_to_export({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Dışa aktarılacak 1 işlem',
		other: 'Dışa aktarılacak ${n} işlem',
	);
	@override String get description => 'Verilerinizi farklı formatlarda indirin';
	@override String get send_file => 'Dosyayı gönder';
	@override String get see_folder => 'Klasöre bakın';
	@override String success({required Object x}) => 'Dosya ${x} olarak başarıyla kaydedildi/indirildi';
	@override String get error => 'Dosya indirilirken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin';
	@override String get dialog_title => 'Dosyayı Kaydet/Gönder';
}

// Path: backup.import
class _TranslationsBackupImportTr implements TranslationsBackupImportEn {
	_TranslationsBackupImportTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verilerinizi içe aktarın';
	@override String get title_short => 'İçe Aktar';
	@override String get restore_backup => 'Yedeklemeyi Geri Yükle';
	@override String get restore_backup_descr => 'Monekin\'den daha önce kaydedilmiş bir veritabanını içe aktarın. Bu eylem, mevcut uygulama verilerinin herhangi birini yeni verilerle değiştirecektir';
	@override String get restore_backup_warn_description => 'Yeni bir veritabanı içe aktarırken, uygulamada şu anda kayıtlı olan tüm verileri kaybedeceksiniz. Devam etmeden önce bir yedekleme yapmanız önerilir. Buraya, kaynağını bilmediğiniz herhangi bir dosyayı yüklemeyin, yalnızca daha önce Monekin\'den indirdiğiniz dosyaları yükleyin';
	@override String get restore_backup_warn_title => 'Tüm verilerin üzerine yaz';
	@override String get select_other_file => 'Başka dosya seç';
	@override String get tap_to_select_file => 'Bir dosya seçmek için dokunun';
	@override late final _TranslationsBackupImportManualImportTr manual_import = _TranslationsBackupImportManualImportTr._(_root);
	@override String get success => 'İçe aktarma başarıyla gerçekleştirildi';
	@override String get error => 'Dosya içe aktarılırken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin';
	@override String get cancelled => 'İçe aktarma kullanıcı tarafından iptal edildi';
}

// Path: backup.about
class _TranslationsBackupAboutTr implements TranslationsBackupAboutEn {
	_TranslationsBackupAboutTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Veritabanınız hakkında bilgiler';
	@override String get create_date => 'Oluşturulma tarihi';
	@override String get modify_date => 'Son değiştirilme';
	@override String get last_backup => 'Son yedekleme';
	@override String get size => 'Boyut';
}

// Path: settings.general
class _TranslationsSettingsGeneralTr implements TranslationsSettingsGeneralEn {
	_TranslationsSettingsGeneralTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Genel Ayarlar';
	@override String get menu_descr => 'Dil, gizlilik ve daha fazlası';
	@override String get show_all_decimals => 'Tüm ondalık basamakları göster';
	@override String get show_all_decimals_descr => 'Sondaki sıfırlar olsa bile tüm ondalık basamakları göster';
	@override late final _TranslationsSettingsGeneralLanguageTr language = _TranslationsSettingsGeneralLanguageTr._(_root);
	@override late final _TranslationsSettingsGeneralLocaleTr locale = _TranslationsSettingsGeneralLocaleTr._(_root);
}

// Path: settings.security
class _TranslationsSettingsSecurityTr implements TranslationsSettingsSecurityEn {
	_TranslationsSettingsSecurityTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Güvenlik';
	@override String get private_mode_at_launch => 'Başlangıçta özel mod';
	@override String get private_mode_at_launch_descr => 'Uygulamayı varsayılan olarak özel modda başlatın';
	@override String get private_mode => 'Özel mod';
	@override String get private_mode_descr => 'Tüm parasal değerleri gizle';
	@override String get private_mode_activated => 'Özel mod etkinleştirildi';
	@override String get private_mode_deactivated => 'Özel mod devre dışı bırakıldı';
}

// Path: settings.transactions
class _TranslationsSettingsTransactionsTr implements TranslationsSettingsTransactionsEn {
	_TranslationsSettingsTransactionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'İşlemler';
	@override String get menu_descr => 'İşlemlerinizin davranışını yapılandırın';
	@override String get title => 'İşlem Ayarları';
	@override late final _TranslationsSettingsTransactionsStyleTr style = _TranslationsSettingsTransactionsStyleTr._(_root);
	@override late final _TranslationsSettingsTransactionsSwipeActionsTr swipe_actions = _TranslationsSettingsTransactionsSwipeActionsTr._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultValuesTr default_values = _TranslationsSettingsTransactionsDefaultValuesTr._(_root);
	@override late final _TranslationsSettingsTransactionsDefaultTypeTr default_type = _TranslationsSettingsTransactionsDefaultTypeTr._(_root);
}

// Path: settings.appearance
class _TranslationsSettingsAppearanceTr implements TranslationsSettingsAppearanceEn {
	_TranslationsSettingsAppearanceTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get menu_title => 'Tema ve Stil';
	@override String get menu_descr => 'Tema seçimi, renkler ve uygulama görünümüyle ilgili diğer şeyler';
	@override String get theme_and_colors => 'Tema ve renkler';
	@override late final _TranslationsSettingsAppearanceThemeTr theme = _TranslationsSettingsAppearanceThemeTr._(_root);
	@override String get amoled_mode => 'AMOLED modu';
	@override String get amoled_mode_descr => 'Mümkün olduğunda saf siyah bir duvar kağıdı kullanın. Bu, AMOLED ekranlara sahip cihazların pili için biraz yardımcı olacaktır';
	@override String get dynamic_colors => 'Dinamik renkler';
	@override String get dynamic_colors_descr => 'Mümkün olduğunda sistem vurgu renginizi kullanın';
	@override String get accent_color => 'Vurgu rengi';
	@override String get accent_color_descr => 'Uygulamanın arayüzün belirli kısımlarını vurgulamak için kullanacağı rengi seçin';
	@override String get text => 'Metin';
	@override String get font => 'Yazı tipi';
	@override String get font_platform => 'platformu';
}

// Path: more.data
class _TranslationsMoreDataTr implements TranslationsMoreDataEn {
	_TranslationsMoreDataTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Veri';
	@override String get display_descr => 'Hiçbir şeyi kaybetmemek için verilerinizi dışa ve içe aktarın';
	@override String get delete_all => 'Verilerimi sil';
	@override String get delete_all_header1 => 'Orada dur padawan ⚠️⚠️';
	@override String get delete_all_message1 => 'Devam etmek istediğinizden emin misiniz? Tüm verileriniz kalıcı olarak silinecek ve kurtarılamayacaktır';
	@override String get delete_all_header2 => 'Son bir adım ⚠️⚠️';
	@override String get delete_all_message2 => 'Bir hesabı sildiğinizde, kayıtlı tüm kişisel verilerinizi silmiş olursunuz. Hesaplarınız, işlemleriniz, bütçeleriniz ve kategorileriniz silinecek ve kurtarılamayacaktır. Kabul ediyor musunuz?';
}

// Path: more.about_us
class _TranslationsMoreAboutUsTr implements TranslationsMoreAboutUsEn {
	_TranslationsMoreAboutUsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Uygulama bilgileri';
	@override String get description => 'Monekin\'in şartlarını, önemli bilgilerini bulun ve hata bildirerek veya fikir paylaşımları ile iletişime geçin';
	@override late final _TranslationsMoreAboutUsLegalTr legal = _TranslationsMoreAboutUsLegalTr._(_root);
	@override late final _TranslationsMoreAboutUsProjectTr project = _TranslationsMoreAboutUsProjectTr._(_root);
}

// Path: more.help_us
class _TranslationsMoreHelpUsTr implements TranslationsMoreHelpUsEn {
	_TranslationsMoreHelpUsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Bize yardım edin';
	@override String get description => 'Monekin\'in nasıl daha iyi olabileceğini öğrenin';
	@override String get rate_us => 'Bize oy verin';
	@override String get rate_us_descr => 'Herhangi bir puan memnuniyetle karşılanır!';
	@override String get share => 'Monekin\'i paylaşın';
	@override String get share_descr => 'Uygulamamızı arkadaşlarınıza ve ailenize paylaşın';
	@override String get share_text => 'Monekin! En iyi kişisel finans uygulaması. Buradan indirin';
	@override String get thanks => 'Teşekkürler!';
	@override String get thanks_long => 'Monekin\'e ve diğer açık kaynaklı projelere yaptığınız katkılar, büyük ve küçük, bunun gibi harika projeleri mümkün kılıyor. Katkıda bulunmak için zaman ayırdığınız için teşekkür ederiz.';
	@override String get donate => 'Bağış yap';
	@override String get donate_descr => 'Bağışınızla uygulamanın iyileştirmeler almaya devam etmesine yardımcı olacaksınız. Yapılan çalışmaya kahve ısmarlayarak teşekkür etmekten daha iyi bir yol mu var?';
	@override String get donate_success => 'Bağış yapıldı. Katkılarınız için çok teşekkür ederim! ❤️';
	@override String get donate_err => 'Ups! Ödemenizi alırken bir hata oluştu gibi görünüyor';
	@override String get report => 'Hataları bildirin, önerilerde bulunun...';
}

// Path: general.time.ranges
class _TranslationsGeneralTimeRangesTr implements TranslationsGeneralTimeRangesEn {
	_TranslationsGeneralTimeRangesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Zaman aralığı';
	@override String get it_repeat => 'Tekrarlar';
	@override String get it_ends => 'Biter';
	@override String get forever => 'Sonsuza kadar';
	@override late final _TranslationsGeneralTimeRangesTypesTr types = _TranslationsGeneralTimeRangesTypesTr._(_root);
	@override String each_range({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Her ${range}',
		other: 'Her ${n} ${range}',
	);
	@override String each_range_until_date({required num n, required Object day, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: '${day} tarihine kadar her ${range}',
		other: '${day} tarihine kadar her ${n} ${range}',
	);
	@override String each_range_until_times({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Her ${range} ${limit} kez',
		other: 'Her ${n} ${range} ${limit} kez',
	);
	@override String each_range_until_once({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Her ${range} bir kez',
		other: 'Her ${n} ${range} bir kez',
	);
	@override String month({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Ay',
		other: 'Aylar',
	);
	@override String year({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Yıl',
		other: 'Yıllar',
	);
	@override String day({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Gün',
		other: 'Günler',
	);
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Hafta',
		other: 'Haftalar',
	);
}

// Path: general.time.periodicity
class _TranslationsGeneralTimePeriodicityTr implements TranslationsGeneralTimePeriodicityEn {
	_TranslationsGeneralTimePeriodicityTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Tekrarlama';
	@override String get no_repeat => 'Tekrarlama yok';
	@override String repeat({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
		one: 'Tekrar',
		other: 'Tekrarlar',
	);
	@override String get diary => 'Günlük';
	@override String get monthly => 'Aylık';
	@override String get annually => 'Yıllık';
	@override String get quaterly => 'Üç Aylık';
	@override String get weekly => 'Haftalık';
	@override String get custom => 'Özel';
	@override String get infinite => 'Her Zaman';
}

// Path: general.time.current
class _TranslationsGeneralTimeCurrentTr implements TranslationsGeneralTimeCurrentEn {
	_TranslationsGeneralTimeCurrentTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get monthly => 'Bu ay';
	@override String get annually => 'Bu yıl';
	@override String get quaterly => 'Bu çeyrek';
	@override String get weekly => 'Bu hafta';
	@override String get infinite => 'Sonsuza dek';
	@override String get custom => 'Özel Aralık';
}

// Path: general.time.all
class _TranslationsGeneralTimeAllTr implements TranslationsGeneralTimeAllEn {
	_TranslationsGeneralTimeAllTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get diary => 'Her gün';
	@override String get monthly => 'Her ay';
	@override String get annually => 'Her yıl';
	@override String get quaterly => 'Her çeyrek';
	@override String get weekly => 'Her hafta';
}

// Path: financial_health.review.descr
class _TranslationsFinancialHealthReviewDescrTr implements TranslationsFinancialHealthReviewDescrEn {
	_TranslationsFinancialHealthReviewDescrTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get insufficient_data => 'Finansal sağlığınızı hesaplamak için yeterli giderimiz yok gibi görünüyor. Size yardımcı olmamıza izin vermek için bu dönemde bazı giderler/gelirler ekleyin!';
	@override String get very_good => 'Tebrikler! Finansal sağlığınız muazzam. İyi gidişatınızı sürdürmenizi ve Monekin ile öğrenmeye devam etmenizi umuyoruz';
	@override String get good => 'Harika! Finansal sağlığınız iyi. Daha da fazla nasıl tasarruf edebileceğinizi görmek için analiz sekmesini ziyaret edin!';
	@override String get normal => 'Finansal sağlığınız bu dönem için nüfusun geri kalanının ortalamasına az çok eşit';
	@override String get bad => 'Görünüşe göre mali durumunuz henüz en iyi seviyede değil. Finanslarınız hakkında daha fazla bilgi edinmek için grafiklerin geri kalanını inceleyin';
	@override String get very_bad => 'Hmm, finansal sağlığınız olması gerekenden çok düşük. Finanslarınız hakkında daha fazla bilgi edinmek için grafiklerin geri kalanını inceleyin';
}

// Path: financial_health.savings_percentage.text
class _TranslationsFinancialHealthSavingsPercentageTextTr implements TranslationsFinancialHealthSavingsPercentageTextEn {
	_TranslationsFinancialHealthSavingsPercentageTextTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String good({required Object value}) => 'Tebrikler! Bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız. Görünüşe göre zaten bir uzmansınız, iyi iş çıkarmaya devam edin!';
	@override String normal({required Object value}) => 'Tebrikler, bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız.';
	@override String bad({required Object value}) => 'Bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız. Ancak, hala çok daha fazlasını yapabileceğinizi düşünüyoruz!';
	@override String get very_bad => 'Vay canına, bu dönemde hiçbir şey biriktirmeyi başaramadınız.';
}

// Path: transaction.list.bulk_edit
class _TranslationsTransactionListBulkEditTr implements TranslationsTransactionListBulkEditEn {
	_TranslationsTransactionListBulkEditTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get dates => 'Tarihleri düzenle';
	@override String get categories => 'Kategorileri düzenle';
	@override String get status => 'Durumları düzenle';
}

// Path: transaction.filters.saved
class _TranslationsTransactionFiltersSavedTr implements TranslationsTransactionFiltersSavedEn {
	_TranslationsTransactionFiltersSavedTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kaydedilen filtreler';
	@override String get new_title => 'Yeni Filtre';
	@override String get edit_title => 'Filtreyi Düzenle';
	@override String get name_label => 'Filtre Adı';
	@override String get name_hint => 'Özel filtrem';
	@override String get save_dialog_title => 'Filtreyi Kaydet';
	@override String get save_tooltip => 'Mevcut filtreyi kaydet';
	@override String get load_tooltip => 'Kaydedilen filtreyi yükle';
	@override String get empty_title => 'Kaydedilen filtre bulunamadı';
	@override String get empty_description => 'Filtreleri daha sonra hızlıca erişmek için buraya kaydedin.';
	@override String get save_success => 'Filtre başarıyla kaydedildi';
	@override String get delete_success => 'Filtre başarıyla silindi';
}

// Path: transaction.form.validators
class _TranslationsTransactionFormValidatorsTr implements TranslationsTransactionFormValidatorsEn {
	_TranslationsTransactionFormValidatorsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get zero => 'Bir işlemin değeri sıfıra eşit olamaz';
	@override String get date_max => 'Seçilen tarih, güncel tarihten sonra. İşlem askıda olarak eklenecektir';
	@override String get date_after_account_creation => 'Bir işlemin tarihi, ait olduğu hesabın oluşturulma tarihinden önce olamaz';
	@override String get negative_transfer => 'Bir transferin parasal değeri negatif olamaz';
	@override String get transfer_between_same_accounts => 'Kaynak ve hedef hesap aynı olamaz';
}

// Path: transfer.form.value_in_destiny
class _TranslationsTransferFormValueInDestinyTr implements TranslationsTransferFormValueInDestinyEn {
	_TranslationsTransferFormValueInDestinyTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hedefte aktarılan miktar';
	@override String amount_short({required Object amount}) => 'Hedef hesaba ${amount}';
}

// Path: budgets.progress.labels
class _TranslationsBudgetsProgressLabelsTr implements TranslationsBudgetsProgressLabelsEn {
	_TranslationsBudgetsProgressLabelsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'Yolunda';
	@override String get active_overspending => 'Aşırı harcama';
	@override String get active_indeterminate => 'Aktif';
	@override String get success => 'Başarılı';
	@override String get fail => 'Bütçe aşıldı';
}

// Path: budgets.progress.description
class _TranslationsBudgetsProgressDescriptionTr implements TranslationsBudgetsProgressDescriptionEn {
	_TranslationsBudgetsProgressDescriptionTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object remainingDays, required Object dailyAmount}) => 'Kalan ${remainingDays} gün için günde ${dailyAmount} harcayabilirsiniz';
	@override String active_overspending({required Object remainingDays, required Object dailyAmount}) => 'Tekrar rayına oturmak için, kalan ${remainingDays} gün boyunca harcamalarınızı günde ${dailyAmount} ile sınırlamalısınız';
	@override String active_indeterminate({required Object amount}) => 'Harcayabileceğiniz ${amount} kaldı.';
	@override String active_exceeded({required Object amount}) => 'Bütçe limitinizi ${amount} aştınız. Bu bütçe için herhangi bir gelir bulamazsanız, dönemin geri kalanında harcama yapmayı bırakmalısınız';
	@override String get success => 'Harika iş! Bu bütçe başarıyla tamamlandı. Harcamalarınızı yönetmek için bütçe oluşturmaya devam edin';
	@override String fail({required Object amount}) => 'Bütçeyi ${amount} aştınız. Bir dahaki sefere daha dikkatli olmaya çalışın!';
}

// Path: goals.type.income
class _TranslationsGoalsTypeIncomeTr implements TranslationsGoalsTypeIncomeEn {
	_TranslationsGoalsTypeIncomeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tasarruf Hedefi';
	@override String get descr => 'Para biriktirmek için ideal. Bakiye hedefinizi aştığında başarılı olursunuz.';
}

// Path: goals.type.expense
class _TranslationsGoalsTypeExpenseTr implements TranslationsGoalsTypeExpenseEn {
	_TranslationsGoalsTypeExpenseTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Harcama Hedefi';
	@override String get descr => 'Ne kadar harcadığınızı takip edin ve bir hedef tutara ulaşmayı amaçlayın. Bağışlar için ...';
}

// Path: goals.progress.labels
class _TranslationsGoalsProgressLabelsTr implements TranslationsGoalsProgressLabelsEn {
	_TranslationsGoalsProgressLabelsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get active_on_track => 'Yolda';
	@override String get active_behind_schedule => 'Programın gerisinde';
	@override String get active_indeterminate => 'Aktif';
	@override String get success => 'Hedefe ulaşıldı';
	@override String get fail => 'Hedef başarısız oldu';
}

// Path: goals.progress.description
class _TranslationsGoalsProgressDescriptionTr implements TranslationsGoalsProgressDescriptionEn {
	_TranslationsGoalsProgressDescriptionTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String active_on_track({required Object remainingDays, required Object dailyAmount}) => 'Hedefinizi arama yolundasınız! Kalan ${remainingDays} gün boyunca günde ${dailyAmount} tasarruf etmelisiniz';
	@override String active_behind_schedule({required Object remainingDays, required Object dailyAmount}) => 'Programın gerisindesiniz. Hedefinize ${remainingDays} gün içinde ulaşmak için günde ${dailyAmount} tasarruf etmeniz gerekiyor';
	@override String active_indeterminate({required Object amount}) => 'Hedefinize ulaşmak için ${amount} daha fazlasına ihtiyacınız var.';
	@override String get success => 'Tebrikler! Hedefine ulaştın.';
	@override String fail({required Object amount}) => 'Hedefinizi ${amount} kadar kaçırdınız.';
}

// Path: backup.import.manual_import
class _TranslationsBackupImportManualImportTr implements TranslationsBackupImportManualImportEn {
	_TranslationsBackupImportManualImportTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Manuel içe aktarma';
	@override String get descr => 'İşlemleri manuel olarak .csv dosyasından içe aktarın';
	@override String get default_account => 'Varsayılan hesap';
	@override String get remove_default_account => 'Varsayılan hesabı kaldır';
	@override String get default_category => 'Varsayılan Kategori';
	@override String get default_tags => 'Varsayılan Etiketler';
	@override String get select_a_column => '.csv\'den bir sütun seçin';
	@override String get date_format => 'Tarih formatı';
	@override String get note_column => 'Not sütunu';
	@override String get title_column => 'Başlık sütunu';
	@override String get tag_separator => '.csv dosyasındaki etiket ayırıcı';
	@override List<String> get steps => [
		'Dosyanızı seçin',
		'Miktar için sütun',
		'Hesap için sütun',
		'Kategori için sütun',
		'Etiket sütunu',
		'Tarih için sütun',
		'Diğer sütunlar',
	];
	@override List<String> get steps_descr => [
		'Cihazınızdan bir .csv dosyası seçin. Her sütunun adını açıklayan bir ilk satıra sahip olduğundan emin olun',
		'Her işlemin değerinin belirtildiği sütunu seçin. Giderler için negatif değerler ve gelirler için pozitif değerler kullanın.',
		'Her işlemin ait olduğu hesabın belirtildiği sütunu seçin. İstediğiniz hesabı bulamamamız durumunda varsayılan bir hesap da seçebilirsiniz. Varsayılan bir hesap belirtilmezse, aynı adla bir tane oluşturacağız',
		'İşlem kategorisi adının bulunduğu sütunu belirtin. Kategoriyi bulamamamız durumunda işlemlere bu kategoriyi atayabilmemiz için varsayılan bir kategori belirtmeniz gerekir',
		'İşlem etiketlerinin bulunduğu sütunu belirtin. Belirtilmediği takdirde, işlemler varsayılan etiketlerle oluşturulacaktır.',
		'Her işlemin tarihinin belirtildiği sütunu seçin. Belirtilmezse, işlemler mevcut tarihle oluşturulacaktır',
		'Diğer isteğe bağlı işlem öznitelikleri için sütunları belirtir',
	];
	@override String success({required Object x}) => '${x} işlem başarıyla içe aktarıldı';
}

// Path: settings.general.language
class _TranslationsSettingsGeneralLanguageTr implements TranslationsSettingsGeneralLanguageEn {
	_TranslationsSettingsGeneralLanguageTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get section => 'Dil ve metinler';
	@override String get title => 'Uygulama dili';
	@override String get descr => 'Metinlerin uygulamada görüntüleneceği dil';
	@override String get help => 'Bu uygulamanın çevirilerine katkıda bulunmak isterseniz, <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>kılavuzumuza</a> başvurabilirsiniz';
}

// Path: settings.general.locale
class _TranslationsSettingsGeneralLocaleTr implements TranslationsSettingsGeneralLocaleEn {
	_TranslationsSettingsGeneralLocaleTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bölge';
	@override String get auto => 'Sistem';
	@override String get descr => 'Tarihler, sayılar için kullanılacak biçimi ayarlayın...';
	@override String get warn => 'Bölge değiştirildiğinde uygulama güncellenecektir';
	@override String get first_day_of_week => 'Haftanın ilk günü';
}

// Path: settings.transactions.style
class _TranslationsSettingsTransactionsStyleTr implements TranslationsSettingsTransactionsStyleEn {
	_TranslationsSettingsTransactionsStyleTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'İşlem stili';
	@override String get subtitle => 'İşlemlerin listelerde nasıl görüneceğini yapılandırın';
	@override String get show_tags => 'Etiketleri Göster';
	@override String get show_time => 'Saati Göster';
}

// Path: settings.transactions.swipe_actions
class _TranslationsSettingsTransactionsSwipeActionsTr implements TranslationsSettingsTransactionsSwipeActionsEn {
	_TranslationsSettingsTransactionsSwipeActionsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kaydırma eylemleri';
	@override String get choose_description => 'Bu kaydırma yönünü kullanarak listedeki bir işlem öğesini kaydırdığınızda hangi eylemin tetikleneceğini seçin';
	@override String get swipe_left => 'Sola kaydırın';
	@override String get swipe_right => 'Sağa kaydırın';
	@override String get none => 'Eylem yok';
	@override String get toggle_reconciled => 'Mutabık kılınmayı aç/kapat';
	@override String get toggle_pending => 'Beklemede\'yi aç/kapat';
	@override String get toggle_voided => 'Geçiş iptal edildi';
	@override String get toggle_unreconciled => 'Mutabık kılınmayanları aç/kapat';
	@override String get remove_status => 'Durumu kaldır';
}

// Path: settings.transactions.default_values
class _TranslationsSettingsTransactionsDefaultValuesTr implements TranslationsSettingsTransactionsDefaultValuesEn {
	_TranslationsSettingsTransactionsDefaultValuesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

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
class _TranslationsSettingsTransactionsDefaultTypeTr implements TranslationsSettingsTransactionsDefaultTypeEn {
	_TranslationsSettingsTransactionsDefaultTypeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Default Type';
	@override String get modal_title => 'Select Default Type';
}

// Path: settings.appearance.theme
class _TranslationsSettingsAppearanceThemeTr implements TranslationsSettingsAppearanceThemeEn {
	_TranslationsSettingsAppearanceThemeTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tema';
	@override String get auto => 'Sistem';
	@override String get light => 'Açık';
	@override String get dark => 'Koyu';
}

// Path: more.about_us.legal
class _TranslationsMoreAboutUsLegalTr implements TranslationsMoreAboutUsLegalEn {
	_TranslationsMoreAboutUsLegalTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Yasal bilgiler';
	@override String get privacy => 'Gizlilik politikası';
	@override String get terms => 'Kullanım koşulları';
	@override String get licenses => 'Lisanslar';
}

// Path: more.about_us.project
class _TranslationsMoreAboutUsProjectTr implements TranslationsMoreAboutUsProjectEn {
	_TranslationsMoreAboutUsProjectTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get display => 'Proje';
	@override String get contributors => 'Katkıda bulunanlar';
	@override String get contributors_descr => 'Monekin\'in büyümesini sağlayan tüm geliştiriciler';
	@override String get contact => 'Bize ulaşın';
}

// Path: general.time.ranges.types
class _TranslationsGeneralTimeRangesTypesTr implements TranslationsGeneralTimeRangesTypesEn {
	_TranslationsGeneralTimeRangesTypesTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get cycle => 'Döngüler';
	@override String get last_days => 'Son günler';
	@override String last_days_form({required Object x}) => 'Önceki ${x} gün';
	@override String get all => 'Her Zaman';
	@override String get date_range => 'Özel aralık';
}

/// The flat map containing all translations for locale <tr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ui_actions.cancel' => 'İptal',
			'ui_actions.confirm' => 'Onayla',
			'ui_actions.continue_text' => 'Devam Et',
			'ui_actions.save' => 'Kaydet',
			'ui_actions.save_changes' => 'Değişiklikleri Kaydet',
			'ui_actions.close_and_save' => 'Kaydet ve Kapat',
			'ui_actions.add' => 'Ekle',
			'ui_actions.edit' => 'Düzenle',
			'ui_actions.delete' => 'Sil',
			'ui_actions.see_more' => 'Daha Fazla Gör',
			'ui_actions.select_all' => 'Tümünü Seç',
			'ui_actions.deselect_all' => 'Tüm Seçimi Kaldır',
			'ui_actions.select' => 'Seç',
			'ui_actions.search' => 'Ara',
			'ui_actions.filter' => 'Filtrele',
			'ui_actions.reset' => 'Sıfırla',
			'ui_actions.submit' => 'Gönder',
			'ui_actions.next' => 'Sonraki',
			'ui_actions.previous' => 'Önceki',
			'ui_actions.back' => 'Geri',
			'ui_actions.reload' => 'Yenile',
			'ui_actions.view' => 'Görüntüle',
			'ui_actions.download' => 'İndir',
			'ui_actions.upload' => 'Yükle',
			'ui_actions.retry' => 'Tekrar Dene',
			'ui_actions.copy' => 'Kopyala',
			'ui_actions.paste' => 'Yapıştır',
			'ui_actions.undo' => 'Geri Al',
			'ui_actions.redo' => 'İleri Al',
			'ui_actions.open' => 'Aç',
			'ui_actions.close' => 'Kapat',
			'ui_actions.apply' => 'Uygula',
			'ui_actions.discard' => 'Vazgeç',
			'ui_actions.refresh' => 'Yenile',
			'ui_actions.share' => 'Paylaş',
			'general.or' => 'veya',
			'general.understood' => 'Anlaşıldı',
			'general.unspecified' => 'Belirtilmemiş',
			'general.quick_actions' => 'Hızlı İşlemler',
			'general.details' => 'Detaylar',
			'general.balance' => 'Bakiye',
			'general.account' => 'Hesap',
			'general.accounts' => 'Hesaplar',
			'general.categories' => 'Kategoriler',
			'general.category' => 'Kategori',
			'general.today' => 'Bugün',
			'general.yesterday' => 'Dün',
			'general.filters' => 'Filtreler',
			'general.empty_warn' => 'Ups! Burası çok boş',
			'general.search_no_results' => 'Arama kriterlerinizle eşleşen öğe yok',
			'general.insufficient_data' => 'Yetersiz veri',
			'general.show_more_fields' => 'Daha fazla alan göster',
			'general.show_less_fields' => 'Daha az alan göster',
			'general.tap_to_search' => 'Aramak için dokunun',
			'general.delete_success' => 'Öğe başarıyla silindi',
			'general.leave_without_saving.title' => 'Kaydetmeden ayrılmak mı istiyorsunuz?',
			'general.leave_without_saving.message' => 'Kaydedilmemiş değişiklikleriniz var, bunları kaydetmeden ayrılmak istediğinizden emin misiniz?',
			'general.clipboard.success' => ({required Object x}) => '${x} panoya kopyalandı',
			'general.clipboard.error' => 'Kopyalama hatası',
			'general.time.start_date' => 'Başlangıç tarihi',
			'general.time.end_date' => 'Bitiş tarihi',
			'general.time.from_date' => 'Başlangıç tarihi',
			'general.time.until_date' => 'Bitiş tarihi',
			'general.time.date' => 'Tarih',
			'general.time.datetime' => 'Tarih ve saat',
			'general.time.time' => 'Saat',
			'general.time.each' => 'Her',
			'general.time.after' => 'Sonra',
			'general.time.ranges.display' => 'Zaman aralığı',
			'general.time.ranges.it_repeat' => 'Tekrarlar',
			'general.time.ranges.it_ends' => 'Biter',
			'general.time.ranges.forever' => 'Sonsuza kadar',
			'general.time.ranges.types.cycle' => 'Döngüler',
			'general.time.ranges.types.last_days' => 'Son günler',
			'general.time.ranges.types.last_days_form' => ({required Object x}) => 'Önceki ${x} gün',
			'general.time.ranges.types.all' => 'Her Zaman',
			'general.time.ranges.types.date_range' => 'Özel aralık',
			'general.time.ranges.each_range' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Her ${range}', other: 'Her ${n} ${range}', ), 
			'general.time.ranges.each_range_until_date' => ({required num n, required Object day, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: '${day} tarihine kadar her ${range}', other: '${day} tarihine kadar her ${n} ${range}', ), 
			'general.time.ranges.each_range_until_times' => ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Her ${range} ${limit} kez', other: 'Her ${n} ${range} ${limit} kez', ), 
			'general.time.ranges.each_range_until_once' => ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Her ${range} bir kez', other: 'Her ${n} ${range} bir kez', ), 
			'general.time.ranges.month' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Ay', other: 'Aylar', ), 
			'general.time.ranges.year' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Yıl', other: 'Yıllar', ), 
			'general.time.ranges.day' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Gün', other: 'Günler', ), 
			'general.time.ranges.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Hafta', other: 'Haftalar', ), 
			'general.time.periodicity.display' => 'Tekrarlama',
			'general.time.periodicity.no_repeat' => 'Tekrarlama yok',
			'general.time.periodicity.repeat' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Tekrar', other: 'Tekrarlar', ), 
			'general.time.periodicity.diary' => 'Günlük',
			'general.time.periodicity.monthly' => 'Aylık',
			'general.time.periodicity.annually' => 'Yıllık',
			'general.time.periodicity.quaterly' => 'Üç Aylık',
			'general.time.periodicity.weekly' => 'Haftalık',
			'general.time.periodicity.custom' => 'Özel',
			'general.time.periodicity.infinite' => 'Her Zaman',
			'general.time.current.monthly' => 'Bu ay',
			'general.time.current.annually' => 'Bu yıl',
			'general.time.current.quaterly' => 'Bu çeyrek',
			'general.time.current.weekly' => 'Bu hafta',
			'general.time.current.infinite' => 'Sonsuza dek',
			'general.time.current.custom' => 'Özel Aralık',
			'general.time.all.diary' => 'Her gün',
			'general.time.all.monthly' => 'Her ay',
			'general.time.all.annually' => 'Her yıl',
			'general.time.all.quaterly' => 'Her çeyrek',
			'general.time.all.weekly' => 'Her hafta',
			'general.transaction_order.display' => 'İşlemleri sırala',
			'general.transaction_order.category' => 'Kategoriye göre',
			'general.transaction_order.quantity' => 'Miktara göre',
			'general.transaction_order.date' => 'Tarihe göre',
			'general.validations.form_error' => 'Devam etmek için belirtilen alanları düzeltin',
			'general.validations.required' => 'Gerekli alan',
			'general.validations.positive' => 'Pozitif olmalı',
			'general.validations.min_number' => ({required Object x}) => '${x} değerinden büyük olmalı',
			'general.validations.max_number' => ({required Object x}) => '${x} değerinden küçük olmalı',
			'intro.start' => 'Başla',
			'intro.skip' => 'Atla',
			'intro.next' => 'İleri',
			'intro.select_your_currency' => 'Para birimini seçin',
			'intro.welcome_subtitle' => 'Kişisel finans yöneticiniz',
			'intro.welcome_subtitle2' => '%100 açık, %100 ücretsiz',
			'intro.welcome_footer' => 'Giriş yaparak, uygulamanın <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Gizlilik Politikası</a> ve <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Kullanım Şartları</a>\'nı kabul etmiş olursunuz',
			'intro.offline_descr_title' => 'ÇEVRİMDIŞI HESAP:',
			'intro.offline_descr' => 'Verileriniz yalnızca cihazınızda saklanacak ve uygulamayı kaldırmadığınız veya telefon değiştirmediniz sürece güvende olacaktır. Veri kaybını önlemek için, uygulama ayarlarından düzenli olarak yedekleme yapılması önerilir.',
			'intro.offline_start' => 'Çevrimdışı oturum başlat',
			'intro.sl1_title' => 'Para birimini seçin',
			'intro.sl1_descr' => 'Varsayılan para biriminiz raporlarda ve genel grafiklerde kullanılacaktır. Uygulama ayarlarından daha sonra istediğiniz zaman para birimini ve uygulama dilini değiştirebileceksiniz',
			'intro.sl2_title' => 'Güvenli, gizli ve güvenilir',
			'intro.sl2_descr' => 'Verileriniz yalnızca size aittir. Bilgileri harici sunuculara gitmeden doğrudan cihazınızda saklarız. Bu, uygulamayı internet olmadan bile kullanmayı mümkün kılar',
			'intro.sl2_descr2' => 'Ayrıca, uygulamanın kaynak kodu herkese açıktır, herkes üzerinde işbirliği yapabilir ve nasıl çalıştığını görebilir',
			'intro.last_slide_title' => 'Her şey hazır',
			'intro.last_slide_descr' => 'Monekin ile sonunda çok istediğiniz finansal bağımsızlığa ulaşabilirsiniz. Paranız hakkında grafiklere, bütçelere, ipuçlarına, istatistiklere ve çok daha fazlasına sahip olacaksınız.',
			'intro.last_slide_descr2' => 'Umarız deneyiminizden keyif alırsınız! Şüpheleriniz, önerileriniz durumunda bizimle iletişime geçmekten çekinmeyin...',
			'home.title' => 'Gösterge Paneli',
			'home.filter_transactions' => 'İşlemleri filtrele',
			'home.hello_day' => 'Günaydın,',
			'home.hello_night' => 'İyi geceler,',
			'home.total_balance' => 'Toplam bakiye',
			'home.my_accounts' => 'Hesaplarım',
			'home.active_accounts' => 'Aktif hesaplar',
			'home.no_accounts' => 'Henüz hesap oluşturulmadı',
			'home.no_accounts_descr' => 'Monekin\'in tüm sihrini kullanmaya başlayın. İşlem eklemeye başlamak için en az bir hesap oluşturun',
			'home.last_transactions' => 'Son işlemler',
			'home.should_create_account_header' => 'Ups!',
			'home.should_create_account_message' => 'İşlem oluşturmaya başlamadan önce en az bir arşivlenmemiş hesabınız olmalıdır',
			'financial_health.display' => 'Finansal sağlık',
			'financial_health.review.very_good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Çok iyi!'; case GenderContext.female: return 'Çok iyi!'; } }, 
			'financial_health.review.good' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'İyi'; case GenderContext.female: return 'İyi'; } }, 
			'financial_health.review.normal' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Ortalama'; case GenderContext.female: return 'Ortalama'; } }, 
			'financial_health.review.bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Fena'; case GenderContext.female: return 'Fena'; } }, 
			'financial_health.review.very_bad' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Çok Kötü'; case GenderContext.female: return 'Çok Kötü'; } }, 
			'financial_health.review.insufficient_data' => ({required GenderContext context}) { switch (context) { case GenderContext.male: return 'Yetersiz veri'; case GenderContext.female: return 'Yetersiz veri'; } }, 
			'financial_health.review.descr.insufficient_data' => 'Finansal sağlığınızı hesaplamak için yeterli giderimiz yok gibi görünüyor. Size yardımcı olmamıza izin vermek için bu dönemde bazı giderler/gelirler ekleyin!',
			'financial_health.review.descr.very_good' => 'Tebrikler! Finansal sağlığınız muazzam. İyi gidişatınızı sürdürmenizi ve Monekin ile öğrenmeye devam etmenizi umuyoruz',
			'financial_health.review.descr.good' => 'Harika! Finansal sağlığınız iyi. Daha da fazla nasıl tasarruf edebileceğinizi görmek için analiz sekmesini ziyaret edin!',
			'financial_health.review.descr.normal' => 'Finansal sağlığınız bu dönem için nüfusun geri kalanının ortalamasına az çok eşit',
			'financial_health.review.descr.bad' => 'Görünüşe göre mali durumunuz henüz en iyi seviyede değil. Finanslarınız hakkında daha fazla bilgi edinmek için grafiklerin geri kalanını inceleyin',
			'financial_health.review.descr.very_bad' => 'Hmm, finansal sağlığınız olması gerekenden çok düşük. Finanslarınız hakkında daha fazla bilgi edinmek için grafiklerin geri kalanını inceleyin',
			'financial_health.months_without_income.title' => 'Hayatta kalma oranı',
			'financial_health.months_without_income.subtitle' => 'Bakiyeniz göz önüne alındığında, gelirsiz kalabileceğiniz süre',
			'financial_health.months_without_income.text_zero' => 'Bu gider oranında gelirsiz bir ay bile dayanamazsınız!',
			'financial_health.months_without_income.text_one' => 'Bu gider oranında yaklaşık bir ay gelirsiz yaşayabilirsiniz!',
			'financial_health.months_without_income.text_other' => ({required Object n}) => 'Bu harcama oranında yaklaşık <b>${n} ay</b> gelir olmadan yaşayabilirsiniz.',
			'financial_health.months_without_income.text_infinite' => 'Bu harcama oranında yaklaşık <b>tüm hayatınız boyunca</b> gelir olmadan yaşayabilirsiniz.',
			'financial_health.months_without_income.suggestion' => 'Bu oranın her zaman en az 5 ayın üzerinde tutulması gerektiğini unutmayın. Yeterli birikiminiz olmadığını görürseniz, gereksiz harcamaları azaltın.',
			'financial_health.months_without_income.insufficient_data' => 'Gelirsiz kaç ay hayatta kalabileceğinizi hesaplamak için yeterli giderimiz yok gibi görünüyor. Birkaç işlem girin ve finansal sağlığınızı kontrol etmek için buraya geri gelin',
			'financial_health.savings_percentage.title' => 'Tasarruf yüzdesi',
			'financial_health.savings_percentage.subtitle' => 'Gelirinizin ne kadarı bu dönemde harcanmıyor',
			'financial_health.savings_percentage.text.good' => ({required Object value}) => 'Tebrikler! Bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız. Görünüşe göre zaten bir uzmansınız, iyi iş çıkarmaya devam edin!',
			'financial_health.savings_percentage.text.normal' => ({required Object value}) => 'Tebrikler, bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız.',
			'financial_health.savings_percentage.text.bad' => ({required Object value}) => 'Bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız. Ancak, hala çok daha fazlasını yapabileceğinizi düşünüyoruz!',
			'financial_health.savings_percentage.text.very_bad' => 'Vay canına, bu dönemde hiçbir şey biriktirmeyi başaramadınız.',
			'financial_health.savings_percentage.suggestion' => 'Kazandığınızın en az %15-20\'sini biriktirmenin tavsiye edildiğini unutmayın.',
			'stats.title' => 'İstatistikler',
			'stats.balance' => 'Bakiye',
			'stats.final_balance' => 'Son bakiye',
			'stats.balance_by_account' => 'Hesaplara göre bakiye',
			'stats.balance_by_account_subtitle' => 'Paramın çoğunu nerede tutuyorum?',
			'stats.balance_by_currency' => 'Para birimine göre bakiye',
			'stats.balance_by_currency_subtitle' => 'Yabancı para biriminde ne kadar param var?',
			'stats.balance_evolution' => 'Bakiye trendi',
			'stats.balance_evolution_subtitle' => 'Eskisinden daha çok param var mı?',
			'stats.compared_to_previous_period' => 'Önceki döneme göre',
			'stats.cash_flow' => 'Nakit akışı',
			'stats.cash_flow_subtitle' => 'Kazandığımdan daha az mı harcıyorum?',
			'stats.by_periods' => 'Dönemlere göre',
			'stats.by_categories' => 'Kategorilere göre',
			'stats.by_tags' => 'Etiketlere göre',
			'stats.distribution' => 'Dağıtım',
			'stats.finance_health_resume' => 'Özet',
			'stats.finance_health_breakdown' => 'Detaylı Analiz',
			'icon_selector.name' => 'İsim:',
			'icon_selector.icon' => 'İkon',
			'icon_selector.color' => 'Renk',
			'icon_selector.select_icon' => 'Bir ikon seçin',
			'icon_selector.select_color' => 'Bir renk seçin',
			'icon_selector.custom_color' => 'Özel renk',
			'icon_selector.current_color_selection' => 'Mevcut seçim',
			'icon_selector.select_account_icon' => 'Hesabınızı tanımlayın',
			'icon_selector.select_category_icon' => 'Kategorinizi tanımlayın',
			'icon_selector.scopes.transport' => 'Ulaşım',
			'icon_selector.scopes.money' => 'Para',
			'icon_selector.scopes.food' => 'Gıda',
			'icon_selector.scopes.medical' => 'Sağlık',
			'icon_selector.scopes.entertainment' => 'Eğlence',
			'icon_selector.scopes.technology' => 'Teknoloji',
			'icon_selector.scopes.other' => 'Diğerleri',
			'icon_selector.scopes.logos_financial_institutions' => 'Finans kuruluşları',
			'transaction.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'İşlem', other: 'İşlemler', ), 
			'transaction.create' => 'Yeni işlem',
			'transaction.new_income' => 'Yeni gelir',
			'transaction.new_expense' => 'Yeni gider',
			'transaction.new_success' => 'İşlem başarıyla oluşturuldu',
			'transaction.edit' => 'İşlemi düzenle',
			'transaction.edit_success' => 'İşlem başarıyla düzenlendi',
			'transaction.edit_multiple' => 'İşlemleri düzenle',
			'transaction.edit_multiple_success' => ({required Object x}) => '${x} işlem başarıyla düzenlendi',
			'transaction.duplicate' => 'İşlemi kopyala',
			'transaction.duplicate_short' => 'Kopyala',
			'transaction.duplicate_warning_message' => 'Aynısı olan bir işlem bu tarih ile oluşturulacaktır, devam etmek istiyor musunuz?',
			'transaction.duplicate_success' => 'İşlem başarıyla kopyalandı',
			'transaction.delete' => 'İşlemi sil',
			'transaction.delete_warning_message' => 'Bu eylem geri alınamaz. Hesaplarınızın mevcut bakiyesi ve tüm istatistikleriniz yeniden hesaplanacaktır',
			'transaction.delete_success' => 'İşlem başarıyla silindi',
			'transaction.delete_multiple' => 'İşlemleri sil',
			'transaction.delete_multiple_warning_message' => ({required Object x}) => 'Bu eylem geri alınamaz ve ${x} işlem silinecektir. Hesaplarınızın mevcut bakiyesi ve tüm istatistikleriniz yeniden hesaplanacaktır',
			'transaction.delete_multiple_success' => ({required Object x}) => '${x} işlem başarıyla silindi',
			'transaction.details' => 'Hareket detayları',
			'transaction.next_payments.accept' => 'Kabul et',
			'transaction.next_payments.skip' => 'Atla',
			'transaction.next_payments.skip_success' => 'İşlem başarıyla atlandı',
			'transaction.next_payments.skip_dialog_title' => 'İşlemi atla',
			'transaction.next_payments.skip_dialog_msg' => ({required Object date}) => 'Bu eylem geri alınamaz. Bir sonraki hareketin tarihini ${date} olarak değiştireceğiz',
			'transaction.next_payments.accept_today' => 'Bugün kabul et',
			'transaction.next_payments.accept_in_required_date' => ({required Object date}) => 'Gerekli tarihte kabul et (${date})',
			'transaction.next_payments.accept_dialog_title' => 'İşlemi kabul et',
			'transaction.next_payments.accept_dialog_msg_single' => 'İşlemin yeni durumu boş olacaktır. İstediğiniz zaman bu işlemin durumunu yeniden düzenleyebilirsiniz',
			'transaction.next_payments.accept_dialog_msg' => ({required Object date}) => 'Bu eylem ${date} tarihli yeni bir işlem oluşturacaktır. İşlem sayfasında bu işlemin detaylarını kontrol edebileceksiniz',
			'transaction.next_payments.recurrent_rule_finished' => 'Tekrarlama kuralı tamamlandı, yapılacak başka ödeme yok!',
			'transaction.list.all' => 'Tüm İşlemler',
			'transaction.list.empty' => 'Burada görüntülenecek işlem bulunamadı. Uygulamaya birkaç işlem ekleyin, belki bir dahaki sefere daha şanslı olursunuz.',
			'transaction.list.searcher_placeholder' => 'Kategoriye, açıklamaya göre ara...',
			'transaction.list.searcher_no_results' => 'Arama kriterlerine uyan işlem bulunamadı',
			'transaction.list.loading' => 'Daha fazla işlem yükleniyor...',
			'transaction.list.selected_short' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: '${n} seçildi', other: '${n} seçildi', ), 
			'transaction.list.selected_long' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: '${n} işlem seçildi', other: '${n} işlem seçildi', ), 
			'transaction.list.bulk_edit.dates' => 'Tarihleri düzenle',
			'transaction.list.bulk_edit.categories' => 'Kategorileri düzenle',
			'transaction.list.bulk_edit.status' => 'Durumları düzenle',
			'transaction.filters.title' => 'İşlem filtreleri',
			'transaction.filters.from_value' => 'Miktardan',
			'transaction.filters.to_value' => 'Miktara kadar',
			'transaction.filters.from_value_def' => ({required Object x}) => '${x} dan',
			'transaction.filters.to_value_def' => ({required Object x}) => '${x} a kadar',
			'transaction.filters.from_date_def' => ({required Object date}) => '${date} tarihinden',
			'transaction.filters.to_date_def' => ({required Object date}) => '${date} tarihine kadar',
			'transaction.filters.reset' => 'Filtreleri sıfırla',
			'transaction.filters.saved.title' => 'Kaydedilen filtreler',
			'transaction.filters.saved.new_title' => 'Yeni Filtre',
			'transaction.filters.saved.edit_title' => 'Filtreyi Düzenle',
			'transaction.filters.saved.name_label' => 'Filtre Adı',
			'transaction.filters.saved.name_hint' => 'Özel filtrem',
			'transaction.filters.saved.save_dialog_title' => 'Filtreyi Kaydet',
			'transaction.filters.saved.save_tooltip' => 'Mevcut filtreyi kaydet',
			'transaction.filters.saved.load_tooltip' => 'Kaydedilen filtreyi yükle',
			'transaction.filters.saved.empty_title' => 'Kaydedilen filtre bulunamadı',
			'transaction.filters.saved.empty_description' => 'Filtreleri daha sonra hızlıca erişmek için buraya kaydedin.',
			'transaction.filters.saved.save_success' => 'Filtre başarıyla kaydedildi',
			'transaction.filters.saved.delete_success' => 'Filtre başarıyla silindi',
			'transaction.form.validators.zero' => 'Bir işlemin değeri sıfıra eşit olamaz',
			'transaction.form.validators.date_max' => 'Seçilen tarih, güncel tarihten sonra. İşlem askıda olarak eklenecektir',
			'transaction.form.validators.date_after_account_creation' => 'Bir işlemin tarihi, ait olduğu hesabın oluşturulma tarihinden önce olamaz',
			'transaction.form.validators.negative_transfer' => 'Bir transferin parasal değeri negatif olamaz',
			'transaction.form.validators.transfer_between_same_accounts' => 'Kaynak ve hedef hesap aynı olamaz',
			'transaction.form.title' => 'İşlem başlığı',
			'transaction.form.title_short' => 'Başlık',
			'transaction.form.value' => 'İşlem değeri',
			'transaction.form.tap_to_see_more' => 'Daha fazla detay görmek için dokunun',
			'transaction.form.no_tags' => '-- Etiket yok --',
			'transaction.form.description' => 'Açıklama',
			'transaction.form.description_info' => 'Bu işlem hakkında daha detaylı bir açıklama girmek için buraya dokunun',
			'transaction.form.exchange_to_preferred_title' => ({required Object currency}) => '${currency} için kur',
			'transaction.form.exchange_to_preferred_in_date' => 'İşlem tarihinde',
			'transaction.reversed.title' => 'Ters işlem',
			'transaction.reversed.title_short' => 'Ters. iş.',
			'transaction.reversed.description_for_expenses' => 'Bir gider işlemi olmasına rağmen, pozitif bir tutara sahiptir. Bu tür işlemler, bir geri ödeme veya bir borcun ödenmesi gibi daha önce kaydedilmiş bir giderin iadesini temsil etmek için kullanılabilir.',
			'transaction.reversed.description_for_incomes' => 'Bir gelir işlemi olmasına rağmen, negatif bir tutara sahiptir. Bu tür işlemler, hatalı kaydedilmiş bir geliri geçersiz kılmak veya düzeltmek, para iadesini veya geri ödemesini yansıtmak veya borç ödemesini kaydetmek için kullanılabilir.',
			'transaction.status.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Durum', other: 'Durumlar', ), 
			'transaction.status.display_long' => 'İşlem durumu',
			'transaction.status.tr_status' => ({required Object status}) => '${status} işlemi',
			'transaction.status.none' => 'Durumsuz',
			'transaction.status.none_descr' => 'Belirli bir durumu olmayan işlem',
			'transaction.status.reconciled' => 'Mutabık',
			'transaction.status.reconciled_descr' => 'Bu işlem zaten onaylandı ve bankanızdaki gerçek bir işleme karşılık geliyor',
			'transaction.status.unreconciled' => 'Mutabık değil',
			'transaction.status.unreconciled_descr' => 'Bu işlem henüz doğrulanmadı ve bu nedenle henüz gerçek banka hesaplarınızda görünmüyor. Ancak, Monekin\'deki bakiyelerin ve istatistiklerin hesaplanması için sayılır',
			'transaction.status.pending' => 'Beklemede',
			'transaction.status.pending_descr' => 'Bu işlem bekliyor ve bu nedenle bakiyeler ve istatistikler hesaplanırken dikkate alınmayacaktır',
			'transaction.status.voided' => 'İptal Edildi',
			'transaction.status.voided_descr' => 'Ödeme hatası veya başka herhangi bir nedenden dolayı geçersiz kılınan/iptal edilen işlem. Bakiyeler ve istatistikler hesaplanırken dikkate alınmayacaktır',
			'transaction.types.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'İşlem türü', other: 'İşlem türleri', ), 
			'transaction.types.income' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Gelir', other: 'Gelirler', ), 
			'transaction.types.expense' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Gider', other: 'Giderler', ), 
			'transaction.types.transfer' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Transfer', other: 'Transferler', ), 
			'transfer.display' => 'Transfer',
			'transfer.transfers' => 'Transferler',
			'transfer.transfer_to' => ({required Object account}) => '${account} hesabına transfer',
			'transfer.create' => 'Yeni Transfer',
			'transfer.need_two_accounts_warning_header' => 'Ups!',
			'transfer.need_two_accounts_warning_message' => 'Bu eylemi gerçekleştirmek için en az iki hesaba ihtiyaç vardır. Bu hesabın mevcut bakiyesini ayarlamanız veya düzenlemeniz gerekiyorsa, düzenle düğmesine tıklayın',
			'transfer.form.from' => 'Kaynak hesap',
			'transfer.form.to' => 'Hedef hesap',
			'transfer.form.value_in_destiny.title' => 'Hedefte aktarılan miktar',
			'transfer.form.value_in_destiny.amount_short' => ({required Object amount}) => 'Hedef hesaba ${amount}',
			'recurrent_transactions.title' => 'Tekrarlayan işlemler',
			'recurrent_transactions.title_short' => 'Tekr. işl.',
			'recurrent_transactions.empty' => 'Görünüşe göre tekrarlayan herhangi bir işleminiz yok. Aylık, yıllık veya haftalık tekrarlayan bir işlem oluşturun, burada görünecektir',
			'recurrent_transactions.total_expense_title' => 'Dönem başına toplam gider',
			'recurrent_transactions.total_expense_descr' => '* Her tekrarın başlangıç ​​ve bitiş tarihi dikkate alınmadan',
			'recurrent_transactions.details.title' => 'Tekrarlayan işlem',
			'recurrent_transactions.details.descr' => 'Bu işlem için sonraki hareketler aşağıda gösterilmektedir. İlk hareketi kabul edebilir veya bu hareketi atlayabilirsiniz',
			'recurrent_transactions.details.last_payment_info' => 'Bu hareket, tekrar kuralının sonuncusudur, bu nedenle bu eylemi onaylarken bu kural otomatik olarak silinecektir',
			'recurrent_transactions.details.delete_header' => 'Tekrarlayan işlemi sil',
			'recurrent_transactions.details.delete_message' => 'Bu eylem geri alınamaz ve zaten onayladığınız/ödediğiniz işlemleri etkilemez',
			'recurrent_transactions.status.delayed_by' => ({required Object x}) => '${x}g gecikti',
			'recurrent_transactions.status.coming_in' => ({required Object x}) => '${x} gün içinde',
			'account.details' => 'Hesap detayları',
			'account.date' => 'Açılış tarihi',
			'account.close_date' => 'Kapanış tarihi',
			'account.reopen' => 'Hesabı yeniden aç',
			'account.reopen_short' => 'Yeniden aç',
			'account.reopen_descr' => 'Bu hesabı yeniden açmak istediğinizden emin misiniz?',
			'account.balance' => 'Hesap bakiyesi',
			'account.n_transactions' => 'İşlem sayısı',
			'account.add_money' => 'Para ekle',
			'account.withdraw_money' => 'Para çek',
			'account.no_accounts' => 'Burada görüntülenecek işlem bulunamadı. Alttaki \'+\' düğmesine tıklayarak bir işlem ekleyin',
			'account.types.title' => 'Hesap türü',
			'account.types.warning' => 'Hesap türü seçildikten sonra gelecekte değiştirilemez',
			'account.types.normal' => 'Normal hesap',
			'account.types.normal_descr' => 'Günlük mali durumunuzu kaydetmek için kullanışlıdır. En yaygın hesaptır, giderler, gelirler eklemenize olanak tanır...',
			'account.types.saving' => 'Tasarruf hesabı',
			'account.types.saving_descr' => 'Yalnızca diğer hesaplardan para ekleyebilecek ve çekebileceksiniz. Para biriktirmeye başlamak için mükemmel',
			'account.form.name' => 'Hesap adı',
			'account.form.name_placeholder' => 'Örn: Tasarruf hesabı',
			'account.form.notes' => 'Notlar',
			'account.form.notes_placeholder' => 'Bu hesap hakkında bazı notlar/açıklama yazın',
			'account.form.initial_balance' => 'Başlangıç ​​bakiyesi',
			'account.form.current_balance' => 'Mevcut bakiye',
			'account.form.create' => 'Hesap oluştur',
			'account.form.edit' => 'Hesabı düzenle',
			'account.form.currency_not_found_warn' => 'Bu para birimi için döviz kurları hakkında bilginiz yok. Varsayılan döviz kuru olarak 1.0 kullanılacaktır. Bunu ayarlardan değiştirebilirsiniz',
			'account.form.already_exists' => 'Aynı ada sahip başka bir hesap zaten var, lütfen başka bir tane yazın',
			'account.form.tr_before_opening_date' => 'Bu hesapta açılış tarihinden önce bir tarihe sahip işlemler var',
			'account.form.iban' => 'IBAN',
			'account.form.swift' => 'SWIFT',
			'account.delete.warning_header' => 'Hesap silinsin mi?',
			'account.delete.warning_text' => 'Bu eylem bu hesabı ve tüm işlemlerini silecektir',
			'account.delete.success' => 'Hesap başarıyla silindi',
			'account.close.title' => 'Hesabı kapat',
			'account.close.title_short' => 'Kapat',
			'account.close.warn' => 'Bu hesap artık belirli listelerde görünmeyecek ve aşağıda belirtilen tarihten sonra bu hesapta işlem oluşturamayacaksınız. Bu eylem herhangi bir işlemi veya bakiyeyi etkilemez ve ayrıca bu hesabı istediğiniz zaman yeniden açabilirsiniz.',
			'account.close.should_have_zero_balance' => 'Kapatmak için bu hesabın mevcut bakiyesi 0 olmalıdır. Lütfen devam etmeden önce hesabı düzenleyin',
			'account.close.should_have_no_transactions' => 'Bu hesap, belirtilen kapanış tarihinden sonra işlemlere sahip. Devam etmeden önce bunları silin veya hesabın kapanış tarihini düzenleyin',
			'account.close.success' => 'Hesap başarıyla kapatıldı',
			'account.close.unarchive_succes' => 'Hesap başarıyla yeniden açıldı',
			'account.select.one' => 'Bir hesap seçin',
			'account.select.all' => 'Tüm hesaplar',
			'account.select.multiple' => 'Hesapları seçin',
			'currencies.currency_converter' => 'Para birimi dönüştürücü',
			'currencies.currency' => 'Para birimi',
			'currencies.currency_settings' => 'Para birimi ayarları',
			'currencies.currency_manager' => 'Para birimi yöneticisi',
			'currencies.currency_manager_descr' => 'Para biriminizi ve diğerleriyle döviz kurlarını yapılandırın',
			'currencies.preferred_currency' => 'Tercih edilen/temel para birimi',
			'currencies.tap_to_change_preferred_currency' => 'Değiştirmek için dokunun',
			'currencies.change_preferred_currency_title' => 'Tercih edilen para birimini değiştir',
			'currencies.change_preferred_currency_msg' => 'Tüm istatistikler ve bütçeler bundan sonra bu para biriminde görüntülenecektir. Hesaplar ve işlemler sahip oldukları para birimini koruyacaktır. Bu eylemi gerçekleştirirseniz, kaydedilen tüm döviz kurları silinecektir. Devam etmek istiyor musunuz?',
			'currencies.exchange_rate_form.equal_to_preferred_warn' => 'Para birimi, kullanıcı para birimine eşit olamaz',
			'currencies.exchange_rate_form.override_existing_warn' => 'Bu tarihte bu para birimi için bir döviz kuru zaten mevcut. Devam ederseniz öncekinin üzerine yazılacak',
			'currencies.exchange_rate_form.specify_a_currency' => 'Lütfen bir para birimi belirtin',
			'currencies.exchange_rate_form.add' => 'Döviz kuru ekle',
			'currencies.exchange_rate_form.add_success' => 'Döviz kuru başarıyla eklendi',
			'currencies.exchange_rate_form.edit' => 'Döviz kurunu düzenle',
			'currencies.exchange_rate_form.edit_success' => 'Döviz kuru başarıyla düzenlendi',
			'currencies.exchange_rate_form.remove_all' => 'Tüm döviz kurlarını sil',
			'currencies.exchange_rate_form.remove_all_warning' => 'Bu işlem geri alınamaz ve bu para biriminin tüm döviz kurlarını silecektir',
			'currencies.types.display' => 'Para birimi türü',
			'currencies.types.fiat' => 'FIAT',
			'currencies.types.crypto' => 'Kripto para birimi',
			'currencies.types.other' => 'Diğer',
			'currencies.currency_form.name' => 'Ekran adı',
			'currencies.currency_form.code' => 'Para Birimi Kodu',
			'currencies.currency_form.symbol' => 'Sembol',
			'currencies.currency_form.decimal_digits' => 'Ondalık Basamaklar',
			'currencies.currency_form.create' => 'Para birimi oluştur',
			'currencies.currency_form.create_success' => 'Para birimi başarıyla oluşturuldu',
			'currencies.currency_form.edit' => 'Para birimini düzenle',
			'currencies.currency_form.edit_success' => 'Para birimi başarıyla düzenlendi',
			'currencies.currency_form.delete' => 'Para birimini sil',
			'currencies.currency_form.delete_success' => 'Para birimi başarıyla silindi',
			'currencies.currency_form.already_exists' => 'Bu koda sahip bir para birimi zaten mevcut. Düzenlemek isteyebilirsiniz',
			'currencies.delete_all_success' => 'Döviz kurları başarıyla silindi',
			'currencies.historical' => 'Geçmiş oranlar',
			'currencies.historical_empty' => 'Bu para birimi için geçmiş döviz kuru bulunamadı',
			'currencies.exchange_rate' => 'Döviz kuru',
			'currencies.exchange_rates' => 'Döviz kurları',
			'currencies.min_exchange_rate' => 'Asgari döviz kuru',
			'currencies.max_exchange_rate' => 'Maksimum döviz kuru',
			'currencies.empty' => 'Buraya döviz kurları ekleyin, böylece temel para biriminizden farklı para birimlerinde hesaplarınız varsa grafiklerimiz daha doğru olur',
			'currencies.select_a_currency' => 'Bir para birimi seçin',
			'currencies.search' => 'Adına veya para birimi koduna göre arayın',
			'tags.display' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Etiket', other: 'Etiketler', ), 
			'tags.form.name' => 'Etiket adı',
			'tags.form.name_hint' => 'Örn.: Yemek',
			'tags.form.forbidden_char_error' => 'Etiket adı \';\' içeremez',
			'tags.form.description' => 'Açıklama',
			'tags.select.title' => 'Etiketleri seçin',
			'tags.select.all' => 'Tüm etiketler',
			'tags.empty_list' => 'Henüz etiket oluşturmadınız. Etiketler ve kategoriler, hareketlerinizi kategorize etmek için harika bir yoldur',
			'tags.without_tags' => 'Etiketsiz',
			'tags.add' => 'Etiket ekle',
			'tags.create' => 'Etiket oluştur',
			'tags.create_success' => 'Etiket başarıyla oluşturuldu',
			'tags.already_exists' => 'Bu etiket adı zaten var. Düzenlemek isteyebilirsiniz',
			'tags.edit' => 'Etiketi düzenle',
			'tags.edit_success' => 'Etiket başarıyla düzenlendi',
			'tags.delete_success' => 'Kategori başarıyla silindi',
			'tags.delete_warning_header' => 'Etiket silinsin mi?',
			'tags.delete_warning_message' => 'Bu eylem bu etikete sahip işlemleri silmez.',
			'categories.unknown' => 'Bilinmeyen kategori',
			'categories.create' => 'Kategori oluştur',
			'categories.create_success' => 'Kategori başarıyla oluşturuldu',
			'categories.new_category' => 'Yeni kategori',
			'categories.already_exists' => 'Bu kategorinin adı zaten var. Belki düzenlemek istersiniz',
			'categories.edit' => 'Kategoriyi düzenle',
			'categories.edit_success' => 'Kategori başarıyla düzenlendi',
			'categories.name' => 'Kategori adı',
			'categories.type' => 'Kategori türü',
			'categories.both_types' => 'Her iki tür',
			'categories.subcategories' => 'Alt kategoriler',
			'categories.subcategories_add' => 'Alt kategori ekle',
			'categories.make_parent' => 'Kategoriye yap',
			'categories.make_child' => 'Alt kategori yap',
			'categories.make_child_warning1' => ({required Object destiny}) => 'Bu kategori ve alt kategorileri <b>${destiny}</b>\'nin alt kategorileri olacaktır.',
			'categories.make_child_warning2' => ({required Object x, required Object destiny}) => 'İşlemleri <b>(${x})</b>, <b>${destiny}</b> kategorisi içinde oluşturulan yeni alt kategorilere taşınacaktır.',
			'categories.make_child_success' => 'Alt kategoriler başarıyla oluşturuldu',
			'categories.merge' => 'Başka bir kategoriyle birleştir',
			'categories.merge_warning1' => ({required Object from, required Object x, required Object destiny}) => '<b>${from}</b> kategorisiyle ilişkili tüm işlemler (${x}), <b>${destiny}</b> kategorisine taşınacaktır.',
			'categories.merge_warning2' => ({required Object from}) => '<b>${from}</b> kategorisi geri dönüşü olmayacak şekilde silinecektir.',
			'categories.merge_success' => 'Kategori başarıyla birleştirildi',
			'categories.delete_success' => 'Kategori başarıyla silindi',
			'categories.delete_warning_header' => 'Kategori silinsin mi?',
			'categories.delete_warning_message' => ({required Object x}) => 'Bu eylem, bu kategoriyle ilgili tüm işlemleri <b>(${x})</b> geri dönüşü olmayacak şekilde silecektir.',
			'categories.select.title' => 'Kategori seçin',
			'categories.select.select_one' => 'Bir kategori seçin',
			'categories.select.select_subcategory' => 'Bir alt kategori seçin',
			'categories.select.without_subcategory' => 'Alt kategori olmadan',
			'categories.select.all' => 'Tüm kategoriler',
			'categories.select.all_short' => 'Tümü',
			'budgets.title' => 'Bütçeler',
			'budgets.status' => 'Bütçe durumu',
			'budgets.repeated' => 'Tekrarlayan',
			'budgets.one_time' => 'Tek seferlik',
			'budgets.actives' => 'Aktifler',
			'budgets.from_budgeted' => 'kalan ',
			'budgets.days_left' => 'gün kaldı',
			'budgets.days_to_start' => 'başlangıca kalan gün',
			'budgets.since_expiration' => 'son kullanma tarihinden itibaren',
			'budgets.no_budgets' => 'Bu bölümde görüntülenecek bütçe yok gibi görünüyor. Aşağıdaki düğmeyi tıklayarak bir bütçe oluşturmaya başlayın',
			'budgets.delete' => 'Bütçeyi sil',
			'budgets.delete_warning' => 'Bu eylem geri alınamaz. Bu bütçeye atıfta bulunan kategoriler ve işlemler silinmez',
			'budgets.form.title' => 'Bütçe ekle',
			'budgets.form.name' => 'Bütçe adı',
			'budgets.form.value' => 'Limit miktarı',
			'budgets.form.create' => 'Bütçe ekle',
			'budgets.form.create_success' => 'Bütçe başarıyla oluşturuldu',
			'budgets.form.edit' => 'Bütçeyi düzenle',
			'budgets.form.edit_success' => 'Bütçe başarıyla düzenlendi',
			'budgets.form.negative_warn' => 'Bütçeler negatif miktara sahip olamaz',
			'budgets.details.title' => 'Bütçe Detayları',
			'budgets.details.statistics' => 'İstatistikler',
			'budgets.details.budget_value' => 'Bütçelenen',
			'budgets.details.expend_evolution' => 'Harcama gelişimi',
			'budgets.details.no_transactions' => 'Bu bütçeyle ilgili herhangi bir harcama yapmamışsınız gibi görünüyor',
			'budgets.target_timeline_statuses.active' => 'Aktif bütçe',
			'budgets.target_timeline_statuses.past' => 'Tamamlanan bütçe',
			'budgets.target_timeline_statuses.future' => 'Gelecek bütçe',
			'budgets.progress.labels.active_on_track' => 'Yolunda',
			'budgets.progress.labels.active_overspending' => 'Aşırı harcama',
			'budgets.progress.labels.active_indeterminate' => 'Aktif',
			'budgets.progress.labels.success' => 'Başarılı',
			'budgets.progress.labels.fail' => 'Bütçe aşıldı',
			'budgets.progress.description.active_on_track' => ({required Object remainingDays, required Object dailyAmount}) => 'Kalan ${remainingDays} gün için günde ${dailyAmount} harcayabilirsiniz',
			'budgets.progress.description.active_overspending' => ({required Object remainingDays, required Object dailyAmount}) => 'Tekrar rayına oturmak için, kalan ${remainingDays} gün boyunca harcamalarınızı günde ${dailyAmount} ile sınırlamalısınız',
			'budgets.progress.description.active_indeterminate' => ({required Object amount}) => 'Harcayabileceğiniz ${amount} kaldı.',
			'budgets.progress.description.active_exceeded' => ({required Object amount}) => 'Bütçe limitinizi ${amount} aştınız. Bu bütçe için herhangi bir gelir bulamazsanız, dönemin geri kalanında harcama yapmayı bırakmalısınız',
			'budgets.progress.description.success' => 'Harika iş! Bu bütçe başarıyla tamamlandı. Harcamalarınızı yönetmek için bütçe oluşturmaya devam edin',
			'budgets.progress.description.fail' => ({required Object amount}) => 'Bütçeyi ${amount} aştınız. Bir dahaki sefere daha dikkatli olmaya çalışın!',
			'goals.title' => 'Hedefler',
			'goals.status' => 'Hedef durumu',
			'goals.type.display' => 'Hedef Türü',
			'goals.type.income.title' => 'Tasarruf Hedefi',
			'goals.type.income.descr' => 'Para biriktirmek için ideal. Bakiye hedefinizi aştığında başarılı olursunuz.',
			'goals.type.expense.title' => 'Harcama Hedefi',
			'goals.type.expense.descr' => 'Ne kadar harcadığınızı takip edin ve bir hedef tutara ulaşmayı amaçlayın. Bağışlar için ...',
			'goals.empty_title' => 'Hedef bulunamadı',
			'goals.empty_description' => 'Tasarruflarınızı takip etmek için yeni bir hedef oluşturun!',
			'goals.delete' => 'Hedefi sil',
			'goals.delete_warning' => 'Bu işlem geri alınamaz. Bu hedefi referans alan kategoriler ve işlemler silinmeyecektir',
			'goals.form.new_title' => 'Yeni Hedef',
			'goals.form.edit_title' => 'Hedefi Düzenle',
			_ => null,
		} ?? switch (path) {
			'goals.form.target_amount' => 'Hedef Tutar',
			'goals.form.initial_amount' => 'Başlangıç Tutarı',
			'goals.form.name' => 'İsim',
			'goals.form.name_hint' => 'Tasarruf Hedefim',
			'goals.form.create_success' => 'Hedef başarıyla oluşturuldu',
			'goals.form.edit_success' => 'Hedef başarıyla düzenlendi',
			'goals.form.negative_warn' => 'Hedef tutar negatif olamaz',
			'goals.details.title' => 'Hedef Detayları',
			'goals.details.statistics' => 'İstatistikler',
			'goals.details.goal_value' => 'Hedef Değeri',
			'goals.details.evolution' => 'Gelişim',
			'goals.details.no_transactions' => 'Bu hedefle ilgili herhangi bir işlem yapmamışsınız gibi görünüyor',
			'goals.target_timeline_statuses.active' => 'Aktif hedef',
			'goals.target_timeline_statuses.past' => 'Tamamlanmış hedef',
			'goals.target_timeline_statuses.future' => 'Gelecek hedef',
			'goals.progress.labels.active_on_track' => 'Yolda',
			'goals.progress.labels.active_behind_schedule' => 'Programın gerisinde',
			'goals.progress.labels.active_indeterminate' => 'Aktif',
			'goals.progress.labels.success' => 'Hedefe ulaşıldı',
			'goals.progress.labels.fail' => 'Hedef başarısız oldu',
			'goals.progress.description.active_on_track' => ({required Object remainingDays, required Object dailyAmount}) => 'Hedefinizi arama yolundasınız! Kalan ${remainingDays} gün boyunca günde ${dailyAmount} tasarruf etmelisiniz',
			'goals.progress.description.active_behind_schedule' => ({required Object remainingDays, required Object dailyAmount}) => 'Programın gerisindesiniz. Hedefinize ${remainingDays} gün içinde ulaşmak için günde ${dailyAmount} tasarruf etmeniz gerekiyor',
			'goals.progress.description.active_indeterminate' => ({required Object amount}) => 'Hedefinize ulaşmak için ${amount} daha fazlasına ihtiyacınız var.',
			'goals.progress.description.success' => 'Tebrikler! Hedefine ulaştın.',
			'goals.progress.description.fail' => ({required Object amount}) => 'Hedefinizi ${amount} kadar kaçırdınız.',
			'target_timeline_statuses.active' => 'Aktif',
			'target_timeline_statuses.past' => 'Tamamlandı',
			'target_timeline_statuses.future' => 'Gelecek',
			'backup.no_file_selected' => 'Hiçbir dosya seçilmedi',
			'backup.no_directory_selected' => 'Hiçbir dizin seçilmedi',
			'backup.export.title' => 'Verilerinizi dışa aktarın',
			'backup.export.title_short' => 'Dışa Aktar',
			'backup.export.type_of_export' => 'İhracat türü',
			'backup.export.other_options' => 'Seçenekler',
			'backup.export.all' => 'Tam yedekleme',
			'backup.export.all_descr' => 'Tüm verilerinizi (hesaplar, işlemler, bütçeler, ayarlar...) dışa aktarın. Herhangi bir şeyi kaybetmemek için bunları istediğiniz zaman tekrar içe aktarın.',
			'backup.export.transactions' => 'İşlemlerin yedeği',
			'backup.export.transactions_descr' => 'İşlemlerinizi CSV olarak dışa aktarın, böylece diğer programlarda veya uygulamalarda daha kolay analiz edebilirsiniz.',
			'backup.export.transactions_to_export' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n, one: 'Dışa aktarılacak 1 işlem', other: 'Dışa aktarılacak ${n} işlem', ), 
			'backup.export.description' => 'Verilerinizi farklı formatlarda indirin',
			'backup.export.send_file' => 'Dosyayı gönder',
			'backup.export.see_folder' => 'Klasöre bakın',
			'backup.export.success' => ({required Object x}) => 'Dosya ${x} olarak başarıyla kaydedildi/indirildi',
			'backup.export.error' => 'Dosya indirilirken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin',
			'backup.export.dialog_title' => 'Dosyayı Kaydet/Gönder',
			'backup.import.title' => 'Verilerinizi içe aktarın',
			'backup.import.title_short' => 'İçe Aktar',
			'backup.import.restore_backup' => 'Yedeklemeyi Geri Yükle',
			'backup.import.restore_backup_descr' => 'Monekin\'den daha önce kaydedilmiş bir veritabanını içe aktarın. Bu eylem, mevcut uygulama verilerinin herhangi birini yeni verilerle değiştirecektir',
			'backup.import.restore_backup_warn_description' => 'Yeni bir veritabanı içe aktarırken, uygulamada şu anda kayıtlı olan tüm verileri kaybedeceksiniz. Devam etmeden önce bir yedekleme yapmanız önerilir. Buraya, kaynağını bilmediğiniz herhangi bir dosyayı yüklemeyin, yalnızca daha önce Monekin\'den indirdiğiniz dosyaları yükleyin',
			'backup.import.restore_backup_warn_title' => 'Tüm verilerin üzerine yaz',
			'backup.import.select_other_file' => 'Başka dosya seç',
			'backup.import.tap_to_select_file' => 'Bir dosya seçmek için dokunun',
			'backup.import.manual_import.title' => 'Manuel içe aktarma',
			'backup.import.manual_import.descr' => 'İşlemleri manuel olarak .csv dosyasından içe aktarın',
			'backup.import.manual_import.default_account' => 'Varsayılan hesap',
			'backup.import.manual_import.remove_default_account' => 'Varsayılan hesabı kaldır',
			'backup.import.manual_import.default_category' => 'Varsayılan Kategori',
			'backup.import.manual_import.default_tags' => 'Varsayılan Etiketler',
			'backup.import.manual_import.select_a_column' => '.csv\'den bir sütun seçin',
			'backup.import.manual_import.date_format' => 'Tarih formatı',
			'backup.import.manual_import.note_column' => 'Not sütunu',
			'backup.import.manual_import.title_column' => 'Başlık sütunu',
			'backup.import.manual_import.tag_separator' => '.csv dosyasındaki etiket ayırıcı',
			'backup.import.manual_import.steps.0' => 'Dosyanızı seçin',
			'backup.import.manual_import.steps.1' => 'Miktar için sütun',
			'backup.import.manual_import.steps.2' => 'Hesap için sütun',
			'backup.import.manual_import.steps.3' => 'Kategori için sütun',
			'backup.import.manual_import.steps.4' => 'Etiket sütunu',
			'backup.import.manual_import.steps.5' => 'Tarih için sütun',
			'backup.import.manual_import.steps.6' => 'Diğer sütunlar',
			'backup.import.manual_import.steps_descr.0' => 'Cihazınızdan bir .csv dosyası seçin. Her sütunun adını açıklayan bir ilk satıra sahip olduğundan emin olun',
			'backup.import.manual_import.steps_descr.1' => 'Her işlemin değerinin belirtildiği sütunu seçin. Giderler için negatif değerler ve gelirler için pozitif değerler kullanın.',
			'backup.import.manual_import.steps_descr.2' => 'Her işlemin ait olduğu hesabın belirtildiği sütunu seçin. İstediğiniz hesabı bulamamamız durumunda varsayılan bir hesap da seçebilirsiniz. Varsayılan bir hesap belirtilmezse, aynı adla bir tane oluşturacağız',
			'backup.import.manual_import.steps_descr.3' => 'İşlem kategorisi adının bulunduğu sütunu belirtin. Kategoriyi bulamamamız durumunda işlemlere bu kategoriyi atayabilmemiz için varsayılan bir kategori belirtmeniz gerekir',
			'backup.import.manual_import.steps_descr.4' => 'İşlem etiketlerinin bulunduğu sütunu belirtin. Belirtilmediği takdirde, işlemler varsayılan etiketlerle oluşturulacaktır.',
			'backup.import.manual_import.steps_descr.5' => 'Her işlemin tarihinin belirtildiği sütunu seçin. Belirtilmezse, işlemler mevcut tarihle oluşturulacaktır',
			'backup.import.manual_import.steps_descr.6' => 'Diğer isteğe bağlı işlem öznitelikleri için sütunları belirtir',
			'backup.import.manual_import.success' => ({required Object x}) => '${x} işlem başarıyla içe aktarıldı',
			'backup.import.success' => 'İçe aktarma başarıyla gerçekleştirildi',
			'backup.import.error' => 'Dosya içe aktarılırken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin',
			'backup.import.cancelled' => 'İçe aktarma kullanıcı tarafından iptal edildi',
			'backup.about.title' => 'Veritabanınız hakkında bilgiler',
			'backup.about.create_date' => 'Oluşturulma tarihi',
			'backup.about.modify_date' => 'Son değiştirilme',
			'backup.about.last_backup' => 'Son yedekleme',
			'backup.about.size' => 'Boyut',
			'settings.title_long' => 'Ayarlar ve Özelleştirme',
			'settings.title_short' => 'Ayarlar',
			'settings.description' => 'Tema, Dil, Veriler ve daha fazlası',
			'settings.edit_profile' => 'Profili düzenle',
			'settings.general.menu_title' => 'Genel Ayarlar',
			'settings.general.menu_descr' => 'Dil, gizlilik ve daha fazlası',
			'settings.general.show_all_decimals' => 'Tüm ondalık basamakları göster',
			'settings.general.show_all_decimals_descr' => 'Sondaki sıfırlar olsa bile tüm ondalık basamakları göster',
			'settings.general.language.section' => 'Dil ve metinler',
			'settings.general.language.title' => 'Uygulama dili',
			'settings.general.language.descr' => 'Metinlerin uygulamada görüntüleneceği dil',
			'settings.general.language.help' => 'Bu uygulamanın çevirilerine katkıda bulunmak isterseniz, <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>kılavuzumuza</a> başvurabilirsiniz',
			'settings.general.locale.title' => 'Bölge',
			'settings.general.locale.auto' => 'Sistem',
			'settings.general.locale.descr' => 'Tarihler, sayılar için kullanılacak biçimi ayarlayın...',
			'settings.general.locale.warn' => 'Bölge değiştirildiğinde uygulama güncellenecektir',
			'settings.general.locale.first_day_of_week' => 'Haftanın ilk günü',
			'settings.security.title' => 'Güvenlik',
			'settings.security.private_mode_at_launch' => 'Başlangıçta özel mod',
			'settings.security.private_mode_at_launch_descr' => 'Uygulamayı varsayılan olarak özel modda başlatın',
			'settings.security.private_mode' => 'Özel mod',
			'settings.security.private_mode_descr' => 'Tüm parasal değerleri gizle',
			'settings.security.private_mode_activated' => 'Özel mod etkinleştirildi',
			'settings.security.private_mode_deactivated' => 'Özel mod devre dışı bırakıldı',
			'settings.transactions.menu_title' => 'İşlemler',
			'settings.transactions.menu_descr' => 'İşlemlerinizin davranışını yapılandırın',
			'settings.transactions.title' => 'İşlem Ayarları',
			'settings.transactions.style.title' => 'İşlem stili',
			'settings.transactions.style.subtitle' => 'İşlemlerin listelerde nasıl görüneceğini yapılandırın',
			'settings.transactions.style.show_tags' => 'Etiketleri Göster',
			'settings.transactions.style.show_time' => 'Saati Göster',
			'settings.transactions.swipe_actions.title' => 'Kaydırma eylemleri',
			'settings.transactions.swipe_actions.choose_description' => 'Bu kaydırma yönünü kullanarak listedeki bir işlem öğesini kaydırdığınızda hangi eylemin tetikleneceğini seçin',
			'settings.transactions.swipe_actions.swipe_left' => 'Sola kaydırın',
			'settings.transactions.swipe_actions.swipe_right' => 'Sağa kaydırın',
			'settings.transactions.swipe_actions.none' => 'Eylem yok',
			'settings.transactions.swipe_actions.toggle_reconciled' => 'Mutabık kılınmayı aç/kapat',
			'settings.transactions.swipe_actions.toggle_pending' => 'Beklemede\'yi aç/kapat',
			'settings.transactions.swipe_actions.toggle_voided' => 'Geçiş iptal edildi',
			'settings.transactions.swipe_actions.toggle_unreconciled' => 'Mutabık kılınmayanları aç/kapat',
			'settings.transactions.swipe_actions.remove_status' => 'Durumu kaldır',
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
			'settings.appearance.menu_title' => 'Tema ve Stil',
			'settings.appearance.menu_descr' => 'Tema seçimi, renkler ve uygulama görünümüyle ilgili diğer şeyler',
			'settings.appearance.theme_and_colors' => 'Tema ve renkler',
			'settings.appearance.theme.title' => 'Tema',
			'settings.appearance.theme.auto' => 'Sistem',
			'settings.appearance.theme.light' => 'Açık',
			'settings.appearance.theme.dark' => 'Koyu',
			'settings.appearance.amoled_mode' => 'AMOLED modu',
			'settings.appearance.amoled_mode_descr' => 'Mümkün olduğunda saf siyah bir duvar kağıdı kullanın. Bu, AMOLED ekranlara sahip cihazların pili için biraz yardımcı olacaktır',
			'settings.appearance.dynamic_colors' => 'Dinamik renkler',
			'settings.appearance.dynamic_colors_descr' => 'Mümkün olduğunda sistem vurgu renginizi kullanın',
			'settings.appearance.accent_color' => 'Vurgu rengi',
			'settings.appearance.accent_color_descr' => 'Uygulamanın arayüzün belirli kısımlarını vurgulamak için kullanacağı rengi seçin',
			'settings.appearance.text' => 'Metin',
			'settings.appearance.font' => 'Yazı tipi',
			'settings.appearance.font_platform' => 'platformu',
			'more.title' => 'Daha Fazla',
			'more.title_long' => 'Daha fazla eylem',
			'more.data.display' => 'Veri',
			'more.data.display_descr' => 'Hiçbir şeyi kaybetmemek için verilerinizi dışa ve içe aktarın',
			'more.data.delete_all' => 'Verilerimi sil',
			'more.data.delete_all_header1' => 'Orada dur padawan ⚠️⚠️',
			'more.data.delete_all_message1' => 'Devam etmek istediğinizden emin misiniz? Tüm verileriniz kalıcı olarak silinecek ve kurtarılamayacaktır',
			'more.data.delete_all_header2' => 'Son bir adım ⚠️⚠️',
			'more.data.delete_all_message2' => 'Bir hesabı sildiğinizde, kayıtlı tüm kişisel verilerinizi silmiş olursunuz. Hesaplarınız, işlemleriniz, bütçeleriniz ve kategorileriniz silinecek ve kurtarılamayacaktır. Kabul ediyor musunuz?',
			'more.about_us.display' => 'Uygulama bilgileri',
			'more.about_us.description' => 'Monekin\'in şartlarını, önemli bilgilerini bulun ve hata bildirerek veya fikir paylaşımları ile iletişime geçin',
			'more.about_us.legal.display' => 'Yasal bilgiler',
			'more.about_us.legal.privacy' => 'Gizlilik politikası',
			'more.about_us.legal.terms' => 'Kullanım koşulları',
			'more.about_us.legal.licenses' => 'Lisanslar',
			'more.about_us.project.display' => 'Proje',
			'more.about_us.project.contributors' => 'Katkıda bulunanlar',
			'more.about_us.project.contributors_descr' => 'Monekin\'in büyümesini sağlayan tüm geliştiriciler',
			'more.about_us.project.contact' => 'Bize ulaşın',
			'more.help_us.display' => 'Bize yardım edin',
			'more.help_us.description' => 'Monekin\'in nasıl daha iyi olabileceğini öğrenin',
			'more.help_us.rate_us' => 'Bize oy verin',
			'more.help_us.rate_us_descr' => 'Herhangi bir puan memnuniyetle karşılanır!',
			'more.help_us.share' => 'Monekin\'i paylaşın',
			'more.help_us.share_descr' => 'Uygulamamızı arkadaşlarınıza ve ailenize paylaşın',
			'more.help_us.share_text' => 'Monekin! En iyi kişisel finans uygulaması. Buradan indirin',
			'more.help_us.thanks' => 'Teşekkürler!',
			'more.help_us.thanks_long' => 'Monekin\'e ve diğer açık kaynaklı projelere yaptığınız katkılar, büyük ve küçük, bunun gibi harika projeleri mümkün kılıyor. Katkıda bulunmak için zaman ayırdığınız için teşekkür ederiz.',
			'more.help_us.donate' => 'Bağış yap',
			'more.help_us.donate_descr' => 'Bağışınızla uygulamanın iyileştirmeler almaya devam etmesine yardımcı olacaksınız. Yapılan çalışmaya kahve ısmarlayarak teşekkür etmekten daha iyi bir yol mu var?',
			'more.help_us.donate_success' => 'Bağış yapıldı. Katkılarınız için çok teşekkür ederim! ❤️',
			'more.help_us.donate_err' => 'Ups! Ödemenizi alırken bir hata oluştu gibi görünüyor',
			'more.help_us.report' => 'Hataları bildirin, önerilerde bulunun...',
			_ => null,
		};
	}
}

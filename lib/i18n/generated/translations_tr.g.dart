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
class TranslationsTr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
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
	@override String get details => 'Detaylar';
	@override String get share => 'Paylaş';
  @override String get none => 'Hiç kimse';
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
	@override String get balance => 'Bakiye';
	@override String get account => 'Hesap';
	@override String get accounts => 'Hesaplar';
	@override String get categories => 'Kategoriler';
	@override String get category => 'Kategori';
	@override String get today => 'Bugün';
	@override String get yesterday => 'Dün';
	@override String get filters => 'Filtreler';
	@override String get empty_warn => 'Ups! Burası çok boş';
	@override String get insufficient_data => 'Yetersiz veri';
	@override String get show_more_fields => 'Daha fazla alan göster';
	@override String get show_less_fields => 'Daha az alan göster';
	@override String get tap_to_search => 'Aramak için dokunun';
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
	@override String get currency_manager => 'Para birimi yöneticisi';
	@override String get currency_manager_descr => 'Para biriminizi ve diğerleriyle döviz kurlarını yapılandırın';
	@override String get preferred_currency => 'Tercih edilen/temel para birimi';
	@override String get change_preferred_currency_title => 'Tercih edilen para birimini değiştir';
	@override String get change_preferred_currency_msg => 'Tüm istatistikler ve bütçeler bundan sonra bu para biriminde görüntülenecektir. Hesaplar ve işlemler sahip oldukları para birimini koruyacaktır. Bu eylemi gerçekleştirirseniz, kaydedilen tüm döviz kurları silinecektir. Devam etmek istiyor musunuz?';
	@override late final _TranslationsCurrenciesFormTr form = _TranslationsCurrenciesFormTr._(_root);
	@override String get delete_all_success => 'Döviz kurları başarıyla silindi';
	@override String get historical => 'Geçmiş oranlar';
	@override String get exchange_rate => 'Döviz kuru';
	@override String get exchange_rates => 'Döviz kurları';
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
	@override String get repeated => 'Tekrarlayan';
	@override String get one_time => 'Tek seferlik';
	@override String get annual => 'Yıllık';
	@override String get week => 'Haftalık';
	@override String get month => 'Aylık';
	@override String get actives => 'Aktifler';
	@override String get pending => 'Başlangıcı Bekliyor';
	@override String get finish => 'Bitti';
	@override String get from_budgeted => 'kalan ';
	@override String get days_left => 'gün kaldı';
	@override String get days_to_start => 'başlangıca kalan gün';
	@override String get since_expiration => 'son kullanma tarihinden itibaren';
	@override String get no_budgets => 'Bu bölümde görüntülenecek bütçe yok gibi görünüyor. Aşağıdaki düğmeyi tıklayarak bir bütçe oluşturmaya başlayın';
	@override String get delete => 'Bütçeyi sil';
	@override String get delete_warning => 'Bu eylem geri alınamaz. Bu bütçeye atıfta bulunan kategoriler ve işlemler silinmez';
	@override late final _TranslationsBudgetsFormTr form = _TranslationsBudgetsFormTr._(_root);
	@override late final _TranslationsBudgetsDetailsTr details = _TranslationsBudgetsDetailsTr._(_root);
}

// Path: backup
class _TranslationsBackupTr implements TranslationsBackupEn {
	_TranslationsBackupTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBackupExportTr export = _TranslationsBackupExportTr._(_root);
	@override late final _TranslationsBackupImportTr import = _TranslationsBackupImportTr._(_root);
	@override late final _TranslationsBackupAboutTr about = _TranslationsBackupAboutTr._(_root);
}

// Path: settings
class _TranslationsSettingsTr implements TranslationsSettingsEn {
	_TranslationsSettingsTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title_long => 'Ayarlar ve görünüm';
	@override String get title_short => 'Ayarlar';
	@override String get description => 'Uygulama teması, metinler ve diğer genel ayarlar';
	@override String get edit_profile => 'Profili düzenle';
	@override String get lang_section => 'Dil ve metinler';
	@override String get lang_title => 'Uygulama dili';
	@override String get lang_descr => 'Metinlerin uygulamada görüntüleneceği dil';
	@override String get lang_help => 'Bu uygulamanın çevirilerine katkıda bulunmak isterseniz, <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>kılavuzumuza</a> başvurabilirsiniz';
	@override String get locale => 'Bölge';
	@override String get locale_descr => 'Tarihler, sayılar için kullanılacak biçimi ayarlayın...';
	@override String get locale_warn => 'Bölge değiştirildiğinde uygulama güncellenecektir';
	@override String get first_day_of_week => 'Haftanın ilk günü';
	@override String get theme_and_colors => 'Tema ve renkler';
	@override String get theme => 'Tema';
	@override String get theme_auto => 'Sistem';
	@override String get theme_light => 'Açık';
	@override String get theme_dark => 'Koyu';
	@override String get amoled_mode => 'AMOLED modu';
	@override String get amoled_mode_descr => 'Mümkün olduğunda saf siyah bir duvar kağıdı kullanın. Bu, AMOLED ekranlara sahip cihazların pili için biraz yardımcı olacaktır';
	@override String get dynamic_colors => 'Dinamik renkler';
	@override String get dynamic_colors_descr => 'Mümkün olduğunda sistem vurgu renginizi kullanın';
	@override String get accent_color => 'Vurgu rengi';
	@override String get accent_color_descr => 'Uygulamanın arayüzün belirli kısımlarını vurgulamak için kullanacağı rengi seçin';
	@override late final _TranslationsSettingsSecurityTr security = _TranslationsSettingsSecurityTr._(_root);
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
	@override String get from_value => 'Miktardan';
	@override String get to_value => 'Miktara kadar';
	@override String from_value_def({required Object x}) => '${x} dan';
	@override String to_value_def({required Object x}) => '${x} a kadar';
	@override String from_date_def({required Object date}) => '${date} tarihinden';
	@override String to_date_def({required Object date}) => '${date} tarihine kadar';
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

// Path: currencies.form
class _TranslationsCurrenciesFormTr implements TranslationsCurrenciesFormEn {
	_TranslationsCurrenciesFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get equal_to_preferred_warn => 'Para birimi, kullanıcı para birimine eşit olamaz';
	@override String get specify_a_currency => 'Lütfen bir para birimi belirtin';
	@override String get add => 'Döviz kuru ekle';
	@override String get add_success => 'Döviz kuru başarıyla eklendi';
	@override String get edit => 'Döviz kurunu düzenle';
	@override String get edit_success => 'Döviz kuru başarıyla düzenlendi';
}

// Path: tags.form
class _TranslationsTagsFormTr implements TranslationsTagsFormEn {
	_TranslationsTagsFormTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Etiket adı';
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
	@override String get edit => 'Bütçeyi düzenle';
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
	@override String expend_diary_left({required Object remainingDays, required Object dailyAmount}) => '${remainingDays} kalan gün için günde ${dailyAmount} harcayabilirsiniz';
	@override String get expend_evolution => 'Harcama gelişimi';
	@override String get no_transactions => 'Bu bütçeyle ilgili herhangi bir harcama yapmamışsınız gibi görünüyor';
}

// Path: backup.export
class _TranslationsBackupExportTr implements TranslationsBackupExportEn {
	_TranslationsBackupExportTr._(this._root);

	final TranslationsTr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verilerinizi dışa aktarın';
	@override String get title_short => 'Dışa Aktar';
	@override String get all => 'Tam yedekleme';
	@override String get all_descr => 'Tüm verilerinizi (hesaplar, işlemler, bütçeler, ayarlar...) dışa aktarın. Herhangi bir şeyi kaybetmemek için bunları istediğiniz zaman tekrar içe aktarın.';
	@override String get transactions => 'İşlemlerin yedeği';
	@override String get transactions_descr => 'İşlemlerinizi CSV olarak dışa aktarın, böylece diğer programlarda veya uygulamalarda daha kolay analiz edebilirsiniz.';
	@override String get description => 'Verilerinizi farklı formatlarda indirin';
	@override String get dialog_title => 'Dosyayı Kaydet/Gönder';
	@override String success({required Object x}) => 'Dosya ${x} olarak başarıyla kaydedildi/indirildi';
	@override String get error => 'Dosya indirilirken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin';
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
	@override String get cancelled => 'İçe aktarma kullanıcı tarafından iptal edildi';
	@override String get error => 'Dosya içe aktarılırken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin';
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
	@override String get description => 'Monekin hakkında şartları ve diğer ilgili bilgileri inceleyin. Hata bildirerek, önerilerde bulunarak toplulukla etkileşime geçin...';
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
	@override String get select_a_column => '.csv\'den bir sütun seçin';
	@override List<String> get steps => [
		'Dosyanızı seçin',
		'Miktar için sütun',
		'Hesap için sütun',
		'Kategori için sütun',
		'Tarih için sütun',
		'diğer sütunlar',
	];
	@override List<String> get steps_descr => [
		'Cihazınızdan bir .csv dosyası seçin. Her sütunun adını açıklayan bir ilk satıra sahip olduğundan emin olun',
		'Her işlemin değerinin belirtildiği sütunu seçin. Giderler için negatif değerler ve gelirler için pozitif değerler kullanın. Ondalık ayırıcı olarak nokta kullanın',
		'Her işlemin ait olduğu hesabın belirtildiği sütunu seçin. İstediğiniz hesabı bulamamamız durumunda varsayılan bir hesap da seçebilirsiniz. Varsayılan bir hesap belirtilmezse, aynı adla bir tane oluşturacağız',
		'İşlem kategorisi adının bulunduğu sütunu belirtin. Kategoriyi bulamamamız durumunda işlemlere bu kategoriyi atayabilmemiz için varsayılan bir kategori belirtmeniz gerekir',
		'Her işlemin tarihinin belirtildiği sütunu seçin. Belirtilmezse, işlemler mevcut tarihle oluşturulacaktır',
		'Diğer isteğe bağlı işlem öznitelikleri için sütunları belirtir',
	];
	@override String success({required Object x}) => '${x} işlem başarıyla içe aktarıldı';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsTr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ui_actions.cancel': return 'İptal';
			case 'ui_actions.confirm': return 'Onayla';
			case 'ui_actions.continue_text': return 'Devam Et';
			case 'ui_actions.save': return 'Kaydet';
			case 'ui_actions.save_changes': return 'Değişiklikleri Kaydet';
			case 'ui_actions.close_and_save': return 'Kaydet ve Kapat';
			case 'ui_actions.add': return 'Ekle';
			case 'ui_actions.edit': return 'Düzenle';
			case 'ui_actions.delete': return 'Sil';
			case 'ui_actions.see_more': return 'Daha Fazla Gör';
			case 'ui_actions.select_all': return 'Tümünü Seç';
			case 'ui_actions.deselect_all': return 'Tüm Seçimi Kaldır';
			case 'ui_actions.select': return 'Seç';
			case 'ui_actions.search': return 'Ara';
			case 'ui_actions.filter': return 'Filtrele';
			case 'ui_actions.reset': return 'Sıfırla';
			case 'ui_actions.submit': return 'Gönder';
			case 'ui_actions.next': return 'Sonraki';
			case 'ui_actions.previous': return 'Önceki';
			case 'ui_actions.back': return 'Geri';
			case 'ui_actions.reload': return 'Yenile';
			case 'ui_actions.view': return 'Görüntüle';
			case 'ui_actions.download': return 'İndir';
			case 'ui_actions.upload': return 'Yükle';
			case 'ui_actions.retry': return 'Tekrar Dene';
			case 'ui_actions.copy': return 'Kopyala';
			case 'ui_actions.paste': return 'Yapıştır';
			case 'ui_actions.undo': return 'Geri Al';
			case 'ui_actions.redo': return 'İleri Al';
			case 'ui_actions.open': return 'Aç';
			case 'ui_actions.close': return 'Kapat';
			case 'ui_actions.apply': return 'Uygula';
			case 'ui_actions.discard': return 'Vazgeç';
			case 'ui_actions.refresh': return 'Yenile';
			case 'ui_actions.details': return 'Detaylar';
			case 'ui_actions.share': return 'Paylaş';
			case 'general.or': return 'veya';
			case 'general.understood': return 'Anlaşıldı';
			case 'general.unspecified': return 'Belirtilmemiş';
			case 'general.quick_actions': return 'Hızlı İşlemler';
			case 'general.balance': return 'Bakiye';
			case 'general.account': return 'Hesap';
			case 'general.accounts': return 'Hesaplar';
			case 'general.categories': return 'Kategoriler';
			case 'general.category': return 'Kategori';
			case 'general.today': return 'Bugün';
			case 'general.yesterday': return 'Dün';
			case 'general.filters': return 'Filtreler';
			case 'general.empty_warn': return 'Ups! Burası çok boş';
			case 'general.insufficient_data': return 'Yetersiz veri';
			case 'general.show_more_fields': return 'Daha fazla alan göster';
			case 'general.show_less_fields': return 'Daha az alan göster';
			case 'general.tap_to_search': return 'Aramak için dokunun';
			case 'general.clipboard.success': return ({required Object x}) => '${x} panoya kopyalandı';
			case 'general.clipboard.error': return 'Kopyalama hatası';
			case 'general.time.start_date': return 'Başlangıç tarihi';
			case 'general.time.end_date': return 'Bitiş tarihi';
			case 'general.time.from_date': return 'Başlangıç tarihi';
			case 'general.time.until_date': return 'Bitiş tarihi';
			case 'general.time.date': return 'Tarih';
			case 'general.time.datetime': return 'Tarih ve saat';
			case 'general.time.time': return 'Saat';
			case 'general.time.each': return 'Her';
			case 'general.time.after': return 'Sonra';
			case 'general.time.ranges.display': return 'Zaman aralığı';
			case 'general.time.ranges.it_repeat': return 'Tekrarlar';
			case 'general.time.ranges.it_ends': return 'Biter';
			case 'general.time.ranges.forever': return 'Sonsuza kadar';
			case 'general.time.ranges.types.cycle': return 'Döngüler';
			case 'general.time.ranges.types.last_days': return 'Son günler';
			case 'general.time.ranges.types.last_days_form': return ({required Object x}) => 'Önceki ${x} gün';
			case 'general.time.ranges.types.all': return 'Her Zaman';
			case 'general.time.ranges.types.date_range': return 'Özel aralık';
			case 'general.time.ranges.each_range': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Her ${range}',
				other: 'Her ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_date': return ({required num n, required Object day, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: '${day} tarihine kadar her ${range}',
				other: '${day} tarihine kadar her ${n} ${range}',
			);
			case 'general.time.ranges.each_range_until_times': return ({required num n, required Object range, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Her ${range} ${limit} kez',
				other: 'Her ${n} ${range} ${limit} kez',
			);
			case 'general.time.ranges.each_range_until_once': return ({required num n, required Object range}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Her ${range} bir kez',
				other: 'Her ${n} ${range} bir kez',
			);
			case 'general.time.ranges.month': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Ay',
				other: 'Aylar',
			);
			case 'general.time.ranges.year': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Yıl',
				other: 'Yıllar',
			);
			case 'general.time.ranges.day': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Gün',
				other: 'Günler',
			);
			case 'general.time.ranges.week': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Hafta',
				other: 'Haftalar',
			);
			case 'general.time.periodicity.display': return 'Tekrarlama';
			case 'general.time.periodicity.no_repeat': return 'Tekrarlama yok';
			case 'general.time.periodicity.repeat': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Tekrar',
				other: 'Tekrarlar',
			);
			case 'general.time.periodicity.diary': return 'Günlük';
			case 'general.time.periodicity.monthly': return 'Aylık';
			case 'general.time.periodicity.annually': return 'Yıllık';
			case 'general.time.periodicity.quaterly': return 'Üç Aylık';
			case 'general.time.periodicity.weekly': return 'Haftalık';
			case 'general.time.periodicity.custom': return 'Özel';
			case 'general.time.periodicity.infinite': return 'Her Zaman';
			case 'general.time.current.monthly': return 'Bu ay';
			case 'general.time.current.annually': return 'Bu yıl';
			case 'general.time.current.quaterly': return 'Bu çeyrek';
			case 'general.time.current.weekly': return 'Bu hafta';
			case 'general.time.current.infinite': return 'Sonsuza dek';
			case 'general.time.current.custom': return 'Özel Aralık';
			case 'general.time.all.diary': return 'Her gün';
			case 'general.time.all.monthly': return 'Her ay';
			case 'general.time.all.annually': return 'Her yıl';
			case 'general.time.all.quaterly': return 'Her çeyrek';
			case 'general.time.all.weekly': return 'Her hafta';
			case 'general.transaction_order.display': return 'İşlemleri sırala';
			case 'general.transaction_order.category': return 'Kategoriye göre';
			case 'general.transaction_order.quantity': return 'Miktara göre';
			case 'general.transaction_order.date': return 'Tarihe göre';
			case 'general.validations.form_error': return 'Devam etmek için belirtilen alanları düzeltin';
			case 'general.validations.required': return 'Gerekli alan';
			case 'general.validations.positive': return 'Pozitif olmalı';
			case 'general.validations.min_number': return ({required Object x}) => '${x} değerinden büyük olmalı';
			case 'general.validations.max_number': return ({required Object x}) => '${x} değerinden küçük olmalı';
			case 'intro.start': return 'Başla';
			case 'intro.skip': return 'Atla';
			case 'intro.next': return 'İleri';
			case 'intro.select_your_currency': return 'Para birimini seçin';
			case 'intro.welcome_subtitle': return 'Kişisel finans yöneticiniz';
			case 'intro.welcome_subtitle2': return '%100 açık, %100 ücretsiz';
			case 'intro.welcome_footer': return 'Giriş yaparak, uygulamanın <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md\'>Gizlilik Politikası</a> ve <a href=\'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md\'>Kullanım Şartları</a>\'nı kabul etmiş olursunuz';
			case 'intro.offline_descr_title': return 'ÇEVRİMDIŞI HESAP:';
			case 'intro.offline_descr': return 'Verileriniz yalnızca cihazınızda saklanacak ve uygulamayı kaldırmadığınız veya telefon değiştirmediniz sürece güvende olacaktır. Veri kaybını önlemek için, uygulama ayarlarından düzenli olarak yedekleme yapılması önerilir.';
			case 'intro.offline_start': return 'Çevrimdışı oturum başlat';
			case 'intro.sl1_title': return 'Para birimini seçin';
			case 'intro.sl1_descr': return 'Varsayılan para biriminiz raporlarda ve genel grafiklerde kullanılacaktır. Uygulama ayarlarından daha sonra istediğiniz zaman para birimini ve uygulama dilini değiştirebileceksiniz';
			case 'intro.sl2_title': return 'Güvenli, gizli ve güvenilir';
			case 'intro.sl2_descr': return 'Verileriniz yalnızca size aittir. Bilgileri harici sunuculara gitmeden doğrudan cihazınızda saklarız. Bu, uygulamayı internet olmadan bile kullanmayı mümkün kılar';
			case 'intro.sl2_descr2': return 'Ayrıca, uygulamanın kaynak kodu herkese açıktır, herkes üzerinde işbirliği yapabilir ve nasıl çalıştığını görebilir';
			case 'intro.last_slide_title': return 'Her şey hazır';
			case 'intro.last_slide_descr': return 'Monekin ile sonunda çok istediğiniz finansal bağımsızlığa ulaşabilirsiniz. Paranız hakkında grafiklere, bütçelere, ipuçlarına, istatistiklere ve çok daha fazlasına sahip olacaksınız.';
			case 'intro.last_slide_descr2': return 'Umarız deneyiminizden keyif alırsınız! Şüpheleriniz, önerileriniz durumunda bizimle iletişime geçmekten çekinmeyin...';
			case 'home.title': return 'Gösterge Paneli';
			case 'home.filter_transactions': return 'İşlemleri filtrele';
			case 'home.hello_day': return 'Günaydın,';
			case 'home.hello_night': return 'İyi geceler,';
			case 'home.total_balance': return 'Toplam bakiye';
			case 'home.my_accounts': return 'Hesaplarım';
			case 'home.active_accounts': return 'Aktif hesaplar';
			case 'home.no_accounts': return 'Henüz hesap oluşturulmadı';
			case 'home.no_accounts_descr': return 'Monekin\'in tüm sihrini kullanmaya başlayın. İşlem eklemeye başlamak için en az bir hesap oluşturun';
			case 'home.last_transactions': return 'Son işlemler';
			case 'home.should_create_account_header': return 'Ups!';
			case 'home.should_create_account_message': return 'İşlem oluşturmaya başlamadan önce en az bir arşivlenmemiş hesabınız olmalıdır';
			case 'financial_health.display': return 'Finansal sağlık';
			case 'financial_health.review.very_good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Çok iyi!';
					case GenderContext.female:
						return 'Çok iyi!';
				}
			};
			case 'financial_health.review.good': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'İyi';
					case GenderContext.female:
						return 'İyi';
				}
			};
			case 'financial_health.review.normal': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Ortalama';
					case GenderContext.female:
						return 'Ortalama';
				}
			};
			case 'financial_health.review.bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Fena';
					case GenderContext.female:
						return 'Fena';
				}
			};
			case 'financial_health.review.very_bad': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Çok Kötü';
					case GenderContext.female:
						return 'Çok Kötü';
				}
			};
			case 'financial_health.review.insufficient_data': return ({required GenderContext context}) {
				switch (context) {
					case GenderContext.male:
						return 'Yetersiz veri';
					case GenderContext.female:
						return 'Yetersiz veri';
				}
			};
			case 'financial_health.review.descr.insufficient_data': return 'Finansal sağlığınızı hesaplamak için yeterli giderimiz yok gibi görünüyor. Size yardımcı olmamıza izin vermek için bu dönemde bazı giderler/gelirler ekleyin!';
			case 'financial_health.review.descr.very_good': return 'Tebrikler! Finansal sağlığınız muazzam. İyi gidişatınızı sürdürmenizi ve Monekin ile öğrenmeye devam etmenizi umuyoruz';
			case 'financial_health.review.descr.good': return 'Harika! Finansal sağlığınız iyi. Daha da fazla nasıl tasarruf edebileceğinizi görmek için analiz sekmesini ziyaret edin!';
			case 'financial_health.review.descr.normal': return 'Finansal sağlığınız bu dönem için nüfusun geri kalanının ortalamasına az çok eşit';
			case 'financial_health.review.descr.bad': return 'Görünüşe göre mali durumunuz henüz en iyi seviyede değil. Finanslarınız hakkında daha fazla bilgi edinmek için grafiklerin geri kalanını inceleyin';
			case 'financial_health.review.descr.very_bad': return 'Hmm, finansal sağlığınız olması gerekenden çok düşük. Finanslarınız hakkında daha fazla bilgi edinmek için grafiklerin geri kalanını inceleyin';
			case 'financial_health.months_without_income.title': return 'Hayatta kalma oranı';
			case 'financial_health.months_without_income.subtitle': return 'Bakiyeniz göz önüne alındığında, gelirsiz kalabileceğiniz süre';
			case 'financial_health.months_without_income.text_zero': return 'Bu gider oranında gelirsiz bir ay bile dayanamazsınız!';
			case 'financial_health.months_without_income.text_one': return 'Bu gider oranında yaklaşık bir ay gelirsiz yaşayabilirsiniz!';
			case 'financial_health.months_without_income.text_other': return ({required Object n}) => 'Bu harcama oranında yaklaşık <b>${n} ay</b> gelir olmadan yaşayabilirsiniz.';
			case 'financial_health.months_without_income.text_infinite': return 'Bu harcama oranında yaklaşık <b>tüm hayatınız boyunca</b> gelir olmadan yaşayabilirsiniz.';
			case 'financial_health.months_without_income.suggestion': return 'Bu oranın her zaman en az 5 ayın üzerinde tutulması gerektiğini unutmayın. Yeterli birikiminiz olmadığını görürseniz, gereksiz harcamaları azaltın.';
			case 'financial_health.months_without_income.insufficient_data': return 'Gelirsiz kaç ay hayatta kalabileceğinizi hesaplamak için yeterli giderimiz yok gibi görünüyor. Birkaç işlem girin ve finansal sağlığınızı kontrol etmek için buraya geri gelin';
			case 'financial_health.savings_percentage.title': return 'Tasarruf yüzdesi';
			case 'financial_health.savings_percentage.subtitle': return 'Gelirinizin ne kadarı bu dönemde harcanmıyor';
			case 'financial_health.savings_percentage.text.good': return ({required Object value}) => 'Tebrikler! Bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız. Görünüşe göre zaten bir uzmansınız, iyi iş çıkarmaya devam edin!';
			case 'financial_health.savings_percentage.text.normal': return ({required Object value}) => 'Tebrikler, bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız.';
			case 'financial_health.savings_percentage.text.bad': return ({required Object value}) => 'Bu dönemde gelirinizin <b>${value}%</b>\'sini tasarruf etmeyi başardınız. Ancak, hala çok daha fazlasını yapabileceğinizi düşünüyoruz!';
			case 'financial_health.savings_percentage.text.very_bad': return 'Vay canına, bu dönemde hiçbir şey biriktirmeyi başaramadınız.';
			case 'financial_health.savings_percentage.suggestion': return 'Kazandığınızın en az %15-20\'sini biriktirmenin tavsiye edildiğini unutmayın.';
			case 'stats.title': return 'İstatistikler';
			case 'stats.balance': return 'Bakiye';
			case 'stats.final_balance': return 'Son bakiye';
			case 'stats.balance_by_account': return 'Hesaplara göre bakiye';
			case 'stats.balance_by_account_subtitle': return 'Paramın çoğunu nerede tutuyorum?';
			case 'stats.balance_by_currency': return 'Para birimine göre bakiye';
			case 'stats.balance_by_currency_subtitle': return 'Yabancı para biriminde ne kadar param var?';
			case 'stats.balance_evolution': return 'Bakiye trendi';
			case 'stats.balance_evolution_subtitle': return 'Eskisinden daha çok param var mı?';
			case 'stats.compared_to_previous_period': return 'Önceki döneme göre';
			case 'stats.cash_flow': return 'Nakit akışı';
			case 'stats.cash_flow_subtitle': return 'Kazandığımdan daha az mı harcıyorum?';
			case 'stats.by_periods': return 'Dönemlere göre';
			case 'stats.by_categories': return 'Kategorilere göre';
			case 'stats.by_tags': return 'Etiketlere göre';
			case 'stats.distribution': return 'Dağıtım';
			case 'stats.finance_health_resume': return 'Özet';
			case 'stats.finance_health_breakdown': return 'Detaylı Analiz';
			case 'icon_selector.name': return 'İsim:';
			case 'icon_selector.icon': return 'İkon';
			case 'icon_selector.color': return 'Renk';
			case 'icon_selector.select_icon': return 'Bir ikon seçin';
			case 'icon_selector.select_color': return 'Bir renk seçin';
			case 'icon_selector.custom_color': return 'Özel renk';
			case 'icon_selector.current_color_selection': return 'Mevcut seçim';
			case 'icon_selector.select_account_icon': return 'Hesabınızı tanımlayın';
			case 'icon_selector.select_category_icon': return 'Kategorinizi tanımlayın';
			case 'icon_selector.scopes.transport': return 'Ulaşım';
			case 'icon_selector.scopes.money': return 'Para';
			case 'icon_selector.scopes.food': return 'Gıda';
			case 'icon_selector.scopes.medical': return 'Sağlık';
			case 'icon_selector.scopes.entertainment': return 'Eğlence';
			case 'icon_selector.scopes.technology': return 'Teknoloji';
			case 'icon_selector.scopes.other': return 'Diğerleri';
			case 'icon_selector.scopes.logos_financial_institutions': return 'Finans kuruluşları';
			case 'transaction.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'İşlem',
				other: 'İşlemler',
			);
			case 'transaction.create': return 'Yeni işlem';
			case 'transaction.new_income': return 'Yeni gelir';
			case 'transaction.new_expense': return 'Yeni gider';
			case 'transaction.new_success': return 'İşlem başarıyla oluşturuldu';
			case 'transaction.edit': return 'İşlemi düzenle';
			case 'transaction.edit_success': return 'İşlem başarıyla düzenlendi';
			case 'transaction.edit_multiple': return 'İşlemleri düzenle';
			case 'transaction.edit_multiple_success': return ({required Object x}) => '${x} işlem başarıyla düzenlendi';
			case 'transaction.duplicate': return 'İşlemi kopyala';
			case 'transaction.duplicate_short': return 'Kopyala';
			case 'transaction.duplicate_warning_message': return 'Aynısı olan bir işlem bu tarih ile oluşturulacaktır, devam etmek istiyor musunuz?';
			case 'transaction.duplicate_success': return 'İşlem başarıyla kopyalandı';
			case 'transaction.delete': return 'İşlemi sil';
			case 'transaction.delete_warning_message': return 'Bu eylem geri alınamaz. Hesaplarınızın mevcut bakiyesi ve tüm istatistikleriniz yeniden hesaplanacaktır';
			case 'transaction.delete_success': return 'İşlem başarıyla silindi';
			case 'transaction.delete_multiple': return 'İşlemleri sil';
			case 'transaction.delete_multiple_warning_message': return ({required Object x}) => 'Bu eylem geri alınamaz ve ${x} işlem silinecektir. Hesaplarınızın mevcut bakiyesi ve tüm istatistikleriniz yeniden hesaplanacaktır';
			case 'transaction.delete_multiple_success': return ({required Object x}) => '${x} işlem başarıyla silindi';
			case 'transaction.details': return 'Hareket detayları';
			case 'transaction.next_payments.accept': return 'Kabul et';
			case 'transaction.next_payments.skip': return 'Atla';
			case 'transaction.next_payments.skip_success': return 'İşlem başarıyla atlandı';
			case 'transaction.next_payments.skip_dialog_title': return 'İşlemi atla';
			case 'transaction.next_payments.skip_dialog_msg': return ({required Object date}) => 'Bu eylem geri alınamaz. Bir sonraki hareketin tarihini ${date} olarak değiştireceğiz';
			case 'transaction.next_payments.accept_today': return 'Bugün kabul et';
			case 'transaction.next_payments.accept_in_required_date': return ({required Object date}) => 'Gerekli tarihte kabul et (${date})';
			case 'transaction.next_payments.accept_dialog_title': return 'İşlemi kabul et';
			case 'transaction.next_payments.accept_dialog_msg_single': return 'İşlemin yeni durumu boş olacaktır. İstediğiniz zaman bu işlemin durumunu yeniden düzenleyebilirsiniz';
			case 'transaction.next_payments.accept_dialog_msg': return ({required Object date}) => 'Bu eylem ${date} tarihli yeni bir işlem oluşturacaktır. İşlem sayfasında bu işlemin detaylarını kontrol edebileceksiniz';
			case 'transaction.next_payments.recurrent_rule_finished': return 'Tekrarlama kuralı tamamlandı, yapılacak başka ödeme yok!';
			case 'transaction.list.empty': return 'Burada görüntülenecek işlem bulunamadı. Uygulamaya birkaç işlem ekleyin, belki bir dahaki sefere daha şanslı olursunuz.';
			case 'transaction.list.searcher_placeholder': return 'Kategoriye, açıklamaya göre ara...';
			case 'transaction.list.searcher_no_results': return 'Arama kriterlerine uyan işlem bulunamadı';
			case 'transaction.list.loading': return 'Daha fazla işlem yükleniyor...';
			case 'transaction.list.selected_short': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: '${n} seçildi',
				other: '${n} seçildi',
			);
			case 'transaction.list.selected_long': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: '${n} işlem seçildi',
				other: '${n} işlem seçildi',
			);
			case 'transaction.list.bulk_edit.dates': return 'Tarihleri düzenle';
			case 'transaction.list.bulk_edit.categories': return 'Kategorileri düzenle';
			case 'transaction.list.bulk_edit.status': return 'Durumları düzenle';
			case 'transaction.filters.from_value': return 'Miktardan';
			case 'transaction.filters.to_value': return 'Miktara kadar';
			case 'transaction.filters.from_value_def': return ({required Object x}) => '${x} dan';
			case 'transaction.filters.to_value_def': return ({required Object x}) => '${x} a kadar';
			case 'transaction.filters.from_date_def': return ({required Object date}) => '${date} tarihinden';
			case 'transaction.filters.to_date_def': return ({required Object date}) => '${date} tarihine kadar';
			case 'transaction.form.validators.zero': return 'Bir işlemin değeri sıfıra eşit olamaz';
			case 'transaction.form.validators.date_max': return 'Seçilen tarih, güncel tarihten sonra. İşlem askıda olarak eklenecektir';
			case 'transaction.form.validators.date_after_account_creation': return 'Bir işlemin tarihi, ait olduğu hesabın oluşturulma tarihinden önce olamaz';
			case 'transaction.form.validators.negative_transfer': return 'Bir transferin parasal değeri negatif olamaz';
			case 'transaction.form.validators.transfer_between_same_accounts': return 'Kaynak ve hedef hesap aynı olamaz';
			case 'transaction.form.title': return 'İşlem başlığı';
			case 'transaction.form.title_short': return 'Başlık';
			case 'transaction.form.value': return 'İşlem değeri';
			case 'transaction.form.tap_to_see_more': return 'Daha fazla detay görmek için dokunun';
			case 'transaction.form.no_tags': return '-- Etiket yok --';
			case 'transaction.form.description': return 'Açıklama';
			case 'transaction.form.description_info': return 'Bu işlem hakkında daha detaylı bir açıklama girmek için buraya dokunun';
			case 'transaction.form.exchange_to_preferred_title': return ({required Object currency}) => '${currency} için kur';
			case 'transaction.form.exchange_to_preferred_in_date': return 'İşlem tarihinde';
			case 'transaction.reversed.title': return 'Ters işlem';
			case 'transaction.reversed.title_short': return 'Ters. iş.';
			case 'transaction.reversed.description_for_expenses': return 'Bir gider işlemi olmasına rağmen, pozitif bir tutara sahiptir. Bu tür işlemler, bir geri ödeme veya bir borcun ödenmesi gibi daha önce kaydedilmiş bir giderin iadesini temsil etmek için kullanılabilir.';
			case 'transaction.reversed.description_for_incomes': return 'Bir gelir işlemi olmasına rağmen, negatif bir tutara sahiptir. Bu tür işlemler, hatalı kaydedilmiş bir geliri geçersiz kılmak veya düzeltmek, para iadesini veya geri ödemesini yansıtmak veya borç ödemesini kaydetmek için kullanılabilir.';
			case 'transaction.status.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Durum',
				other: 'Durumlar',
			);
			case 'transaction.status.display_long': return 'İşlem durumu';
			case 'transaction.status.tr_status': return ({required Object status}) => '${status} işlemi';
			case 'transaction.status.none': return 'Durumsuz';
			case 'transaction.status.none_descr': return 'Belirli bir durumu olmayan işlem';
			case 'transaction.status.reconciled': return 'Mutabık';
			case 'transaction.status.reconciled_descr': return 'Bu işlem zaten onaylandı ve bankanızdaki gerçek bir işleme karşılık geliyor';
			case 'transaction.status.unreconciled': return 'Mutabık değil';
			case 'transaction.status.unreconciled_descr': return 'Bu işlem henüz doğrulanmadı ve bu nedenle henüz gerçek banka hesaplarınızda görünmüyor. Ancak, Monekin\'deki bakiyelerin ve istatistiklerin hesaplanması için sayılır';
			case 'transaction.status.pending': return 'Beklemede';
			case 'transaction.status.pending_descr': return 'Bu işlem bekliyor ve bu nedenle bakiyeler ve istatistikler hesaplanırken dikkate alınmayacaktır';
			case 'transaction.status.voided': return 'İptal Edildi';
			case 'transaction.status.voided_descr': return 'Ödeme hatası veya başka herhangi bir nedenden dolayı geçersiz kılınan/iptal edilen işlem. Bakiyeler ve istatistikler hesaplanırken dikkate alınmayacaktır';
			case 'transaction.types.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'İşlem türü',
				other: 'İşlem türleri',
			);
			case 'transaction.types.income': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Gelir',
				other: 'Gelirler',
			);
			case 'transaction.types.expense': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Gider',
				other: 'Giderler',
			);
			case 'transaction.types.transfer': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Transfer',
				other: 'Transferler',
			);
			case 'transfer.display': return 'Transfer';
			case 'transfer.transfers': return 'Transferler';
			case 'transfer.transfer_to': return ({required Object account}) => '${account} hesabına transfer';
			case 'transfer.create': return 'Yeni Transfer';
			case 'transfer.need_two_accounts_warning_header': return 'Ups!';
			case 'transfer.need_two_accounts_warning_message': return 'Bu eylemi gerçekleştirmek için en az iki hesaba ihtiyaç vardır. Bu hesabın mevcut bakiyesini ayarlamanız veya düzenlemeniz gerekiyorsa, düzenle düğmesine tıklayın';
			case 'transfer.form.from': return 'Kaynak hesap';
			case 'transfer.form.to': return 'Hedef hesap';
			case 'transfer.form.value_in_destiny.title': return 'Hedefte aktarılan miktar';
			case 'transfer.form.value_in_destiny.amount_short': return ({required Object amount}) => 'Hedef hesaba ${amount}';
			case 'recurrent_transactions.title': return 'Tekrarlayan işlemler';
			case 'recurrent_transactions.title_short': return 'Tekr. işl.';
			case 'recurrent_transactions.empty': return 'Görünüşe göre tekrarlayan herhangi bir işleminiz yok. Aylık, yıllık veya haftalık tekrarlayan bir işlem oluşturun, burada görünecektir';
			case 'recurrent_transactions.total_expense_title': return 'Dönem başına toplam gider';
			case 'recurrent_transactions.total_expense_descr': return '* Her tekrarın başlangıç ​​ve bitiş tarihi dikkate alınmadan';
			case 'recurrent_transactions.details.title': return 'Tekrarlayan işlem';
			case 'recurrent_transactions.details.descr': return 'Bu işlem için sonraki hareketler aşağıda gösterilmektedir. İlk hareketi kabul edebilir veya bu hareketi atlayabilirsiniz';
			case 'recurrent_transactions.details.last_payment_info': return 'Bu hareket, tekrar kuralının sonuncusudur, bu nedenle bu eylemi onaylarken bu kural otomatik olarak silinecektir';
			case 'recurrent_transactions.details.delete_header': return 'Tekrarlayan işlemi sil';
			case 'recurrent_transactions.details.delete_message': return 'Bu eylem geri alınamaz ve zaten onayladığınız/ödediğiniz işlemleri etkilemez';
			case 'recurrent_transactions.status.delayed_by': return ({required Object x}) => '${x}g gecikti';
			case 'recurrent_transactions.status.coming_in': return ({required Object x}) => '${x} gün içinde';
			case 'account.details': return 'Hesap detayları';
			case 'account.date': return 'Açılış tarihi';
			case 'account.close_date': return 'Kapanış tarihi';
			case 'account.reopen': return 'Hesabı yeniden aç';
			case 'account.reopen_short': return 'Yeniden aç';
			case 'account.reopen_descr': return 'Bu hesabı yeniden açmak istediğinizden emin misiniz?';
			case 'account.balance': return 'Hesap bakiyesi';
			case 'account.n_transactions': return 'İşlem sayısı';
			case 'account.add_money': return 'Para ekle';
			case 'account.withdraw_money': return 'Para çek';
			case 'account.no_accounts': return 'Burada görüntülenecek işlem bulunamadı. Alttaki \'+\' düğmesine tıklayarak bir işlem ekleyin';
			case 'account.types.title': return 'Hesap türü';
			case 'account.types.warning': return 'Hesap türü seçildikten sonra gelecekte değiştirilemez';
			case 'account.types.normal': return 'Normal hesap';
			case 'account.types.normal_descr': return 'Günlük mali durumunuzu kaydetmek için kullanışlıdır. En yaygın hesaptır, giderler, gelirler eklemenize olanak tanır...';
			case 'account.types.saving': return 'Tasarruf hesabı';
			case 'account.types.saving_descr': return 'Yalnızca diğer hesaplardan para ekleyebilecek ve çekebileceksiniz. Para biriktirmeye başlamak için mükemmel';
			case 'account.form.name': return 'Hesap adı';
			case 'account.form.name_placeholder': return 'Örn: Tasarruf hesabı';
			case 'account.form.notes': return 'Notlar';
			case 'account.form.notes_placeholder': return 'Bu hesap hakkında bazı notlar/açıklama yazın';
			case 'account.form.initial_balance': return 'Başlangıç ​​bakiyesi';
			case 'account.form.current_balance': return 'Mevcut bakiye';
			case 'account.form.create': return 'Hesap oluştur';
			case 'account.form.edit': return 'Hesabı düzenle';
			case 'account.form.currency_not_found_warn': return 'Bu para birimi için döviz kurları hakkında bilginiz yok. Varsayılan döviz kuru olarak 1.0 kullanılacaktır. Bunu ayarlardan değiştirebilirsiniz';
			case 'account.form.already_exists': return 'Aynı ada sahip başka bir hesap zaten var, lütfen başka bir tane yazın';
			case 'account.form.tr_before_opening_date': return 'Bu hesapta açılış tarihinden önce bir tarihe sahip işlemler var';
			case 'account.form.iban': return 'IBAN';
			case 'account.form.swift': return 'SWIFT';
			case 'account.delete.warning_header': return 'Hesap silinsin mi?';
			case 'account.delete.warning_text': return 'Bu eylem bu hesabı ve tüm işlemlerini silecektir';
			case 'account.delete.success': return 'Hesap başarıyla silindi';
			case 'account.close.title': return 'Hesabı kapat';
			case 'account.close.title_short': return 'Kapat';
			case 'account.close.warn': return 'Bu hesap artık belirli listelerde görünmeyecek ve aşağıda belirtilen tarihten sonra bu hesapta işlem oluşturamayacaksınız. Bu eylem herhangi bir işlemi veya bakiyeyi etkilemez ve ayrıca bu hesabı istediğiniz zaman yeniden açabilirsiniz.';
			case 'account.close.should_have_zero_balance': return 'Kapatmak için bu hesabın mevcut bakiyesi 0 olmalıdır. Lütfen devam etmeden önce hesabı düzenleyin';
			case 'account.close.should_have_no_transactions': return 'Bu hesap, belirtilen kapanış tarihinden sonra işlemlere sahip. Devam etmeden önce bunları silin veya hesabın kapanış tarihini düzenleyin';
			case 'account.close.success': return 'Hesap başarıyla kapatıldı';
			case 'account.close.unarchive_succes': return 'Hesap başarıyla yeniden açıldı';
			case 'account.select.one': return 'Bir hesap seçin';
			case 'account.select.all': return 'Tüm hesaplar';
			case 'account.select.multiple': return 'Hesapları seçin';
			case 'currencies.currency_converter': return 'Para birimi dönüştürücü';
			case 'currencies.currency': return 'Para birimi';
			case 'currencies.currency_manager': return 'Para birimi yöneticisi';
			case 'currencies.currency_manager_descr': return 'Para biriminizi ve diğerleriyle döviz kurlarını yapılandırın';
			case 'currencies.preferred_currency': return 'Tercih edilen/temel para birimi';
			case 'currencies.change_preferred_currency_title': return 'Tercih edilen para birimini değiştir';
			case 'currencies.change_preferred_currency_msg': return 'Tüm istatistikler ve bütçeler bundan sonra bu para biriminde görüntülenecektir. Hesaplar ve işlemler sahip oldukları para birimini koruyacaktır. Bu eylemi gerçekleştirirseniz, kaydedilen tüm döviz kurları silinecektir. Devam etmek istiyor musunuz?';
			case 'currencies.form.equal_to_preferred_warn': return 'Para birimi, kullanıcı para birimine eşit olamaz';
			case 'currencies.form.specify_a_currency': return 'Lütfen bir para birimi belirtin';
			case 'currencies.form.add': return 'Döviz kuru ekle';
			case 'currencies.form.add_success': return 'Döviz kuru başarıyla eklendi';
			case 'currencies.form.edit': return 'Döviz kurunu düzenle';
			case 'currencies.form.edit_success': return 'Döviz kuru başarıyla düzenlendi';
			case 'currencies.delete_all_success': return 'Döviz kurları başarıyla silindi';
			case 'currencies.historical': return 'Geçmiş oranlar';
			case 'currencies.exchange_rate': return 'Döviz kuru';
			case 'currencies.exchange_rates': return 'Döviz kurları';
			case 'currencies.empty': return 'Buraya döviz kurları ekleyin, böylece temel para biriminizden farklı para birimlerinde hesaplarınız varsa grafiklerimiz daha doğru olur';
			case 'currencies.select_a_currency': return 'Bir para birimi seçin';
			case 'currencies.search': return 'Adına veya para birimi koduna göre arayın';
			case 'tags.display': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('tr'))(n,
				one: 'Etiket',
				other: 'Etiketler',
			);
			case 'tags.form.name': return 'Etiket adı';
			case 'tags.form.description': return 'Açıklama';
			case 'tags.select.title': return 'Etiketleri seçin';
			case 'tags.select.all': return 'Tüm etiketler';
			case 'tags.empty_list': return 'Henüz etiket oluşturmadınız. Etiketler ve kategoriler, hareketlerinizi kategorize etmek için harika bir yoldur';
			case 'tags.without_tags': return 'Etiketsiz';
			case 'tags.add': return 'Etiket ekle';
			case 'tags.create': return 'Etiket oluştur';
			case 'tags.create_success': return 'Etiket başarıyla oluşturuldu';
			case 'tags.already_exists': return 'Bu etiket adı zaten var. Düzenlemek isteyebilirsiniz';
			case 'tags.edit': return 'Etiketi düzenle';
			case 'tags.edit_success': return 'Etiket başarıyla düzenlendi';
			case 'tags.delete_success': return 'Kategori başarıyla silindi';
			case 'tags.delete_warning_header': return 'Etiket silinsin mi?';
			case 'tags.delete_warning_message': return 'Bu eylem bu etikete sahip işlemleri silmez.';
			case 'categories.unknown': return 'Bilinmeyen kategori';
			case 'categories.create': return 'Kategori oluştur';
			case 'categories.create_success': return 'Kategori başarıyla oluşturuldu';
			case 'categories.new_category': return 'Yeni kategori';
			case 'categories.already_exists': return 'Bu kategorinin adı zaten var. Belki düzenlemek istersiniz';
			case 'categories.edit': return 'Kategoriyi düzenle';
			case 'categories.edit_success': return 'Kategori başarıyla düzenlendi';
			case 'categories.name': return 'Kategori adı';
			case 'categories.type': return 'Kategori türü';
			case 'categories.both_types': return 'Her iki tür';
			case 'categories.subcategories': return 'Alt kategoriler';
			case 'categories.subcategories_add': return 'Alt kategori ekle';
			case 'categories.make_parent': return 'Kategoriye yap';
			case 'categories.make_child': return 'Alt kategori yap';
			case 'categories.make_child_warning1': return ({required Object destiny}) => 'Bu kategori ve alt kategorileri <b>${destiny}</b>\'nin alt kategorileri olacaktır.';
			case 'categories.make_child_warning2': return ({required Object x, required Object destiny}) => 'İşlemleri <b>(${x})</b>, <b>${destiny}</b> kategorisi içinde oluşturulan yeni alt kategorilere taşınacaktır.';
			case 'categories.make_child_success': return 'Alt kategoriler başarıyla oluşturuldu';
			case 'categories.merge': return 'Başka bir kategoriyle birleştir';
			case 'categories.merge_warning1': return ({required Object from, required Object x, required Object destiny}) => '<b>${from}</b> kategorisiyle ilişkili tüm işlemler (${x}), <b>${destiny}</b> kategorisine taşınacaktır.';
			case 'categories.merge_warning2': return ({required Object from}) => '<b>${from}</b> kategorisi geri dönüşü olmayacak şekilde silinecektir.';
			case 'categories.merge_success': return 'Kategori başarıyla birleştirildi';
			case 'categories.delete_success': return 'Kategori başarıyla silindi';
			case 'categories.delete_warning_header': return 'Kategori silinsin mi?';
			case 'categories.delete_warning_message': return ({required Object x}) => 'Bu eylem, bu kategoriyle ilgili tüm işlemleri <b>(${x})</b> geri dönüşü olmayacak şekilde silecektir.';
			case 'categories.select.title': return 'Kategori seçin';
			case 'categories.select.select_one': return 'Bir kategori seçin';
			case 'categories.select.select_subcategory': return 'Bir alt kategori seçin';
			case 'categories.select.without_subcategory': return 'Alt kategori olmadan';
			case 'categories.select.all': return 'Tüm kategoriler';
			case 'categories.select.all_short': return 'Tümü';
			case 'budgets.title': return 'Bütçeler';
			case 'budgets.repeated': return 'Tekrarlayan';
			case 'budgets.one_time': return 'Tek seferlik';
			case 'budgets.annual': return 'Yıllık';
			case 'budgets.week': return 'Haftalık';
			case 'budgets.month': return 'Aylık';
			case 'budgets.actives': return 'Aktifler';
			case 'budgets.pending': return 'Başlangıcı Bekliyor';
			case 'budgets.finish': return 'Bitti';
			case 'budgets.from_budgeted': return 'kalan ';
			case 'budgets.days_left': return 'gün kaldı';
			case 'budgets.days_to_start': return 'başlangıca kalan gün';
			case 'budgets.since_expiration': return 'son kullanma tarihinden itibaren';
			case 'budgets.no_budgets': return 'Bu bölümde görüntülenecek bütçe yok gibi görünüyor. Aşağıdaki düğmeyi tıklayarak bir bütçe oluşturmaya başlayın';
			case 'budgets.delete': return 'Bütçeyi sil';
			case 'budgets.delete_warning': return 'Bu eylem geri alınamaz. Bu bütçeye atıfta bulunan kategoriler ve işlemler silinmez';
			case 'budgets.form.title': return 'Bütçe ekle';
			case 'budgets.form.name': return 'Bütçe adı';
			case 'budgets.form.value': return 'Limit miktarı';
			case 'budgets.form.create': return 'Bütçe ekle';
			case 'budgets.form.edit': return 'Bütçeyi düzenle';
			case 'budgets.form.negative_warn': return 'Bütçeler negatif miktara sahip olamaz';
			case 'budgets.details.title': return 'Bütçe Detayları';
			case 'budgets.details.statistics': return 'İstatistikler';
			case 'budgets.details.budget_value': return 'Bütçelenen';
			case 'budgets.details.expend_diary_left': return ({required Object remainingDays, required Object dailyAmount}) => '${remainingDays} kalan gün için günde ${dailyAmount} harcayabilirsiniz';
			case 'budgets.details.expend_evolution': return 'Harcama gelişimi';
			case 'budgets.details.no_transactions': return 'Bu bütçeyle ilgili herhangi bir harcama yapmamışsınız gibi görünüyor';
			case 'backup.export.title': return 'Verilerinizi dışa aktarın';
			case 'backup.export.title_short': return 'Dışa Aktar';
			case 'backup.export.all': return 'Tam yedekleme';
			case 'backup.export.all_descr': return 'Tüm verilerinizi (hesaplar, işlemler, bütçeler, ayarlar...) dışa aktarın. Herhangi bir şeyi kaybetmemek için bunları istediğiniz zaman tekrar içe aktarın.';
			case 'backup.export.transactions': return 'İşlemlerin yedeği';
			case 'backup.export.transactions_descr': return 'İşlemlerinizi CSV olarak dışa aktarın, böylece diğer programlarda veya uygulamalarda daha kolay analiz edebilirsiniz.';
			case 'backup.export.description': return 'Verilerinizi farklı formatlarda indirin';
			case 'backup.export.dialog_title': return 'Dosyayı Kaydet/Gönder';
			case 'backup.export.success': return ({required Object x}) => 'Dosya ${x} olarak başarıyla kaydedildi/indirildi';
			case 'backup.export.error': return 'Dosya indirilirken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin';
			case 'backup.import.title': return 'Verilerinizi içe aktarın';
			case 'backup.import.title_short': return 'İçe Aktar';
			case 'backup.import.restore_backup': return 'Yedeklemeyi Geri Yükle';
			case 'backup.import.restore_backup_descr': return 'Monekin\'den daha önce kaydedilmiş bir veritabanını içe aktarın. Bu eylem, mevcut uygulama verilerinin herhangi birini yeni verilerle değiştirecektir';
			case 'backup.import.restore_backup_warn_description': return 'Yeni bir veritabanı içe aktarırken, uygulamada şu anda kayıtlı olan tüm verileri kaybedeceksiniz. Devam etmeden önce bir yedekleme yapmanız önerilir. Buraya, kaynağını bilmediğiniz herhangi bir dosyayı yüklemeyin, yalnızca daha önce Monekin\'den indirdiğiniz dosyaları yükleyin';
			case 'backup.import.restore_backup_warn_title': return 'Tüm verilerin üzerine yaz';
			case 'backup.import.select_other_file': return 'Başka dosya seç';
			case 'backup.import.tap_to_select_file': return 'Bir dosya seçmek için dokunun';
			case 'backup.import.manual_import.title': return 'Manuel içe aktarma';
			case 'backup.import.manual_import.descr': return 'İşlemleri manuel olarak .csv dosyasından içe aktarın';
			case 'backup.import.manual_import.default_account': return 'Varsayılan hesap';
			case 'backup.import.manual_import.remove_default_account': return 'Varsayılan hesabı kaldır';
			case 'backup.import.manual_import.default_category': return 'Varsayılan Kategori';
			case 'backup.import.manual_import.select_a_column': return '.csv\'den bir sütun seçin';
			case 'backup.import.manual_import.steps.0': return 'Dosyanızı seçin';
			case 'backup.import.manual_import.steps.1': return 'Miktar için sütun';
			case 'backup.import.manual_import.steps.2': return 'Hesap için sütun';
			case 'backup.import.manual_import.steps.3': return 'Kategori için sütun';
			case 'backup.import.manual_import.steps.4': return 'Tarih için sütun';
			case 'backup.import.manual_import.steps.5': return 'diğer sütunlar';
			case 'backup.import.manual_import.steps_descr.0': return 'Cihazınızdan bir .csv dosyası seçin. Her sütunun adını açıklayan bir ilk satıra sahip olduğundan emin olun';
			case 'backup.import.manual_import.steps_descr.1': return 'Her işlemin değerinin belirtildiği sütunu seçin. Giderler için negatif değerler ve gelirler için pozitif değerler kullanın. Ondalık ayırıcı olarak nokta kullanın';
			case 'backup.import.manual_import.steps_descr.2': return 'Her işlemin ait olduğu hesabın belirtildiği sütunu seçin. İstediğiniz hesabı bulamamamız durumunda varsayılan bir hesap da seçebilirsiniz. Varsayılan bir hesap belirtilmezse, aynı adla bir tane oluşturacağız';
			case 'backup.import.manual_import.steps_descr.3': return 'İşlem kategorisi adının bulunduğu sütunu belirtin. Kategoriyi bulamamamız durumunda işlemlere bu kategoriyi atayabilmemiz için varsayılan bir kategori belirtmeniz gerekir';
			case 'backup.import.manual_import.steps_descr.4': return 'Her işlemin tarihinin belirtildiği sütunu seçin. Belirtilmezse, işlemler mevcut tarihle oluşturulacaktır';
			case 'backup.import.manual_import.steps_descr.5': return 'Diğer isteğe bağlı işlem öznitelikleri için sütunları belirtir';
			case 'backup.import.manual_import.success': return ({required Object x}) => '${x} işlem başarıyla içe aktarıldı';
			case 'backup.import.success': return 'İçe aktarma başarıyla gerçekleştirildi';
			case 'backup.import.cancelled': return 'İçe aktarma kullanıcı tarafından iptal edildi';
			case 'backup.import.error': return 'Dosya içe aktarılırken hata oluştu. Lütfen lozin.technologies@gmail.com adresinden geliştirici ile iletişime geçin';
			case 'backup.about.title': return 'Veritabanınız hakkında bilgiler';
			case 'backup.about.create_date': return 'Oluşturulma tarihi';
			case 'backup.about.modify_date': return 'Son değiştirilme';
			case 'backup.about.last_backup': return 'Son yedekleme';
			case 'backup.about.size': return 'Boyut';
			case 'settings.title_long': return 'Ayarlar ve görünüm';
			case 'settings.title_short': return 'Ayarlar';
			case 'settings.description': return 'Uygulama teması, metinler ve diğer genel ayarlar';
			case 'settings.edit_profile': return 'Profili düzenle';
			case 'settings.lang_section': return 'Dil ve metinler';
			case 'settings.lang_title': return 'Uygulama dili';
			case 'settings.lang_descr': return 'Metinlerin uygulamada görüntüleneceği dil';
			case 'settings.lang_help': return 'Bu uygulamanın çevirilerine katkıda bulunmak isterseniz, <a href=\'https://github.com/enrique-lozano/Monekin/tree/main/lib/i18n\'>kılavuzumuza</a> başvurabilirsiniz';
			case 'settings.locale': return 'Bölge';
			case 'settings.locale_descr': return 'Tarihler, sayılar için kullanılacak biçimi ayarlayın...';
			case 'settings.locale_warn': return 'Bölge değiştirildiğinde uygulama güncellenecektir';
			case 'settings.first_day_of_week': return 'Haftanın ilk günü';
			case 'settings.theme_and_colors': return 'Tema ve renkler';
			case 'settings.theme': return 'Tema';
			case 'settings.theme_auto': return 'Sistem';
			case 'settings.theme_light': return 'Açık';
			case 'settings.theme_dark': return 'Koyu';
			case 'settings.amoled_mode': return 'AMOLED modu';
			case 'settings.amoled_mode_descr': return 'Mümkün olduğunda saf siyah bir duvar kağıdı kullanın. Bu, AMOLED ekranlara sahip cihazların pili için biraz yardımcı olacaktır';
			case 'settings.dynamic_colors': return 'Dinamik renkler';
			case 'settings.dynamic_colors_descr': return 'Mümkün olduğunda sistem vurgu renginizi kullanın';
			case 'settings.accent_color': return 'Vurgu rengi';
			case 'settings.accent_color_descr': return 'Uygulamanın arayüzün belirli kısımlarını vurgulamak için kullanacağı rengi seçin';
			case 'settings.security.title': return 'Güvenlik';
			case 'settings.security.private_mode_at_launch': return 'Başlangıçta özel mod';
			case 'settings.security.private_mode_at_launch_descr': return 'Uygulamayı varsayılan olarak özel modda başlatın';
			case 'settings.security.private_mode': return 'Özel mod';
			case 'settings.security.private_mode_descr': return 'Tüm parasal değerleri gizle';
			case 'settings.security.private_mode_activated': return 'Özel mod etkinleştirildi';
			case 'settings.security.private_mode_deactivated': return 'Özel mod devre dışı bırakıldı';
			case 'more.title': return 'Daha Fazla';
			case 'more.title_long': return 'Daha fazla eylem';
			case 'more.data.display': return 'Veri';
			case 'more.data.display_descr': return 'Hiçbir şeyi kaybetmemek için verilerinizi dışa ve içe aktarın';
			case 'more.data.delete_all': return 'Verilerimi sil';
			case 'more.data.delete_all_header1': return 'Orada dur padawan ⚠️⚠️';
			case 'more.data.delete_all_message1': return 'Devam etmek istediğinizden emin misiniz? Tüm verileriniz kalıcı olarak silinecek ve kurtarılamayacaktır';
			case 'more.data.delete_all_header2': return 'Son bir adım ⚠️⚠️';
			case 'more.data.delete_all_message2': return 'Bir hesabı sildiğinizde, kayıtlı tüm kişisel verilerinizi silmiş olursunuz. Hesaplarınız, işlemleriniz, bütçeleriniz ve kategorileriniz silinecek ve kurtarılamayacaktır. Kabul ediyor musunuz?';
			case 'more.about_us.display': return 'Uygulama bilgileri';
			case 'more.about_us.description': return 'Monekin hakkında şartları ve diğer ilgili bilgileri inceleyin. Hata bildirerek, önerilerde bulunarak toplulukla etkileşime geçin...';
			case 'more.about_us.legal.display': return 'Yasal bilgiler';
			case 'more.about_us.legal.privacy': return 'Gizlilik politikası';
			case 'more.about_us.legal.terms': return 'Kullanım koşulları';
			case 'more.about_us.legal.licenses': return 'Lisanslar';
			case 'more.about_us.project.display': return 'Proje';
			case 'more.about_us.project.contributors': return 'Katkıda bulunanlar';
			case 'more.about_us.project.contributors_descr': return 'Monekin\'in büyümesini sağlayan tüm geliştiriciler';
			case 'more.about_us.project.contact': return 'Bize ulaşın';
			case 'more.help_us.display': return 'Bize yardım edin';
			case 'more.help_us.description': return 'Monekin\'in nasıl daha iyi olabileceğini öğrenin';
			case 'more.help_us.rate_us': return 'Bize oy verin';
			case 'more.help_us.rate_us_descr': return 'Herhangi bir puan memnuniyetle karşılanır!';
			case 'more.help_us.share': return 'Monekin\'i paylaşın';
			case 'more.help_us.share_descr': return 'Uygulamamızı arkadaşlarınıza ve ailenize paylaşın';
			case 'more.help_us.share_text': return 'Monekin! En iyi kişisel finans uygulaması. Buradan indirin';
			case 'more.help_us.thanks': return 'Teşekkürler!';
			case 'more.help_us.thanks_long': return 'Monekin\'e ve diğer açık kaynaklı projelere yaptığınız katkılar, büyük ve küçük, bunun gibi harika projeleri mümkün kılıyor. Katkıda bulunmak için zaman ayırdığınız için teşekkür ederiz.';
			case 'more.help_us.donate': return 'Bağış yap';
			case 'more.help_us.donate_descr': return 'Bağışınızla uygulamanın iyileştirmeler almaya devam etmesine yardımcı olacaksınız. Yapılan çalışmaya kahve ısmarlayarak teşekkür etmekten daha iyi bir yol mu var?';
			case 'more.help_us.donate_success': return 'Bağış yapıldı. Katkılarınız için çok teşekkür ederim! ❤️';
			case 'more.help_us.donate_err': return 'Ups! Ödemenizi alırken bir hata oluştu gibi görünüyor';
			case 'more.help_us.report': return 'Hataları bildirin, önerilerde bulunun...';
			default: return null;
		}
	}
}


/// Currencies published in the ECB euro foreign exchange reference rates.
const ecbCurrencyCodes = {
  'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', //
  'HKD', 'HUF', 'IDR', 'ILS', 'INR', 'ISK', 'JPY', 'KRW', 'MXN', 'MYR', //
  'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'SEK', 'SGD', 'THB', 'TRY', 'USD', //
  'ZAR',
};

enum EcbFetchAvailability { available, missingCurrency, samePreferred, unsupported }

/// Whether the ECB fetch action can apply to a [currency]/[preferred] pair.
EcbFetchAvailability ecbFetchAvailability({
  required String? currency,
  required String? preferred,
}) {
  if (currency == null || preferred == null) {
    return EcbFetchAvailability.missingCurrency;
  }
  final from = currency.toUpperCase();
  final to = preferred.toUpperCase();
  if (from == to) return EcbFetchAvailability.samePreferred;
  if (!ecbCurrencyCodes.contains(from) || !ecbCurrencyCodes.contains(to)) {
    return EcbFetchAvailability.unsupported;
  }
  return EcbFetchAvailability.available;
}

enum RateFillPlan { fill, confirmReplace, dateMismatch }

bool isSameCalendarDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Decide how a fetched ECB quote may go into the exchange-rate form.
///
/// A rate the user already typed is never replaced without confirmation.
/// When the form date cannot change (editing a saved rate), the quote is only
/// used if it belongs to that same day: the ECB business day can be earlier
/// than the local clock on weekends and before the daily fix.
RateFillPlan planRateFill({
  required String currentText,
  required double quoteRate,
  required DateTime quoteDate,
  required DateTime formDate,
  required bool dateLocked,
}) {
  if (dateLocked && !isSameCalendarDay(quoteDate, formDate)) {
    return RateFillPlan.dateMismatch;
  }
  final typed = double.tryParse(currentText.trim());
  if (typed != null && typed != quoteRate) return RateFillPlan.confirmReplace;
  return RateFillPlan.fill;
}

/// Currencies published in the ECB euro foreign exchange reference rates.
const ecbCurrencyCodes = {
  'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CNY', 'CZK', 'DKK', 'EUR', 'GBP', //
  'HKD', 'HUF', 'IDR', 'ILS', 'INR', 'ISK', 'JPY', 'KRW', 'MXN', 'MYR', //
  'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'SEK', 'SGD', 'THB', 'TRY', 'USD', //
  'ZAR',
};

enum EcbFetchAvailability {
  available,
  missingCurrency,
  samePreferred,
  unsupported,
}

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

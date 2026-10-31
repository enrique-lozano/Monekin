import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/services/exchange-rate/today_rate_plan.dart';

void main() {
  group('ecbFetchAvailability', () {
    test('available for two ECB currencies', () {
      expect(
        ecbFetchAvailability(currency: 'eur', preferred: 'USD'),
        EcbFetchAvailability.available,
      );
    });

    test('not available for the preferred currency itself', () {
      expect(
        ecbFetchAvailability(currency: 'USD', preferred: 'USD'),
        EcbFetchAvailability.samePreferred,
      );
    });

    test('not available when ECB does not publish either side', () {
      expect(
        ecbFetchAvailability(currency: 'ARS', preferred: 'USD'),
        EcbFetchAvailability.unsupported,
      );
      expect(
        ecbFetchAvailability(currency: 'EUR', preferred: 'VND'),
        EcbFetchAvailability.unsupported,
      );
    });

    test('not available until a currency is chosen', () {
      expect(
        ecbFetchAvailability(currency: null, preferred: 'USD'),
        EcbFetchAvailability.missingCurrency,
      );
    });
  });
}

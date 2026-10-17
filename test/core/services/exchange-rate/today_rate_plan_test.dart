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

  group('planRateFill', () {
    final day = DateTime(2026, 10, 16);

    test('fills an empty field', () {
      expect(
        planRateFill(
          currentText: '',
          quoteRate: 1.12,
          quoteDate: day,
          formDate: day,
          dateLocked: false,
        ),
        RateFillPlan.fill,
      );
    });

    test('asks before replacing a different typed rate', () {
      expect(
        planRateFill(
          currentText: '1.05',
          quoteRate: 1.12,
          quoteDate: day,
          formDate: day,
          dateLocked: false,
        ),
        RateFillPlan.confirmReplace,
      );
    });

    test('does not ask when the typed rate already matches', () {
      expect(
        planRateFill(
          currentText: '1.12',
          quoteRate: 1.12,
          quoteDate: day,
          formDate: day,
          dateLocked: true,
        ),
        RateFillPlan.fill,
      );
    });

    test('refuses a quote for another day when the date is locked', () {
      expect(
        planRateFill(
          currentText: '1.05',
          quoteRate: 1.12,
          quoteDate: day,
          formDate: DateTime(2026, 9, 1),
          dateLocked: true,
        ),
        RateFillPlan.dateMismatch,
      );
    });

    test('an unlocked date may follow the quote', () {
      expect(
        planRateFill(
          currentText: '',
          quoteRate: 1.12,
          quoteDate: day,
          formDate: DateTime(2026, 10, 18),
          dateLocked: false,
        ),
        RateFillPlan.fill,
      );
    });
  });
}

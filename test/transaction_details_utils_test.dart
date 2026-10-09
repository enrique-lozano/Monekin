import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/transactions/details/utils/transaction_details.utils.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

void main() {
  test('accepting a recurrent transaction preserves its status', () {
    final transaction = MoneyTransaction(
      id: 'recurrent-transaction',
      date: DateTime(2026, 5, 15),
      value: -25,
      isHidden: false,
      type: TransactionType.expense,
      status: TransactionStatus.unreconciled,
      account: AccountInDB(
        id: 'account',
        name: 'Cash',
        iniValue: 0,
        date: DateTime(2026),
        type: AccountType.money,
        isSaving: false,
        trackingMode: AccountTrackingMode.transactions,
        iconId: 'wallet',
        displayOrder: 0,
        currencyId: 'EUR',
      ),
      accountCurrency: const CurrencyInDB(
        code: 'EUR',
        symbol: '€',
        name: 'Euro',
        decimalPlaces: 2,
        isDefault: true,
        type: 0,
      ),
      currentValueInPreferredCurrency: -25,
      tags: const [],
      intervalEach: 1,
      intervalPeriod: Periodicity.month,
    );
    final acceptedDate = DateTime(2026, 5, 16);

    final accepted = buildAcceptedTransaction(
      transaction,
      datetime: acceptedDate,
    );

    expect(accepted.status, TransactionStatus.unreconciled);
    expect(accepted.id, isNot(transaction.id));
    expect(accepted.date, acceptedDate);
    expect(accepted.intervalEach, isNull);
    expect(accepted.intervalPeriod, isNull);
  });

  group('accepting a recurrent security trade', () {
    MoneyTransaction recurrentTrade({
      required double value,
      required double quantity,
    }) => MoneyTransaction(
      id: 'recurrent-trade',
      date: DateTime(2026, 5, 15),
      value: value,
      isHidden: false,
      type: TransactionType.investment,
      account: AccountInDB(
        id: 'account',
        name: 'Broker',
        iniValue: 0,
        date: DateTime(2026),
        type: AccountType.investment,
        isSaving: false,
        trackingMode: AccountTrackingMode.transactions,
        iconId: 'wallet',
        displayOrder: 0,
        currencyId: 'EUR',
      ),
      accountCurrency: const CurrencyInDB(
        code: 'EUR',
        symbol: '€',
        name: 'Euro',
        decimalPlaces: 2,
        isDefault: true,
        type: 0,
      ),
      currentValueInPreferredCurrency: value,
      tags: const [],
      intervalEach: 1,
      intervalPeriod: Periodicity.month,
      securityID: 'security',
      quantity: quantity,
      pricePerUnit: value.abs() / quantity.abs(),
    );

    test('a buy keeps its amount and resizes to the new price', () {
      final accepted = buildAcceptedTransaction(
        recurrentTrade(value: -100, quantity: 2),
        datetime: DateTime(2026, 6, 15),
        securityPrice: 40,
      );

      expect(accepted.value, -100);
      expect(accepted.pricePerUnit, 40);
      expect(accepted.quantity, closeTo(2.5, 1e-9));
    });

    test('a sell resizes using the security-to-account rate', () {
      final accepted = buildAcceptedTransaction(
        recurrentTrade(value: 100, quantity: -2),
        datetime: DateTime(2026, 6, 15),
        securityPrice: 25,
        securityToAccountRate: 0.8,
      );

      // 100 EUR / (25 USD * 0.8 EUR per USD) = 5 units
      expect(accepted.value, 100);
      expect(accepted.pricePerUnit, 25);
      expect(accepted.quantity, closeTo(-5, 1e-9));
    });

    test('keeps the previous trade when there is no known price', () {
      final accepted = buildAcceptedTransaction(
        recurrentTrade(value: -100, quantity: 2),
        datetime: DateTime(2026, 6, 15),
        securityPrice: 0,
      );

      expect(accepted.quantity, 2);
      expect(accepted.pricePerUnit, 50);
    });
  });
}

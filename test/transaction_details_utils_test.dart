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
}

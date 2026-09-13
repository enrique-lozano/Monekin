import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/date-utils/periodicity.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

/// The recurrent transactions page sums every recurrency into a single
/// per-period figure. It does so through the *balance* each one causes, since a
/// transfer between two of the user accounts moves money without spending it.
void main() {
  const currency = CurrencyInDB(
    code: 'EUR',
    symbol: '€',
    name: 'Euro',
    decimalPlaces: 2,
    isDefault: true,
    type: 0,
  );

  AccountInDB account(String id) => AccountInDB(
    id: id,
    name: 'Account $id',
    iniValue: 0,
    date: DateTime(2020),
    type: AccountType.money,
    isSaving: false,
    trackingMode: AccountTrackingMode.transactions,
    iconId: 'wallet',
    displayOrder: 0,
    currencyId: 'EUR',
  );

  MoneyTransaction buildTransaction({
    required TransactionType type,
    required double value,
    double? valueInDestiny,
    Periodicity? intervalPeriod,
    int? intervalEach,
  }) {
    return MoneyTransaction(
      id: 'tr-1',
      date: DateTime(2026),
      value: value,
      valueInDestiny: valueInDestiny,
      isHidden: false,
      type: type,
      account: account('acc-1'),
      accountCurrency: currency,
      receivingAccount: type.isTransfer ? account('acc-2') : null,
      receivingAccountCurrency: type.isTransfer ? currency : null,
      currentValueInPreferredCurrency: value,
      currentValueInDestinyInPreferredCurrency: valueInDestiny,
      tags: const [],
      intervalPeriod: intervalPeriod,
      intervalEach: intervalEach,
    );
  }

  test('a transfer between two own accounts spends nothing', () {
    final transfer = buildTransaction(
      type: TransactionType.transfer,
      value: 700,
      intervalPeriod: Periodicity.month,
      intervalEach: 1,
    );

    expect(
      transfer.getUnifiedBalanceForAPeriod(periodicity: Periodicity.month),
      0,
    );

    // The row itself still displays the amount being moved
    expect(
      transfer.getUnifiedMoneyForAPeriod(periodicity: Periodicity.month),
      700,
    );
  });

  test('a transfer losing money on the exchange counts the difference', () {
    final transfer = buildTransaction(
      type: TransactionType.transfer,
      value: 700,
      valueInDestiny: 690,
      intervalPeriod: Periodicity.month,
      intervalEach: 1,
    );

    expect(
      transfer.getUnifiedBalanceForAPeriod(periodicity: Periodicity.month),
      -10,
    );
  });

  test('expenses keep their value and are spread over the period', () {
    final expense = buildTransaction(
      type: TransactionType.expense,
      value: -120,
      intervalPeriod: Periodicity.year,
      intervalEach: 1,
    );

    expect(
      expense.getUnifiedBalanceForAPeriod(periodicity: Periodicity.month),
      closeTo(-10, 0.001),
    );
  });

  test('the interval divides the amount before converting the period', () {
    final expense = buildTransaction(
      type: TransactionType.expense,
      value: -30,
      intervalPeriod: Periodicity.month,
      intervalEach: 3,
    );

    expect(
      expense.getUnifiedBalanceForAPeriod(periodicity: Periodicity.month),
      closeTo(-10, 0.001),
    );
  });
}

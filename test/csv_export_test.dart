import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

const _eur = CurrencyInDB(
  code: 'EUR',
  symbol: '€',
  name: 'Euro',
  decimalPlaces: 2,
  isDefault: true,
  type: 0,
);

const _usd = CurrencyInDB(
  code: 'USD',
  symbol: r'$',
  name: 'US Dollar',
  decimalPlaces: 2,
  isDefault: true,
  type: 0,
);

AccountInDB _account(String id, String currencyId) => AccountInDB(
  id: id,
  name: id,
  iniValue: 0,
  date: DateTime(2026),
  type: AccountType.money,
  isSaving: false,
  trackingMode: AccountTrackingMode.transactions,
  iconId: 'wallet',
  displayOrder: 0,
  currencyId: currencyId,
);

const _tag = TagInDB(id: 'tag', name: 'Trip', color: 'FF0000', displayOrder: 0);

List<List<dynamic>> _export(List<MoneyTransaction> transactions) => Csv()
    .decode(BackupDatabaseService().createCsvFromTransactions(transactions));

void main() {
  test('exports one aligned row per account of a transfer', () {
    final transfer = MoneyTransaction(
      id: 'transfer',
      date: DateTime(2026, 5, 15),
      value: 100,
      valueInDestiny: 110,
      isHidden: false,
      type: TransactionType.transfer,
      account: _account('Bank', 'EUR'),
      accountCurrency: _eur,
      receivingAccount: _account('Savings', 'USD'),
      receivingAccountCurrency: _usd,
      currentValueInPreferredCurrency: 100,
      tags: const [_tag],
    );

    final rows = _export([transfer]);
    final header = rows.first;

    expect(rows, hasLength(3));
    for (final row in rows) {
      expect(row, hasLength(header.length));
    }
    expect(rows[1].sublist(1, 2), ['-100.00']);
    expect(rows[1].sublist(5), ['Bank', 'EUR', 'TRANSFER', '', 'Trip']);
    expect(rows[2].sublist(1, 2), ['110.00']);
    expect(rows[2].sublist(5), ['Savings', 'USD', 'TRANSFER', '', 'Trip']);
  });

  test('exports category and subcategory in their own columns', () {
    final expense = MoneyTransaction(
      id: 'expense',
      date: DateTime(2026, 5, 15),
      value: -25,
      isHidden: false,
      type: TransactionType.expense,
      account: _account('Bank', 'EUR'),
      accountCurrency: _eur,
      category: const CategoryInDB(
        id: 'sub',
        name: 'Restaurants',
        iconId: 'food',
        displayOrder: 0,
        parentCategoryID: 'parent',
      ),
      parentCategory: const CategoryInDB(
        id: 'parent',
        name: 'Food',
        iconId: 'food',
        displayOrder: 0,
      ),
      currentValueInPreferredCurrency: -25,
      tags: const [],
    );

    final rows = _export([expense]);

    expect(rows, hasLength(2));
    expect(rows[1].sublist(5), ['Bank', 'EUR', 'Food', 'Restaurants', '']);
  });
}

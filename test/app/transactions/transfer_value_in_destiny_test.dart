import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';

/// A transfer between accounts of different currencies must store the amount
/// that lands in the receiving account (`valueInDestiny`). When it is null the
/// balance falls back to the origin amount, crediting it unconverted.
void main() {
  Account account(String id, String code, {int decimals = 2}) => Account(
    id: id,
    name: id,
    iniValue: 0,
    date: DateTime(2020),
    type: AccountType.money,
    iconId: 'wallet',
    displayOrder: 0,
    currency: Currency(
      code: code,
      symbol: code,
      name: code,
      decimalPlaces: decimals,
    ),
    isSaving: false,
    trackingMode: AccountTrackingMode.transactions,
  );

  final eur = account('eur', 'EUR');
  final eurSecond = account('eur2', 'EUR');
  final gbp = account('gbp', 'GBP');
  final jpy = account('jpy', 'JPY', decimals: 0);

  group('resolveValueInDestiny', () {
    test('stays null for accounts with the same currency', () async {
      final res = await TransactionFormController.resolveValueInDestiny(
        from: eur,
        to: eurSecond,
        custom: null,
        convert: () async => fail('Should not convert'),
      );

      expect(res, isNull);
    });

    test('converts when currencies differ and no custom amount', () async {
      final res = await TransactionFormController.resolveValueInDestiny(
        from: eur,
        to: gbp,
        custom: null,
        convert: () async => 82.5,
      );

      expect(res, 82.5);
    });

    test('rounds to the decimals of the destination currency', () async {
      final res = await TransactionFormController.resolveValueInDestiny(
        from: eur,
        to: jpy,
        custom: null,
        convert: () async => 16234.567,
      );

      expect(res, 16235);
    });

    test('keeps the custom amount', () async {
      final res = await TransactionFormController.resolveValueInDestiny(
        from: eur,
        to: gbp,
        custom: 80,
        convert: () async => fail('Should not convert'),
      );

      expect(res, 80);
    });
  });

  group('receiving account balance', () {
    late AppDB db;
    late TransactionService service;

    setUp(() async {
      db = AppDB.forTesting(NativeDatabase.memory());
      service = TransactionService.forTesting(db);

      for (final code in ['EUR', 'GBP']) {
        await db
            .into(db.currencies)
            .insert(
              CurrencyInDB(
                code: code,
                symbol: code,
                name: code,
                decimalPlaces: 2,
                isDefault: code == 'EUR',
                type: 0,
              ),
            );
        await db
            .into(db.accounts)
            .insert(
              AccountInDB(
                id: code,
                name: code,
                iniValue: 0,
                date: DateTime(2020),
                type: AccountType.money,
                isSaving: false,
                trackingMode: AccountTrackingMode.transactions,
                iconId: 'wallet',
                displayOrder: 0,
                currencyId: code,
              ),
            );
      }
    });

    tearDown(() => db.close());

    Future<double> gbpBalance() => service
        .getTransactionsValueBalance(
          filters: const TransactionFilterSet(accountsIDs: ['GBP']),
          convertToPreferredCurrency: false,
        )
        .first;

    Future<void> transfer(double? valueInDestiny) => db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: 'tr',
            date: DateTime(2024),
            accountID: 'EUR',
            receivingAccountID: 'GBP',
            value: 100,
            valueInDestiny: valueInDestiny,
            type: TransactionType.transfer,
            isHidden: false,
          ),
        );

    test('is credited the converted amount when it is stored', () async {
      await transfer(82.5);

      expect(await gbpBalance(), 82.5);
    });

    test('is credited the unconverted amount when it is null', () async {
      await transfer(null);

      expect(await gbpBalance(), 100);
    });
  });
}

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';

/// A portfolio snapshot is the authoritative state of a holdings-mode account
/// on its date: its positions *and* its cash. These tests cover the correction
/// that makes the declared cash take over from the transaction ledger, by
/// running the very query `AccountService` runs
/// (`snapshotCashAdjustmentQuery`), so a balance of
/// `iniValue + ledger + adjustment` lands on
/// `declared cash + the flows posted after the snapshot`.
void main() {
  late AppDB db;

  const investmentAccount = 'acc-inv';
  const otherAccount = 'acc-other';

  setUp(() {
    db = AppDB.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> insertAccount(
    String id, {
    AccountTrackingMode mode = AccountTrackingMode.holdings,
    double iniValue = 0,
    DateTime? openedOn,
  }) {
    return db
        .into(db.accounts)
        .insert(
          AccountInDB(
            id: id,
            name: 'Account $id',
            iniValue: iniValue,
            date: openedOn ?? DateTime(2026),
            type: AccountType.investment,
            isSaving: false,
            trackingMode: mode,
            iconId: 'wallet',
            displayOrder: 0,
            currencyId: 'EUR',
          ),
        );
  }

  Future<void> insertSnapshot(
    String id, {
    required String accountId,
    required DateTime date,
    required double cash,
  }) {
    return db
        .into(db.accountSnapshots)
        .insert(
          AccountSnapshotInDB(
            id: id,
            accountID: accountId,
            date: date,
            cash: cash,
          ),
        );
  }

  Future<void> insertLedgerRow({
    required String id,
    required DateTime date,
    required double value,
    String accountId = investmentAccount,
    TransactionType type = TransactionType.income,
    String? receivingAccountId,
    double? valueInDestiny,
    TransactionStatus? status,
  }) {
    return db
        .into(db.transactions)
        .insert(
          TransactionInDB(
            id: id,
            date: date,
            accountID: accountId,
            value: value,
            type: type,
            isHidden: false,
            status: status,
            receivingAccountID: receivingAccountId,
            valueInDestiny: valueInDestiny,
            // Income and expense rows need a category, transfers a receiving
            // account (enforced by a CHECK on the table).
            categoryID: type == TransactionType.transfer ? null : 'cat-1',
          ),
        );
  }

  /// Runs the production adjustment query at [date], for every account or just
  /// [accountIds].
  Future<double> adjustmentAt(DateTime date, {List<String>? accountIds}) async {
    final res = await db
        .customSelect(
          AccountService.snapshotCashAdjustmentQuery(
            accountIdsCount: accountIds?.length,
          ),
          variables: [
            Variable.withDateTime(date),
            if (accountIds != null)
              for (final id in accountIds) Variable.withString(id),
          ],
        )
        .getSingle();

    return (res.data['adjustment'] as num).toDouble();
  }

  test('an account without snapshots is never anchored', () async {
    await insertAccount(investmentAccount);
    await insertLedgerRow(id: 'tx-1', date: DateTime(2026, 7), value: 1664);

    expect(await adjustmentAt(DateTime(2026, 12)), 0);
  });

  test('a snapshot agreeing with the ledger changes nothing', () async {
    await insertAccount(investmentAccount);
    await insertLedgerRow(id: 'tx-1', date: DateTime(2026, 7), value: 1664);
    await insertSnapshot(
      'snap-1',
      accountId: investmentAccount,
      date: DateTime(2026, 7, 31),
      cash: 1664,
    );

    expect(await adjustmentAt(DateTime(2026, 8, 15)), closeTo(0, 0.0001));
  });

  test(
    'declaring the cash spent on positions removes it from the balance',
    () async {
      // 1664 € transferred in, then 1736 € of it declared as positions: the
      // user says only 1664 - 1736 = -72 € of cash is left.
      await insertAccount(investmentAccount);
      await insertLedgerRow(id: 'tx-1', date: DateTime(2026, 7), value: 1664);
      await insertSnapshot(
        'snap-1',
        accountId: investmentAccount,
        date: DateTime(2026, 7, 31),
        cash: -72,
      );

      expect(await adjustmentAt(DateTime(2026, 8, 15)), closeTo(-1736, 0.0001));
    },
  );

  test('the opening balance is absorbed by the snapshot', () async {
    await insertAccount(investmentAccount, iniValue: 500);
    await insertSnapshot(
      'snap-1',
      accountId: investmentAccount,
      date: DateTime(2026, 3),
      cash: 0,
    );

    // iniValue + ledger + adjustment = 500 + 0 - 500 = 0, the declared cash.
    expect(await adjustmentAt(DateTime(2026, 6)), closeTo(-500, 0.0001));
  });

  test('an opening balance later than the snapshot is not cancelled', () async {
    await insertAccount(
      investmentAccount,
      iniValue: 500,
      openedOn: DateTime(2026, 6),
    );
    await insertSnapshot(
      'snap-1',
      accountId: investmentAccount,
      date: DateTime(2026, 3),
      cash: 0,
    );

    expect(await adjustmentAt(DateTime(2026, 8)), closeTo(0, 0.0001));
  });

  test('flows posted after the snapshot survive on top of it', () async {
    await insertAccount(investmentAccount);
    await insertLedgerRow(id: 'tx-1', date: DateTime(2026, 7), value: 1000);
    await insertSnapshot(
      'snap-1',
      accountId: investmentAccount,
      date: DateTime(2026, 7, 31),
      cash: 0,
    );
    // Interest paid after the snapshot: still counted, as any ledger row is.
    await insertLedgerRow(id: 'tx-2', date: DateTime(2026, 8, 10), value: 25);

    final adjustment = await adjustmentAt(DateTime(2026, 8, 31));

    // iniValue + ledger + adjustment = 0 + (1000 + 25) - 1000 = 25.
    expect(adjustment, closeTo(-1000, 0.0001));
    expect(0 + 1025 + adjustment, closeTo(25, 0.0001));
  });

  test(
    'the latest snapshot on or before the date is the one that counts',
    () async {
      await insertAccount(investmentAccount);
      await insertSnapshot(
        'snap-jul',
        accountId: investmentAccount,
        date: DateTime(2026, 7),
        cash: 100,
      );
      await insertSnapshot(
        'snap-sep',
        accountId: investmentAccount,
        date: DateTime(2026, 9),
        cash: 700,
      );

      expect(await adjustmentAt(DateTime(2026, 6)), 0);
      expect(await adjustmentAt(DateTime(2026, 8)), closeTo(100, 0.0001));
      expect(await adjustmentAt(DateTime(2026, 10)), closeTo(700, 0.0001));
    },
  );

  test('transfer legs are netted from the right side', () async {
    await insertAccount(investmentAccount);
    await insertAccount(otherAccount, mode: AccountTrackingMode.transactions);

    // 300 € into the investment account, 50 € back out of it.
    await insertLedgerRow(
      id: 'tx-in',
      date: DateTime(2026, 2),
      accountId: otherAccount,
      receivingAccountId: investmentAccount,
      type: TransactionType.transfer,
      value: 300,
      valueInDestiny: 300,
    );
    await insertLedgerRow(
      id: 'tx-out',
      date: DateTime(2026, 3),
      accountId: investmentAccount,
      receivingAccountId: otherAccount,
      type: TransactionType.transfer,
      value: 50,
      valueInDestiny: 50,
    );

    await insertSnapshot(
      'snap-1',
      accountId: investmentAccount,
      date: DateTime(2026, 4),
      cash: 0,
    );

    // The account's ledger reads +300 - 50 = 250, all of it superseded.
    expect(
      await adjustmentAt(
        DateTime(2026, 5),
        accountIds: const [investmentAccount],
      ),
      closeTo(-250, 0.0001),
    );
  });

  test('a currency exchange transfer uses the destination amount', () async {
    await insertAccount(investmentAccount);
    await insertAccount(otherAccount, mode: AccountTrackingMode.transactions);

    // 100 charged on the origin, 92 credited to the investment account.
    await insertLedgerRow(
      id: 'tx-fx',
      date: DateTime(2026, 2),
      accountId: otherAccount,
      receivingAccountId: investmentAccount,
      type: TransactionType.transfer,
      value: 100,
      valueInDestiny: 92,
    );
    await insertSnapshot(
      'snap-1',
      accountId: investmentAccount,
      date: DateTime(2026, 4),
      cash: 0,
    );

    expect(
      await adjustmentAt(
        DateTime(2026, 5),
        accountIds: const [investmentAccount],
      ),
      closeTo(-92, 0.0001),
    );
  });

  test(
    'voided and pending rows are ignored, as they are in balances',
    () async {
      await insertAccount(investmentAccount);
      await insertLedgerRow(
        id: 'tx-void',
        date: DateTime(2026, 2),
        value: 400,
        status: TransactionStatus.voided,
      );
      await insertLedgerRow(
        id: 'tx-pending',
        date: DateTime(2026, 2),
        value: 900,
        status: TransactionStatus.pending,
      );
      await insertLedgerRow(
        id: 'tx-real',
        date: DateTime(2026, 2),
        value: 30,
        status: TransactionStatus.reconciled,
      );
      await insertSnapshot(
        'snap-1',
        accountId: investmentAccount,
        date: DateTime(2026, 4),
        cash: 0,
      );

      expect(await adjustmentAt(DateTime(2026, 5)), closeTo(-30, 0.0001));
    },
  );

  test('accounts tracked by transactions are left alone', () async {
    await insertAccount(
      investmentAccount,
      mode: AccountTrackingMode.transactions,
    );
    await insertLedgerRow(id: 'tx-1', date: DateTime(2026, 2), value: 1000);
    // A leftover snapshot from a previous stint in holdings mode.
    await insertSnapshot(
      'snap-1',
      accountId: investmentAccount,
      date: DateTime(2026, 4),
      cash: 0,
    );

    expect(await adjustmentAt(DateTime(2026, 5)), 0);
  });

  test('only the accounts in scope are anchored', () async {
    await insertAccount(investmentAccount);
    await insertAccount(otherAccount);

    await insertSnapshot(
      'snap-a',
      accountId: investmentAccount,
      date: DateTime(2026, 4),
      cash: 10,
    );
    await insertSnapshot(
      'snap-b',
      accountId: otherAccount,
      date: DateTime(2026, 4),
      cash: 25,
    );

    expect(
      await adjustmentAt(
        DateTime(2026, 5),
        accountIds: const [investmentAccount],
      ),
      closeTo(10, 0.0001),
    );
    expect(await adjustmentAt(DateTime(2026, 5)), closeTo(35, 0.0001));
  });
}

import 'dart:math';

import 'package:drift/drift.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/debt/debt_direction.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:rxdart/rxdart.dart';

class DebtServive {
  final AppDB db;

  DebtServive._(this.db);
  static final DebtServive instance = DebtServive._(AppDB.instance);

  Future<int> insertDebt(DebtInDB debt) {
    return db.into(db.debts).insert(debt);
  }

  Future<bool> updateDebt(DebtInDB debt) {
    return db.update(db.debts).replace(debt);
  }

  Future<int> deleteDebt(String debtId) {
    return (db.delete(db.debts)..where((tbl) => tbl.id.equals(debtId))).go();
  }

  /// Gets the total amount of the debt to be fully paid back
  Stream<double> getDebtTotalAmount(
    Debt debt, {
    bool countInitialAmount = true,
  }) {
    return TransactionService.instance
        .getTransactionsValueBalance(
          filters: TransactionFilterSet(
            debtId: debt.id,
            transactionTypes: [
              if (debt.type == DebtDirection.lent) TransactionType.expense,
              if (debt.type == DebtDirection.borrowed) TransactionType.income,
            ],
          ),
        )
        .switchMap((balance) {
          final prefCurrency = appStateSettings[SettingKey.preferredCurrency];

          if (prefCurrency == null) {
            return Stream.value(balance);
          }

          return ExchangeRateService.instance.calculateExchangeRate(
            fromCurrency: prefCurrency,
            toCurrency: debt.currencyId,
            amount: balance,
          );
        })
        .map((balanceInDebtCurrency) {
          if (debt.type == DebtDirection.lent) {
            // For lent debts, the balance is negative because it's an outgoing transaction, but we want to sum it to the initial amount, so we convert it to positive
            balanceInDebtCurrency = -balanceInDebtCurrency;
          }

          if (!countInitialAmount) {
            return balanceInDebtCurrency;
          }

          return debt.initialAmount + balanceInDebtCurrency;
        });
  }

  /// Gets the remaining amount of the debt in order to be completed/closed.
  Stream<double> getDebtRemainingAmount(
    Debt debt, {
    bool countInitialAmount = true,
  }) {
    return TransactionService.instance
        .getTransactionsValueBalance(
          filters: TransactionFilterSet(debtId: debt.id),
        )
        .switchMap((balance) {
          final prefCurrency = appStateSettings[SettingKey.preferredCurrency];

          if (prefCurrency == null) {
            return Stream.value(balance);
          }

          return ExchangeRateService.instance.calculateExchangeRate(
            fromCurrency: prefCurrency,
            toCurrency: debt.currencyId,
            amount: balance,
          );
        })
        .map((balanceInDebtCurrency) {
          double toReturn = balanceInDebtCurrency;

          if (countInitialAmount) {
            if (debt.type == DebtDirection.borrowed) {
              toReturn = debt.initialAmount + balanceInDebtCurrency;
            } else {
              toReturn = debt.initialAmount - balanceInDebtCurrency;
            }
          }

          return max(toReturn, 0);
        });
  }

  /// Gets the amount of the debt that has been already collected/paid
  Stream<double> getDebtPaidAmount(Debt debt) {
    return Rx.combineLatest2(
      getDebtTotalAmount(debt, countInitialAmount: false),
      getDebtRemainingAmount(debt, countInitialAmount: false),
      (totalWithoutInitial, remainingWithoutInitial) =>
          totalWithoutInitial - remainingWithoutInitial,
    );
  }

  Stream<List<Debt>> getDebts({
    Expression<bool> Function(Debts, Currencies)? predicate,
    OrderBy Function(Debts, Currencies)? orderBy,
    int? limit,
    int? offset,
  }) {
    return db
        .getDebtsWithFullData(
          predicate: predicate,
          orderBy: orderBy,
          limit: (b, trFilter) => Limit(limit ?? -1, offset),
        )
        .watch();
  }

  /// Links an existing transaction to this debt by updating its [debtId] field.
  /// Only the [debtId] column is written; all other transaction data is preserved.
  Future<int> linkTransactionToDebt({
    required String transactionId,
    required String debtId,
  }) {
    return (db.update(db.transactions)
          ..where((tbl) => tbl.id.equals(transactionId)))
        .write(TransactionsCompanion(debtId: Value(debtId)));
  }

  Stream<Debt?> getDebtById(String id) {
    return getDebts(
      predicate: (p0, trFilter) => p0.id.equals(id),
      limit: 1,
    ).map((res) => res.firstOrNull);
  }
}

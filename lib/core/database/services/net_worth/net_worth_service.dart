import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/account/asset_valuation_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/database/services/exchange-rate/exchange_rate_service.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:rxdart/rxdart.dart';

/// Gross assets and net worth in the user’s preferred currency.
///
/// **Gross assets** = all account balances ([AccountService.getAccountsMoney],
/// which already include the market value of each account's holdings) plus the
/// value of every asset ([AssetValuationService.getTotalAssetsValueAtDate]).
/// See `docs/BALANCE_FORMULAS.md` in the repo.
class NetWorthService {
  NetWorthService._();
  static final NetWorthService instance = NetWorthService._();

  /// All accounts (per [AccountService.getAccountsMoney]) plus every asset at
  /// [date], converted to the preferred currency.
  Stream<double> getGrossAssetsAtDate(
    DateTime date, {
    TransactionFilterSet trFilters = const TransactionFilterSet(),
  }) {
    return Rx.combineLatest2(
      AccountService.instance.getAccountsMoney(
        date: date,
        accountIds: trFilters.accountsIDs,
        trFilters: trFilters,
        convertToPreferredCurrency: true,
      ),
      AssetValuationService.instance.getTotalAssetsValueAtDate(date: date),
      (accountsTotal, assetsTotal) => accountsTotal + assetsTotal,
    );
  }

  /// Sum of each debt’s **remaining** balance, converted to the preferred currency.
  ///
  /// [exchangeRateAsOf] is used only for currency conversion. Remaining amounts
  /// follow [DebtService.getDebtRemainingAmount] (current ledger), matching
  /// [NetWorthEvolutionCard] behaviour.
  Stream<double> getTotalDebtsInPreferredCurrency({
    DateTime? exchangeRateAsOf,
  }) {
    final asOf = exchangeRateAsOf ?? DateTime.now();

    return Rx.combineLatest2(
      CurrencyService.instance.ensureAndGetPreferredCurrency(),
      DebtService.instance.getDebts(),
      (Currency pref, List<Debt> debts) => (pref, debts),
    ).switchMap((tuple) {
      final pref = tuple.$1;
      final debts = tuple.$2;
      if (debts.isEmpty) {
        return Stream.value(0.0);
      }

      final streams = debts.map((Debt debt) {
        return DebtService.instance.getDebtRemainingAmount(debt).switchMap((
          double remaining,
        ) {
          if (debt.currency.code == pref.code) {
            return Stream.value(remaining);
          }
          return ExchangeRateService.instance
              .calculateExchangeRateToPreferredCurrency(
                fromCurrency: debt.currency.code,
                amount: remaining,
                date: asOf,
              );
        });
      }).toList();

      return Rx.combineLatestList(
        streams,
      ).map((values) => values.fold<double>(0, (a, b) => a + b));
    });
  }

  /// [getGrossAssetsAtDate] minus [getTotalDebtsInPreferredCurrency].
  Stream<double> getNetWorthAtDate(
    DateTime date, {
    TransactionFilterSet trFilters = const TransactionFilterSet(),
  }) {
    return Rx.combineLatest2(
      getGrossAssetsAtDate(date, trFilters: trFilters),
      getTotalDebtsInPreferredCurrency(exchangeRateAsOf: date),
      (gross, debts) => gross - debts,
    );
  }
}

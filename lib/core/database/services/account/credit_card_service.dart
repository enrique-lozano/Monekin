import 'dart:math';

import 'package:monekin/core/database/services/account/account_service.dart';
import 'package:monekin/core/database/services/transaction/transaction_service.dart';
import 'package:monekin/core/extensions/numbers.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/account/credit_card_cycle.dart';
import 'package:monekin/core/models/account/installment_purchase.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:rxdart/rxdart.dart';

/// Snapshot of where a credit card stands. Every amount is in the account
/// currency. Debts are positive numbers here (unlike the account balance, which
/// is negative while something is owed).
class CreditCardStatus {
  const CreditCardStatus({
    required this.cycle,
    required this.balance,
    required this.statementBalance,
    required this.paymentsSinceCutoff,
    required this.periodCharges,
    this.previousStatementBalance = 0,
    this.paymentsSincePreviousCutoff = 0,
    this.installmentPurchases = const [],
    this.decimals = 2,
    this.creditLimit,
    this.minPaymentPct,
  });

  final CreditCardCycle cycle;

  /// Current balance of the account. Negative while something is owed.
  final double balance;

  /// Balance of the account at the end of the last cut-off day.
  final double statementBalance;

  /// Net money that came into the card (payments, refunds, incomes) since the
  /// last cut-off.
  final double paymentsSinceCutoff;

  /// Net purchases (expenses) made since the last cut-off. Positive.
  final double periodCharges;

  /// Balance of the account at the end of [CreditCardCycle.previousCutoff].
  final double previousStatementBalance;

  /// Net money that came into the card since [CreditCardCycle.previousCutoff].
  final double paymentsSincePreviousCutoff;

  /// Purchases paid in installments made up to now. The account balances above
  /// count them whole, and the statement getters take back the part that is
  /// not billed yet.
  final List<InstallmentPurchase> installmentPurchases;

  /// Decimals of the account currency, used to round the derived amounts.
  final int decimals;

  final double? creditLimit;
  final double? minPaymentPct;

  /// Everything owed right now.
  double get totalDebt => max(0, -balance);

  /// Installment debt that, at the end of [cutoff], no statement has billed.
  double _unbilledAt(DateTime cutoff) => installmentPurchases.fold(
    0,
    (sum, p) => sum + p.unbilledAt(cutoff, cycle.cutoffDay),
  );

  /// What the last statement asked to pay.
  double get statementDebt => max(
    0,
    -(statementBalance + _unbilledAt(cycle.lastCutoff)),
  ).roundWithDecimals(decimals);

  /// What is left to pay of the last statement to avoid interest.
  double get statementPaymentLeft => max(
    0,
    statementDebt - max(0, paymentsSinceCutoff),
  ).roundWithDecimals(decimals);

  /// What is still unpaid of the statement before the last one, whose due
  /// date ([CreditCardCycle.previousPaymentDueDate]) has already passed. It is
  /// part of [statementPaymentLeft] too, since unpaid debt carries over.
  double get previousStatementOverdue => max(
    0,
    -(previousStatementBalance + _unbilledAt(cycle.previousCutoff)) -
        max(0, paymentsSincePreviousCutoff),
  ).roundWithDecimals(decimals);

  /// What the statement that closes on [CreditCardCycle.nextCutoff] bills so
  /// far: the purchases of the current period, with installment purchases
  /// replaced by the installments it bills (of new and older purchases alike).
  double get nextStatementCharges {
    final installmentsCharged = installmentPurchases.fold<double>(
      0,
      (sum, p) => sum + p.chargeAt(cycle, cycle.nextCutoff),
    );
    final installmentPurchasesOfPeriod = installmentPurchases
        .where((p) => !p.date.isBefore(cycle.periodStart))
        .fold<double>(0, (sum, p) => sum + p.amount);

    return (periodCharges - installmentPurchasesOfPeriod + installmentsCharged)
        .roundWithDecimals(decimals);
  }

  /// Installment debt left for the statements after the next one.
  double get installmentsPending =>
      _unbilledAt(cycle.nextCutoff).roundWithDecimals(decimals);

  /// Installments each upcoming statement will bill, starting with the next
  /// one, until every purchase is billed.
  List<({DateTime cutoff, DateTime dueDate, double amount})>
  get upcomingInstallments {
    final res = <({DateTime cutoff, DateTime dueDate, double amount})>[];

    var cutoff = cycle.nextCutoff;
    while (res.isEmpty || _unbilledAt(res.last.cutoff) > 0) {
      final amount = installmentPurchases.fold<double>(
        0,
        (sum, p) => sum + p.chargeAt(cycle, cutoff),
      );
      res.add((
        cutoff: cutoff,
        dueDate: cycle.dueDateOf(cutoff),
        amount: amount.roundWithDecimals(decimals),
      ));
      cutoff = cycle.cutoffAfter(cutoff, 1);
    }

    return res.where((e) => e.amount > 0).toList();
  }

  /// Credit that can still be used. A positive balance (overpaid card) adds
  /// to the limit. `null` when the card has no limit set.
  double? get availableCredit =>
      creditLimit == null ? null : creditLimit! + balance;

  /// Share of the limit in use, between 0 and 1 (can go above 1 if the limit is
  /// exceeded). `null` when the card has no positive limit set.
  double? get utilization => creditLimit == null || creditLimit! <= 0
      ? null
      : totalDebt / creditLimit!;

  /// Estimated minimum payment still due for the last statement. Banks use
  /// their own rules, so this is only an estimate.
  double? get minPaymentLeft => minPaymentPct == null
      ? null
      : max(0, statementDebt * minPaymentPct! - max(0, paymentsSinceCutoff));
}

class CreditCardService {
  CreditCardService._();
  static final CreditCardService instance = CreditCardService._();

  /// The [CreditCardStatus] of a credit [account] at [date].
  ///
  /// [date] defaults to the end of today, so that transactions added later
  /// today still count while the stream is being listened to.
  ///
  /// Returns a stream of `null` if the account isn't a credit card or misses
  /// its cut-off/due days.
  Stream<CreditCardStatus?> getStatus(Account account, {DateTime? date}) {
    if (!account.isCredit ||
        account.cutoffDay == null ||
        account.dueDay == null) {
      return Stream.value(null);
    }

    final cycle = CreditCardCycle.of(
      cutoffDay: account.cutoffDay!,
      dueDay: account.dueDay!,
      date: date,
    );

    final now = DateTime.now();
    date ??= DateTime(now.year, now.month, now.day + 1);

    final balance = AccountService.instance.getAccountMoney(
      account: account,
      date: date,
    );

    // `maxDate` is exclusive, so the start of the current period is the end
    // of the cut-off day.
    //
    // A card registered after its last cut-off brings a debt that was already
    // billed, so its opening balance counts as part of that statement. It is
    // never counted in the previous one, so it can't show up as overdue.
    final openedInCurrentPeriod = !account.date.isBefore(cycle.periodStart);
    final statementBalance = AccountService.instance
        .getAccountMoney(account: account, date: cycle.periodStart)
        .map((b) => openedInCurrentPeriod ? b + account.iniValue : b);

    final previousStatementBalance = AccountService.instance.getAccountMoney(
      account: account,
      date: cycle.previousPeriodStart,
    );

    Stream<double> periodFlow(List<TransactionType> types, {DateTime? from}) =>
        TransactionService.instance.getTransactionsValueBalance(
          filters: TransactionFilterSet(
            accountsIDs: [account.id],
            minDate: from ?? cycle.periodStart,
            maxDate: date,
            transactionTypes: types,
          ),
          convertToPreferredCurrency: false,
        );

    final decimals = account.currency.decimalPlaces;

    final installmentPurchases = TransactionService.instance
        .getTransactionsFromPredicate(
          predicate:
              TransactionFilterSet(
                accountsIDs: [account.id],
                maxDate: date,
                transactionTypes: const [TransactionType.expense],
                status: TransactionStatus.getStatusThatCountsForStats(null),
              ).toTransactionExpression(
                extraFilters: (t, a, ac, ra, rac, c, pc) => [
                  t.installments.isNotNull(),
                ],
              ),
        )
        .map(
          (txs) => txs
              .map(
                (tx) => InstallmentPurchase(
                  date: tx.date,
                  amount: -tx.value,
                  count: tx.installments!,
                  decimals: decimals,
                ),
              )
              .toList(),
        );

    const credits = [TransactionType.income, TransactionType.transfer];

    return Rx.combineLatest7(
      balance,
      statementBalance,
      periodFlow(credits),
      periodFlow([TransactionType.expense, TransactionType.investment]),
      previousStatementBalance,
      periodFlow(credits, from: cycle.previousPeriodStart),
      installmentPurchases,
      (
        double bal,
        double stmt,
        double payments,
        double charges,
        double prevStmt,
        double prevPayments,
        List<InstallmentPurchase> installments,
      ) => CreditCardStatus(
        cycle: cycle,
        balance: bal,
        statementBalance: stmt,
        paymentsSinceCutoff: payments.roundWithDecimals(decimals),
        periodCharges: (-charges).roundWithDecimals(decimals),
        previousStatementBalance: prevStmt,
        paymentsSincePreviousCutoff: prevPayments.roundWithDecimals(decimals),
        installmentPurchases: installments,
        decimals: decimals,
        creditLimit: account.creditLimit,
        minPaymentPct: account.minPaymentPct,
      ),
    );
  }
}

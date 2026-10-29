import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/services/account/credit_card_service.dart';
import 'package:monekin/core/models/account/credit_card_cycle.dart';

void main() {
  group('CreditCardCycle.dayInMonth', () {
    test('clamps days a month does not have to its last day', () {
      expect(CreditCardCycle.dayInMonth(2026, 2, 31), DateTime(2026, 2, 28));
      expect(CreditCardCycle.dayInMonth(2028, 2, 30), DateTime(2028, 2, 29));
      expect(CreditCardCycle.dayInMonth(2026, 4, 31), DateTime(2026, 4, 30));
      expect(CreditCardCycle.dayInMonth(2026, 1, 31), DateTime(2026, 1, 31));
    });

    test('handles month overflow in both directions', () {
      expect(CreditCardCycle.dayInMonth(2026, 13, 15), DateTime(2027, 1, 15));
      expect(CreditCardCycle.dayInMonth(2026, 0, 31), DateTime(2025, 12, 31));
    });
  });

  group('CreditCardCycle.of', () {
    test('mid-cycle: last cut-off this month, next one the following', () {
      final c = CreditCardCycle.of(
        cutoffDay: 10,
        dueDay: 30,
        date: DateTime(2026, 10, 22, 15, 30),
      );

      expect(c.lastCutoff, DateTime(2026, 10, 10));
      expect(c.nextCutoff, DateTime(2026, 11, 10));
      expect(c.paymentDueDate, DateTime(2026, 10, 30));
      expect(c.nextPaymentDueDate, DateTime(2026, 11, 30));
      expect(c.periodStart, DateTime(2026, 10, 11));
      expect(c.periodEnd, DateTime(2026, 11, 11));
      expect(c.daysToCutoff(DateTime(2026, 10, 22, 15, 30)), 19);
      expect(c.daysToPaymentDue(DateTime(2026, 10, 22)), 8);
    });

    test('the cut-off day itself still belongs to the closing statement', () {
      final c = CreditCardCycle.of(
        cutoffDay: 10,
        dueDay: 30,
        date: DateTime(2026, 10, 10, 23, 59),
      );

      expect(c.nextCutoff, DateTime(2026, 10, 10));
      expect(c.lastCutoff, DateTime(2026, 9, 10));
      expect(c.daysToCutoff(DateTime(2026, 10, 10)), 0);
    });

    test('the day after the cut-off starts a new period', () {
      final c = CreditCardCycle.of(
        cutoffDay: 10,
        dueDay: 30,
        date: DateTime(2026, 10, 11),
      );

      expect(c.lastCutoff, DateTime(2026, 10, 10));
      expect(c.periodStart, DateTime(2026, 10, 11));
    });

    test('due day before the cut-off day falls in the next month', () {
      final c = CreditCardCycle.of(
        cutoffDay: 25,
        dueDay: 15,
        date: DateTime(2026, 10, 28),
      );

      expect(c.lastCutoff, DateTime(2026, 10, 25));
      expect(c.paymentDueDate, DateTime(2026, 11, 15));
    });

    test('cut-off on the 31st clamps through February', () {
      final inFeb = CreditCardCycle.of(
        cutoffDay: 31,
        dueDay: 20,
        date: DateTime(2026, 2, 15),
      );
      expect(inFeb.lastCutoff, DateTime(2026, 1, 31));
      expect(inFeb.nextCutoff, DateTime(2026, 2, 28));
      expect(inFeb.paymentDueDate, DateTime(2026, 2, 20));

      final afterFeb = CreditCardCycle.of(
        cutoffDay: 31,
        dueDay: 20,
        date: DateTime(2026, 3, 1),
      );
      expect(afterFeb.lastCutoff, DateTime(2026, 2, 28));
      expect(afterFeb.nextCutoff, DateTime(2026, 3, 31));
      expect(afterFeb.paymentDueDate, DateTime(2026, 3, 20));
    });

    test('cut-off on the 30th in a leap-year February', () {
      final c = CreditCardCycle.of(
        cutoffDay: 30,
        dueDay: 30,
        date: DateTime(2028, 3, 5),
      );

      expect(c.lastCutoff, DateTime(2028, 2, 29));
      expect(c.nextCutoff, DateTime(2028, 3, 30));
      // Due day 30 right after a Feb 29 cut-off is March 30.
      expect(c.paymentDueDate, DateTime(2028, 3, 30));
    });

    test('crosses the year boundary', () {
      final c = CreditCardCycle.of(
        cutoffDay: 5,
        dueDay: 25,
        date: DateTime(2026, 12, 20),
      );

      expect(c.lastCutoff, DateTime(2026, 12, 5));
      expect(c.nextCutoff, DateTime(2027, 1, 5));
      expect(c.nextPaymentDueDate, DateTime(2027, 1, 25));
    });
  });

  test('cut-off 15, due 5: each statement is paid the next month', () {
    final c = CreditCardCycle.of(
      cutoffDay: 15,
      dueDay: 5,
      date: DateTime(2026, 10, 22),
    );

    // Aug 16 - Sep 15, paid by Oct 5
    expect(c.previousCutoff, DateTime(2026, 9, 15));
    expect(c.previousPaymentDueDate, DateTime(2026, 10, 5));
    // Sep 16 - Oct 15, paid by Nov 5
    expect(c.lastCutoff, DateTime(2026, 10, 15));
    expect(c.paymentDueDate, DateTime(2026, 11, 5));
    // Oct 16 - Nov 15, paid by Dec 5
    expect(c.nextCutoff, DateTime(2026, 11, 15));
    expect(c.nextPaymentDueDate, DateTime(2026, 12, 5));
  });

  test('the previous due date is not always past (month-end days)', () {
    // Cut-off 29 and due day 31: the Feb 28 statement is due on Mar 31.
    CreditCardCycle at(DateTime d) =>
        CreditCardCycle.of(cutoffDay: 29, dueDay: 31, date: d);

    final mar30 = at(DateTime(2026, 3, 30));
    expect(mar30.previousCutoff, DateTime(2026, 2, 28));
    expect(mar30.previousPaymentDueDate, DateTime(2026, 3, 31));
    expect(mar30.isPreviousPaymentDue(DateTime(2026, 3, 30)), isFalse);
    expect(mar30.isPreviousPaymentDue(DateTime(2026, 4, 1)), isTrue);
  });

  group('opening debt', () {
    // Cut-off 15, due 5. A card registered on Oct 22 brings the debt of the
    // Oct 15 statement, due Nov 5.
    final opened = DateTime(2026, 10, 22, 14, 30);

    test('belongs to the statement closed before the opening date', () {
      final c = CreditCardCycle.of(
        cutoffDay: 15,
        dueDay: 5,
        date: DateTime(2026, 10, 25),
      );

      expect(c.billsOpeningDebt(c.lastCutoff, opened), isTrue);
      expect(c.billsOpeningDebt(c.previousCutoff, opened), isFalse);
    });

    test('stays in that statement once it becomes the previous one', () {
      final c = CreditCardCycle.of(
        cutoffDay: 15,
        dueDay: 5,
        date: DateTime(2026, 11, 20),
      );

      expect(c.billsOpeningDebt(c.previousCutoff, opened), isTrue);
      // The balance at the end of Nov 15 already includes it.
      expect(c.billsOpeningDebt(c.lastCutoff, opened), isFalse);
    });

    test('is not added twice when opened right at the period start', () {
      final c = CreditCardCycle.of(
        cutoffDay: 15,
        dueDay: 5,
        date: DateTime(2026, 10, 25),
      );

      // The balance at the start of Oct 16 already counts this opening.
      expect(c.billsOpeningDebt(c.lastCutoff, DateTime(2026, 10, 16)), isFalse);
    });
  });

  group('CreditCardStatus overdue', () {
    final cycle = CreditCardCycle.of(
      cutoffDay: 15,
      dueDay: 5,
      date: DateTime(2026, 10, 22),
    );

    // A 1500 purchase on Sep 14, nothing paid since.
    CreditCardStatus status({double prevPayments = 0}) => CreditCardStatus(
      cycle: cycle,
      balance: -1850,
      statementBalance: -1500,
      paymentsSinceCutoff: 0,
      periodCharges: 350,
      previousStatementBalance: -1500,
      paymentsSincePreviousCutoff: prevPayments,
    );

    test('an unpaid statement past its due date is overdue', () {
      expect(status().previousStatementOverdue, 1500);
      expect(status().statementPaymentLeft, 1500);
    });

    test('payments since that cut-off reduce the overdue amount', () {
      expect(status(prevPayments: 1000).previousStatementOverdue, 500);
      expect(status(prevPayments: 2000).previousStatementOverdue, 0);
    });
  });

  group('CreditCardStatus', () {
    final cycle = CreditCardCycle.of(
      cutoffDay: 10,
      dueDay: 30,
      date: DateTime(2026, 10, 22),
    );

    CreditCardStatus status({
      double balance = -4000,
      double statementBalance = -3000,
      double payments = 0,
      double? limit = 20000,
      double? pct = 0.05,
    }) => CreditCardStatus(
      cycle: cycle,
      balance: balance,
      statementBalance: statementBalance,
      paymentsSinceCutoff: payments,
      periodCharges: 1000,
      creditLimit: limit,
      minPaymentPct: pct,
    );

    test('available credit and utilization come from the current debt', () {
      final s = status();

      expect(s.totalDebt, 4000);
      expect(s.availableCredit, 16000);
      expect(s.utilization, 0.2);
    });

    test('an overpaid card adds its positive balance to the limit', () {
      final s = status(balance: 500);

      expect(s.totalDebt, 0);
      expect(s.availableCredit, 20500);
      expect(s.utilization, 0);
    });

    test('no limit means no available credit nor utilization', () {
      final s = status(limit: null);

      expect(s.availableCredit, isNull);
      expect(s.utilization, isNull);
    });

    test('payments since the cut-off reduce what is left of the statement', () {
      expect(status().statementPaymentLeft, 3000);
      expect(status(payments: 1000).statementPaymentLeft, 2000);
      expect(status(payments: 5000).statementPaymentLeft, 0);
    });

    test('minimum payment is a share of the statement, minus payments', () {
      expect(status().minPaymentLeft, 150);
      expect(status(payments: 100).minPaymentLeft, 50);
      expect(status(payments: 1000).minPaymentLeft, 0);
      expect(status(pct: null).minPaymentLeft, isNull);
    });

    test('a statement with a positive balance asks for nothing', () {
      final s = status(statementBalance: 200);

      expect(s.statementDebt, 0);
      expect(s.statementPaymentLeft, 0);
      expect(s.minPaymentLeft, 0);
    });
  });
}

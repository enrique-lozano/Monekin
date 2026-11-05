import 'package:flutter_test/flutter_test.dart';
import 'package:monekin/core/database/services/account/credit_card_service.dart';
import 'package:monekin/core/models/account/credit_card_cycle.dart';
import 'package:monekin/core/models/account/installment_purchase.dart';

void main() {
  // Cut-off 15, due 5. 1000 bought on Oct 20 in 3 installments: billed on the
  // Nov 15, Dec 15 and Jan 15 statements.
  final purchase = InstallmentPurchase(
    date: DateTime(2026, 10, 20, 13, 30),
    amount: 1000,
    count: 3,
  );

  group('InstallmentPurchase', () {
    test('the first installment goes to the statement of the purchase', () {
      expect(purchase.billedCountAt(DateTime(2026, 10, 15), 15), 0);
      expect(purchase.billedCountAt(DateTime(2026, 11, 15), 15), 1);
      expect(purchase.billedCountAt(DateTime(2026, 12, 15), 15), 2);
      expect(purchase.billedCountAt(DateTime(2027, 1, 15), 15), 3);
      expect(purchase.billedCountAt(DateTime(2027, 2, 15), 15), 3);
    });

    test('a purchase on the cut-off day is billed by that statement', () {
      final onCutoff = InstallmentPurchase(
        date: DateTime(2026, 11, 15, 22),
        amount: 600,
        count: 6,
      );

      expect(onCutoff.billedCountAt(DateTime(2026, 11, 15), 15), 1);
    });

    test('the last installment absorbs the rounding difference', () {
      final cycle = CreditCardCycle.of(cutoffDay: 15, dueDay: 5);

      expect(purchase.installmentAmount, 333.33);
      expect(purchase.chargeAt(cycle, DateTime(2026, 11, 15)), 333.33);
      expect(purchase.chargeAt(cycle, DateTime(2026, 12, 15)), 333.33);
      expect(purchase.chargeAt(cycle, DateTime(2027, 1, 15)), 333.34);
      expect(purchase.chargeAt(cycle, DateTime(2027, 2, 15)), 0);
    });

    test('installments are rounded down so they never bill too much', () {
      final cycle = CreditCardCycle.of(cutoffDay: 15, dueDay: 5);
      final p = InstallmentPurchase(
        date: DateTime(2026, 10, 20),
        amount: 200,
        count: 3,
      );

      expect(p.installmentAmount, 66.66);
      expect(p.chargeAt(cycle, DateTime(2027, 1, 15)), 66.68);
    });

    test('tiny installments in a currency without decimals stay valid', () {
      final cycle = CreditCardCycle.of(cutoffDay: 15, dueDay: 5);
      final yen = InstallmentPurchase(
        date: DateTime(2026, 10, 20),
        amount: 100,
        count: 60,
        decimals: 0,
      );

      var cutoff = DateTime(2026, 11, 15);
      for (var i = 0; i < 60; i++) {
        expect(yen.chargeAt(cycle, cutoff), greaterThanOrEqualTo(0));
        expect(yen.billedAt(cutoff, 15), lessThanOrEqualTo(100));
        expect(yen.unbilledAt(cutoff, 15), greaterThanOrEqualTo(0));
        cutoff = cycle.cutoffAfter(cutoff, 1);
      }

      expect(yen.billedAt(DateTime(2031, 10, 15), 15), 100);
    });

    test('unbilled debt only counts once the purchase is made', () {
      expect(purchase.unbilledAt(DateTime(2026, 10, 15), 15), 0);
      expect(purchase.unbilledAt(DateTime(2026, 11, 15), 15), 666.67);
      expect(purchase.unbilledAt(DateTime(2026, 12, 15), 15), 333.34);
      expect(purchase.unbilledAt(DateTime(2027, 1, 15), 15), 0);
    });
  });

  group('CreditCardStatus with installments', () {
    // Nov 22: the Nov 15 statement billed the first installment.
    final cycle = CreditCardCycle.of(
      cutoffDay: 15,
      dueDay: 5,
      date: DateTime(2026, 11, 22),
    );

    CreditCardStatus status({double periodCharges = 0}) => CreditCardStatus(
      cycle: cycle,
      balance: -1000 - periodCharges,
      statementBalance: -1000,
      paymentsSinceCutoff: 0,
      periodCharges: periodCharges,
      installmentPurchases: [purchase],
      creditLimit: 5000,
    );

    test('the whole purchase is debt and uses the credit limit', () {
      expect(status().totalDebt, 1000);
      expect(status().availableCredit, 4000);
    });

    test('the statement only asks for the billed installment', () {
      expect(status().statementDebt, 333.33);
      expect(status().statementPaymentLeft, 333.33);
      expect(status().previousStatementOverdue, 0);
    });

    test('the next statement adds the next installment to new purchases', () {
      expect(status().nextStatementCharges, 333.33);
      expect(status(periodCharges: 200).nextStatementCharges, 533.33);
      expect(status().installmentsPending, 333.34);
    });

    test('a new installment purchase only adds its first installment', () {
      final s = CreditCardStatus(
        cycle: cycle,
        balance: -1600,
        statementBalance: -1000,
        paymentsSinceCutoff: 0,
        periodCharges: 600,
        installmentPurchases: [
          purchase,
          InstallmentPurchase(
            date: DateTime(2026, 11, 20),
            amount: 600,
            count: 6,
          ),
        ],
      );

      expect(s.nextStatementCharges, 333.33 + 100);
    });

    test('upcoming installments list each statement until all is billed', () {
      final upcoming = status().upcomingInstallments;

      expect(upcoming.map((e) => e.cutoff), [
        DateTime(2026, 12, 15),
        DateTime(2027, 1, 15),
      ]);
      expect(upcoming.map((e) => e.dueDate), [
        DateTime(2027, 1, 5),
        DateTime(2027, 2, 5),
      ]);
      expect(upcoming.map((e) => e.amount), [333.33, 333.34]);
    });

    test('a card without installments has no upcoming ones', () {
      final s = CreditCardStatus(
        cycle: cycle,
        balance: -100,
        statementBalance: -100,
        paymentsSinceCutoff: 0,
        periodCharges: 0,
      );

      expect(s.upcomingInstallments, isEmpty);
      expect(s.installmentsPending, 0);
    });
  });
}

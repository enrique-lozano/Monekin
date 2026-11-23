import 'dart:math';

import 'package:monekin/core/models/account/credit_card_cycle.dart';

/// A credit card purchase paid in monthly installments.
///
/// The whole [amount] is debt from the purchase [date], but each statement only
/// bills one installment, starting with the statement the purchase belongs to.
/// The installment is `amount / count` rounded down to [decimals]; the last one
/// absorbs the difference so they add up to the purchase without ever billing
/// more than it.
class InstallmentPurchase {
  const InstallmentPurchase({
    required this.date,
    required this.amount,
    required this.count,
    this.decimals = 2,
  });

  final DateTime date;

  /// Purchase amount, positive, in the account currency.
  final double amount;

  /// Number of installments, at least 2.
  final int count;

  final int decimals;

  double get installmentAmount {
    final factor = pow(10, decimals);
    // The epsilon keeps exact quotients (e.g. 100 / 4) from dropping a cent.
    return (amount / count * factor + 1e-9).floor() / factor;
  }

  /// How many installments the statement closed on [cutoff] and the earlier
  /// ones have billed.
  int billedCountAt(DateTime cutoff, int cutoffDay) {
    final first = CreditCardCycle.cutoffOnOrAfter(cutoffDay, date);
    if (cutoff.isBefore(first)) return 0;

    final months = (cutoff.year - first.year) * 12 + cutoff.month - first.month;

    return min(count, months + 1);
  }

  /// Amount billed by the statement closed on [cutoff] and the earlier ones.
  double billedAt(DateTime cutoff, int cutoffDay) {
    final billed = billedCountAt(cutoff, cutoffDay);
    return billed >= count
        ? amount
        : min(amount, _round(installmentAmount * billed));
  }

  /// Part of the purchase that, at the end of the [cutoff] day, is already
  /// debt but has not been billed by any statement yet.
  double unbilledAt(DateTime cutoff, int cutoffDay) {
    final endOfCutoff = DateTime(cutoff.year, cutoff.month, cutoff.day + 1);
    if (!date.isBefore(endOfCutoff)) return 0;

    return _round(amount - billedAt(cutoff, cutoffDay));
  }

  /// Amount the statement closed on [cutoff] bills of this purchase.
  double chargeAt(CreditCardCycle cycle, DateTime cutoff) => _round(
    billedAt(cutoff, cycle.cutoffDay) -
        billedAt(cycle.cutoffAfter(cutoff, -1), cycle.cutoffDay),
  );

  double _round(double value) {
    final factor = pow(10, decimals);
    return (value * factor).round() / factor;
  }
}

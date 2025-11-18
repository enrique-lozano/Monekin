import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Literally the `null` value, just casted to TransactionStatus? to avoid
/// issues with null safety
const nullTransactionStatus = null as TransactionStatus?;

enum TransactionStatus {
  voided,
  pending,
  reconciled,
  unreconciled;

  /// Get a list of statuses that are not in a set of statuses.
  ///
  /// Include the null status with the [includeNullStatus] param, that defaults to true.
  static List<TransactionStatus?> notIn(
    Set<TransactionStatus> statuses, {
    bool includeNullStatus = true,
  }) {
    return [
      if (includeNullStatus) null,
      ...TransactionStatus.values.whereNot(
        (element) => statuses.contains(element),
      ),
    ];
  }

  /// Filter the status that does count for stats, parting of a array of statuses (if defined).
  ///
  /// The transaction statuses that do not count for balances and other stats are the pending and the voided transactions
  static List<TransactionStatus?> getStatusThatCountsForStats(
    List<TransactionStatus?>? status,
  ) {
    if (status != null) {
      return status
          .whereNot(
            (element) => [
              TransactionStatus.pending.index,
              TransactionStatus.voided.index,
            ].contains(element?.index),
          )
          .toList();
    } else {
      return TransactionStatus.notIn({
        TransactionStatus.pending,
        TransactionStatus.voided,
      });
    }
  }
}

extension TransactionStatusExtension on TransactionStatus? {
  IconData get icon {
    if (this == null) return Icons.do_not_disturb_on_rounded;

    if (this == TransactionStatus.voided) return Icons.cancel_rounded;
    if (this == TransactionStatus.pending) return Icons.hourglass_full_rounded;
    if (this == TransactionStatus.unreconciled) return Icons.cloud_off_rounded;
    if (this == TransactionStatus.reconciled) return Icons.check_circle_rounded;

    return Icons.question_mark;
  }

  String displayName(BuildContext context) {
    final t = Translations.of(context);

    if (this == TransactionStatus.voided) return t.transaction.status.voided;
    if (this == TransactionStatus.pending) return t.transaction.status.pending;
    if (this == TransactionStatus.unreconciled) {
      return t.transaction.status.unreconciled;
    }
    if (this == TransactionStatus.reconciled) {
      return t.transaction.status.reconciled;
    }

    return t.transaction.status.none;
  }

  String description(BuildContext context) {
    final t = Translations.of(context);

    if (this == TransactionStatus.voided) {
      return t.transaction.status.voided_descr;
    }
    if (this == TransactionStatus.pending) {
      return t.transaction.status.pending_descr;
    }
    if (this == TransactionStatus.unreconciled) {
      return t.transaction.status.unreconciled_descr;
    }
    if (this == TransactionStatus.reconciled) {
      return t.transaction.status.reconciled_descr;
    }

    return t.transaction.status.none_descr;
  }

  Color get color {
    if (this == TransactionStatus.voided) return Colors.red;
    if (this == TransactionStatus.pending) return Colors.amber;
    if (this == TransactionStatus.unreconciled) return Colors.orange;
    if (this == TransactionStatus.reconciled) return Colors.green;

    return Colors.grey;
  }
}

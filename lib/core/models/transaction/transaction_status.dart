import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/i18n/translations.g.dart';

enum TransactionStatus {
  voided,
  pending,
  reconciled,
  unreconciled;

  /// Get a list of statuses that are not in a set of statuses.
  ///
  /// Include the null status with the [includeNullStatus] param, that defaults to true.
  static List<TransactionStatus?> notIn(Set<TransactionStatus> statuses,
      {bool includeNullStatus = true}) {
    return [
      if (includeNullStatus) null,
      ...TransactionStatus.values
          .whereNot((element) => statuses.contains(element))
    ];
  }

  IconData get icon {
    if (this == voided) return Icons.block_rounded;
    if (this == pending) return Icons.hourglass_full_rounded;
    if (this == unreconciled) return Icons.cloud_off_rounded;
    if (this == reconciled) return Icons.check_circle_rounded;

    return Icons.question_mark;
  }

  Color get color {
    if (this == voided) return Colors.red;
    if (this == pending) return Colors.amber;
    if (this == unreconciled) return Colors.orange;
    if (this == reconciled) return Colors.green;

    return Colors.grey;
  }

  String displayName(BuildContext context) {
    final t = Translations.of(context);

    if (this == voided) return t.transaction.status.voided;
    if (this == pending) return t.transaction.status.pending;
    if (this == unreconciled) return t.transaction.status.unreconciled;
    if (this == reconciled) return t.transaction.status.reconciled;

    return '';
  }

  String description(BuildContext context) {
    final t = Translations.of(context);

    if (this == voided) return t.transaction.status.voided_descr;
    if (this == pending) return t.transaction.status.pending_descr;
    if (this == unreconciled) return t.transaction.status.unreconciled_descr;
    if (this == reconciled) return t.transaction.status.reconciled_descr;

    return '';
  }
}

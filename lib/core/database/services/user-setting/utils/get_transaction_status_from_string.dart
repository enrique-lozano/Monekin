import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

TransactionStatus getTransactionStatusFromString(String actionString) {

  Map<String, TransactionStatus> transactionStatusSetting = {
    t.transaction.status.voided: TransactionStatus.voided,
    t.transaction.status.pending: TransactionStatus.pending,
    t.transaction.status.unreconciled: TransactionStatus.unreconciled,
    t.transaction.status.reconciled: TransactionStatus.reconciled
  };

  return transactionStatusSetting[actionString]!;
}

// TODO: This piece for code is in the wrong place, must move it later.
// TODO: Need to add functionality to delete and edit.
DismissDirection getDismissDirection(String leftSwipeString, String rightSwipeString) {
  // Example conditions to determine the dismiss direction
  if (leftSwipeString == t.ui_actions.none && rightSwipeString == t.ui_actions.none){
    return DismissDirection.none;
  }else if (leftSwipeString == t.ui_actions.none) {
    return DismissDirection.startToEnd;
  } else if (rightSwipeString == t.ui_actions.none) {
    return DismissDirection.endToStart;
  }
  return DismissDirection.horizontal;
}
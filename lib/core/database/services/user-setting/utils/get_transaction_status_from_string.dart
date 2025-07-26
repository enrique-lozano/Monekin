import 'package:flutter/material.dart';
import 'package:monekin/core/models/transaction/transaction_status.enum.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

TransactionStatus? getTransactionStatusFromString(String? statusCodeString) {

  Map<String, TransactionStatus> transactionStatusSetting = {
    t.transaction.status.voided: TransactionStatus.voided,
    t.transaction.status.pending: TransactionStatus.pending,
    t.transaction.status.unreconciled: TransactionStatus.unreconciled,
    t.transaction.status.reconciled: TransactionStatus.reconciled
  };
  return transactionStatusSetting[statusCodeString];
}

// TODO: This piece for code is in the wrong place, must move it later.
// TODO: Need to add functionality to delete and edit.
DismissDirection getDismissDirection(TransactionStatus? leftSwipeStatusCode, TransactionStatus? rightSwipeStatusCode) {
  // Example conditions to determine the dismiss direction
  if (leftSwipeStatusCode == null && rightSwipeStatusCode == null){
    return DismissDirection.none;
  }else if (leftSwipeStatusCode == null) {
    return DismissDirection.startToEnd;
  } else if (rightSwipeStatusCode == null) {
    return DismissDirection.endToStart;
  }
  return DismissDirection.horizontal;
}
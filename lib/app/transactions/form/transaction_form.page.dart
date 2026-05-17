import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/app/transactions/form/transaction_form_scaffold.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:provider/provider.dart';

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({
    super.key,
    this.mode,
    this.fromAccount,
    this.toAccount,
    this.transactionToEdit,
    this.linkedDebt,
    this.linkedAsset,
  });

  final TransactionType? mode;
  final MoneyTransaction? transactionToEdit;
  final Account? fromAccount;
  final Account? toAccount;
  final Debt? linkedDebt;
  final Asset? linkedAsset;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  late final TransactionFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TransactionFormController(
      mode: widget.mode,
      transactionToEdit: widget.transactionToEdit,
      fromAccount: widget.fromAccount,
      toAccount: widget.toAccount,
      linkedDebt: widget.linkedDebt,
      linkedAsset: widget.linkedAsset,
    )..initialize();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(_runPostMountBootstrap());
    });
  }

  Future<void> _runPostMountBootstrap() async {
    final c = _controller;
    if (c.isEditMode) return;

    final assetNew =
        c.isAssetTradeInvestment &&
        widget.transactionToEdit == null &&
        widget.linkedAsset != null;
    if (assetNew) {
      await c.completeLinkedAssetBootstrap();
      if (!mounted) return;
      c.requestAmountFocusAfterFrame();
      return;
    }

    await c.waitForFormDefaults();
    if (!mounted) return;
    await c.bootstrapCreateCategoryAndFocusAmount(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: const TransactionFormScaffold(),
    );
  }
}

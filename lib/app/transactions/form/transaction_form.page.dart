import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/state/transaction_form_controller.dart';
import 'package:monekin/app/transactions/form/transaction_form_scaffold.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:provider/provider.dart';

class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({
    super.key,
    this.mode,
    this.fromAccount,
    this.toAccount,
    this.transactionToEdit,
    this.linkedDebt,
    this.security,
    this.isSell = false,
  });

  final TransactionType? mode;
  final MoneyTransaction? transactionToEdit;
  final Account? fromAccount;
  final Account? toAccount;
  final Debt? linkedDebt;

  /// With the investment [mode], creates a buy (or a sell, with [isSell]) in
  /// [fromAccount]. The user picks the security if [security] is null.
  final SecurityInDB? security;
  final bool isSell;

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
      security: widget.security,
      isSell: widget.isSell,
    )..initialize();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(_runPostMountBootstrap());
    });
  }

  Future<void> _runPostMountBootstrap() async {
    final c = _controller;
    if (c.isEditMode) return;

    if (c.isSecurityTradeInvestment) {
      if (c.security == null) await c.pickSecurity(context);
      return;
    }

    await c.waitForFormDefaults();
    if (!mounted) return;

    if (c.usesDualLegAmountLayout) {
      c.openDualLegTopAmountSelector(
        context,
        defaultDestinationAmount: c.transactionValue.abs(),
      );
      return;
    }

    if (SideDrawerScope.of(context)) {
      c.requestAmountFocusAfterFrame();
      return;
    }

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

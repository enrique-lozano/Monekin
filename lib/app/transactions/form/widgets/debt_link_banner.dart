import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A compact banner shown in [TransactionFormPage] when the transaction being
/// created is pre-linked to a [Debt]. Visible only during creation (not edit).
class DebtLinkBanner extends StatelessWidget {
  const DebtLinkBanner({
    required this.debt,
    this.padding = const EdgeInsets.only(bottom: 16, left: 16, right: 16),
  });

  final Debt debt;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final color = debt.type.color(context);
    final t = Translations.of(context);

    return Padding(
      padding: padding,
      child: InlineInfoCard(
        text: t.debts.actions.link_transaction.creating(name: debt.name),
        mode: InlineInfoCardMode.custom(
          bgColor: color.withOpacity(0.2),
          iconColor: color,
          icon: Debt.icon,
        ),
      ),
    );
  }
}

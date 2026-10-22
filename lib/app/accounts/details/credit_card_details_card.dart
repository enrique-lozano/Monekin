import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/services/account/credit_card_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/label_value_info_list.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Billing cycle and available credit of a credit card account: what is left
/// to pay of the last statement and when, the days to the next cut-off, the
/// credit still available and the estimated minimum payment.
class CreditCardDetailsCard extends StatefulWidget {
  const CreditCardDetailsCard({super.key, required this.account});

  final Account account;

  @override
  State<CreditCardDetailsCard> createState() => _CreditCardDetailsCardState();
}

class _CreditCardDetailsCardState extends State<CreditCardDetailsCard> {
  late Stream<CreditCardStatus?> _status;

  @override
  void initState() {
    super.initState();
    _status = CreditCardService.instance.getStatus(widget.account);
  }

  @override
  void didUpdateWidget(covariant CreditCardDetailsCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    final a = widget.account;
    final b = oldWidget.account;
    if (a.cutoffDay != b.cutoffDay ||
        a.dueDay != b.dueDay ||
        a.creditLimit != b.creditLimit ||
        a.minPaymentPct != b.minPaymentPct ||
        a.iniValue != b.iniValue ||
        a.date != b.date ||
        a.currencyId != b.currencyId) {
      _status = CreditCardService.instance.getStatus(a);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder(
      stream: _status,
      builder: (context, snapshot) {
        final status = snapshot.data;
        if (status == null) return const SizedBox.shrink();

        final cycle = status.cycle;
        final daysToCutoff = cycle.daysToCutoff();

        return CardWithHeader(
          title: t.account.credit.title,
          subtitle: daysToCutoff == 0
              ? t.account.credit.cutoff_today
              : t.account.credit.cutoff_in(
                  n: daysToCutoff,
                  date: DateFormat.MMMd().format(cycle.nextCutoff),
                ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatementPayment(context, status),
              if (status.availableCredit != null)
                _buildAvailableCredit(context, status),
              LabelValueInfoList(
                items: [
                  if (status.minPaymentLeft != null)
                    _amountItem(
                      t.account.credit.min_payment,
                      status.minPaymentLeft!,
                      hint: t.account.credit.min_payment_hint,
                    ),
                  _amountItem(
                    t.account.credit.statement_balance(
                      date: DateFormat.MMMd().format(cycle.lastCutoff),
                    ),
                    status.statementDebt,
                  ),
                  _amountItem(
                    t.account.credit.payments_since_cutoff,
                    status.paymentsSinceCutoff,
                  ),
                  _amountItem(
                    t.account.credit.period_charges,
                    status.periodCharges,
                    hint: t.account.credit.period_charges_hint(
                      date: DateFormat.MMMd().format(cycle.nextPaymentDueDate),
                    ),
                  ),
                  _amountItem(t.account.credit.total_debt, status.totalDebt),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// What is left to pay of the last statement, with its due date.
  Widget _buildStatementPayment(BuildContext context, CreditCardStatus status) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    final dueDate = status.cycle.paymentDueDate;
    final daysToDue = status.cycle.daysToPaymentDue();
    final isPaid = status.statementPaymentLeft <= 0;

    final String dueText;
    if (isPaid) {
      dueText = status.statementDebt > 0
          ? t.account.credit.statement_paid
          : t.account.credit.nothing_to_pay;
    } else if (daysToDue < 0) {
      dueText = t.account.credit.due_overdue(
        date: DateFormat.MMMd().format(dueDate),
      );
    } else if (daysToDue == 0) {
      dueText = t.account.credit.due_today;
    } else {
      dueText = t.account.credit.due_in(
        n: daysToDue,
        date: DateFormat.MMMd().format(dueDate),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.account.credit.to_pay,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          CurrencyDisplayer(
            amountToConvert: status.statementPaymentLeft,
            currency: widget.account.currency,
            integerStyle: theme.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            dueText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: !isPaid && daysToDue <= 3
                  ? AppColors.of(context).danger
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
          // Once the last statement is overdue its own text already says so.
          if (daysToDue >= 0 && status.previousStatementOverdue > 0)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: DefaultTextStyle.merge(
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.of(context).danger,
                  fontWeight: FontWeight.w600,
                ),
                child: Row(
                  spacing: 6,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 18,
                      color: AppColors.of(context).danger,
                    ),
                    Flexible(
                      child: Text(
                        t.account.credit.due_overdue(
                          date: DateFormat.MMMd().format(
                            status.cycle.previousPaymentDueDate,
                          ),
                        ),
                      ),
                    ),
                    CurrencyDisplayer(
                      amountToConvert: status.previousStatementOverdue,
                      currency: widget.account.currency,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Credit still available, with a bar showing the share of the limit in use.
  Widget _buildAvailableCredit(BuildContext context, CreditCardStatus status) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    final utilization = status.utilization ?? 0;
    final barColor = utilization >= 0.9
        ? AppColors.of(context).danger
        : theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.account.credit.available,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    CurrencyDisplayer(
                      amountToConvert: status.availableCredit!,
                      currency: widget.account.currency,
                      integerStyle: theme.textTheme.titleLarge!,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    t.account.credit.limit,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  CurrencyDisplayer(
                    amountToConvert: status.creditLimit!,
                    currency: widget.account.currency,
                    integerStyle: theme.textTheme.bodyMedium!,
                  ),
                ],
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: utilization.clamp(0, 1),
              minHeight: 8,
              color: barColor,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
          Text(
            t.account.credit.utilization(
              x: NumberFormat.percentPattern().format(utilization),
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  LabelValueInfoListItem _amountItem(
    String label,
    double amount, {
    String? hint,
  }) {
    return LabelValueInfoListItem(
      label: label,
      value: hint == null ? const SizedBox.shrink() : Text(hint),
      trailing: CurrencyDisplayer(
        amountToConvert: amount,
        currency: widget.account.currency,
      ),
    );
  }
}

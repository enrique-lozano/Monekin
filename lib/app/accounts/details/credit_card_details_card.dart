import 'dart:async';

import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:monekin/core/database/services/account/credit_card_service.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/targets/target_status_card.dart';
import 'package:monekin/core/utils/date_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Billing cycle and available credit of a credit card account, laid out like
/// the goal status card: what is left to pay of the last statement and when it
/// is due, then the credit still available and the debt.
class CreditCardDetailsCard extends StatefulWidget {
  const CreditCardDetailsCard({super.key, required this.account});

  final Account account;

  @override
  State<CreditCardDetailsCard> createState() => _CreditCardDetailsCardState();
}

class _CreditCardDetailsCardState extends State<CreditCardDetailsCard>
    with WidgetsBindingObserver {
  late Stream<CreditCardStatus?> _status;

  /// The day [_status] was built for. The billing cycle depends on it, so the
  /// status is rebuilt when the day changes (at midnight, or when the app
  /// comes back after it).
  late DateTime _day;
  Timer? _midnightTimer;

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void _subscribe() {
    _day = _today();
    _status = CreditCardService.instance.getStatus(widget.account);
    _scheduleMidnightCheck();
  }

  void _scheduleMidnightCheck() {
    _midnightTimer?.cancel();
    final nextDay = DateTime(_day.year, _day.month, _day.day + 1);
    _midnightTimer = Timer(
      nextDay.difference(DateTime.now()) + const Duration(seconds: 1),
      _refreshIfNewDay,
    );
  }

  void _refreshIfNewDay() {
    if (!mounted) return;

    if (_today() != _day) {
      setState(_subscribe);
    } else {
      _scheduleMidnightCheck();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscribe();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshIfNewDay();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
    super.dispose();
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
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _status,
      builder: (context, snapshot) {
        final status = snapshot.data;
        if (status == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            _buildStatementCard(context, status),
            _buildCreditCard(context, status),
          ],
        );
      },
    );
  }

  /// What is left to pay of the last statement, how much of it is paid and
  /// when it is due.
  Widget _buildStatementCard(BuildContext context, CreditCardStatus status) {
    final t = Translations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final appColors = AppColors.of(context);
    final hintColor = appColors.textHint;
    final currency = widget.account.currency;

    final cycle = status.cycle;
    final daysToCutoff = cycle.daysToCutoff();
    final daysToDue = cycle.daysToPaymentDue();
    final isPaid = status.statementPaymentLeft <= 0;

    final paid = status.statementDebt - status.statementPaymentLeft;
    final percent = status.statementDebt <= 0
        ? 1.0
        : paid / status.statementDebt;

    return CardWithHeader(
      title: t.account.credit.statement_of(
        date: getShortDateLabel(cycle.lastCutoff),
      ),
      subtitle: daysToCutoff == 0
          ? t.account.credit.cutoff_today
          : t.account.credit.cutoff_in(
              n: daysToCutoff,
              date: DateFormat.MMMd().format(cycle.nextCutoff),
            ),
      bodyPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: _headlineAmount(
                  context,
                  amount: status.statementPaymentLeft,
                  label: t.targets.left,
                ),
              ),
              if (status.statementDebt > 0)
                Flexible(
                  child: _dueChip(
                    context,
                    isPaid: isPaid,
                    daysToDue: daysToDue,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          DefaultTextStyle.merge(
            style: textTheme.bodyMedium!.copyWith(color: hintColor),
            child: status.statementDebt <= 0
                ? Text(t.account.credit.nothing_to_pay)
                : Text.rich(
                    TextSpan(
                      children: [
                        _currencySpan(paid),
                        TextSpan(text: ' ${t.account.credit.paid} · '),
                        TextSpan(
                          text: UINumberFormatter.percentage(
                            amountToConvert: percent,
                            showDecimals: false,
                          ).getFormattedAmount(),
                        ),
                        TextSpan(text: ' ${t.general.of} '),
                        _currencySpan(status.statementDebt),
                      ],
                    ),
                    maxLines: 2,
                  ),
          ),
          // Once the last statement is overdue its own chip already says so.
          if (daysToDue >= 0 &&
              cycle.isPreviousPaymentDue() &&
              status.previousStatementOverdue > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _previousOverdueWarning(context, status),
            ),
          const Divider(height: 32),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (status.minPaymentLeft != null) ...[
                  TargetStat(
                    icon: Icons.payments_rounded,
                    amount: status.minPaymentLeft!,
                    currency: currency,
                    showDecimals: true,
                    label: t.account.credit.min_payment_short,
                    helpText: t.account.credit.min_payment_hint,
                  ),
                  const VerticalDivider(width: 1),
                ],
                TargetStat(
                  icon: Icons.receipt_long_rounded,
                  amount: status.statementDebt,
                  currency: currency,
                  showDecimals: true,
                  label: t.account.credit.statement_short,
                  helpText: t.account.credit.statement_balance(
                    date: getShortDateLabel(cycle.lastCutoff),
                  ),
                ),
                const VerticalDivider(width: 1),
                TargetStat(
                  icon: Icons.shopping_bag_rounded,
                  amount: status.nextStatementCharges,
                  currency: currency,
                  showDecimals: true,
                  label: t.account.credit.next_statement_short,
                  helpText: t.account.credit.next_statement_help(
                    date: getShortDateLabel(cycle.nextPaymentDueDate),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Credit still available against the limit, and the debt of the card.
  Widget _buildCreditCard(BuildContext context, CreditCardStatus status) {
    final t = Translations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final appColors = AppColors.of(context);
    final hintColor = appColors.textHint;
    final currency = widget.account.currency;

    final hasLimit = status.availableCredit != null;
    final utilization = status.utilization ?? 0;
    final utilizationColor = utilization >= 0.9
        ? appColors.danger
        : utilization >= 0.7
        ? Colors.orange
        : appColors.success;

    final stats = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TargetStat(
            icon: Icons.account_balance_rounded,
            amount: status.totalDebt,
            currency: currency,
            showDecimals: true,
            label: t.account.credit.total_debt_short,
            helpText: t.account.credit.total_debt_help,
          ),
        ],
      ),
    );

    return CardWithHeader(
      title: hasLimit
          ? t.account.credit.available
          : t.account.credit.total_debt,
      bodyPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      body: !hasLimit
          ? stats
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: _headlineAmount(
                        context,
                        amount: status.availableCredit!,
                        label: t.targets.left,
                      ),
                    ),
                    Flexible(
                      child: _chip(
                        context,
                        color: utilizationColor,
                        icon: Icons.credit_score_rounded,
                        text: t.account.credit.in_use(
                          x: UINumberFormatter.percentage(
                            amountToConvert: utilization,
                            showDecimals: false,
                          ).getFormattedAmount(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AnimatedProgressBar(
                  width: 16,
                  radius: 99,
                  animationDuration: 1500,
                  value: utilization.clamp(0, 1),
                  color: utilization >= 0.7 ? utilizationColor : null,
                ),
                const SizedBox(height: 8),
                DefaultTextStyle(
                  style: textTheme.labelMedium!.copyWith(color: hintColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8,
                    children: [
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              _currencySpan(status.totalDebt),
                              TextSpan(text: ' ${t.account.credit.used}'),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '${t.general.of} '),
                              _currencySpan(status.creditLimit!),
                            ],
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 32),
                stats,
              ],
            ),
    );
  }

  Widget _headlineAmount(
    BuildContext context, {
    required double amount,
    required String label,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        spacing: 6,
        children: [
          CurrencyDisplayer(
            amountToConvert: amount,
            currency: widget.account.currency,
            integerStyle: textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: textTheme.titleMedium!.copyWith(
              color: AppColors.of(context).textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dueChip(
    BuildContext context, {
    required bool isPaid,
    required int daysToDue,
  }) {
    final t = Translations.of(context);
    final appColors = AppColors.of(context);

    if (isPaid) {
      return _chip(
        context,
        color: appColors.success,
        icon: Icons.check_circle_rounded,
        text: t.account.credit.statement_paid,
      );
    }

    if (daysToDue < 0) {
      return _chip(
        context,
        color: appColors.danger,
        icon: Icons.error_rounded,
        text: t.account.credit.overdue,
      );
    }

    if (daysToDue == 0) {
      return _chip(
        context,
        color: appColors.danger,
        icon: Icons.warning_rounded,
        text: t.account.credit.due_today,
      );
    }

    final isClose = daysToDue <= 3;

    return _chip(
      context,
      color: isClose ? Colors.orange : Theme.of(context).colorScheme.primary,
      icon: isClose ? Icons.warning_rounded : Icons.event_available_rounded,
      text: t.account.credit.due_short(n: daysToDue),
    );
  }

  /// Unpaid debt of the statement before the last one, once it is overdue.
  Widget _previousOverdueWarning(
    BuildContext context,
    CreditCardStatus status,
  ) {
    final t = Translations.of(context);
    final danger = AppColors.of(context).danger;

    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.bodyMedium!
          .copyWith(color: danger, fontWeight: FontWeight.w600),
      child: Row(
        spacing: 6,
        children: [
          Icon(Icons.warning_amber_rounded, size: 18, color: danger),
          Flexible(
            child: Text(
              t.account.credit.due_overdue(
                date: getShortDateLabel(status.cycle.previousPaymentDueDate),
              ),
            ),
          ),
          CurrencyDisplayer(
            amountToConvert: status.previousStatementOverdue,
            currency: widget.account.currency,
          ),
        ],
      ),
    );
  }

  Widget _chip(
    BuildContext context, {
    required Color color,
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.lighten(0.2).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(icon, size: 18, color: color),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge!
                  .copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }

  InlineSpan _currencySpan(double amount) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: CurrencyDisplayer(
        amountToConvert: amount,
        currency: widget.account.currency,
      ),
    );
  }
}

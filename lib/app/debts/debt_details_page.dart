import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/debts/components/add_register_to_debt_modal.dart';
import 'package:monekin/app/debts/debt_form_page.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/transactions/widgets/transaction_list.dart';
import 'package:monekin/core/database/services/debts/debt_service.dart';
import 'package:monekin/core/models/debt/debt.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/presentation/widgets/animated_progress_bar.dart';
import 'package:monekin/core/presentation/widgets/confirm_dialog.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/services/supported_icon/supported_icon_service.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:rxdart/rxdart.dart';

class DebtDetailsPage extends StatelessWidget {
  const DebtDetailsPage({super.key, required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: debt.name,
      appBarBackgroundColor: Theme.of(context).cardColor,
      appBarActions: [
        IconButton(
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: () async {
            final confirmed = await confirmDialog(
              context,
              dialogTitle: 'Delete this debt?',
              contentParagraphs: [
                const Text(
                  'This action cannot be undone. Linked transactions will not be deleted but will no longer be associated with this debt.',
                ),
              ],
              showCancelButton: true,
              icon: Icons.delete_forever_rounded,
            );
            if (confirmed != true) return;
            try {
              await DebtServive.instance.deleteDebt(debt.id);
              MonekinSnackbar.success(
                SnackbarParams('Debt deleted successfully'),
              );
              if (context.mounted) Navigator.of(context).pop();
            } catch (e) {
              MonekinSnackbar.error(SnackbarParams.fromError(e));
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            RouteUtils.pushRoute(DebtFormPage(debt: debt));
          },
        ),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_link_rounded),
        label: const Text('Add register'),
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => AddMoneyTransactionToDebtModal(debt: debt),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              t.transaction.display(n: 20),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: TransactionListComponent(
              filters: TransactionFilterSet(debtId: debt.id),
              onEmptyList: Center(
                child: Text('No transactions found for this debt'),
              ),
              showGroupDivider: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return StreamBuilder(
      stream: Rx.combineLatest2(
        DebtServive.instance.getDebtRemainingAmount(debt),
        DebtServive.instance.getDebtTotalAmount(debt),
        (remaining, total) => (remaining: remaining, total: total),
      ),
      initialData: (remaining: 0.0, total: debt.initialAmount),
      builder: (context, snapshot) {
        final data =
            snapshot.data ?? (remaining: 0.0, total: debt.initialAmount);
        final remainingAmount = data.remaining;
        final totalAmount = data.total;
        final collectedAmount = totalAmount - remainingAmount;
        final progress = collectedAmount / totalAmount;

        final color = debt.type.color(context);
        final int? daysLeft = debt.endDate?.difference(DateTime.now()).inDays;

        return ColoredBox(
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Row(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconDisplayer(
                      supportedIcon: SupportedIconService.instance.getIconByID(
                        debt.iconId,
                      ),
                      mainColor: color,
                      size: 46,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Collected Amount',
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                                ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Row(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  CurrencyDisplayer(
                                    amountToConvert: collectedAmount,
                                    currency: debt.currency,
                                    integerStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: color,
                                        ),
                                  ),
                                  Text(
                                    "/",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  CurrencyDisplayer(
                                    amountToConvert: totalAmount,
                                    currency: debt.currency,
                                    integerStyle: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!,
                                  ),
                                ],
                              ),

                              if (BreakPoint.of(
                                context,
                              ).isLargerThan(BreakpointID.md))
                                Flexible(
                                  child: _DebtDirectionBadge(debt: debt),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          AnimatedProgressBar(
                            value: progress.clamp(0.0, 1.0),
                            showPercentageText: true,
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _DebtInfoItem(
                        icon: Icons.calendar_today_rounded,
                        label: t.general.time.start_date,
                        child: Text(
                          DateFormat.yMMMd().format(debt.startDate),
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      width: 1,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: _DebtInfoItem(
                        icon: debt.endDate != null
                            ? Icons.event_available_rounded
                            : Icons.event_busy_rounded,
                        label: t.general.time.end_date,
                        child: debt.endDate != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    DateFormat.yMMMd().format(debt.endDate!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 2),
                                  if (daysLeft != null)
                                    Text(
                                      daysLeft > 0
                                          ? 'In $daysLeft days'
                                          : daysLeft == 0
                                          ? 'Due today'
                                          : '${daysLeft.abs()} days ago',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                            color: daysLeft > 0
                                                ? color
                                                : daysLeft == 0
                                                ? Colors.orange
                                                : Theme.of(
                                                    context,
                                                  ).colorScheme.error,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                ],
                              )
                            : Text(
                                'No deadline',
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.45),
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                      ),
                    ),
                    const VerticalDivider(
                      width: 1,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: _DebtInfoItem(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'Remaining',
                        child: CurrencyDisplayer(
                          amountToConvert: remainingAmount,
                          currency: debt.currency,
                          integerStyle: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: remainingAmount > 0
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DebtInfoItem extends StatelessWidget {
  const _DebtInfoItem({
    required this.icon,
    required this.label,
    required this.child,
  });

  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 3,
        children: [
          Row(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 11,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              Flexible(
                child: Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 9,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}

class _DebtDirectionBadge extends StatelessWidget {
  const _DebtDirectionBadge({required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context) {
    final color = debt.type.color(context);
    final label = debt.type.title(context);

    return Chip(
      avatar: Icon(debt.type.icon(), size: 14, color: color),
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.35)),
      labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
        color: color,
        fontWeight: FontWeight.w600,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

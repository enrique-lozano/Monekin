import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/accounts/details/account_snapshots.dart';
import 'package:monekin/app/securities/security_details_page.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/trending_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A card that lists the positions of an investment account tracked in
/// [AccountTrackingMode.holdings]. Positions come from the portfolio snapshot in
/// effect (the most recent snapshot on or before today); the whole portfolio is
/// edited at once as a snapshot, not as individual buy/sell trades.
class HoldingsSnapshotCard extends StatelessWidget {
  const HoldingsSnapshotCard({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder<List<AccountSnapshotWithPositions>>(
      stream: HoldingService.instance.getAccountSnapshots(account.id),
      builder: (context, snapshot) {
        final snapshots = snapshot.data ?? [];
        final now = DateTime.now();

        final current = snapshots
            .cast<AccountSnapshotWithPositions?>()
            .firstWhere((s) => !s!.date.isAfter(now), orElse: () => null);

        final positions = current?.positions ?? [];

        return Column(
          children: [
            const SizedBox(height: 16),
            CardWithHeader(
              title: t.assets.holdings.title,
              headerAction: CardHeaderAction(
                text: t.assets.holdings.snapshots.update,
                icon: const Icon(Icons.edit_rounded, size: 15),
                onTap: () => showPortfolioSnapshotEditor(
                  context,
                  account: account,
                  prefillPositions: current?.positions,
                ),
              ),
              bodyPadding: const EdgeInsets.symmetric(vertical: 4),
              footer: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: FilledButton.tonalIcon(
                  label: Text(
                    '${t.assets.holdings.snapshots.history_title} · ${snapshots.length}',
                  ),
                  icon: const Icon(Icons.history_rounded),
                  onPressed: () => RouteUtils.pushRoute(
                    AccountSnapshotsPage(account: account),
                  ),
                ),
              ),
              body: Column(
                children: [
                  if (current != null)
                    _CurrentSnapshotBanner(snapshot: current)
                  else
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        t.assets.holdings.empty,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (positions.isNotEmpty)
                    ...positions.map(
                      (p) => _PositionTile(account: account, position: p),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CurrentSnapshotBanner extends StatelessWidget {
  const _CurrentSnapshotBanner({required this.snapshot});

  final AccountSnapshotWithPositions snapshot;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.history_toggle_off_rounded,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${t.assets.holdings.snapshots.current.toUpperCase()} · '
                  '${DateFormat.yMMMd().format(snapshot.date)}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  snapshot.isEmpty
                      ? t.assets.holdings.snapshots.empty_portfolio
                      : t.assets.holdings.snapshots.positions_count(
                          n: snapshot.positionsCount,
                        ),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PositionTile extends StatelessWidget {
  const _PositionTile({required this.account, required this.position});

  final Account account;
  final SnapshotPosition position;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final security = position.security;

    final marketValue = position.quantity * (security.currentPrice ?? 0);
    final costBasis = position.cost;
    final pnlPct = costBasis == 0 ? 0.0 : (marketValue - costBasis) / costBasis;

    return StreamBuilder<Currency?>(
      stream: CurrencyService.instance.getCurrencyByCode(security.currencyId),
      builder: (context, currencySnap) {
        final currency = currencySnap.data;

        final avgCostText = currency != null
            ? UINumberFormatter.currency(
                amountToConvert: position.avgCostPrice,
                currency: currency,
              ).getFormattedAmount()
            : UINumberFormatter.decimal(
                amountToConvert: position.avgCostPrice,
              ).getFormattedAmount();

        return ListTile(
          leading: SecurityAvatar(security: security),
          title: Text(security.name),
          subtitle: Text(
            '${UINumberFormatter.decimal(amountToConvert: position.quantity).getFormattedAmount()}'
            ' · ${t.assets.holdings.avg_cost}: $avgCostText',
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CurrencyDisplayer(
                amountToConvert: marketValue,
                currency: currency,
              ),
              TrendingValue(
                percentage: pnlPct,
                dataTypes: const [TrendingValueDataType.percentage],
                fontSize: 12,
              ),
            ],
          ),
          onTap: () =>
              RouteUtils.pushRoute(SecurityDetailsPage(security: security)),
        );
      },
    );
  }
}

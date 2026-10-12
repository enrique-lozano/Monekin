import 'package:flutter/material.dart';
import 'package:monekin/app/securities/security_details_page.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/app/securities/widgets/security_form_sheet.dart';
import 'package:monekin/app/securities/widgets/security_price_form_dialog.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/core/presentation/widgets/trailing_value.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A card that lists the holdings of an investment account and lets the user
/// buy/sell, update prices and manage securities.
class HoldingsCard extends StatelessWidget {
  const HoldingsCard({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return StreamBuilder<List<HoldingWithSecurity>>(
      stream: HoldingService.instance.getHoldingsForAccount(account.id),
      builder: (context, snapshot) {
        final holdings = snapshot.data ?? [];

        return Column(
          children: [
            const SizedBox(height: 16),
            CardWithHeader(
              title: t.assets.holdings.title,
              headerAction: CardHeaderAction(
                text: t.assets.holdings.buy,
                icon: const Icon(Icons.add_rounded, size: 15),
                onTap: _startBuyFlow,
              ),
              bodyPadding: const EdgeInsets.symmetric(vertical: 4),
              body: holdings.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        t.assets.holdings.empty,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      children: holdings
                          .map((h) => _HoldingTile(account: account, data: h))
                          .toList(),
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _startBuyFlow() => showTradeForm(account: account, isBuy: true);
}

class _HoldingTile extends StatelessWidget {
  const _HoldingTile({required this.account, required this.data});

  final Account account;
  final HoldingWithSecurity data;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final security = data.security;
    final pnlColor = data.unrealizedPnl >= 0 ? Colors.green : Colors.red;

    return StreamBuilder<Currency?>(
      stream: CurrencyService.instance.getCurrencyByCode(security.currencyId),
      builder: (context, currencySnap) {
        final currency = currencySnap.data;

        final avgCostText = currency != null
            ? UINumberFormatter.currency(
                amountToConvert: data.holding.avgCostPrice,
                currency: currency,
              ).getFormattedAmount()
            : UINumberFormatter.decimal(
                amountToConvert: data.holding.avgCostPrice,
              ).getFormattedAmount();

        final pnlPct = data.unrealizedPnlPercent;
        final pnlText =
            '${pnlPct >= 0 ? '+' : ''}'
            '${UINumberFormatter.percentage(amountToConvert: pnlPct).getFormattedAmount()}';

        return ListTile(
          leading: SecurityAvatar(security: security),
          title: Text(
            security.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${UINumberFormatter.decimal(amountToConvert: data.quantity).getFormattedAmount()}'
            ' × $avgCostText',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              TrailingValue(
                amount: data.marketValue,
                currency: currency,
                secondary: Text(
                  pnlText,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: pnlColor),
                ),
              ),
              MonekinPopupMenuButton(
                actionItems: [
                  ListTileActionItem(
                    label: t.assets.holdings.buy,
                    icon: Icons.add_rounded,
                    onClick: () => showTradeForm(
                      account: account,
                      security: security,
                      isBuy: true,
                    ),
                  ),
                  ListTileActionItem(
                    label: t.assets.holdings.sell,
                    icon: Icons.remove_rounded,
                    onClick: () => showTradeForm(
                      account: account,
                      security: security,
                      isBuy: false,
                    ),
                  ),
                  ListTileActionItem(
                    label: t.assets.holdings.update_price,
                    icon: Icons.price_change_rounded,
                    onClick: () =>
                        showUpdatePriceSheet(context, security: security),
                  ),
                ],
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

// ---------------------------------------------------------------------------
// Security picker + creation
// ---------------------------------------------------------------------------

/// Lets the user pick an existing security or create a new one. Returns the
/// chosen (or created) security, or null if dismissed.
///
/// With [heldInAccountId], only the securities held in that account are listed
/// and none can be created, as there would be nothing to sell.
Future<SecurityInDB?> showSecurityPicker(
  BuildContext context, {
  String? heldInAccountId,
}) {
  return showModalBottomSheet<SecurityInDB>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) =>
        _SecurityPickerSheet(heldInAccountId: heldInAccountId),
  );
}

class _SecurityPickerSheet extends StatefulWidget {
  const _SecurityPickerSheet({this.heldInAccountId});

  final String? heldInAccountId;

  @override
  State<_SecurityPickerSheet> createState() => _SecurityPickerSheetState();
}

class _SecurityPickerSheetState extends State<_SecurityPickerSheet> {
  String _searchQuery = '';

  List<SecurityInDB> _filter(List<SecurityInDB> securities) {
    if (_searchQuery.isEmpty) return securities;

    final query = _searchQuery.toLowerCase();

    return securities
        .where(
          (s) =>
              s.name.toLowerCase().contains(query) ||
              (s.ticker?.toLowerCase().contains(query) ?? false),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.assets.holdings.choose_security,
      body: StreamBuilder<List<SecurityInDB>>(
        stream: widget.heldInAccountId == null
            ? SecurityService.instance.getSecurities()
            : HoldingService.instance
                  .getHoldingsForAccount(widget.heldInAccountId!)
                  .map((holdings) => holdings.map((h) => h.security).toList()),
        builder: (context, snapshot) {
          final securities = _filter(snapshot.data ?? []);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.heldInAccountId == null) ...[
                ListTile(
                  leading: const Icon(Icons.add_circle_outline_rounded),
                  title: Text(t.assets.holdings.create_security),
                  onTap: () async {
                    final created = await showSecurityFormSheet(context);
                    if (created != null && context.mounted) {
                      RouteUtils.popRoute(created);
                    }
                  },
                ),
                const Divider(height: 1),
              ],
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: SearchBar(
                  hintText: t.general.tap_to_search,
                  leading: const Icon(Icons.search),
                  onChanged: (value) => setState(() => _searchQuery = value),
                  trailing: [
                    AnimatedExpanded(
                      expand: _searchQuery.isNotEmpty,
                      axis: Axis.horizontal,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => setState(() => _searchQuery = ''),
                      ),
                    ),
                  ],
                ),
              ),
              if (securities.isEmpty &&
                  widget.heldInAccountId != null &&
                  _searchQuery.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    t.assets.holdings.empty,
                    textAlign: TextAlign.center,
                  ),
                ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: securities
                      .map(
                        (s) => ListTile(
                          leading: SecurityAvatar(security: s),
                          title: Text(s.name),
                          subtitle: s.ticker != null ? Text(s.ticker!) : null,
                          onTap: () => RouteUtils.popRoute(s),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Buy / Sell
// ---------------------------------------------------------------------------

/// Opens the transaction form to buy or sell in [account]. The form asks for
/// the security when [security] is null.
Future<void> showTradeForm({
  required Account account,
  SecurityInDB? security,
  required bool isBuy,
}) {
  return RouteUtils.showResponsiveForm(
    TransactionFormPage(
      mode: TransactionType.investment,
      fromAccount: account,
      security: security,
      isSell: !isBuy,
    ),
  );
}

// ---------------------------------------------------------------------------
// Update price sheet
// ---------------------------------------------------------------------------

Future<void> showUpdatePriceSheet(
  BuildContext context, {
  required SecurityInDB security,
}) async {
  final currency = await CurrencyService.instance
      .getCurrencyByCode(security.currencyId)
      .first;

  if (!context.mounted) return;

  final point = await showSecurityPriceFormDialog(
    context,
    SecurityPriceFormDialog(
      securityId: security.id,
      currencySymbol: currency?.symbol,
      initialPrice: security.currentPrice,
      dateEditable: false,
      title: Translations.of(context).assets.holdings.update_price,
    ),
  );

  if (point != null) {
    await SecurityService.instance.upsertPricePoint(point);
  }
}

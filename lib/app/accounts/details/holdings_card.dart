import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/app/securities/security_details_page.dart';
import 'package:monekin/app/securities/widgets/security_avatar.dart';
import 'package:monekin/app/securities/widgets/security_form_sheet.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/account/holding_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/database/services/currency/currency_service.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/asset/holding.dart';
import 'package:monekin/core/models/currency/currency.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_field.dart';
import 'package:monekin/core/presentation/widgets/form_fields/date_form_field.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/monekin_popup_menu_button.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/currency_displayer.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
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
                onTap: () => _startBuyFlow(context),
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

  Future<void> _startBuyFlow(BuildContext context) async {
    final security = await showSecurityPicker(context);
    if (security == null || !context.mounted) return;

    await showTradeSheet(
      context,
      account: account,
      security: security,
      isBuy: true,
    );
  }
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
          title: Text(security.name),
          subtitle: Text(
            '${UINumberFormatter.decimal(amountToConvert: data.quantity).getFormattedAmount()}'
            ' · ${t.assets.holdings.avg_cost}: $avgCostText',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CurrencyDisplayer(
                    amountToConvert: data.marketValue,
                    currency: currency,
                  ),
                  Text(
                    pnlText,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: pnlColor),
                  ),
                ],
              ),
              MonekinPopupMenuButton(
                actionItems: [
                  ListTileActionItem(
                    label: t.assets.holdings.buy,
                    icon: Icons.add_rounded,
                    onClick: () => showTradeSheet(
                      context,
                      account: account,
                      security: security,
                      isBuy: true,
                    ),
                  ),
                  ListTileActionItem(
                    label: t.assets.holdings.sell,
                    icon: Icons.remove_rounded,
                    onClick: () => showTradeSheet(
                      context,
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
Future<SecurityInDB?> showSecurityPicker(BuildContext context) {
  return showModalBottomSheet<SecurityInDB>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => const _SecurityPickerSheet(),
  );
}

class _SecurityPickerSheet extends StatefulWidget {
  const _SecurityPickerSheet();

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
        stream: SecurityService.instance.getSecurities(),
        builder: (context, snapshot) {
          final securities = _filter(snapshot.data ?? []);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
// Buy / Sell sheet
// ---------------------------------------------------------------------------

Future<void> showTradeSheet(
  BuildContext context, {
  required Account account,
  required SecurityInDB security,
  required bool isBuy,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) =>
        _TradeSheet(account: account, security: security, isBuy: isBuy),
  );
}

class _TradeSheet extends StatefulWidget {
  const _TradeSheet({
    required this.account,
    required this.security,
    required this.isBuy,
  });

  final Account account;
  final SecurityInDB security;
  final bool isBuy;

  @override
  State<_TradeSheet> createState() => _TradeSheetState();
}

class _TradeSheetState extends State<_TradeSheet> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  late final TextEditingController _priceController;
  DateTime _date = DateTime.now();

  /// Units currently held, used to cap a sell. Null until loaded.
  double? _heldQuantity;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(
      text: (widget.security.currentPrice ?? 0).toString(),
    );

    if (!widget.isBuy) {
      HoldingService.instance
          .getHolding(widget.account.id, widget.security.id)
          .first
          .then((holding) {
            if (!mounted) return;
            setState(() => _heldQuantity = holding?.quantity ?? 0);
          });
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  double get _total =>
      (double.tryParse(_quantityController.text) ?? 0) *
      (double.tryParse(_priceController.text) ?? 0);

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;

    if (widget.isBuy) {
      await HoldingService.instance.buy(
        accountId: widget.account.id,
        securityId: widget.security.id,
        quantity: quantity,
        pricePerUnit: price,
        date: _date,
      );
    } else {
      await HoldingService.instance.sell(
        accountId: widget.account.id,
        securityId: widget.security.id,
        quantity: quantity,
        pricePerUnit: price,
        date: _date,
      );
    }

    RouteUtils.popRoute();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final held = _heldQuantity;

    return ModalContainer(
      title: widget.isBuy
          ? t.assets.holdings.buy_title(security: widget.security.name)
          : t.assets.holdings.sell_title(security: widget.security.name),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 16),
      footer: BottomSheetFooter(
        submitText: widget.isBuy
            ? t.assets.holdings.buy
            : t.assets.holdings.sell,
        submitIcon: widget.isBuy ? Icons.add : Icons.remove,
        onSaved: _submit,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: '${t.assets.holdings.quantity} *',
                helperText: held == null
                    ? null
                    : t.assets.holdings.units_available(
                        quantity: UINumberFormatter.decimal(
                          amountToConvert: held,
                        ).getFormattedAmount(),
                      ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) {
                final parsed = double.tryParse(v ?? '');
                if (parsed == null || parsed <= 0) {
                  return t.general.validations.required;
                }
                if (held != null && parsed > held + 0.0000001) {
                  return t.assets.holdings.not_enough_units;
                }
                return null;
              },
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: '${t.assets.holdings.price_per_unit} *',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            DateTimeFormField(
              mode: DateTimeFieldPickerMode.date,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.event),
                labelText: '${t.general.time.date} *',
              ),
              initialDate: _date,
              firstDate: widget.account.date,
              lastDate: DateTime.now(),
              dateFormat: DateFormat.yMMMMd(),
              validator: (e) =>
                  e == null ? t.general.validations.required : null,
              onDateSelected: (value) => setState(() => _date = value),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.assets.holdings.total),
              trailing: Text(
                UINumberFormatter.decimal(
                  amountToConvert: _total,
                ).getFormattedAmount(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Update price sheet
// ---------------------------------------------------------------------------

Future<void> showUpdatePriceSheet(
  BuildContext context, {
  required SecurityInDB security,
}) {
  final controller = TextEditingController(
    text: (security.currentPrice ?? 0).toString(),
  );

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      final t = Translations.of(context);

      return ModalContainer(
        title: t.assets.holdings.update_price,
        bodyPadding: const EdgeInsets.symmetric(horizontal: 16),
        footer: BottomSheetFooter(
          onSaved: () async {
            final price = double.tryParse(controller.text);
            if (price == null) return;
            await SecurityService.instance.updatePrice(security.id, price);
            RouteUtils.popRoute();
          },
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(security.name),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: t.assets.holdings.current_price,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

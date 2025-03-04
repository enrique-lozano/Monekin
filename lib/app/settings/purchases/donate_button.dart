import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:monekin/app/settings/purchases/in_app_purchase.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../../core/presentation/app_colors.dart';

class DonateButton extends StatefulWidget {
  const DonateButton({
    super.key,
    required this.iapConnection,
  });

  final InAppPurchase iapConnection;

  @override
  State<DonateButton> createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton> {
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  void initState() {
    setUpPurchaseListeners();
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  setUpPurchaseListeners() async {
    if (!(await IAPConnection.isAvailable())) return;

    final Stream purchaseUpdated = IAPConnection.instance.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription?.cancel();
    }, onError: (error) {
      showSnackbarMessage(context, t.more.help_us.donate_err);
    }) as StreamSubscription<List<PurchaseDetails>>;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    final t = Translations.of(context);

    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // LOADING
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          showSnackbarMessage(context, t.more.help_us.donate_err);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          showSnackbarMessage(context, t.more.help_us.donate_success);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  showSnackbarMessage(BuildContext context, String msg) {
    final snackbarDisplayer = ScaffoldMessenger.of(context).showSnackBar;

    snackbarDisplayer(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        radius: 8,
        onTap: () async {
          final snackbarDisplayer = ScaffoldMessenger.of(context).showSnackBar;

          if (!(await IAPConnection.isAvailable())) {
            // TODO: Implement other payment methods
            snackbarDisplayer(
              const SnackBar(
                content: Text(
                    'The current platform not supported or the store is not ready yet'),
              ),
            );

            return;
          }

          const Set<String> productsIDs = <String>{'donate'};

          final ProductDetailsResponse response =
              await widget.iapConnection.queryProductDetails(productsIDs);

          if (response.notFoundIDs.isNotEmpty) {
            snackbarDisplayer(
              SnackBar(
                content: Text(
                    "Products not found -> ${response.notFoundIDs.join(',')}"),
              ),
            );

            return;
          } else if (response.error != null) {
            snackbarDisplayer(
              SnackBar(
                content: Text(response.error!.message),
              ),
            );

            return;
          }

          ProductDetails product = response.productDetails[0];

          await InAppPurchase.instance.buyConsumable(
            purchaseParam: PurchaseParam(productDetails: product),
          );
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0),
          color: isAppInLightBrightness(context)
              ? AppColors.of(context).danger.lighten(0.8)
              : AppColors.of(context).danger.withOpacity(0.2),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary, width: 2),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.volunteer_activism_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.more.help_us.donate,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        t.more.help_us.donate_descr,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

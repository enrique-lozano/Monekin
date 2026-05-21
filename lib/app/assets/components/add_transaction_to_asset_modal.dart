import 'package:flutter/material.dart';
import 'package:monekin/app/debts/components/transaction_selector.dart';
import 'package:monekin/app/transactions/form/transaction_form.page.dart';
import 'package:monekin/core/database/services/account/asset_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/presentation/widgets/outlined_button_stacked.dart';
import 'package:monekin/core/presentation/widgets/transaction_filter/transaction_filter_set.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

void showAddTransactionToAssetModal(
  BuildContext context, {
  required Asset asset,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => AddTransactionToAssetModal(asset: asset),
  );
}

class AddTransactionToAssetModal extends StatelessWidget {
  const AddTransactionToAssetModal({required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ModalContainer(
      title: t.assets.actions.add_register.modal_title,
      subtitle: t.assets.actions.add_register.modal_subtitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(
          children: [
            OutlinedButtonStacked(
              text: t.assets.actions.link_transaction.title,
              afterWidget: Text(t.assets.actions.link_transaction.description),
              iconData: Icons.link_rounded,
              alignLeft: true,
              alignBeside: true,
              padding: const EdgeInsets.all(16),
              onTap: () {
                showTransactionSelectorModal(
                  context,
                  initialFilters: TransactionFilterSet(
                    transactionTypes: [
                      TransactionType.income,
                      TransactionType.expense,
                    ],
                    assetIds: [],
                  ),
                  onTransactionSelected: (transaction) async {
                    RouteUtils.popRoute();
                    try {
                      await AssetService.instance.linkTransactionToAsset(
                        transactionId: transaction.id,
                        assetId: asset.id,
                      );
                      MonekinSnackbar.success(
                        SnackbarParams(
                          t.assets.actions.link_transaction.success,
                          showAtTop: true,
                        ),
                      );
                    } catch (e) {
                      MonekinSnackbar.error(
                        SnackbarParams.fromError(e, showAtTop: true),
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            OutlinedButtonStacked(
              text: t.assets.actions.new_investment_transaction.title,
              afterWidget: Text(
                t.assets.actions.new_investment_transaction.description,
              ),
              iconData: Icons.trending_up_rounded,
              alignLeft: true,
              alignBeside: true,
              padding: const EdgeInsets.all(16),
              onTap: () {
                RouteUtils.popRoute();
                RouteUtils.pushRoute(
                  TransactionFormPage(
                    mode: TransactionType.investment,
                    linkedAsset: asset,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

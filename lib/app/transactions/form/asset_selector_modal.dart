import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/account/investment_service.dart';
import 'package:monekin/core/models/asset/asset.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

Future<Asset?> showAssetSelectorBottomSheet(
  BuildContext context, {
  Asset? selectedAsset,
}) {
  return showModalBottomSheet<Asset>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => _AssetSelectorModal(selectedAsset: selectedAsset),
  );
}

class _AssetSelectorModal extends StatelessWidget {
  const _AssetSelectorModal({this.selectedAsset});

  final Asset? selectedAsset;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return ModalContainer(
          title: t.assets.details.trade_form_asset_column,
          body: StreamBuilder<List<Asset>>(
            stream: InvestmentService.instance.getAssets(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final assets = snapshot.data!;
              if (assets.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    t.assets.empty_description,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.separated(
                controller: scrollController,
                itemCount: assets.length,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  final asset = assets[index];
                  return RadioListTile<String>(
                    value: asset.id,
                    groupValue: selectedAsset?.id,
                    title: Text(asset.name),
                    secondary: IconDisplayer(
                      displayMode: IconDisplayMode.polygon,
                      icon: Icons.pie_chart_outline_rounded,
                      mainColor: Theme.of(context).colorScheme.primary,
                    ),
                    onChanged: (_) => RouteUtils.popRoute(asset),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

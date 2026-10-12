import 'package:flutter/material.dart';
import 'package:monekin/app/assets/widgets/asset_type_card.dart';
import 'package:monekin/core/models/asset/asset_type.enum.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A grid of [AssetTypeCard]s for choosing an [AssetType].
///
/// Shared by the asset-creation type step ([AssetFormPage]) and
/// [showAssetTypeSelector], so both entry points look and behave the same.
class AssetTypeGrid extends StatelessWidget {
  const AssetTypeGrid({
    super.key,
    required this.selectedType,
    required this.onSelected,
  });

  final AssetType? selectedType;
  final ValueChanged<AssetType> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisExtent: 136,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: AssetType.values.length,
      itemBuilder: (context, index) {
        final type = AssetType.values[index];
        return AssetTypeCard(
          type: type,
          selected: type == selectedType,
          onTap: () => onSelected(type),
        );
      },
    );
  }
}

/// Opens a bottom sheet for choosing an asset type.
///
/// Returns the selected [AssetType] immediately when the user taps an option,
/// or `null` if the sheet is dismissed without a selection.
Future<AssetType?> showAssetTypeSelector(
  BuildContext context, {
  required AssetType selectedType,
}) {
  final t = Translations.of(context);

  return RouteUtils.showResponsiveModal<AssetType>(
    context,
    builder: (context) => ModalContainer(
      title: t.assets.form.asset_type,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: AssetTypeGrid(
          selectedType: selectedType,
          onSelected: (type) => RouteUtils.popRoute(type),
        ),
      ),
    ),
  );
}

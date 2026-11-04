import 'package:material_ui/material_ui.dart';
import 'package:monekin/core/presentation/app_colors.dart';

Radius get inputBorderRadius => Radius.circular(6);

BoxDecoration cardSurfaceDecoration(
  BuildContext context, {
  double radius = 20,
}) {
  return BoxDecoration(
    color: Theme.of(context).colorScheme.surfaceContainerLow,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.4),
    ),
  );
}

List<BoxShadow> boxShadowGeneral(BuildContext context) {
  return [
    BoxShadow(
      color: AppColors.of(context).shadowColorLight.withOpacity(0.12),
      blurRadius: 10,
      offset: Offset(0, 0),
      spreadRadius: 4,
    ),
  ];
}

UnderlineInputBorder get appInputBorder => UnderlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.only(
    topLeft: inputBorderRadius,
    topRight: inputBorderRadius,
    bottomLeft: inputBorderRadius,
    bottomRight: inputBorderRadius,
  ),
  //    borderSide: BorderSide(color: theme.colorScheme.outline),
);

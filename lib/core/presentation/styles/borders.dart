import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';

Radius get inputBorderRadius => Radius.circular(6);

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

import 'package:flutter/material.dart';
import 'package:parsa/core/presentation/app_colors.dart';

Widget createListSeparator(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.of(context).primary),
    ),
  );
}

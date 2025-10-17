import 'package:flutter/material.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';

class CategoryButtonSelector extends StatelessWidget {
  const CategoryButtonSelector({
    super.key,
    required this.iconWidget,
    required this.label,
    required this.maxTextSize,
  });

  final IconDisplayer iconWidget;
  final String label;

  final double maxTextSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        iconWidget,
        const SizedBox(height: 4),
        SizedBox(
          width: maxTextSize,
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}

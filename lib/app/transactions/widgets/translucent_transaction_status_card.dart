import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';

class TranslucentTransactionStatusCard extends StatelessWidget {
  const TranslucentTransactionStatusCard({
    super.key,
    required this.color,
    required this.body,
    required this.icon,
    required this.title,
  });

  final Color color;
  final Widget body;
  final IconData? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.125),
        border: Border.all(
          width: 1,
          color: color,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).shadowColorLight,
            blurRadius: 12,
            offset: const Offset(0, 0),
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          body
        ],
      ),
    );
  }
}

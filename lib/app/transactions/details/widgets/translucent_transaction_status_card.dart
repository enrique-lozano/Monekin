import 'package:flutter/material.dart';

class TranslucentTransactionStatusCard extends StatelessWidget {
  const TranslucentTransactionStatusCard({
    super.key,
    required this.color,
    required this.body,
    required this.icon,
    required this.title,
    this.initiallyExpanded = false,
  });

  final Color color;
  final Widget body;
  final IconData? icon;
  final String title;

  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(title),
        leading: Icon(icon, size: 24, color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: color.withOpacity(0.125),
        collapsedBackgroundColor: color.withOpacity(0.125),
        iconColor: color,
        collapsedIconColor: color,
        initiallyExpanded: initiallyExpanded,
        children: [body],
      ),
    );
  }
}

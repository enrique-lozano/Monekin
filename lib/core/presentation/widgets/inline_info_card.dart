import 'package:flutter/material.dart';

enum InlineInfoCardMode { warn, info }

class InlineInfoCard extends StatelessWidget {
  const InlineInfoCard({super.key, required this.text, required this.mode});

  final String text;

  final InlineInfoCardMode mode;

  @override
  Widget build(BuildContext context) {
    final Color color = mode == InlineInfoCardMode.info
        ? Theme.of(context).primaryColor
        : Colors.amber;

    return Card(
      color: color.withOpacity(0.2),
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              mode == InlineInfoCardMode.info
                  ? Icons.info_rounded
                  : Icons.warning_rounded,
              color: color,
              size: 28,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12.25,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

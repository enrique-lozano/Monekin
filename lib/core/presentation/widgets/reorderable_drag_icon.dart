import 'package:flutter/material.dart';

class ReorderableDragIcon extends StatelessWidget {
  const ReorderableDragIcon(
      {super.key, required this.index, this.enabled = true});

  final int index;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      enabled: enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Container(
          // Padding to increase the dragabble area:
          padding: const EdgeInsets.fromLTRB(14, 4, 2, 4),

          // color: Colors.red,
          child: const Icon(Icons.drag_handle_rounded),
        ),
      ),
    );
  }
}

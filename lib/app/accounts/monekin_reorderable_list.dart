import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MonekinReorderableList extends StatefulWidget {
  const MonekinReorderableList({
    super.key,
    required this.itemBuilder,
    required this.onReorder,
    required this.totalItemCount,
  });

  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(int from, int to) onReorder;

  final int totalItemCount;

  @override
  State<MonekinReorderableList> createState() => _MonekinReorderableListState();
}

class _MonekinReorderableListState extends State<MonekinReorderableList> {
  int? isOrderingItem;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Opacity(
        key: Key(index.toString()),
        opacity: isOrderingItem == null || isOrderingItem == index ? 1 : 0.4,
        child: ReorderableDelayedDragStartListener(
          index: index,
          enabled: widget.totalItemCount > 1,
          child: widget.itemBuilder(context, index),
        ),
      ),
      buildDefaultDragHandles: false,
      itemCount: widget.totalItemCount,
      onReorder: (from, to) => widget.onReorder(from, to),
      onReorderStart: (index) {
        HapticFeedback.lightImpact();

        setState(() {
          isOrderingItem = index;
        });
      },
      onReorderEnd: (index) {
        setState(() {
          isOrderingItem = null;
        });
      },
    );
  }
}

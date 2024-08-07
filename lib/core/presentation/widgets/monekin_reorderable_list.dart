import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MonekinReorderableList extends StatefulWidget {
  const MonekinReorderableList({
    super.key,
    required this.itemBuilder,
    required this.onReorder,
    required this.totalItemCount,
    this.isOrderEnabled = true,
    this.padding,
  });

  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(int from, int to) onReorder;

  final int totalItemCount;
  final bool isOrderEnabled;

  final EdgeInsets? padding;

  @override
  State<MonekinReorderableList> createState() => _MonekinReorderableListState();
}

class _MonekinReorderableListState extends State<MonekinReorderableList> {
  int? isOrderingItem;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: widget.padding,
      itemBuilder: (context, index) => Opacity(
        key: Key(index.toString()),
        opacity: isOrderingItem == null || isOrderingItem == index ? 1 : 0.4,
        child: ReorderableDelayedDragStartListener(
          index: index,
          enabled: widget.isOrderEnabled,
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

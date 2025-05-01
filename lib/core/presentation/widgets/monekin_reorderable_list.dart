import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MonekinReorderableList extends StatefulWidget {
  const MonekinReorderableList(
      {super.key,
      required this.itemBuilder,
      required this.onReorder,
      required this.totalItemCount,
      this.isOrderEnabled = true,
      this.padding,
      this.spaceBetween = 0});

  final Widget Function(BuildContext context, int index, bool isOrdering)
      itemBuilder;
  final void Function(int from, int to) onReorder;

  final int totalItemCount;
  final bool isOrderEnabled;

  final EdgeInsets? padding;
  final double spaceBetween;

  @override
  State<MonekinReorderableList> createState() => _MonekinReorderableListState();
}

class _MonekinReorderableListState extends State<MonekinReorderableList> {
  int? currentOrderingIndex;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: widget.padding,
      proxyDecorator: (child, index, animation) => Material(
        type: MaterialType.transparency,
        child: child,
      ),
      itemBuilder: (context, index) => Opacity(
        key: Key(index.toString()),
        opacity: currentOrderingIndex == null || currentOrderingIndex == index
            ? 1
            : 0.4,
        child: Padding(
          padding: EdgeInsets.only(
              bottom:
                  index < widget.totalItemCount - 1 ? widget.spaceBetween : 0),
          child: ReorderableDelayedDragStartListener(
            index: index,
            enabled: widget.isOrderEnabled,
            child: widget.itemBuilder(
                context, index, currentOrderingIndex == index),
          ),
        ),
      ),
      buildDefaultDragHandles: false,
      itemCount: widget.totalItemCount,
      onReorder: (from, to) => widget.onReorder(from, to),
      onReorderStart: (index) {
        HapticFeedback.lightImpact();

        setState(() {
          currentOrderingIndex = index;
        });
      },
      onReorderEnd: (index) {
        setState(() {
          currentOrderingIndex = null;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monekin/core/routes/route_utils.dart';

/// Renders selector/picker content as a draggable bottom sheet on mobile and as
/// a plain, parent-bounded box when presented inside a [SelectorPopoverRoute]
/// (wide layouts).
///
/// The popover already provides a bounded height, so the [DraggableScrollableSheet]
/// — which would float with an empty gap inside a fixed box — is skipped and
/// [builder] is handed a regular [ScrollController] instead.
class SheetOrFixed extends StatefulWidget {
  const SheetOrFixed({
    super.key,
    required this.builder,
    this.initialChildSize = 0.85,
    this.minChildSize = 0.625,
    this.maxChildSize = 0.85,
  });

  final Widget Function(BuildContext context, ScrollController scrollController)
  builder;

  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  @override
  State<SheetOrFixed> createState() => _SheetOrFixedState();
}

class _SheetOrFixedState extends State<SheetOrFixed> {
  ScrollController? _fixedController;

  @override
  void dispose() {
    _fixedController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalPresentation.isPopover(context)) {
      _fixedController ??= ScrollController();
      return widget.builder(context, _fixedController!);
    }

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: widget.initialChildSize,
      minChildSize: widget.minChildSize,
      maxChildSize: widget.maxChildSize,
      builder: widget.builder,
    );
  }
}

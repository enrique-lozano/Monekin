import 'package:flutter/material.dart';
import 'package:monekin/core/routes/route_utils.dart';

/// Base Mixin for Keyboard-Aware Draggable Scrollable Sheet Modals
mixin DraggableScrollableKeyboardAware<T extends StatefulWidget> on State<T> {
  final DraggableScrollableController controller =
      DraggableScrollableController();
  double? initialSize;

  ScrollController? _fixedController;

  FocusNode? _searchFocusNode;

  /// Focus node for the modal's search field. In a popover, arrow keys move
  /// focus into the results list (see [createPopoverSearchFocusNode]).
  FocusNode get searchFocusNode =>
      _searchFocusNode ??= createPopoverSearchFocusNode();

  @override
  void dispose() {
    controller.dispose();
    _fixedController?.dispose();
    _searchFocusNode?.dispose();
    super.dispose();
  }

  bool get isKeyboardVisible => MediaQuery.of(context).viewInsets.bottom > 0;

  void rebuild() {
    // In a popover there is no draggable sheet to resize, so just repaint.
    if (ModalPresentation.isPopover(context)) {
      setState(() {});
      return;
    }

    if (!controller.isAttached) return;

    final newSize = isKeyboardVisible ? initialSize : controller.size;

    setState(() {
      initialSize = newSize;
    });
  }

  void moveSheetTo(double position) {
    if (controller.isAttached && mounted) {
      controller.animateTo(
        position,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildDraggableSheet({
    required double minChildSize,
    required double defaultSize,
    required Widget Function(BuildContext, ScrollController) builder,
    double maxChildSize = 1.0,
  }) {
    // Inside a popover the content just fills the bounded box; skip the
    // draggable sheet (which would float with an empty gap) and hand the
    // builder a plain controller instead.
    if (ModalPresentation.isPopover(context)) {
      _fixedController ??= ScrollController();
      return builder(context, _fixedController!);
    }

    if (isKeyboardVisible) {
      moveSheetTo(maxChildSize);
    } else {
      moveSheetTo(initialSize ?? defaultSize);
    }

    return DraggableScrollableSheet(
      controller: controller,
      expand: false,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      initialChildSize: initialSize ?? defaultSize,
      snap: true,
      snapSizes: [defaultSize],
      builder: builder,
    );
  }
}

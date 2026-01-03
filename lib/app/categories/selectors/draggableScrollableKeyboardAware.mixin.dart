import 'package:flutter/material.dart';

/// Base Mixin for Keyboard-Aware Draggable Scrollable Sheet Modals
mixin DraggableScrollableKeyboardAware<T extends StatefulWidget> on State<T> {
  final DraggableScrollableController controller =
      DraggableScrollableController();
  double? initialSize;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isKeyboardVisible => MediaQuery.of(context).viewInsets.bottom > 0;

  void rebuild() {
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

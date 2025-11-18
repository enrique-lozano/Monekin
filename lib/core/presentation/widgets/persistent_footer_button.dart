import 'package:flutter/material.dart';

class PersistentFooterButton extends StatelessWidget {
  const PersistentFooterButton({
    super.key,
    required this.child,
    this.moveWithKeyboard = true,
  });

  final bool moveWithKeyboard;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      margin: moveWithKeyboard
          ? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
          : null,
      child: child,
    );
  }
}

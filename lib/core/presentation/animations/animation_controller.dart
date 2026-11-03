import 'package:material_ui/material_ui.dart';

abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T>
    with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);

  final Duration animationDuration;
  late final animationController = AnimationController(
    vsync: this,
    duration: animationDuration,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

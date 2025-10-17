import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.radius = 2,
    this.color,
    this.animationDuration = 750,
    this.width = 8,
    this.direction = Axis.horizontal,
  }) /* :  assert(value <= 1 && value >= 0) */;

  /// Percentage of the bar to occupy. Must be a value between 0 and 1
  final double value;

  final double radius;

  /// Width of the bar
  final double width;

  final Axis direction;

  /// Color of the progress bar. Will be the primary color of the app if null
  final Color? color;

  /// Animation duration in milliseconds
  final int animationDuration;

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> {
  get isHorizontal => widget.direction == Axis.horizontal;
  get isVertical => widget.direction == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    var barRadius = BorderRadius.only(
      bottomRight: isHorizontal ? Radius.circular(widget.radius) : Radius.zero,
      topLeft: isVertical ? Radius.circular(widget.radius) : Radius.zero,
      topRight: Radius.circular(widget.radius),
    );

    final barColor = widget.color ?? Theme.of(context).colorScheme.primary;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: widget.animationDuration),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: widget.value),
      builder: (context, value, child) {
        if (value.isNaN) value = 0;

        return Container(
          height: isHorizontal ? widget.width : double.infinity,
          width: isHorizontal ? double.infinity : widget.width,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: barRadius,
            color: barColor.withOpacity(0.12),
          ),
          child: FractionallySizedBox(
            widthFactor: isHorizontal ? value : 1,
            heightFactor: isHorizontal ? 1 : value,
            alignment: isHorizontal
                ? FractionalOffset.centerLeft
                : FractionalOffset.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: barRadius,
                color: barColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

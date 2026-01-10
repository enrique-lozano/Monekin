import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/animations/fade_in.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.radius = 2,
    this.color,
    this.animationDuration = 750,
    this.width = 8,
    this.direction = Axis.horizontal,
    this.showPercentageText = false,
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

  final bool showPercentageText;

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> {
  bool get isHorizontal => widget.direction == Axis.horizontal;
  bool get isVertical => widget.direction == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    var barRadius = BorderRadius.circular(widget.radius);

    final barColor = widget.color ?? Theme.of(context).colorScheme.primary;

    final mainBar = TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: widget.animationDuration),
      curve: Curves.easeInOutCubic,
      tween: Tween<double>(begin: 0, end: widget.value),
      builder: (context, value, child) {
        if (value.isNaN) value = 0;

        return ClipRRect(
          borderRadius: barRadius,
          child: Container(
            height: isHorizontal ? widget.width : double.infinity,
            width: isHorizontal ? double.infinity : widget.width,
            decoration: BoxDecoration(color: barColor.withOpacity(0.12)),
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
          ),
        );
      },
    );

    if (!widget.showPercentageText) {
      return mainBar;
    }

    final isDarkMode = isAppInDarkBrightness(context);

    return Stack(
      children: [
        mainBar,
        Positioned.fill(
          child: FadeIn(
            duration: Duration(
              milliseconds: (widget.animationDuration * 0.75).round(),
            ),
            delay: Duration(
              milliseconds: (widget.animationDuration * 0.25).round(),
            ),
            child: Align(
              alignment: Alignment.center,
              child: RotatedBox(
                quarterTurns: isVertical ? 1 : 0,
                child: UINumberFormatter.percentage(
                  amountToConvert: widget.value,
                  showDecimals: false,
                  integerStyle: Theme.of(context).textTheme.labelMedium!
                      .copyWith(
                        color: widget.value > 0.4
                            ? barColor.darkenPastel(
                                amount: isDarkMode ? 0.6 : -0.9,
                              )
                            : barColor.lightenPastel(
                                amount: isDarkMode ? 0.6 : -0.6,
                              ),
                        fontSize:
                            widget.width * (widget.width > 20 ? 0.6 : 0.75),
                      ),
                ).getTextWidget(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class IndicatorLabelOptions {
  /// The label text widget to show. If null, no label will be shown
  final Widget? label;

  /// A percentage (0 to 1) indicating where to position the label along the bar
  final double labelPercent;

  /// The color of the indicator line and label background
  final Color? indicatorColor;

  /// Whether to show the label before (above/left) the bar instead of after (below/right)
  final bool isLabelBeforeBar;

  IndicatorLabelOptions({
    required this.label,
    required this.labelPercent,
    this.indicatorColor,
    this.isLabelBeforeBar = false,
  });
}

class AnimatedProgressBarWithIndicatorLabel extends StatelessWidget {
  AnimatedProgressBarWithIndicatorLabel({
    super.key,
    required this.animatedProgressBar,
    required this.indicatorLabelOptions,

    this.enableLabel = true,
  }) : assert(
         animatedProgressBar.direction == Axis.horizontal,
         'AnimatedProgressBarWithIndicatorLabel only supports horizontal AnimatedProgressBar by the moment',
       );

  final AnimatedProgressBar animatedProgressBar;
  final IndicatorLabelOptions indicatorLabelOptions;
  final bool enableLabel;

  @override
  Widget build(BuildContext context) {
    if (!enableLabel) {
      return animatedProgressBar;
    }

    final barWidth = animatedProgressBar.width;
    final labelColor =
        indicatorLabelOptions.indicatorColor ??
        Theme.of(context).colorScheme.tertiary;

    const indicatorLabelOffset = 5;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            animatedProgressBar,
            Positioned(
              left: constraints.maxWidth * indicatorLabelOptions.labelPercent,
              child: FadeIn(
                duration: Duration(
                  milliseconds: (animatedProgressBar.animationDuration * 0.5)
                      .round(),
                ),
                delay: Duration(
                  milliseconds: (animatedProgressBar.animationDuration * 0.5)
                      .round(),
                ),
                child: Stack(
                  children: [
                    // ----- INDICATOR LABEL ----- //
                    if (indicatorLabelOptions.label != null)
                      Transform.translate(
                        offset: Offset(
                          0,
                          indicatorLabelOptions.isLabelBeforeBar
                              ? -1.0 * indicatorLabelOffset + 1
                              : animatedProgressBar.width +
                                    indicatorLabelOffset -
                                    1,
                        ),
                        child: FractionalTranslation(
                          translation: Offset(
                            indicatorLabelOptions.labelPercent < 0.1
                                ? -0.1
                                : indicatorLabelOptions.labelPercent > 0.9
                                ? -0.8
                                : -0.5,
                            indicatorLabelOptions.isLabelBeforeBar ? -1 : 0,
                          ),
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiary,
                                ),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            child: Container(
                              decoration: BoxDecoration(
                                color: labelColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: indicatorLabelOptions.label,
                            ),
                          ),
                        ),
                      ),

                    // ----- INDICATOR LINE POINTER ----- //
                    Transform.translate(
                      offset: Offset(0, -1.0 * indicatorLabelOffset),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 2.5,
                          height: barWidth + indicatorLabelOffset * 2,
                          color: labelColor.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

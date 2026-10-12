import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/animations/animated_expanded.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';

/// Heads-up shown above the financial-health cards when the score of the
/// selected range should not be read at face value.
class FinanceHealthReliabilityBanner extends StatefulWidget {
  const FinanceHealthReliabilityBanner({super.key, required this.text});

  /// The warning to display, or null to collapse the banner.
  final String? text;

  @override
  State<FinanceHealthReliabilityBanner> createState() =>
      _FinanceHealthReliabilityBannerState();
}

class _FinanceHealthReliabilityBannerState
    extends State<FinanceHealthReliabilityBanner> {
  /// Kept so the banner still has something to show while collapsing.
  String? _lastText;

  @override
  void initState() {
    super.initState();
    _lastText = widget.text;
  }

  @override
  void didUpdateWidget(covariant FinanceHealthReliabilityBanner oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != null) _lastText = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.text ?? _lastText;
    final isDark = isAppInDarkBrightness(context);
    final accent = isDark ? Colors.amber.shade200 : Colors.amber.shade800;

    return AnimatedExpanded(
      expand: widget.text != null,
      child: text == null
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: accent.withOpacity(isDark ? 0.1 : 0.16),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: accent,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: HTMLText(
                          htmlString: text,
                          tags: const {
                            'b': TextStyle(fontWeight: FontWeight.w700),
                          },
                          defaultTextStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: AppColors.of(context).textBody,
                                height: 1.35,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

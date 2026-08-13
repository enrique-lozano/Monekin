import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monekin/core/presentation/animations/fade_in.dart';
import 'package:monekin/core/presentation/animations/scaled_animated_switcher.dart';
import 'package:monekin/core/presentation/theme.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    super.key,
    required this.description,
    this.tintColor,
    this.padding,
    this.noSearchResultsVariation = false,
    this.showIllustration = true,
    this.icon,
    this.title,
    this.bottom,
  });

  final String? title;
  final String description;
  final Color? tintColor;
  final EdgeInsets? padding;

  final bool noSearchResultsVariation;
  final bool showIllustration;

  /// Optional icon shown above the text in the compact variant (i.e. when
  /// [showIllustration] is `false`), as a lightweight stand-in for the
  /// illustration when embedded in cards/lists.
  final IconData? icon;

  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    // The illustrated variant is meant for whole (scrollable) pages, where the
    // extra bottom-heavy spacing visually centers the content below an app
    // bar. The compact variant (no illustration) is meant to be embedded in
    // cards/lists, so it should keep a small, symmetric padding instead.
    final defaultPadding = showIllustration
        ? EdgeInsets.only(
            bottom: MediaQuery.sizeOf(context).height * 0.4 > 400 ? 80 : 40,
            right: 40,
            left: 40,
          )
        : const EdgeInsets.symmetric(horizontal: 24, vertical: 24);

    return FadeIn(
      child: Opacity(
        opacity: isAppInLightBrightness(context) ? 1 : 0.9,
        child: Center(
          child: Padding(
            padding: padding ?? defaultPadding,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showIllustration)
                  Container(
                    constraints: BoxConstraints(
                      maxWidth:
                          MediaQuery.sizeOf(context).height <=
                              MediaQuery.sizeOf(context).width
                          ? MediaQuery.sizeOf(context).height * 0.4 > 400
                                ? 400
                                : MediaQuery.sizeOf(context).height * 0.4
                          : 270,
                    ),
                    child: ScaledAnimatedSwitcher(
                      keyToWatch: noSearchResultsVariation.toString(),
                      duration: const Duration(milliseconds: 250),
                      child: SvgPicture.asset(
                        noSearchResultsVariation
                            ? 'assets/icons/page_states/no_results.svg'
                            : 'assets/icons/page_states/empty_folder.svg',
                        colorFilter: ColorFilter.mode(
                          tintColor == null
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.7)
                              : tintColor!.withOpacity(0.7),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),

                if (showIllustration) const SizedBox(height: 30),

                if (!showIllustration && icon != null) ...[
                  Icon(
                    icon,
                    size: 42,
                    color: (tintColor ?? Theme.of(context).colorScheme.primary)
                        .withOpacity(0.6),
                  ),
                  const SizedBox(height: 14),
                ],

                if (title != null) ...[
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),

                if (bottom != null) ...[const SizedBox(height: 16), bottom!],
                if (showIllustration) const SizedBox(height: 42),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

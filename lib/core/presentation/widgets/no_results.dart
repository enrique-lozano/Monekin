import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monekin/core/presentation/animations/fade_in.dart';
import 'package:monekin/core/presentation/theme.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    super.key,
    required this.description,
    this.tintColor,
    this.padding,
    this.noSearchResultsVariation = false,
    this.showIllustration = true,
    this.title,
    this.bottom,
  });

  final String? title;
  final String description;
  final Color? tintColor;
  final EdgeInsets? padding;

  final bool noSearchResultsVariation;
  final bool showIllustration;

  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Opacity(
        opacity: isAppInLightBrightness(context) ? 1 : 0.9,
        child: Center(
          child: Padding(
            padding:
                padding ??
                EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.4 > 400 ? 100 : 45,
                  right: 40,
                  left: 40,
                ),
            child: Column(
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
                    child: Opacity(
                      opacity: 1,
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
                const SizedBox(height: 42),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

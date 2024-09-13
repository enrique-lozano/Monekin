import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parsa/core/presentation/animations/shake/fade_in.dart';
import 'package:parsa/core/presentation/app_colors.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    super.key,
    required this.description,
    this.tintColor,
    this.padding,
    this.noSearchResultsVariation = false,
    this.title,
  });

  final String? title;
  final String description;
  final Color? tintColor;
  final EdgeInsets? padding;
  final bool noSearchResultsVariation;

  @override
  Widget build(BuildContext context) {
    final Color effectiveTintColor =
        tintColor ?? AppColors.of(context).primary.withOpacity(0.7);
    final bool isLightMode = Theme.of(context).brightness == Brightness.light;
    final double opacity = isLightMode ? 1.0 : 0.9;

    return FadeIn(
      child: Opacity(
        opacity: opacity,
        child: Center(
          child: Padding(
            padding: padding ??
                EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.4 > 400 ? 100 : 45,
                  right: 40,
                  left: 40,
                ),
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).height <=
                            MediaQuery.sizeOf(context).width
                        ? MediaQuery.sizeOf(context).height * 0.4 > 400
                            ? 400
                            : MediaQuery.sizeOf(context).height * 0.4
                        : 270,
                  ),
                  child: SvgPicture.asset(
                    noSearchResultsVariation
                        ? 'assets/icons/page_states/no_results.svg'
                        : 'assets/icons/page_states/empty_folder.svg',
                    colorFilter: ColorFilter.mode(
                      effectiveTintColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 42),
                // Lottie.asset('assets/animations/search-animation.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

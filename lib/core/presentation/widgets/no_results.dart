import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monekin/core/presentation/animations/shake/fade_in.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/theme.dart';

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
    return FadeIn(
      child: Opacity(
        opacity: isAppInLightBrightness(context) ? 1 : 0.9,
        child: Center(
          child: Padding(
            padding: padding ??
                EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.4 > 400 ? 100 : 35,
                  right: 30,
                  left: 30,
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
                          : 270),
                  child: Opacity(
                    opacity: 1,
                    child: SvgPicture.asset(
                      noSearchResultsVariation
                          ? 'assets/icons/page_states/no_results.svg'
                          : 'assets/icons/page_states/empty_folder.svg',
                      colorFilter: ColorFilter.mode(
                        tintColor == null
                            ? AppColors.of(context).primary.withOpacity(0.7)
                            : tintColor!.withOpacity(0.7),
                        BlendMode.srcIn,
                      ),
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

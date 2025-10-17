import 'package:flutter/material.dart';
import 'package:monekin/app/onboarding/onboarding.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/styles/big_button_style.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  Widget buildFirstSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.translate(
              offset: const Offset(-4, 0),
              child: const DisplayAppIcon(height: 80),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Monekin',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          t.intro.welcome_subtitle,
          style: Theme.of(context).textTheme.titleMedium!,
        ),
        const SizedBox(height: 4),
        Text(
          t.intro.welcome_subtitle2,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildSecondSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          t.intro.offline_descr_title,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          t.intro.offline_descr,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () => RouteUtils.pushRoute(
            context,
            const OnboardingPage(),
            withReplacement: true,
          ),
          icon: const Icon(Icons.person_2_rounded, size: 24),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 4),
            child: Text(t.intro.offline_start),
          ),
          style: getBigButtonStyle(context),
        ),
        const Divider(height: 24),
        HTMLText(
          textAlign: TextAlign.center,
          htmlString: t.intro.welcome_footer,
          defaultTextStyle: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w200,
          ),
          tags: {
            'a': TextStyle(
              color: AppColors.of(context).link,
              fontSize: 12.5,
              fontWeight: FontWeight.w200,
            ),
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BreakpointContainer(
            mdChild: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    child: buildFirstSection(context),
                  ),
                ),
                const VerticalDivider(),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    child: buildSecondSection(context),
                  ),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFirstSection(context),
                buildSecondSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

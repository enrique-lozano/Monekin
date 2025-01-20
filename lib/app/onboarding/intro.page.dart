import 'package:flutter/material.dart';
import 'package:monekin/app/onboarding/onboarding.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/translations.g.dart';

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
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(t.intro.welcome_subtitle),
        const SizedBox(height: 4),
        Text(
          t.intro.welcome_subtitle2,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Theme.of(context).colorScheme.primary),
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
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          t.intro.offline_descr,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(fontWeight: FontWeight.w200),
        ),
        const SizedBox(height: 12),
        SizedBox(
          // width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => RouteUtils.pushRoute(
                context, const OnboardingPage(),
                withReplacement: true),
            icon: const Icon(Icons.person_2_rounded),
            label: Align(
              alignment: Alignment.centerLeft,
              child: Text(t.intro.offline_start),
            ),
          ),
        ),
        const SizedBox(height: 18),
        HTMLText(
          htmlString: t.intro.welcome_footer,
          defaultTextStyle:
              const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w200),
          tags: {
            'a': TextStyle(
                color: AppColors.of(context).link,
                fontSize: 12.5,
                fontWeight: FontWeight.w200)
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
                          vertical: 12, horizontal: 24),
                      child: buildFirstSection(context),
                    )),
                const VerticalDivider(),
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: buildSecondSection(context),
                    )),
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

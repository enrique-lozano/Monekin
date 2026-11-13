import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/layout/page_switcher.dart';
import 'package:monekin/app/onboarding/onboarding.dart';
import 'package:monekin/app/settings/pages/backup/restore_backup.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/responsive/breakpoint_container.dart';
import 'package:monekin/core/presentation/styles/button_styles.dart';
import 'package:monekin/core/presentation/widgets/html_text.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/main.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  Future<void> _restoreBackup() async {
    if (!await pickAndRestoreBackup()) return;

    // The restored database has its own settings and app data
    await UserSettingService.instance.initializeGlobalStateMap();
    await AppDataService.instance.initializeGlobalStateMap();
    await AppDataService.instance.setItem(AppDataKey.introSeen, '1');
    appStateKey.currentState?.refreshAppState();

    unawaited(
      RouteUtils.pushRoute(
        PageSwitcher(key: tabsPageKey),
        withReplacement: true,
      ),
    );
  }

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
          ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
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
    final footerStyle = Theme.of(context).textTheme.bodySmall!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          t.intro.offline_descr_title,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
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
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _restoreBackup,
          icon: const Icon(Icons.file_open_outlined, size: 20),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 4),
            child: Text(t.intro.restore_backup),
          ),
          style: getMediumButtonStyle(context),
        ),
        const Divider(height: 24),
        HTMLText(
          textAlign: TextAlign.center,
          htmlString: t.intro.welcome_footer,
          defaultTextStyle: footerStyle,
          tags: {'a': footerStyle.copyWith(color: AppColors.of(context).link)},
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
            mdBuilder: (context) => Row(
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
            builder: (context) => Column(
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

import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/layout/page_switcher.dart';
import 'package:monekin/app/settings/pages/backup/import_csv/import_csv.page.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/utils/demo_app_seeders.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/loading_overlay.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Last step of the onboarding: lets the user choose how to fill the app
/// before reaching the dashboard.
class OnboardingStartPage extends StatelessWidget {
  const OnboardingStartPage({super.key});

  Future<void> _goToDashboard() async {
    await AppDataService.instance.setItem(
      AppDataKey.introSeen,
      '1',
      updateGlobalState: true,
    );

    unawaited(
      RouteUtils.pushRoute(
        PageSwitcher(key: tabsPageKey),
        withReplacement: true,
      ),
    );
  }

  Future<void> _importData() async {
    await _goToDashboard();

    unawaited(RouteUtils.showResponsiveForm(const ImportCSVPage()));
  }

  Future<void> _loadSampleData(BuildContext context) async {
    final loadingOverlay = LoadingOverlay.of(context);
    loadingOverlay.show();

    try {
      await fillWithDemoData();
      loadingOverlay.hide();

      await _goToDashboard();
    } catch (e) {
      Logger.printDebug(e);
      loadingOverlay.hide();

      MonekinSnackbar.error(SnackbarParams.fromError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: screenWidth < 700 ? 1.0 : 700 / screenWidth,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isAppInDarkBrightness(context)
                          ? Theme.of(context).colorScheme.primary.lighten(0.8)
                          : Theme.of(context).colorScheme.primaryContainer
                                .lighten(0.58),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/app_onboarding/wallet.svg',
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    t.intro.start_options.title,
                    style: Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(t.intro.start_options.descr),
                  const SizedBox(height: 16),
                  _StartOptionTile(
                    icon: Icons.file_upload_outlined,
                    title: t.intro.start_options.import,
                    subtitle: t.intro.start_options.import_descr,
                    onTap: _importData,
                  ),
                  _StartOptionTile(
                    icon: Icons.auto_awesome_rounded,
                    title: t.intro.start_options.sample,
                    subtitle: t.intro.start_options.sample_descr,
                    onTap: () => _loadSampleData(context),
                  ),
                  _StartOptionTile(
                    icon: Icons.add_rounded,
                    title: t.intro.start_options.scratch,
                    subtitle: t.intro.start_options.scratch_descr,
                    onTap: _goToDashboard,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StartOptionTile extends StatelessWidget {
  const _StartOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: colors.onSurface.withOpacity(0.04),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          child: Icon(icon, color: colors.onPrimaryContainer),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: colors.onSurface.withOpacity(0.45),
        ),
        onTap: onTap,
      ),
    );
  }
}

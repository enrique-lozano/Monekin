import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/layout/page_switcher.dart';
import 'package:monekin/app/settings/pages/backup/import_csv/import_csv.page.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/database/utils/demo_app_seeders.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
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

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 700;

                final startNow = _StartNowCard(
                  tall: isWide,
                  onTap: _goToDashboard,
                );

                final otherWays = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        t.intro.start_options.other_ways,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.of(context).textBody,
                        ),
                      ),
                    ),
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
                  ],
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        t.intro.start_options.title,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(t.intro.start_options.descr),
                      const SizedBox(height: 24),
                      if (isWide)
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 24,
                            children: [
                              Expanded(child: startNow),
                              Expanded(child: otherWays),
                            ],
                          ),
                        )
                      else ...[
                        startNow,
                        const SizedBox(height: 24),
                        otherWays,
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Main call to action of the page: the fastest way to reach the app.
class _StartNowCard extends StatelessWidget {
  const _StartNowCard({required this.tall, required this.onTap});

  /// Taller layout, used when the card is placed beside the other options
  final bool tall;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colors = Theme.of(context).colorScheme;

    final icon = CircleAvatar(
      radius: tall ? 28 : 22,
      backgroundColor: colors.onPrimary.withValues(alpha: 0.16),
      child: Icon(
        Icons.rocket_launch_rounded,
        color: colors.onPrimary,
        size: tall ? 28 : 22,
      ),
    );

    final texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.intro.start_options.start_now,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.onPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          t.intro.start_options.start_now_descr,
          style: TextStyle(color: colors.onPrimary.withValues(alpha: 0.85)),
        ),
      ],
    );

    final arrow = Icon(Icons.arrow_forward_rounded, color: colors.onPrimary);

    return Material(
      color: colors.primary,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: tall
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    icon,
                    const SizedBox(height: 32),
                    Row(
                      spacing: 12,
                      children: [Expanded(child: texts), arrow],
                    ),
                  ],
                )
              : Row(
                  spacing: 16,
                  children: [icon, Expanded(child: texts), arrow],
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

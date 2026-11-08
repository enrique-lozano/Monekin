import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/layout/page_switcher.dart';
import 'package:monekin/app/settings/pages/backup/import_csv/import_csv.page.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
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
class OnboardingStartPage extends StatefulWidget {
  const OnboardingStartPage({super.key});

  @override
  State<OnboardingStartPage> createState() => _OnboardingStartPageState();
}

class _OnboardingStartPageState extends State<OnboardingStartPage> {
  /// Whether one of the options is running, to ignore repeated taps
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;

    setState(() => _busy = true);

    try {
      await action();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

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
      await _goToDashboard();
    } catch (e) {
      Logger.printDebug(e);

      MonekinSnackbar.error(SnackbarParams.fromError(e));
    } finally {
      loadingOverlay.hide();
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
                final contentWidth = (constraints.maxWidth - 48).clamp(
                  0.0,
                  double.infinity,
                );
                final otherWaysWidth = isWide
                    ? (contentWidth - 24) / 2
                    : contentWidth;

                final startNow = _StartNowCard(
                  tall: isWide,
                  onTap: () => _run(_goToDashboard),
                );

                final otherWays = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: (otherWaysWidth - 8).clamp(
                                0.0,
                                double.infinity,
                              ),
                            ),
                            child: Text(
                              t.intro.start_options.other_ways,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelMedium!
                                  .copyWith(
                                    color: AppColors.of(context).textBody,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant
                                  .withValues(alpha: .4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StartOptionTile(
                      icon: Icons.file_upload_outlined,
                      title: t.intro.start_options.import,
                      subtitle: t.intro.start_options.import_descr,
                      onTap: () => _run(_importData),
                    ),
                    const SizedBox(height: 10),
                    _StartOptionTile(
                      icon: Icons.auto_awesome_rounded,
                      title: t.intro.start_options.sample,
                      subtitle: t.intro.start_options.sample_descr,
                      onTap: () => _run(() => _loadSampleData(context)),
                    ),
                  ],
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: (constraints.maxHeight - 48).clamp(
                        0,
                        double.infinity,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: DisplayAppIcon(height: 80),
                            ),
                            const SizedBox(height: 36),
                            Text(
                              t.intro.start_options.title,
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              t.intro.start_options.descr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isWide)
                                IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                        ),
                      ],
                    ),
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
    final textTheme = Theme.of(context).textTheme;

    final icon = DecoratedBox(
      decoration: BoxDecoration(
        color: colors.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 42,
        height: 42,
        child: Icon(
          Icons.rocket_launch_rounded,
          color: colors.primary,
          size: 22,
        ),
      ),
    );

    final texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.intro.start_options.start_now,
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.onPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          t.intro.start_options.start_now_descr,
          style: textTheme.bodySmall!.copyWith(
            color: colors.onPrimary.withValues(alpha: 0.85),
          ),
        ),
      ],
    );

    final arrow = DecoratedBox(
      decoration: BoxDecoration(
        color: colors.onPrimary,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: 34,
        height: 34,
        child: Icon(Icons.arrow_forward_rounded, color: colors.primary),
      ),
    );

    return Material(
      color: colors.primary,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: tall
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [icon, arrow],
              ),
              SizedBox(height: tall ? 32 : 16),
              texts,
            ],
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
    final textTheme = Theme.of(context).textTheme;
    final borderRadius = BorderRadius.circular(14);

    return Material(
      color: colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: colors.outlineVariant.withValues(alpha: .35)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: 38,
                  height: 38,
                  child: Icon(icon, color: colors.onPrimaryContainer),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle, style: textTheme.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

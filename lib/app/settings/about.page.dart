import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/extensions/string.extension.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/utils/open_external_url.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'widgets/settings_list_utils.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Widget buildLinkItem(
    String title, {
    String? subtitle,
    required Function() onTap,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.open_in_new_rounded,
            size: 20,
            color: AppColors.of(context).textHint,
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.more.about_us.display,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero.withSafeBottom(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DisplayAppIcon(height: 80),
                  const SizedBox(width: 16),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      final packageInfo = snapshot.data;

                      return Skeletonizer(
                        enabled: packageInfo == null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data?.appName.capitalize() ?? 'Monekin',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              'v${snapshot.data?.version ?? 'X.X.X'} (${snapshot.data?.buildNumber ?? '??????'})',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              t.intro.welcome_subtitle2,
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            createListSeparator(context, t.more.about_us.project.display),
            buildLinkItem(
              t.more.about_us.project.contributors,
              subtitle: t.more.about_us.project.contributors_descr,
              onTap: () {
                openExternalURL(
                  context,
                  'https://github.com/enrique-lozano/Monekin/graphs/contributors',
                );
              },
            ),
            buildLinkItem(
              t.more.help_us.report,
              onTap: () {
                openExternalURL(
                  context,
                  'https://github.com/enrique-lozano/Monekin/issues/new/choose',
                );
              },
            ),
            buildLinkItem(
              t.more.about_us.project.contact,
              onTap: () {
                openExternalURL(context, 'mailto:lozin.technologies@gmail.com');
              },
            ),
            createListSeparator(context, t.more.about_us.legal.display),
            buildLinkItem(
              t.more.about_us.legal.terms,
              onTap: () {
                openExternalURL(
                  context,
                  'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md',
                );
              },
            ),
            buildLinkItem(
              t.more.about_us.legal.privacy,
              onTap: () {
                openExternalURL(
                  context,
                  'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md',
                );
              },
            ),
            buildLinkItem(
              t.more.about_us.legal.licenses,
              onTap: () async {
                openLicense({String? appName, String? version}) {
                  showLicensePage(
                    context: context,
                    applicationName: appName,
                    applicationVersion: version,
                  );
                }

                final info = await PackageInfo.fromPlatform();
                openLicense(appName: info.appName, version: info.version);
              },
            ),
          ],
        ),
      ),
    );
  }
}

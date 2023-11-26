import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/utils/open_external_url.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:slang/builder/utils/string_extensions.dart';

@RoutePage()
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Widget buildLinkItem(
    String title, {
    String? subtitle,
    required Function() onTap,
  }) {
    return ListTile(
      title: Text(title),
      minVerticalPadding: 16,
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.about_us.display)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/resources/appIcon-removebg.png',
                        height: 80,
                      ),
                      const SizedBox(width: 16),
                      FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Column(
                                children: [
                                  Skeleton(width: 25, height: 16),
                                  Skeleton(width: 12, height: 12),
                                ],
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.appName.capitalize(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                Text(
                                  'v${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  t.intro.welcome_subtitle2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
            createListSeparator(context, t.settings.about_us.project.display),
            buildLinkItem(
              t.settings.about_us.project.contributors,
              subtitle: t.settings.about_us.project.contributors_descr,
              onTap: () {
                openExternalURL(context,
                    'https://github.com/enrique-lozano/Monekin/graphs/contributors');
              },
            ),
            buildLinkItem(
              t.settings.help_us.report,
              onTap: () {
                openExternalURL(context,
                    'https://github.com/enrique-lozano/Monekin/issues/new/choose');
              },
            ),
            buildLinkItem(t.settings.about_us.project.contact, onTap: () {
              openExternalURL(context, 'mailto:lozin.technologies@gmail.com');
            }),
            createListSeparator(context, t.settings.about_us.legal.display),
            buildLinkItem(
              t.settings.about_us.legal.terms,
              onTap: () {
                openExternalURL(context,
                    'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md');
              },
            ),
            buildLinkItem(
              t.settings.about_us.legal.privacy,
              onTap: () {
                openExternalURL(context,
                    'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md');
              },
            ),
            buildLinkItem(
              t.settings.about_us.legal.licenses,
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

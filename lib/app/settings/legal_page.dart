import 'package:flutter/material.dart';
import 'package:monekin/core/utils/open_external_url.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  Widget buildLinkItem(String title, {required Function() onTap}) {
    return ListTile(
      title: Text(title),
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
      appBar: AppBar(title: Text(t.settings.project.legal)),
      body: Column(
        children: [
          buildLinkItem(
            t.settings.terms_of_use.title,
            onTap: () {
              openExternalURL(context,
                  'https://github.com/enrique-lozano/Monekin/blob/main/docs/TERMS_OF_USE.md');
            },
          ),
          buildLinkItem(
            t.settings.privacy.title,
            onTap: () {
              openExternalURL(context,
                  'https://github.com/enrique-lozano/Monekin/blob/main/docs/PRIVACY_POLICY.md');
            },
          ),
          buildLinkItem(
            t.settings.licenses.title,
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
    );
  }
}

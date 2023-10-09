import 'package:flutter/material.dart';
import 'package:monekin/app/settings/settings.page.dart';
import 'package:monekin/core/utils/open_external_url.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:share_plus/share_plus.dart';

class HelpUsPage extends StatelessWidget {
  const HelpUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.help_us.display)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/resources/appIcon-removebg.png',
                    height: 80,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.settings.help_us.thanks,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(t.settings.help_us.thanks_long)
                      ],
                    ),
                  )
                ],
              ),
            ),
            createSettingItem(context,
                title: t.settings.help_us.rate_us,
                subtitle: t.settings.help_us.rate_us_descr,
                icon: Icons.star_rounded, onTap: () {
              openExternalURL(context,
                  'https://play.google.com/store/apps/details?id=com.monekin.app');
            }),
            createSettingItem(context,
                title: t.settings.help_us.share,
                subtitle: t.settings.help_us.share_descr,
                icon: Icons.share, onTap: () {
              Share.share(
                  '${t.settings.help_us.share_text}: https://play.google.com/store/apps/details?id=com.monekin.app');
            }),
            createSettingItem(context,
                title: t.settings.help_us.report,
                icon: Icons.rate_review_outlined, onTap: () {
              openExternalURL(context,
                  'https://github.com/enrique-lozano/Monekin/issues/new/choose');
            }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                radius: 8,
                onTap: () {
                  // TODO
                },
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(0),
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary,
                          width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.volunteer_activism_rounded,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.settings.help_us.donate,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                t.settings.help_us.donate_descr,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

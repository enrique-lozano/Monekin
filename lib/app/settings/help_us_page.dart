import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/purchases/donate_button.dart';
import 'package:monekin/app/settings/purchases/in_app_purchase.dart';
import 'package:monekin/app/settings/widgets/display_app_icon.dart';
import 'package:monekin/app/settings/widgets/setting_card_item.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/utils/open_external_url.dart';
import 'package:monekin/i18n/generated/translations.g.dart';
import 'package:share_plus/share_plus.dart';

class HelpUsPage extends StatefulWidget {
  const HelpUsPage({super.key});

  @override
  State<HelpUsPage> createState() => _HelpUsPageState();
}

class _HelpUsPageState extends State<HelpUsPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final iapConnection = IAPConnection.instance;

    return PageFramework(
      title: t.more.help_us.display,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero.withSafeBottom(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const DisplayAppIcon(height: 80),
                  const SizedBox(height: 18),
                  Text(
                    t.more.help_us.thanks,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(t.more.help_us.thanks_long, textAlign: TextAlign.center),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SettingCardItem(
                    title: t.more.help_us.rate_us,
                    subtitle: t.more.help_us.rate_us_descr,
                    icon: Icons.star_rounded,
                    mainAxis: Axis.horizontal,
                    onTap: () {
                      openExternalURL(
                        context,
                        'https://play.google.com/store/apps/details?id=com.monekin.app',
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  SettingCardItem(
                    title: t.more.help_us.share,
                    subtitle: t.more.help_us.share_descr,
                    icon: Icons.share,
                    mainAxis: Axis.horizontal,
                    onTap: () {
                      SharePlus.instance.share(
                        ShareParams(
                          text:
                              '${t.more.help_us.share_text}: https://play.google.com/store/apps/details?id=com.monekin.app',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  SettingCardItem(
                    title: t.more.help_us.report,
                    icon: Icons.rate_review_outlined,
                    mainAxis: Axis.horizontal,
                    onTap: () {
                      openExternalURL(
                        context,
                        'https://github.com/enrique-lozano/Monekin/issues/new/choose',
                      );
                    },
                  ),
                ],
              ),
            ),
            DonateButton(iapConnection: iapConnection),
          ],
        ),
      ),
    );
  }
}

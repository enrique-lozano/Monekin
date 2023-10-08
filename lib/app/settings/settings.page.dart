import 'package:flutter/material.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/app/settings/advanced_settings_page.dart';
import 'package:monekin/app/settings/edit_profile_modal.dart';
import 'package:monekin/app/settings/export_page.dart';
import 'package:monekin/app/settings/import_page.dart';
import 'package:monekin/app/settings/legal_page.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/core/utils/open_external_url.dart';
import 'package:monekin/i18n/translations.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ListTile createSettingItem(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function() onTap}) {
    return ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
        onTap: () => onTap());
  }

  Widget createListSeparator(String title) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Text(title, style: const TextStyle(fontSize: 14)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final settingService = UserSettingService.instance;

    return Scaffold(
        appBar: AppBar(
          title: Text(t.settings.title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        builder: (context) {
                          return const EditProfileModal();
                        });
                  },
                  title: Text(t.settings.edit_profile),
                  subtitle: StreamBuilder(
                      stream: settingService.getSetting(SettingKey.userName),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Skeleton(width: 70, height: 12);
                        }

                        return Text(snapshot.data!);
                      }),
                  leading: StreamBuilder(
                      stream: UserSettingService.instance
                          .getSetting(SettingKey.avatar),
                      builder: (context, snapshot) {
                        return UserAvatar(avatar: snapshot.data);
                      })),
              const SizedBox(height: 12),
              createListSeparator(t.settings.general.display),
              createSettingItem(
                  title: t.general.categories,
                  subtitle: t.settings.general.categories_descr,
                  icon: Icons.sell_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesList(
                                mode: CategoriesListMode.page)));
                  }),
              const Divider(indent: 54),
              createSettingItem(
                  title: t.currencies.currency_manager,
                  subtitle:
                      'Configura tu divisa y sus tipos de cambio con otras',
                  icon: Icons.currency_exchange,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CurrencyManagerPage()));
                  }),
              const Divider(indent: 54),
              createSettingItem(
                  title: t.settings.general.other,
                  subtitle: t.settings.general.other_descr,
                  icon: Icons.build_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdvancedSettingsPage()));
                  }),
              const SizedBox(height: 22),
              createListSeparator(t.settings.data.display),
              createSettingItem(
                  title: t.backup.export.title_sort,
                  subtitle: t.settings.data.export_descr,
                  icon: Icons.cloud_download_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExportDataPage()));
                  }),
              const Divider(indent: 54),
              createSettingItem(
                  title: t.backup.import.title,
                  icon: Icons.cloud_upload_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ImportPage()));
                  }),
              const SizedBox(height: 22),
              createListSeparator(t.settings.help_us.display),
              createSettingItem(
                  title: t.settings.help_us.rate_us,
                  subtitle: t.settings.help_us.rate_us_descr,
                  icon: Icons.star_rate_outlined,
                  onTap: () {
                    openExternalURL(context,
                        'https://play.google.com/store/apps/details?id=com.monekin.app');
                  }),
              const Divider(indent: 54),
              createSettingItem(
                  title: t.settings.help_us.share,
                  icon: Icons.share,
                  onTap: () {
                    Share.share(
                        'Monekin! The best personal finance app. Download here: https://play.google.com/store/apps/details?id=com.monekin.app');
                  }),
              const Divider(indent: 54),
              createSettingItem(
                  title: t.settings.help_us.report,
                  icon: Icons.rate_review_outlined,
                  onTap: () {
                    openExternalURL(context,
                        'https://github.com/enrique-lozano/Monekin/issues/new/choose');
                  }),
              const SizedBox(height: 22),
              createListSeparator('Project'),
              createSettingItem(
                  title: t.settings.project.legal,
                  subtitle: t.settings.project.legal_descr,
                  icon: Icons.inventory_outlined,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LegalPage()));
                  }),
              const Divider(indent: 54),
              createSettingItem(
                  title: t.settings.project.contributors,
                  subtitle: t.settings.project.contributors_descr,
                  icon: Icons.group_outlined,
                  onTap: () {
                    openExternalURL(context,
                        'https://github.com/enrique-lozano/Monekin/graphs/contributors');
                  }),
              const Divider(indent: 54),
              createSettingItem(
                  title: t.settings.project.contact,
                  icon: Icons.email_outlined,
                  onTap: () {
                    openExternalURL(
                        context, 'mailto:lozin.technologies@gmail.com');
                  }),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Skeleton(width: 45, height: 12);
                      }

                      return Center(
                        child: Text(
                          '${snapshot.data!.appName} - v${snapshot.data!.version}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}

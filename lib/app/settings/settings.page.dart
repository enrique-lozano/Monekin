import 'package:flutter/material.dart';
import 'package:monekin/app/categories/categories_list.dart';
import 'package:monekin/app/currencies/currency_manager.dart';
import 'package:monekin/app/settings/about_page.dart';
import 'package:monekin/app/settings/appearance_settings_page.dart';
import 'package:monekin/app/settings/backup_settings_page.dart';
import 'package:monekin/app/settings/edit_profile_modal.dart';
import 'package:monekin/app/settings/help_us_page.dart';
import 'package:monekin/app/tags/tag_list.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/skeleton.dart';
import 'package:monekin/core/presentation/widgets/user_avatar.dart';
import 'package:monekin/i18n/translations.g.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

Widget createListSeparator(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(
      title.toUpperCase(),
      style:
          TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary),
    ),
  );
}

ListTile createSettingItem(BuildContext context,
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
            color: appColorScheme(context).primary,
          ),
        ],
      ),
      onTap: () => onTap());
}

class _SettingsPageState extends State<SettingsPage> {
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
              createSettingItem(context,
                  title: t.general.categories,
                  subtitle: t.settings.general.categories_descr,
                  icon: Icons.category_rounded, onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const CategoriesList(mode: CategoriesListMode.page),
                    ));
              }),
              createSettingItem(context,
                  title: t.tags.display(n: 10),
                  subtitle: t.settings.general.categories_descr,
                  icon: Icons.label_outline_rounded, onTap: () {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TagList(),
                    ));
              }),
              createSettingItem(context,
                  title: t.currencies.currency_manager,
                  subtitle: t.currencies.currency_manager_descr,
                  icon: Icons.currency_exchange, onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CurrencyManagerPage()));
              }),
              createSettingItem(context,
                  title: t.settings.general.appearance,
                  subtitle: t.settings.general.appearance_descr,
                  icon: Icons.palette_outlined, onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdvancedSettingsPage()));
              }),
              createSettingItem(context,
                  title: t.settings.data.display,
                  subtitle: t.settings.data.display_descr,
                  icon: Icons.storage_rounded, onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BackupSettings()));
              }),
              createSettingItem(context,
                  title: t.settings.about_us.display,
                  subtitle: t.settings.about_us.description,
                  icon: Icons.info_outline_rounded, onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              }),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  radius: 8,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpUsPage())),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(0),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.settings.help_us.display,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  t.settings.help_us.description,
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
        ));
  }
}

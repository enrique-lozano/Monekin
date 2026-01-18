import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/language_selector.dart';
import 'package:monekin/app/settings/widgets/monekin_tile_switch.dart';
import 'package:monekin/app/settings/widgets/settings_list_utils.dart';
import 'package:monekin/core/database/services/user-setting/enum/supported_locales.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/presentation/animations/scaled_animated_switcher.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class GeneralSettingsPage extends StatefulWidget {
  const GeneralSettingsPage({super.key});

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final currentLangTag = appStateSettings[SettingKey.appLanguage];
    final currentSelectedLangDisplayName =
        appSupportedLocales
            .firstWhereOrNull(
              (element) => element.locale.languageTag == currentLangTag,
            )
            ?.label ??
        t.settings.general.locale.auto;

    return PageFramework(
      title: t.settings.general.menu_title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16).withSafeBottom(context),
        child: ListTileTheme(
          data: getSettingListTileStyle(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createListSeparator(context, t.settings.general.language.section),
              ListTile(
                title: Text(t.settings.general.language.title),
                leading: const Icon(Icons.language),
                subtitle: Text(currentSelectedLangDisplayName),
                onTap: () async {
                  final newLang = await showLanguageSelectorBottomSheet(
                    context,
                    LanguageSelector(selectedLangTag: currentLangTag),
                  );

                  if (newLang == null) {
                    return;
                  }

                  if (newLang.result != null) {
                    await LocaleSettings.setLocaleRaw(
                      newLang.result!,
                      listenToDeviceLocale: true,
                    );
                  } else {
                    await LocaleSettings.useDeviceLocale();
                  }

                  try {
                    await UserSettingService.instance.setItem(
                      SettingKey.appLanguage,
                      newLang.result,
                      updateGlobalState: true,
                    );
                  } catch (e) {
                    MonekinSnackbar.error(
                      SnackbarParams.fromError(
                        'There was an error persisting this setting on your device. Contact the developers for more information',
                      ),
                    );
                  }
                },
              ),
              ShowAllDecimalPlacesSwitch(),
              createListSeparator(context, t.settings.security.title),
              MonekinTileSwitch(
                title: t.settings.security.private_mode_at_launch,
                subtitle: t.settings.security.private_mode_at_launch_descr,
                icon: const Icon(Icons.phonelink_lock_outlined),
                initialValue:
                    appStateSettings[SettingKey.privateModeAtLaunch] == '1',
                onSwitch: (bool value) async {
                  await PrivateModeService.instance.setPrivateModeAtLaunch(
                    value,
                  );
                },
              ),
              StreamBuilder(
                stream: PrivateModeService.instance.privateModeStream,
                builder: (context, snapshot) {
                  final initialValue = (snapshot.data ?? false);

                  return MonekinTileSwitch(
                    title: t.settings.security.private_mode,
                    subtitle: t.settings.security.private_mode_descr,
                    icon: ScaledAnimatedSwitcher(
                      keyToWatch: initialValue.toString(),
                      child: Icon(
                        initialValue
                            ? Icons.lock_outline_rounded
                            : Icons.lock_open_rounded,
                      ),
                    ),
                    initialValue: initialValue,
                    onSwitch: (bool value) {
                      setState(() {
                        PrivateModeService.instance.setPrivateMode(value);
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowAllDecimalPlacesSwitch extends StatelessWidget {
  const ShowAllDecimalPlacesSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MonekinTileSwitch(
      title: t.settings.general.show_all_decimals,
      subtitle: t.settings.general.show_all_decimals_descr,
      icon: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        child: Icon(
          Icons.exposure_zero,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      initialValue: appStateSettings[SettingKey.showAllDecimals] == '1',
      onSwitchDebounceMs: 200,
      onSwitch: (bool value) async {
        await UserSettingService.instance.setItem(
          SettingKey.showAllDecimals,
          value ? '1' : '0',
          updateGlobalState: true,
        );
      },
    );
  }
}

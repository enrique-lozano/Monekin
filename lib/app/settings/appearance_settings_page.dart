import 'package:flutter/material.dart';
import 'package:monekin/app/settings/widgets/language_selector.dart';
import 'package:monekin/app/settings/widgets/monekin_tile_switch.dart';
import 'package:monekin/app/settings/widgets/supported_locales.dart';
import 'package:monekin/core/database/services/user-setting/private_mode_service.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/services/user-setting/utils/get_theme_from_string.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/animations/scaled_animated_switcher.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker_modal.dart';
import 'package:monekin/core/presentation/widgets/monekin_dropdown_select.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

import '../../core/presentation/app_colors.dart';
import 'widgets/settings_list_separator.dart';

class AdvancedSettingsPage extends StatefulWidget {
  const AdvancedSettingsPage({super.key});

  @override
  State<AdvancedSettingsPage> createState() => _AdvancedSettingsPageState();
}

class SelectItem<T> {
  T value;
  String label;

  IconData? icon;

  SelectItem({
    required this.value,
    required this.label,
    this.icon,
  });
}

class _AdvancedSettingsPageState extends State<AdvancedSettingsPage> {
  late GlobalKey<MonekinDropdownSelectState>? _themeDropdownKey = GlobalKey();
  late GlobalKey<MonekinDropdownSelectState>? _swipeRightActionDropdownKey = GlobalKey();
  late GlobalKey<MonekinDropdownSelectState>? _swipeLeftActionDropdownKey = GlobalKey();
 
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.title_short),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createListSeparator(context, t.settings.lang_section),
            ListTile(
              title: Text(t.settings.lang_title),
              leading: const Icon(Icons.language),
              subtitle: Text(
                appSupportedLocales
                    .firstWhere((element) =>
                        element.locale.languageTag ==
                        LocaleSettings.currentLocale.languageTag)
                    .label,
              ),
              onTap: () async {
                final snackbarDisplayer =
                    ScaffoldMessenger.of(context).showSnackBar;

                final newLang = await showLanguageSelectorBottomSheet(
                  context,
                  LanguageSelector(
                      selectedLangTag:
                          LocaleSettings.currentLocale.languageTag),
                );

                if (newLang?.result == null) {
                  return;
                }

                LocaleSettings.setLocaleRaw(newLang!.result!,
                    listenToDeviceLocale: true);

                try {
                  await UserSettingService.instance.setItem(
                    SettingKey.appLanguage,
                    newLang.result!,
                    updateGlobalState: true,
                  );
                } catch (e) {
                  snackbarDisplayer(const SnackBar(
                    content: Text(
                        'There was an error persisting this setting on your device. Contact the developers for more information'),
                  ));
                }
              },
            ),
            // TODO: Need to move this to i18n and add the translations later on.
            createListSeparator(context, "Swipe Actions"),
            Builder(
              builder: (context) {
                final statusCodeString = appStateSettings[SettingKey.rightSwipe];
                
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TODO: Need to implement for Swipe Right
                      // TODO: Need to move this to i18n and add the translations later on.
                      Flexible(child: Text("Swipe Right")),
                      const SizedBox(width: 12),
                      Flexible(child: _buildSwipeActionDropdown(statusCodeString, SettingKey.rightSwipe, _swipeRightActionDropdownKey))
                    ],
                  ),
                  onTap: () {
                    _swipeRightActionDropdownKey!.currentState!.openDropdown();
                  },
                  // leading: ScaledAnimatedSwitcher(
                  //   keyToWatch: theme.icon(context).toString(),
                  //   child: Icon(theme.icon(context)),
                  // ),
                );
              },
            ),
            Builder(
              builder: (context) {
                final statusCodeString = appStateSettings[SettingKey.leftSwipe];
                
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TODO: Need to implement for Swipe Right
                      // TODO: Need to move this to i18n and add the translations later on.
                      Flexible(child: Text("Swipe Left")),
                      const SizedBox(width: 12),
                      Flexible(child: _buildSwipeActionDropdown(statusCodeString, SettingKey.leftSwipe, _swipeLeftActionDropdownKey))
                    ],
                  ),
                  onTap: () {
                    _swipeLeftActionDropdownKey!.currentState!.openDropdown();
                  },
                  // leading: ScaledAnimatedSwitcher(
                  //   keyToWatch: theme.icon(context).toString(),
                  //   child: Icon(theme.icon(context)),
                  // ),
                );
              },
            ),
            createListSeparator(context, t.settings.theme_and_colors),
            Builder(
              builder: (context) {
                final theme =
                    getThemeFromString(appStateSettings[SettingKey.themeMode]);

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(t.settings.theme)),
                      const SizedBox(width: 12),
                      Flexible(child: _buildThemeDropdown(theme))
                    ],
                  ),
                  onTap: () {
                    _themeDropdownKey!.currentState!.openDropdown();
                  },
                  leading: ScaledAnimatedSwitcher(
                    keyToWatch: theme.icon(context).toString(),
                    child: Icon(theme.icon(context)),
                  ),
                );
              },
            ),
            MonekinTileSwitch(
              title: t.settings.amoled_mode,
              subtitle: t.settings.amoled_mode_descr,
              initialValue: appStateSettings[SettingKey.amoledMode] == '1',
              disabled: isAppInLightBrightness(context),
              onSwitchDebounceMs: 200,
              onSwitch: (bool value) async {
                await UserSettingService.instance.setItem(
                  SettingKey.amoledMode,
                  value ? '1' : '0',
                  updateGlobalState: true,
                );
              },
            ),
            MonekinTileSwitch(
              title: t.settings.dynamic_colors,
              subtitle: t.settings.dynamic_colors_descr,
              initialValue: appStateSettings[SettingKey.accentColor] == 'auto',
              onSwitchDebounceMs: 200,
              onSwitch: (bool value) async {
                await UserSettingService.instance.setItem(
                  SettingKey.accentColor,
                  value ? 'auto' : brandBlue.toHex(),
                  updateGlobalState: true,
                );
              },
            ),
            StreamBuilder(
                stream: UserSettingService.instance
                    .getSettingFromDB(SettingKey.accentColor),
                initialData: 'auto',
                builder: (context, snapshot) {
                  late final Color color;

                  if (snapshot.data! == 'auto') {
                    color = Theme.of(context).colorScheme.primary;
                  } else {
                    color = ColorHex.get(snapshot.data!);
                  }

                  return ListTile(
                    onTap: snapshot.data! == 'auto'
                        ? null
                        : () => showColorPickerModal(
                              context,
                              ColorPickerModal(
                                colorOptions: [
                                  brandBlue.toHex(),
                                  ...defaultColorPickerOptions
                                ],
                                selectedColor: color.toHex(),
                                onColorSelected: (value) {
                                  Navigator.pop(context);

                                  setState(() {
                                    UserSettingService.instance.setItem(
                                      SettingKey.accentColor,
                                      value.toHex(),
                                      updateGlobalState: true,
                                    );
                                  });
                                },
                              ),
                            ),
                    title: Text(t.settings.accent_color),
                    subtitle: Text(t.settings.accent_color_descr),
                    enabled: snapshot.data! != 'auto',
                    trailing: SizedBox(
                      height: 46,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        clipBehavior: Clip.hardEdge,
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: color.withOpacity(
                            snapshot.data! != 'auto' ? 1 : 0.4,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  );
                }),
            createListSeparator(context, t.settings.security.title),
            MonekinTileSwitch(
              title: t.settings.security.private_mode_at_launch,
              subtitle: t.settings.security.private_mode_at_launch_descr,
              icon: const Icon(Icons.phonelink_lock_outlined),
              initialValue:
                  appStateSettings[SettingKey.privateModeAtLaunch] == '1',
              onSwitch: (bool value) async {
                await PrivateModeService.instance.setPrivateModeAtLaunch(value);
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
                      child: Icon(initialValue
                          ? Icons.lock_outline_rounded
                          : Icons.lock_open_rounded),
                    ),
                    initialValue: initialValue,
                    onSwitch: (bool value) {
                      setState(() {
                        PrivateModeService.instance.setPrivateMode(value);
                      });
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeDropdown(ThemeMode theme) {
    return Focus(
      canRequestFocus: false,
      descendantsAreFocusable: false,
      child: MonekinDropdownSelect(
          key: _themeDropdownKey,
          initial: theme,
          compact: true,
          expanded: false,
          items: const [
            ThemeMode.system,
            ThemeMode.light,
            ThemeMode.dark,
          ],
          getLabel: (x) => x.displayName(context),
          onChanged: (mode) {
            UserSettingService.instance
                .setItem(
                  SettingKey.themeMode,
                  mode.name,
                  updateGlobalState: true,
                )
                .then((value) => null);
          }),
    );
  }

  

  Widget _buildSwipeActionDropdown(String? statusCodeString, SettingKey direction, GlobalKey<MonekinDropdownSelectState<dynamic>>? swipeActionKey) {
  return Focus(
    canRequestFocus: false,
    descendantsAreFocusable: false,
    child: MonekinDropdownSelect<String>(
      key: swipeActionKey,
      // TODO: Need to see a better form of implementation, as for now it just checks if actions is set or not, if not it dafults to none.
      initial: statusCodeString ?? t.ui_actions.none,
      compact: true,
      expanded: false,
      items: [ 
        t.transaction.status.voided,
        t.transaction.status.pending,
        t.transaction.status.reconciled,
        t.transaction.status.unreconciled,
        t.ui_actions.none,
      ],
      onChanged: (actionString) {
        UserSettingService.instance
          .setItem(
            direction,
            actionString,
            updateGlobalState: true,
          )
          .then((value) => null);
        },
      ),
    );
  }
}

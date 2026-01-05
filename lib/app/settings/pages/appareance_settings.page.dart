import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/app/settings/widgets/monekin_tile_switch.dart';
import 'package:monekin/app/settings/widgets/settings_list_utils.dart';
import 'package:monekin/core/database/services/user-setting/enum/app-fonts.enum.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';
import 'package:monekin/core/database/services/user-setting/utils/get_theme_from_string.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/presentation/animations/scaled_animated_switcher.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/theme.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker.dart';
import 'package:monekin/core/presentation/widgets/color_picker/color_picker_modal.dart';
import 'package:monekin/core/presentation/widgets/dynamic_selector_modal.dart';
import 'package:monekin/core/presentation/widgets/monekin_dropdown_select.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

final GlobalKey<MonekinDropdownSelectState> _themeDropdownKey = GlobalKey();

class AppareanceSettingsPage extends StatelessWidget {
  const AppareanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PageFramework(
      title: t.settings.appearance.menu_title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16).withSafeBottom(context),
        child: ListTileTheme(
          data: getSettingListTileStyle(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createListSeparator(
                context,
                t.settings.appearance.theme_and_colors,
              ),
              Builder(
                builder: (context) {
                  final theme = getThemeFromString(
                    appStateSettings[SettingKey.themeMode],
                  );

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(t.settings.appearance.theme.title),
                        ),
                        const SizedBox(width: 12),
                        Flexible(child: _buildThemeDropdown(context, theme)),
                      ],
                    ),
                    onTap: () {
                      _themeDropdownKey.currentState!.openDropdown();
                    },
                    leading: ScaledAnimatedSwitcher(
                      keyToWatch: theme.icon(context).toString(),
                      child: Icon(theme.icon(context)),
                    ),
                  );
                },
              ),
              MonekinTileSwitch(
                title: t.settings.appearance.amoled_mode,
                subtitle: t.settings.appearance.amoled_mode_descr,
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
                title: t.settings.appearance.dynamic_colors,
                subtitle: t.settings.appearance.dynamic_colors_descr,
                initialValue:
                    appStateSettings[SettingKey.accentColor] == 'auto',
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
                stream: UserSettingService.instance.getSettingFromDB(
                  SettingKey.accentColor,
                ),
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
                                ...defaultColorPickerOptions,
                              ],
                              selectedColor: color.toHex(),
                              onColorSelected: (value) {
                                RouteUtils.popRoute();

                                UserSettingService.instance.setItem(
                                  SettingKey.accentColor,
                                  value.toHex(),
                                  updateGlobalState: true,
                                );
                              },
                            ),
                          ),
                    title: Text(t.settings.appearance.accent_color),
                    subtitle: Text(t.settings.appearance.accent_color_descr),
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
                },
              ),
              createListSeparator(context, t.settings.appearance.text),

              Builder(
                builder: (context) {
                  final font = AppFonts.fromDB(
                    appStateSettings[SettingKey.font],
                  );

                  return ListTile(
                    leading: Icon(Icons.font_download_rounded),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 12,
                      children: [
                        Flexible(child: Text(t.settings.appearance.font)),
                        Flexible(
                          child: SelectorContainer(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Text(
                              font?.fontFamilyName ??
                                  t.settings.appearance.font_platform,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      showDynamicSelectorBottomSheet(
                        context,
                        selectorWidget: DynamicSelectorModal(
                          items: const [null, ...AppFonts.values],
                          selectedValue: font,
                          displayNameGetter: (action) =>
                              action?.fontFamilyName ??
                              t.settings.appearance.font_platform,
                          elementTitleBuilder: (title, item) => Text(
                            title,
                            style: TextStyle(fontFamily: item?.fontFamilyName),
                          ),
                          valueGetter: (action) => action,
                          title: t.settings.appearance.font,
                        ),
                      ).then((modalResult) async {
                        if (modalResult == null) return;

                        await UserSettingService.instance.setItem(
                          SettingKey.font,
                          modalResult.result?.toDB(),
                          updateGlobalState: true,
                        );
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

  Widget _buildThemeDropdown(BuildContext context, ThemeMode theme) {
    return Focus(
      canRequestFocus: false,
      descendantsAreFocusable: false,
      child: MonekinDropdownSelect(
        key: _themeDropdownKey,
        initial: theme,
        compact: true,
        expanded: false,
        items: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
        getLabel: (x) => x.displayName(context),
        onChanged: (mode) {
          UserSettingService.instance
              .setItem(SettingKey.themeMode, mode.name, updateGlobalState: true)
              .then((value) => null);
        },
      ),
    );
  }
}

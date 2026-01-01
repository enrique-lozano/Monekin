import 'package:flutter/material.dart';
import 'package:monekin/app/layout/page_framework.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/presentation/app_colors.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final customColors = AppColors.of(context);

    const sectionStyle = TextStyle(fontWeight: FontWeight.bold);

    final colorSchemePairs = <(String, Color, String, Color)>[
      ('primary', themeColors.primary, 'onPrimary', themeColors.onPrimary),
      (
        'primaryContainer',
        themeColors.primaryContainer,
        'onPrimaryContainer',
        themeColors.onPrimaryContainer,
      ),
      (
        'primaryFixed',
        themeColors.primaryFixed,
        'onPrimaryFixed',
        themeColors.onPrimaryFixed,
      ),
      (
        'secondary',
        themeColors.secondary,
        'onSecondary',
        themeColors.onSecondary,
      ),
      (
        'secondaryContainer',
        themeColors.secondaryContainer,
        'onSecondaryContainer',
        themeColors.onSecondaryContainer,
      ),
      ('tertiary', themeColors.tertiary, 'onTertiary', themeColors.onTertiary),
      (
        'tertiaryContainer',
        themeColors.tertiaryContainer,
        'onTertiaryContainer',
        themeColors.onTertiaryContainer,
      ),
      ('error', themeColors.error, 'onError', themeColors.onError),
      (
        'errorContainer',
        themeColors.errorContainer,
        'onErrorContainer',
        themeColors.onErrorContainer,
      ),
      ('surface', themeColors.surface, 'onSurface', themeColors.onSurface),
      (
        'inverseSurface',
        themeColors.inverseSurface,
        'onInverseSurface',
        themeColors.onInverseSurface,
      ),
    ];

    return PageFramework(
      title: 'Debug Page',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Flutter color scheme:', style: sectionStyle),
            const SizedBox(height: 4),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: colorSchemePairs.map((pair) {
                final (bgName, bgColor, fgName, fgColor) = pair;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      _ColorPreviewTile(
                        label: bgName,
                        backgroundColor: bgColor,
                        showHex: true,
                      ),
                      const SizedBox(width: 8),
                      _ColorPreviewTile(
                        label: fgName,
                        backgroundColor: fgColor,
                        showHex: true,
                      ),
                      const SizedBox(width: 8),
                      _ColorPreviewTile(
                        label: 'Combi Test',
                        backgroundColor: bgColor,
                        foregroundColor: fgColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Column(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    _ColorPreviewTile(
                      label: 'surfaceContainer',
                      backgroundColor: themeColors.surfaceContainer,
                      showHex: true,
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    _ColorPreviewTile(
                      label: 'surfaceContainerLowest',
                      backgroundColor: themeColors.surfaceContainerLowest,
                      showHex: true,
                    ),
                    _ColorPreviewTile(
                      label: 'surfaceContainerLow',
                      backgroundColor: themeColors.surfaceContainerLow,
                      showHex: true,
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    _ColorPreviewTile(
                      label: 'surfaceContainerHighest',
                      backgroundColor: themeColors.surfaceContainerHighest,
                      showHex: true,
                    ),
                    _ColorPreviewTile(
                      label: 'surfaceContainerHigh',
                      backgroundColor: themeColors.surfaceContainerHigh,
                      showHex: true,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('App custom colors:', style: sectionStyle),
            const SizedBox(height: 4),
            Column(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    _ColorPreviewTile(
                      label: 'textHint',
                      backgroundColor: customColors.textHint,
                      showHex: true,
                    ),
                    _ColorPreviewTile(
                      label: 'textBody',
                      backgroundColor: customColors.textBody,
                      showHex: true,
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    _ColorPreviewTile(
                      label: 'success',
                      backgroundColor: customColors.success,
                      showHex: true,
                    ),
                    _ColorPreviewTile(
                      label: 'danger',
                      backgroundColor: customColors.danger,
                      showHex: true,
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    _ColorPreviewTile(
                      label: 'link',
                      backgroundColor: customColors.link,
                      showHex: true,
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    _ColorPreviewTile(
                      label: 'brand',
                      backgroundColor: customColors.brand,
                      showHex: true,
                    ),
                  ],
                ),
              ],
            ),
            // Add this below the existing sections in your build method
            const SizedBox(height: 24),
            const Text('Text styles:', style: sectionStyle),
            const SizedBox(height: 12),
            const _ThemeTextStylesPreview(),
          ],
        ),
      ),
    );
  }
}

class _ThemeTextStylesPreview extends StatelessWidget {
  const _ThemeTextStylesPreview();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final textStyles = <(String, TextStyle?)>[
      ('displayLarge', textTheme.displayLarge),
      ('displayMedium', textTheme.displayMedium),
      ('displaySmall', textTheme.displaySmall),
      ('headlineLarge', textTheme.headlineLarge),
      ('headlineMedium', textTheme.headlineMedium),
      ('headlineSmall', textTheme.headlineSmall),
      ('titleLarge', textTheme.titleLarge),
      ('titleMedium', textTheme.titleMedium),
      ('titleSmall', textTheme.titleSmall),
      ('bodyLarge', textTheme.bodyLarge),
      ('bodyMedium', textTheme.bodyMedium),
      ('bodySmall', textTheme.bodySmall),
      ('labelLarge', textTheme.labelLarge),
      ('labelMedium', textTheme.labelMedium),
      ('labelSmall', textTheme.labelSmall),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textStyles.map((style) {
        final (label, textStyle) = style;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label, style: textStyle),
        );
      }).toList(),
    );
  }
}

class _ColorPreviewTile extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool showHex;

  const _ColorPreviewTile({
    required this.label,
    required this.backgroundColor,
    this.foregroundColor,
    this.showHex = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveFg =
        foregroundColor ??
        (ThemeData.estimateBrightnessForColor(backgroundColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black);

    return Expanded(
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
          border: foregroundColor != null
              ? Border.all(color: foregroundColor!.withOpacity(0.2))
              : null,
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(color: effectiveFg, fontWeight: FontWeight.bold),
            ),
            if (showHex)
              SelectableText(
                backgroundColor.toHex(leadingHashSign: true),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: effectiveFg),
              ),
          ],
        ),
      ),
    );
  }
}

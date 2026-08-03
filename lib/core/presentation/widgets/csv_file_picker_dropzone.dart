import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A dashed "drop zone"-styled button used to prompt the user to pick a
/// file. Tapping it triggers [onTap] (typically a file picker call).
///
/// There is no OS-level drag & drop support in the app, so this only
/// supports tap-to-pick; the dashed style is kept purely for the familiar
/// "drop a file here" affordance.
class CsvFilePickerDropzone extends StatelessWidget {
  const CsvFilePickerDropzone({super.key, required this.onTap, this.label});

  final VoidCallback onTap;

  /// Defaults to the generic "Tap to select a file" translation.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 3,
          strokeCap: StrokeCap.round,
          dashPattern: const [6, 8],
          radius: const Radius.circular(12),
        ),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 68),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 48,
                  weight: 10,
                  color: Colors.grey.withOpacity(0.95),
                ),
                const SizedBox(height: 4),
                Text(
                  label ?? t.backup.import.tap_to_select_file,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:file_picker/file_picker.dart' show FileType;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/backup/backup_database_service.dart';
import 'package:monekin/core/database/services/account/security_service.dart';
import 'package:monekin/core/presentation/helpers/snackbar.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/csv_file_picker_dropzone.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/list_tile_action_item.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A parsed price row (date + price), already validated.
typedef PricePointCsvRow = ({DateTime date, double price});

/// Parses a pasted/imported CSV of price observations into a list of
/// `(date, price)` rows. Fully offline (no network calls).
///
/// One observation per line. The delimiter is auto-detected (tab, then `;`,
/// then `,`), so European files using `;` can keep `,` as the decimal mark.
/// Dates accept ISO-8601 plus a few common formats; invalid or header rows are
/// silently skipped. The result is sorted by date (oldest first).
List<PricePointCsvRow> parseSecurityPriceCsv(String raw) {
  final result = <PricePointCsvRow>[];

  for (final rawLine in const LineSplitter().convert(raw)) {
    final line = rawLine.trim();
    if (line.isEmpty) continue;

    final delimiter = line.contains('\t')
        ? '\t'
        : line.contains(';')
        ? ';'
        : ',';

    final parts = line.split(delimiter).map((e) => e.trim()).toList();
    if (parts.length < 2) continue;

    final date = _tryParseDate(parts[0]);
    final price = _tryParseNumber(parts[1]);
    if (date == null || price == null) continue;

    result.add((date: date, price: price));
  }

  result.sort((a, b) => a.date.compareTo(b.date));
  return result;
}

DateTime? _tryParseDate(String value) {
  final iso = DateTime.tryParse(value);
  if (iso != null) return iso;

  const formats = ['dd/MM/yyyy', 'MM/dd/yyyy', 'yyyy/MM/dd', 'dd-MM-yyyy'];
  for (final format in formats) {
    try {
      return DateFormat(format).parseStrict(value);
    } catch (_) {
      // Try the next format.
    }
  }

  return null;
}

double? _tryParseNumber(String value) {
  final direct = double.tryParse(value);
  if (direct != null) return direct;

  final cleaned = value.replaceAll(' ', '').replaceAll(',', '.');
  return double.tryParse(cleaned);
}

DateTime _dayOnly(DateTime date) => DateTime(date.year, date.month, date.day);

/// Bottom sheet that lets the user import price history for a security from
/// a CSV file (or pasted text), without any network access. A 2-step flow:
/// pick the data, then review it (and any dates that will be overwritten)
/// before confirming.
Future<void> showSecurityPriceImportSheet(
  BuildContext context, {
  required String securityId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _SecurityPriceImportSheet(securityId: securityId),
  );
}

class _SecurityPriceImportSheet extends StatefulWidget {
  const _SecurityPriceImportSheet({required this.securityId});

  final String securityId;

  @override
  State<_SecurityPriceImportSheet> createState() =>
      _SecurityPriceImportSheetState();
}

class _SecurityPriceImportSheetState extends State<_SecurityPriceImportSheet> {
  final _controller = TextEditingController();
  List<PricePointCsvRow> _parsed = const [];

  bool _reviewing = false;

  /// Calendar dates (from the parsed rows) that already have a price
  /// recorded for this security, and will therefore be overwritten.
  Set<DateTime> _datesToOverwrite = const {};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() => _parsed = parseSecurityPriceCsv(value));
  }

  Future<void> _pickFile() async {
    try {
      final file = await BackupDatabaseService().pickAndReadSingleFile(
        type: FileType.custom,
        allowedExtensions: ['csv', 'txt'],
      );
      if (file == null || !mounted) return;

      _controller.text = await file.readAsString();
      _onChanged(_controller.text);
    } catch (err) {
      MonekinSnackbar.error(SnackbarParams.fromError(err));
    }
  }

  Future<void> _goToReview() async {
    if (_parsed.isEmpty) return;

    final overwritten = await SecurityService.instance
        .getDatesWithExistingPrice(
          widget.securityId,
          _parsed.map((p) => p.date),
        );

    if (!mounted) return;
    setState(() {
      _datesToOverwrite = overwritten;
      _reviewing = true;
    });
  }

  Future<void> _import() async {
    final t = Translations.of(context);
    if (_parsed.isEmpty) return;

    final count = await SecurityService.instance.importPricePoints(
      widget.securityId,
      _parsed,
    );

    RouteUtils.popRoute();
    MonekinSnackbar.success(
      SnackbarParams(t.assets.securities.import.success(n: count.toString())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: t.assets.securities.import.title,
      subtitle: _reviewing
          ? t.assets.securities.import.review_description
          : t.assets.securities.import.description,
      bodyPadding: const EdgeInsets.symmetric(horizontal: 16),
      footer: _reviewing
          ? BottomSheetFooter(
              submitText: t.assets.securities.import.button,
              submitIcon: Icons.file_upload_outlined,
              extraActions: [
                ListTileActionItem(
                  icon: Icons.arrow_back,
                  label: t.ui_actions.back,
                  onClick: () => setState(() => _reviewing = false),
                ),
              ],
              onSaved: _import,
            )
          : BottomSheetFooter(
              submitText: t.ui_actions.continue_text,
              submitIcon: Icons.arrow_forward,
              onSaved: _parsed.isEmpty ? null : _goToReview,
            ),
      body: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        child: _reviewing ? _buildReviewStep(t) : _buildSelectStep(t),
      ),
    );
  }

  Widget _buildSelectStep(Translations t) {
    return Column(
      key: const ValueKey('select'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CsvFilePickerDropzone(onTap: _pickFile),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(t.general.or),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          onChanged: _onChanged,
          minLines: 5,
          maxLines: 10,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: '2026-01-01, 100.5\n2026-02-01, 102.3',
            labelText: t.assets.securities.import.field_label,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          t.assets.securities.import.rows_detected(
            n: _parsed.length.toString(),
          ),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildReviewStep(Translations t) {
    final overwriteCount = _datesToOverwrite.length;

    return Column(
      key: const ValueKey('review'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (overwriteCount > 0) ...[
          InlineInfoCard(
            mode: InlineInfoCardMode.warn,
            text: t.assets.securities.import.overwrite_warning(
              n: overwriteCount.toString(),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          t.assets.securities.import.rows_detected(
            n: _parsed.length.toString(),
          ),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 260),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _parsed.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final point = _parsed[index];
              final willOverwrite = _datesToOverwrite.contains(
                _dayOnly(point.date),
              );

              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: willOverwrite
                    ? Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.amber.shade700,
                        size: 20,
                      )
                    : const SizedBox(width: 20),
                title: Text(DateFormat.yMMMd().format(point.date)),
                trailing: Text(point.price.toString()),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

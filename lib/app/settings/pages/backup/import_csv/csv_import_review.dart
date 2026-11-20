import 'package:material_ui/material_ui.dart';
import 'package:monekin/app/transactions/list/widgets/transaction_list_tile.dart';
import 'package:monekin/core/database/backup/csv_import_service.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/styles/borders.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/services/csv_import/csv_transaction_parser.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Last step of the CSV import: tells the user what is going to happen
/// before anything is written in the database.
class CsvImportReview extends StatefulWidget {
  const CsvImportReview({
    super.key,
    required this.result,
    required this.defaults,
  });

  final CsvParseResult result;
  final CsvImportDefaults defaults;

  @override
  State<CsvImportReview> createState() => _CsvImportReviewState();
}

class _CsvImportReviewState extends State<CsvImportReview> {
  /// Only the first transactions are built, however big the file is
  late final Future<CsvImportPreview> _preview = CsvImportService.instance
      .getPreview(widget.result.transactions, widget.defaults);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;
    final result = widget.result;

    if (result.transactions.isEmpty) {
      return NoResults(
        description: t.no_transactions_found,
        icon: Icons.search_off_rounded,
      );
    }

    final skipped = result.skippedRows.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.review_title(n: result.transactions.length),
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (final type in [
              TransactionType.income,
              TransactionType.expense,
              TransactionType.transfer,
            ])
              Expanded(
                child: _TypeStat(type: type, count: result.countOf(type)),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (skipped > 0) ...[
          InlineInfoCard(
            text: t.skipped_rows(n: skipped),
            mode: InlineInfoCardMode.warn,
          ),
          const SizedBox(height: 8),
        ],
        if (result.unpairedTransfers > 0) ...[
          InlineInfoCard(
            text: t.unpaired_transfers(n: result.unpairedTransfers),
            mode: InlineInfoCardMode.warn,
          ),
          const SizedBox(height: 8),
        ],
        FutureBuilder(
          future: _preview,
          builder: (context, snapshot) {
            final preview = snapshot.data;

            if (preview == null) {
              return const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (preview.newAccountNames.isNotEmpty) ...[
                  InlineInfoCard(
                    text: t.accounts_to_create(
                      accounts: preview.newAccountNames.join(', '),
                    ),
                    mode: InlineInfoCardMode.info,
                  ),
                  const SizedBox(height: 8),
                ],
                if (preview.discardedTransfers > 0) ...[
                  InlineInfoCard(
                    text: t.discarded_transfers(n: preview.discardedTransfers),
                    mode: InlineInfoCardMode.warn,
                  ),
                  const SizedBox(height: 8),
                ],
                const SizedBox(height: 4),
                Text(
                  t.preview,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: cardSurfaceDecoration(context),
                  child: Column(
                    children: [
                      for (final tr in preview.sample)
                        TransactionListTile(
                          transaction: tr,
                          heroTag: null,
                          preventDefaultOnTap: true,
                          onLongPress: () {},
                        ),
                    ],
                  ),
                ),
                if (preview.total > preview.sample.length)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      t.preview_more(n: preview.total - preview.sample.length),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _TypeStat extends StatelessWidget {
  const _TypeStat({required this.type, required this.count});

  final TransactionType type;
  final int count;

  @override
  Widget build(BuildContext context) {
    final color = type.color(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(type.icon, color: color),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            type.displayName(context, plural: true),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

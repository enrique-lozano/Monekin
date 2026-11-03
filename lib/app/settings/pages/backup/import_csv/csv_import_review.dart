import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/backup/csv_import_service.dart';
import 'package:monekin/core/models/transaction/transaction_type.enum.dart';
import 'package:monekin/core/presentation/widgets/card_with_header.dart';
import 'package:monekin/core/presentation/widgets/inline_info_card.dart';
import 'package:monekin/core/presentation/widgets/no_results.dart';
import 'package:monekin/core/services/csv_import/csv_transaction_parser.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

const _transactionsToPreview = 5;

/// Last step of the CSV import: tells the user what is going to happen
/// before anything is written in the database.
class CsvImportReview extends StatelessWidget {
  const CsvImportReview({
    super.key,
    required this.result,
    required this.defaults,
  });

  final CsvParseResult result;
  final CsvImportDefaults defaults;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).backup.import.manual_import;

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
          future: CsvImportService.instance.getAccountsToCreate(
            result.transactions,
            defaults,
          ),
          builder: (context, snapshot) {
            final names = snapshot.data;

            if (names == null || names.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InlineInfoCard(
                text: t.accounts_to_create(accounts: names.join(', ')),
                mode: InlineInfoCardMode.info,
              ),
            );
          },
        ),
        const SizedBox(height: 4),
        CardWithHeader(
          title: t.preview,
          body: Column(
            children: [
              for (final tr in result.transactions.take(_transactionsToPreview))
                _PreviewTile(transaction: tr),
            ],
          ),
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
        color: color.withOpacity(0.12),
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

class _PreviewTile extends StatelessWidget {
  const _PreviewTile({required this.transaction});

  final ParsedCsvTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final tr = transaction;
    final color = tr.type.color(context);

    final title = tr.title ?? tr.categoryName ?? tr.type.displayName(context);

    final subtitle = [
      DateFormat.yMMMd().format(tr.date),
      if (tr.type.isTransfer)
        '${tr.accountName ?? ''} → ${tr.receivingAccountName ?? ''}'
      else if (tr.accountName != null)
        tr.accountName,
    ].join(' · ');

    final sign = switch (tr.type) {
      TransactionType.expense => '-',
      TransactionType.income => '+',
      _ => '',
    };

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.12),
        child: Icon(tr.type.icon, color: color, size: 20),
      ),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(
        '$sign${NumberFormat.decimalPatternDigits(decimalDigits: 2).format(tr.amount)}',
        style: Theme.of(context).textTheme.titleSmall
            ?.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

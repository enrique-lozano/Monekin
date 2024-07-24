import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/app_colors.dart';

class LabelValueInfoItem {
  final Widget value;
  final String label;

  const LabelValueInfoItem({
    required this.value,
    required this.label,
  });
}

class LabelValueInfoTable extends StatelessWidget {
  const LabelValueInfoTable({super.key, required this.items});

  final List<LabelValueInfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(borderRadius: BorderRadius.circular(0)),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(7),
      },
      children: items
          .mapIndexed(
            (i, e) => TableRow(
              decoration: BoxDecoration(
                color: i % 2 == 0
                    ? AppColors.of(context).background
                    : AppColors.of(context).light.withOpacity(0.025),
              ),
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Text(
                      e.label,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: e.value,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

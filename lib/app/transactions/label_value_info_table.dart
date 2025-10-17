import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class LabelValueInfoItem {
  final Widget value;
  final String label;

  const LabelValueInfoItem({required this.value, required this.label});
}

class LabelValueInfoTable extends StatelessWidget {
  const LabelValueInfoTable({super.key, required this.items});

  final List<LabelValueInfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Table(
        border: TableBorder(
          borderRadius: BorderRadius.circular(0),
          horizontalInside: BorderSide(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {0: FlexColumnWidth(3), 1: FlexColumnWidth(7)},
        children: items
            .mapIndexed(
              (i, e) => TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 4,
                      ),
                      child: Text(
                        e.label,
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  TableCell(
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.labelLarge!,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 4,
                        ),
                        child: e.value,
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

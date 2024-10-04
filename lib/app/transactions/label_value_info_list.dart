import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/label_value_info_table.dart';

class LabelValueInfoListItem extends LabelValueInfoItem {
  final Widget? trailing;

  LabelValueInfoListItem({
    required super.value,
    required super.label,
    this.trailing,
  });
}

class LabelValueInfoList extends StatelessWidget {
  const LabelValueInfoList({super.key, required this.items});

  final List<LabelValueInfoListItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const Divider(
          //  color: Colors.grey, // Customize the color of the separator
          thickness: 1, // Customize the thickness of the separator
          indent: 16,
          endIndent: 16,
        );
      },
      itemBuilder: (context, index) {
        final element = items[index];
        return ListTile(
          minVerticalPadding: 0,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(element.label),
          subtitle: element.value,
          trailing: element.trailing,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';

class DynamicSelectorModal<T, V> extends StatelessWidget {
  const DynamicSelectorModal({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.displayNameGetter,
    required this.valueGetter,
    required this.title,
    this.subtitle,
    this.headerWidget,
  });

  final List<T> items;
  final V selectedValue;
  final String Function(T) displayNameGetter;
  final V Function(T) valueGetter;
  final String title;
  final String? subtitle;
  final Widget? headerWidget;

  Widget _radioTile(BuildContext context, T item) {
    final value = valueGetter(item);
    final displayName = displayNameGetter(item);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: RadioListTile<V>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        selectedTileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        selected: value == selectedValue,
        value: value,
        title: Text(displayName),
        groupValue: selectedValue,
        onChanged: (V? newValue) {
          if (newValue == null) return;

          Navigator.of(context).pop(newValue);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalContainer(
      title: title,
      subtitle: subtitle,
      responseToKeyboard: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (headerWidget != null) headerWidget!,
            ...items.map((item) => _radioTile(context, item)),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}

Future<V?> showDynamicSelectorBottomSheet<T, V>(BuildContext context,
    {required DynamicSelectorModal<T, V> selectorWidget}) {
  return showModalBottomSheet<V>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return selectorWidget;
    },
  );
}

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';

class DynamicSelectorModal<T, V> extends StatelessWidget {
  const DynamicSelectorModal({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.displayNameGetter,
    required this.valueGetter,
    this.subtitle,
    this.headerWidget,
    this.trailingIconGetter,
  });

  final List<T> items;
  final V selectedValue;
  final String Function(T) displayNameGetter;
  final IconData? Function(T)? trailingIconGetter;
  final V Function(T) valueGetter;
  final String title;
  final String? subtitle;
  final Widget? headerWidget;

  Widget _radioTile(BuildContext context, T item) {
    final value = valueGetter(item);
    final displayName = displayNameGetter(item);
    final icon = trailingIconGetter != null ? trailingIconGetter!(item) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: RadioListTile<V>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        selectedTileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        selected: value == selectedValue,
        secondary: icon == null
            ? null
            : Icon(
                icon,
                color: Colors.grey.shade600,
              ),
        value: value,
        title: Text(displayName),
        groupValue: selectedValue,
        onChanged: (V? newValue) {
          Navigator.of(context).pop(ModalResult(newValue));
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

Future<ModalResult<V>?> showDynamicSelectorBottomSheet<T, V>(
  BuildContext context, {
  required DynamicSelectorModal<T, V> selectorWidget,
}) {
  return showModalBottomSheet<ModalResult<V>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return selectorWidget;
    },
  );
}

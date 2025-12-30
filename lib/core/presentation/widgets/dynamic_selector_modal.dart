import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/widgets/bottomSheetFooter.dart';
import 'package:monekin/core/presentation/widgets/modal_container.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// A dynamic selector modal that displays a list of selectable items with radio buttons.
///
/// This widget provides a generic interface for selecting from a list of items of type [T],
/// where each item has an associated value of type [V]. The modal displays as a bottom sheet
/// with radio button selection.
///
/// Type parameters:
/// * [T] - The type of items in the selection list
/// * [V] - The type of values associated with each item (used for selection state)
class DynamicSelectorModal<T, V> extends StatelessWidget {
  /// Creates a dynamic selector modal.
  ///
  /// All required parameters must be provided to ensure proper functionality.
  const DynamicSelectorModal({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.displayNameGetter,
    required this.valueGetter,
    this.subtitle,
    this.elementTitleBuilder,
    this.headerWidget,
    this.trailingIconGetter,
  });

  /// The list of items to display in the selector.
  ///
  /// Each item of type [T] will be rendered as a radio list tile.
  /// The list can be empty, in which case no options will be shown.
  final List<T> items;

  /// The currently selected value of type [V].
  ///
  /// This value is compared against the result of [valueGetter] for each item
  /// to determine which radio button should be marked as selected.
  final V selectedValue;

  /// A function that extracts the display text from each item.
  ///
  /// Takes an item of type [T] and returns a [String] that will be used
  /// as the display text for that item in the list. This text will be
  /// passed to [elementTitleBuilder] if provided, or displayed directly.
  final String Function(T) displayNameGetter;

  /// Optional builder function for customizing the title of each element in the list.
  ///
  /// If provided, this function receives the display name (from [displayNameGetter])
  /// and should return a [Widget] to display as the title. If null, a simple
  /// [Text] widget with the display name will be used.
  final Widget Function(String title, T item)? elementTitleBuilder;

  /// Optional function that provides trailing icons for each item.
  ///
  /// Takes an item of type [T] and returns an optional [IconData].
  /// If the function returns null for an item, no trailing icon will be shown.
  /// If this function itself is null, no trailing icons will be shown for any items.
  final IconData? Function(T)? trailingIconGetter;

  /// A function that extracts the value from each item for selection comparison.
  ///
  /// Takes an item of type [T] and returns a value of type [V] that will be
  /// compared against [selectedValue] to determine selection state and will be
  /// returned when the item is selected.
  final V Function(T) valueGetter;

  /// The title text displayed at the top of the modal.
  ///
  /// This appears in the modal header and describes what the user is selecting.
  final String title;

  /// Optional subtitle text displayed below the title.
  ///
  /// Provides additional context or instructions for the selection.
  /// If null, no subtitle will be shown.
  final String? subtitle;

  /// Optional widget displayed at the top of the item list.
  ///
  /// This appears after the title/subtitle but before the selectable items.
  /// Can be used for additional instructions, filters, or other UI elements.
  final Widget? headerWidget;

  Widget _radioTile(BuildContext context, T item) {
    final value = valueGetter(item);
    final displayName = displayNameGetter(item);
    final icon = trailingIconGetter != null ? trailingIconGetter!(item) : null;

    Widget titleWidget = elementTitleBuilder != null
        ? elementTitleBuilder!(displayName, item)
        : Text(displayName);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: RadioListTile<V>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        selectedTileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        selected: value == selectedValue,
        secondary: icon == null
            ? null
            : Icon(icon, color: Colors.grey.shade600),
        value: value,
        title: titleWidget,
        groupValue: selectedValue,
        onChanged: (V? newValue) {
          RouteUtils.popRoute(ModalResult(newValue));
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
            const SizedBox(height: 12),
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

class DynamicMultiSelectorModal<T, V> extends StatefulWidget {
  const DynamicMultiSelectorModal({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValues,
    required this.displayNameGetter,
    required this.valueGetter,
    this.subtitle,
    this.elementTitleBuilder,
    this.headerWidget,
    this.trailingIconGetter,
  });

  final List<T> items;
  final List<V> selectedValues;
  final String Function(T) displayNameGetter;
  final Widget Function(String title, T item)? elementTitleBuilder;
  final IconData? Function(T)? trailingIconGetter;
  final V Function(T) valueGetter;
  final String title;
  final String? subtitle;
  final Widget? headerWidget;

  @override
  State<DynamicMultiSelectorModal<T, V>> createState() =>
      _DynamicMultiSelectorModalState<T, V>();
}

class _DynamicMultiSelectorModalState<T, V>
    extends State<DynamicMultiSelectorModal<T, V>> {
  late List<V> _currentSelectedValues;

  @override
  void initState() {
    super.initState();
    _currentSelectedValues = List.from(widget.selectedValues);
  }

  Widget _checkboxTile(BuildContext context, T item) {
    final value = widget.valueGetter(item);
    final displayName = widget.displayNameGetter(item);
    final icon = widget.trailingIconGetter != null
        ? widget.trailingIconGetter!(item)
        : null;

    Widget titleWidget = widget.elementTitleBuilder != null
        ? widget.elementTitleBuilder!(displayName, item)
        : Text(displayName);

    final isSelected = _currentSelectedValues.contains(value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CheckboxListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        selectedTileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        selected: isSelected,
        secondary: icon == null
            ? null
            : Icon(icon, color: Colors.grey.shade600),
        value: isSelected,
        title: titleWidget,
        onChanged: (bool? checked) {
          setState(() {
            if (checked == true) {
              _currentSelectedValues.add(value);
            } else {
              _currentSelectedValues.remove(value);
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ModalContainer(
      title: widget.title,
      subtitle: widget.subtitle,
      responseToKeyboard: false,
      footer: BottomSheetFooter(
        submitText: t.ui_actions.continue_text,
        submitIcon: Icons.check_rounded,
        onSaved: () {
          RouteUtils.popRoute(ModalResult(_currentSelectedValues));
        },
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.headerWidget != null) widget.headerWidget!,
            ...widget.items.map((item) => _checkboxTile(context, item)),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

Future<ModalResult<List<V>>?> showDynamicMultiSelectorBottomSheet<T, V>(
  BuildContext context, {
  required DynamicMultiSelectorModal<T, V> selectorWidget,
}) {
  return showModalBottomSheet<ModalResult<List<V>>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return selectorWidget;
    },
  );
}

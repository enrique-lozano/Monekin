import 'package:flutter/material.dart';

class MonekinDropdownSelect<T> extends StatefulWidget {
  const MonekinDropdownSelect({
    super.key,
    required this.initial,
    required this.items,
    required this.onChanged,
    this.backgroundColor,
    this.compact = false,
    this.checkInitialValue = false,
    this.getLabel,
    this.isDisabled,
    this.enabled = true,
    this.expanded = false,
    this.textConstraints = const BoxConstraints(),
  });

  final T initial;
  final List<T> items;
  final void Function(T) onChanged;
  final Color? backgroundColor;
  final bool compact;
  final bool enabled;
  final bool expanded;
  final bool checkInitialValue;
  final String Function(T)? getLabel;
  final bool Function(T)? isDisabled;
  final BoxConstraints textConstraints;

  @override
  State<MonekinDropdownSelect> createState() => MonekinDropdownSelectState<T>();
}

/// State of the `MonekinDropdownSelect` component. Use it for creating a key and open the dropdown programatically:
///
///
///```
///     late GlobalKey<MonekinDropdownSelectState>? _dropdownKey = GlobalKey();
///     _dropdownKey!.currentState!.openDropdown();
///```
class MonekinDropdownSelectState<T> extends State<MonekinDropdownSelect<T>> {
  T? currentValue;

  late final GlobalKey _dropdownButtonKey = GlobalKey();

  void openDropdown() {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext? element) {
      element?.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector?;
        } else {
          searchForGestureDetector(element);
        }
      });
    }

    searchForGestureDetector(_dropdownButtonKey.currentContext);
    assert(detector != null);

    detector?.onTap?.call();
  }

  @override
  void initState() {
    super.initState();

    if (widget.checkInitialValue == true &&
        !widget.items.contains(widget.initial)) {
      currentValue =
          widget.items.where((item) => !_isItemDisabled(item)).firstOrNull ??
              widget.initial;
    } else {
      currentValue = widget.initial;
    }
  }

  bool _isItemDisabled(T item) {
    return widget.isDisabled == null ? false : widget.isDisabled!(item);
  }

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          openDropdown();
        }
        
        child: SelectorContainer(
      backgroundColor: widget.backgroundColor,
      padding: EdgeInsetsDirectional.only(
          start: widget.compact ? 13 : 15,
          end: widget.compact ? 1 : 6,
          top: widget.compact ? 2 : 10,
          bottom: widget.compact ? 2 : 10),
      enabled: widget.enabled,
      child: DropdownButton<T>(
        key: _dropdownButtonKey,
        underline: Container(),
        dropdownColor: widget.backgroundColor ??
            Theme.of(context).colorScheme.surfaceContainerHigh,
        isDense: true,
        isExpanded: widget.expanded,
        value: currentValue ?? widget.initial,
        elevation: 15,
        iconSize: 32,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.arrow_drop_down_rounded),
        onChanged: !widget.enabled
            ? null
            : (T? value) {
                widget.onChanged(value ?? widget.items[0]);
                setState(() {
                  currentValue = value;
                });
              },
        selectedItemBuilder: (context) {
          return widget.items.toSet().toList().map((value) {
            return ConstrainedBox(
              constraints: widget.textConstraints,
              child: Text(
                widget.getLabel != null
                    ? widget.getLabel!(value)
                    : value.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(
                      _isItemDisabled(value) || !widget.enabled ? 0.3 : 1),
                ),
              ),
            );
          }).toList();
        },
        items: widget.items.toSet().toList().map<DropdownMenuItem<T>>((value) {
          final isSelected = value == currentValue;

          return DropdownMenuItem(
            alignment: AlignmentDirectional.centerStart,
            enabled: !_isItemDisabled(value),
            value: value,
            child: ConstrainedBox(
              constraints: widget.textConstraints,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 12,
                children: [
                  Text(
                    widget.getLabel != null
                        ? widget.getLabel!(value)
                        : value.toString(),
                    style: TextStyle(
                      color: (Theme.of(context).colorScheme.onSurface)
                          .withOpacity(_isItemDisabled(value) || !widget.enabled
                              ? 0.3
                              : 1),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    )));
  }
}

class SelectorContainer extends StatelessWidget {
  const SelectorContainer({
    super.key,
    required this.padding,
    this.enabled = true,
    this.backgroundColor,
    required this.child,
  });

  final EdgeInsetsGeometry padding;
  final bool enabled;
  final Color? backgroundColor;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ??
            Theme.of(context)
                .colorScheme
                .surfaceContainerHigh
                .withOpacity(enabled ? 1 : 0.75),
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: child,
    );
  }
}

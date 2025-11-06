import 'dart:async';

import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/padding.extension.dart';
import 'package:monekin/core/presentation/responsive/app_breakpoints.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

class ReorderableListTileStyling extends StatelessWidget {
  const ReorderableListTileStyling({super.key, required this.child});

  final ListTile child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTileTheme(
        tileColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}

class ColumnWithReorderableListAndSearch extends StatefulWidget {
  const ColumnWithReorderableListAndSearch({
    super.key,
    required this.onSearchChanged,
    required this.child,
    required this.onAddPressed,
    required this.addText,
    this.debounceDuration = const Duration(milliseconds: 225),
  });

  final void Function(String) onSearchChanged;
  final VoidCallback onAddPressed;
  final String addText;
  final Widget child;
  final Duration debounceDuration;

  static EdgeInsets listPadding(BuildContext context) => EdgeInsets.fromLTRB(
    16,
    6,
    16,
    BreakPoint.of(context).isLargerThan(BreakpointID.sm) ? 16 : 74,
  );

  @override
  State<ColumnWithReorderableListAndSearch> createState() =>
      _ColumnWithReorderableListAndSearchState();
}

class _ColumnWithReorderableListAndSearchState
    extends State<ColumnWithReorderableListAndSearch> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onSearchChanged(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final showTopAddButton = BreakPoint.of(
      context,
    ).isLargerThan(BreakpointID.sm);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ).withSafeBottom(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: appBreakPoints
                        .firstWhere((bp) => bp.id == BreakpointID.md)
                        .width,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: t.general.tap_to_search,
                      prefixIcon: const Icon(Icons.search_rounded),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
              ),
              if (showTopAddButton)
                FilledButton.icon(
                  onPressed: widget.onAddPressed,
                  icon: const Icon(Icons.add_rounded),
                  label: Text(widget.addText),
                ),
            ],
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}

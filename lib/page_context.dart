import 'package:flutter/material.dart';

/// Returns true if the current page is displayed within tabs
bool ifIsInTabs(BuildContext context) {
  final pageContext = PageContext.maybeOf(context);
  return pageContext?.isInTabs ?? false;
}

class PageContext extends InheritedWidget {
  final bool isInTabs;

  const PageContext({super.key, required this.isInTabs, required super.child});

  static PageContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PageContext>();
  }

  static PageContext of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No PageContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PageContext oldWidget) {
    return isInTabs != oldWidget.isInTabs;
  }
}

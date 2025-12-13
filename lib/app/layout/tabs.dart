import 'package:flutter/material.dart' hide BottomNavigationBar;
import 'package:monekin/app/layout/bottom_navigation_bar.dart';
import 'package:monekin/app/layout/lazy_indexed_stack.dart';
import 'package:monekin/app/layout/scaffold_configuration.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/core/utils/unique_app_widgets_keys.dart';
import 'package:monekin/page_framework.dart';

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

/// This page is the entry point of the app once the user has complete onboarding
class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => TabsPageState();
}

class TabsPageState extends State<TabsPage>
    with PageWithScaffold, WidgetsBindingObserver {
  AppMenuDestinationsID? selectedDestination;
  ScaffoldConfiguration currentScaffoldConfiguration = ScaffoldConfiguration(
    title: '',
  );

  ScaffoldConfiguration? previousScaffoldConfiguration;

  WidgetsBinding get widgetsBinding => WidgetsBinding.instance;

  @override
  ScaffoldConfiguration get scaffoldConfiguration =>
      currentScaffoldConfiguration;

  @override
  void initState() {
    super.initState();

    widgetsBinding.addObserver(this);
    updateScaffoldConfiguration();
  }

  @override
  void dispose() {
    widgetsBinding.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Called when the window size changes.
    // Scaffold config is not updated otherwise when resizing the window
    updateScaffoldConfiguration();
  }

  void changePage(AppMenuDestinationsID destination) {
    print("--------------------");
    navigationSidebarKey.currentState?.setSelectedDestination(destination);

    // Update selected destination. No need to call setState here because
    // updateScaffoldConfiguration will call setState when needed.
    selectedDestination = destination;

    updateScaffoldConfiguration();

    FocusScope.of(context).unfocus();
  }

  void updateScaffoldConfiguration() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add post frame callback to ensure that selectedItem.pageKey exists
      if (!mounted) {
        return;
      }

      final menuItems = getAllDestinations(context);

      final selectedItem = menuItems.firstWhere(
        (element) => element.id == selectedDestination,
        orElse: () => menuItems.last,
      );

      if (selectedItem.pageKey?.currentState == null) {
        // Load the page if needed. For some reason the currentState is null
        // only after the second different page selection.
        setState(() {});
      }

      if (selectedItem.pageKey?.currentState != null) {
        final pageState = selectedItem.pageKey!.currentState;
        if (pageState is PageWithScaffold) {
          final config = (pageState as PageWithScaffold).scaffoldConfiguration;

          // Only update if the configuration has actually changed
          if (config != currentScaffoldConfiguration) {
            setState(() {
              previousScaffoldConfiguration = currentScaffoldConfiguration;
              currentScaffoldConfiguration = config;
            });
          }
        } else {
          throw Exception(
            'PageState is not of type PageWithScaffold. '
            'That probably means that the page is not a valid destination for TabsPage.',
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(context);
    selectedDestination ??= menuItems.elementAt(0).id;

    return PageFramework(
      scaffoldConfiguration: currentScaffoldConfiguration,
      bottomNavigationBar: !AppUtils.isMobileLayout(context)
          ? null
          : BottomNavigationBar(selectedDestination: selectedDestination!),
      body: PageContext(
        isInTabs: true,
        child: Builder(
          builder: (context) {
            final allDestinations = getAllDestinations(context);

            final selectedIndex = allDestinations.indexWhere(
              (element) => element.id == selectedDestination,
            );

            return FadeIndexedStack(
              index: selectedIndex,
              duration: !AppUtils.isDesktop
                  ? Duration.zero
                  : const Duration(milliseconds: 300),
              children: allDestinations.map((e) => e.destination).toList(),
            );
          },
        ),
      ),
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;

  const FadeIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 250),
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
  });

  @override
  FadeIndexedStackState createState() => FadeIndexedStackState();
}

class FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: LazyIndexedStack(
        index: widget.index,
        alignment: widget.alignment,
        textDirection: widget.textDirection,
        sizing: widget.sizing,
        children: widget.children,
      ),
    );
  }
}

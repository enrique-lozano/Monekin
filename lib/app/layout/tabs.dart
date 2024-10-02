import 'package:flutter/material.dart';
import 'package:monekin/app/layout/lazy_indexed_stack.dart';
import 'package:monekin/core/presentation/responsive/breakpoints.dart';
import 'package:monekin/core/routes/destinations.dart';
import 'package:monekin/main.dart';

/// This page is the entry point of the app once the user has complete onboarding
class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => TabsPageState();
}

class TabsPageState extends State<TabsPage> {
  MainMenuDestination? selectedDestination;

  void changePage(MainMenuDestination destination) {
    navigationSidebarKey.currentState?.setSelectedDestination(destination);

    setState(() {
      selectedDestination = destination;
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = getDestinations(context,
        shortLabels: BreakPoint.of(context).isSmallerThan(BreakpointID.xl));

    selectedDestination ??= menuItems.elementAt(0);

    final selectedNavItemIndex = menuItems
        .indexWhere((element) => element.id == selectedDestination!.id);

    return Scaffold(
      bottomNavigationBar: BreakPoint.of(context)
                  .isLargerThan(BreakpointID.sm) ||
              !(0 <= selectedNavItemIndex &&
                  selectedNavItemIndex < menuItems.length)
          ? null
          : NavigationBar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              indicatorColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              destinations: menuItems
                  .map((e) => e.toNavigationDestinationWidget(context))
                  .toList(),
              selectedIndex: selectedNavItemIndex,
              onDestinationSelected: (e) => changePage(menuItems.elementAt(e)),
            ),
      body: Builder(builder: (context) {
        final allDestinations = getAllDestinations(context,
            shortLabels: BreakPoint.of(context).isSmallerThan(BreakpointID.xl));

        return FadeIndexedStack(
          index: allDestinations
              .indexWhere((element) => element.id == selectedDestination?.id),
          duration: const Duration(milliseconds: 300),
          children: allDestinations.map((e) => e.destination).toList(),
        );
      }),
      // selectedDestination?.destination ?? const SizedBox.shrink(),
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
    this.duration = const Duration(
      milliseconds: 250,
    ),
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
  });

  @override
  FadeIndexedStackState createState() => FadeIndexedStackState();
}

class FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);

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

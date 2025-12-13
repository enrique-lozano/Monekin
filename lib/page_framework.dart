import 'package:flutter/material.dart';
import 'package:monekin/app/layout/scaffold_configuration.dart';
import 'package:monekin/app/layout/tabs.dart';
import 'package:monekin/app/transactions/animate_fab.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/empty_app_bar.dart';

class PageFramework extends StatelessWidget {
  const PageFramework({
    super.key,
    required this.scaffoldConfiguration,
    required this.body,
    this.bottomNavigationBar,
  });

  final ScaffoldConfiguration scaffoldConfiguration;
  final Widget body;
  final Widget? bottomNavigationBar;

  bool _getIfIsInTabs(BuildContext context) {
    final pageContext = PageContext.maybeOf(context);
    return pageContext?.isInTabs ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isInTabs = _getIfIsInTabs(context);

    Widget toBuild = body;

    if (!isInTabs) {
      // Wrap in Scaffold when not in tabs (standalone page)
      toBuild = MediaQuery.removePadding(
        context: context,
        removeLeft: !AppUtils.isMobileLayout(context),
        removeRight: !AppUtils.isMobileLayout(context),
        child: Scaffold(
          appBar: scaffoldConfiguration.enableAppBar
              ? scaffoldConfiguration.buildDefaultAppBar()
              : scaffoldConfiguration.appBarBackgroundColor != null
              ? EmptyAppBar(
                  key: ValueKey(
                    'empty_app_bar_${scaffoldConfiguration.appBarBackgroundColor}',
                  ),
                  color: scaffoldConfiguration.appBarBackgroundColor!,
                )
              : null,
          persistentFooterButtons:
              scaffoldConfiguration.persistentFooterButtons,
          floatingActionButton: AnimateFABDelayed(
            fab: scaffoldConfiguration.floatingActionButton,
          ),

          bottomNavigationBar: bottomNavigationBar,

          // body: CustomScrollView(
          //   slivers: [
          //     PageFrameworkSliverAppBar(
          //       scaffoldConfiguration: scaffoldConfiguration,
          //     ),
          //     SliverFillRemaining(child: toBuild),
          //     //toBuild,
          //   ],
          // ),
          body: toBuild,
        ),
      );
    }

    return PageNavigationFrameworkSafeArea(child: toBuild);
  }
}

class PageNavigationFrameworkSafeArea extends StatelessWidget {
  const PageNavigationFrameworkSafeArea({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final devicePadding = MediaQuery.paddingOf(context);
    double rightPaddingSafeArea = devicePadding.right;
    bool hasRightSafeArea = rightPaddingSafeArea > 0;
    double leftPaddingSafeArea = devicePadding.left;
    bool hasLeftSafeArea =
        leftPaddingSafeArea > 0 && AppUtils.isMobileLayout(context);

    // Only enable left safe area if no navigation sidebar
    return Stack(
      children: [
        hasRightSafeArea || hasLeftSafeArea
            ? Container(color: Theme.of(context).colorScheme.surface)
            : SizedBox.shrink(),
        hasRightSafeArea || hasLeftSafeArea
            ? Container(
                padding: EdgeInsets.only(
                  right: hasRightSafeArea ? rightPaddingSafeArea : 0,
                  left: hasLeftSafeArea ? leftPaddingSafeArea : 0,
                ),
                child: child,
              )
            : child,
        hasRightSafeArea
            ? Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: rightPaddingSafeArea,
                  color: Theme.of(context).colorScheme.surface,
                ),
              )
            : SizedBox.shrink(),
        hasLeftSafeArea
            ? Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: leftPaddingSafeArea,
                  color: Theme.of(context).colorScheme.surface,
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

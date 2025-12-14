import 'package:flutter/material.dart';
import 'package:monekin/app/transactions/animate_fab.dart';
import 'package:monekin/core/utils/app_utils.dart';
import 'package:monekin/empty_app_bar.dart';

class PageFramework extends StatelessWidget {
  const PageFramework({
    super.key,
    this.title,
    this.tabBar,
    this.appBarActions,
    this.appBarBuilder,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.enableAppBar = true,
    this.persistentFooterButtons,
    this.floatingActionButton,
    required this.body,
    this.bottomNavigationBar,
  });

  final String? title;
  final TabBar? tabBar;
  final List<Widget>? appBarActions;
  final PreferredSizeWidget Function(
    String title,
    TabBar? tabBar,
    List<Widget>? appBarActions,
  )?
  appBarBuilder;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final bool enableAppBar;
  final List<Widget>? persistentFooterButtons;
  final Widget? floatingActionButton;
  final Widget body;
  final Widget? bottomNavigationBar;

  PreferredSizeWidget? _buildAppBar() {
    if (enableAppBar) {
      if (appBarBuilder != null) {
        return appBarBuilder!(title ?? '', tabBar, appBarActions);
      }

      return AppBar(
        key: ValueKey('AppBar_${title ?? ''}'),
        title: Text(title ?? ''),
        bottom: tabBar,
        backgroundColor: appBarBackgroundColor,
        foregroundColor: appBarForegroundColor,
        actions: appBarActions,
      );
    }

    if (appBarBackgroundColor != null) {
      return EmptyAppBar(
        key: ValueKey('empty_app_bar_$appBarBackgroundColor'),
        color: appBarBackgroundColor!,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = MediaQuery.removePadding(
      context: context,
      removeLeft: !AppUtils.isMobileLayout(context),
      removeRight: !AppUtils.isMobileLayout(context),
      child: Scaffold(
        appBar: _buildAppBar(),
        persistentFooterButtons: persistentFooterButtons,
        floatingActionButton: AnimateFABDelayed(fab: floatingActionButton),
        bottomNavigationBar: bottomNavigationBar,
        body: body,
      ),
    );

    return PageNavigationFrameworkSafeArea(child: scaffold);
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

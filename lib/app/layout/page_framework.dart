import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/animations/animate_fab.dart';
import 'package:monekin/core/presentation/helpers/empty_app_bar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';

class PageFramework extends StatelessWidget {
  const PageFramework({
    super.key,
    this.title,
    this.tabBar,
    this.appBarActions,
    this.appBarBuilder,
    this.breadcrumbs,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.enableAppBar = true,
    this.persistentFooterButtons,
    this.floatingActionButton,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
  });

  final String? title;
  final TabBar? tabBar;
  final List<Widget>? appBarActions;
  final List<PageBreadcrumb>? breadcrumbs;
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
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (enableAppBar) {
      if (breadcrumbs != null && !AppUtils.isMobileLayout(context)) {
        return AppBar(
          key: ValueKey(
            'AppBar_${breadcrumbs!.map((item) => item.label).join('_')}',
          ),
          titleSpacing: 0,
          title: _Breadcrumbs(items: breadcrumbs!),
          bottom: tabBar,
          backgroundColor: appBarBackgroundColor,
          foregroundColor: appBarForegroundColor,
          actions: appBarActions,
        );
      }

      if (appBarBuilder != null) {
        return appBarBuilder!(title ?? '', tabBar, appBarActions);
      }

      return AppBar(
        key: ValueKey('AppBar_${title ?? ''}'),
        leading: SideDrawerScope.of(context) ? const CloseButton() : null,
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
        appBar: _buildAppBar(context),
        persistentFooterButtons: persistentFooterButtons,
        floatingActionButton: AnimateFABDelayed(fab: floatingActionButton),
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        body: body,
      ),
    );

    return PageNavigationFrameworkSafeArea(child: scaffold);
  }
}

class PageBreadcrumb {
  const PageBreadcrumb(this.label, {this.onTap});

  final String label;
  final VoidCallback? onTap;
}

class _Breadcrumbs extends StatelessWidget {
  const _Breadcrumbs({required this.items});

  final List<PageBreadcrumb> items;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge;

    return Row(
      spacing: 4,
      children: [
        for (var index = 0; index < items.length; index++) ...[
          if (index > 0) ...[
            Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
          Flexible(
            child: items[index].onTap == null
                ? Text(
                    items[index].label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style,
                  )
                : TextButton(
                    onPressed: items[index].onTap,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      minimumSize: const Size(0, 40),
                      textStyle: style,
                      foregroundColor: style?.color,
                    ),
                    child: Text(
                      items[index].label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: style,
                    ),
                  ),
          ),
        ],
      ],
    );
  }
}

class PageScrollTitle extends StatelessWidget {
  const PageScrollTitle({
    super.key,
    this.primaryTitle,
    required this.secondaryTitle,
    required this.controller,
  });

  final String? primaryTitle;
  final String secondaryTitle;
  final ScrollController controller;

  static double opacityForOffset(
    double offset, {
    double fadeStart = 40,
    double fadeEnd = 100,
  }) {
    return ((offset - fadeStart) / (fadeEnd - fadeStart))
        .clamp(0, 1)
        .toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final opacity = controller.hasClients
            ? opacityForOffset(controller.offset)
            : 0.0;

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (primaryTitle != null)
              Opacity(opacity: 1 - opacity, child: Text(primaryTitle!)),
            Opacity(opacity: opacity, child: Text(secondaryTitle)),
          ],
        );
      },
    );
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

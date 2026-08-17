import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/animations/animate_fab.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/empty_app_bar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';

class PageFramework extends StatelessWidget {
  const PageFramework({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.leading,
    this.tabBar,
    this.appBarActions,
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
  final Widget? subtitle;
  final Widget? icon;
  final Widget? leading;
  final TabBar? tabBar;
  final List<Widget>? appBarActions;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final bool enableAppBar;
  final List<Widget>? persistentFooterButtons;
  final Widget? floatingActionButton;
  final Widget body;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Trailing inset so compact desktop action icons are not flush with the
  /// window edge. Android keeps the default Material padding.
  static EdgeInsetsGeometry? get _actionsPadding =>
      AppUtils.isDesktop ? const EdgeInsetsDirectional.only(end: 12) : null;

  bool _usesSingleRowHeader(BuildContext context) =>
      SideDrawerScope.of(context) || ModalPageScope.of(context);

  Widget _buildHeaderContent(BuildContext context, {bool singleRow = false}) {
    final theme = Theme.of(context);
    final foregroundColor =
        appBarForegroundColor ?? theme.colorScheme.onSurface;

    TextStyle? textStyle = singleRow
        ? theme.textTheme.titleLarge
        : subtitle != null && icon != null
        ? theme.textTheme.titleLarge
        : AppUtils.isMobileLayout(context)
        ? theme.textTheme.headlineLarge
        : theme.textTheme.headlineSmall;

    textStyle = textStyle?.copyWith(
      color: foregroundColor,
      fontWeight: FontWeight.bold,
    );

    return Row(
      spacing: 12,
      children: [
        if (icon != null)
          IconTheme.merge(
            data: IconThemeData(
              size: singleRow ? 24 : 32,
              color: foregroundColor,
            ),
            child: icon!,
          ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
              if (subtitle != null)
                DefaultTextStyle(
                  style: theme.textTheme.labelMedium!.copyWith(
                    color:
                        appBarForegroundColor?.withValues(alpha: 0.85) ??
                        theme.extension<AppColors>()?.textHint ??
                        theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  child: subtitle!,
                ),
            ],
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (enableAppBar) {
      final singleRow = _usesSingleRowHeader(context);
      final resolvedLeading =
          leading ?? (singleRow ? const CloseButton() : null);

      if (singleRow) {
        return AppBar(
          key: ValueKey('AppBar_${title ?? ''}'),
          toolbarHeight: subtitle != null || icon != null ? 76 : 56,
          titleSpacing: icon != null ? 0 : null,
          leading: resolvedLeading,
          title: _buildHeaderContent(context, singleRow: true),
          bottom: tabBar,
          backgroundColor: appBarBackgroundColor,
          foregroundColor: appBarForegroundColor,
          actions: appBarActions,
          actionsPadding: _actionsPadding,
        );
      }

      if (!AppUtils.isMobileLayout(context)) {
        return AppBar(
          key: ValueKey('AppBar_${title ?? ''}'),
          toolbarHeight: subtitle != null || icon != null ? 76 : 56,
          titleSpacing: icon != null ? 0 : null,
          leading: resolvedLeading,
          title: _buildHeaderContent(context),
          bottom: tabBar,
          backgroundColor: appBarBackgroundColor,
          foregroundColor: appBarForegroundColor,
          actions: appBarActions,
          actionsPadding: _actionsPadding,
        );
      }

      return _buildMobileAppBar(context, 0);
    }

    if (appBarBackgroundColor != null) {
      return EmptyAppBar(
        key: ValueKey('empty_app_bar_$appBarBackgroundColor'),
        color: appBarBackgroundColor!,
      );
    }

    return null;
  }

  PreferredSizeWidget _buildMobileAppBar(
    BuildContext context,
    double collapseProgress,
  ) {
    final resolvedLeading =
        leading ?? (SideDrawerScope.of(context) ? const CloseButton() : null);
    final headerHeight =
        _MobilePageHeader.expandedHeaderHeight * (1 - collapseProgress);

    return AppBar(
      key: ValueKey('AppBar_${title ?? ''}'),
      leading: resolvedLeading,
      title: Opacity(
        opacity: collapseProgress,
        child: Text(title ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      bottom: _MobilePageHeader(
        header: _buildHeaderContent(context),
        headerHeight: headerHeight,
        headerOpacity: 1 - collapseProgress,
        tabBar: tabBar,
      ),
      backgroundColor: appBarBackgroundColor,
      foregroundColor: appBarForegroundColor,
      actions: appBarActions,
      actionsPadding: _actionsPadding,
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    PreferredSizeWidget? appBar,
    Widget? scaffoldBody,
  }) {
    return MediaQuery.removePadding(
      context: context,
      removeLeft: !AppUtils.isMobileLayout(context),
      removeRight: !AppUtils.isMobileLayout(context),
      child: Scaffold(
        appBar: appBar ?? _buildAppBar(context),
        persistentFooterButtons: persistentFooterButtons,
        floatingActionButton: AnimateFABDelayed(fab: floatingActionButton),
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        body: scaffoldBody ?? body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (enableAppBar &&
        AppUtils.isMobileLayout(context) &&
        !_usesSingleRowHeader(context)) {
      return PageNavigationFrameworkSafeArea(
        child: _CollapsibleMobilePageScaffold(page: this),
      );
    }

    return PageNavigationFrameworkSafeArea(child: _buildScaffold(context));
  }
}

class _MobilePageHeader extends StatelessWidget implements PreferredSizeWidget {
  const _MobilePageHeader({
    required this.header,
    required this.headerHeight,
    required this.headerOpacity,
    this.tabBar,
  });

  static const expandedHeaderHeight = 64.0;

  final Widget header;
  final double headerHeight;
  final double headerOpacity;
  final TabBar? tabBar;

  @override
  Size get preferredSize =>
      Size.fromHeight(headerHeight + (tabBar?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: headerHeight,
          child: ClipRect(
            child: Opacity(
              opacity: headerOpacity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: header,
              ),
            ),
          ),
        ),
        ?tabBar,
      ],
    );
  }
}

class _CollapsibleMobilePageScaffold extends StatefulWidget {
  const _CollapsibleMobilePageScaffold({required this.page});

  final PageFramework page;

  @override
  State<_CollapsibleMobilePageScaffold> createState() =>
      _CollapsibleMobilePageScaffoldState();
}

class _CollapsibleMobilePageScaffoldState
    extends State<_CollapsibleMobilePageScaffold> {
  double _collapseProgress = 0;

  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;

    final nextProgress =
        (notification.metrics.pixels / _MobilePageHeader.expandedHeaderHeight)
            .clamp(0.0, 1.0);

    if ((nextProgress - _collapseProgress).abs() > 0.001) {
      setState(() => _collapseProgress = nextProgress);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.page._buildScaffold(
      context,
      appBar: widget.page._buildMobileAppBar(context, _collapseProgress),
      scaffoldBody: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: widget.page.body,
      ),
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

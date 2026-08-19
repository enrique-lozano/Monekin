import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:monekin/core/presentation/animations/animate_fab.dart';
import 'package:monekin/core/presentation/app_colors.dart';
import 'package:monekin/core/presentation/helpers/empty_app_bar.dart';
import 'package:monekin/core/routes/route_utils.dart';
import 'package:monekin/core/utils/app_utils.dart';

part 'page_framework_mobile.dart';

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

  bool get _hasTitle => title != null && title!.isNotEmpty;

  bool get _hasIdentityExtras => subtitle != null || icon != null;

  bool _usesSingleRowHeader(BuildContext context) =>
      SideDrawerScope.of(context) || ModalPageScope.of(context);

  Color _foregroundColor(BuildContext context) =>
      appBarForegroundColor ?? Theme.of(context).colorScheme.onSurface;

  Color _subtitleColor(BuildContext context) {
    return appBarForegroundColor?.withValues(alpha: 0.85) ??
        Theme.of(context).extension<AppColors>()?.textHint ??
        Theme.of(context).colorScheme.onSurfaceVariant;
  }

  Widget _buildHeaderContent(BuildContext context, {bool singleRow = false}) {
    final theme = Theme.of(context);
    final foreground = _foregroundColor(context);
    final compactTitle = singleRow || (subtitle != null && icon != null);
    final baseStyle = compactTitle
        ? theme.textTheme.titleLarge
        : AppUtils.isMobileLayout(context)
        ? theme.textTheme.headlineLarge
        : theme.textTheme.headlineSmall;

    return Row(
      spacing: 12,
      children: [
        if (icon != null)
          IconTheme.merge(
            data: IconThemeData(size: singleRow ? 24 : 32, color: foreground),
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
                style: baseStyle?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null)
                DefaultTextStyle(
                  style: theme.textTheme.labelMedium!.copyWith(
                    color: _subtitleColor(context),
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

  PreferredSizeWidget _buildStaticAppBar(
    BuildContext context, {
    required bool singleRow,
  }) {
    return AppBar(
      key: ValueKey('AppBar_${title ?? ''}'),
      toolbarHeight: _hasIdentityExtras ? 76 : 56,
      titleSpacing: icon != null ? 0 : null,
      leading: leading ?? (singleRow ? const CloseButton() : null),
      title: _hasTitle
          ? _buildHeaderContent(context, singleRow: singleRow)
          : null,
      bottom: tabBar,
      backgroundColor: appBarBackgroundColor,
      foregroundColor: appBarForegroundColor,
      actions: appBarActions,
      actionsPadding: _actionsPadding,
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (!enableAppBar) {
      return appBarBackgroundColor == null
          ? null
          : EmptyAppBar(
              key: ValueKey('empty_app_bar_$appBarBackgroundColor'),
              color: appBarBackgroundColor!,
            );
    }

    return _buildStaticAppBar(
      context,
      singleRow: _usesSingleRowHeader(context),
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
    final collapsible =
        enableAppBar &&
        _hasTitle &&
        AppUtils.isMobileLayout(context) &&
        !_usesSingleRowHeader(context);

    return PageNavigationFrameworkSafeArea(
      child: collapsible
          ? _CollapsibleMobilePageScaffold(page: this)
          : _buildScaffold(context),
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

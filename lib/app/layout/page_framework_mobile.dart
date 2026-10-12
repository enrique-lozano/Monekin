part of 'page_framework.dart';

class _MobilePageHeader extends StatelessWidget implements PreferredSizeWidget {
  const _MobilePageHeader({required this.headerHeight, this.tabBar});

  static double expandedHeight({required bool hasSubtitle}) =>
      64 + (hasSubtitle ? 4 : 0);

  final double headerHeight;
  final TabBar? tabBar;

  @override
  Size get preferredSize =>
      Size.fromHeight(headerHeight + (tabBar?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: headerHeight),
        ?tabBar,
      ],
    );
  }
}

/// One title that moves from the identity row into the toolbar. Icon and
/// subtitle stay in the expanded row and fade out as the header shrinks.
class _MobileCollapsingIdentity extends StatelessWidget {
  const _MobileCollapsingIdentity({
    required this.title,
    required this.collapseProgress,
    required this.foregroundColor,
    required this.subtitleColor,
    required this.hasLeading,
    required this.actionsCount,
    this.icon,
    this.subtitle,
  });

  final String title;
  final Widget? icon;
  final Widget? subtitle;
  final double collapseProgress;
  final Color foregroundColor;
  final Color subtitleColor;
  final bool hasLeading;
  final int actionsCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSubtitle = subtitle != null;
    final titleStyle = theme.textTheme.titleLarge!.copyWith(
      color: foregroundColor,
      fontWeight: FontWeight.bold,
      height: 1,
    );

    // Font size of the title once it has moved into the toolbar.
    final collapsedSize = titleStyle.fontSize ?? 22;
    // Font size of the title in the expanded identity row.
    final expandedSize = hasSubtitle
        ? (theme.textTheme.headlineSmall?.fontSize ?? 24)
        : (theme.textTheme.headlineLarge?.fontSize ?? 32);

    // Subtitle line height; zero when the page has no subtitle.
    final subtitleSize = hasSubtitle
        ? (theme.textTheme.labelMedium?.fontSize ?? 12)
        : 0.0;

    // Space between the expanded title and the subtitle.
    final gap = hasSubtitle ? 4.0 : 0.0;
    // Combined height of the expanded title, gap, and subtitle.
    final blockHeight = expandedSize + gap + subtitleSize;

    // Icon is slightly taller than the text block when a subtitle is present.
    final iconSize = icon != null && hasSubtitle ? (blockHeight * 1.1) : 32.0;

    // Top inset from the status bar / display cutout.
    final statusBar = MediaQuery.paddingOf(context).top;
    // Used to pin leading/trailing edges correctly in LTR and RTL.
    final direction = Directionality.of(context);
    // Left edge of the expanded title (after the icon, if any).
    final expandedStart = 16.0 + (icon != null ? iconSize + 12 : 0);
    // Top edge of the expanded title, pinned just above the app-bar divider.
    final expandedTop =
        statusBar +
        kToolbarHeight +
        _MobilePageHeader.expandedHeight(hasSubtitle: hasSubtitle) -
        12 -
        blockHeight;
    // Icon and subtitle fade out in the first half of the collapse.
    final fade = (1 - collapseProgress * 2).clamp(0.0, 1.0);

    Widget pin({
      double? start,
      double? end,
      required double top,
      double opacity = 1,
      required Widget child,
    }) {
      return Positioned.directional(
        textDirection: direction,
        start: start,
        end: end,
        top: top,
        child: IgnorePointer(
          child: Opacity(opacity: opacity, child: child),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        if (icon != null)
          pin(
            start: 16,
            top: expandedTop + (blockHeight - iconSize) / 2,
            opacity: fade,
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: FittedBox(
                fit: BoxFit.contain,
                child: IconTheme.merge(
                  data: IconThemeData(size: iconSize, color: foregroundColor),
                  child: icon!,
                ),
              ),
            ),
          ),
        if (subtitle != null)
          pin(
            start: expandedStart,
            end: 16,
            top: expandedTop + expandedSize + gap,
            opacity: fade,
            child: DefaultTextStyle(
              style: theme.textTheme.labelMedium!.copyWith(
                color: subtitleColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: subtitle!,
            ),
          ),
        pin(
          start: lerpDouble(
            expandedStart,
            (hasLeading ? kToolbarHeight : 0) +
                NavigationToolbar.kMiddleSpacing,
            collapseProgress,
          ),
          end: lerpDouble(16, 8 + actionsCount * 48, collapseProgress),
          top: lerpDouble(
            expandedTop,
            statusBar + (kToolbarHeight - collapsedSize) / 2,
            collapseProgress,
          )!,
          child: Transform.scale(
            key: const ValueKey('page_framework_collapsing_title'),
            alignment: AlignmentDirectional.topStart.resolve(direction),
            scale: lerpDouble(
              expandedSize / collapsedSize,
              1,
              collapseProgress,
            )!,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
        ),
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
  double _progress = 0;

  PageFramework get _page => widget.page;

  double get _headerHeight =>
      _MobilePageHeader.expandedHeight(hasSubtitle: _page.subtitle != null);

  void _setProgress(double value) {
    if (!mounted) return;
    final next = value.clamp(0.0, 1.0);
    if ((next - _progress).abs() <= 0.001) return;
    setState(() => _progress = next);
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;

    final metrics = notification.metrics;
    if (_progress == 0 && metrics.maxScrollExtent < _headerHeight) {
      return false;
    }

    _setProgress(metrics.pixels / _headerHeight);

    return false;
  }

  bool _hasToolbarLeading(BuildContext context, Widget? leading) {
    if (leading != null) return true;
    if (Scaffold.maybeOf(context)?.hasDrawer ?? false) return true;
    return ModalRoute.of(context)?.impliesAppBarDismissal ?? false;
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final leading =
        _page.leading ??
        (SideDrawerScope.of(context)
            ? CloseButton(onPressed: _page.onClose)
            : null);

    return AppBar(
      key: ValueKey('AppBar_${_page.title ?? ''}'),
      leading: leading,
      titleSpacing: 0,
      clipBehavior: Clip.hardEdge,
      flexibleSpace: _MobileCollapsingIdentity(
        title: _page.title ?? '',
        icon: _page.icon,
        subtitle: _page.subtitle,
        collapseProgress: _progress,
        foregroundColor: _page._foregroundColor(context),
        subtitleColor: _page._subtitleColor(context),
        hasLeading: _hasToolbarLeading(context, leading),
        actionsCount: _page.appBarActions?.length ?? 0,
      ),
      bottom: _MobilePageHeader(
        headerHeight: _headerHeight * (1 - _progress),
        tabBar: _page.tabBar,
      ),
      backgroundColor: _page.appBarBackgroundColor,
      foregroundColor: _page.appBarForegroundColor,
      actions: _page.appBarActions,
      actionsPadding: PageFramework._actionsPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _page._buildScaffold(
      context,
      appBar: _buildAppBar(context),
      scaffoldBody: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: _page.body,
      ),
    );
  }
}

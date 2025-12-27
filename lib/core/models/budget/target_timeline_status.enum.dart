import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// The status of a target (budget or goal) relative to the current date.
enum TargetTimelineStatus {
  /// The budget is currently active.
  active,

  /// The budget period has passed.
  past,

  /// The budget period is in the future.
  future;

  /// Returns the icon associated with the budget status.
  Widget icon({double size = 24}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: color.lighten(0.5), width: size * 0.2),
      ),
    );
  }

  /// Returns the color associated with the budget status.
  Color get color {
    switch (this) {
      case TargetTimelineStatus.active:
        return Colors.blue;
      case TargetTimelineStatus.past:
        return Colors.amber;
      case TargetTimelineStatus.future:
        return Colors.blueGrey;
    }
  }

  String displayName(BuildContext context) {
    final t = Translations.of(context);

    switch (this) {
      case TargetTimelineStatus.active:
        return t.target_timeline_statuses.active;
      case TargetTimelineStatus.past:
        return t.target_timeline_statuses.past;
      case TargetTimelineStatus.future:
        return t.target_timeline_statuses.future;
    }
  }
}

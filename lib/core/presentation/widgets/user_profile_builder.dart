import 'package:flutter/material.dart';
import 'package:monekin/core/database/services/user-setting/user_setting_service.dart';

/// Reactively builds a widget with the current user profile (name + avatar).
///
/// It watches the profile settings from the DB, so it rebuilds only itself
/// whenever the profile changes (e.g. after editing it), instead of forcing a
/// full app-state refresh. The initial data comes from [appStateSettings] to
/// avoid any flicker on the first frame.
class UserProfileBuilder extends StatelessWidget {
  const UserProfileBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, String? userName, String? avatar)
  builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserSettingService.instance.getUserProfile(),
      initialData: (
        userName: appStateSettings[SettingKey.userName],
        avatar: appStateSettings[SettingKey.avatar],
      ),
      builder: (context, snapshot) {
        return builder(context, snapshot.data!.userName, snapshot.data!.avatar);
      },
    );
  }
}

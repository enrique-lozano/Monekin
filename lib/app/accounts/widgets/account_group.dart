import 'package:flutter/material.dart';
import 'package:monekin/core/extensions/color.extensions.dart';
import 'package:monekin/core/models/account/account.dart';
import 'package:monekin/core/models/supported-icon/icon_displayer.dart';
import 'package:monekin/core/models/supported-icon/supported_icon.dart';
import 'package:monekin/core/presentation/theme.dart';

/// A list row on the dashboard or the stats: either a single account or several
/// accounts that share the same [Account.groupName].
typedef AccountRowData = ({String? groupName, List<Account> accounts});

/// Collapses the accounts sharing a group into a single row, keeping the order
/// in which each group first appears (so groups honour the user's
/// `displayOrder` just like standalone accounts do).
List<AccountRowData> groupAccounts(List<Account> accounts) {
  final rows = <AccountRowData>[];
  final rowIndexByGroup = <String, int>{};

  for (final account in accounts) {
    final group = account.groupName;

    if (group == null) {
      rows.add((groupName: null, accounts: [account]));
      continue;
    }

    final existingRow = rowIndexByGroup[group];

    if (existingRow == null) {
      rowIndexByGroup[group] = rows.length;
      rows.add((groupName: group, accounts: [account]));
    } else {
      rows[existingRow].accounts.add(account);
    }
  }

  return rows;
}

/// The "first account" that represents a group: the one with the lowest
/// display order, regardless of the order the list is passed in.
Account accountGroupRepresentative(List<Account> accounts) {
  return accounts.reduce((a, b) => a.displayOrder <= b.displayOrder ? a : b);
}

/// The color that represents a group: the shared color when every account has
/// the same one, otherwise the representative account's color. Both cases
/// resolve to the representative account's computed color.
Color accountGroupColor(BuildContext context, List<Account> accounts) {
  return accountGroupRepresentative(accounts).getComputedColor(context);
}

/// The icon shared by every account of a group, or `null` when they differ (in
/// which case a generic group icon is used instead).
SupportedIcon? sharedAccountIcon(List<Account> accounts) {
  final firstIconId = accounts.first.iconId;

  return accounts.every((a) => a.iconId == firstIconId)
      ? accountGroupRepresentative(accounts).icon
      : null;
}

/// Builds the leading icon that represents a whole group, applying the shared
/// icon/color rules.
IconDisplayer accountGroupIcon(
  BuildContext context,
  List<Account> accounts, {
  double size = 24,
}) {
  final color = accountGroupColor(context, accounts);
  final isDark = isAppInDarkBrightness(context);
  final sharedIcon = sharedAccountIcon(accounts);

  return IconDisplayer(
    supportedIcon: sharedIcon,
    icon: sharedIcon == null ? Icons.workspaces_rounded : null,
    mainColor: color.lighten(isDark ? IconDisplayer.darkLightenFactor : 0),
    secondaryColor: color.lighten(isDark ? 0 : IconDisplayer.darkLightenFactor),
    displayMode: IconDisplayMode.polygon,
    size: size,
    borderRadius: 20,
  );
}

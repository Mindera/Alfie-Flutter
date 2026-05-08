import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/account/view/account_menu_item.dart';

/// Represents the presentation state for the account dashboard.
class AccountState {
  /// The list of actionable navigation items available to the user.
  final List<AccountMenuItem> menuItems;

  /// The dedicated sign-out action item.
  final AccountMenuItem signOutItem;

  /// The actively authenticated session data.
  final RegisteredUser? user;

  const AccountState({
    required this.menuItems,
    required this.signOutItem,
    required this.user,
  });
}

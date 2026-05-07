import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/account/view/account_menu_item.dart';

class AccountState {
  final List<AccountMenuItem> menuItems;
  final AccountMenuItem signOutItem;
  final RegisteredUser? user;

  AccountState({
    required this.menuItems,
    required this.signOutItem,
    required this.user,
  });
}

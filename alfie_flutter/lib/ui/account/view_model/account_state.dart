import 'package:alfie_flutter/ui/account/view/account_menu_item.dart';

class AccountState {
  final List<AccountMenuItem> menuItems;
  final AccountMenuItem signOutItem;

  AccountState({required this.menuItems, required this.signOutItem});
}

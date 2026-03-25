import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/account/view/account_menu_item.dart';
import 'package:alfie_flutter/ui/account/view_model/account_state.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountViewModelProvider = NotifierProvider(AccountViewModel.new);

class AccountViewModel extends Notifier<AccountState> {
  @override
  AccountState build() {
    return AccountState(
      menuItems: [
        AccountMenuItem(icon: AppIcons.account, label: "Personal Information"),
        AccountMenuItem(icon: AppIcons.package, label: "Orders"),
        AccountMenuItem(icon: AppIcons.returnIcon, label: "Returns & Refunds"),
        AccountMenuItem(icon: AppIcons.wishlist, label: "Wishlist"),
        AccountMenuItem(icon: AppIcons.creditCard, label: "Wallet"),
        AccountMenuItem(icon: AppIcons.home, label: "Promotions"),
        AccountMenuItem(icon: AppIcons.settings, label: "Settings"),
        AccountMenuItem(icon: AppIcons.help, label: "Help"),
      ],
      signOutItem: AccountMenuItem(
        icon: AppIcons.exit,
        label: "Sign Out",
        onTap: () {
          ref.read(authRepositoryProvider.notifier).logout();
        },
      ),
    );
  }
}

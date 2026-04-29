import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/account/view/account_menu_item.dart';
import 'package:alfie_flutter/ui/account/view_model/account_state.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountViewModelProvider = NotifierProvider(AccountViewModel.new);

class AccountViewModel extends Notifier<AccountState> {
  @override
  AccountState build() {
    final navigatorKey = ref.watch(navigatorKeyProvider);
    final currentUser = ref.watch(authRepositoryProvider);
    return AccountState(
      menuItems: [
        AccountMenuItem(
          icon: AppIcons.account,
          label: "Personal Information",
          onTap: () =>
              navigatorKey.currentContext?.goTo(AppRoute.personalInformation),
        ),
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
      user: currentUser is RegisteredUser ? currentUser : null,
    );
  }
}

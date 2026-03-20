import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/account/view/account_menu_item.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  static const List<AccountMenuItem> items = [
    AccountMenuItem(icon: AppIcons.account, label: "Personal Information"),
    AccountMenuItem(icon: AppIcons.package, label: "Orders"),
    AccountMenuItem(icon: AppIcons.returnIcon, label: "Returns & Refunds"),
    AccountMenuItem(icon: AppIcons.wishlist, label: "Wishlist"),
    AccountMenuItem(icon: AppIcons.creditCard, label: "Wallet"),
    AccountMenuItem(icon: AppIcons.home, label: "Promotions"),
    AccountMenuItem(icon: AppIcons.settings, label: "Settings"),
    AccountMenuItem(icon: AppIcons.help, label: "Help"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AccountMenuItem signOutMenuItem = AccountMenuItem(
      icon: AppIcons.exit,
      label: "Sign Out",
      onTap: () {
        ref.read(authRepositoryProvider.notifier).logout();
      },
    );
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.extraSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hi, Alfie!", style: context.textTheme.displaySmall),
                    AppButton.tertiary(
                      leading: AppIcons.profileId,
                      onPressed: () {},
                    ),
                  ],
                ),
                Text(
                  "Member since 2024",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.extraSmall,
            ),
            child: Column(
              spacing: Spacing.medium,
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: items),
                signOutMenuItem,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

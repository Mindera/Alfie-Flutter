import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/account/view/account_menu_item.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(title: "Account", leading: null),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.small),

        child: Column(
          spacing: Spacing.medium,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.small,
              children: [
                Icon(AppIcons.account),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Spacing.extraSmall,
                  children: [
                    Text(
                      "Sign in to your account",
                      style: context.textTheme.headlineSmall,
                    ),
                    Text(
                      "View your orders and fast-track your checkout experience",
                    ),
                  ],
                ),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: Spacing.extraSmall,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: AppButton.primary(
                    label: "Sign in",
                    onPressed: () {
                      context.goTo(AppRoute.signIn);
                    },
                  ),
                ),

                SizedBox(
                  width: double.maxFinite,
                  child: AppButton.secondary(
                    label: "Create Account",
                    onPressed: () {
                      context.goTo(AppRoute.createAccount);
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AccountMenuItem(icon: AppIcons.settings, label: "Settings"),
                AccountMenuItem(icon: AppIcons.help, label: "Help"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

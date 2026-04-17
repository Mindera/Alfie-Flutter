import 'package:alfie_flutter/ui/account/view_model/account_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountViewModelProvider);
    return SafeArea(
      child: SingleChildScrollView(
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
                      Text(
                        "Hi, ${state.user?.data.firstName}!",
                        style: context.textTheme.displaySmall,
                      ),
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: state.menuItems,
                  ),
                  state.signOutItem,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

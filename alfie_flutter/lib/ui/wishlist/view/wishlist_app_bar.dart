import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';

/// A customized application bar designed specifically for the Wishlist view.
///
/// Implements [PreferredSizeWidget] to guarantee standard Material metrics
/// while exposing bespoke sharing and navigation actions.
class WishlistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WishlistAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (!context.safePop()) context.goTo(AppRoute.home);
        },
        icon: Icon(AppIcons.back),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(AppIcons.share))],
      title: Text('Wishlist', style: context.textTheme.headlineSmall),
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.neutral,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

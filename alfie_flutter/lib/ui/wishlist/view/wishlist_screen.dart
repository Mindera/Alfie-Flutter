import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/vertical_product_card.dart';
import 'package:alfie_flutter/ui/core/ui/snack_bar.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: _wishlistAppBar(context), body: _wishlistBody(ref));
  }

  Widget _wishlistBody(WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
      ).add(EdgeInsets.only(bottom: Spacing.small)),

      child: GridView.builder(
        itemCount: wishlist.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.43,
          crossAxisSpacing: Spacing.extraSmall,
          mainAxisSpacing: Spacing.small,
        ),
        itemBuilder: (context, index) {
          final product = wishlist[index];
          return VerticalProductCard(
            product: product,
            actionButton: AppButton.secondary(
              label: "Add to Bag",
              onPressed: () {
                ref
                    .watch(bagViewModelProvider.notifier)
                    .addItem(BagItem(product: product, quantity: 1));
                ref
                    .watch(wishlistViewModelProvider.notifier)
                    .removeProduct(product.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  AppSnackBar.build(
                    context: context,
                    infoText: "Added to Bag.",
                    actionText: "Go to Bag",
                    messengerKey: ref.watch(scaffoldMessengerKeyProvider),
                    onTapAction: () => context.goTo(AppRoute.bag),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  AppBar _wishlistAppBar(BuildContext context) {
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
}

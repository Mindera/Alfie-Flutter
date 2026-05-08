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

class WishlistBody extends ConsumerWidget {
  const WishlistBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);
    return wishlist.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(Spacing.large),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spacing.small,
                children: [
                  const Icon(AppIcons.wishlist),
                  Column(
                    spacing: Spacing.extraExtraSmall,
                    children: [
                      const Text("Your wishlist is empty."),
                      Text(
                        "Tap this icon in the products you like to see them here.",
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.small,
            ).add(const EdgeInsets.only(bottom: Spacing.small)),

            child: GridView.builder(
              itemCount: wishlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.43,
                crossAxisSpacing: Spacing.extraSmall,
                mainAxisSpacing: Spacing.small,
              ),
              itemBuilder: (_, index) {
                final product = wishlist[index];
                return VerticalProductCard(
                  product: product,
                  actionButton: AppButton.secondary(
                    label: "Add to Bag",
                    onPressed: () {
                      ref
                          .read(bagViewModelProvider.notifier)
                          .addItem(BagItem(product: product, quantity: 1));
                      ref
                          .read(wishlistViewModelProvider.notifier)
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
}

import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/color_swatch.dart';
import 'package:alfie_flutter/ui/core/ui/snack_bar.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays the primary metadata for a [Product], including brand, name,
/// price, available colors, and call-to-action buttons.
class ProductMainInfo extends ConsumerWidget {
  final Product product;
  final bool isOnWishlist;

  const ProductMainInfo({
    super.key,
    required this.product,
    required this.isOnWishlist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: Spacing.extraSmall,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.brand.name, style: context.textTheme.labelSmall),
                  Text(
                    product.name.capitalizeAll(),
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    product.defaultVariant.price.amount.formatted,
                    style: context.textTheme.bodyMediumBold,
                  ),
                ],
              ),
            ),
            ColorSwatchWidget(
              color: AppColors.neutral,
              totalColors: product.colours?.length ?? 1,
            ),
          ],
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Spacing.extraSmall,
          children: [
            Expanded(
              child: AppButton.primary(
                label: "Add to Bag",
                onPressed: () {
                  ref
                      .read(productDetailViewModelProvider(product.id).notifier)
                      .addToBag(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar.build(
                      context: context,
                      infoText: "Added to bag.",
                      actionText: "Go to Bag",
                      messengerKey: ref.watch(scaffoldMessengerKeyProvider),
                      onTapAction: () {
                        context.goTo(AppRoute.bag);
                      },
                    ),
                  );
                },
              ),
            ),
            AppButton.secondary(
              leading: isOnWishlist ? AppIcons.wishlistFill : AppIcons.wishlist,
              onPressed: () {
                late String infoText;
                late String? actionText;
                if (isOnWishlist) {
                  ref
                      .read(productDetailViewModelProvider(product.id).notifier)
                      .removeFromWishlist(product);
                  infoText = "Removed from Wishlist.";
                  actionText = null;
                } else {
                  ref
                      .read(productDetailViewModelProvider(product.id).notifier)
                      .addToWishlist(product);
                  infoText = "Added to Wishlist.";
                  actionText = "Go to Wishlist";
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  AppSnackBar.build(
                    context: context,
                    infoText: infoText,
                    actionText: actionText,
                    messengerKey: ref.watch(scaffoldMessengerKeyProvider),
                    onTapAction: () {
                      context.goTo(AppRoute.wishlist);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

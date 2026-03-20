import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/snack_bar.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistButton extends ConsumerWidget {
  final Product product;
  final ButtonVariant buttonVariant;
  final ButtonSize buttonSize;

  const WishlistButton({
    super.key,
    required this.product,
    this.buttonVariant = ButtonVariant.secondary,
    this.buttonSize = ButtonSize.medium,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailViewModelProvider(product.id));
    final viewModel = ref.read(
      productDetailViewModelProvider(product.id).notifier,
    );

    return AppButton(
      variant: buttonVariant,
      size: buttonSize,
      leading: state.isOnWishlist ? AppIcons.wishlistFill : AppIcons.wishlist,
      onPressed: () {
        late String infoText;
        late String? actionText;

        if (state.isOnWishlist) {
          viewModel.removeFromWishlist(product);
          infoText = "Removed from Wishlist.";
          actionText = null;
        } else {
          viewModel.addToWishlist(product);
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
    );
  }
}

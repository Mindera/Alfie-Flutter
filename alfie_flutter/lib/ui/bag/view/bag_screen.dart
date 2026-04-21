import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/horizontal_product_card.dart';
import 'package:alfie_flutter/ui/core/ui/snack_bar.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BagScreen extends ConsumerWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bagItems = ref.watch(bagViewModelProvider);

    return Scaffold(
      appBar: _bagAppBar(context),
      body: _bagBody(bagItems, ref),

      bottomNavigationBar: bagItems.isNotEmpty
          ? _bagBottomBar(context, ref)
          : SizedBox.shrink(),
    );
  }

  Widget _bagBody(List<BagItem> bagItems, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
      ).add(EdgeInsets.only(bottom: Spacing.small)),
      child: bagItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spacing.small,
                children: const [
                  Icon(AppIcons.bag),
                  Text("Your bag is empty."),
                ],
              ),
            )
          : ListView.separated(
              itemCount: bagItems.length,
              itemBuilder: (context, index) {
                return HorizontalProductCard(
                  bagItem: bagItems[index],
                  onDismiss: (item) {
                    ref
                        .read(bagViewModelProvider.notifier)
                        .removeItem(item.product.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      AppSnackBar.build(
                        context: context,
                        infoText: "Removed.",
                        actionText: "Undo",
                        messengerKey: ref.watch(scaffoldMessengerKeyProvider),
                        onTapAction: () {
                          ref.read(bagViewModelProvider.notifier).addItem(item);
                        },
                      ),
                    );
                  },
                  onSave: (item) {
                    ref
                        .read(bagViewModelProvider.notifier)
                        .addToWishlist(item.product);

                    ref
                        .read(bagViewModelProvider.notifier)
                        .removeItem(item.product.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      AppSnackBar.build(
                        context: context,
                        infoText: "Added to Wishlist.",
                        actionText: "Undo",
                        messengerKey: ref.watch(scaffoldMessengerKeyProvider),
                        onTapAction: () {
                          ref
                              .read(bagViewModelProvider.notifier)
                              .removeFromWishlist(item.product);
                          ref.read(bagViewModelProvider.notifier).addItem(item);
                        },
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: Spacing.small);
              },
            ),
    );
  }

  Widget _bagBottomBar(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral,
        border: Border(top: BorderSide(color: AppColors.neutral200)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Spacing.small,
          Spacing.extraSmall,
          Spacing.small,
          Spacing.extraSmall + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Spacing.extraSmall,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: context.textTheme.bodyMediumBold),
                    Text(
                      '\$${ref.read(bagViewModelProvider.notifier).total.toStringAsFixed(2)}',
                      style: context.textTheme.bodyMediumBold,
                    ),
                  ],
                ),
                Text(
                  "Shipping and taxes are calculated in checkout.",
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: AppButton.primary(
                label: "Continue",
                onPressed: () {
                  if (ref.read(bagViewModelProvider.notifier).total > 0) {
                    context.goTo(AppRoute.checkout);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      AppSnackBar.build(
                        context: context,
                        infoText: "Your bag is empty.",
                        messengerKey: ref.watch(scaffoldMessengerKeyProvider),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _bagAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (!context.safePop()) context.goTo(AppRoute.home);
        },
        icon: Icon(AppIcons.back),
      ),
      title: Text('Bag', style: context.textTheme.headlineSmall),
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.neutral,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
    );
  }
}

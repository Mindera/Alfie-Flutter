import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/horizontal_product_card.dart';
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
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.small,
        ).add(EdgeInsets.only(bottom: Spacing.small)),
        child: bagItems.isEmpty
            ? const Center(child: Text('Your bag is empty.'))
            : ListView.separated(
                itemCount: bagItems.length,
                itemBuilder: (context, index) {
                  return HorizontalProductCard(
                    bagItem: bagItems[index],
                    onDismiss: (item) {
                      ref
                          .read(bagViewModelProvider.notifier)
                          .removeItem(item.product.id);
                    },
                    onSave: (item) {
                      //TODO Add to wishlist
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: Spacing.small);
                },
              ),
      ),
      bottomNavigationBar: Container(
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
                child: AppButton.primary(label: "Continue", onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

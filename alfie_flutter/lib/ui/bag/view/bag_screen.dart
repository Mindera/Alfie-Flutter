import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
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

    return RefreshIndicator.adaptive(
      onRefresh: () async => ref.refresh(bagViewModelProvider),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
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
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
            ).add(EdgeInsets.only(bottom: Spacing.small)),
            sliver: bagItems.isEmpty
                ? SliverToBoxAdapter(
                    child: const Center(child: Text('Your bag is empty.')),
                  )
                : SliverList.separated(
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
          SliverAppBar(
            pinned: true,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(Spacing.small),
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                spacing: Spacing.small,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AppButton.destructive(
                      label: 'Clear Bag',
                      onPressed: () =>
                          ref.read(bagViewModelProvider.notifier).clearBag(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '\$${ref.read(bagViewModelProvider.notifier).total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

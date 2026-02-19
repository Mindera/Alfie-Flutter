import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/product_card.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingScreen extends HookConsumerWidget {
  const ProductListingScreen({super.key});

  static const labels = ["Slim Fit", "Linen", "Cotton", "Straight Fit"];

  final columns = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProductListing = ref.watch(
      getProductListingProvider(
        ProductListingParams(
          offset: 0,
          limit: 4,
          query: null,
          categoryId: null,
          sort: null,
        ),
      ),
    );

    final controller = useScrollToTop(ref, AppRoute.store.fullPath);
    return asyncProductListing.when(
      loading: () => Center(child: AppIcons.progressIndicator),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (productListing) {
        if (productListing == null) {
          return const Center(child: Text("Not Found"));
        }
        return CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              primary: true,

              pinned: true,

              automaticallyImplyActions: false,
              automaticallyImplyLeading: false,

              backgroundColor: AppColors.neutral,
              surfaceTintColor: AppColors.transparent,

              flexibleSpace: FlexibleSpaceBar(
                background: Header(
                  leading: IconButton(
                    onPressed: () => context.safePop(),
                    icon: Icon(AppIcons.back),
                  ),
                  title: productListing.title.capitalizeAll(),
                ),
              ),
            ),

            SliverAppBar(
              primary: false,

              pinned: true,

              automaticallyImplyLeading: false,
              automaticallyImplyActions: false,

              backgroundColor: AppColors.neutral,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,

              titleSpacing: 0,

              toolbarHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(
                    left: Spacing.small,
                    right: Spacing.small,
                    bottom: Spacing.extraSmall,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppButton.tertiary(
                                leading: AppIcons.grid2,
                                size: ButtonSize.small,
                                onPressed: () {},
                              ),
                              AppButton.tertiary(
                                leading: AppIcons.grid3,
                                size: ButtonSize.small,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Text("${productListing.products.length} items"),
                          Text("Refine", style: context.textTheme.linkMedium),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.small,
                              vertical: Spacing.extraExtraSmall,
                            ),
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.neutral800),
                              borderRadius: BorderRadius.circular(
                                Spacing.medium,
                              ),
                            ),
                            child: Center(child: Text(labels[index])),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: Spacing.extraSmall),
                          itemCount: labels.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsetsGeometry.all(Spacing.small),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return VerticalProductCard(
                    product: productListing.products[index],
                  );
                }, childCount: productListing.products.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: Spacing.extraSmall,
                  mainAxisSpacing: Spacing.small,
                  childAspectRatio: 112.72 / 229.19,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

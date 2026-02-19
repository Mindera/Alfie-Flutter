import 'dart:developer';

import 'package:alfie_flutter/data/models/product_listing.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/product_card.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingScreen extends HookConsumerWidget {
  const ProductListingScreen({super.key});

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
          sort: ProductListingSort.highToLow,
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

              automaticallyImplyActions: false,
              automaticallyImplyLeading: false,

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
            SliverPadding(
              padding: EdgeInsetsGeometry.all(Spacing.small),
              sliver: SliverList.separated(
                itemCount: columns == 1
                    ? productListing.products.length
                    : ((productListing.products.length) / 2).ceil(),
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: Spacing.small),
                itemBuilder: (context, index) {
                  if (columns == 1) {
                    return VerticalProductCard();
                  }

                  final leftIndex = index * 2;
                  final rightIndex = leftIndex + 1;
                  log(productListing.products.length.toString());

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: Spacing.extraSmall,
                    children: [
                      Expanded(child: VerticalProductCard()),
                      rightIndex >= productListing.products.length
                          ? Expanded(child: SizedBox(width: double.maxFinite))
                          : Expanded(child: VerticalProductCard()),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

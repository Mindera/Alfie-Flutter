import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListingAppBar extends ConsumerWidget {
  const ProductListingAppBar({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListingTitle = ref.watch(
      productListingViewModelProvider(
        categoryId,
      ).select((s) => s.value?.listing?.title.capitalizeAll()),
    );
    return SliverAppBar(
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
          title: productListingTitle ?? '',
        ),
      ),
    );
  }
}

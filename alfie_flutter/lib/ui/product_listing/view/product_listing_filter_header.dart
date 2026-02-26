import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/product_listing/view_model/product_listing_view_model.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListingFilterHeader extends ConsumerWidget {
  const ProductListingFilterHeader({
    super.key,
    required this.categoryId,
    required this.onColumnsChanged,
    required this.columns,
  });

  final String categoryId;
  final ValueChanged<int> onColumnsChanged;
  final int columns;

  static const labels = ["Slim Fit", "Linen", "Cotton", "Straight Fit"];
  static const double _headerHeight = 88.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCount = ref.watch(
      productListingViewModelProvider(
        categoryId,
      ).select((s) => s.value?.listing?.products.length),
    );
    return SliverAppBar(
      pinned: true,
      primary: false,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.neutral,
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      toolbarHeight: _headerHeight,

      flexibleSpace: Padding(
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Spacing.extraExtraSmall,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton.tertiary(
                        leading: columns == 1
                            ? AppIcons.grid1Fill
                            : AppIcons.grid1,
                        size: ButtonSize.small,
                        onPressed: () => onColumnsChanged(1),
                      ),
                      AppButton.tertiary(
                        leading: columns == 2
                            ? AppIcons.grid2Fill
                            : AppIcons.grid2,
                        size: ButtonSize.small,
                        onPressed: () => onColumnsChanged(2),
                      ),
                    ],
                  ),
                ),
                if (productCount != null) Text("$productCount items"),
                Text("Refine", style: context.textTheme.linkMedium),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Spacing.extraExtraSmall,
                ),
                child: Row(
                  spacing: Spacing.extraSmall,
                  children: labels.map((label) {
                    final double borderWidth = 1;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.small - borderWidth,
                        vertical: Spacing.extraExtraSmall - borderWidth,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.neutral800,
                          width: borderWidth,
                        ),
                        borderRadius: BorderRadius.circular(Spacing.medium),
                      ),

                      child: Center(child: Text(label)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

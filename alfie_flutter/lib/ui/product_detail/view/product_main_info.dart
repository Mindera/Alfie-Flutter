import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/color_swatch.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';

/// Displays the primary metadata for a [Product], including brand, name,
/// price, available colors, and call-to-action buttons.
class ProductMainInfo extends StatelessWidget {
  final Product product;

  const ProductMainInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
                  // TODO: Wire up to ViewModel
                },
              ),
            ),
            AppButton.secondary(
              leading: AppIcons.wishlist,
              onPressed: () {
                // TODO: Wire up to ViewModel
              },
            ),
          ],
        ),
      ],
    );
  }
}

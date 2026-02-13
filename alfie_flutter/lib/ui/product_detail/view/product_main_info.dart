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

class ProductMainInfo extends StatelessWidget {
  const ProductMainInfo({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Spacing.extraSmall,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aditional Information 1",
                  style: context.textTheme.labelSmall,
                ),
                Text(
                  product.name.capitalizeAll(),
                  style: context.textTheme.bodyMedium,
                ),
                Text(
                  product.defaultVariant.price.amount.formatted,
                  style: context.textTheme.bodyMediumBold,
                ),
                Text(
                  "Aditional Information 2",
                  style: context.textTheme.labelSmall,
                ),
              ],
            ),
            ColorSwatchWidget(
              color: AppColors.neutral,
              size: product.colours?.length ?? 1,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: Spacing.extraSmall,
          children: [
            Expanded(
              child: AppButton.primary(label: "Add to Bag", onPressed: () {}),
            ),
            AppButton.secondary(leading: AppIcons.wishlist, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

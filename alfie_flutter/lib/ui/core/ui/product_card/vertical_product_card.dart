import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/product_detail/view/wishlist_button.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerticalProductCard extends ConsumerWidget {
  const VerticalProductCard({
    super.key,
    required this.product,
    this.aditionalInfo,
    this.label,
    this.actionButton,
  });

  final Product product;
  final String? aditionalInfo;
  static const aspectRatio = 2 / 3;
  final String? label;
  final AppButton? actionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.goToProduct(product.id),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spacing.extraSmall,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: ImageFactory.network(
                  product.colours!.first.media!.first.firstUrl,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.name,
                    style: context.textTheme.labelSmall,
                    maxLines: 1,
                  ),
                  Text(
                    product.name.capitalizeAll(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    product.defaultVariant.price.amount.formatted,
                    style: context.textTheme.bodyMediumBold,
                  ),
                  if (aditionalInfo != null)
                    Text(aditionalInfo!, style: context.textTheme.labelSmall),
                ],
              ),

              SizedBox(width: double.maxFinite, child: actionButton),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: WishlistButton(
              product: product,
              buttonVariant: ButtonVariant.tertiary,
            ),
          ),
          if (label != null)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(Spacing.extraSmall),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.extraSmall),
                  color: AppColors.neutral800,
                  child: Text(
                    label!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.neutral,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

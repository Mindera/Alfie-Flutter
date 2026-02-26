import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({
    super.key,
    required this.product,
    this.aditionalInfo,
    this.label,
  });

  final Product product;
  final String? aditionalInfo;
  static const aspectRatio = 2 / 3;
  final String? label;

  @override
  Widget build(BuildContext context) {
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
                child: FadeInImage.assetNetwork(
                  fadeInDuration: Duration(milliseconds: 300),
                  placeholder: "assets/images/fallback_image.png",
                  image: product.colours!.first.media!.first.when(
                    image: (image) => image.url,
                    video: (video) => video.sources.first.url,
                    orElse: () => '',
                  ),
                  fit: BoxFit.cover,
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
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: AppButton.tertiary(
              leading: AppIcons.wishlist,
              onPressed: () {},
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

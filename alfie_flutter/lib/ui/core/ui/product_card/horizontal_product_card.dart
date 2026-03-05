import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/quantity_selector_modal.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({super.key, required this.bagItem});

  final BagItem bagItem;
  static const aspectRatio = 3 / 4;

  @override
  Widget build(BuildContext context) {
    final labelSmallTextStyle = context.textTheme.labelSmall;

    return IntrinsicHeight(
      child: Row(
        spacing: Spacing.extraSmall,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.mediaQuery.size.width * 0.25,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: ImageFactory.network(
                bagItem.product.colours!.first.media!.first.firstUrl,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bagItem.product.name.capitalizeAll(),
                          style: context.textTheme.bodyMedium,
                        ),
                        Text('Ref. 0273/393', style: labelSmallTextStyle),
                        Text(
                          "Color: ${bagItem.product.colours!.first.name}",
                          style: labelSmallTextStyle,
                        ),
                        Text(
                          "Size: ${bagItem.product.defaultVariant.size?.value}",
                          style: labelSmallTextStyle,
                        ),
                      ],
                    ),
                    AppButton.tertiary(
                      size: ButtonSize.small,
                      leading: AppIcons.more,
                    ),
                  ],
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: Spacing.extraExtraExtraSmall,
                        children: [
                          Text("Quantity:"),
                          Text(bagItem.quantity.toString()),
                          AppButton.tertiary(
                            leading: AppIcons.chevronDown,
                            size: ButtonSize.small,
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(),
                                context: context,
                                builder: (context) {
                                  return QuantitySelectorModal(item: bagItem);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        bagItem.product.defaultVariant.price.amount.formatted,
                        style: context.textTheme.bodyMediumBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

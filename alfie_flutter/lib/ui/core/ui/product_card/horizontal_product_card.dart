import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/quantity_selector_modal.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';
import 'package:alfie_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    super.key,
    required this.bagItem,
    this.onDismiss,
    this.onSave,
  });

  final BagItem bagItem;
  static const aspectRatio = 3 / 4;
  final void Function(BagItem item)? onDismiss;
  final void Function(BagItem item)? onSave;

  @override
  Widget build(BuildContext context) {
    final labelSmallTextStyle = context.textTheme.labelSmall;

    return Slidable(
      key: ValueKey(bagItem.product.id),
      endActionPane: ActionPane(
        dismissible: DismissiblePane(
          onDismissed: () => onDismiss?.call(bagItem),
        ),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: AppColors.neutral,
            onPressed: (context) {
              onSave?.call(bagItem);
              onDismiss?.call(bagItem);
            },
            icon: AppIcons.wishlist,
            label: "Save",
          ),
          SlidableAction(
            backgroundColor: AppColors.error600,
            foregroundColor: AppColors.neutral,
            onPressed: (context) => onDismiss?.call(bagItem),
            icon: AppIcons.close,
            label: "Remove",
          ),
        ],
      ),
      child: IntrinsicHeight(
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
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bagItem.product.name.capitalizeAll(),
                              style: context.textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

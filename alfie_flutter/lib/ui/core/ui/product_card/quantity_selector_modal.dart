import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuantitySelectorModal extends HookConsumerWidget {
  static const double borderWidth = 1.0;
  const QuantitySelectorModal({super.key, required this.item});
  final BagItem item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(
      bagViewModelProvider.select(
        (bagItems) => bagItems
            .firstWhere((bagItem) => bagItem.product.id == item.product.id)
            .quantity,
      ),
    );
    final textController = useTextEditingController(text: quantity.toString());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Spacing.extraSmall),
          child: Center(
            child: Container(width: 40, height: 2, color: AppColors.neutral300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Spacing.small),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: Spacing.extraSmall,
            children: [
              Text("Quantity", style: context.textTheme.bodyMediumBold),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    width: borderWidth,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppButton.tertiary(
                      leading: AppIcons.minus,
                      onPressed: () {
                        textController.text = (quantity - 1).toString();
                        ref
                            .read(bagViewModelProvider.notifier)
                            .updateItemQuantity(item.product.id, quantity - 1);
                      },
                    ),
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          constraints: BoxConstraints(),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        showCursor: false,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: textController,
                        onChanged: (value) {
                          final parsedQuantity = int.tryParse(value);
                          if (parsedQuantity != null) {
                            ref
                                .read(bagViewModelProvider.notifier)
                                .updateItemQuantity(
                                  item.product.id,
                                  parsedQuantity,
                                );
                          } else {
                            // If parsing fails, reset the text to the current quantity
                            textController.text = quantity.toString();
                          }
                        },
                      ),
                    ),
                    AppButton.tertiary(
                      leading: AppIcons.add,
                      onPressed: () {
                        textController.text = (quantity + 1).toString();
                        ref
                            .read(bagViewModelProvider.notifier)
                            .updateItemQuantity(item.product.id, quantity + 1);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

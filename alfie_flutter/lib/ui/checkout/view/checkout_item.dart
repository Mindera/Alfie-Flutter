import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

class CheckoutItem extends StatelessWidget {
  final String? label;
  final String? content;
  final String nullValueFallBackMessage;
  final VoidCallback? onPressed;

  const CheckoutItem({
    super.key,
    this.label,
    this.content,
    this.onPressed,
    this.nullValueFallBackMessage = "No data",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.extraSmall),
      child: Row(
        children: [
          Expanded(
            child: Row(
              spacing: Spacing.extraSmall,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label != null)
                  SizedBox(
                    width: 70,
                    child: Text(
                      label!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ),

                Expanded(
                  child: content != null
                      ? Text(content!)
                      : Text(
                          nullValueFallBackMessage,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.neutral400,
                          ),
                        ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Icon(AppIcons.chevronRight),
            onTap: () => onPressed?.call(),
          ),
        ],
      ),
    );
  }
}

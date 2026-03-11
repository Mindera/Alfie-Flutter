import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static SnackBar build({
    required BuildContext context,
    required String infoText,
    String? actionText,
    VoidCallback? onTapAction,
    required GlobalKey<ScaffoldMessengerState> messengerKey,
  }) {
    return SnackBar(
      backgroundColor: AppColors.neutral800,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(infoText),
          if (actionText != null)
            GestureDetector(
              onTap: () {
                onTapAction?.call();
                messengerKey.currentState?.hideCurrentSnackBar();
              },
              child: Text(
                actionText,
                style: context.textTheme.linkMedium?.copyWith(
                  color: AppColors.neutral,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.neutral,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

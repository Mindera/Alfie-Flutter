import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';

/// A badge used to present promotions or offers.
///
/// This is a stateless component that renders a [title] and a
/// multi-line [description].
class PromotionBadge extends StatelessWidget {
  final String title;
  final String description;

  const PromotionBadge({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.extraSmall),
      color: AppColors.neutral100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.labelSmallBold,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            description,
            style: context.textTheme.labelSmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

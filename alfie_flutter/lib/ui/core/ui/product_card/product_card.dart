import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({super.key});

  static const aspectRatio = 2 / 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.extraSmall,
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: Image.asset(
            "assets/images/fallback_image.png",
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Additional Information 1",
              style: context.textTheme.labelSmall,
            ),
            Text("Product Name", style: context.textTheme.bodyMedium),
            Text("£120", style: context.textTheme.bodyMediumBold),
            Text(
              "Additional Information 2",
              style: context.textTheme.labelSmall,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/section_header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCarousel extends ConsumerWidget {
  const CategoryCarousel({super.key, this.imageSize = 100});

  static const double itemSpacing = Spacing.extraSmall;
  static const double contentSpacing = Spacing.extraExtraSmall;
  final double imageSize;

  final List<String> categories = const [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: Spacing.extraSmall,
      children: [
        SectionHeader(title: "Shop by Category", textLink: "text link"),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
                imageSize +
                contentSpacing +
                context.textTheme.bodyMedium!.height! *
                    context.textTheme.bodyMedium!.fontSize!,
          ),
          child: CarouselView(
            padding: EdgeInsets.only(right: itemSpacing),
            itemSnapping: true,
            shape: RoundedRectangleBorder(),
            itemExtent: imageSize + itemSpacing,
            shrinkExtent: imageSize / 2 + itemSpacing,
            children: categories.map((category) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                spacing: contentSpacing,
                children: [
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neutral100,
                    ),

                    child: Icon(AppIcons.bag),
                  ),
                  Text(
                    category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

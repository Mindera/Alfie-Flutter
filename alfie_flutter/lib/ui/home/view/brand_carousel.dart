import 'package:alfie_flutter/data/repositories/brand_repository.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/section_header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandCarousel extends ConsumerWidget {
  const BrandCarousel({super.key, this.logoSize = 100});

  static const double spacing = Spacing.extraExtraSmall;
  final double logoSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(brandListProvider);
    return Column(
      spacing: Spacing.extraSmall,
      children: [
        SectionHeader(title: "Shop by Brand", textLink: "text link"),
        brands.when(
          loading: () => AppIcons.progressIndicator,
          error: (error, stackTrace) => Text(error.toString()),
          data: (brands) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    logoSize +
                    spacing +
                    context.textTheme.bodyMedium!.height! *
                        context.textTheme.bodyMedium!.fontSize! *
                        2,
              ),
              child: CarouselView(
                padding: EdgeInsets.only(right: spacing),
                itemSnapping: true,
                shape: RoundedRectangleBorder(),
                itemExtent: logoSize + spacing,
                shrinkExtent: logoSize / 2 + spacing,
                children: brands.map((brand) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: spacing,
                    children: [
                      Container(
                        height: logoSize,
                        color: AppColors.neutral100,
                        child: Image.asset('assets/images/alfie.png'),
                      ),
                      Text(
                        brand.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

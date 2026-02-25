import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/core/ui/promotion_badge.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/ui/home/view/brand_carousel.dart';
import 'package:alfie_flutter/ui/home/view/category_carousel.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> highlights = [
      ImageFactory.networkWithGradient(
        'https://images.pexels.com/photos/6769357/pexels-photo-6769357.jpeg',
        foreground: Text(
          "Transcending Trends for Breezy Nights",
          style: context.textTheme.displayMedium?.copyWith(
            color: AppColors.neutral,
          ),
        ),
      ),
      ImageFactory.networkWithGradient(
        'https://images.pexels.com/photos/1381553/pexels-photo-1381553.jpeg',
      ),
      ImageFactory.networkWithGradient(
        'https://images.pexels.com/photos/10679191/pexels-photo-10679191.jpeg',
      ),
      ImageFactory.networkWithGradient(
        'https://images.pexels.com/photos/10037708/pexels-photo-10037708.jpeg',
      ),
      ImageFactory.networkWithGradient(
        'https://images.pexels.com/photos/247908/pexels-photo-247908.jpeg',
      ),
    ];

    final List<Widget> promotions = [
      PromotionBadge(
        title: "Get 50% off your first purchase!",
        description:
            "New subscribers receive 50% off their entire order. Activate message notifications and receive special discounts and updates.",
      ),
      PromotionBadge(
        title: "Get 30% off your second purchase!",
        description:
            "New subscribers receive 30% off their entire order. Activate message notifications and receive special discounts and updates.",
      ),
      PromotionBadge(
        title: "Get 99% off your third purchase!",
        description:
            "New subscribers receive 99% off their entire order. Activate message notifications and receive special discounts and updates. This is a long text. This is a long text. This is a long text. And you'll give us a lot of money. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. ",
      ),
    ];

    final controller = useScrollToTop(ref, AppRoute.home.fullPath);

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          automaticallyImplyActions: false,
          automaticallyImplyLeading: false,

          backgroundColor: AppColors.neutral,
          surfaceTintColor: AppColors.transparent,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(Spacing.small),
            expandedTitleScale: 1,
            background: Image.asset('assets/images/doc_branding.png'),
            title: Search(),
          ),
        ),
        SliverAppBar(
          primary: false,
          expandedHeight: context.mediaQuery.size.width * 4 / 3,
          flexibleSpace: FlexibleSpaceBar(
            background: Gallery(
              aspectRatio: 3 / 4,
              dotsAlignment: MainAxisAlignment.start,
              autoScroll: true,
              children: highlights,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: Spacing.small,
            vertical: Spacing.large,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: Spacing.extraLarge,
              children: [
                Gallery(
                  overlayDots: false,
                  darkDots: true,
                  children: promotions,
                ),
                CategoryCarousel(),
                BrandCarousel(),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: Image.asset(
            'assets/images/random_image.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

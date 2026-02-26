import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/home/view/brand_carousel.dart';
import 'package:alfie_flutter/ui/home/view/category_carousel.dart';
import 'package:alfie_flutter/ui/home/view/highlights_gallery.dart';
import 'package:alfie_flutter/ui/home/view/home_app_bar.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The primary landing screen of the application.
///
/// Utilizes a [CustomScrollView] to coordinate various sliver-based components.
/// State is managed via Riverpod, and scroll behavior is handled by [useScrollToTop].
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollToTop(ref, AppRoute.home.fullPath);

    return CustomScrollView(
      controller: controller,
      slivers: [
        const HomeAppBar(),
        const HighlightsGallery(),

        // Main content section.
        const SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: Spacing.small,
            vertical: Spacing.large,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: Spacing.extraLarge,
              children: [CategoryCarousel(), BrandCarousel()],
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

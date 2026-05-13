import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';

/// A pinned navigation sliver providing global search access and brand identity.
///
/// Anchors to the top of the viewport, transitioning the central brand logo
/// into a persistent [SearchDummy] field as the user scrolls down the page.
class HomeAppBar extends StatelessWidget {
  static const double expandedHeight = 150;
  static const String logoImagePath = 'assets/images/doc_branding.png';

  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      primary: true,
      pinned: true,
      automaticallyImplyActions: false,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.neutral,
      surfaceTintColor: AppColors.transparent,
      expandedHeight: expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(Spacing.small),
        expandedTitleScale: 1,
        background: Image.asset(logoImagePath, fit: BoxFit.scaleDown),
        title: SearchDummy(onTap: () => context.goTo(AppRoute.search)),
      ),
    );
  }
}

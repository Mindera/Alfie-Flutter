import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';

/// A persistent top navigation bar designed for the home screen.
///
/// It utilizes a [SliverAppBar] to transition from a branded background
/// to a pinned [SearchDummy] field during scrolling.
class HomeAppBar extends StatelessWidget {
  final double expandedHeight = 150;
  final String logoImagePath = 'assets/images/doc_branding.png';

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
        titlePadding: EdgeInsets.all(Spacing.small),
        // Setting scale to 1 prevents the Search field from resizing
        expandedTitleScale: 1,
        background: Image.asset(logoImagePath, fit: BoxFit.scaleDown),
        title: SearchDummy(onTap: () => context.goTo(AppRoute.search)),
      ),
    );
  }
}

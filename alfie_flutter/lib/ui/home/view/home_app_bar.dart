import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
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
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(Spacing.small),
        expandedTitleScale: 1,
        background: Image.asset('assets/images/doc_branding.png'),
        title: Search(),
      ),
    );
  }
}

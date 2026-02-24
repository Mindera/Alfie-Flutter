import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  static List<Media> highlights = <Media>[
    MediaImage(
      url: 'https://images.pexels.com/photos/6769357/pexels-photo-6769357.jpeg',
    ),
    MediaImage(
      url: 'https://images.pexels.com/photos/1381553/pexels-photo-1381553.jpeg',
    ),
    MediaImage(
      url:
          'https://images.pexels.com/photos/10679191/pexels-photo-10679191.jpeg',
    ),
    MediaImage(
      url:
          'https://images.pexels.com/photos/10037708/pexels-photo-10037708.jpeg',
    ),
    MediaImage(
      url: 'https://images.pexels.com/photos/247908/pexels-photo-247908.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        SliverToBoxAdapter(
          child: SizedBox(
            height: 500,
            child: Gallery(
              medias: highlights,
              dotsAlignment: MainAxisAlignment.start,
              title: 'Transcending Trends for Breezy Nights',
            ),
          ),
        ),
      ],
    );
  }
}

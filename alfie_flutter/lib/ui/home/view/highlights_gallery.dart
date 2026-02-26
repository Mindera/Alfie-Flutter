import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/image_utils.dart';
import 'package:flutter/material.dart';

class HighlightsGallery extends StatelessWidget {
  const HighlightsGallery({super.key});

  @override
  Widget build(BuildContext context) {
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

    return SliverAppBar(
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
    );
  }
}

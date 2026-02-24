import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A swipeable gallery that displays a paginated list of [Media] items.
///
/// Supports both image and video models, displaying the video's first source URL
/// as a thumbnail. Automatically hides pagination indicators if there is only one item.
///
/// TO BE DONE: Video support is not yet implemented
class Gallery extends HookWidget {
  /// The collection of media items to display in the gallery.
  final List<Media> medias;

  final MainAxisAlignment dotsAlignment;

  final String? title;

  const Gallery({
    super.key,
    required this.medias,
    this.dotsAlignment = MainAxisAlignment.center,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (medias.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentPage = useState(0);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: medias.length,
          onPageChanged: (index) => currentPage.value = index,
          itemBuilder: (context, index) {
            final mediaUrl = _extractMediaUrl(medias[index]);

            // Prevent network exceptions if the media URL is empty.
            if (mediaUrl.isEmpty) {
              return Image.asset(
                'assets/images/fallback_image.png',
                fit: BoxFit.cover,
              );
            }
            return FadeInImage.assetNetwork(
              imageCacheHeight: 550,
              placeholder: 'assets/images/fallback_image.png',
              image: mediaUrl,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/fallback_image.png',
                  fit: BoxFit.cover,
                );
              },
            );
          },
        ),
        if (title != null)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, AppColors.neutral800],
                  ),
                ),
              ),
            ),
          ),

        // Only show pagination dots if there are multiple items to swipe through.
        Padding(
          padding: const EdgeInsets.all(Spacing.small),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Spacing.medium,
            children: [
              if (title != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: context.textTheme.displayMedium?.copyWith(
                        color: AppColors.neutral,
                      ),
                    ),
                    Text(
                      "Explore Collection",
                      style: context.textTheme.linkMedium?.copyWith(
                        color: AppColors.neutral,
                        decorationColor: AppColors.neutral,
                      ),
                    ),
                  ],
                ),
              if (medias.length > 1)
                Row(
                  mainAxisAlignment: dotsAlignment,
                  spacing: Spacing.extraSmall,
                  children: List.generate(
                    medias.length,
                    (index) =>
                        _DotIndicator(isActive: currentPage.value == index),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Safely extracts the primary display URL from the [Media] union type.
  String _extractMediaUrl(Media media) {
    return media.when(
      image: (image) => image.url,
      // Avoids a StateError by ensuring sources list is not empty before accessing .first
      video: (video) => video.sources.isNotEmpty ? video.sources.first.url : '',
      orElse: () => '',
    );
  }
}

/// An animated dot indicator for the gallery pagination.
///
/// Extracted into its own [StatelessWidget] to prevent the entire [Gallery]
/// from rebuilding unnecessarily when a single dot's state changes.
class _DotIndicator extends StatelessWidget {
  final bool isActive;

  const _DotIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 12 : 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.neutral : AppColors.neutral400,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Gallery extends HookWidget {
  const Gallery({super.key, required this.medias});
  final List<Media> medias;

  @override
  Widget build(BuildContext context) {
    final currentPage = useState(0);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: medias.length,
          onPageChanged: (index) => currentPage.value = index,
          itemBuilder: (context, index) {
            return FadeInImage.assetNetwork(
              placeholder: "assets/images/fallback_image.png",
              image: medias[index].when(
                image: (image) => image.url,
                video: (video) => video.sources.first.url,
                orElse: () => '',
              ),
              fit: BoxFit.cover,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: Spacing.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Spacing.extraSmall,
            children: List.generate(medias.length, (index) {
              return _buildDot(currentPage.value == index);
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(bool isActive) {
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

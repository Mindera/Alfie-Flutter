import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  Gallery({super.key, required this.medias});
  final List<Media> medias;

  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: medias.length,
          onPageChanged: (index) => _currentPage.value = index,
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
        ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: Spacing.small),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spacing.extraSmall,
                children: List.generate(medias.length, (index) {
                  return _buildDot(value == index);
                }),
              ),
            );
          },
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

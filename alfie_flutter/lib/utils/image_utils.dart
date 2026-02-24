import 'package:flutter/material.dart';

abstract class ImageFactory {
  static StatefulWidget network(String url) {
    if (url.isEmpty) {
      return Image.asset('assets/images/fallback_image.png', fit: BoxFit.cover);
    }
    return FadeInImage.assetNetwork(
      imageCacheHeight: 550,
      placeholder: 'assets/images/fallback_image.png',
      image: url,
      fit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/fallback_image.png',
          fit: BoxFit.cover,
        );
      },
    );
  }
}

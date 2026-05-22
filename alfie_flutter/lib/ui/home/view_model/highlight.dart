/// Represents a featured visual item for the home page highlights gallery.
class Highlight {
  /// The remote network URL locating the feature image.
  final String imageUrl;

  /// An optional overlay text summarizing the feature or promotion.
  final String? title;

  const Highlight({required this.imageUrl, this.title});
}

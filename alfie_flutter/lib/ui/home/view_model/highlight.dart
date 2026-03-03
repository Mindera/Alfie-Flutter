/// Represents a featured item to be displayed in the home highlights gallery.
///
/// This model is consumed by the HomeViewModel
/// to prepare the UI state for the HighlightsGallery view.
class Highlight {
  final String imageUrl;
  final String? title;

  Highlight({required this.imageUrl, this.title});
}

/// Represents a historical user search query used for auto-completion or recent search lists.
class SearchItem {
  /// The raw text string entered by the user.
  final String query;

  /// The exact time the search was executed, used for chronological sorting.
  final DateTime timestamp;

  const SearchItem({required this.query, required this.timestamp});
}

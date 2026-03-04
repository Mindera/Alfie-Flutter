/// Represents a single entry in the user's search history.
class SearchItem {
  final String query;
  final DateTime timestamp;

  SearchItem({required this.query, required this.timestamp});
}

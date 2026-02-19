/// Utility extensions for common [String] manipulations.
extension StringUtils on String {
  /// Capitalizes the first letter of every word separated by spaces or hyphens.
  ///
  /// For example: 'hello-world' becomes 'Hello-World' and 'jane doe' becomes 'Jane Doe'.
  String capitalizeAll() {
    if (isEmpty) return this;

    // Use a RegExp to split by both spaces and hyphens while capturing the delimiters
    // to preserve the original formatting during the join.
    final pattern = RegExp(r'(\s|-)');

    return splitMapJoin(
      pattern,
      onMatch: (m) => m.group(0)!,
      onNonMatch: (word) => word.capitalize(),
    );
  }

  /// Capitalizes the first character of the string.
  ///
  /// Returns the original string if it is empty.
  String capitalize() {
    if (isEmpty) return this;

    if (length == 1) return toUpperCase();

    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

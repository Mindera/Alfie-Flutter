/// A centralized repository of regular expressions used for input validation.
class AppRegex {
  const AppRegex._();

  /// Validates standard personal names (2-30 characters, allowing spaces, hyphens, and apostrophes).
  static final name = RegExp(r"^[a-zA-Z\s\-']{2,30}$");

  /// Validates standard email address formats.
  static final email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validates internationalized phone numbers (7-15 digits, optional leading '+').
  static final phone = RegExp(r'^\+?[0-9]{7,15}$');

  /// Validates a minimum password length of 4 characters.
  static final password = RegExp(r'^.{4,}$');
}

class AppRegex {
  const AppRegex._();
  static final name = RegExp(r"^[a-zA-Z\s\-']{2,30}$");
  static final email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final phone = RegExp(r'^\+?[0-9]{7,15}$');
}

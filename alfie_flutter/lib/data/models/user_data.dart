import 'package:alfie_flutter/utils/form_utils.dart';

/// Represents a user's personal contact information.
class UserData {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  /// Represents an empty or uninitialized contact profile.
  const UserData.empty()
    : firstName = "",
      lastName = "",
      email = "",
      phoneNumber = "";

  /// Validates all contact fields against formatting rules via [FormUtils].
  ///
  /// Returns `true` only if all fields meet strict regex and length requirements.
  bool isValid() =>
      FormUtils.validateName(firstName) == null &&
      FormUtils.validateName(lastName) == null &&
      FormUtils.validateEmail(email) == null &&
      FormUtils.validatePhoneNumber(phoneNumber) == null;

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  String toString() {
    return 'UserData(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber)';
  }
}

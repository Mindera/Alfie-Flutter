import 'package:alfie_flutter/utils/form_utils.dart';

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

  const UserData.empty()
    : firstName = "",
      lastName = "",
      email = "",
      phoneNumber = "";

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

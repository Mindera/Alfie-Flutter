import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalInformationViewModel extends Notifier<User?> {
  static final nameRegex = RegExp(r"^[a-zA-Z\s\-']{2,30}$");
  static final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
  @override
  User? build() {
    return ref.watch(authRepositoryProvider);
  }

  String? validateName(
    String? value, {
    String errorMessage = 'Please enter a valid name',
  }) {
    return _validate(
      value: value,
      regex: nameRegex,
      errorMessage: errorMessage,
    );
  }

  String? validateEmail(
    String? value, {
    String errorMessage = 'Please enter a valid email',
  }) {
    return _validate(
      value: value,
      regex: emailRegex,
      errorMessage: errorMessage,
    );
  }

  String? validatePhoneNumber(
    String? value, {
    String errorMessage = 'Please enter a valid phone number',
  }) {
    return _validate(
      value: value,
      regex: phoneRegex,
      errorMessage: errorMessage,
    );
  }

  String? _validate({
    required String? value,
    required RegExp regex,
    required String errorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    if (!regex.hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }
}

final personalInformationViewModelProvider = NotifierProvider(
  PersonalInformationViewModel.new,
);

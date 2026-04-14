import 'package:alfie_flutter/utils/app_regex.dart';
import 'package:flutter/material.dart';

extension FormUtils on BuildContext {
  String? validateName(
    String? value, {
    String errorMessage = 'Please enter a valid name',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.name,
      errorMessage: errorMessage,
    );
  }

  String? validatePassword(
    String? value, {
    String errorMessage = 'Password must be at least 4 characters',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.password,
      errorMessage: errorMessage,
    );
  }

  String? validateCheckbox(
    bool? value, {
    String errorMessage = 'This field is required',
  }) {
    if (value != true) {
      return errorMessage;
    }
    return null;
  }

  String? validateEmail(
    String? value, {
    String errorMessage = 'Please enter a valid email',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.email,
      errorMessage: errorMessage,
    );
  }

  String? validatePhoneNumber(
    String? value, {
    String errorMessage = 'Please enter a valid phone number',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.phone,
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

import 'package:communitary_service_app/domain/models/change_password/change_password_model.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/password.dart';
import 'package:flutter/material.dart';

enum ChangePasswordFormState {
  loading,
  posted,
  error,
  pure,
  isValid,
  isNotValid
}

class ChangePasswordState {
  final Password oldPassword;
  final Password newPassword;
  final Password confirmPassword;
  final ChangePasswordFormState formState;
  final String? errorMessage;

  ChangePasswordState(
      {required this.oldPassword,
      required this.newPassword,
      required this.formState,
      required this.confirmPassword,
      this.errorMessage});

  factory ChangePasswordState.initial() => ChangePasswordState(
        oldPassword: const Password.pure(),
        newPassword: const Password.pure(),
        formState: ChangePasswordFormState.pure,
        confirmPassword: const Password.pure(),
        errorMessage: null,
      );

  ChangePasswordState copyWith(
      {Password? oldPassword,
      Password? newPassword,
      ChangePasswordFormState? formState,
      Password? confirmPassword,
      ValueGetter<String?>? errorMessage}) {
    return ChangePasswordState(
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        formState: formState ?? this.formState,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        errorMessage:
            errorMessage != null ? errorMessage() : this.errorMessage);
  }

  bool get isValid => formState == ChangePasswordFormState.isValid;

  bool get isLoading => formState == ChangePasswordFormState.loading;

  ChangePasswordModel toDomain() {
    return ChangePasswordModel(
      oldPassword: oldPassword.value,
      newPassword: newPassword.value,
    );
  }
}

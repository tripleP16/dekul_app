import 'package:communitary_service_app/presentation/blocs/change_password_bloc/change_password_state.dart';

abstract class ChangePasswordEvent {}

class InputOldPasswordEvent extends ChangePasswordEvent {
  final String oldPassword;

  InputOldPasswordEvent({required this.oldPassword});
}

class InputNewPasswordEvent extends ChangePasswordEvent {
  final String newPassword;
  InputNewPasswordEvent({required this.newPassword});
}

class InputConfirmPasswordEvent extends ChangePasswordEvent {
  final String confirmPassword;
  InputConfirmPasswordEvent({required this.confirmPassword});
}

class PostChangePasswordEvent extends ChangePasswordEvent {
  final ChangePasswordFormState formState;

  PostChangePasswordEvent({required this.formState});
}

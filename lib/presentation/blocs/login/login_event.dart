part of 'login_bloc.dart';

sealed class LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;
  final LoginStatus status;

  EmailChanged({required this.email, required this.status});
}

class PasswordChanged extends LoginEvent {
  final String password;
  final LoginStatus status;

  PasswordChanged({required this.password, required this.status});
}

class FormIsLoading extends LoginEvent {
  final LoginStatus status;
  FormIsLoading({
    required this.status,
  });
}

class FormSubmitted extends LoginEvent {
  final LoginStatus status;
  FormSubmitted({
    required this.status,
  });
}

import 'package:communitary_service_app/domain/models/login/access_token_model.dart';

class AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AppStartedEvent extends AuthEvent {}

class LoginSuccessEvent extends AuthEvent {
  final AccessTokenModel tokens;

  LoginSuccessEvent({required this.tokens});
}

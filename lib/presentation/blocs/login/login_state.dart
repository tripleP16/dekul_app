part of 'login_bloc.dart';

enum LoginStatus { loading, posted, pure, touched }

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final LoginStatus loginStatus;

  const LoginState({
    required this.email,
    required this.password,
    required this.loginStatus,
  });

  const LoginState.initialValue()
      : email = const Email.pure(),
        password = const Password.pure(),
        loginStatus = LoginStatus.pure;

  @override
  List<Object> get props => [email, password, loginStatus];
  LoginState copyWith(
      {Email? email, Password? password, LoginStatus? loginStatus}) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  bool get isValid => Formz.validate([email, password]);
}

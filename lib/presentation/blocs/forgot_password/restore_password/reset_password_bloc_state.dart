import 'package:communitary_service_app/presentation/shared/form_inputs/password.dart';

class ResetPasswordBlocState {
  final bool isValid;
  final Password password;
  final Password confirmPassword;
  final String accessToken;

  ResetPasswordBlocState({
    required this.isValid,
    required this.password,
    required this.confirmPassword,
    required this.accessToken,
  });

  factory ResetPasswordBlocState.initial() {
    return ResetPasswordBlocState(
      isValid: false,
      password: const Password.pure(),
      confirmPassword: const Password.pure(),
      accessToken: '',
    );
  }

  ResetPasswordBlocState copyWith(
      {bool? isValid,
      Password? password,
      Password? confirmPassword,
      String? accessToken}) {
    return ResetPasswordBlocState(
      isValid: isValid ?? this.isValid,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

abstract class ResetPasswordBlocEvent {}

class ResetPasswordAddAccessTokenEvent extends ResetPasswordBlocEvent {
  final String accessToken;

  ResetPasswordAddAccessTokenEvent({
    required this.accessToken,
  });
}

class ResetPasswordEdit extends ResetPasswordBlocEvent {
  final String password;

  ResetPasswordEdit({
    required this.password,
  });
}

class ResetPasswordConfirmEdit extends ResetPasswordBlocEvent {
  final String confirmPassword;

  ResetPasswordConfirmEdit({
    required this.confirmPassword,
  });
}


class ResetPasswordReset extends ResetPasswordBlocEvent {}
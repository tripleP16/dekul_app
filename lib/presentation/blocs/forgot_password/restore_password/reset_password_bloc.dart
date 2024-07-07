import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/models/forgot_password/reset_password_model.dart';
import 'package:communitary_service_app/domain/repositories/forgot_password/forgot_password_repository.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/restore_password/reset_password_bloc_event.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/restore_password/reset_password_bloc_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ResetPasswordBloc
    extends Bloc<ResetPasswordBlocEvent, ResetPasswordBlocState> {
  final ForgotPasswordRepository repository;
  ResetPasswordBloc(this.repository) : super(ResetPasswordBlocState.initial()) {
    on<ResetPasswordAddAccessTokenEvent>(_onAddAccessToken);
    on<ResetPasswordEdit>(_onEditPassword);
    on<ResetPasswordConfirmEdit>(_onConfirmEditPassword);
    on<ResetPasswordReset>(_onResetPassword);
  }

  void _onResetPassword(
      ResetPasswordReset event, Emitter<ResetPasswordBlocState> emit) {
    emit(ResetPasswordBlocState.initial());
  }

  void _onConfirmEditPassword(
      ResetPasswordConfirmEdit event, Emitter<ResetPasswordBlocState> emit) {
    final isValid = Formz.validate([
          Password.dirty(event.confirmPassword),
          Password.dirty(state.confirmPassword.value)
        ]) &&
        event.confirmPassword == state.password.value;
    emit(state.copyWith(
      password: Password.dirty(state.password.value),
      confirmPassword: Password.dirty(event.confirmPassword),
      isValid: isValid,
    ));
  }

  void _onEditPassword(
      ResetPasswordEdit event, Emitter<ResetPasswordBlocState> emit) {
    final isValid = Formz.validate([
          Password.dirty(event.password),
          Password.dirty(state.confirmPassword.value)
        ]) &&
        event.password == state.confirmPassword.value;

    emit(state.copyWith(
      password: Password.dirty(event.password),
      confirmPassword: Password.dirty(state.confirmPassword.value),
      isValid: isValid,
    ));
  }

  void _onAddAccessToken(ResetPasswordAddAccessTokenEvent event,
      Emitter<ResetPasswordBlocState> emit) {
    emit(state.copyWith(accessToken: event.accessToken));
  }

  void addAccessToken(String accessToken) {
    add(ResetPasswordAddAccessTokenEvent(accessToken: accessToken));
  }

  void editPassword(String password) {
    add(ResetPasswordEdit(password: password));
  }

  void editConfirmPassword(String password) {
    add(ResetPasswordConfirmEdit(confirmPassword: password));
  }

  void reset() {
    add(ResetPasswordReset());
  }

  Future<void> submit() async {
    try {
      await repository.resetPassword(ResetPasswordModel(
          accessToken: state.accessToken, newPassword: state.password.value));
      appRouter.go('/');
    } catch (e) {
      rethrow;
    }
  }
}

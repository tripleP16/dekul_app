import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/repositories/change_password/change_password_repository.dart';
import 'package:communitary_service_app/presentation/blocs/change_password_bloc/change_password_event.dart';
import 'package:communitary_service_app/presentation/blocs/change_password_bloc/change_password_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordRepository changePasswordRepository;
  ChangePasswordBloc(
    this.changePasswordRepository,
  ) : super(ChangePasswordState.initial()) {
    on<InputOldPasswordEvent>(_changeOldPassword);
    on<InputNewPasswordEvent>(_changeNewPassword);
    on<InputConfirmPasswordEvent>(_changeConfirmPassword);
    on<PostChangePasswordEvent>(_postChangePassword);
  }

  void _postChangePassword(
    PostChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
      formState: event.formState,
    ));
  }

  void _changeConfirmPassword(
    InputConfirmPasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(
        state.copyWith(confirmPassword: Password.dirty(event.confirmPassword)));
    _isFormValid(emit);
  }

  void _changeNewPassword(
    InputNewPasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(state.copyWith(newPassword: Password.dirty(event.newPassword)));
    _isFormValid(emit);
  }

  void _changeOldPassword(
    InputOldPasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(state.copyWith(oldPassword: Password.dirty(event.oldPassword)));
    _isFormValid(emit);
  }

  void _isFormValid(
    Emitter<ChangePasswordState> emit,
  ) {
    final isValidConfirmPassword =
        state.newPassword.value == state.confirmPassword.value;
    final isValid = Formz.validate(
          [
            Password.dirty(state.oldPassword.value),
            Password.dirty(state.newPassword.value),
            Password.dirty(state.confirmPassword.value),
          ],
        ) &&
        isValidConfirmPassword;

    emit(state.copyWith(
      formState: isValid
          ? ChangePasswordFormState.isValid
          : ChangePasswordFormState.isNotValid,
      errorMessage: isValidConfirmPassword
          ? () => null
          : () => 'Las contraseñas no coinciden.',
    ));
  }

  void onOldPasswordChanged(String oldPassword) {
    add(InputOldPasswordEvent(oldPassword: oldPassword));
  }

  void onNewPasswordChanged(String newPassword) {
    add(InputNewPasswordEvent(newPassword: newPassword));
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    add(InputConfirmPasswordEvent(confirmPassword: confirmPassword));
  }

  Future<void> onSubmit() async {
    add(PostChangePasswordEvent(formState: ChangePasswordFormState.loading));
    try {
      await changePasswordRepository.changePassword(
        state.toDomain(),
      );
      add(PostChangePasswordEvent(formState: ChangePasswordFormState.posted));
      appRouter.go('/home');
    } catch (e) {
      add(PostChangePasswordEvent(formState: ChangePasswordFormState.isValid));
      rethrow;
    }
  }
}

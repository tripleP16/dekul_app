import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/models/forgot_password/validate_code_model.dart';
import 'package:communitary_service_app/domain/repositories/forgot_password/forgot_password_repository.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/restore_password/reset_password_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/validate_code_bloc/validate_code_event.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/validate_code_bloc/validate_code_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ValidateCodeBloc extends Bloc<ValidateCodeEvent, ValidateCodeState> {
  final ForgotPasswordRepository forgotPasswordRepository;
  final ResetPasswordBloc resetPasswordBloc;
  ValidateCodeBloc(
    this.forgotPasswordRepository,
    this.resetPasswordBloc,
  ) : super(ValidateCodeState.initial()) {
    on<EditCode>(_onEditCode);
    on<ValidateCodeReset>(_onReset);
  }

  void _onReset(ValidateCodeReset event, Emitter<ValidateCodeState> emit) {
    emit(ValidateCodeState.initial());
  }

  void _onEditCode(EditCode event, Emitter<ValidateCodeState> emit) {
    emit(
      state.copyWith(
          code: Code.dirty(event.code),
          isValid: Formz.validate([Code.dirty(event.code)])),
    );
  }

  void onEditCode(String code) {
    add(EditCode(code: code));
  }

  void reset() {
    add(ValidateCodeReset());
  }

  Future<void> validateCode() async {
    try {
      final result = await forgotPasswordRepository.validateCode(
        ValidateCodeModel(code: state.code.value),
      );

      resetPasswordBloc.addAccessToken(result.accessToken);

      appRouter.go('/restore_password');
    } catch (e) {
      rethrow;
    }
  }
}

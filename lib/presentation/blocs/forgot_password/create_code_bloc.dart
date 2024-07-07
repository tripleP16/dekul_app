import 'package:communitary_service_app/domain/models/forgot_password/create_code_model.dart';
import 'package:communitary_service_app/domain/repositories/forgot_password/forgot_password_repository.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/create_code_event.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/create_code_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateCodeBloc extends Bloc<CreateCodeEvent, CreateCodeStateInput> {
  final ForgotPasswordRepository repository;
  CreateCodeBloc(this.repository) : super(CreateCodeStateInput.empty()) {
    on<CreateCodeEmailInput>(_onEmailInput);
    on<CreateCodePosted>(_onPosted);
    on<CreateCodeError>(_onError);
    on<CreateCodeReset>(_onReset);
  }

  void _onReset(CreateCodeReset event, Emitter<CreateCodeStateInput> emit) {
    emit(CreateCodeStateInput.empty());
  }

  void _onError(CreateCodeError event, Emitter<CreateCodeStateInput> emit) {
    emit(state.copyWith(
      email: Email.dirty(state.email.value),
      state: Formz.validate([Email.dirty(state.email.value)])
          ? CreateCodeState.valid
          : CreateCodeState.error,
    ));
  }

  void _onPosted(
      CreateCodePosted event, Emitter<CreateCodeStateInput> emit) async {
    emit(state.copyWith(
      email: Email.dirty(state.email.value),
      state: CreateCodeState.success,
    ));
  }

  void _onEmailInput(
      CreateCodeEmailInput event, Emitter<CreateCodeStateInput> emit) {
    emit(state.copyWith(
      email: Email.dirty(event.email),
      state: Formz.validate([Email.dirty(event.email)])
          ? CreateCodeState.valid
          : CreateCodeState.error,
    ));
  }

  void editEmail(String email) {
    add(CreateCodeEmailInput(email: email));
  }

  Future<void> submit() async {
    try {
      await repository.createCodeToRestorePassword(
        CreateCodeModel(email: state.email.value),
      );
      add(CreateCodePosted());
    } catch (e) {
      add(CreateCodeError());
      rethrow;
    }
  }

  void reset() {
    add(CreateCodeReset());
  }
}

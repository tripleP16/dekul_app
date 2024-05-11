import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.initialValue()) {
    on<EmailChanged>(_onEmailChanged);

    on<PasswordChanged>(_onPasswordChanged);

    on<FormSubmitted>(_onSubmitted);

    on<FormIsLoading>(_onFormIsLoading);
  }

  void _onFormIsLoading(FormIsLoading event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      loginStatus: event.status,
    ));
  }

  void _onSubmitted(FormSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      loginStatus: event.status,
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final newEmail = Email.dirty(event.email);
    emit(state.copyWith(
      email: newEmail,
      loginStatus: event.status,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final newPassword = Password.dirty(event.password);
    emit(state.copyWith(
      password: newPassword,
      loginStatus: event.status,
    ));
  }

  void emailChanged(String email) {
    add(EmailChanged(
      email: email,
      status: LoginStatus.touched,
    ));
  }

  void passwordChanged(String password) {
    add(PasswordChanged(
      password: password,
      status: LoginStatus.touched,
    ));
  }

  Future<void> submit() async {
    add(FormIsLoading(
      status: LoginStatus.loading,
    ));

    //Simulate network call
    await Future.delayed(const Duration(seconds: 4));

    add(FormSubmitted(
      status: LoginStatus.posted,
    ));
  }
}

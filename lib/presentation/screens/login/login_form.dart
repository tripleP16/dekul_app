import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/password.dart';
import 'package:communitary_service_app/presentation/shared/widgets/error_snackbar.dart';
import 'package:communitary_service_app/presentation/shared/widgets/sucess_snackbar.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:formz/formz.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key, Random? seed}) : seed = seed ?? Random();

  final Random seed;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class LoginFormState with FormzMixin {
  LoginFormState({
    Email? email,
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
  }) : email = email ?? Email.pure();

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;

  LoginFormState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
  }) {
    return LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  @override
  List<FormzInput> get inputs => [email, password];
}

class _LoginFormState extends State<LoginForm> {
  final _key = GlobalKey<FormState>();
  late LoginFormState _state;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  void _onEmailChanged() {
    setState(() {
      _state = _state.copyWith(email: Email.dirty(_emailController.text));
    });
  }

  void _onPasswordChanged() {
    setState(() {
      _state = _state.copyWith(
        password: Password.dirty(_passwordController.text),
      );
    });
  }

  Future<void> _submitForm() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (widget.seed.nextInt(2) == 0) throw Exception();
  }

  void _resetForm() {
    _key.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
    setState(
      () => _state = LoginFormState(),
    );
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    setState(
      () => _state = _state.copyWith(status: FormzSubmissionStatus.inProgress),
    );

    try {
      await _submitForm();
      _state = _state.copyWith(status: FormzSubmissionStatus.success);
    } catch (_) {
      _state = _state.copyWith(status: FormzSubmissionStatus.failure);
    }

    if (!mounted) return;

    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_state.status.isSuccess
          ? const SuccessSnackBar(
              content: Text("¡Inicio de sesión exitoso! 🎉"),
            )
          : const ErrorSnackBar(
              content: Text("Hubo un error, intentelo de nuevo."),
            ));
    if (_state.status.isSuccess) _resetForm();
  }

  @override
  void initState() {
    super.initState();
    _state = LoginFormState();
    _emailController = TextEditingController(text: _state.email.value)
      ..addListener(_onEmailChanged);
    _passwordController = TextEditingController(text: _state.password.value)
      ..addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              key: const Key('loginForm_emailInput'),
              controller: _emailController,
              validator: (value) => _state.email.validator(value ?? '')?.text(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              key: const Key('loginForm_passwordInput'),
              controller: _passwordController,
              validator: (value) =>
                  _state.password.validator(value ?? '')?.text(),
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
                errorMaxLines: 2,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _state.status.isInProgress
                ? const CircularProgressIndicator()
                : FilledButton(
                    key: const Key('loginForm_submit'),
                    onPressed: _onSubmit,
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(double.infinity,40))
                    ), 
                    child: const Text('Continuar'),
                  ),
          ],
        ));
  }
}

extension on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.invalid:
        return 'Contraseña invalidad';
      case PasswordValidationError.empty:
        return 'Por favor introduzca una contraseña';
    }
  }
}

extension on EmailValidationError {
  String text() {
    switch (this) {
      case EmailValidationError.empty:
        return 'Por favor introduzca un correo electrónico';
      case EmailValidationError.invalid:
        return 'Correo invalido';
    }
  }
}

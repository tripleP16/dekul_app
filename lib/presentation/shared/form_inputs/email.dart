import 'package:formz/formz.dart';

// Define input validation errors
enum EmailInputError { empty, format }

// Extend FormzInput and provide the input type and error type.

class Email extends FormzInput<String, EmailInputError> {
  // Call super.pure to represent an unmodified form input.
  const Email.pure() : super.pure('');

  static final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  // Call super.dirty to represent a modified form input.
  const Email.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == EmailInputError.empty) {
      return 'El email es obligatorio';
    }

    if (displayError == EmailInputError.format) {
      return 'El correo no tiene el formato correcto';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailInputError.empty;

    if (!emailRegex.hasMatch(value)) return EmailInputError.format;

    return null;
  }
}

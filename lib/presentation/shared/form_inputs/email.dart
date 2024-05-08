import 'package:formz/formz.dart';

enum EmailValidationError {
  invalid,
  empty
}

class Email extends FormzInput<String, EmailValidationError> with FormzInputErrorCacheMixin{
  Email.pure([super.value = '']) : super.pure();

  Email.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$'
  );

  @override
    EmailValidationError? validator(String value) {
      if (value.isEmpty){
        return EmailValidationError.empty;
      } else if (!_emailRegExp.hasMatch(value)) {
        return EmailValidationError.invalid;
      }

      return null;
    }
}

extension on EmailValidationError{
  String text() {
    switch (this) {
      case EmailValidationError.empty:
        return 'Por favor introduzca un correo electrónico';
      case EmailValidationError.invalid:
        return '';
    }
  }
}

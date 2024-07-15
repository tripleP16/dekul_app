import 'package:formz/formz.dart';

enum PhoneNumberError {
  invalidPhoneNumber,
  required,
}

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _phoneNumberRegExp = RegExp(r'^\+(?:[0-9] ?){6,14}[0-9]$');

  @override
  PhoneNumberError? validator(String? value) {
    if (value == null || value.isEmpty) return PhoneNumberError.required;
    return _phoneNumberRegExp.hasMatch(value)
        ? null
        : PhoneNumberError.invalidPhoneNumber;
  }

  String? get errorMessage {
    if (displayError == PhoneNumberError.required) {
      return 'El numero de telefono es requerido';
    }
    if (displayError == PhoneNumberError.invalidPhoneNumber) {
      return 'El numero de telefono es invalido';
    }

    return null;
  }
}

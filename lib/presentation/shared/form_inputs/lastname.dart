import 'package:formz/formz.dart';

enum LastnameError { required }

class Lastname extends FormzInput<String, LastnameError> {
  const Lastname.pure() : super.pure('');

  const Lastname.dirty(String value) : super.dirty(value);

  @override
  LastnameError? validator(String value) {
    if (value.isEmpty) {
      return LastnameError.required;
    }
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == LastnameError.required) {
      return 'El apellido es requerido';
    }

    return null;
  }
}

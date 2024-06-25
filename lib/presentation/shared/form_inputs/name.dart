import 'package:formz/formz.dart';

enum NameError { required }

class Name extends FormzInput<String, NameError> {
  const Name.pure() : super.pure('');

  const Name.dirty(String value) : super.dirty(value);

  @override
  NameError? validator(String value) {
    if (value.isEmpty) {
      return NameError.required;
    }
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.required) return 'El nombre es requerido';

    return null;
  }
}

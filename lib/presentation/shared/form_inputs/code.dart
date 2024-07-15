import 'package:formz/formz.dart';

enum CodeInputError { empty, invalid }

class Code extends FormzInput<String, CodeInputError> {
  const Code.pure() : super.pure('');

  const Code.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (value.isEmpty) {
      return 'El codigo no puede estar vacio';
    }

    if (value.length < 6) {
      return 'El codigo debe tener al menos 6 caracteres';
    }

    return null;
  }

  @override
  CodeInputError? validator(String value) {
    if (value.isEmpty) {
      return CodeInputError.empty;
    }

    if (value.length < 6) {
      return CodeInputError.invalid;
    }

    return null;
  }
}

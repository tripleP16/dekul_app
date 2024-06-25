import 'package:formz/formz.dart';

enum Gender {
  male('M'),
  female('F'),
  pure('');

  final String value;
  const Gender(this.value);
}

enum GenderError {
  required,
}

class GenderInput extends FormzInput<Gender, GenderError> {
  const GenderInput.pure() : super.pure(Gender.pure);

  const GenderInput.dirty(Gender value) : super.dirty(value);

  @override
  GenderError? validator(Gender value) {
    if (value.value.isEmpty) {
      return GenderError.required;
    }

    if (value == Gender.pure) return GenderError.required;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == GenderError.required) return 'El genero es requerido';

    return null;
  }
}

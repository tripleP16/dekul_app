import 'package:formz/formz.dart';

enum AllergyError { required }

class Allergy extends FormzInput<String, AllergyError> {
  const Allergy.pure() : super.pure('');

  const Allergy.dirty(String value) : super.dirty(value);

  @override
  AllergyError? validator(String value) {
    if (value.isEmpty) {
      return AllergyError.required;
    }
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == AllergyError.required) {
      return 'El nombre de la alergia es obligatorio.';
    }

    return null;
  }
}

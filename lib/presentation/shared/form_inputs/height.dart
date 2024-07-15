import 'package:formz/formz.dart';

enum HeightError { required, invalid }

class Height extends FormzInput<int, HeightError> {
  const Height.pure() : super.pure(0);

  const Height.dirty(int value) : super.dirty(value);

  @override
  HeightError? validator(int value) {
    if (value == 0) {
      return HeightError.required;
    }
    if (value < 0 || value > 270) {
      return HeightError.invalid;
    }
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == HeightError.required) {
      return 'La altura es requerida';
    }

    if (displayError == HeightError.invalid) {
      return 'La altura debe ser mayor a 0 y menor a 270';
    }

    return null;
  }
}

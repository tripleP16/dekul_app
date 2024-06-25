import 'package:formz/formz.dart';

enum WeightErrror { invalid, required }

class Weight extends FormzInput<double, WeightErrror> {
  const Weight.pure() : super.pure(0);

  const Weight.dirty([double value = 0]) : super.dirty(value);

  @override
  WeightErrror? validator(double? value) {
    if (value == null) {
      return WeightErrror.required;
    }
    if (value <= 0) {
      return WeightErrror.invalid;
    }
    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == WeightErrror.required) {
      return 'El peso es requerido';
    }

    if (displayError == WeightErrror.invalid) {
      return 'El peso debe ser mayor a 0';
    }

    return null;
  }
}

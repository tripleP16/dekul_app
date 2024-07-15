import 'package:formz/formz.dart';

enum BirthdayError { required, isTooOld, tooYoung }

class Birthday extends FormzInput<DateTime?, BirthdayError> {
  const Birthday.pure() : super.pure(null);

  const Birthday.dirty(DateTime? value) : super.dirty(value);
  @override
  BirthdayError? validator(DateTime? value) {
    if (value == null) return BirthdayError.required;

    if (DateTime.now().year - value.year >= 21) return BirthdayError.isTooOld;

    if (DateTime.now().year < value.year) return BirthdayError.tooYoung;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == BirthdayError.required) {
      return 'La fecha de nacimiento es requerida';
    }

    if (displayError == BirthdayError.isTooOld) {
      return 'El beneficiario debe ser menor de 21 años';
    }

    if (displayError == BirthdayError.tooYoung) {
      return 'El año de nacimiento debe ser mayor al actual';
    }

    return null;
  }
}

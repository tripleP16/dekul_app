import 'package:communitary_service_app/presentation/shared/form_inputs/code.dart';

class ValidateCodeState {
  final Code code;
  final bool isValid;

  ValidateCodeState({required this.code, required this.isValid});

  factory ValidateCodeState.initial() {
    return ValidateCodeState(
      code: const Code.pure(),
      isValid: false,
    );
  }

  ValidateCodeState copyWith({Code? code, bool? isValid}) {
    return ValidateCodeState(
      code: code ?? this.code,
      isValid: isValid ?? this.isValid,
    );
  }
}

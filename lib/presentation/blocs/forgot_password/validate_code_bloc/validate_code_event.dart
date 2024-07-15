abstract class ValidateCodeEvent {}

class EditCode extends ValidateCodeEvent {
  final String code;

  EditCode({
    required this.code,
  });
}


class ValidateCodeReset extends ValidateCodeEvent {}

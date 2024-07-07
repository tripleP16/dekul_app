abstract class CreateCodeEvent {}

class CreateCodeEmailInput extends CreateCodeEvent {
  final String email;

  CreateCodeEmailInput({required this.email});
}

class CreateCodePosted extends CreateCodeEvent {}

class CreateCodeError extends CreateCodeEvent {}

class CreateCodeReset extends CreateCodeEvent {}
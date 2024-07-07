import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';

enum CreateCodeState { empty, loading, success, error, valid }

class CreateCodeStateInput {
  final Email email;
  final String? error;
  final CreateCodeState state;

  final bool isPosted;

  const CreateCodeStateInput({
    required this.email,
    required this.isPosted,
    required this.error,
    required this.state,
  });

  factory CreateCodeStateInput.empty() {
    return const CreateCodeStateInput(
      email: Email.pure(),
      isPosted: false,
      error: null,
      state: CreateCodeState.empty,
    );
  }

  CreateCodeStateInput copyWith(
      {Email? email, bool? isPosted, String? error, CreateCodeState? state}) {
    return CreateCodeStateInput(
      email: email ?? this.email,
      isPosted: isPosted ?? this.isPosted,
      error: error ?? this.error,
      state: state ?? this.state,
    );
  }
}

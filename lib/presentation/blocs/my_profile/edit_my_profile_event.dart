import 'package:communitary_service_app/presentation/blocs/my_profile/edit_my_profile_state.dart';

abstract class EditMyProfileEvent {}

class InputNameProfileEvent extends EditMyProfileEvent {
  InputNameProfileEvent({required this.name});
  final String name;
}

class InputLastNameProfileEvent extends EditMyProfileEvent {
  final String lastname;

  InputLastNameProfileEvent({required this.lastname});
}

class InputEmailProfileEvent extends EditMyProfileEvent {
  final String email;

  InputEmailProfileEvent({required this.email});
}

class PostChangeProfileEvent extends EditMyProfileEvent {
  final EditMyProfileFormState state;

  PostChangeProfileEvent({required this.state});
}

import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/user_state.dart';

abstract class UserEvent {}

class InputNameUserEvent extends UserEvent {
  final String name;

  InputNameUserEvent({required this.name});
}

class InputLastnameUserEvent extends UserEvent {
  final String lastname;

  InputLastnameUserEvent({required this.lastname});
}

class InputEmailUserEvent extends UserEvent {
  final String email;

  InputEmailUserEvent({required this.email});
}

class InputPrivilegeAddedEvent extends UserEvent {
  final PrivilegeModel privilege;

  InputPrivilegeAddedEvent({required this.privilege});
}

class InputPrivilegeRemovedEvent extends UserEvent {
  final PrivilegeModel privilege;

  InputPrivilegeRemovedEvent({required this.privilege});
}

class PostCreateUserEvent extends UserEvent {
  final UserFormState formState;

  PostCreateUserEvent({required this.formState});
}

class StartEditingUserEvent extends UserEvent {
  final String id;

  StartEditingUserEvent({required this.id});
}

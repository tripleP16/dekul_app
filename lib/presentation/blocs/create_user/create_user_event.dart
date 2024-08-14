import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/create_user_state.dart';

abstract class CreateUserEvent {}

class InputNameUserEvent extends CreateUserEvent {
  final String name;

  InputNameUserEvent({required this.name});
}

class InputLastnameUserEvent extends CreateUserEvent {
  final String lastname;

  InputLastnameUserEvent({required this.lastname});
}

class InputEmailUserEvent extends CreateUserEvent {
  final String email;

  InputEmailUserEvent({required this.email});
}

class InputPrivilegeAddedEvent extends CreateUserEvent {
  final PrivilegeModel privilege;

  InputPrivilegeAddedEvent({required this.privilege});
}

class InputPrivilegeRemovedEvent extends CreateUserEvent {
  final PrivilegeModel privilege;

  InputPrivilegeRemovedEvent({required this.privilege});
}

class PostCreateUserEvent extends CreateUserEvent {
  final CreateUserFormState formState;

  PostCreateUserEvent({required this.formState});
}

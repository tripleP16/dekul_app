import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/create_user_event.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/create_user_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final UsersRepository usersRepository;
  CreateUserBloc(this.usersRepository) : super(CreateUserState.initial()) {
    on<InputNameUserEvent>(_changeName);
    on<InputLastnameUserEvent>(_changeLastname);
    on<InputEmailUserEvent>(_changeEmail);
    on<InputPrivilegeAddedEvent>(_addPrivilege);
    on<InputPrivilegeRemovedEvent>(_removePrivilege);
    on<PostCreateUserEvent>(_postCreateUser);
  }

  void _changeName(InputNameUserEvent event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(name: Name.dirty(event.name)));
    _isFormValid(emit);
  }

  void _changeLastname(
    InputLastnameUserEvent event,
    Emitter<CreateUserState> emit,
  ) {
    emit(state.copyWith(lastname: Lastname.dirty(event.lastname)));
    _isFormValid(emit);
  }

  void _changeEmail(InputEmailUserEvent event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
    _isFormValid(emit);
  }

  void _addPrivilege(
    InputPrivilegeAddedEvent event,
    Emitter<CreateUserState> emit,
  ) {
    final exists = state.privileges.any((e) => e.id == event.privilege.id);
    if (exists) return;

    emit(state.copyWith(privileges: [...state.privileges, event.privilege]));

    _isFormValid(emit);
  }

  void _removePrivilege(
    InputPrivilegeRemovedEvent event,
    Emitter<CreateUserState> emit,
  ) {
    emit(state.copyWith(
      privileges:
          state.privileges.where((e) => e.id != event.privilege.id).toList(),
    ));

    _isFormValid(emit);
  }

  void _isFormValid(
    Emitter<CreateUserState> emit,
  ) {
    final isValid = Formz.validate([
          Name.dirty(state.name.value),
          Lastname.dirty(state.lastname.value),
          Email.dirty(state.email.value),
        ]) &&
        state.privileges.isNotEmpty;

    if (isValid) {
      emit(state.copyWith(formState: CreateUserFormState.isValid));
    } else {
      emit(state.copyWith(formState: CreateUserFormState.isNotValid));
    }
  }

  void _postCreateUser(
    PostCreateUserEvent event,
    Emitter<CreateUserState> emit,
  ) {
    if (state.formState == CreateUserFormState.isNotValid) return;

    emit(state.copyWith(formState: event.formState));
  }

  void onEditName(String name) {
    add(InputNameUserEvent(name: name));
  }

  void onEditLastname(String lastname) {
    add(InputLastnameUserEvent(lastname: lastname));
  }

  void onEditEmail(String email) {
    add(InputEmailUserEvent(email: email));
  }

  void onAddPrivilege(PrivilegeModel privilege) {
    add(InputPrivilegeAddedEvent(privilege: privilege));
  }

  void onRemovePrivilege(PrivilegeModel privilege) {
    add(InputPrivilegeRemovedEvent(privilege: privilege));
  }

  Future<void> onSubmit() async {
    add(PostCreateUserEvent(formState: CreateUserFormState.isLoading));
    try {
      await usersRepository.createUser(state.toDomain());
      add(PostCreateUserEvent(formState: CreateUserFormState.posted));
      appRouter.go('/home');
    } catch (e) {
      add(PostCreateUserEvent(formState: CreateUserFormState.isValid));
      rethrow;
    }
  }
}

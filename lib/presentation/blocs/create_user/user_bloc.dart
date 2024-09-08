import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/user_event.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/user_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;
  UserBloc(this.usersRepository) : super(UserState.initial()) {
    on<InputNameUserEvent>(_changeName);
    on<InputLastnameUserEvent>(_changeLastname);
    on<InputEmailUserEvent>(_changeEmail);
    on<InputPrivilegeAddedEvent>(_addPrivilege);
    on<InputPrivilegeRemovedEvent>(_removePrivilege);
    on<PostCreateUserEvent>(_postCreateUser);
    on<StartEditingUserEvent>(_startEditing);
  }

  Future<void> _startEditing(
      StartEditingUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isEditing: true));
    emit(
        state.copyWith(errorMessage: null, formState: UserFormState.isLoadingToEdit));
    try {
      final user = await usersRepository.fetchUser(event.id);
      emit(state.copyWith(
        name: Name.dirty(user.name),
        lastname: Lastname.dirty(user.lastname),
        email: Email.dirty(user.email),
        privileges: user.privileges ?? [],
        formState: UserFormState.isValid,
        isEditing: true,
        id: () => event.id,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: () => e.toString()));
    }
  }

  void _changeName(InputNameUserEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(name: Name.dirty(event.name)));
    _isFormValid(emit);
  }

  void _changeLastname(
    InputLastnameUserEvent event,
    Emitter<UserState> emit,
  ) {
    emit(state.copyWith(lastname: Lastname.dirty(event.lastname)));
    _isFormValid(emit);
  }

  void _changeEmail(InputEmailUserEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
    _isFormValid(emit);
  }

  void _addPrivilege(
    InputPrivilegeAddedEvent event,
    Emitter<UserState> emit,
  ) {
    final exists = state.privileges.any((e) => e.id == event.privilege.id);
    if (exists) return;

    emit(state.copyWith(privileges: [...state.privileges, event.privilege]));

    _isFormValid(emit);
  }

  void _removePrivilege(
    InputPrivilegeRemovedEvent event,
    Emitter<UserState> emit,
  ) {
    emit(state.copyWith(
      privileges:
          state.privileges.where((e) => e.id != event.privilege.id).toList(),
    ));

    _isFormValid(emit);
  }

  void _isFormValid(
    Emitter<UserState> emit,
  ) {
    final isValid = Formz.validate([
          Name.dirty(state.name.value),
          Lastname.dirty(state.lastname.value),
          Email.dirty(state.email.value),
        ]) &&
        state.privileges.isNotEmpty;

    if (isValid) {
      emit(state.copyWith(formState: UserFormState.isValid));
    } else {
      emit(state.copyWith(formState: UserFormState.isNotValid));
    }
  }

  void _postCreateUser(
    PostCreateUserEvent event,
    Emitter<UserState> emit,
  ) {
    if (state.formState == UserFormState.isNotValid) return;

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

  void onStartEditing(String id) {
    add(StartEditingUserEvent(id: id));
  }

  Future<void> onSubmit() async {
    add(PostCreateUserEvent(formState: UserFormState.isLoading));
    try {
      if (!state.isEditing) {
        await usersRepository.createUser(
          state.toDomain(),
        );
      } else {
        await usersRepository.updateUser(
          state.toUpdateDomain(),
        );
      }
      add(PostCreateUserEvent(formState: UserFormState.posted));
      appRouter.go('/home');
    } catch (e) {
      add(PostCreateUserEvent(formState: UserFormState.isValid));
      rethrow;
    }
  }
}

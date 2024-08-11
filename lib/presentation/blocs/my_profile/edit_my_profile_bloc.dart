import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/repositories/my_profile/my_profile_repository.dart';
import 'package:communitary_service_app/presentation/blocs/my_profile/edit_my_profile_event.dart';
import 'package:communitary_service_app/presentation/blocs/my_profile/edit_my_profile_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class EditMyProfileBloc extends Bloc<EditMyProfileEvent, EditMyProfileState> {
  final MyProfileRepository repository;
  EditMyProfileBloc(this.repository) : super(EditMyProfileState.initial()) {
    on<InputNameProfileEvent>(_changeName);
    on<InputLastNameProfileEvent>(_changeLastName);
    on<InputEmailProfileEvent>(_changeEmail);
    on<PostChangeProfileEvent>(_postChangeProfile);
    loadProfile();
  }

  void _postChangeProfile(
    PostChangeProfileEvent event,
    Emitter<EditMyProfileState> emit,
  ) async {
    emit(state.copyWith(
      formState: event.state,
    ));
  }

  void _changeEmail(
    InputEmailProfileEvent event,
    Emitter<EditMyProfileState> emit,
  ) {
    emit(state.copyWith(email: Email.dirty(event.email)));
    _isFormValid(emit);
  }

  void _changeLastName(
    InputLastNameProfileEvent event,
    Emitter<EditMyProfileState> emit,
  ) {
    emit(state.copyWith(lastname: Lastname.dirty(event.lastname)));
    _isFormValid(emit);
  }

  void _changeName(
    InputNameProfileEvent event,
    Emitter<EditMyProfileState> emit,
  ) {
    emit(state.copyWith(name: Name.dirty(event.name)));
    _isFormValid(emit);
  }

  void _isFormValid(
    Emitter<EditMyProfileState> emit,
  ) {
    final isValid = Formz.validate([
      Name.dirty(state.name.value),
      Lastname.dirty(state.lastname.value),
      Email.dirty(state.email.value),
    ]);
    emit(state.copyWith(
      formState: isValid
          ? EditMyProfileFormState.isValid
          : EditMyProfileFormState.isNotValid,
    ));
  }

  void onNameChanged(String name) {
    add(InputNameProfileEvent(name: name));
  }

  void onLastNameChanged(String lastname) {
    add(InputLastNameProfileEvent(lastname: lastname));
  }

  void onEmailChanged(String email) {
    add(InputEmailProfileEvent(email: email));
  }

  Future<void> submit() async {
    add(PostChangeProfileEvent(state: EditMyProfileFormState.loading));
    try {
      await repository.update(state.toDomain());
      add(PostChangeProfileEvent(state: EditMyProfileFormState.posted));
      appRouter.pop();
    } catch (e) {
      add(PostChangeProfileEvent(state: EditMyProfileFormState.isValid));
      rethrow;
    }
  }

  Future<void> loadProfile() async {
    try {
      add(PostChangeProfileEvent(state: EditMyProfileFormState.retrieving));
      final profile = await repository.getMyProfile();
      add(InputNameProfileEvent(name: profile.name));
      add(InputLastNameProfileEvent(lastname: profile.lastname));
      add(InputEmailProfileEvent(email: profile.email));
    } catch (e) {
      add(PostChangeProfileEvent(state: EditMyProfileFormState.error));
    }
  }
}

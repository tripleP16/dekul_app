import 'package:communitary_service_app/domain/models/my_profile/update_my_profile_model.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';

enum EditMyProfileFormState {
  loading,
  posted,
  error,
  pure,
  isValid,
  isNotValid,
  retrieving,
}

class EditMyProfileState {
  final Name name;
  final Lastname lastname;
  final Email email;
  final EditMyProfileFormState formState;

  EditMyProfileState(
      {required this.name,
      required this.lastname,
      required this.email,
      required this.formState});

  bool get isValid => formState == EditMyProfileFormState.isValid;

  bool get isLoading => formState == EditMyProfileFormState.loading;

  bool get isErrored => formState == EditMyProfileFormState.error;

  bool get isRetrieving => formState == EditMyProfileFormState.retrieving;

  UpdateMyProfileModel toDomain() {
    return UpdateMyProfileModel(
      name: name.value,
      lastname: lastname.value,
      email: email.value,
    );
  }

  factory EditMyProfileState.initial() => EditMyProfileState(
        name: const Name.pure(),
        lastname: const Lastname.pure(),
        email: const Email.pure(),
        formState: EditMyProfileFormState.pure,
      );

  EditMyProfileState copyWith(
      {Name? name,
      Lastname? lastname,
      Email? email,
      EditMyProfileFormState? formState}) {
    return EditMyProfileState(
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        formState: formState ?? this.formState);
  }
}

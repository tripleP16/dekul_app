import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/domain/models/users/create_user_model.dart';
import 'package:communitary_service_app/domain/models/users/update_user_model.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

enum UserFormState {
  pure,
  isValid,
  isNotValid,
  posted,
  isLoading,
  isLoadingToEdit
}

class UserState {
  final Name name;
  final Lastname lastname;
  final Email email;
  final UserFormState formState;
  final String? errorMessage;
  final List<PrivilegeModel> privileges;
  final bool isEditing;
  final String? id;
  UserState({
    required this.name,
    required this.lastname,
    required this.email,
    required this.formState,
    required this.privileges,
    this.errorMessage,
    this.isEditing = false,
    this.id,
  });

  factory UserState.initial() {
    return UserState(
      name: const Name.pure(),
      lastname: const Lastname.pure(),
      email: const Email.pure(),
      formState: UserFormState.pure,
      privileges: [],
    );
  }

  bool get isValid => formState == UserFormState.isValid;

  bool get isNotValid => formState == UserFormState.isNotValid;

  UserState copyWith({
    Name? name,
    Lastname? lastname,
    Email? email,
    UserFormState? formState,
    ValueGetter<String?>? errorMessage,
    List<PrivilegeModel>? privileges,
    bool? isEditing,
    ValueGetter<String?>? id,
  }) {
    return UserState(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      formState: formState ?? this.formState,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      privileges: privileges ?? this.privileges,
      isEditing: isEditing ?? this.isEditing,
      id: id != null ? id() : this.id,
    );
  }

  List<CustomChipViewModel> getCustomChipViewModels() {
    return privileges
        .map((privilege) => CustomChipViewModel(
              label: privilege.name,
              value: privilege.id,
            ))
        .toList();
  }

  CreateUserModel toDomain() {
    return CreateUserModel(
      name: name.value,
      lastname: lastname.value,
      email: email.value,
      privileges: privileges,
    );
  }

  UpdateUserModel toUpdateDomain() {
    return UpdateUserModel(
      id: id ?? '',
      name: name.value,
      lastname: lastname.value,
      email: email.value,
      privileges: privileges,
    );
  }
}

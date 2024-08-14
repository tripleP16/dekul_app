import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/domain/models/users/create_user_model.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/email.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

enum CreateUserFormState {
  pure,
  isValid,
  isNotValid,
  posted,
  isLoading,
}

class CreateUserState {
  final Name name;
  final Lastname lastname;
  final Email email;
  final CreateUserFormState formState;
  final String? errorMessage;
  final List<PrivilegeModel> privileges;

  CreateUserState({
    required this.name,
    required this.lastname,
    required this.email,
    required this.formState,
    required this.privileges,
    this.errorMessage,
  });

  factory CreateUserState.initial() {
    return CreateUserState(
      name: const Name.pure(),
      lastname: const Lastname.pure(),
      email: const Email.pure(),
      formState: CreateUserFormState.pure,
      privileges: [],
    );
  }

  bool get isValid => formState == CreateUserFormState.isValid;

  bool get isNotValid => formState == CreateUserFormState.isNotValid;

  CreateUserState copyWith({
    Name? name,
    Lastname? lastname,
    Email? email,
    CreateUserFormState? formState,
    ValueGetter<String?>? errorMessage,
    List<PrivilegeModel>? privileges,
  }) {
    return CreateUserState(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      formState: formState ?? this.formState,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      privileges: privileges ?? this.privileges,
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
}

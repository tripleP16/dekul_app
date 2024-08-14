import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/custom_chip_view_model.dart';
import 'package:flutter/material.dart';

class PrivilegesState {
  final List<PrivilegeModel> privileges;
  final String? errorMessage;
  final bool isLoading;

  PrivilegesState(
      {required this.privileges, required this.isLoading, this.errorMessage});

  factory PrivilegesState.initial() => PrivilegesState(
        privileges: [],
        isLoading: false,
        errorMessage: null,
      );

  List<CustomChipViewModel> getCustomChipViewModels() {
    return privileges
        .map((privilege) => CustomChipViewModel(
              label: privilege.name,
              value: privilege.id,
            ))
        .toList();
  }

  PrivilegesState copyWith(
      {List<PrivilegeModel>? privileges,
      ValueGetter<String?>? errorMessage,
      bool? isLoading}) {
    return PrivilegesState(
        privileges: privileges ?? this.privileges,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
        isLoading: isLoading ?? this.isLoading);
  }
}

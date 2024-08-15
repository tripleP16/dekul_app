import 'package:communitary_service_app/domain/models/medical_history/medical_history_model.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/height.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/weight.dart';
import 'package:flutter/material.dart';

enum UpdateMedicalHistoryFormState {
  loading,
  posted,
  error,
  pure,
  isValid,
  isNotValid
}

class UpdateMedicalHistoryState {
  final Height height;
  final Weight weight;
  final UpdateMedicalHistoryFormState formState;
  final String? errorMessage;

  UpdateMedicalHistoryState(
      {required this.height,
      required this.weight,
      required this.formState,
      this.errorMessage});

  UpdateMedicalHistoryState copyWith({
    Height? height,
    Weight? weight,
    UpdateMedicalHistoryFormState? formState,
    ValueGetter<String?>? errorMessage,
  }) {
    return UpdateMedicalHistoryState(
        height: height ?? this.height,
        weight: weight ?? this.weight,
        formState: formState ?? this.formState,
        errorMessage:
            errorMessage != null ? errorMessage() : this.errorMessage);
  }

  bool get isValid => formState == UpdateMedicalHistoryFormState.isValid;
  bool get isLoading => formState == UpdateMedicalHistoryFormState.loading;
  bool get isNotValid => formState == UpdateMedicalHistoryFormState.isNotValid;

  MedicalHistoryModel toDomain() {
    return MedicalHistoryModel(
      height: height.value,
      weight: weight.value,
    );
  }

  factory UpdateMedicalHistoryState.initial() => UpdateMedicalHistoryState(
        height: const Height.pure(),
        weight: const Weight.pure(),
        formState: UpdateMedicalHistoryFormState.pure,
        errorMessage: null,
      );
}

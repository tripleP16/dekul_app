import 'package:communitary_service_app/domain/models/beneficiaries/get_beneficiary_model.dart';
import 'package:flutter/material.dart';

enum BeneficiaryDetailStatus {
  loading,
  loaded,
  error,
  init,
}

class BeneficiaryDetailState {
  final BeneficiaryDetailStatus status;
  final GetBeneficiaryModel? model;
  final String? errorMessage;

  BeneficiaryDetailState({required this.status, this.model, this.errorMessage});

  factory BeneficiaryDetailState.initial() =>
      BeneficiaryDetailState(status: BeneficiaryDetailStatus.init);

  BeneficiaryDetailState copyWith(
      {BeneficiaryDetailStatus? status,
      ValueGetter<GetBeneficiaryModel?>? model,
      ValueGetter<String?>? errorMessage}) {
    return BeneficiaryDetailState(
        status: status ?? this.status,
        model: model != null ? model() : this.model,
        errorMessage:
            errorMessage != null ? errorMessage() : this.errorMessage);
  }
}

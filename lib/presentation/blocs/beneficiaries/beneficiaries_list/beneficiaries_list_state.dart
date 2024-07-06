import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';

class BeneficiariesListState {
  final ListPaginatedModel<BeneficiaryModel> paginatedBeneficiaries;
  final List<BeneficiaryModel> totalBeneficiaries;
  final bool isLoading;
  final String? searchQuery;
  final String? error;

  BeneficiariesListState({
    required this.paginatedBeneficiaries,
    required this.totalBeneficiaries,
    required this.isLoading,
    this.error,
    this.searchQuery,
  });

  BeneficiariesListState copyWith({
    ListPaginatedModel<BeneficiaryModel>? paginatedBeneficiaries,
    List<BeneficiaryModel>? totalBeneficiaries,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return BeneficiariesListState(
      paginatedBeneficiaries:
          paginatedBeneficiaries ?? this.paginatedBeneficiaries,
      totalBeneficiaries: totalBeneficiaries ?? this.totalBeneficiaries,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  factory BeneficiariesListState.initial() {
    return BeneficiariesListState(
      isLoading: false,
      paginatedBeneficiaries:
          ListPaginatedModel<BeneficiaryModel>.empty(hasNextPage: true),
      totalBeneficiaries: [],
      error: null,
      searchQuery: null,
    );
  }
}

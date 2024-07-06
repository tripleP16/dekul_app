import 'package:communitary_service_app/domain/datasources/beneficiaries/beneficiaries_datasource.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';

import '../../../domain/repositories/beneficiaries/beneficiaries_repository.dart';

class BeneficiariesRepositoryImpl implements BeneficiariesRepository {
  final BeneficiariesDatasource _beneficiariesDataSource;

  BeneficiariesRepositoryImpl(this._beneficiariesDataSource);

  @override
  Future<void> registerBeneficiary(BeneficiaryModel beneficiaryModel) {
    return _beneficiariesDataSource.registerBeneficiary(beneficiaryModel);
  }

  @override
  Future<ListPaginatedModel<BeneficiaryModel>>
      getBeneficiariesWithSearchPaginated(PaginationAndSearchModel query) {
    return _beneficiariesDataSource.getBeneficiariesWithSearchPaginated(query);
  }
}

import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';

import '../../models/shared/pagination_and_search_model.dart';

abstract class BeneficiariesDatasource {
  Future<void> registerBeneficiary(BeneficiaryModel beneficiaryModel);

  Future<ListPaginatedModel<BeneficiaryModel>>
      getBeneficiariesWithSearchPaginated(
    PaginationAndSearchModel query,
  );
}

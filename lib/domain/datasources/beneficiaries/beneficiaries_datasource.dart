import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/get_beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/medical_history/medical_history_model.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';

import '../../models/shared/pagination_and_search_model.dart';

abstract class BeneficiariesDatasource {
  Future<void> registerBeneficiary(BeneficiaryModel beneficiaryModel);

  Future<ListPaginatedModel<BeneficiaryModel>>
      getBeneficiariesWithSearchPaginated(
    PaginationAndSearchModel query,
  );

  Future<GetBeneficiaryModel> getBeneficiary(String beneficiaryId);

  Future<void> addMedicalHistory(String id, MedicalHistoryModel medicalHistory);
}

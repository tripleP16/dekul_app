import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';

import '../../domain/models/beneficiaries/beneficiary_model.dart';
import '../models/beneficiaries/get_beneficiaries_data_model.dart';
import '../models/shared/list_paginated_data_model.dart';

class PaginatedListBeneficiariesMapper {
  static ListPaginatedModel<BeneficiaryModel> fromDataModel(
      ListPaginatedDataModel<GetBeneficiariesDataModel> dataModel) {
    return ListPaginatedModel(
      totalPages: dataModel.totalPages,
      hasNextPage: dataModel.hasNextPage,
      hasPreviousPage: dataModel.hasPreviousPage,
      currentPage: dataModel.currentPage,
      pageSize: dataModel.pageSize,
      data: dataModel.data.map((e) => e.toDomain()).toList(),
    );
  }
}

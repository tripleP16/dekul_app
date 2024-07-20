import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/users/users_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/list_paginated_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/users/users_data_model.dart';

class PaginatedListUsersMapper {
  static ListPaginatedModel<UsersModel> fromDataModel(
    ListPaginatedDataModel<UsersDataModel> dataModel,
  ) {
    return ListPaginatedModel(
      totalPages: dataModel.totalPages,
      hasNextPage: dataModel.hasNextPage,
      hasPreviousPage: dataModel.hasPreviousPage,
      pageSize: dataModel.pageSize,
      currentPage: dataModel.currentPage,
      data: dataModel.data.map((e) => e.toDomain()).toList(),
    );
  }
}

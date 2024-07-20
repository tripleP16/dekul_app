import 'package:communitary_service_app/domain/datasources/users/users_datasource.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/domain/models/users/users_model.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDatasource usersDatasource;

  UsersRepositoryImpl({
    required this.usersDatasource,
  });
  @override
  Future<ListPaginatedModel<UsersModel>> fetchUsers(
      PaginationAndSearchModel model) {
    return usersDatasource.fetchUsers(model);
  }
}

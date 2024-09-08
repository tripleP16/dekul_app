import 'package:communitary_service_app/domain/datasources/users/users_datasource.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/domain/models/users/create_user_model.dart';
import 'package:communitary_service_app/domain/models/users/update_user_model.dart';
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

  @override
  Future<void> deleteUser(String userId) {
    return usersDatasource.deleteUser(userId);
  }

  @override
  Future<void> createUser(CreateUserModel model) {
    return usersDatasource.createUser(model);
  }

  @override
  Future<UsersModel> fetchUser(String userId) {
    return usersDatasource.fetchUser(userId);
  }

  @override
  Future<void> updateUser(UpdateUserModel model) {
    return usersDatasource.updateUser(model);
  }
}

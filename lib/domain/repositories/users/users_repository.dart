import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/domain/models/users/create_user_model.dart';
import 'package:communitary_service_app/domain/models/users/users_model.dart';

abstract class UsersRepository {
  Future<ListPaginatedModel<UsersModel>> fetchUsers(
    PaginationAndSearchModel model,
  );
  Future<void> deleteUser(
    String userId,
  );

  Future<void> createUser(
    CreateUserModel model,
  );
}

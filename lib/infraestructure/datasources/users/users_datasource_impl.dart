import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/users/users_datasource.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/domain/models/users/create_user_model.dart';
import 'package:communitary_service_app/domain/models/users/users_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/mappers/paginated_list_users_mapper.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/list_paginated_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/users/create_user_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/users/users_data_model.dart';
import 'package:dio/dio.dart';

class UsersDatasourceImpl implements UsersDatasource {
  final IApiService _apiService;

  UsersDatasourceImpl({
    required IApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<ListPaginatedModel<UsersModel>> fetchUsers(
      PaginationAndSearchModel model) async {
    try {
      final response = await _apiService.get(
        url: 'users',
        params: model.toJson(),
      );

      final baseResponse = BaseResponseDataModel<
          ListPaginatedDataModel<UsersDataModel>>.fromJson(
        response.data,
        (json) => ListPaginatedDataModel<UsersDataModel>.fromJson(
          json as Map<String, dynamic>,
          (json) => UsersDataModel.fromJson(json as Map<String, dynamic>),
        ),
      );

      final responseWithoutMap = baseResponse.data;

      return PaginatedListUsersMapper.fromDataModel(
        responseWithoutMap,
      );
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(
          message: 'Error en el servidor por favor intente mas tarde');
    }
  }

  String _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return 'No autorizado';
      case 404:
        return 'Usuario no encontrado';
      case 409:
        return 'Ya existe un usuario con ese email';
      case 400:
        return 'Error en el formulario por favor intente nuevamente';
      default:
        return 'Intente mas tarde';
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _apiService.delete(url: 'users/delete/$userId');
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(
          message: 'Error en el servidor por favor intente mas tarde');
    }
  }

  @override
  Future<void> createUser(CreateUserModel model) async {
    try {
      final dataModel = CreateUserDataModel.fromDomain(model);
      await _apiService.post(
        url: 'users/create',
        body: dataModel.toJson(),
      );
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(
          message: 'Error en el servidor por favor intente mas tarde');
    }
  }
}

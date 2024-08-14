import 'package:communitary_service_app/config/helpers/list_converter.dart';
import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/privileges/privileges_datasource.dart';
import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/privileges/privileges_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:dio/dio.dart';

class PrivilegesDatasourceImpl implements PrivilegesDatasource {
  final IApiService _apiService;

  PrivilegesDatasourceImpl({
    required IApiService apiService,
  }) : _apiService = apiService;
  @override
  Future<List<PrivilegeModel>> getPrivileges() async {
    try {
      final response = await _apiService.get(url: 'privileges');
      final privileges =
          BaseResponseDataModel<List<PrivilegesDataModel>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .toListOfMaps()
            .map((e) => PrivilegesDataModel.fromJson(e))
            .toList(),
      ).data;

      return privileges.map((e) => e.toDomain()).toList();
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(message: 'Error desconocido');
    }
  }

  String _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return 'No autorizado';
      case 400:
        return 'Error en el formulario por favor intente nuevamente';
      default:
        return 'Intente mas tarde';
    }
  }
}

import 'package:communitary_service_app/config/helpers/list_converter.dart';
import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/allergies/allergies_datasource.dart';
import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/allergies/allergies_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:dio/dio.dart';

class AllergiesDatasourceImpl implements AllergiesDataSource {
  final IApiService _apiService;

  AllergiesDatasourceImpl({required IApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<AllergiesModel>> getAllergies() async {
    try {
      final response = await _apiService.get(url: 'alergies');

      final allergies =
          BaseResponseDataModel<List<AllergiesDataModel>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .toListOfMaps()
            .map((e) => AllergiesDataModel.fromJson(e))
            .toList(),
      ).data;
      return allergies.map((e) => e.toDomain()).toList();
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
        return 'Unauthorized';
      case 404:
        return 'No hay alergias disponibles';
      default:
        return 'Intente mas tarde';
    }
  }
}

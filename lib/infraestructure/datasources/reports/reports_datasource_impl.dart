import 'package:communitary_service_app/config/helpers/list_converter.dart';
import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/reports/reports_datasource.dart';
import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/reports/reports_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:dio/dio.dart';

class ReportsDatasourceImpl implements ReportsDatasource {
  final IApiService _apiService;

  ReportsDatasourceImpl({
    required IApiService apiService,
  }) : _apiService = apiService;

  @override
  Future<List<ReportsModel>> getReportsByBeneficiaries(
      ReportsQueryModel query) async {
    try {
      final response = await _apiService.get(
        url: 'reports/beneficiaries',
        params: query.toJson(),
      );

      final reports = BaseResponseDataModel<List<ReportsDataModel>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .toListOfMaps()
            .map((e) => ReportsDataModel.fromJson(e))
            .toList(),
      ).data;

      return reports.map((e) => e.toDomain()).toList();
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
      case 404:
        return 'No se encontraron registros';
      default:
        return 'Intente mas tarde';
    }
  }

  @override
  Future<List<ReportsModel>> getReportsGlobal(ReportsQueryModel query) async {
    try {
      final response = await _apiService.get(
        url: 'reports/global',
        params: query.toJson(),
      );
      final reports = BaseResponseDataModel<List<ReportsDataModel>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .toListOfMaps()
            .map((e) => ReportsDataModel.fromJson(e))
            .toList(),
      ).data;
      return reports.map((e) => e.toDomain()).toList();
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(message: 'Error desconocido');
    }
  }
}

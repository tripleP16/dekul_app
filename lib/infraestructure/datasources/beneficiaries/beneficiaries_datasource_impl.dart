import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:dio/dio.dart';

import '../../../domain/datasources/beneficiaries/beneficiaries_datasource.dart';
import '../../errors/custom_error.dart';
import '../../models/beneficiaries/create_beneficiary_data_model.dart';

class BeneficiariesDatasourceImpl implements BeneficiariesDatasource {
  final IApiService _apiService;

  BeneficiariesDatasourceImpl({required IApiService apiService})
      : _apiService = apiService;

  @override
  Future<void> registerBeneficiary(BeneficiaryModel beneficiaryModel) async {
    try {
      final dataModel = CreateBeneficiaryDataModel.fromDomain(beneficiaryModel);
      return await _apiService.post(
        url: 'beneficiaries',
        body: dataModel.toJson(),
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
        return 'Una o mas alergias no existen en el sistema';
      case 400:
        return 'Error en el formulario por favor intente nuevamente';
      default:
        return 'Intente mas tarde';
    }
  }
}

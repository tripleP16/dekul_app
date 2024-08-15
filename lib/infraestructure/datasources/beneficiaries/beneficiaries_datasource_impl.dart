import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/get_beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/medical_history/medical_history_model.dart';
import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/infraestructure/mappers/paginated_list_beneficiaries_mapper.dart';
import 'package:communitary_service_app/infraestructure/models/beneficiaries/get_beneficiaries_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/medical_history/medical_history_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/list_paginated_data_model.dart';
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

  @override
  Future<ListPaginatedModel<BeneficiaryModel>>
      getBeneficiariesWithSearchPaginated(
          PaginationAndSearchModel query) async {
    try {
      final response = await _apiService.get(
        url: 'beneficiaries',
        params: query.toJson(),
      );

      final baseResponse = BaseResponseDataModel<
          ListPaginatedDataModel<GetBeneficiariesDataModel>>.fromJson(
        response.data,
        (json) => ListPaginatedDataModel<GetBeneficiariesDataModel>.fromJson(
          json as Map<String, dynamic>,
          (json) =>
              GetBeneficiariesDataModel.fromJson(json as Map<String, dynamic>),
        ),
      );

      final responseWithoutMap = baseResponse.data;

      return PaginatedListBeneficiariesMapper.fromDataModel(responseWithoutMap);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return ListPaginatedModel<BeneficiaryModel>.empty();
      }
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(
          message: 'Error en el servidor por favor intente mas tarde');
    }
  }

  @override
  Future<GetBeneficiaryModel> getBeneficiary(String beneficiaryId) async {
    try {
      final response = await _apiService.get(
        url: 'beneficiaries/$beneficiaryId',
      );

      final baseResponse =
          BaseResponseDataModel<GetBeneficiariesDataModel>.fromJson(
        response.data,
        (json) =>
            GetBeneficiariesDataModel.fromJson(json as Map<String, dynamic>),
      );

      return baseResponse.data.toGetDomain();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw CustomError(message: 'Beneficiario no encontrado');
      }

      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(
          message: 'Error en el servidor por favor intente mas tarde');
    }
  }

  @override
  Future<void> addMedicalHistory(
      String id, MedicalHistoryModel medicalHistory) async {
    try {
      final dataModel = MedicalHistoryDataModel.fromDomain(medicalHistory);
      await _apiService.patch(
        url: 'beneficiaries/medical/history/$id',
        body: dataModel.toJson(),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw CustomError(message: 'Beneficiario no encontrado');
      }
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(
          message: 'Error en el servidor por favor intente mas tarde');
    }
  }
}

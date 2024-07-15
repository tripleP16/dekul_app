import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:communitary_service_app/domain/models/forgot_password/create_code_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/reset_password_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/reset_password_token_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/validate_code_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/forgot_password/create_code_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/forgot_password/reset_password_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/forgot_password/reset_password_token_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/forgot_password/validate_code_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:dio/dio.dart';

class ForgotPasswordDatasourceImpl implements ForgotPasswordDatasource {
  final IApiService _apiService;

  ForgotPasswordDatasourceImpl({required IApiService apiService})
      : _apiService = apiService;
  @override
  Future<void> createCodeToRestorePassword(CreateCodeModel input) async {
    try {
      final body = CreateCodeDataModel.fromDomain(input);
      await _apiService.post(
        url: 'code/create',
        body: body.toJson(),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw CustomError(
            message: 'El correo no existe en nuestra base de datos');
      }
      throw CustomError(message: 'Por favor intente mas tarde');
    } catch (e) {
      throw CustomError(message: 'Por favor intente mas tarde');
    }
  }

  @override
  Future<ResetPasswordTokenModel> validateCode(ValidateCodeModel input) async {
    try {
      final body = ValidateCodeDataModel.fromDomain(input);
      final response = await _apiService.post(
        url: 'code/validate',
        body: body.toJson(),
      );

      final result =
          BaseResponseDataModel<ResetPasswordTokenDataModel>.fromJson(
        response.data,
        (json) =>
            ResetPasswordTokenDataModel.fromJson(json as Map<String, dynamic>),
      );

      return result.data.toDomain();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw CustomError(message: 'El codigo no ha sido encontrado');
      }

      if (e.response?.statusCode == 409) {
        throw CustomError(message: 'El codigo ha expirado');
      }
      throw CustomError(message: 'Por favor intente mas tarde');
    } catch (e) {
      throw CustomError(message: 'Por favor intente mas tarde');
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordModel input) async {
    try {
      final body = ResetPasswordDataModel(
        newPassword: input.newPassword,
      );
      await _apiService.post(
        url: 'password/reset',
        headers: {'Authorization': 'Bearer ${input.accessToken}'},
        body: body.toJson(),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            message: 'No esta autorizado para realizar esta accion');
      }

      if (e.response?.statusCode == 409) {
        throw CustomError(message: 'El codigo ha expirado');
      }
      throw CustomError(message: 'Por favor intente mas tarde');
    } catch (e) {
      throw CustomError(message: 'Por favor intente mas tarde');
    }
  }
}

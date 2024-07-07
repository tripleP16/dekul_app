import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:communitary_service_app/domain/models/forgot_password/create_code_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/forgot_password/create_code_data_model.dart';
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
}

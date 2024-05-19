import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/login/login_datasource.dart';
import 'package:communitary_service_app/domain/models/login/access_token_model.dart';
import 'package:communitary_service_app/domain/models/login/login_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/login/access_token_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/login/login_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:dio/dio.dart';

class LoginDatasourceImpl extends LoginDatasource {
  final IApiService _apiService;

  LoginDatasourceImpl({required IApiService apiService})
      : _apiService = apiService;

  @override
  Future<AccessTokenModel> login(LoginModel input) async {
    try {
      final response = await _apiService.post(
          url: 'auth/login', body: LoginDataModel.fromDomain(input).toJson());

      final accessToken = BaseResponseDataModel<AccessTokenDataModel>.fromJson(
        response.data,
        (json) => AccessTokenDataModel.fromJson(json as Map<String, dynamic>),
      ).data;

      return accessToken.toDomain();
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
        return 'La contraseña es incorrecta';
      case 404:
        return 'El usuario no existe';
      case 400:
        return 'Error en el formulario por favor intente nuevamente';
      default:
        return 'Intente mas tarde';
    }
  }
}

import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/auth/auth_datasource.dart';
import 'package:communitary_service_app/domain/models/login/access_token_model.dart';
import 'package:communitary_service_app/infraestructure/models/login/access_token_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final IApiService _apiService;

  AuthDatasourceImpl({required IApiService apiService})
      : _apiService = apiService;

  @override
  Future<AccessTokenModel> refreshToken(String refreshToken) async {
    final response = await _apiService.post(url: 'auth/refresh', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $refreshToken',
    });
    final accessToken = BaseResponseDataModel<AccessTokenDataModel>.fromJson(
      response.data,
      (json) => AccessTokenDataModel.fromJson(json as Map<String, dynamic>),
    ).data;

    return accessToken.toDomain();
  }
}

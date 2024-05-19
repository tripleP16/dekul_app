import 'package:communitary_service_app/domain/datasources/auth/auth_datasource.dart';
import 'package:communitary_service_app/domain/models/login/access_token_model.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});
  @override
  Future<AccessTokenModel> refreshToken(String refreshToken) {
    return datasource.refreshToken(refreshToken);
  }
}

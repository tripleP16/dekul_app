import 'package:communitary_service_app/domain/datasources/login/login_datasource.dart';
import 'package:communitary_service_app/domain/models/login/access_token_model.dart';
import 'package:communitary_service_app/domain/models/login/login_model.dart';
import 'package:communitary_service_app/domain/repositories/login/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasource _datasource;

  LoginRepositoryImpl({required LoginDatasource datasource})
      : _datasource = datasource;
  @override
  Future<AccessTokenModel> login(LoginModel input) {
   return _datasource.login(input);
  }
}

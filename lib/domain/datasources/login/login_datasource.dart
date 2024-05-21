import 'package:communitary_service_app/domain/models/login/access_token_model.dart';
import 'package:communitary_service_app/domain/models/login/login_model.dart';

abstract class LoginDatasource {
  Future<AccessTokenModel> login(LoginModel input);
}

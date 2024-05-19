import 'package:communitary_service_app/domain/models/login/access_token_model.dart';

abstract class AuthDatasource {
  Future<AccessTokenModel> refreshToken(String refreshToken);
}

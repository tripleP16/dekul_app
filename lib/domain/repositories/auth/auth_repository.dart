import 'package:communitary_service_app/domain/models/login/access_token_model.dart';

abstract class AuthRepository {
  Future<AccessTokenModel> refreshToken(String refreshToken);
}

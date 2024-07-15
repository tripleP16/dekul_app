import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/storage_service.dart';

class TokenService {
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';

  static Future<String> getToken() async {
    return await getIt<IStorageService>().read<String?>(tokenKey) ?? '';
  }

  static Future<String> getRefreshToken() async {
    return await getIt<IStorageService>().read<String?>(refreshTokenKey) ?? '';
  }

  static Future<void> setToken(String token) async {
    await getIt<IStorageService>().write<String>(tokenKey, token);
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    await getIt<IStorageService>().write<String>(refreshTokenKey, refreshToken);
  }

  static Future<void> deleteTokens() async {
    await getIt<IStorageService>().delete(tokenKey);
    await getIt<IStorageService>().delete(refreshTokenKey);
  }
}

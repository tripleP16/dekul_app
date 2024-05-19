import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/config/services/expiration_service.dart';
import 'package:communitary_service_app/config/services/token_service.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';
import 'package:dio/dio.dart';

class RefreshTokenInterceptor extends Interceptor {
  final AuthRepository _authRepository;

  RefreshTokenInterceptor({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = await TokenService.getToken();
    String refreshToken = await TokenService.getRefreshToken();

    if (accessToken.isEmpty || refreshToken.isEmpty) {
      return handler.next(options);
    }

    if (ExpirationService.isTokenAboutToExpire(accessToken)) {
      try {
        final newAccessToken = await _authRepository.refreshToken(refreshToken);
        TokenService.setRefreshToken(newAccessToken.refreshToken);
        TokenService.setToken(newAccessToken.accessToken);
        accessToken = newAccessToken.accessToken;
      } catch (e) {
        appRouter.go('/login');
      }
    }

    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      appRouter.go('/login');
    }

    return handler.reject(err);
  }
}

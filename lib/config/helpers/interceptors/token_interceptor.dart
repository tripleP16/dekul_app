import 'package:communitary_service_app/config/services/token_service.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = TokenService.getToken();

    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}

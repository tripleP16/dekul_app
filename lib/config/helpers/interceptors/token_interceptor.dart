import 'package:communitary_service_app/config/services/token_service.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('refresh')) return handler.next(options);
    if (options.path.contains('reset')) return handler.next(options);
    final token = await TokenService.getToken();

    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}

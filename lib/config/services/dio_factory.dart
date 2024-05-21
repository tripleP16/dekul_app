import 'package:communitary_service_app/config/helpers/interceptors/token_interceptor.dart';
import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:dio/dio.dart';

class DioFactory {
  final Environment environment;

  DioFactory(this.environment);

  Dio create() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: environment.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final Dio dio = Dio(baseOptions);
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}

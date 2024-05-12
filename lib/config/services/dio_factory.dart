import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:dio/dio.dart';

class DioFactory {
  final BaseOptions baseOptions = BaseOptions(
    baseUrl: getIt<Environment>().baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );


  Dio create() {
    return Dio(baseOptions);
  }
}

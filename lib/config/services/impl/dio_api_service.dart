import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:dio/dio.dart';

class DioApiService implements IApiService {
  final Dio _dio;

  DioApiService(this._dio);

  @override
  Future delete(
      {required String url,
      Map<String, dynamic>? params,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) {
    
    return _dio.delete(url,
        queryParameters: params,
        data: body,
        options: Options(headers: headers));
  }

  @override
  Future get(
      {required String url,
      Map<String, dynamic>? params,
      Map<String, String>? headers}) {
    return _dio.get(url,
        queryParameters: params, options: Options(headers: headers));
  }

  @override
  Future patch(
      {required String url,
      Map<String, dynamic>? params,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) {
    
    return _dio.patch(url,
        queryParameters: params,
        data: body,
        options: Options(headers: headers));
  }

  @override
  Future post(
      {required String url,
      Map<String, dynamic>? params,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) {
    
    return _dio.post(url,
        queryParameters: params,
        data: body,
        options: Options(headers: headers));
  }

  @override
  Future put(
      {required String url,
      Map<String, dynamic>? params,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) {
    
    return _dio.put(url,
        queryParameters: params,
        data: body,
        options: Options(headers: headers));
  }
}

abstract class IApiService {
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  });

  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<dynamic> put({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<dynamic> patch({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}

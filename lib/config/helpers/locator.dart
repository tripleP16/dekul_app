import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:communitary_service_app/config/services/contracts/storage_service.dart';
import 'package:communitary_service_app/config/services/dio_factory.dart';
import 'package:communitary_service_app/config/services/impl/dio_api_service.dart';
import 'package:communitary_service_app/config/services/impl/environment_service.dart';
import 'package:communitary_service_app/config/services/impl/shared_preferences_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Locator {
  Locator() {
    getIt.registerSingleton<Environment>(EnvironmentService());
    getIt.registerLazySingleton<Dio>(() => DioFactory().create());
    getIt.registerLazySingleton<IApiService>(() => DioApiService(getIt<Dio>()));

    getIt.registerLazySingleton<IStorageService>(
        () => SharedPreferencesStorageService());
  }
}

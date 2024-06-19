import 'package:communitary_service_app/config/services/contracts/alert_dialog_service.dart';
import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:communitary_service_app/config/services/contracts/snackbars_service.dart';
import 'package:communitary_service_app/config/services/contracts/storage_service.dart';
import 'package:communitary_service_app/config/services/dio_factory.dart';
import 'package:communitary_service_app/config/services/impl/alert_dialog_service_impl.dart';
import 'package:communitary_service_app/config/services/impl/dio_api_service.dart';
import 'package:communitary_service_app/config/services/impl/environment_service.dart';
import 'package:communitary_service_app/config/services/impl/shared_preferences_storage_service.dart';
import 'package:communitary_service_app/config/services/impl/snackbars_service_impl.dart';
import 'package:communitary_service_app/domain/datasources/auth/auth_datasource.dart';
import 'package:communitary_service_app/domain/datasources/login/login_datasource.dart';
import 'package:communitary_service_app/domain/repositories/allergies/allergy_repository.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';
import 'package:communitary_service_app/domain/repositories/login/login_repository.dart';
import 'package:communitary_service_app/infraestructure/datasources/allergies/allergies_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/auth/auth_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/login/login_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/auth/auth_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/login/login_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../infraestructure/repositories/allergies/allergies_repository_impl.dart';

final getIt = GetIt.instance;

class Locator {
  Locator() {
    // Register synchronous services first
  }

  Future<void> init() async {
    getIt.registerLazySingleton<Environment>(() => EnvironmentService());
    getIt.registerLazySingleton<IStorageService>(
        () => SharedPreferencesStorageService());
    getIt.registerLazySingleton<SnackbarsService>(() => SnackbarsServiceImpl());
    getIt.registerLazySingleton<AlertDialogService>(
        () => AlertDialogServiceImpl());

    // Initialize async services
    await _setupAsyncServices();
    // Register services that depend on async services
    getIt.registerLazySingleton<IApiService>(() => DioApiService(getIt<Dio>()));
    getIt.registerSingleton<LoginDatasource>(
        LoginDatasourceImpl(apiService: getIt<IApiService>()));
    getIt.registerLazySingleton<AuthDatasource>(
        () => AuthDatasourceImpl(apiService: getIt<IApiService>()));
    getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(datasource: getIt<LoginDatasource>()));

    getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(datasource: getIt<AuthDatasource>()));

    getIt.registerLazySingleton<AllergiesDatasourceImpl>(
        () => AllergiesDatasourceImpl(apiService: getIt<IApiService>()));

    getIt.registerLazySingleton<AllergiesRepository>(
      () => AllergiesRepositoryImpl(
          allergiesDataSource: getIt<AllergiesDatasourceImpl>()),
    );
  }

  Future<void> _setupAsyncServices() async {
    await _initializeDio();
  }

  Future<void> _initializeDio() async {
    final environment = getIt<Environment>();
    await environment.init();
    await getIt<IStorageService>().init();
    final dio = DioFactory(environment).create();
    getIt.registerSingleton<Dio>(dio);
  }
}

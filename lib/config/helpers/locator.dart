import 'package:communitary_service_app/config/services/contracts/alert_dialog_service.dart';
import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/config/services/contracts/download_charts_service.dart';
import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:communitary_service_app/config/services/contracts/permissions_service.dart';
import 'package:communitary_service_app/config/services/contracts/snackbars_service.dart';
import 'package:communitary_service_app/config/services/contracts/storage_service.dart';
import 'package:communitary_service_app/config/services/dio_factory.dart';
import 'package:communitary_service_app/config/services/impl/alert_dialog_service_impl.dart';
import 'package:communitary_service_app/config/services/impl/dio_api_service.dart';
import 'package:communitary_service_app/config/services/impl/download_charts_service_impl.dart';
import 'package:communitary_service_app/config/services/impl/environment_service.dart';
import 'package:communitary_service_app/config/services/impl/permissions_service_impl.dart';
import 'package:communitary_service_app/config/services/impl/shared_preferences_storage_service.dart';
import 'package:communitary_service_app/config/services/impl/snackbars_service_impl.dart';
import 'package:communitary_service_app/domain/datasources/auth/auth_datasource.dart';
import 'package:communitary_service_app/domain/datasources/change_password/change_password_datasource.dart';
import 'package:communitary_service_app/domain/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:communitary_service_app/domain/datasources/login/login_datasource.dart';
import 'package:communitary_service_app/domain/datasources/my_profile/my_profile_datasource.dart';
import 'package:communitary_service_app/domain/datasources/privileges/privileges_datasource.dart';
import 'package:communitary_service_app/domain/datasources/reports/reports_datasource.dart';
import 'package:communitary_service_app/domain/datasources/users/users_datasource.dart';
import 'package:communitary_service_app/domain/repositories/allergies/allergy_repository.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/domain/repositories/change_password/change_password_repository.dart';
import 'package:communitary_service_app/domain/repositories/forgot_password/forgot_password_repository.dart';
import 'package:communitary_service_app/domain/repositories/login/login_repository.dart';
import 'package:communitary_service_app/domain/repositories/my_profile/my_profile_repository.dart';
import 'package:communitary_service_app/domain/repositories/privileges/privileges_repository.dart';
import 'package:communitary_service_app/domain/repositories/reports/reports_repository.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';
import 'package:communitary_service_app/infraestructure/datasources/allergies/allergies_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/auth/auth_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/change_password/change_password_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/forgot_password/forgot_password_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/login/login_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/my_profile/my_profile_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/privileges/privileges_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/reports/reports_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/datasources/users/users_datasource_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/auth/auth_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/change_password/change_password_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/forgot_password/forgot_password_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/login/login_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/my_profile/my_profile_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/privileges/privileges_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/reports/reports_repository_impl.dart';
import 'package:communitary_service_app/infraestructure/repositories/users/users_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../domain/datasources/beneficiaries/beneficiaries_datasource.dart';
import '../../infraestructure/datasources/beneficiaries/beneficiaries_datasource_impl.dart';
import '../../infraestructure/repositories/allergies/allergies_repository_impl.dart';
import '../../infraestructure/repositories/beneficiaries/beneficiaries_repository_impl.dart';

final getIt = GetIt.instance;

class Locator {
  Locator() {
    // Register synchronous services first
  }

  Future<void> init() async {
    getIt.registerLazySingleton<Environment>(
      () => EnvironmentService(),
    );
    getIt.registerLazySingleton<IStorageService>(
        () => SharedPreferencesStorageService());
    getIt.registerLazySingleton<SnackbarsService>(
      () => SnackbarsServiceImpl(),
    );
    getIt.registerLazySingleton<AlertDialogService>(
        () => AlertDialogServiceImpl());

    // Initialize async services
    await _setupAsyncServices();
    getIt.registerLazySingleton<IApiService>(
      () => DioApiService(
        getIt<Dio>(),
      ),
    );
    getIt.registerSingleton<LoginDatasource>(
      LoginDatasourceImpl(
        apiService: getIt<IApiService>(),
      ),
    );
    getIt.registerLazySingleton<AuthDatasource>(
      () => AuthDatasourceImpl(
        apiService: getIt<IApiService>(),
      ),
    );
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

    getIt.registerLazySingleton<BeneficiariesDatasource>(
        () => BeneficiariesDatasourceImpl(apiService: getIt<IApiService>()));

    getIt.registerLazySingleton<BeneficiariesRepository>(
      () => BeneficiariesRepositoryImpl(
        getIt<BeneficiariesDatasource>(),
      ),
    );
    getIt.registerLazySingleton<ForgotPasswordDatasource>(
      () => ForgotPasswordDatasourceImpl(apiService: getIt<IApiService>()),
    );

    getIt.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImpl(
        datasource: getIt<ForgotPasswordDatasource>(),
      ),
    );
    getIt.registerLazySingleton<UsersDatasource>(
      () => UsersDatasourceImpl(
        apiService: getIt<IApiService>(),
      ),
    );

    getIt.registerLazySingleton<UsersRepository>(
      () => UsersRepositoryImpl(
        usersDatasource: getIt<UsersDatasource>(),
      ),
    );

    getIt.registerLazySingleton<PermissionsService>(
      () => PermissionsServiceImpl(),
    );

    getIt.registerLazySingleton<ChangePasswordDatasource>(
      () => ChangePasswordDatasourceImpl(
        apiService: getIt<IApiService>(),
      ),
    );

    getIt.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(
          datasource: getIt<ChangePasswordDatasource>()),
    );

    getIt.registerLazySingleton<MyProfileDatasource>(
      () => MyProfileDatasourceImpl(apiService: getIt<IApiService>()),
    );

    getIt.registerLazySingleton<MyProfileRepository>(
      () => MyProfileRepositoryImpl(
        datasource: getIt<MyProfileDatasource>(),
      ),
    );

    getIt.registerLazySingleton<PrivilegesDatasource>(
      () => PrivilegesDatasourceImpl(apiService: getIt<IApiService>()),
    );

    getIt.registerLazySingleton<PrivilegesRepository>(
      () => PrivilegesRepositoryImpl(
        privilegesDatasource: getIt<PrivilegesDatasource>(),
      ),
    );

    getIt.registerLazySingleton<DownloadChartsService>(
      () => DownloadChartsServiceImpl(),
    );

    getIt.registerLazySingleton<ReportsDatasource>(
      () => ReportsDatasourceImpl(
        apiService: getIt<IApiService>(),
      ),
    );

    getIt.registerLazySingleton<ReportsRepository>(
      () => ReportsRepositoryImpl(
        getIt<ReportsDatasource>(),
      ),
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

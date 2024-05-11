import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:communitary_service_app/config/services/impl/environment_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Locator {
  Locator() {
    getIt.registerSingleton<Environment>(EnvironmentService());
  }
}

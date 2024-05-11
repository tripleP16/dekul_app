import 'package:communitary_service_app/config/services/contracts/environment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class EnvironmentService extends Environment {
  @override
  Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  @override
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';
}

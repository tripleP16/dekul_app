import 'package:communitary_service_app/domain/models/forgot_password/create_code_model.dart';

abstract class ForgotPasswordRepository {
  Future<void> createCodeToRestorePassword(CreateCodeModel input);
}

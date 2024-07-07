import 'package:communitary_service_app/domain/models/forgot_password/create_code_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/reset_password_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/reset_password_token_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/validate_code_model.dart';

abstract class ForgotPasswordRepository {
  Future<void> createCodeToRestorePassword(CreateCodeModel input);

  Future<ResetPasswordTokenModel> validateCode(ValidateCodeModel input);

  Future<void> resetPassword(ResetPasswordModel input);
}

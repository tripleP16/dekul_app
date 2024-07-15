import 'package:communitary_service_app/domain/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:communitary_service_app/domain/models/forgot_password/create_code_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/reset_password_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/reset_password_token_model.dart';
import 'package:communitary_service_app/domain/models/forgot_password/validate_code_model.dart';
import 'package:communitary_service_app/domain/repositories/forgot_password/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordDatasource _datasource;

  ForgotPasswordRepositoryImpl({required ForgotPasswordDatasource datasource})
      : _datasource = datasource;

  @override
  Future<void> createCodeToRestorePassword(CreateCodeModel input) {
    return _datasource.createCodeToRestorePassword(input);
  }

  @override
  Future<ResetPasswordTokenModel> validateCode(ValidateCodeModel input) {
    return _datasource.validateCode(input);
  }
  
  @override
  Future<void> resetPassword(ResetPasswordModel input) {
    return _datasource.resetPassword(input);
  }
}

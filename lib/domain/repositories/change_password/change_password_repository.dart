import 'package:communitary_service_app/domain/models/change_password/change_password_model.dart';

abstract class ChangePasswordRepository {
  Future<void> changePassword(ChangePasswordModel model);
}

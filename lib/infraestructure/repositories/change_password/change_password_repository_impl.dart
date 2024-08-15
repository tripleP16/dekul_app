import 'package:communitary_service_app/domain/datasources/change_password/change_password_datasource.dart';
import 'package:communitary_service_app/domain/models/change_password/change_password_model.dart';
import 'package:communitary_service_app/domain/repositories/change_password/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordDatasource datasource;

  ChangePasswordRepositoryImpl({
    required this.datasource,
  });
  @override
  Future<void> changePassword(ChangePasswordModel model) {
    return datasource.changePassword(model);
  }
}

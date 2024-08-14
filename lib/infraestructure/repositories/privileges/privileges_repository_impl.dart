import 'package:communitary_service_app/domain/datasources/privileges/privileges_datasource.dart';
import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/domain/repositories/privileges/privileges_repository.dart';

class PrivilegesRepositoryImpl implements PrivilegesRepository {
  final PrivilegesDatasource _privilegesDatasource;

  PrivilegesRepositoryImpl({required PrivilegesDatasource privilegesDatasource})
      : _privilegesDatasource = privilegesDatasource;

  @override
  Future<List<PrivilegeModel>> getPrivileges() {
    return _privilegesDatasource.getPrivileges();
  }
}

import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';

abstract class PrivilegesDatasource {
  Future<List<PrivilegeModel>> getPrivileges();
}

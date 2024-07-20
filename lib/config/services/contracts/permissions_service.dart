import 'package:communitary_service_app/config/services/models/permissions_enum.dart';

abstract class PermissionsService {
  Future<bool> hasAccess(PermissionsEnum permission);
}

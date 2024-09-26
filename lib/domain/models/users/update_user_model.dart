import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';

class UpdateUserModel {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final List<PrivilegeModel> privileges;

  const UpdateUserModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.privileges,
    required this.email,
  });
}

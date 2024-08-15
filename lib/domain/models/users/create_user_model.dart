import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';

class CreateUserModel {
  final String name;
  final String lastname;
  final String email;
  final List<PrivilegeModel> privileges;

  CreateUserModel({
    required this.name,
    required this.lastname,
    required this.privileges,
    required this.email,
  });
}

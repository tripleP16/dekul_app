import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';

class UsersModel {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final List<PrivilegeModel>? privileges;

  UsersModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    this.privileges,
  });

  String get fullName => '$name $lastname';
}

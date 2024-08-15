import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';

class GetMyProfileModel {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final List<PrivilegeModel> privileges;

  const GetMyProfileModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.privileges,
  });
}

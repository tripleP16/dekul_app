import 'package:communitary_service_app/domain/models/users/users_model.dart';
import 'package:communitary_service_app/infraestructure/models/privileges/privileges_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_data_model.g.dart';

@JsonSerializable()
class UsersDataModel {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final List<PrivilegesDataModel>? privileges;
  const UsersDataModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    this.privileges,
  });

  factory UsersDataModel.fromJson(Map<String, dynamic> json) =>
      _$UsersDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersDataModelToJson(this);

  UsersModel toDomain() {
    return UsersModel(
      id: id,
      name: name,
      lastname: lastname,
      email: email,
      privileges: privileges?.map((e) => e.toDomain()).toList(),
    );
  }

  factory UsersDataModel.fromDomain(UsersModel users) {
    return UsersDataModel(
      id: users.id,
      name: users.name,
      lastname: users.lastname,
      email: users.email,
      privileges: users.privileges
          ?.map((e) => PrivilegesDataModel.fromDomain(e))
          .toList(),
    );
  }
}

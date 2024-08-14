import 'package:communitary_service_app/domain/models/users/create_user_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_id_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_data_model.g.dart';

@JsonSerializable()
class CreateUserDataModel {
  final String name;
  final String lastname;
  final String email;
  final List<BaseIdDataModel> privileges;

  CreateUserDataModel({
    required this.name,
    required this.lastname,
    required this.privileges,
    required this.email,
  });

  factory CreateUserDataModel.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserDataModelToJson(this);

  factory CreateUserDataModel.fromDomain(CreateUserModel model) =>
      CreateUserDataModel(
        email: model.email,
        name: model.name,
        lastname: model.lastname,
        privileges:
            model.privileges.map((e) => BaseIdDataModel(id: e.id)).toList(),
      );
}

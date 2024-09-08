import 'package:communitary_service_app/domain/models/users/update_user_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_id_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_data_model.g.dart';

@JsonSerializable()
class UpdateUserDataModel {
  final String name;
  final String lastname;
  final String email;
  final List<BaseIdDataModel> privileges;

  UpdateUserDataModel({
    required this.name,
    required this.lastname,
    required this.privileges,
    required this.email,
  });

  factory UpdateUserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataModelToJson(this);

  factory UpdateUserDataModel.fromDomain(UpdateUserModel model) =>
      UpdateUserDataModel(
        email: model.email,
        name: model.name,
        lastname: model.lastname,
        privileges:
            model.privileges.map((e) => BaseIdDataModel(id: e.id)).toList(),
      );
}

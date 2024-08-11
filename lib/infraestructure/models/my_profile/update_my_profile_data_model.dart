import 'package:communitary_service_app/domain/models/my_profile/update_my_profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_my_profile_data_model.g.dart';

@JsonSerializable()
class UpdateMyProfileDataModel {
  final String name;
  final String lastname;
  final String email;

  const UpdateMyProfileDataModel({
    required this.name,
    required this.lastname,
    required this.email,
  });

  factory UpdateMyProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateMyProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMyProfileDataModelToJson(this);

  factory UpdateMyProfileDataModel.fromDomain(UpdateMyProfileModel model) =>
      UpdateMyProfileDataModel(
        name: model.name,
        lastname: model.lastname,
        email: model.email,
      );

  UpdateMyProfileModel toDomain() => UpdateMyProfileModel(
        name: name,
        lastname: lastname,
        email: email,
      );
}

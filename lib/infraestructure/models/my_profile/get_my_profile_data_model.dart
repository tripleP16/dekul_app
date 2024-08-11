import 'package:communitary_service_app/domain/models/my_profile/get_my_profile_model.dart';
import 'package:communitary_service_app/infraestructure/models/privileges/privileges_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_my_profile_data_model.g.dart';

@JsonSerializable()
class GetMyProfileDataModel {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final List<PrivilegesDataModel> privileges;

  const GetMyProfileDataModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.privileges,
  });

  factory GetMyProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetMyProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyProfileDataModelToJson(this);

  GetMyProfileModel toDomain() => GetMyProfileModel(
        id: id,
        name: name,
        lastname: lastname,
        email: email,
        privileges: privileges
            .map(
              (e) => e.toDomain(),
            )
            .toList(),
      );

  factory GetMyProfileDataModel.fromDomain(GetMyProfileModel domain) =>
      GetMyProfileDataModel(
        id: domain.id,
        name: domain.name,
        lastname: domain.lastname,
        email: domain.email,
        privileges: domain.privileges
            .map((e) => PrivilegesDataModel.fromDomain(e))
            .toList(),
      );
}

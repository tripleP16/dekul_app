import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'privileges_data_model.g.dart';

@JsonSerializable()
class PrivilegesDataModel {
  final String id;
  final String name;

  const PrivilegesDataModel({
    required this.id,
    required this.name,
  });

  factory PrivilegesDataModel.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesDataModelToJson(this);

  PrivilegeModel toDomain() => PrivilegeModel(
        id: id,
        name: name,
      );

  factory PrivilegesDataModel.fromDomain(PrivilegeModel domain) =>
      PrivilegesDataModel(id: domain.id, name: domain.name);
}

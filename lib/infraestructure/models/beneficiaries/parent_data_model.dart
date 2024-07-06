import 'package:communitary_service_app/domain/models/beneficiaries/parent_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent_data_model.g.dart';

@JsonSerializable()
class ParentDataModel {
  final String name;
  final String lastname;
  final String phoneNumber;

  ParentDataModel({
    required this.name,
    required this.lastname,
    required this.phoneNumber,
  });

  factory ParentDataModel.fromJson(Map<String, dynamic> json) =>
      _$ParentDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParentDataModelToJson(this);

  factory ParentDataModel.fromDomain(ParentModel domain) {
    return ParentDataModel(
      name: domain.name,
      lastname: domain.lastname,
      phoneNumber: domain.phoneNumber,
    );
  }

  ParentModel toDomain() => ParentModel(
        name: name,
        lastname: lastname,
        phoneNumber: phoneNumber,
      );
}

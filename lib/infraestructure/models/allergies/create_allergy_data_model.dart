import 'package:communitary_service_app/domain/models/allergies/create_allergy_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_allergy_data_model.g.dart';

@JsonSerializable()
class CreateAllergyDataModel {
  final String name;

  CreateAllergyDataModel({required this.name});

  factory CreateAllergyDataModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAllergyDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAllergyDataModelToJson(this);

  factory CreateAllergyDataModel.fromDomain(CreateAllergyModel model) =>
      CreateAllergyDataModel(
        name: model.name,
      );
}

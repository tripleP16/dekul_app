import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allergies_data_model.g.dart';

@JsonSerializable()
class AllergiesDataModel {
  final String id;
  final String name;

  const AllergiesDataModel({
    required this.id,
    required this.name,
  });

  factory AllergiesDataModel.fromJson(Map<String, dynamic> json) =>
      _$AllergiesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllergiesDataModelToJson(this);

  AllergiesModel toDomain() => AllergiesModel(
        id: id,
        name: name,
      );
}

import 'package:json_annotation/json_annotation.dart';

part 'base_id_data_model.g.dart';

@JsonSerializable()
class BaseIdDataModel {
  final String id;

  BaseIdDataModel({required this.id});

  factory BaseIdDataModel.fromJson(Map<String, dynamic> json) =>
      _$BaseIdDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseIdDataModelToJson(this);
}

import 'package:communitary_service_app/domain/models/forgot_password/create_code_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_code_data_model.g.dart';

@JsonSerializable()
class CreateCodeDataModel {
  final String email;

  CreateCodeDataModel({required this.email});

  factory CreateCodeDataModel.fromJson(Map<String, dynamic> json) =>
      _$CreateCodeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCodeDataModelToJson(this);

  factory CreateCodeDataModel.fromDomain(CreateCodeModel model) =>
      CreateCodeDataModel(
        email: model.email,
      );
}

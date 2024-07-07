import 'package:communitary_service_app/domain/models/forgot_password/validate_code_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_code_data_model.g.dart';

@JsonSerializable()
class ValidateCodeDataModel {
  final String code;

  ValidateCodeDataModel({required this.code});

  factory ValidateCodeDataModel.fromJson(Map<String, dynamic> json) =>
      _$ValidateCodeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCodeDataModelToJson(this);

  factory ValidateCodeDataModel.fromDomain(ValidateCodeModel model) =>
      ValidateCodeDataModel(
        code: model.code,
      );
}

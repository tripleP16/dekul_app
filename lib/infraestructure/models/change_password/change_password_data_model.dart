import 'package:communitary_service_app/domain/models/change_password/change_password_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_data_model.g.dart';

@JsonSerializable()
class ChangePasswordDataModel {
  final String oldPassword;
  final String newPassword;

  ChangePasswordDataModel({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePasswordDataModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordDataModelToJson(this);

  factory ChangePasswordDataModel.fromDomain(ChangePasswordModel model) =>
      ChangePasswordDataModel(
        oldPassword: model.oldPassword,
        newPassword: model.newPassword,
      );
}

import 'package:json_annotation/json_annotation.dart';

part 'reset_password_data_model.g.dart';

@JsonSerializable()
class ResetPasswordDataModel {
  final String newPassword;

  ResetPasswordDataModel({
    required this.newPassword,
  });

  factory ResetPasswordDataModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordDataModelToJson(this);
}

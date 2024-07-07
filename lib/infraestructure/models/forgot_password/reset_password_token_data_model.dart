import 'package:communitary_service_app/domain/models/forgot_password/reset_password_token_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_token_data_model.g.dart';

@JsonSerializable()
class ResetPasswordTokenDataModel {
  final String accessToken;

  ResetPasswordTokenDataModel({
    required this.accessToken,
  });

  factory ResetPasswordTokenDataModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordTokenDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordTokenDataModelToJson(this);

  ResetPasswordTokenModel toDomain() => ResetPasswordTokenModel(
        accessToken: accessToken,
      );
}

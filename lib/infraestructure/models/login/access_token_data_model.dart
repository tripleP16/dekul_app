import 'package:communitary_service_app/domain/models/login/access_token_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'access_token_data_model.g.dart';

@JsonSerializable()
class AccessTokenDataModel {
  final String accessToken;
  final String refreshToken;

  AccessTokenDataModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AccessTokenDataModel.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenDataModelToJson(this);


  AccessTokenModel toDomain() => AccessTokenModel(
    accessToken: accessToken,
    refreshToken: refreshToken,
  );

  
}

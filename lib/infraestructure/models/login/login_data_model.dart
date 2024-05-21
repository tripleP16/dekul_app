import 'package:communitary_service_app/domain/models/login/login_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_data_model.g.dart';

@JsonSerializable()
class LoginDataModel {
  final String email;
  final String password;

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);

  LoginDataModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);

  factory LoginDataModel.fromDomain(LoginModel model) {
    return LoginDataModel(
      email: model.email,
      password: model.password,
    );
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'base_response_data_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseDataModel<T> {
  final String? message;
  final T data;
  final bool success;

  BaseResponseDataModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory BaseResponseDataModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseDataModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseDataModelToJson(this, toJsonT);
}

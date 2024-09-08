import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reports_data_model.g.dart';

@JsonSerializable()
class ReportsDataModel {
  final int x;
  final double? value;

  ReportsDataModel({required this.x, required this.value});

  factory ReportsDataModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsDataModelToJson(this);

  ReportsModel toDomain() {
    return ReportsModel(
      x: x,
      value: value,
    );
  }

  factory ReportsDataModel.fromDomain(ReportsModel model) {
    return ReportsDataModel(
      x: model.x,
      value: model.value,
    );
  }
}

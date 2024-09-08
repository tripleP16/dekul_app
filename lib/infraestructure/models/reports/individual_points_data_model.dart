import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'individual_points_data_model.g.dart';

@JsonSerializable()
class IndividualPointsDataModel {
  final int x;
  final double? y;

  IndividualPointsDataModel({required this.x, required this.y});

  factory IndividualPointsDataModel.fromJson(Map<String, dynamic> json) =>
      _$IndividualPointsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$IndividualPointsDataModelToJson(this);

  ReportsModel toDomain() {
    return ReportsModel(
      x: x,
      value: y,
    );
  }

  factory IndividualPointsDataModel.fromDomain(ReportsModel model) {
    return IndividualPointsDataModel(
      x: model.x,
      y: model.value,
    );
  }
}

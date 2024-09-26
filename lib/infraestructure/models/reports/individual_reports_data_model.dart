import 'package:communitary_service_app/domain/models/reports/individual_reports_model.dart';
import 'package:communitary_service_app/infraestructure/models/reports/individual_points_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'individual_reports_data_model.g.dart';

@JsonSerializable()
class IndividualReportsDataModel {
  final String beneficiaryId;
  final String name;
  final List<IndividualPointsDataModel> points;

  IndividualReportsDataModel({
    required this.beneficiaryId,
    required this.name,
    required this.points,
  });

  factory IndividualReportsDataModel.fromJson(Map<String, dynamic> json) =>
      _$IndividualReportsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$IndividualReportsDataModelToJson(this);

  IndividualReportsModel toDomain() {
    return IndividualReportsModel(
      beneficiaryId: beneficiaryId,
      name: name,
      points: points.map((e) => e.toDomain()).toList(),
    );
  }
}

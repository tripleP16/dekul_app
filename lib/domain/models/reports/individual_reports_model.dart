import 'package:communitary_service_app/domain/models/reports/reports_model.dart';

class IndividualReportsModel {
  final String beneficiaryId;
  final String name;
  final List<ReportsModel> points;
  const IndividualReportsModel({
    required this.beneficiaryId,
    required this.name,
    required this.points,
  });
}

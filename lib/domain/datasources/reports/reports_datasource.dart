import 'package:communitary_service_app/domain/models/reports/individual_reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';

abstract class ReportsDatasource {
  Future<List<ReportsModel>> getReportsGlobal(ReportsQueryModel query);

  Future<List<IndividualReportsModel>> getReportsByBeneficiaries(
      ReportsQueryModel query);
}

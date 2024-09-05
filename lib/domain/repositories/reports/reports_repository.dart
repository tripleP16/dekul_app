import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';

abstract class ReportsRepository {
  Future<List<ReportsModel>> getReportsGlobal(ReportsQueryModel query);

  Future<List<ReportsModel>> getReportsByBeneficiaries(ReportsQueryModel query);
}

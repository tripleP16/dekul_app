import 'package:communitary_service_app/domain/datasources/reports/reports_datasource.dart';
import 'package:communitary_service_app/domain/models/reports/individual_reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/domain/repositories/reports/reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsDatasource _reportsDatasource;

  ReportsRepositoryImpl(this._reportsDatasource);
  @override
  Future<List<IndividualReportsModel>> getReportsByBeneficiaries(
      ReportsQueryModel query) {
    return _reportsDatasource.getReportsByBeneficiaries(query);
  }

  @override
  Future<List<ReportsModel>> getReportsGlobal(ReportsQueryModel query) {
    return _reportsDatasource.getReportsGlobal(query);
  }
}

import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';

abstract class ReportsEvent {}

class LoadReportsGlobal extends ReportsEvent {
  final ReportsQueryModel query;

  LoadReportsGlobal({
    required this.query,
  });
}

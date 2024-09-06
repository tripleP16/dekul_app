import 'dart:ui';

import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';

abstract class ReportsEvent {}

class LoadReportsGlobal extends ReportsEvent {
  final ReportsQueryModel query;
  final Color? color;
  final String? title;
  final String? text;
  LoadReportsGlobal({
    required this.query,
    this.color,
    this.title,
    this.text,
  });
}

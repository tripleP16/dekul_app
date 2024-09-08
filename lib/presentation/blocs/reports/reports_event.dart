import 'dart:ui';

import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';

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

class LoadReportsIndividual extends ReportsEvent {
  final ReportsQueryModel query;
  final Color? color;
  final String? title;
  final String? text;
  LoadReportsIndividual({
    required this.query,
    this.color,
    this.title,
    this.text,
  });
}

class LoadBeneficiaries extends ReportsEvent {
  final PaginationAndSearchModel query;
  LoadBeneficiaries({
    required this.query,
  });
}

class SelectBeneficiary extends ReportsEvent {
  final String beneficiaryId;
  SelectBeneficiary({
    required this.beneficiaryId,
  });
}

class UnselectBeneficiary extends ReportsEvent {
  final String beneficiaryId;
  UnselectBeneficiary({
    required this.beneficiaryId,
  });
}

class ClearIndividualReports extends ReportsEvent {}

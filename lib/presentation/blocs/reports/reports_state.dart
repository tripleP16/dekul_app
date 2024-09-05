import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/presentation/screens/charts/view_models/enums/chart_type_enum.dart';
import 'package:flutter/material.dart';

enum ReportViewState { loading, loaded, error, pure }

class ReportsState {
  final ReportViewState viewState;
  final List<ReportsModel> report;
  final String? errorMessage;
  final ChartType chartType;

  final ReportsQueryModel query;

  ReportsState(
      {required this.viewState,
      required this.report,
      required this.chartType,
      required this.query,
      this.errorMessage});

  bool get isLoading => viewState == ReportViewState.loading;

  bool get isLoaded => viewState == ReportViewState.loaded;

  bool get isError => viewState == ReportViewState.error;

  bool get isYearly => query.isYearly;

  ReportType get reportType => query.reportType;

  List<String>? get userIds => query.userIds;

  ReportsState copyWith(
      {ReportViewState? viewState,
      List<ReportsModel>? report,
      ValueGetter<String?>? errorMessage,
      ChartType? chartType,
      ReportsQueryModel? query}) {
    return ReportsState(
        viewState: viewState ?? this.viewState,
        report: report ?? this.report,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
        chartType: chartType ?? this.chartType,
        query: query ?? this.query);
  }

  factory ReportsState.initial() {
    return ReportsState(
      viewState: ReportViewState.pure,
      report: [],
      errorMessage: null,
      chartType: ChartType.bar,
      query: ReportsQueryModel.initial(),
    );
  }
}

import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/presentation/screens/charts/view_models/enums/chart_type_enum.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum ReportViewState { loading, loaded, error, pure }

class ReportsState {
  final ReportViewState viewState;
  final List<ReportsModel> report;
  final String? errorMessage;
  final ChartType chartType;
  final Color color;
  final ReportsQueryModel query;
  final String title;
  final String text;

  ReportsState({
    required this.viewState,
    required this.report,
    required this.chartType,
    required this.query,
    this.errorMessage,
    this.color = Colors.blue,
    this.title = 'Reporte Global',
    this.text = 'Reporte global de la comunidad',
  });

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
      ReportsQueryModel? query,
      String? title,
      String? text,
      Color? color}) {
    return ReportsState(
      viewState: viewState ?? this.viewState,
      report: report ?? this.report,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      chartType: chartType ?? this.chartType,
      query: query ?? this.query,
      color: color ?? this.color,
      text: text ?? this.text,
      title: title ?? this.title,
    );
  }

  factory ReportsState.initial() {
    return ReportsState(
      viewState: ReportViewState.pure,
      report: [],
      errorMessage: null,
      chartType: ChartType.bar,
      query: ReportsQueryModel.initial(),
      color: Colors.blue,
    );
  }

  List<int> get xValues => report.map((e) => e.x).toList();
  List<double> get yValues => report.map((e) => e.value).nonNulls.toList();
  List<FlSpot> get spots => List.generate(xValues.length,
      (index) => FlSpot(xValues[index].toDouble(), yValues[index]));

  bool get isAnual => query.isYearly;

  bool get isMonthly => !query.isYearly;
}

import 'dart:ui';

import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/domain/repositories/reports/reports_repository.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_event.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportsRepository _reportsRepository;
  ReportsBloc(this._reportsRepository) : super(ReportsState.initial()) {
    on<LoadReportsGlobal>(_onLoadReports);
  }

  Future<void> _onLoadReports(
    LoadReportsGlobal event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(viewState: ReportViewState.loading));
    try {
      final reports = await _reportsRepository.getReportsGlobal(event.query);
      emit(state.copyWith(
        viewState: ReportViewState.loaded,
        report: reports,
        query: event.query,
        color: event.color,
        title: event.title,
        text: event.text,
      ));
    } catch (e) {
      emit(state.copyWith(
        viewState: ReportViewState.error,
        errorMessage: () => e.toString(),
      ));
    }
  }

  void loadReport(
    ReportsQueryModel query,
    Color? color,
    String? title,
    String? text,
  ) {
    add(LoadReportsGlobal(
        query: query, color: color, title: title, text: text));
  }
}

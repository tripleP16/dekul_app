import 'dart:ui';

import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/domain/repositories/reports/reports_repository.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_event.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportsRepository _reportsRepository;
  final BeneficiariesRepository _beneficiariesRepository;
  ReportsBloc(this._reportsRepository, this._beneficiariesRepository)
      : super(ReportsState.initial()) {
    on<LoadReportsGlobal>(_onLoadGlobalReports);
    on<LoadBeneficiaries>(_onLoadBeneficiaries);
    on<LoadReportsIndividual>(_onLoadIndividualReports);
    on<SelectBeneficiary>(_onSelectBeneficiary);
    on<UnselectBeneficiary>(_onUnselectBeneficiary);
    on<ClearIndividualReports>(_onClearIndividualReports);

    add(LoadBeneficiaries(
        query: PaginationAndSearchModel(
      page: 1,
      pageSize: 10,
      search: null,
    )));
  }

  void _onClearIndividualReports(
    ClearIndividualReports event,
    Emitter<ReportsState> emit,
  ) {
    emit(state.copyWith(individualReports: []));
  }

  void _onSelectBeneficiary(
    SelectBeneficiary event,
    Emitter<ReportsState> emit,
  ) {
    final userIds = state.query.userIds ?? [];
    if (userIds.contains(event.beneficiaryId)) return;
    emit(state.copyWith(
      query: state.query.copyWith(
          userIds: () => [
                if (state.query.userIds != null) ...state.query.userIds!,
                event.beneficiaryId
              ]),
    ));
    add(LoadReportsIndividual(
      query: state.query,
      color: state.color,
      title: state.title,
      text: state.text,
    ));
  }

  void _onUnselectBeneficiary(
    UnselectBeneficiary event,
    Emitter<ReportsState> emit,
  ) {
    emit(state.copyWith(
      query: state.query.copyWith(
          userIds: () => state.query.userIds
              ?.where((e) => e != event.beneficiaryId)
              .toList()),
    ));

    add(LoadReportsIndividual(
      query: state.query,
      color: state.color,
      title: state.title,
      text: state.text,
    ));
  }

  Future<void> _onLoadBeneficiaries(
    LoadBeneficiaries event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(viewState: ReportViewState.loading));
    try {
      final beneficiaries = await _beneficiariesRepository
          .getBeneficiariesWithSearchPaginated(event.query);
      emit(state.copyWith(
        viewState: ReportViewState.loaded,
        beneficiaries: beneficiaries,
        beneficiariesQuery: event.query,
      ));
    } catch (e) {
      emit(state.copyWith(
        viewState: ReportViewState.error,
        errorMessage: () => e.toString(),
      ));
    }
  }

  Future<void> _onLoadGlobalReports(
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

  Future<void> _onLoadIndividualReports(
    LoadReportsIndividual event,
    Emitter<ReportsState> emit,
  ) async {
    emit(state.copyWith(viewState: ReportViewState.loading));
    if (state.query.userIds == null || state.query.userIds!.isEmpty) {
      emit(state.copyWith(
        viewState: ReportViewState.error,
        errorMessage: () => 'No se han seleccionado beneficiarios',
        individualReports: [],
      ));
      return;
    }
    try {
      final reports =
          await _reportsRepository.getReportsByBeneficiaries(event.query);
      emit(state.copyWith(
        viewState: ReportViewState.loaded,
        individualReports: reports,
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

  void onSearchBeneficiary(String value) {
    add(LoadBeneficiaries(
        query: PaginationAndSearchModel(
      page: 1,
      pageSize: 10,
      search: value,
    )));
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

  void loadIndividualReport(
    ReportsQueryModel query,
    Color? color,
    String? title,
    String? text,
  ) {
    add(LoadReportsIndividual(
        query: query, color: color, title: title, text: text));
  }

  void selectBeneficiary(String beneficiaryId) {
    add(SelectBeneficiary(beneficiaryId: beneficiaryId));
  }

  void unselectBeneficiary(String beneficiaryId) {
    add(UnselectBeneficiary(beneficiaryId: beneficiaryId));
  }

  void clearIndividualReports() {
    add(ClearIndividualReports());
  }
}

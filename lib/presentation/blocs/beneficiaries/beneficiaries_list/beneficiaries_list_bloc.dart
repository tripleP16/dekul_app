import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/beneficiaries_list/beneficiaries_list_event.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/beneficiaries_list/beneficiaries_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiariesListBloc
    extends Bloc<BeneficiariesListEvent, BeneficiariesListState> {
  final BeneficiariesRepository repository;

  BeneficiariesListBloc(this.repository)
      : super(BeneficiariesListState.initial()) {
    on<LoadBeneficiariesNextPage>(_onLoadBeneficiariesNextPage);
    on<LoadBeneficiariesWithSearchQuery>(_onLoadBeneficiariesWithSearchQuery);
    add(LoadBeneficiariesNextPage(nextPage: 1));
  }

  Future<void> _onLoadBeneficiariesWithSearchQuery(
    LoadBeneficiariesWithSearchQuery event,
    Emitter<BeneficiariesListState> emit,
  ) async {
    await _loadBeneficiaries(
      emit,
      page: event.page,
      searchQuery: event.searchQuery,
      isNewSearch: true,
    );
  }

  Future<void> _onLoadBeneficiariesNextPage(
    LoadBeneficiariesNextPage event,
    Emitter<BeneficiariesListState> emit,
  ) async {
    await _loadBeneficiaries(
      emit,
      page: event.nextPage,
      searchQuery: state.searchQuery,
      isNewSearch: false,
    );
  }

  Future<void> _loadBeneficiaries(
    Emitter<BeneficiariesListState> emit, {
    required int page,
    String? searchQuery,
    required bool isNewSearch,
  }) async {
    if (state.isLoading ||
        (!isNewSearch && !state.paginatedBeneficiaries.hasNextPage)) {
      return;
    }

    emit(state.copyWith(isLoading: true, searchQuery: searchQuery));

    try {
      final result = await repository.getBeneficiariesWithSearchPaginated(
        PaginationAndSearchModel(
          page: page,
          pageSize: state.paginatedBeneficiaries.pageSize,
          search: searchQuery,
        ),
      );

      final updatedTotalBeneficiaries = isNewSearch
          ? result.data
          : [...state.totalBeneficiaries, ...result.data];

      emit(
        state.copyWith(
          isLoading: false,
          paginatedBeneficiaries: result,
          totalBeneficiaries: updatedTotalBeneficiaries,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void loadNextPage() {
    final nextPage = state.paginatedBeneficiaries.currentPage + 1;
    add(LoadBeneficiariesNextPage(nextPage: nextPage));
  }

  void search(String query) {
    add(LoadBeneficiariesWithSearchQuery(page: 1, searchQuery: query));
  }
}

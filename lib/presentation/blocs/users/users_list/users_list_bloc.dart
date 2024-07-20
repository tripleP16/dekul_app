import 'package:communitary_service_app/domain/models/shared/pagination_and_search_model.dart';
import 'package:communitary_service_app/domain/repositories/users/users_repository.dart';
import 'package:communitary_service_app/presentation/blocs/users/users_list/users_list_event.dart';
import 'package:communitary_service_app/presentation/blocs/users/users_list/users_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final UsersRepository repository;

  UsersListBloc(this.repository) : super(UsersListState.initial()) {
    on<LoadUsersListEventNextPage>(_onLoadUsersNextPage);
    on<LoadUsersListWithSearchQuery>(_onLoadUsersWithSearchQuery);
    add(LoadUsersListEventNextPage(nextPage: 1));
  }

  Future<void> _onLoadUsersWithSearchQuery(
    LoadUsersListWithSearchQuery event,
    Emitter<UsersListState> emit,
  ) async {
    await _loadUsers(
      emit,
      page: event.page,
      searchQuery: event.searchQuery,
      isNewSearch: true,
    );
  }

  Future<void> _onLoadUsersNextPage(
    LoadUsersListEventNextPage event,
    Emitter<UsersListState> emit,
  ) async {
    await _loadUsers(
      emit,
      page: event.nextPage,
      searchQuery: state.searchQuery,
      isNewSearch: false,
    );
  }

  Future<void> _loadUsers(
    Emitter<UsersListState> emit, {
    required int page,
    String? searchQuery,
    required bool isNewSearch,
  }) async {
    if (state.isLoading ||
        (!isNewSearch && !state.paginatedUsers.hasNextPage)) {
      return;
    }

    emit(state.copyWith(
        isLoading: true,
        searchQuery: () => searchQuery,
        errorMessage: () => null));

    try {
      final result = await repository.fetchUsers(
        PaginationAndSearchModel(
          page: page,
          pageSize: state.paginatedUsers.pageSize,
          search: searchQuery,
        ),
      );

      final updatedTotalUsers =
          isNewSearch ? result.data : [...state.totalUsers, ...result.data];

      emit(
        state.copyWith(
          isLoading: false,
          paginatedUsers: result,
          totalUsers: updatedTotalUsers,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: () => e.toString(),
      ));
    }
  }

  void loadNextPage() {
    final nextPage = state.paginatedUsers.currentPage + 1;
    add(LoadUsersListEventNextPage(nextPage: nextPage));
  }

  void search(String query) {
    add(LoadUsersListWithSearchQuery(page: 1, searchQuery: query));
  }
}

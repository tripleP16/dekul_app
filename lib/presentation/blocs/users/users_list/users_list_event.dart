abstract class UsersListEvent {}

class LoadUsersListEventNextPage extends UsersListEvent {
  final int nextPage;

  LoadUsersListEventNextPage({
    required this.nextPage,
  });
}

class LoadUsersListWithSearchQuery extends UsersListEvent {
  final String searchQuery;
  final int page;

  LoadUsersListWithSearchQuery({
    required this.searchQuery,
    required this.page,
  });
}

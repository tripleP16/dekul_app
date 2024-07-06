abstract class BeneficiariesListEvent {}

class LoadBeneficiariesNextPage extends BeneficiariesListEvent {
  final int nextPage;

  LoadBeneficiariesNextPage({
    required this.nextPage,
  });
}

class LoadBeneficiariesWithSearchQuery extends BeneficiariesListEvent {
  final String searchQuery;
  final int page;

  LoadBeneficiariesWithSearchQuery({
    required this.searchQuery,
    required this.page,
  });
}

class ListPaginatedModel<T> {
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int currentPage;
  final int pageSize;
  final List<T> data;

  ListPaginatedModel({
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.currentPage,
    required this.pageSize,
    required this.data,
  });

  factory ListPaginatedModel.empty({
    hasNextPage = false,
  }) {
    return ListPaginatedModel(
      totalPages: 0,
      hasNextPage: hasNextPage,
      hasPreviousPage: false,
      currentPage: 0,
      pageSize: 10,
      data: [],
    );
  }
}

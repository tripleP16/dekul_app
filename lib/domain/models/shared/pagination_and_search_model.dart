class PaginationAndSearchModel {
  final int page;
  final int pageSize;
  final String? search;

  PaginationAndSearchModel({
    required this.page,
    required this.pageSize,
    required this.search,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'searchKey': search,
    };
  }
}

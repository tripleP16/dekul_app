import 'package:json_annotation/json_annotation.dart';

part 'list_paginated_data_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListPaginatedDataModel<T> {
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int currentPage;
  final int pageSize;
  final List<T> data;

  ListPaginatedDataModel({
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.currentPage,
    required this.pageSize,
    required this.data,
  });

  factory ListPaginatedDataModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ListPaginatedDataModelFromJson(json, (object) => fromJsonT(object));

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ListPaginatedDataModelToJson(this, (value) => toJsonT(value));
}

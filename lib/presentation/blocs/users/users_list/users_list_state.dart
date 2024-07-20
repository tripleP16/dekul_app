import 'package:communitary_service_app/domain/models/shared/list_paginated_model.dart';
import 'package:communitary_service_app/domain/models/users/users_model.dart';
import 'package:flutter/material.dart';

class UsersListState {
  final ListPaginatedModel<UsersModel> paginatedUsers;
  final List<UsersModel> totalUsers;
  final bool isLoading;
  final String? searchQuery;
  final String? errorMessage;

  UsersListState({
    required this.paginatedUsers,
    required this.totalUsers,
    required this.isLoading,
    this.searchQuery,
    this.errorMessage,
  });

  factory UsersListState.initial() {
    return UsersListState(
      paginatedUsers: ListPaginatedModel<UsersModel>.empty(
        hasNextPage: true,
      ),
      totalUsers: [],
      isLoading: false,
      searchQuery: null,
      errorMessage: null,
    );
  }

  UsersListState copyWith({
    ListPaginatedModel<UsersModel>? paginatedUsers,
    List<UsersModel>? totalUsers,
    bool? isLoading,
    ValueGetter<String?>? searchQuery,
    ValueGetter<String?>? errorMessage,
  }) {
    return UsersListState(
      paginatedUsers: paginatedUsers ?? this.paginatedUsers,
      totalUsers: totalUsers ?? this.totalUsers,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery != null ? searchQuery() : this.searchQuery,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

import 'package:communitary_service_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

String? authGuard(BuildContext context, GoRouterState state) {
  final authState = context.read<AuthBloc>().state;
  if (authState is! Authenticated) {
    return '/';
  }
  return null;
}

String? splashGuard(BuildContext context, GoRouterState state) {
  final authState = context.watch<AuthBloc>().state;
  if (authState is Authenticated) {
    return '/home';
  }
  if (authState is Unauthenticated) {
    return '/login';
  }
  return null;
}

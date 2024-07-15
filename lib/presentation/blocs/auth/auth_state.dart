import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState {
  @override
  List<Object?> get props => [];
}



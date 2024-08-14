import 'package:communitary_service_app/domain/repositories/privileges/privileges_repository.dart';
import 'package:communitary_service_app/presentation/blocs/privileges/privileges_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivilegesCubit extends Cubit<PrivilegesState> {
  final PrivilegesRepository _repository;
  PrivilegesCubit(this._repository) : super(PrivilegesState.initial()) {
    fetchPrivileges();
  }

  Future<void> fetchPrivileges() async {
    try {
      emit(state.copyWith(isLoading: true));
      final privileges = await _repository.getPrivileges();
      emit(state.copyWith(privileges: privileges, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        privileges: [],
        errorMessage: () => e.toString(),
      ));
    }
  }
}

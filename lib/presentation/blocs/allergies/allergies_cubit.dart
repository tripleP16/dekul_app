import 'package:communitary_service_app/domain/repositories/allergies/allergy_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'allergies_state.dart';

class AllergiesCubit extends Cubit<AllergiesState> {
  final AllergiesRepository _repository;

  AllergiesCubit(this._repository) : super(AllergiesState.initial());

  Future<void> fetchAllergies() async {
    try {
      emit(state.copyWith(isLoading: true));
      final allergies = await _repository.getAllergies();
      emit(state.copyWith(allergies: allergies, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, allergies: []));
    }
  }
}

import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/medical_history_form/medical_history_form_event.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/medical_history_form/medical_history_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../shared/form_inputs/height.dart';
import '../../../shared/form_inputs/weight.dart';

class MedicalHistoryFormBloc
    extends Bloc<MedicalHistoryFormEvent, MedicalHistoryFormState> {
  MedicalHistoryFormBloc() : super(MedicalHistoryFormState.initial()) {
    on<MedicalHistoryAddedAllergy>(_onAddAllergy);
    on<MedicalHistoryRemovedAllergy>(_onRemoveAllergy);
    on<MedicalHistoryChangedHeight>(_onChangedHeight);
    on<MedicalHistoryChangedWeight>(_onChangedWeight);
    on<MedicalHistoryPosted>(_onPosted);
    on<MedicalHistoryReset>(_onReset);
  }

  void _onPosted(
    MedicalHistoryPosted event,
    Emitter<MedicalHistoryFormState> emit,
  ) {
    emit(
      state.copyWith(
        status: event.status,
        height: Height.dirty(state.height.value),
        weight: Weight.dirty(state.weight.value),
        isValid: Formz.validate(
          [
            state.height,
            state.weight,
          ],
        ),
      ),
    );
  }

  void _onChangedHeight(
    MedicalHistoryChangedHeight event,
    Emitter<MedicalHistoryFormState> emit,
  ) {
    emit(
      state.copyWith(
        height: Height.dirty(event.height),
        status: MedicalHistoryFormStatus.dirty,
      ),
    );
  }

  void _onChangedWeight(
    MedicalHistoryChangedWeight event,
    Emitter<MedicalHistoryFormState> emit,
  ) {
    emit(
      state.copyWith(
        weight: Weight.dirty(event.weight),
        status: MedicalHistoryFormStatus.dirty,
      ),
    );
  }

  void _onAddAllergy(
    MedicalHistoryAddedAllergy event,
    Emitter<MedicalHistoryFormState> emit,
  ) {
    if (state.allergies.any((allergy) => allergy.id == event.allergy.id)) {
      return;
    }
    emit(
      state.copyWith(
        status: MedicalHistoryFormStatus.dirty,
        allergies: [...state.allergies, event.allergy],
      ),
    );
  }

  void _onRemoveAllergy(
    MedicalHistoryRemovedAllergy event,
    Emitter<MedicalHistoryFormState> emit,
  ) {
    emit(
      state.copyWith(
          status: MedicalHistoryFormStatus.dirty,
          allergies: state.allergies
              .where((allergy) => allergy.id != event.allergy.id)
              .toList()),
    );
  }

  void _onReset(
    MedicalHistoryReset event,
    Emitter<MedicalHistoryFormState> emit,
  ) {
    emit(
      MedicalHistoryFormState.initial(),
    );
  }

  Future<void> submit() async {
    add(MedicalHistoryPosted(status: MedicalHistoryFormStatus.posted));
  }

  void onAddAllergy(AllergiesModel allergy) {
    add(MedicalHistoryAddedAllergy(allergy: allergy));
  }

  void onRemoveAllergy(AllergiesModel allergy) {
    add(MedicalHistoryRemovedAllergy(allergy: allergy));
  }

  void onEditHeight(int height) {
    add(MedicalHistoryChangedHeight(height: height));
  }

  void onEditWeight(double weight) {
    add(MedicalHistoryChangedWeight(weight: weight));
  }

  void reset() {
    add(MedicalHistoryReset(status: MedicalHistoryFormStatus.initial));
  }
}

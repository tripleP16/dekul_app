import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/presentation/blocs/update_medical_history/update_medical_history_event.dart';
import 'package:communitary_service_app/presentation/blocs/update_medical_history/update_medical_history_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/height.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/weight.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class UpdateMedicalHistoryBloc
    extends Bloc<UpdateMedicalHistoryEvent, UpdateMedicalHistoryState> {
  final BeneficiariesRepository beneficiariesRepository;
  final String id;
  UpdateMedicalHistoryBloc(this.beneficiariesRepository, this.id)
      : super(UpdateMedicalHistoryState.initial()) {
    on<InputHeightEvent>(_onEditHeight);
    on<InputWeightEvent>(_onEditWeight);
    on<PostUpdateMedicalHistoryEvent>(_onPostMedicalHistory);
  }

  void _onPostMedicalHistory(
    PostUpdateMedicalHistoryEvent event,
    Emitter<UpdateMedicalHistoryState> emit,
  ) {
    emit(state.copyWith(formState: event.formState));
  }

  void _onEditWeight(
    InputWeightEvent event,
    Emitter<UpdateMedicalHistoryState> emit,
  ) {
    emit(state.copyWith(weight: Weight.dirty(event.weight)));

    _isFormValid(emit);
  }

  void _onEditHeight(
    InputHeightEvent event,
    Emitter<UpdateMedicalHistoryState> emit,
  ) {
    emit(state.copyWith(height: Height.dirty(event.height)));

    _isFormValid(emit);
  }

  void _isFormValid(
    Emitter<UpdateMedicalHistoryState> emit,
  ) {
    final isValid = Formz.validate(
      [state.height, state.weight],
    );
    emit(state.copyWith(
      formState: isValid
          ? UpdateMedicalHistoryFormState.isValid
          : UpdateMedicalHistoryFormState.isNotValid,
    ));
  }

  void onHeightChanged(int height) {
    add(InputHeightEvent(height: height));
  }

  void onWeightChanged(double weight) {
    add(InputWeightEvent(weight: weight));
  }

  Future<void> onSubmit() async {
    add(PostUpdateMedicalHistoryEvent(
        formState: UpdateMedicalHistoryFormState.loading));
    try {
      await beneficiariesRepository.addMedicalHistory(id, state.toDomain());
      add(PostUpdateMedicalHistoryEvent(
          formState: UpdateMedicalHistoryFormState.posted));
      appRouter.pushReplacement('/home');
    } catch (e) {
      add(PostUpdateMedicalHistoryEvent(
          formState: UpdateMedicalHistoryFormState.isValid));
      rethrow;
    }
  }
}

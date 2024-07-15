import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/models/allergies/create_allergy_model.dart';
import 'package:communitary_service_app/domain/repositories/allergies/allergy_repository.dart';
import 'package:communitary_service_app/presentation/blocs/allergies/create_allergies/create_allergies_event.dart';
import 'package:communitary_service_app/presentation/blocs/allergies/create_allergies/create_allergies_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/allergy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateAllergiesBloc
    extends Bloc<CreateAllergiesEvent, CreateAllergiesState> {
  final AllergiesRepository allergiesRepository;
  CreateAllergiesBloc(this.allergiesRepository)
      : super(CreateAllergiesState.initial()) {
    on<EditAllergyName>(_editAllergyName);
    on<PostCreateAllergy>(_postCreateAllergy);
    on<ResetAllergy>(_resetAllergy);
  }

  void _resetAllergy(ResetAllergy event, Emitter<CreateAllergiesState> emit) {
    emit(CreateAllergiesState.initial());
  }

  void _postCreateAllergy(
    PostCreateAllergy event,
    Emitter<CreateAllergiesState> emit,
  ) {
    emit(state.copyWith(
        isFormValid: Formz.validate([Allergy.dirty(state.allergy.value)])));

    if (state.isFormValid) {
      emit(
        state.copyWith(status: CreateAllergiesFormStatus.posted),
      );
    } else {
      emit(state.copyWith(status: CreateAllergiesFormStatus.inavlid));
    }
  }

  void _editAllergyName(
    EditAllergyName event,
    Emitter<CreateAllergiesState> emit,
  ) {
    emit(
      state.copyWith(
        allergy: Allergy.dirty(event.name),
        isFormValid: Formz.validate(
          [Allergy.dirty(event.name)],
        ),
      ),
    );
  }

  void onEditAllergyName(String name) {
    add(EditAllergyName(name: name));
  }

  void resetAllergy() {
    add(ResetAllergy());
  }

  Future<void> submitAllergy() async {
    add(PostCreateAllergy());
    if (!state.isFormValid) return;
    try {
      await allergiesRepository
          .createAllergy(CreateAllergyModel(name: state.allergy.value));
      resetAllergy();
      appRouter.push('/home');
    } catch (e) {
      rethrow;
    }
  }
}

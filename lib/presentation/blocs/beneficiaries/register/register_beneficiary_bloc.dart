import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/parent_model.dart';
import 'package:communitary_service_app/domain/models/medical_history/medical_history_model.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_parent/form_parent_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/medical_history_form/medical_history_form_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/register/register_beneficiary_event.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/register/register_beneficiary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBeneficiaryBloc
    extends Bloc<RegisterBeneficiaryEvent, RegisterBeneficiaryState> {
  final FormBeneficiaryBloc formBeneficiaryBloc;
  final FormParentBloc formParentBloc;
  final MedicalHistoryFormBloc medicalHistoryFormBloc;
  final BeneficiariesRepository repository;

  RegisterBeneficiaryBloc(this.formBeneficiaryBloc, this.formParentBloc,
      this.medicalHistoryFormBloc, this.repository)
      : super(RegisterBeneficiaryState.initial()) {
    on<RegisterBeneficiaryEvent>(_onRegisterBeneficiary);
  }

  void _onRegisterBeneficiary(
    RegisterBeneficiaryEvent event,
    Emitter<RegisterBeneficiaryState> emit,
  ) async {
    emit(state.copyWith(status: RegisterBeneficiaryStatus.loading));
    try {
      await repository.registerBeneficiary(_fromStateToModel());
      emit(state.copyWith(status: RegisterBeneficiaryStatus.success));
    } catch (e) {
      rethrow;
    }
  }

  BeneficiaryModel _fromStateToModel() {
    return BeneficiaryModel(
      id: '',
      name: formBeneficiaryBloc.state.beneficiaryName.value,
      lastname: formBeneficiaryBloc.state.beneficiaryLastname.value,
      birthday: formBeneficiaryBloc.state.beneficiaryBirthday.value!,
      isPlayingSports: formBeneficiaryBloc.state.isPlayingSports,
      gender: formBeneficiaryBloc.state.beneficiaryGender.value.name,
      parent: ParentModel(
        name: formParentBloc.state.name.value,
        lastname: formParentBloc.state.lastname.value,
        phoneNumber: formParentBloc.state.phoneNumber.value,
      ),
      medicalHistory: MedicalHistoryModel(
        height: medicalHistoryFormBloc.state.height.value,
        weight: medicalHistoryFormBloc.state.weight.value,
      ),
      allergies: medicalHistoryFormBloc.state.allergies,
    );
  }

  Future<void> submit() async {
    final isValid = formBeneficiaryBloc.state.isValid &&
        formParentBloc.state.isValid &&
        medicalHistoryFormBloc.state.isValid;
    if (isValid) {
      try {
        await repository.registerBeneficiary(_fromStateToModel());
        reset();
        appRouter.go('/home');
      } catch (e) {
        rethrow;
      }
    }
  }

  void reset() {
    formBeneficiaryBloc.reset();
    formParentBloc.reset();
    medicalHistoryFormBloc.reset();
  }
}

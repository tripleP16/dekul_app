import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_event.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/birthday.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/gender.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FormBeneficiaryBloc
    extends Bloc<FormBeneficiaryEvent, FormBeneficiaryState> {
  FormBeneficiaryBloc() : super(FormBeneficiaryState.initial()) {
    on<NameChanged>(_onNameChanged);
    on<LastnameChanged>(_onLastnameChanged);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<GenderChanged>(_onGenderChanged);
    on<PlayingSportsChanged>(_onPlayingSportsChanged);
    on<FormPosted>(_onFormPosted);
    on<FormReset>(_onFormReset);
  }

  void _onNameChanged(NameChanged event, Emitter<FormBeneficiaryState> emit) {
    emit(state.copyWith(
      beneficiaryName: Name.dirty(event.name),
      status: event.status,
    ));
  }

  void _onLastnameChanged(
      LastnameChanged event, Emitter<FormBeneficiaryState> emit) {
    emit(state.copyWith(
      beneficiaryLastname: Lastname.dirty(event.lastname),
      status: event.status,
    ));
  }

  void _onBirthdayChanged(
      BirthdayChanged event, Emitter<FormBeneficiaryState> emit) {
    emit(state.copyWith(
      beneficiaryBirthday: Birthday.dirty(event.birthday),
      status: event.status,
    ));
  }

  void _onGenderChanged(
      GenderChanged event, Emitter<FormBeneficiaryState> emit) {
    emit(state.copyWith(
      beneficiaryGender: GenderInput.dirty(event.gender),
      status: event.status,
    ));
  }

  void _onPlayingSportsChanged(
      PlayingSportsChanged event, Emitter<FormBeneficiaryState> emit) {
    emit(state.copyWith(
      isPlayingSports: event.playingSports,
      status: event.status,
    ));
  }

  void _onFormPosted(FormPosted event, Emitter<FormBeneficiaryState> emit) {
    emit(
      state.copyWith(
        status: event.status,
        beneficiaryBirthday: Birthday.dirty(state.beneficiaryBirthday.value),
        beneficiaryGender: GenderInput.dirty(state.beneficiaryGender.value),
        isPlayingSports: state.isPlayingSports,
        beneficiaryName: Name.dirty(state.beneficiaryName.value),
        beneficiaryLastname: Lastname.dirty(state.beneficiaryLastname.value),
        isValid: Formz.validate(
          [
            state.beneficiaryName,
            state.beneficiaryLastname,
            state.beneficiaryBirthday,
            state.beneficiaryGender,
          ],
        ),
      ),
    );

    if (state.isValid) {
      appRouter.push('/beneficiaries/parent');
    }
  }

  void _onFormReset(FormReset event, Emitter<FormBeneficiaryState> emit) {
    emit(FormBeneficiaryState.initial());
  }

  void changeName(String name) {
    add(NameChanged(
      name: name,
      status: FormBeneficiaryStatus.touched,
    ));
  }

  void changeLastName(String lastName) {
    add(LastnameChanged(
      lastname: lastName,
      status: FormBeneficiaryStatus.touched,
    ));
  }

  void birthdayChanged(DateTime birthday) {
    add(BirthdayChanged(
      birthday: birthday,
      status: FormBeneficiaryStatus.touched,
    ));
  }

  void genderChanged(Gender gender) {
    add(GenderChanged(
      gender: gender,
      status: FormBeneficiaryStatus.touched,
    ));
  }

  void playingSportsChanged(bool playingSports) {
    add(PlayingSportsChanged(
      playingSports: playingSports,
      status: FormBeneficiaryStatus.touched,
    ));
  }

  void submit() {
    add(FormPosted(
      status: FormBeneficiaryStatus.posted,
    ));
  }

  void reset() {
    add(
      FormReset(status: FormBeneficiaryStatus.pure),
    );
  }
}

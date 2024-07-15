import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_parent/form_parent_event.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_parent/form_parent_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../shared/form_inputs/lastname.dart';
import '../../../shared/form_inputs/phone_number.dart';

class FormParentBloc extends Bloc<FormParentEvent, FormParentState> {
  FormParentBloc() : super(const FormParentState.initial()) {
    on<OnParentNameChanged>(_onParentNameChanged);
    on<OnParentLastNameChanged>(_onParentLastnameChanged);
    on<OnParentPhoneChanged>(_onParentPhoneChanged);
    on<OnParentFormPosted>(_onParentFormPosted);
    on<OnParentFormValid>(_onParentFormValid);
    on<OnParentFormReset>(_onParentFormReset);
  }

  void _onParentNameChanged(
    OnParentNameChanged event,
    Emitter<FormParentState> emit,
  ) {
    emit(state.copyWith(
      name: Name.dirty(event.parentName),
      status: event.parentState,
    ));
  }

  void _onParentLastnameChanged(
    OnParentLastNameChanged event,
    Emitter<FormParentState> emit,
  ) {
    emit(state.copyWith(
      lastname: Lastname.dirty(event.parentLastname),
      status: event.parentState,
    ));
  }

  void _onParentPhoneChanged(
    OnParentPhoneChanged event,
    Emitter<FormParentState> emit,
  ) {
    emit(state.copyWith(
      phoneNumber: PhoneNumber.dirty(event.parentPhone),
      status: event.parentState,
    ));
  }

  void _onParentFormPosted(
    OnParentFormPosted event,
    Emitter<FormParentState> emit,
  ) {
    emit(state.copyWith(
        status: event.parentState,
        name: Name.dirty(state.name.value),
        lastname: Lastname.dirty(state.lastname.value),
        phoneNumber: PhoneNumber.dirty(state.phoneNumber.value),
        isValid: Formz.validate([
          state.name,
          state.lastname,
          state.phoneNumber,
        ])));
    if (state.isValid) {
      add(OnParentFormValid());
    }
  }

  void _onParentFormValid(
    OnParentFormValid event,
    Emitter<FormParentState> emit,
  ) {
    appRouter.push('/beneficiaries/medical_history');
  }

  void _onParentFormReset(
    OnParentFormReset event,
    Emitter<FormParentState> emit,
  ) {
    emit(const FormParentState.initial());
  }

  void setName(String name) {
    add(OnParentNameChanged(
      parentName: name,
      parentState: FormParentStatus.touched,
    ));
  }

  void setLastname(String lastname) {
    add(OnParentLastNameChanged(
      parentLastname: lastname,
      parentState: FormParentStatus.touched,
    ));
  }

  void setPhone(String phone) {
    add(OnParentPhoneChanged(
      parentPhone: phone,
      parentState: FormParentStatus.touched,
    ));
  }

  void submit() {
    add(
      OnParentFormPosted(
        parentState: FormParentStatus.posted,
      ),
    );
  }

  void reset() {
    add(
      OnParentFormReset(
        parentState: FormParentStatus.pure,
      ),
    );
  }
}

import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_parent/form_parent_state.dart';

class FormParentEvent {}

class OnParentNameChanged extends FormParentEvent {
  final String parentName;
  final FormParentStatus parentState;

  OnParentNameChanged({
    required this.parentName,
    required this.parentState,
  });
}

class OnParentLastNameChanged extends FormParentEvent {
  final String parentLastname;
  final FormParentStatus parentState;

  OnParentLastNameChanged({
    required this.parentLastname,
    required this.parentState,
  });
}

class OnParentPhoneChanged extends FormParentEvent {
  final String parentPhone;
  final FormParentStatus parentState;

  OnParentPhoneChanged({
    required this.parentPhone,
    required this.parentState,
  });
}

class OnParentFormValid extends FormParentEvent {}

class OnParentFormPosted extends FormParentEvent {
  final FormParentStatus parentState;

  OnParentFormPosted({required this.parentState});
}

class OnParentFormReset extends FormParentEvent {
  final FormParentStatus parentState;

  OnParentFormReset({required this.parentState});
}

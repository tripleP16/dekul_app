import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_state.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/gender.dart';

class FormBeneficiaryEvent {}

class NameChanged extends FormBeneficiaryEvent {
  final String name;
  final FormBeneficiaryStatus status;

  NameChanged({
    required this.name,
    required this.status,
  });
}

class LastnameChanged extends FormBeneficiaryEvent {
  final String lastname;
  final FormBeneficiaryStatus status;
  LastnameChanged({
    required this.lastname,
    required this.status,
  });
}

class BirthdayChanged extends FormBeneficiaryEvent {
  final DateTime birthday;
  final FormBeneficiaryStatus status;

  BirthdayChanged({
    required this.birthday,
    required this.status,
  });
}

class GenderChanged extends FormBeneficiaryEvent {
  final Gender gender;
  final FormBeneficiaryStatus status;
  GenderChanged({
    required this.gender,
    required this.status,
  });
}

class PlayingSportsChanged extends FormBeneficiaryEvent {
  final bool playingSports;
  final FormBeneficiaryStatus status;
  PlayingSportsChanged({
    required this.playingSports,
    required this.status,
  });
}

class FormPosted extends FormBeneficiaryEvent {
  final FormBeneficiaryStatus status;
  FormPosted({
    required this.status,
  });
}

class FormReset extends FormBeneficiaryEvent {
  final FormBeneficiaryStatus status;
  FormReset({
    required this.status,
  });
}

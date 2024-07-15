import 'package:communitary_service_app/presentation/shared/form_inputs/birthday.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/gender.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';

enum FormBeneficiaryStatus {
  pure,
  touched,
  posted,
}

class FormBeneficiaryState {
  final Name beneficiaryName;
  final Lastname beneficiaryLastname;
  final Birthday beneficiaryBirthday;
  final GenderInput beneficiaryGender;
  final bool isPlayingSports;
  final FormBeneficiaryStatus status;
  final bool isValid;

  FormBeneficiaryState({
    required this.beneficiaryName,
    required this.beneficiaryLastname,
    required this.beneficiaryBirthday,
    required this.beneficiaryGender,
    required this.isPlayingSports,
    required this.status,
    required this.isValid,
  });

  factory FormBeneficiaryState.initial() {
    return FormBeneficiaryState(
      beneficiaryName: const Name.pure(),
      beneficiaryLastname: const Lastname.pure(),
      beneficiaryBirthday: const Birthday.pure(),
      beneficiaryGender: const GenderInput.pure(),
      isPlayingSports: false,
      status: FormBeneficiaryStatus.pure,
      isValid: false,
    );
  }

  FormBeneficiaryState copyWith({
    Name? beneficiaryName,
    Lastname? beneficiaryLastname,
    Birthday? beneficiaryBirthday,
    GenderInput? beneficiaryGender,
    bool? isPlayingSports,
    FormBeneficiaryStatus? status,
    bool? isValid,
  }) {
    return FormBeneficiaryState(
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      beneficiaryLastname: beneficiaryLastname ?? this.beneficiaryLastname,
      beneficiaryBirthday: beneficiaryBirthday ?? this.beneficiaryBirthday,
      beneficiaryGender: beneficiaryGender ?? this.beneficiaryGender,
      isPlayingSports: isPlayingSports ?? this.isPlayingSports,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}

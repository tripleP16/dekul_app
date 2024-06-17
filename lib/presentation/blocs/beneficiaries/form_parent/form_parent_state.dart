import 'package:communitary_service_app/presentation/shared/form_inputs/lastname.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/name.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/phone_number.dart';

enum FormParentStatus {
  pure,
  touched,
  posted,
}

class FormParentState {
  final Name name;
  final Lastname lastname;
  final PhoneNumber phoneNumber;
  final FormParentStatus status;
  final bool isValid;

  const FormParentState({
    required this.name,
    required this.lastname,
    required this.phoneNumber,
    required this.status,
    required this.isValid,
  });

  FormParentState copyWith({
    Name? name,
    Lastname? lastname,
    PhoneNumber? phoneNumber,
    FormParentStatus? status,
    bool? isValid,
  }) {
    return FormParentState(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  const FormParentState.initial()
      : this(
          name: const Name.pure(),
          lastname: const Lastname.pure(),
          phoneNumber: const PhoneNumber.pure(),
          status: FormParentStatus.pure,
          isValid: false,
        );
}

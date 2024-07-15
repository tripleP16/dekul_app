import 'package:communitary_service_app/presentation/shared/form_inputs/allergy.dart';

enum CreateAllergiesFormStatus { inavlid, posted, error, initial }

class CreateAllergiesState {
  final Allergy allergy;
  final CreateAllergiesFormStatus status;
  final bool isFormValid;

  CreateAllergiesState(
      {required this.allergy, required this.status, required this.isFormValid});

  factory CreateAllergiesState.initial() => CreateAllergiesState(
        allergy: const Allergy.pure(),
        status: CreateAllergiesFormStatus.initial,
        isFormValid: false,
      );
  CreateAllergiesState copyWith(
      {Allergy? allergy,
      CreateAllergiesFormStatus? status,
      bool? isFormValid}) {
    return CreateAllergiesState(
      isFormValid: isFormValid ?? this.isFormValid,
      allergy: allergy ?? this.allergy,
      status: status ?? this.status,
    );
  }
}

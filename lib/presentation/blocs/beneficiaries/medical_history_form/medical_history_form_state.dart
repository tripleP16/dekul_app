import 'package:communitary_service_app/presentation/shared/form_inputs/height.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/weight.dart';

import '../../../../domain/models/allergies/allergies_model.dart';
import '../../../shared/widgets/view_models/custom_chip_view_model.dart';

enum MedicalHistoryFormStatus { initial, loading, dirty, posted }

class MedicalHistoryFormState {
  final Height height;
  final Weight weight;
  final List<AllergiesModel> allergies;
  final MedicalHistoryFormStatus status;
  final bool isValid;

  MedicalHistoryFormState({
    required this.height,
    required this.weight,
    required this.allergies,
    required this.status,
    required this.isValid,
  });

  factory MedicalHistoryFormState.initial() {
    return MedicalHistoryFormState(
      height: const Height.pure(),
      weight: const Weight.pure(),
      isValid: false,
      allergies: [],
      status: MedicalHistoryFormStatus.initial,
    );
  }

  MedicalHistoryFormState copyWith({
    Height? height,
    Weight? weight,
    List<AllergiesModel>? allergies,
    MedicalHistoryFormStatus? status,
    bool? isValid,
  }) {
    return MedicalHistoryFormState(
      isValid: isValid ?? this.isValid,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      allergies: allergies ?? this.allergies,
      status: status ?? this.status,
    );
  }

  List<CustomChipViewModel> getCustomChipViewModels() {
    return allergies
        .map((allergy) => CustomChipViewModel(
              label: allergy.name,
              value: allergy.id,
            ))
        .toList();
  }
}

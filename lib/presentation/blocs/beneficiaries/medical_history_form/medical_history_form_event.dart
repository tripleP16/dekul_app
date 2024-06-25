import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/medical_history_form/medical_history_form_state.dart';

class MedicalHistoryFormEvent {}

class MedicalHistoryChangedHeight extends MedicalHistoryFormEvent {
  final int height;

  MedicalHistoryChangedHeight({required this.height});
}

class MedicalHistoryChangedWeight extends MedicalHistoryFormEvent {
  final double weight;

  MedicalHistoryChangedWeight({required this.weight});
}

class MedicalHistoryAddedAllergy extends MedicalHistoryFormEvent {
  final AllergiesModel allergy;

  MedicalHistoryAddedAllergy({required this.allergy});
}

class MedicalHistoryRemovedAllergy extends MedicalHistoryFormEvent {
  final AllergiesModel allergy;

  MedicalHistoryRemovedAllergy({required this.allergy});
}

class MedicalHistoryPosted extends MedicalHistoryFormEvent {
  final MedicalHistoryFormStatus status;

  MedicalHistoryPosted({required this.status});
}

class MedicalHistoryReset extends MedicalHistoryFormEvent {
  final MedicalHistoryFormStatus status;

  MedicalHistoryReset({required this.status});
}

import 'package:communitary_service_app/presentation/blocs/update_medical_history/update_medical_history_state.dart';

abstract class UpdateMedicalHistoryEvent {}

class InputHeightEvent extends UpdateMedicalHistoryEvent {
  final int height;

  InputHeightEvent({required this.height});
}

class InputWeightEvent extends UpdateMedicalHistoryEvent {
  final double weight;
  InputWeightEvent({required this.weight});
}

class PostUpdateMedicalHistoryEvent extends UpdateMedicalHistoryEvent {
  final UpdateMedicalHistoryFormState formState;

  PostUpdateMedicalHistoryEvent({required this.formState});
}

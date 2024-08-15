import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/parent_model.dart';
import 'package:communitary_service_app/domain/models/medical_history/medical_history_model.dart';

enum BeneficiaryBMIState {
  ok,
  warning,
  danger,
}

class GetBeneficiaryModel {
  final String id;
  final String name;
  final String lastname;
  final DateTime birthday;
  final bool isPlayingSports;
  final String gender;
  final ParentModel parent;
  final List<MedicalHistoryModel> medicalHistory;
  final List<AllergiesModel> allergies;
  final bool needsMedicalHistoryUpdate;
  const GetBeneficiaryModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.birthday,
    required this.isPlayingSports,
    required this.gender,
    required this.parent,
    required this.medicalHistory,
    required this.allergies,
    required this.needsMedicalHistoryUpdate,
  });

  int get age => DateTime.now().year - birthday.year;

  String get fullName => '$name $lastname';

  String get allergiesString =>
      allergies.map((allergy) => allergy.name).join(', ');

  MedicalHistoryModel? get latestMedicalHistory {
    if (medicalHistory.isEmpty) return null;

    return medicalHistory.reduce((current, next) =>
        current.createdAt.isAfter(next.createdAt) ? current : next);
  }

  String get currentHeight {
    final medicalHistory = latestMedicalHistory;
    if (medicalHistory == null) return 'Desconocido';

    return '${medicalHistory.height} cm';
  }

  String get currentWeight {
    final medicalHistory = latestMedicalHistory;
    if (medicalHistory == null) return 'Desconocido';

    return '${medicalHistory.weight} kg';
  }

  String get currentBMI {
    final medicalHistory = latestMedicalHistory;
    if (medicalHistory == null) return 'Desconocido';

    final double weight = medicalHistory.weight;
    final double height = medicalHistory.height / 100.0;
    final double bmi = weight / (height * height);

    return bmi.toStringAsFixed(2);
  }

  BeneficiaryBMIState get bmiState {
    final medicalHistory = latestMedicalHistory;
    if (medicalHistory == null) return BeneficiaryBMIState.warning;

    final double bmi = double.tryParse(currentBMI) ?? 0;

    if (bmi < 18.5 || bmi >= 25) {
      return BeneficiaryBMIState.danger;
    } else if (bmi >= 18.5 && bmi < 18.9 || bmi >= 24.5 && bmi < 25) {
      return BeneficiaryBMIState.warning;
    } else {
      return BeneficiaryBMIState.ok;
    }
  }
}

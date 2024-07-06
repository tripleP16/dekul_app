import 'package:communitary_service_app/domain/models/beneficiaries/parent_model.dart';
import 'package:communitary_service_app/domain/models/medicalHistory/medical_history_model.dart';

import '../allergies/allergies_model.dart';

class BeneficiaryModel {
  final String id;
  final String name;
  final String lastname;
  final DateTime birthday;
  final bool isPlayingSports;
  final String gender;
  final ParentModel parent;
  final MedicalHistoryModel medicalHistory;
  final List<AllergiesModel> allergies;

  const BeneficiaryModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.birthday,
    required this.isPlayingSports,
    required this.gender,
    required this.parent,
    required this.medicalHistory,
    required this.allergies,
  });

  int get age => DateTime.now().year - birthday.year;
}

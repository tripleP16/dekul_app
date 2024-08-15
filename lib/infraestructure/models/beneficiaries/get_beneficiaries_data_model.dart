import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/get_beneficiary_model.dart';
import 'package:communitary_service_app/infraestructure/models/allergies/allergies_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/beneficiaries/parent_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/medical_history/medical_history_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_beneficiaries_data_model.g.dart';

@JsonSerializable()
class GetBeneficiariesDataModel {
  final String id;
  final String name;
  final String lastname;
  final DateTime birthday;
  final bool isPlayingSports;
  final String gender;
  final ParentDataModel parent;
  final List<MedicalHistoryDataModel> medicalHistories;
  final List<AllergiesDataModel> alergies;
  final bool? needsMedicalHistoryUpdate;

  GetBeneficiariesDataModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.birthday,
    required this.isPlayingSports,
    required this.gender,
    required this.parent,
    required this.medicalHistories,
    required this.alergies,
    required this.needsMedicalHistoryUpdate,
  });

  factory GetBeneficiariesDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetBeneficiariesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetBeneficiariesDataModelToJson(this);

  factory GetBeneficiariesDataModel.fromDomain(BeneficiaryModel domain) {
    return GetBeneficiariesDataModel(
      id: domain.id,
      name: domain.name,
      lastname: domain.lastname,
      birthday: domain.birthday,
      isPlayingSports: domain.isPlayingSports,
      gender: domain.gender,
      parent: ParentDataModel.fromDomain(domain.parent),
      medicalHistories: [
        MedicalHistoryDataModel.fromDomain(domain.medicalHistory)
      ],
      alergies: domain.allergies
          .map((e) => AllergiesDataModel.fromDomain(e))
          .toList(),
      needsMedicalHistoryUpdate: false,
    );
  }

  GetBeneficiaryModel toGetDomain() => GetBeneficiaryModel(
        id: id,
        name: name,
        lastname: lastname,
        birthday: birthday,
        isPlayingSports: isPlayingSports,
        gender: gender,
        parent: parent.toDomain(),
        medicalHistory: medicalHistories.map((e) => e.toDomain()).toList(),
        allergies: alergies.map((e) => e.toDomain()).toList(),
        needsMedicalHistoryUpdate: needsMedicalHistoryUpdate ?? false,
      );

  BeneficiaryModel toDomain() => BeneficiaryModel(
        id: id,
        name: name,
        lastname: lastname,
        birthday: birthday,
        isPlayingSports: isPlayingSports,
        gender: gender,
        parent: parent.toDomain(),
        medicalHistory: medicalHistories.first.toDomain(),
        allergies: alergies.map((e) => e.toDomain()).toList(),
        needsMedicalHistoryUpdate: needsMedicalHistoryUpdate ?? false,
      );
}

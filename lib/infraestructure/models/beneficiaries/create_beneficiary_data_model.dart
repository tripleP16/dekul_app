import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/infraestructure/models/beneficiaries/parent_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/medical_history/medical_history_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_id_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_beneficiary_data_model.g.dart';

@JsonSerializable()
class CreateBeneficiaryDataModel {
  final String name;
  final String lastname;
  final DateTime birthday;
  final bool isPlayingSports;
  final String gender;
  final ParentDataModel parent;
  final MedicalHistoryDataModel medicalHistory;
  final List<BaseIdDataModel> allergies;

  CreateBeneficiaryDataModel({
    required this.name,
    required this.lastname,
    required this.birthday,
    required this.isPlayingSports,
    required this.gender,
    required this.parent,
    required this.medicalHistory,
    required this.allergies,
  });

  factory CreateBeneficiaryDataModel.fromJson(Map<String, dynamic> json) =>
      _$CreateBeneficiaryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBeneficiaryDataModelToJson(this);

  factory CreateBeneficiaryDataModel.fromDomain(BeneficiaryModel domain) {
    return CreateBeneficiaryDataModel(
      name: domain.name,
      lastname: domain.lastname,
      birthday: domain.birthday,
      isPlayingSports: domain.isPlayingSports,
      gender: domain.gender,
      parent: ParentDataModel.fromDomain(domain.parent),
      medicalHistory: MedicalHistoryDataModel.fromDomain(domain.medicalHistory),
      allergies:
          domain.allergies.map((e) => BaseIdDataModel(id: e.id)).toList(),
    );
  }
}

import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/medicalHistory/medical_history_model.dart';

part 'medical_history_data_model.g.dart';

@JsonSerializable()
class MedicalHistoryDataModel {
  final int height;
  final double weight;
  final DateTime createdAt;

  MedicalHistoryDataModel({
    required this.height,
    required this.weight,
    required this.createdAt,
  });

  factory MedicalHistoryDataModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalHistoryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalHistoryDataModelToJson(this);

  factory MedicalHistoryDataModel.fromDomain(MedicalHistoryModel domain) {
    return MedicalHistoryDataModel(
      height: domain.height,
      weight: domain.weight,
      createdAt: domain.createdAt,
    );
  }

  MedicalHistoryModel toDomain() => MedicalHistoryModel(
        height: height,
        weight: weight,
        createdAt: createdAt,
      );
}

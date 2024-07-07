class MedicalHistoryModel {
  final int height;
  final double weight;
  final DateTime createdAt;

  MedicalHistoryModel({
    required this.height,
    required this.weight,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

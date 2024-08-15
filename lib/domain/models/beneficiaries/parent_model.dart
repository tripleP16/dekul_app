class ParentModel {
  final String? id;
  final String name;
  final String lastname;
  final String phoneNumber;

  ParentModel({
    this.id,
    required this.name,
    required this.lastname,
    required this.phoneNumber,
  });

  String get fullName => '$name $lastname';
}

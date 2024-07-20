class UsersModel {
  final String id;
  final String name;
  final String lastname;
  final String email;

  const UsersModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
  });

  String get fullName => '$name $lastname';
}

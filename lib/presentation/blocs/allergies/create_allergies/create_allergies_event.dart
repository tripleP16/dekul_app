abstract class CreateAllergiesEvent {}

class EditAllergyName extends CreateAllergiesEvent {
  final String name;

  EditAllergyName({
    required this.name,
  });
}

class PostCreateAllergy extends CreateAllergiesEvent {}

class ResetAllergy extends CreateAllergiesEvent {}

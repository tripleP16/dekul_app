import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:communitary_service_app/domain/models/allergies/create_allergy_model.dart';

abstract class AllergiesRepository {
  Future<List<AllergiesModel>> getAllergies();
  Future<void> createAllergy(CreateAllergyModel model);
}

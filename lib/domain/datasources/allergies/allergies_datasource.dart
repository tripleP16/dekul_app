import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';

abstract class AllergiesDataSource {
  Future<List<AllergiesModel>> getAllergies();
}

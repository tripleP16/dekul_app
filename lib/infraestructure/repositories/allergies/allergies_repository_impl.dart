import 'package:communitary_service_app/domain/datasources/allergies/allergies_datasource.dart';
import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:communitary_service_app/domain/repositories/allergies/allergy_repository.dart';

class AllergiesRepositoryImpl implements AllergiesRepository {
  final AllergiesDataSource _allergiesDataSource;

  AllergiesRepositoryImpl({required AllergiesDataSource allergiesDataSource})
      : _allergiesDataSource = allergiesDataSource;

  @override
  Future<List<AllergiesModel>> getAllergies() {
    return _allergiesDataSource.getAllergies();
  }
}

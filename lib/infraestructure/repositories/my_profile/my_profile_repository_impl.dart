import 'package:communitary_service_app/domain/datasources/my_profile/my_profile_datasource.dart';
import 'package:communitary_service_app/domain/models/my_profile/get_my_profile_model.dart';
import 'package:communitary_service_app/domain/models/my_profile/update_my_profile_model.dart';
import 'package:communitary_service_app/domain/repositories/my_profile/my_profile_repository.dart';

class MyProfileRepositoryImpl implements MyProfileRepository {
  final MyProfileDatasource datasource;

  const MyProfileRepositoryImpl({required this.datasource});
  @override
  Future<GetMyProfileModel> getMyProfile() {
    return datasource.getMyProfile();
  }

  @override
  Future<void> update(UpdateMyProfileModel model) {
    return datasource.update(model);
  }
}

import 'package:communitary_service_app/domain/models/my_profile/get_my_profile_model.dart';
import 'package:communitary_service_app/domain/models/my_profile/update_my_profile_model.dart';

abstract class MyProfileRepository {
  Future<GetMyProfileModel> getMyProfile();
  Future<void> update(UpdateMyProfileModel model);
}

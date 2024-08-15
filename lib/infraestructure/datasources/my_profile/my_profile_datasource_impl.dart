import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/my_profile/my_profile_datasource.dart';
import 'package:communitary_service_app/domain/models/my_profile/get_my_profile_model.dart';
import 'package:communitary_service_app/domain/models/my_profile/update_my_profile_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/my_profile/get_my_profile_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/my_profile/update_my_profile_data_model.dart';
import 'package:communitary_service_app/infraestructure/models/shared/base_response_data_model.dart';
import 'package:dio/dio.dart';

class MyProfileDatasourceImpl extends MyProfileDatasource {
  final IApiService apiService;

  MyProfileDatasourceImpl({required this.apiService});

  @override
  Future<GetMyProfileModel> getMyProfile() async {
    try {
      final response = await apiService.get(url: 'users/me');
      final baseResponse =
          BaseResponseDataModel<GetMyProfileDataModel>.fromJson(
              response.data,
              (json) =>
                  GetMyProfileDataModel.fromJson(json as Map<String, dynamic>));

      return baseResponse.data.toDomain();
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(message: 'Error inesperado, intente mas tarde');
    }
  }

  String _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return 'No autorizado';
      case 409:
        return 'Ese correo ya esta en uso';

      case 400:
        return 'Error en el formulario por favor intente nuevamente';
      default:
        return 'Intente mas tarde';
    }
  }

  @override
  Future<void> update(UpdateMyProfileModel model) async {
    try {
      final body = UpdateMyProfileDataModel.fromDomain(model).toJson();
      await apiService.put(
        url: 'users/me',
        body: body,
      );
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(message: 'Error inesperado, intente mas tarde');
    }
  }
}

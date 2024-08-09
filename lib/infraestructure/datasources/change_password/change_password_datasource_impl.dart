import 'package:communitary_service_app/config/services/contracts/api_service.dart';
import 'package:communitary_service_app/domain/datasources/change_password/change_password_datasource.dart';
import 'package:communitary_service_app/domain/models/change_password/change_password_model.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';
import 'package:communitary_service_app/infraestructure/models/change_password/change_password_data_model.dart';
import 'package:dio/dio.dart';

class ChangePasswordDatasourceImpl implements ChangePasswordDatasource {
  final IApiService apiService;

  ChangePasswordDatasourceImpl({
    required this.apiService,
  });

  @override
  Future<void> changePassword(ChangePasswordModel model) async {
    try {
      final dataModel = ChangePasswordDataModel.fromDomain(model);
      await apiService.put(url: 'password/change', body: dataModel.toJson());
    } on DioException catch (e) {
      throw CustomError(message: _handleDioException(e));
    } catch (e) {
      throw CustomError(message: 'Error desconocido');
    }
  }

  String _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return 'No autorizado';
      case 403:
        return 'La contraseña actual es incorrecta';
      case 400:
        return 'Error en el formulario por favor intente nuevamente';
      default:
        return 'Intente mas tarde';
    }
  }
}

import 'package:communitary_service_app/config/services/models/alert_dialog_model.dart';

abstract class AlertDialogService {
  Future<T?> showNotificationDialog<T>(
    AlertDialogModel model,
  );
}

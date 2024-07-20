import 'dart:convert';

import 'package:communitary_service_app/config/services/contracts/permissions_service.dart';
import 'package:communitary_service_app/config/services/models/permissions_enum.dart';
import 'package:communitary_service_app/config/services/token_service.dart';
import 'package:communitary_service_app/infraestructure/errors/custom_error.dart';

class PermissionsServiceImpl implements PermissionsService {
  @override
  Future<bool> hasAccess(PermissionsEnum permission) async {
    final decoded = await _decode();
    try {
      final actions = decoded['actions'] as List<dynamic>;
      // For debugging purposes, remove this line before production.
      return actions.contains(permission.value);
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> _decode() async {
    final token = await TokenService.getToken();
    final parts = token.split('.');
    if (parts.length != 3) {
      throw CustomError(message: 'Invalid token format');
    }
    final payload = _decodeBase64(parts[1]);
    return json.decode(payload) as Map<String, dynamic>;
  }

  static String _decodeBase64(String input) {
    final normalized = base64Url.normalize(input);
    return utf8.decode(base64Url.decode(normalized));
  }
}

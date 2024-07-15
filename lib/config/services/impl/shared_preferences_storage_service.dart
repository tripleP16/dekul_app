import 'package:communitary_service_app/config/services/contracts/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorageService implements IStorageService {
  late SharedPreferences _sharedPreferences;

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> delete(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<T> read<T>(String key) async {
    return _sharedPreferences.get(key) as T;
  }

  @override
  Future<void> write<T>(String key, T value) {
    switch (T) {
      case String:
        return _sharedPreferences.setString(key, value as String);
      case int:
        return _sharedPreferences.setInt(key, value as int);
      case double:
        return _sharedPreferences.setDouble(key, value as double);
      case bool:
        return _sharedPreferences.setBool(key, value as bool);
      default:
        throw Exception('Unsupported type');
    }
  }
}

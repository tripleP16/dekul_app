abstract class IStorageService {
  Future<void> init();

  Future<T> read<T>(String key);

  Future<void> write<T>(String key, T value);

  Future<void> delete(String key);
}

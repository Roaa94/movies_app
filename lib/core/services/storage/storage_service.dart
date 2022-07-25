abstract class StorageService {
  Future<void> init();

  Future<void> remove(String key);

  dynamic get(String key);

  dynamic getAll();

  Future<void> clear();

  bool has(String key);

  Future<void> set(String? key, dynamic data);

  Future<void> close();
}

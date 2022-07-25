import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

class HiveStorageService implements StorageService {
  late Box hiveBox;

  Future<void> openBox([String boxName = 'MOVES_APP']) async {
    hiveBox = await Hive.openBox(boxName);
  }

  @override
  Future<void> init() async {
    await openBox();
  }

  @override
  Future<void> remove(String key) async {
    hiveBox.delete(key);
  }

  @override
  dynamic get(String key) {
    return hiveBox.get(key);
  }

  @override
  dynamic getAll() {
    return hiveBox.values.toList();
  }

  @override
  bool has(String key) {
    return hiveBox.containsKey(key);
  }

  @override
  Future<void> set(String? key, dynamic data) async {
    hiveBox.put(key, data);
  }

  @override
  Future<void> clear() async {
    await hiveBox.clear();
  }

  @override
  Future<void> close() async {
    await hiveBox.close();
  }
}

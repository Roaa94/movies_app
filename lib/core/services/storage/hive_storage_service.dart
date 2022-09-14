import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

/// [StorageService] interface implementation using the Hive package
///
/// See: https://pub.dev/packages/hive_flutter
class HiveStorageService implements StorageService {
  /// A Hive Box
  late Box hiveBox;

  /// Opens a Hive box by its name
  Future<void> openBox([String boxName = 'MOVES_APP']) async {
    hiveBox = await Hive.openBox<dynamic>(boxName);
  }

  @override
  Future<void> init() async {
    await openBox();
  }

  @override
  Future<void> remove(String key) async {
    await hiveBox.delete(key);
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
    await hiveBox.put(key, data);
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

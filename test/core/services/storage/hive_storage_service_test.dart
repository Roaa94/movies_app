import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:movies_app/core/services/storage/hive_storage_service.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

void main() {
  final StorageService hiveStorageService = HiveStorageService();
  const String testStorageKey = 'test';

  setUp(() async {
    await setUpTestHive();
    await hiveStorageService.init();
  });

  test('Can store & get value', () async {
    hiveStorageService.set(testStorageKey, 'someValue');

    expect(hiveStorageService.get(testStorageKey), 'someValue');
  });

  test('Can check if key exists', () async {
    hiveStorageService.set(testStorageKey, 'someValue');
    expect(hiveStorageService.has(testStorageKey), true);

    hiveStorageService.remove(testStorageKey);
    expect(hiveStorageService.has(testStorageKey), false);
  });

  test('Can delete value', () async {
    hiveStorageService.set(testStorageKey, 'someValue');
    hiveStorageService.remove(testStorageKey);

    expect(hiveStorageService.get(testStorageKey), null);
  });

  test('Can get all values', () async {
    hiveStorageService.set(testStorageKey, 'someValue');
    hiveStorageService.set('test2', 'otherValue');

    expect(hiveStorageService.getAll(), ['someValue', 'otherValue']);
  });

  test('Can clear all values', () async {
    hiveStorageService.set(testStorageKey, 'someValue');
    hiveStorageService.set('test2', 'otherValue');
    await hiveStorageService.clear();

    expect(hiveStorageService.getAll(), []);
  });

  tearDown(() async {
    await hiveStorageService.close();
  });
}

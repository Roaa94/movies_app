import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/services/storage/hive_storage_service.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

final storageServiceProvider = Provider<StorageService>(
  (_) => HiveStorageService(),
);

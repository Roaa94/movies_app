import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/core/models/cache_response.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

const dioCacheForceRefreshKey = 'dio_cache_force_refresh';

class CacheInterceptor implements Interceptor {
  final StorageService storageService;

  CacheInterceptor(this.storageService);

  String _createStorageKey(RequestOptions requestOptions) {
    String storageKey =
        '${requestOptions.method.toUpperCase()}:${requestOptions.baseUrl + requestOptions.path}/';
    if (requestOptions.queryParameters.isNotEmpty) {
      storageKey += '?';
      requestOptions.queryParameters.forEach((key, value) {
        storageKey += '$key=$value&';
      });
    }
    return storageKey;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    String storageKey = _createStorageKey(err.requestOptions);
    final CachedResponse? cachedResponse = _tryCachedResponse(storageKey);
    if (cachedResponse != null) {
      log('❌ ❌ ❌ Dio Error');
      log('📦 📦 📦 Retrieved response from cache');
      final Response response =
          cachedResponse.buildResponse(err.requestOptions);
      log('⬅️ ⬅️ ⬅️ Response');
      log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      log('-------------------------');
      return handler.resolve(response);
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra[dioCacheForceRefreshKey] == true) {
      log('🌍 🌍 🌍 Retrieving request from network');
      return handler.next(options);
    }
    String storageKey = _createStorageKey(options);
    final CachedResponse? cachedResponse = _tryCachedResponse(storageKey);
    if (cachedResponse != null) {
      log('📦 📦 📦 Retrieved response from cache');
      final Response response = cachedResponse.buildResponse(options);
      log('⬅️ ⬅️ ⬅️ Response');
      log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      log('-------------------------');
      return handler.resolve(response);
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String storageKey = _createStorageKey(response.requestOptions);

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      CachedResponse cachedResponse = CachedResponse(
        data: response.data,
        headers: Headers.fromMap(response.headers.map),
        age: DateTime.now(),
        statusCode: response.statusCode!,
      );

      log('Storing request in cache');
      storageService.set(storageKey, cachedResponse.toJson());
    }
    return handler.next(response);
  }

  CachedResponse? _tryCachedResponse(String storageKey) {
    if (storageService.has(storageKey)) {
      final rawCachedResponse = storageService.get(storageKey);
      try {
        final CachedResponse cachedResponse = CachedResponse.fromJson(
            json.decode(json.encode(rawCachedResponse)));
        if (cachedResponse.isValid) {
          return cachedResponse;
        } else {
          log('Cache is outdated, deleting it...');
          storageService.remove(storageKey);
          return null;
        }
      } catch (e) {
        log('Error retrieving response from cache');
        log('e: $e');
        return null;
      }
    }
    return null;
  }
}

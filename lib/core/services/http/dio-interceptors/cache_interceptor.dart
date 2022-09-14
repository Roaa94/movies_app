import 'dart:convert';
import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/core/models/cache_response.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

const dioCacheForceRefreshKey = 'dio_cache_force_refresh_key';

class CacheInterceptor implements Interceptor {
  final StorageService storageService;

  CacheInterceptor(this.storageService);

  @visibleForTesting
  String createStorageKey(
    String method,
    String baseUrl,
    String path, [
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  ]) {
    var storageKey = '${method.toUpperCase()}:${baseUrl + path}/';
    if (queryParameters.isNotEmpty) {
      storageKey += '?';
      queryParameters.forEach((key, dynamic value) {
        storageKey += '$key=$value&';
      });
    }
    return storageKey;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('❌ ❌ ❌ Dio Error!');
    log('❌ ❌ ❌ Url: ${err.requestOptions.uri}');
    log('❌ ❌ ❌ ${err.stackTrace}');
    log('❌ ❌ ❌ Response Errors: ${err.response?.data}');
    var storageKey = createStorageKey(
      err.requestOptions.method,
      err.requestOptions.baseUrl,
      err.requestOptions.path,
      err.requestOptions.queryParameters,
    );
    if (storageService.has(storageKey)) {
      final cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        log('📦 📦 📦 Retrieved response from cache');
        final response = cachedResponse.buildResponse(err.requestOptions);
        log('⬅️ ⬅️ ⬅️ Response');
        log(
          '''
          <---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'}'
          ' ${response.requestOptions.baseUrl}${response.requestOptions.path}''',
        );
        log('Query params: ${response.requestOptions.queryParameters}');
        log('-------------------------');
        return handler.resolve(response);
      }
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra[dioCacheForceRefreshKey] == true) {
      log('🌍 🌍 🌍 Retrieving request from network by force refresh');
      return handler.next(options);
    }
    var storageKey = createStorageKey(
      options.method,
      options.baseUrl,
      options.path,
      options.queryParameters,
    );
    if (storageService.has(storageKey)) {
      final cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        log('📦 📦 📦 Retrieved response from cache');
        final response = cachedResponse.buildResponse(options);
        log('⬅️ ⬅️ ⬅️ Response');
        log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        log('Query params: ${response.requestOptions.queryParameters}');
        log('-------------------------');
        return handler.resolve(response);
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var storageKey = createStorageKey(
      response.requestOptions.method,
      response.requestOptions.baseUrl,
      response.requestOptions.path,
      response.requestOptions.queryParameters,
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      log('🌍 🌍 🌍 Retrieved response from network');
      log('⬅️ ⬅️ ⬅️ Response');
      log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      log('Query params: ${response.requestOptions.queryParameters}');
      log('-------------------------');

      var cachedResponse = CachedResponse(
        data: response.data,
        headers: Headers.fromMap(response.headers.map),
        age: clock.now(),
        statusCode: response.statusCode!,
      );
      storageService.set(storageKey, cachedResponse.toJson());
    }
    return handler.next(response);
  }

  CachedResponse? _getCachedResponse(String storageKey) {
    final dynamic rawCachedResponse = storageService.get(storageKey);
    try {
      final cachedResponse = CachedResponse.fromJson(
        json.decode(json.encode(rawCachedResponse)) as Map<String, dynamic>,
      );
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
}

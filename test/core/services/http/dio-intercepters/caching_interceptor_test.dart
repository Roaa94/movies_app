import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/models/cache_response.dart';
import 'package:movies_app/core/services/http/dio-interceptors/cache_interceptor.dart';
import 'package:movies_app/core/services/http/dio_http_service.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

import '../../../../test-utils/mocks.dart';

void main() {
  late DioHttpService dioHttpService;
  StorageService storageService = MockStorageService();
  late DioAdapter dioAdapter;
  final CacheInterceptor cacheInterceptor = CacheInterceptor(storageService);
  const String baseUrl = 'https://api.test/';

  Map<String, dynamic> headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  Map<String, List<String>> responseHeaders = {
    'content-type': ['application/json; charset=utf-8']
  };

  setUp(() {
    dioAdapter = DioAdapter(
      dio: Dio(
        BaseOptions(baseUrl: baseUrl, headers: headers),
      ),
    );

    dioHttpService = DioHttpService(
      storageService,
      dioOverride: dioAdapter.dio,
      enableCaching: false,
    );

    dioAdapter.dio.interceptors.add(cacheInterceptor);
  });

  test('Creates appropriate storage key from request information', () async {
    const String path = 'storage-key-test';
    final String storageKey = cacheInterceptor.createStorageKey(
      'get',
      baseUrl,
      path,
      {
        'param1': 'value1',
        'param2': 'value2',
      },
    );
    expect(
        storageKey, equals('GET:$baseUrl$path/?param1=value1&param2=value2&'));
  });

  test(
    'creates correct cache response from request information',
    () {
      final Map<String, dynamic> responseData = {'data': 'Success!'};

      CachedResponse cachedResponse = CachedResponse(
        data: responseData,
        headers: Headers.fromMap(responseHeaders),
        age: DateTime(2022, 1, 1, 12, 0),
        statusCode: 200,
      );

      Map<String, dynamic> rawCachedResponse = {
        'data': {'data': 'Success!'},
        'age': '2022-01-01 12:00:00.000',
        'statusCode': 200,
        'headers': {
          'content-type': ['application/json; charset=utf-8'],
        },
      };

      expect(cachedResponse.toJson(), equals(rawCachedResponse));
    },
  );

  test('cache response is invalid when it passes max age', () {
    final Map<String, dynamic> responseData = {'data': 'Success!'};

    CachedResponse cachedResponse = CachedResponse(
      data: responseData,
      headers: Headers.fromMap(responseHeaders),
      age: DateTime(2022, 1, 1, 12, 0),
      statusCode: 200,
    );

    withClock(Clock.fixed(DateTime(2022, 1, 1, 14, 0)), () {
      expect(cachedResponse.isValid, isFalse);
    });
  });

  test('cache response is valid when it is not older than max age', () {
    final Map<String, dynamic> responseData = {'data': 'Success!'};

    CachedResponse cachedResponse = CachedResponse(
      data: responseData,
      headers: Headers.fromMap(responseHeaders),
      age: DateTime(2022, 1, 1, 12, 0),
      statusCode: 200,
    );

    withClock(Clock.fixed(DateTime(2022, 1, 1, 12, 30)), () {
      expect(cachedResponse.isValid, isTrue);
    });
  });

  test(
      'Retrieves data from network when it does not exist, then caches it in storage',
      () async {
    DateTime fetchTime = DateTime(2022, 1, 1, 12, 0);
    const String path = 'retrieve-data-from-network-test';
    final Map<String, dynamic> responseData = {'data': 'Success!'};

    dioAdapter.onGet(
      path,
      (server) => server.reply(200, responseData),
    );

    final String storageKey = cacheInterceptor.createStorageKey(
      'get',
      baseUrl,
      path,
    );

    when(() => storageService.has(storageKey)).thenReturn(false);

    CachedResponse cachedResponse = CachedResponse(
      data: responseData,
      headers: Headers.fromMap(responseHeaders),
      age: fetchTime,
      statusCode: 200,
    );

    when(() => storageService.has(storageKey)).thenReturn(false);
    when(() => storageService.set(storageKey, cachedResponse.toJson()))
        .thenAnswer((_) async {});

    await withClock(Clock.fixed(fetchTime), () async {
      final response = await dioHttpService.get(path);
      expect(response, {'data': 'Success!'});
    });
  });

  test('Retrieves data from cache when it exists and the cache is valid',
      () async {
    DateTime fetchTime = DateTime(2022, 1, 1, 12, 0);
    const String path = 'retrieve-data-from-cache-test';
    final Map<String, dynamic> responseData = {'data': 'Success!'};

    dioAdapter.onGet(
      path,
      (server) => server.reply(200, responseData),
    );

    final String storageKey = cacheInterceptor.createStorageKey(
      'get',
      baseUrl,
      path,
    );

    when(() => storageService.has(storageKey)).thenReturn(true);
    CachedResponse cachedResponse = CachedResponse(
      data: responseData,
      headers: Headers.fromMap(responseHeaders),
      age: fetchTime.subtract(const Duration(minutes: 30)),
      statusCode: 200,
    );

    await withClock(Clock.fixed(fetchTime), () async {
      expect(cachedResponse.isValid, isTrue);

      when(() => storageService.get(storageKey))
          .thenReturn(cachedResponse.toJson());
      final response = await dioHttpService.get(path);
      expect(response, cachedResponse.data);
    });
  });

  test('Retrieves data from network when cache exists but is too old',
      () async {
    DateTime fetchTime = DateTime(2022, 1, 1, 12, 0);
    const String path = 'retrieve-data-from-old-cache-test';
    final Map<String, dynamic> responseData = {'data': 'Success!'};

    dioAdapter.onGet(
      path,
      (server) => server.reply(200, responseData),
    );

    final String storageKey =
        cacheInterceptor.createStorageKey('get', baseUrl, path);

    when(() => storageService.has(storageKey)).thenReturn(true);
    CachedResponse cachedResponse = CachedResponse(
      data: responseData,
      headers: Headers.fromMap(responseHeaders),
      age: fetchTime.subtract(const Duration(hours: 2)),
      statusCode: 200,
    );

    await withClock(Clock.fixed(fetchTime), () async {
      expect(cachedResponse.isValid, isFalse);
      when(() => storageService.get(storageKey))
          .thenReturn(cachedResponse.toJson());

      CachedResponse newCachedResponse = CachedResponse(
        data: responseData,
        headers: Headers.fromMap(responseHeaders),
        age: fetchTime,
        statusCode: 200,
      );

      when(() => storageService.set(storageKey, newCachedResponse.toJson()))
          .thenAnswer((_) async {});

      final response = await dioHttpService.get(path);
      expect(response, responseData);
    });
  });

  test('Retrieves data from network when refresh is forced', () async {
    DateTime fetchTime = DateTime(2022, 1, 1, 12, 0);
    const String path = 'force-refresh-test';
    final Map<String, dynamic> responseData = {'data': 'Success!'};

    dioAdapter.onGet(
      path,
      (server) => server.reply(200, responseData),
    );

    final String storageKey =
        cacheInterceptor.createStorageKey('get', baseUrl, path);

    CachedResponse refreshedCachedResponse = CachedResponse(
      data: responseData,
      headers: Headers.fromMap(responseHeaders),
      age: fetchTime,
      statusCode: 200,
    );

    when(() => storageService.set(storageKey, refreshedCachedResponse.toJson()))
        .thenAnswer((_) async {});

    await withClock(Clock.fixed(fetchTime), () async {
      final response = await dioHttpService.get(
        path,
        forceRefresh: true,
      );

      expect(response, responseData);
    });
  });

  test(
    'Retrieves data from cache when an error occurs and the cache exists',
    () async {
      DateTime fetchTime = DateTime(2022, 1, 1, 12, 0);
      const String path = '404-get-request-test';
      dioAdapter.onGet(
        path,
        (server) => server.reply(404, {'error': 'no data returned!'}),
      );

      final String storageKey =
          cacheInterceptor.createStorageKey('get', baseUrl, path);
      when(() => storageService.has(storageKey)).thenReturn(true);

      CachedResponse cachedResponse = CachedResponse(
        data: {'data': 'Success!'},
        headers: Headers.fromMap(responseHeaders),
        age: fetchTime,
        statusCode: 200,
      );
      when(() => storageService.get(storageKey))
          .thenReturn(cachedResponse.toJson());

      await withClock(Clock.fixed(fetchTime), () async {
        final response = await dioHttpService.get(
          path,
          forceRefresh: true,
        );

        expect(response, cachedResponse.data);
      });
    },
  );

  test(
    'Throws error when http error occurs and no cache exists',
    () async {
      const String path = '404-get-request-test';
      dioAdapter.onGet(
        path,
        (server) => server.reply(404, {'error': 'no data returned!'}),
      );

      final String storageKey =
          cacheInterceptor.createStorageKey('get', baseUrl, path);
      when(() => storageService.has(storageKey)).thenReturn(false);

      expect(() => dioHttpService.get(path), throwsA(isA<DioError>()));
      // expect(() async => await dioHttpService.get('404-get-request-test'),
      //     throwsA(isA<HttpException>()));
      //
      // try {
      //   await dioHttpService.get('404-get-request-test');
      // } on HttpException catch (e) {
      //   expect(e.title, 'Http Error!');
      //   expect(e.statusCode, 404);
      // }
    },
  );
}

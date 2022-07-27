import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:movies_app/core/exceptions/http_exception.dart';
import 'package:movies_app/core/services/http/dio_http_service.dart';
import 'package:movies_app/core/services/storage/storage_service.dart';

import '../../../test-utils/mocks.dart';

void main() {
  late DioHttpService dioHttpService;
  StorageService storageService = MockStorageService();
  late DioAdapter dioAdapter;

  setUp(() {
    dioAdapter = DioAdapter(
      dio: Dio(
        BaseOptions(
          baseUrl: 'https://api.test/',
          // To handle errors manually rather than by Dio
          validateStatus: (status) => true,
          headers: {
            'accept': 'application/json',
            'content-type': 'application/json'
          },
        ),
      ),
    );

    dioHttpService = DioHttpService(
      storageService,
      dioOverride: dioAdapter.dio,
      enableCaching: false,
    );
  });

  test('Successful Get Request', () async {
    dioAdapter.onGet(
      'successful-get-request-test',
      (server) => server.reply(200, {'data': 'Success!'}),
    );

    final response = await dioHttpService.get(
      'successful-get-request-test',
    );

    expect(response, {'data': 'Success!'});
  });

  test('404 Get Request', () async {
    dioAdapter.onGet(
      '404-get-request-test',
      (server) => server.reply(404, {'error': '404 Error!'}),
    );

    expect(() async => await dioHttpService.get('404-get-request-test'),
        throwsA(isA<HttpException>()));

    try {
      await dioHttpService.get('404-get-request-test');
    } on HttpException catch (e) {
      expect(e.title, 'Http Error!');
      expect(e.statusCode, 404);
    }
  });

  test('Successful Post Request', () async {
    dioAdapter.onPost(
      'successful-post-request-test',
      (server) => server.reply(200, {'data': 'Success!'}),
    );

    final response =
        await dioHttpService.post('successful-post-request-test');

    expect(response, {'data': 'Success!'});
  });

  test('404 Post Request', () async {
    dioAdapter.onPost(
      '404-post-request-test',
      (server) => server.reply(404, {'error': '404 Error!'}),
    );

    expect(
      () async => await dioHttpService.post('404-post-request-test'),
      throwsA(isA<HttpException>()),
    );

    try {
      await dioHttpService.post('404-post-request-test');
    } on HttpException catch (e) {
      expect(e.title, 'Http Error!');
      expect(e.statusCode, 404);
    }
  });

  test('Unimplemented methods', () async {
    expect(
      () async => await dioHttpService.delete(),
      throwsA(isA<UnimplementedError>()),
    );
    expect(
      () async => await dioHttpService.put(),
      throwsA(isA<UnimplementedError>()),
    );
  });

  group('CacheInterceptor tests', () {
    // Todo: test CacheInterceptor
  });

  group('LoggingInterceptor tests', () {
    // Todo: test LoggingInterceptor
  });
}

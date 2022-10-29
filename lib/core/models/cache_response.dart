import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/configs/configs.dart';

/// Model for the response returned from HTTP Cache
class CachedResponse {
  /// Creates an instance of [CachedResponse]
  CachedResponse({
    required this.data,
    required this.age,
    required this.statusCode,
    required this.headers,
  });

  /// Creates an instance of [CachedResponse] parsed raw data
  factory CachedResponse.fromJson(Map<String, dynamic> data) {
    return CachedResponse(
      data: data['data'],
      age: DateTime.parse(data['age'] as String),
      statusCode: data['statusCode'] as int,
      headers: Headers.fromMap(
        Map<String, List<dynamic>>.from(
          json.decode(json.encode(data['headers'])) as Map<dynamic, dynamic>,
        ).map(
          (k, v) => MapEntry(k, List<String>.from(v)),
        ),
      ),
    );
  }

  /// The data inside the cached response
  final dynamic data;

  /// The age of the cached response
  ///
  /// This is used to determine whether the cache has expired or not
  /// based on the [Configs.maxCacheAge] value
  ///
  /// see [isValid]
  final DateTime age;

  /// The http status code of the cached http response
  final int statusCode;

  /// The cached http response headers
  final Headers headers;

  /// Determines if a cached response has expired
  ///
  /// A cached response is expired when its [age] is older
  /// than the [Configs.maxCacheAge]
  bool get isValid => clock.now().isBefore(age.add(Configs.maxCacheAge));

  /// Converts data to json Map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data,
      'age': age.toString(),
      'statusCode': statusCode,
      'headers': headers.map,
    };
  }

  /// Builds a dio response from a [RequestOptions] object
  Response<dynamic> buildResponse(RequestOptions options) {
    return Response<dynamic>(
      data: data,
      headers: headers,
      requestOptions: options.copyWith(extra: options.extra),
      statusCode: statusCode,
    );
  }
}

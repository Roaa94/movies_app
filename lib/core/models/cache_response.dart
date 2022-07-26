import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_app/core/configs/configs.dart';

class CachedResponse {
  final dynamic data;
  final DateTime age;
  final int statusCode;
  final Headers headers;

  CachedResponse({
    required this.data,
    required this.age,
    required this.statusCode,
    required this.headers,
  });

  bool get isValid => DateTime.now().isBefore(age.add(Configs.maxCacheAge));

  factory CachedResponse.fromJson(Map<String, dynamic> data) {
    return CachedResponse(
      data: data['data'],
      age: DateTime.parse(data['age']),
      statusCode: data['statusCode'],
      headers: Headers.fromMap((Map<String, List<dynamic>>.from(
          json.decode(json.encode(data['headers']))))
          .map(
            (k, v) => MapEntry(k, List<String>.from(v)),
      )),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'age': age.toString(),
      'statusCode': statusCode,
      'headers': headers.map,
    };
  }

  Response buildResponse(RequestOptions options) {
    return Response(
      data: data,
      headers: headers,
      requestOptions: options.copyWith(extra: options.extra),
      statusCode: statusCode,
    );
  }
}

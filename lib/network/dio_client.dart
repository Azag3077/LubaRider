import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constants.dart';
import 'interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  static String? token;
  bool _isInitialized = false;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  DioClient._internal() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    _dio.interceptors
      ..add(PrettyDioLogger(
          requestBody: true,
          enabled: kDebugMode,
          logPrint: (msg) => log(msg.toString(), name: 'DioLog')))
      ..add(CustomInterceptor());
  }

  Future<void> initializeClient() async {
    if (_isInitialized) return;
    if (!await _hasTokens) return;

    token = await _secureStorage.read(key: userTokenKey);
    _isInitialized = true;
  }

  Future<bool> get _hasTokens async =>
      await _secureStorage.containsKey(key: userTokenKey);

  static Future<void> updateToken(String token) async {
    token = token;
    await _secureStorage.write(key: userTokenKey, value: token);
  }

  static Future<void> updateUser(Map<String, dynamic> data) async =>
      await updateStorageKeys({userKey: jsonEncode(data)});

  static Future<Map<String, dynamic>> getUserJson() async =>
      jsonDecode((await _secureStorage.read(key: userKey))!);

  static Future<void> clearToken() async {
    token = null;
    await _secureStorage.delete(key: userTokenKey);
  }

  static Future<void> updateStorageKeys(Map<String, dynamic> data) async {
    for (var entry in data.entries) {
      await _secureStorage.write(
        key: entry.key,
        value: entry.value.toString(),
      );
    }
  }

  static Future<String?> readStorage(String key) async =>
      await _secureStorage.read(key: key);

  static Future<void> refreshToken() async {
    // await dio.post(
    //   refreshTokensEndpoint,
    //   data: {
    //   },
    // );
  }

  static Future<Response> retry(RequestOptions requestOptions) async {
    var data = requestOptions.data;

    if (data is FormData) {
      data = data.clone();
    }

    final retryResponse = await dio.request(
      requestOptions.path,
      data: data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        extra: requestOptions.extra,
      ),
    );

    return retryResponse;
  }
}

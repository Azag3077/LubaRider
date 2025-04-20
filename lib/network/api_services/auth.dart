import 'package:dio/dio.dart';

import '../api_response.dart';
import '../dio_client.dart';

class AuthService {
  static Future<ApiResponse<bool>> registerUser({
    required String email,
    required String phone,
    required String country,
    required String password,
  }) async {
    try {
      await DioClient.dio.post('/auth/register', data: {
        'email': email,
        'phone': phone,
        'country': country,
        'password': password,
      });

      return ApiResponse<bool>(data: true);
    } on DioException catch (e) {
      final error = e.error as ApiError;

      return ApiResponse<bool>(error: error, data: false);
    }
  }

  static Future<ApiResponse<bool>> loginUser(String phone) async {
    try {
      await DioClient.dio.post('/auth/login', data: {'phone': phone});

      return ApiResponse<bool>(data: true);
    } on DioException catch (e) {
      final error = e.error as ApiError;

      return ApiResponse(error: error, data: false);
    }
  }

  static Future<ApiResponse<bool>> verifyCode(String code) async {
    try {
      await DioClient.dio.post('/auth/verifyCode', data: {'code': code});

      return ApiResponse<bool>(data: true);
    } on DioException catch (e) {
      final error = e.error as ApiError;

      return ApiResponse(error: error, data: false);
    }
  }

  static Future<ApiResponse<bool>> resendCode() async {
    try {
      await DioClient.dio.post('/auth/resendCode');

      return ApiResponse<bool>(data: true);
    } on DioException catch (e) {
      final error = e.error as ApiError;

      return ApiResponse(error: error, data: false);
    }
  }

  static Future<ApiResponse<bool>> resetPassword(String password) async {
    try {
      final data = {'newPassword': password};
      await DioClient.dio.post('/auth/resetPassword', data: data);

      return ApiResponse<bool>(data: true);
    } on DioException catch (e) {
      final error = e.error as ApiError;

      return ApiResponse(error: error, data: false);
    }
  }
}

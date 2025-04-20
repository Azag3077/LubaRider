import 'package:dio/dio.dart';

class ApiResponse<T> {
  ApiResponse({
    this.data,
    this.error,
  });

  final T? data;
  final ApiError? error;

  bool get hasData => data != null;

  bool get isError => error != null;
}

class ApiError {
  ApiError({
    required this.title,
    required this.message,
    required this.type,
    this.errors,
  });

  final String title;
  final String message;
  final DioExceptionType type;
  final Map<String, dynamic>? errors;

  ApiError copyWith({
    String? title,
    String? message,
    DioExceptionType? type,
    Map<String, dynamic>? errors,
  }) {
    return ApiError(
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      errors: errors ?? this.errors,
    );
  }
}

class PaginatedResponse<T> {
  PaginatedResponse({
    required this.totalCount,
    required this.data,
  });

  final int totalCount;
  final List<T> data;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      totalCount: json['totalCount'],
      data: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
    );
  }

  PaginatedResponse<T> copyWith({
    List<T>? data,
    int? totalCount,
  }) {
    return PaginatedResponse<T>(
      data: data ?? this.data,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

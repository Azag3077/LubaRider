import 'package:dio/dio.dart';

import '../../core/extensions/string.dart';
import 'api_response.dart';
import 'dio_client.dart';

class CustomInterceptor extends Interceptor {
  /// Retry request that Timed-out [_retry] more time.
  final _retry = 2;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (DioClient.token != null) {
      options.headers['Authorization'] = 'Bearer ${DioClient.token}';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map) {
      final data = response.data['data'];

      if (data is Map) {
        if (data['user'] != null) DioClient.updateUser(data['user']);
        if (data['token'] != null) DioClient.updateToken(data['token']);
      }
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.resolve(Response(requestOptions: RequestOptions()));

    if (err.response?.statusCode == 401) {
      try {
        await DioClient.refreshToken();
        final retryRequest = await DioClient.retry(err.requestOptions);
        return handler.resolve(retryRequest);
      } on DioException catch (e) {
        err = e;
      } catch (e) {
        err.copyWith(
          error: e,
          type: DioExceptionType.unknown,
        );
      }
    }

    String title = err.type.name.camelCaseToWords;
    String message = '';
    Map<String, dynamic>? errors;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        final extra = err.requestOptions.extra;
        final requestAttempt = extra['requestAttempt'] ?? 0;

        if (requestAttempt < _retry) {
          extra['requestAttempt'] = requestAttempt + 1;
          err.requestOptions.copyWith(extra: extra);

          try {
            final retryRequest = await DioClient.retry(err.requestOptions);
            return handler.resolve(retryRequest);
          } on DioException catch (e) {
            err = e;
          }
        }

        message = 'The request timed-out because it took so long. '
            'Please check your network connection and try again.';

      case DioExceptionType.badCertificate:
        message = 'An unexpected error occurred, please try again.';

      case DioExceptionType.badResponse:
        if (err.response?.data is Map) {
          title = err.response?.data['message'] ?? 'Unknown error';
          message =
              err.response?.data['message'] ?? 'An unknown error occurred';
          errors = err.response?.data['errors'];
        } else {
          title = 'Unknown error';
          message = 'An unknown error occurred';
        }

      case DioExceptionType.cancel:
        title = 'Request Canceled';
        message = 'The request was interrupted.';

      case DioExceptionType.connectionError:
        message = 'Connection error. Please check '
            'your internet connection and try again.';

      case DioExceptionType.unknown:
        title = 'Unknown Error';
        message = 'An Unknown Error occurred, please try again. '
            'If issue persists, please report.';
    }

    final error = ApiError(
      title: title,
      message: message,
      type: err.type,
      errors: errors,
    );
    return handler.next(err.copyWith(error: error));
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';

class Api {
  late final Dio _dio;

  // Singleton pattern
  static final Api _instance = Api._internal();
  factory Api() => _instance;

  Api._internal() {
    _dio = Dio();
    _setupDio();
  }

  void _setupDio() {
    // Base options
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors for logging (optional)
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => log(obj.toString()),
        ),
      );
    }
  }

  Future<dynamic> get({
    required String url,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = _buildOptions(token);

      Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<dynamic> post({
    required String url,
    dynamic body,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = _buildOptions(token);

      Response response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<dynamic> put({
    required String url,
    dynamic body,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = _buildOptions(token);

      Response response = await _dio.put(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<dynamic> patch({
    required String url,
    dynamic body,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = _buildOptions(token);

      Response response = await _dio.patch(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<dynamic> delete({
    required String url,
    String? token,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = _buildOptions(token);

      Response response = await _dio.delete(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<dynamic> uploadFile({
    required String url,
    required String filePath,
    required String fileKey,
    String? token,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final options = _buildOptions(token);

      FormData formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(filePath),
        ...?additionalData,
      });

      Response response = await _dio.post(
        url,
        data: formData,
        options: options,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }


  Future<void> downloadFile({
    required String url,
    required String savePath,
    String? token,
    ProgressCallback? onProgress,
  }) async {
    try {
      final options = _buildOptions(token);

      await _dio.download(
        url,
        savePath,
        options: options,
        onReceiveProgress: onProgress,
      );
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Options _buildOptions(
    String? token, {
    Map<String, dynamic>? additionalHeaders,
  }) {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return Options(headers: headers);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception(
        'api.request_failed'.tr(args: ['${response.statusCode}']),
      );
    }
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'api.connection_timeout'.tr();

      case DioExceptionType.sendTimeout:
        return 'api.send_timeout'.tr();

      case DioExceptionType.receiveTimeout:
        return 'api.receive_timeout'.tr();

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.cancel:
        return 'api.request_cancelled'.tr();

      case DioExceptionType.connectionError:
        return 'api.connection_error'.tr();

      case DioExceptionType.badCertificate:
        return 'api.certificate_error'.tr();

      case DioExceptionType.unknown:
        return e.message ?? 'api.unknown_error'.tr();
    }
  }

  String _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    switch (statusCode) {
      case 400:
        return _extractErrorMessage(data) ?? 'api.bad_request'.tr();
      case 401:
        return 'api.unauthorized'.tr();
      case 403:
        return 'api.forbidden'.tr();
      case 404:
        return 'api.not_found'.tr();
      case 422:
        return _extractErrorMessage(data) ?? 'api.validation_error'.tr();
      case 500:
        return 'api.server_error'.tr();
      case 502:
        return 'api.bad_gateway'.tr();
      case 503:
        return 'api.service_unavailable'.tr();
      default:
        return _extractErrorMessage(data) ??
            'api.request_failed'.tr(args: ['$statusCode']);
    }
  }

  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    try {
      if (data is Map<String, dynamic>) {
        final possibleKeys = ['message', 'error', 'msg', 'detail', 'details'];

        for (String key in possibleKeys) {
          if (data.containsKey(key) && data[key] != null) {
            if (data[key] is String) {
              return data[key];
            } else if (data[key] is List && (data[key] as List).isNotEmpty) {
              return (data[key] as List).first.toString();
            }
          }
        }

        for (var value in data.values) {
          if (value is String && value.isNotEmpty) {
            return value;
          }
        }
      }

      return data.toString();
    } catch (_) {
      return null;
    }
  }

  void cancelAllRequests() {
    _dio.close(force: true);
  }

  void addRequestInterceptor(InterceptorsWrapper interceptor) {
    _dio.interceptors.add(interceptor);
  }

  void clearInterceptors() {
    _dio.interceptors.clear();
  }
}

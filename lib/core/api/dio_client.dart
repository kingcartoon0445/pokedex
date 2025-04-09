import 'package:dio/dio.dart';
import '../../../config/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'interceptors/auth_interceptor.dart';
import 'dart:developer' as developer;

class DioClient {
  late final Dio _dio;

  // Singleton pattern
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio();
    _initializeDio();
  }

  void _initializeDio() {
    // Base configuration
    _dio.options = BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    );

    // Add interceptors
    _dio.interceptors.add(AuthInterceptor());

    // Add custom logging interceptor that works in all environments
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // developer.log(
          //     'REQUEST[${options.method}] => URL: ${options.baseUrl}${options.path}',
          //     name: 'DioClient');
          // developer.log('REQUEST BODY: ${options.data}', name: 'DioClient');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // developer.log(
          //     'RESPONSE[${response.statusCode}] => URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
          //     name: 'DioClient');
          // developer.log('RESPONSE BODY: ${response.data}', name: 'DioClient');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // developer.log(
          //     'ERROR[${e.response?.statusCode}] => URL: ${e.requestOptions.baseUrl}${e.requestOptions.path}',
          //     name: 'DioClient');
          // developer.log('ERROR MESSAGE: ${e.message}', name: 'DioClient');
          return handler.next(e);
        },
      ),
    );

    // Add pretty logger in debug mode (this is still useful for detailed formatting)
    if (AppConfig.isDevelopment) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: false,
          error: true,
          compact: false,
        ),
      );
    }
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // If you need to access the Dio instance directly
  Dio get dioInstance => _dio;
}

// Centralized API Client using Dio
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../error/exceptions.dart';

class ApiClient {
  late final Dio _dio;
  late final Dio _dioGolang;
  late final Dio _dioEmployee;
  late final Dio _dioRegion;
  late final Dio _dioLetter;
  late final Dio _dioAttendance;
  late final Dio _dioPayroll;
  late final Dio _dioCount;
  late final Dio _dioPublic;

  ApiClient() {
    // Main service
    _dio = _createDio(dotenv.env['BASE_URL'] ?? '');
    
    // Golang service
    _dioGolang = _createDio(dotenv.env['BASE_URL_GOLANG'] ?? '');
    
    // Employee service
    _dioEmployee = _createDio(dotenv.env['BASE_URL_EMPLOYEE'] ?? '');
    
    // Region service
    _dioRegion = _createDio(dotenv.env['BASE_URL_REGION'] ?? '');
    
    // Letter service
    _dioLetter = _createDio(dotenv.env['BASE_URL_LETTER'] ?? '');
    
    // Attendance service
    _dioAttendance = _createDio(dotenv.env['BASE_URL_ATTENDANCE'] ?? '');
    
    // Payroll service
    _dioPayroll = _createDio(dotenv.env['BASE_URL_PAYROLL'] ?? '');
    
    // Count service
    _dioCount = _createDio(dotenv.env['BASE_URL_COUNT'] ?? '');
    
    // Public service
    _dioPublic = _createDio(dotenv.env['BASE_URL_PUBLIC'] ?? '');
  }

  Dio _createDio(String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors(dio);
    return dio;
  }

  void _setupInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token to headers if available (V1 compatible)
          try {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('auth_token') ?? prefs.getString('refresh_token');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = token;
            }
          } catch (e) {
            print('Failed to get token: $e');
          }
          
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handling
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Connection timeout. Please check your internet connection.');
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'] ?? 'An error occurred';
        
        if (statusCode != null) {
          if (statusCode >= 500) {
            return ServerException('Server error: $message');
          } else if (statusCode >= 400) {
            return ServerException(message);
          }
        }
        return ServerException(message);
      
      case DioExceptionType.cancel:
        return ServerException('Request cancelled');
      
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return NetworkException('No internet connection');
        }
        return ServerException('Unexpected error occurred');
      
      default:
        return ServerException('Unexpected error occurred');
    }
  }

  // Get Dio instances for different services
  Dio get dio => _dio;
  Dio get dioGolang => _dioGolang;
  Dio get dioEmployee => _dioEmployee;
  Dio get dioRegion => _dioRegion;
  Dio get dioLetter => _dioLetter;
  Dio get dioAttendance => _dioAttendance;
  Dio get dioPayroll => _dioPayroll;
  Dio get dioCount => _dioCount;
  Dio get dioPublic => _dioPublic;
}

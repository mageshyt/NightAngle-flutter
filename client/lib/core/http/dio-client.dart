import 'dart:io';
import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  final Dio _dio;

  // Private constructor
  DioClient._internal()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'http://localhost:8000',
            headers: {
              'Accept': 'application/json',
            },
          ),
        );

  // Factory constructor to return the singleton instance
  factory DioClient() {
    return _instance;
  }

  // GET request
  Future get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioError catch (e) {
      return _handleDioError(e);
    } on SocketException {
      return 'No Internet connection';
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // POST request
  Future post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioError catch (e) {
      return _handleDioError(e);
    } on SocketException {
      return 'No Internet connection';
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // PUT request
  Future put(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioError catch (e) {
      return _handleDioError(e);
    } on SocketException {
      return 'No Internet connection';
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // DELETE request
  Future delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioError catch (e) {
      return _handleDioError(e);
    } on SocketException {
      return 'No Internet connection';
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // Handle Dio errors
  dynamic _handleDioError(DioError e) {
    if (e.response != null) {
      return e.response!.data;
    } else {
      return e.message;
    }
  }
}

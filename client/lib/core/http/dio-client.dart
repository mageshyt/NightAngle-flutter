import 'package:dio/dio.dart';
import 'package:nightAngle/core/core.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker/talker.dart';

enum DioMethod { post, get, put, delete }

class APIService {
  APIService._singleton();

  static final APIService instance = APIService._singleton();

  String baseUrl = 'http://localhost:8000';

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    formData,
    Map<String, String>? headers,
    bool? isAuthorized = false,
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: contentType ?? Headers.formUrlEncodedContentType,
          headers: headers,
        ),
      );

      if (isAuthorized == true) {
        dio.interceptors.add(AuthHeaderIntro());
      }

      dio.interceptors.add(TalkerDioLogger(
          settings: TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true, // Blue http requests logs in console
        requestPen: AnsiPen()..blue(),
        // Green http responses logs in console
        responsePen: AnsiPen()..green(),
        // Error http logs in console
        errorPen: AnsiPen()..red(),
      )));

      switch (method) {
        case DioMethod.post:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.get:
          return dio.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.put:
          return dio.put(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.delete:
          return dio.delete(
            endpoint,
            data: param ?? formData,
          );
        default:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
      }
    } catch (e) {
      throw Exception('Network error');
    }
  }
}

class AuthHeaderIntro extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token =
        LocalStorage().readData('token'); // get your token from your resources
    var headers = {"x-auth-token": token};
    // Add token to headers before making a request
    options.headers.addAll(headers);
    return super.onRequest(options, handler);
  }
}

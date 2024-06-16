import 'package:dio/dio.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/http/failure.dart';
import 'package:nightAngle/core/logger/logger.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/features/auth/model/user-model.dart';

class AuthRemoteRepository {
  Future<Either<HttpFailure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final response =
          await APIService.instance.request('/auth/login', DioMethod.post,
              param: {
                'email': email,
                'password': password,
              },
              contentType: Headers.jsonContentType);

      LoggerHelper.debug(response.toString());
      if (response.statusCode != 200) {
        LoggerHelper.error(response.toString());
        return Left(HttpFailure(
          message: response.data['detail'],
          code: response.statusCode.toString(),
        ));
      }

      final user = UserModel.fromMap(response.data['user']);

      //  add token to user

      return Right(user.copyWith(token: response.data['token']));
    } catch (e) {
      if (e is DioError) {
        LoggerHelper.error(e.response.toString());
        return Left(HttpFailure(
            message: e.response!.data['detail'],
            code: e.response!.statusCode.toString()));
      }

      return Left(
          HttpFailure(message: 'An error occurred. Please try again later.'));
    }
  }

  Future<Either<HttpFailure, UserModel>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final Response response =
          await APIService.instance.request('/auth/register', DioMethod.post,
              param: {
                'email': email,
                'password': password,
                'name': name,
              },
              contentType: Headers.jsonContentType);

      if (response.statusCode != 201) {
        LoggerHelper.error(response.toString());
        return Left(HttpFailure(
          message: response.data['detail'],
          code: response.statusCode.toString(),
        ));
      }

      return Right(UserModel.fromMap(response.data));
    } catch (e) {
      if (e is DioException) {
        LoggerHelper.error(e.response.toString());
        return Left(HttpFailure(
            message: e.response!.data['detail'],
            code: e.response!.statusCode.toString()));
      }

      return Left(HttpFailure(message: e.toString(), code: '500'));
    }
  }
}

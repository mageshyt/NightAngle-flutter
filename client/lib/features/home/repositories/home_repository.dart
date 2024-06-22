import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/http/failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<HttpFailure, String>> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required String hexCode,
  }) async {
    try {
      // --------------------make form data--------------------
      FormData formData = FormData.fromMap({
        "song": await MultipartFile.fromFile(selectedAudio.path),
        "thumbnail": await MultipartFile.fromFile(selectedThumbnail.path),
        "song_name": songName,
        "artist": artist,
        "hex_color": hexCode,
      });

      final res = await APIService.instance.request('/song/', DioMethod.post,
          contentType: 'multipart/form-data',
          formData: formData,
          isAuthorized: true);

      LoggerHelper.debug(res.data.toString());
      if (res.statusCode == 201) {
        return Right(res.data['message'] ?? 'Song uploaded successfully');
      } else {
        return Left(HttpFailure(
            message: res.data['details'] ?? "something went wrong",
            code: res.statusCode.toString()));
      }
    } catch (e) {
      return Left(HttpFailure(message: e.toString()));
    }
  }
}

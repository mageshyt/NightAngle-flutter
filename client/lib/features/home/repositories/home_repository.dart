import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/http/failure.dart';
import 'package:nightAngle/features/home/models/song-model.dart';
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

  Future<Either<HttpFailure, List<SongModel>>> getSongs() async {
    try {
      final res = await APIService.instance.request(
        '/song/',
        DioMethod.get,
      );

      if (res.statusCode == 200) {
        final List<SongModel> songs = [];
        for (var song in res.data['songs']) {
          LoggerHelper.debug('[GET ALL SONGS]${song['song_name']}');
          songs.add(SongModel.fromMap(song));
        }
        LoggerHelper.debug('[GET ALL SONGS LENGTH]' + songs.length.toString());
        return Right(songs);
      } else {
        return Left(HttpFailure(
            message: res.data['details'] ?? "something went wrong",
            code: res.statusCode.toString()));
      }
    } catch (e) {
      LoggerHelper.error('[GET ALL SONGS ERROR]' + e.toString());
      return Left(HttpFailure(message: e.toString()));
    }
  }

  Future<Either<HttpFailure, List<SongModel>>> getCurrentUserSongs() async {
    try {
      final res = await APIService.instance.request(
        '/song/me',
        DioMethod.get,
        isAuthorized: true,
      );

      if (res.statusCode == 200) {
        final List<SongModel> songs = [];
        for (var song in res.data) {
          LoggerHelper.debug('[GET ALL SONGS]${song['song_name']}');
          songs.add(SongModel.fromMap(song));
        }
        LoggerHelper.debug('[GET ALL SONGS LENGTH]' + songs.length.toString());
        return Right(songs);
      } else {
        return Left(HttpFailure(
            message: res.data['details'] ?? "something went wrong",
            code: res.statusCode.toString()));
      }
    } catch (e) {
      LoggerHelper.error('[GET ALL SONGS ERROR]' + e.toString());
      return Left(HttpFailure(message: e.toString()));
    }
  }

  Future<Either<HttpFailure, bool>> favoriteSong({
    required songId,
  }) async {
    try {
      final res = await APIService.instance.request(
        '/song/favorite/$songId',
        DioMethod.put,
        isAuthorized: true,
      );
      LoggerHelper.debug(res.data.toString());
      if (res.statusCode == 200) {
        return Right(res.data['message']);
      } else {
        return Left(HttpFailure(
            message: res.data['details'] ?? "something went wrong",
            code: res.statusCode.toString()));
      }
    } catch (e) {
      LoggerHelper.error('[FAV SONGS ERROR]' + e.toString());
      return Left(HttpFailure(message: e.toString()));
    }
  }

  Future<Either<HttpFailure, List<SongModel>>> topFavoriteSongs() async {
    try {
      final res = await APIService.instance.request(
        '/song/top-favorite',
        DioMethod.get,
        isAuthorized: true,
      );

      if (res.statusCode == 200) {
        final List<SongModel> songs = [];
        for (var song in res.data['top_songs']) {
          songs.add(SongModel.fromMap(song));
        }
        return Right(songs);
      } else {
        return Left(HttpFailure(
            message: res.data['details'] ?? "something went wrong",
            code: res.statusCode.toString()));
      }
    } catch (e) {
      LoggerHelper.error('[GET ALL SONGS ERROR]' + e.toString());
      return Left(HttpFailure(message: e.toString()));
    }
  }

  Future<Either<HttpFailure, List<SongModel>>> getfavorites() async {
    try {
      final res = await APIService.instance.request(
        '/song/favorite',
        DioMethod.get,
        isAuthorized: true,
      );

      if (res.statusCode == 200) {
        final List<SongModel> songs = [];
        for (var song in res.data['favorite_songs']) {
          // LoggerHelper.debug('[GET ALL SONGS]${song['favorite_songs'].}');
          songs.add(SongModel.fromMap(song['song']));
        }
        LoggerHelper.debug('[GET ALL SONGS LENGTH]' + songs.length.toString());
        return Right(songs);
      } else {
        return Left(HttpFailure(
            message: res.data['details'] ?? "something went wrong",
            code: res.statusCode.toString()));
      }
    } catch (e) {
      LoggerHelper.error('[GET ALL SONGS ERROR]' + e.toString());
      return Left(HttpFailure(message: e.toString()));
    }
  }

  Future<Either<Null, List<SongModel>>> getSearchResults(String query) async {
    try {
      final res = await APIService.instance
          .request('/song/search/?query=$query', DioMethod.get);

      if (res.statusCode == 200) {
        final List<SongModel> songs = [];
        for (var song in res.data) {
          songs.add(SongModel.fromMap(song));
        }
        return Right(songs);
      }
      return const Left(null);
    } catch (e) {
      LoggerHelper.error('[GET ALL SONGS ERROR]' + e.toString());

      return const Left(null);
    }
  }
}

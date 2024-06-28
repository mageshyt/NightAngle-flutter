import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/home/models/song-model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search-remote-repository.g.dart';

@riverpod
SearchRepository searchRepository(SearchRepositoryRef ref) {
  return SearchRepository();
}

class SearchRepository {
  Future<Either<Null, List<SongModel>>> getSearchResults(String query) async {
    try {
      final res = await APIService.instance
          .request('/song/search/?query=$query', DioMethod.get);

      if (res.statusCode == 200) {
        final List<SongModel> songs = [];
        for (var song in res.data) {
          songs.add(SongModel.fromMap(song));
        }

        LoggerHelper.debug(songs.toString());
        return Right(songs);
      }
      return const Left(null);
    } catch (e) {
      return const Left(null);
    }
  }
}

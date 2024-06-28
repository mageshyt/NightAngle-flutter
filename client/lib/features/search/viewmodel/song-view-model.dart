import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/features/home/models/song-model.dart';
import 'package:nightAngle/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'song-view-model.g.dart';

enum SearchScreenStates { EMPTY, SUCCESS, NOTHING, LOADING, FAILED }

@riverpod
Future<List<SongModel>> getSearchResults(
    GetSearchResultsRef ref, String query) async {
  final res = await ref.read(homeRepositoryProvider).getSearchResults(query);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class SearchViewModel extends _$SearchViewModel {
  late HomeRepository _homeRepository;

  @override
  AsyncValue<List<SongModel>>? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    // loading state

    return null;
  }

  SearchScreenStates searchState = SearchScreenStates.EMPTY;

  // search query
  Future<void> getSearchResult(String query) async {
    try {
      searchState = SearchScreenStates.LOADING;
      state = AsyncValue.loading(); // Update state to loading

      // get search result
      final result = await _homeRepository.getSearchResults(query);

      return switch (result) {
        Left(value: final l) => _successState(l),
        Right(value: final r) => _successState(r),
      };
    } catch (e) {
      searchState = SearchScreenStates.FAILED;
    }
  }

  _successState(r) {
    searchState = SearchScreenStates.SUCCESS;

    return r;
  }

  _failureState(l) {
    searchState = SearchScreenStates.FAILED;

    return l;
  }
}

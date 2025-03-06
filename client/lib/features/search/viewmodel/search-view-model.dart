import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/features/home/models/song-model.dart';
import 'package:nightAngle/features/home/repositories/home_repository.dart';
import 'package:nightAngle/features/search/model/search-state-model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search-view-model.g.dart';

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
  SearchState build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    // loading state

    return SearchState(searchState: SearchScreenStates.NOTHING);
  }

  // search query
  Future<void> getSearchResult(String query) async {
    try {
      // loading state
      state = state.copyWith(searchState: SearchScreenStates.LOADING);
      // demo have 2 sec delay
      await Future.delayed(const Duration(seconds: 1));
      // get search result
      final result = await _homeRepository.getSearchResults(query);

      return switch (result) {
        Left(value: final l) => _successState(l),
        Right(value: final r) => _successState(r),
      };
    } catch (e) {
      return _failureState(e);
    }
  }

  _successState(r) {
    // success state
    if (r.isEmpty) {
      state = state.copyWith(searchState: SearchScreenStates.EMPTY);
      return;
    }
    state = state.copyWith(searchState: SearchScreenStates.SUCCESS, songs: r);
  }

  _failureState(l) {
    state = state.copyWith(searchState: SearchScreenStates.FAILED);
  }
}

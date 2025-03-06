import 'package:nightAngle/features/home/models/song-model.dart';
import 'package:nightAngle/features/search/viewmodel/search-view-model.dart';

class SearchState {
  final SearchScreenStates searchState;
  final List<SongModel>? songs;

  SearchState({
    required this.searchState,
    this.songs,
  });

  SearchState copyWith({
    SearchScreenStates? searchState,
    List<SongModel>? songs,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      songs: songs ?? this.songs,
    );
  }
}

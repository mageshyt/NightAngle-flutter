import 'package:nightAngle/features/search/viewmodel/search-view-model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider_notifier.g.dart';

@riverpod
class SearchProviderNotifier extends _$SearchProviderNotifier {
  late SearchViewModel _searchViewModel;
  @override
  String build() {
    _searchViewModel = ref.watch(searchViewModelProvider.notifier);
    return '';
  }

  void setSearch(String value) {
    state = value;
    _searchViewModel.getSearchResult(value);
  }

  String get search => state;

  void clearSearch() {
    state = '';
  }
}

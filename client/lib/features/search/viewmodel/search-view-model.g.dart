// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search-view-model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSearchResultsHash() => r'3ac544625537a6f793db3162b81d483b030293db';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getSearchResults].
@ProviderFor(getSearchResults)
const getSearchResultsProvider = GetSearchResultsFamily();

/// See also [getSearchResults].
class GetSearchResultsFamily extends Family<AsyncValue<List<SongModel>>> {
  /// See also [getSearchResults].
  const GetSearchResultsFamily();

  /// See also [getSearchResults].
  GetSearchResultsProvider call(
    String query,
  ) {
    return GetSearchResultsProvider(
      query,
    );
  }

  @override
  GetSearchResultsProvider getProviderOverride(
    covariant GetSearchResultsProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getSearchResultsProvider';
}

/// See also [getSearchResults].
class GetSearchResultsProvider
    extends AutoDisposeFutureProvider<List<SongModel>> {
  /// See also [getSearchResults].
  GetSearchResultsProvider(
    String query,
  ) : this._internal(
          (ref) => getSearchResults(
            ref as GetSearchResultsRef,
            query,
          ),
          from: getSearchResultsProvider,
          name: r'getSearchResultsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSearchResultsHash,
          dependencies: GetSearchResultsFamily._dependencies,
          allTransitiveDependencies:
              GetSearchResultsFamily._allTransitiveDependencies,
          query: query,
        );

  GetSearchResultsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<SongModel>> Function(GetSearchResultsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSearchResultsProvider._internal(
        (ref) => create(ref as GetSearchResultsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SongModel>> createElement() {
    return _GetSearchResultsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSearchResultsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSearchResultsRef on AutoDisposeFutureProviderRef<List<SongModel>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _GetSearchResultsProviderElement
    extends AutoDisposeFutureProviderElement<List<SongModel>>
    with GetSearchResultsRef {
  _GetSearchResultsProviderElement(super.provider);

  @override
  String get query => (origin as GetSearchResultsProvider).query;
}

String _$searchViewModelHash() => r'b13125802c1df703b82083afa9485f128e798fd8';

/// See also [SearchViewModel].
@ProviderFor(SearchViewModel)
final searchViewModelProvider =
    AutoDisposeNotifierProvider<SearchViewModel, SearchState>.internal(
  SearchViewModel.new,
  name: r'searchViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchViewModel = AutoDisposeNotifier<SearchState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllSongsHash() => r'0101b678842673c7189ca965e0eb16900740a17f';

/// See also [getAllSongs].
@ProviderFor(getAllSongs)
final getAllSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  getAllSongs,
  name: r'getAllSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$getCurrentUserSongsHash() =>
    r'da22a647755467ed4a6a3aebcc5d1536b0f4f35a';

/// See also [getCurrentUserSongs].
@ProviderFor(getCurrentUserSongs)
final getCurrentUserSongsProvider =
    AutoDisposeFutureProvider<List<SongModel>>.internal(
  getCurrentUserSongs,
  name: r'getCurrentUserSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getCurrentUserSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCurrentUserSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewModelHash() => r'ecdbd3fa8f983136c27eac4efb1f6ec99c2fa787';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

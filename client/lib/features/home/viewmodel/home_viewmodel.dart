import 'dart:io';
import 'dart:ui';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
import 'package:nightAngle/core/widgets/toast.dart';
import 'package:nightAngle/features/home/models/fav-song-model.dart';
import 'package:nightAngle/features/home/models/song-model.dart';
import 'package:nightAngle/features/home/repositories/home_local_repository.dart';
import 'package:nightAngle/features/home/repositories/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async {
  final res = await ref.read(homeRepositoryProvider).getSongs();
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<SongModel>> getFavoriteSongs(GetFavoriteSongsRef ref) async {
  final res = await ref.read(homeRepositoryProvider).getfavorites();
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<SongModel>> getCurrentUserSongs(GetCurrentUserSongsRef ref) async {
  final res = await ref.read(homeRepositoryProvider).getCurrentUserSongs();
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<SongModel>> getTopSongs(GetTopSongsRef ref) async {
  final res = await ref.read(homeRepositoryProvider).topFavoriteSongs();
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late HomeLocalRepository _homeLocalRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color hexCode,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: hexCode.hex,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _success(r, context),
    };

    // revalidate the songs
    ref.invalidate(getCurrentUserSongsProvider);
  }

  _success(r, context) {
    toast.showSuccessToast(
        context: context, message: "Song uploaded successfully");
    state = AsyncValue.data(r);
  }

  Future<void> favSong({required String songId}) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.favoriteSong(
      songId: songId,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _favSongSuccess(r, songId),
    };
  }

  AsyncValue _favSongSuccess(bool isFavorited, String songId) {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    final currentUser = ref.read(currentUserNotifierProvider);

    if (isFavorited) {
      userNotifier.addUser(
        currentUser!.copyWith(
          favorites: [
            ...currentUser.favorites,
            FavSongModel(
              id: '',
              songId: songId,
              userId: currentUser.id,
            )
          ],
        ),
      );
    } else {
      userNotifier.addUser(
        currentUser!.copyWith(
          favorites: currentUser.favorites
              .where((element) => element.songId != songId)
              .toList(),
        ),
      );
    }

    // revalidate the songs
    ref.invalidate(getFavoriteSongsProvider);

    return state = AsyncValue.data(isFavorited);
  }

  List<SongModel> getRecentlyPlayedSong() {
    return _homeLocalRepository.getLocalSongs();
  }

  Future<void> logout(BuildContext context) async {
    state = const AsyncValue.loading();

    try {
      // Clear current user from provider
      ref.read(currentUserNotifierProvider.notifier).removeUser();

      // Reset all relevant providers
      ref.invalidate(getFavoriteSongsProvider);
      ref.invalidate(getCurrentUserSongsProvider);

      // Show success message
      toast.showSuccessToast(
          context: context, message: "Logged out successfully");

      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
      toast.showErrorToast(
          context: context, message: "Failed to logout: ${e.toString()}");
    }
  }
}

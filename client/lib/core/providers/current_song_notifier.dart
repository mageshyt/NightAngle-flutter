// ignore_for_file: avoid_public_notifier_properties
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/home/models/song-model.dart';
import 'package:nightAngle/features/home/repositories/home_local_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;
  late HomeLocalRepository _homeLocalRepository;
  bool isPlaying = false;

  @override
  SongModel? build() {
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  void updateSong(SongModel song) async {
    try {
      await audioPlayer?.stop();

      // create a new instance of AudioPlayer
      audioPlayer = AudioPlayer();

      // if the song is already playing, stop it
      LoggerHelper.info('Current Song >> ${song.id}');

      // load the song
      final audioSource = AudioSource.uri(Uri.parse(song.song_url),
          tag: MediaItem(
            id: song.id,
            title: song.song_name,
            artist: song.artist,
            artUri: Uri.parse(song.thumbnail_url),
          ));

      // cache the song
      await audioPlayer!.setAudioSource(audioSource);

      audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          audioPlayer!.seek(Duration.zero);
          audioPlayer!.pause();
          isPlaying = false;
          this.state = this.state?.copyWith(hex_color: this.state?.hex_color);
        }
      });
      // add the song to local storage
      _homeLocalRepository.uploadLocalSong(song);

      audioPlayer!.play();
      isPlaying = true;
      state = song;

      LoggerHelper.info('STATE UPDATED ${state?.song_name}');
    } catch (e) {
      LoggerHelper.error(e.toString());
    }
  }

  void playPause() async {
    if (isPlaying) {
      audioPlayer?.pause();
    } else {
      audioPlayer?.play();
    }
    isPlaying = !isPlaying;

    state = state?.copyWith(hex_color: state!.hex_color);
  }

  void seek(double val) {
    audioPlayer!.seek(
      Duration(
        milliseconds: (val * audioPlayer!.duration!.inMilliseconds).toInt(),
      ),
    );
  }
}

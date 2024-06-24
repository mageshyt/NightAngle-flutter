import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nightAngle/core/core.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({super.key, required this.path});

  @override
  State createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController _playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await _playerController.preparePlayer(path: widget.path);
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Future<void> _playAndPause() async {
    if (!_playerController.playerState.isPlaying) {
      await _playerController.startPlayer(finishMode: FinishMode.stop);
    } else if (!_playerController.playerState.isPaused) {
      await _playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            _playerController.playerState.isPlaying
                ? CupertinoIcons.pause_circle_fill
                : IconlyBold.play,
          ),
          onPressed: _playAndPause,
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 100),
            playerController: _playerController,
            animationCurve: Curves.bounceIn,
            animationDuration: const Duration(milliseconds: 1000),
            enableSeekGesture: true,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Pallete.borderColor,
              liveWaveColor: Pallete.primary,
              spacing: 6,
              showSeekLine: false,
            ),
          ),
        ),
      ],
    );
  }
}

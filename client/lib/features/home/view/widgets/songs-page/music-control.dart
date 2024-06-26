import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_song_notifier.dart';

class MusicControl extends ConsumerWidget {
  const MusicControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);
    final songColor = hexToColor(songNotifier.state!.hex_color);
    return StreamBuilder<Object>(
        stream: songNotifier.audioPlayer!.positionStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          final position = snapshot.data as Duration?;
          final duration = songNotifier.audioPlayer!.duration;

          double sliderValue = 0.0;
          if (position != null && duration != null) {
            sliderValue = position.inMilliseconds / duration.inMilliseconds;
          }

          return Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: songColor,
                  inactiveTrackColor: Pallete.white.withOpacity(0.117),
                  thumbColor: songColor,
                  trackHeight: 4,
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  value: sliderValue,
                  min: 0,
                  max: 1,
                  onChanged: (val) {
                    sliderValue = val;
                  },
                  onChangeEnd: songNotifier.seek,
                ),
              ),

              //  ---------------------------- duration----------------
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.sm, vertical: Sizes.xs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${position?.inMinutes}:${(position?.inSeconds ?? 0) < 10 ? '0${position?.inSeconds}' : position?.inSeconds}',
                      style: const TextStyle(
                          color: Pallete.subtitleText,
                          fontSize: Sizes.fontSizesm,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      '${duration?.inMinutes}:${(duration?.inSeconds ?? 0) < 10 ? '0${duration?.inSeconds}' : duration?.inSeconds}',
                      style: const TextStyle(
                          color: Pallete.subtitleText,
                          fontSize: Sizes.fontSizesm,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),

              // ----------------------------- music controls----------------

              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // shuffle button
                  Button(
                    variant: ButtonVariant.icon,
                    size: ButtonSize.icon,
                    icon: SvgPicture.asset(
                      'assets/icons/Shuffle.svg',
                      width: Sizes.iconSm,
                    ),
                    onPressed: () {},
                  ),

                  // ------------------ previous button----------------
                  Button(
                    variant: ButtonVariant.icon,
                    size: ButtonSize.icon,
                    icon: SvgPicture.asset(
                      'assets/icons/Previous.svg',
                      width: Sizes.iconSm,
                    ),
                    onPressed: () {},
                  ),

                  // ------------------ play button----------------
                  Button(
                    variant: ButtonVariant.icon,
                    size: ButtonSize.icon,
                    icon: Icon(
                      songNotifier.isPlaying
                          ? CupertinoIcons.pause_circle_fill
                          : IconlyBold.play,
                      size: 70,
                    ),
                    onPressed: () {
                      ref
                          .read(currentSongNotifierProvider.notifier)
                          .playPause();
                    },
                  ),

                  // ------------------ next button----------------
                  Button(
                    variant: ButtonVariant.icon,
                    size: ButtonSize.icon,
                    icon: SvgPicture.asset(
                      'assets/icons/Next.svg',
                      width: Sizes.iconSm,
                    ),
                    onPressed: () {},
                  ),

                  // Repeat button
                  Button(
                    variant: ButtonVariant.icon,
                    size: ButtonSize.icon,
                    icon: SvgPicture.asset(
                      'assets/icons/Repeat.svg',
                      width: Sizes.iconSm,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          );
        });
  }
}

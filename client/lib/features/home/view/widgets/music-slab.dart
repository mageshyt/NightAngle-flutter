import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/providers.dart';
import 'package:nightAngle/core/theme/app_pallete.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);

    LoggerHelper.info('MUSIC SLAP ${currentSong?.song_name}');

    if (currentSong == null) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        context.push(Routes.musicPlay);
      },
      child: ZoomIn(
        duration: Durations.extralong4,
        manualTrigger: false,
        child: Container(
          padding: const EdgeInsets.all(Sizes.sm),
          height: 70,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            bottom: Sizes.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusXl),
            gradient: LinearGradient(
              colors: [
                hexToColor(currentSong.hex_color).withOpacity(0.7),
                Pallete.cardColor.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // image
              Container(
                height: Sizes.imageSm,
                width: Sizes.imageSm,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image:
                        CachedNetworkImageProvider(currentSong.thumbnail_url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // song name and artist name
              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentSong.song_name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currentSong.artist,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              // play button

              const Spacer(),

              Row(
                children: [
                  // heart icon

                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),

                  IconButton(
                    icon: Icon(
                      ref.watch(currentSongNotifierProvider.notifier).isPlaying
                          ? CupertinoIcons.pause_circle_fill
                          : IconlyBold.play,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      ref
                          .read(currentSongNotifierProvider.notifier)
                          .playPause();
                    },
                  ),
                ],
              ),

              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

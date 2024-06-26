import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_song_notifier.dart';
import 'package:nightAngle/core/theme/text-style.dart';
import 'package:nightAngle/features/home/view/widgets/songs-page/music-control.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            hexToColor(song!.hex_color),
            const Color(0xff121212),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Pallete.transparent,
          appBar: AppBar(
            backgroundColor: Pallete.transparent,
            elevation: 0,
            leading: Transform.translate(
              offset: const Offset(-15, 0),
              child: InkWell(
                highlightColor: Pallete.transparent,
                focusColor: Pallete.transparent,
                splashColor: Pallete.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.sm),
                  child: Image.asset('assets/icons/pull-down-arrow.png'),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              // --------------------------------- song image-------------------
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.lg),
                  child: Hero(
                    tag: 'music-image',
                    child: Center(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Sizes.productImageRadius),
                        child: CachedImage(
                          imageUrl: song!.thumbnail_url,
                          width: Sizes.productImageSize,
                          placeholder: Container(
                            width: Sizes.productImageSize,
                            height: Sizes.productImageSize,
                            child: const Loader(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ------------------------------- song details-----------------------

              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    // ----------------- song name & heart-------------------

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.song_name,
                              style: TextStyles.songTitle,
                            ),
                            // ----------------------- artist
                            Text(
                              song.artist,
                              style: TextStyles.labelStyle,
                            ),
                          ],
                        ),

                        // Favorite

                        Button(
                          variant: ButtonVariant.icon,
                          size: ButtonSize.icon,
                          icon: const Icon(CupertinoIcons.heart,
                              color: Pallete.white),
                          onPressed: () {},
                        ),

                        Button(
                          variant: ButtonVariant.icon,
                          size: ButtonSize.icon,
                          icon: const Icon(CupertinoIcons.bookmark,
                              color: Pallete.white),
                          onPressed: () {
                            // create a playlist
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwSections,
                    ),
                    // ---------------------------- music slider-----------------

                    const MusicControl(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

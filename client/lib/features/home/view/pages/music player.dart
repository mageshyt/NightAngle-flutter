import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_song_notifier.dart';
import 'package:nightAngle/core/theme/text-style.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongNotifierProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.lg),
      child: Scaffold(
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
                          icon: Icon(IconlyLight.heart),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwSections,
                    ),
                    // ---------------------------- music slider-----------------

                    Column(
                      children: [
                        Slider(
                          value: 0.30,
                          min: 0,
                          max: 1,
                          onChanged: (val) {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

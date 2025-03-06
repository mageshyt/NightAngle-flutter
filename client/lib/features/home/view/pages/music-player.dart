import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_song_notifier.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
import 'package:nightAngle/core/theme/text-style.dart';
import 'package:nightAngle/features/home/view/widgets/songs-page/music-control.dart';
import 'package:nightAngle/features/home/view/widgets/songs-page/rotation-disk.dart';
import 'package:nightAngle/features/home/viewmodel/home_viewmodel.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongNotifierProvider);
    // final songNotifier = ref.read(currentSongNotifierProvider.notifier);

    final userFavorites =
        ref.read(currentUserNotifierProvider.select((data) => data!.favorites));
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
                          imageUrl: song.thumbnail_url,
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
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              truncate(song.song_name, 12),
                              style: TextStyles.songTitle,
                            ),
                            // ----------------------- artist
                            Text(
                              song.artist,
                              style: TextStyles.labelStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        RotatingDisk(),
                        const Spacer(),
                        // Favorite

                        Button(
                          variant: ButtonVariant.icon,
                          size: ButtonSize.icon,
                          icon: Icon(
                            userFavorites
                                    .where((fav) => fav.songId == song.id)
                                    .toList()
                                    .isNotEmpty
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await ref
                                .watch(homeViewModelProvider.notifier)
                                .favSong(songId: song.id);
                          },
                        ),

                        Button(
                          variant: ButtonVariant.icon,
                          size: ButtonSize.icon,
                          icon: const Icon(CupertinoIcons.bookmark,
                              color: Pallete.white),
                          onPressed: () {
                            // create a playlist
                            showMaterialModalBottomSheet(
                              context: context,
                              expand: false,
                              settings: const RouteSettings(name: 'playlist'),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => Container(
                                height: 300,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.lg, vertical: Sizes.sm),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: Sizes.spaceBtwItems,
                                    ),
                                    // ----------------- create playlist----------------
                                    const Text(
                                      'Your Playlist',
                                      style: TextStyle(
                                        color: Pallete.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // ----------------- Already playlist----------------

                                    // ----------------- create playlist----------------

                                    const SizedBox(
                                      height: Sizes.spaceBtwItems,
                                    ),

                                    ListTile(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      onTap: () {
                                        // create a playlist
                                      },
                                      leading: const Icon(
                                        CupertinoIcons.add,
                                        color: Pallete.white,
                                      ),
                                      title: const Text(
                                        'Create Playlist',
                                        style: TextStyle(
                                          color: Pallete.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
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

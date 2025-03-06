import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_song_notifier.dart';
import 'package:nightAngle/features/home/view/widgets/section-header.dart';
import 'package:nightAngle/features/home/viewmodel/home_viewmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                SectionHeader(title: 'Favorite Songs', onTap: () {}),
                const SizedBox(height: Sizes.spaceBtwItems),
                ref.watch(getFavoriteSongsProvider).when(
                      data: (songs) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: songs.length + 1,
                            itemBuilder: (context, index) {
                              if (index == songs.length) {
                                return ListTile(
                                  onTap: () {
                                    context.push(Routes.upload);
                                  },
                                  leading: const Icon(
                                    CupertinoIcons.plus,
                                  ),
                                  title: const Text(
                                    'Upload New Song',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                );
                              }

                              final song = songs[index];
                              return ListTile(
                                onTap: () {
                                  ref
                                      .read(
                                          currentSongNotifierProvider.notifier)
                                      .updateSong(song);
                                },
                                title: Text(
                                  song.song_name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(song.artist),
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    song.thumbnail_url,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      loading: () => const Center(child: Loader()),
                      error: (error, stack) =>
                          Center(child: Text(error.toString())),
                    ),
              ],
            )),
      ),
    );
  }
}

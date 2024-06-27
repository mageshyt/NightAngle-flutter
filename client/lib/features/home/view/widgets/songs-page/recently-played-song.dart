import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';

import 'package:nightAngle/core/providers/current_song_notifier.dart';
import 'package:nightAngle/features/home/viewmodel/home_viewmodel.dart';

class RecentlyPlayedSong extends ConsumerWidget {
  const RecentlyPlayedSong({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyPlayedSongs =
        ref.watch(homeViewModelProvider.notifier).getRecentlyPlayedSong();
    return SizedBox(
      height: 150,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 240,
          childAspectRatio: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: recentlyPlayedSongs.length,
        itemBuilder: (context, index) {
          final song = recentlyPlayedSongs[index];
          return GestureDetector(
            onTap: ()=>  ref.read(currentSongNotifierProvider.notifier).updateSong(song),

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pallete.cardColor,
              ),
              padding: const EdgeInsets.all(Sizes.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ----------------- Thumbnail -----------------
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedImage(
                      imageUrl: song.thumbnail_url,
                      height: 50,
                      width: 50,
                    ),
                  ),

                  const SizedBox(width: Sizes.sm),

                  // ----------------- Song details -----------------
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      song.song_name,
                      style: const TextStyle(
                        fontSize: Sizes.fontSizesm,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

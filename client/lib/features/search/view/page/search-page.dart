import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_song_notifier.dart';
import 'package:nightAngle/core/widgets/reuse_appbar.dart';
import 'package:nightAngle/features/search/viewmodel/search-view-model.dart';

final searchProvider = StateProvider<String>((ref) => '');

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchSongs = ref.watch(searchViewModelProvider);
    return Scaffold(
      appBar: const ReuseableAppbar(
        title: 'Search Songs',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Pallete.cardColor,
                ),
                onSubmitted: (value) {
                  ref.read(searchProvider.notifier).state = value;
                  ref
                      .read(searchViewModelProvider.notifier)
                      .getSearchResult(value);
                  // Call the search function
                },
              ),
              const SizedBox(height: 16),

              // Nothing state
              searchSongs.searchState == SearchScreenStates.NOTHING
                  ? const Expanded(
                      child: Center(
                        child: Text('Search for songs'),
                      ),
                    )
                  : const SizedBox(),

              // Loading state
              searchSongs.searchState == SearchScreenStates.LOADING
                  ? Expanded(
                      child: Center(
                        child: Lottie.asset(
                          'assets/animations/loading.json',
                          height: 200,
                          width: 200,
                        ),
                      ),
                    )
                  : const SizedBox(),

              // Empty state
              searchSongs.searchState == SearchScreenStates.EMPTY
                  ? Expanded(
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/empty.svg',
                          height: 200,
                        ),
                      ),
                    )
                  : const SizedBox(),

              // Failed state
              searchSongs.searchState == SearchScreenStates.FAILED
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/error.svg',
                              height: 200,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Something Went Wrong',
                              style: TextStyle(
                                color: Pallete.primary,
                                fontSize: Sizes.fontSizeLg,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              // Success state
              Expanded(
                child: searchSongs.searchState == SearchScreenStates.SUCCESS
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchSongs.songs!.length,
                        itemBuilder: (context, index) {
                          final song = searchSongs.songs![index];
                          return ListTile(
                            title: Text(
                              song.song_name,
                            ),
                            subtitle: Text(
                              song.artist,
                            ),
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  song.thumbnail_url),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () {
                                // Play the song
                                ref
                                    .watch(currentSongNotifierProvider.notifier)
                                    .updateSong(song);
                              },
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

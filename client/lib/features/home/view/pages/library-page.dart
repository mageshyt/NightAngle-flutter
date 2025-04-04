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

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(homeViewModelProvider.notifier).logout(context);
                Navigator.pop(context);
                context.go(Routes.login); // Navigate to login screen
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context, ref),
            tooltip: 'Logout',
          ),
        ],
      ),
      // Add a floating action button for uploading
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(Routes.upload);
        },
        icon: const Icon(Icons.upload),
        label: const Text('Upload New Song'),
        backgroundColor: theme.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Sizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User library card
              Container(
                margin: const EdgeInsets.only(bottom: Sizes.lg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor.withOpacity(0.7),
                      theme.primaryColor.withOpacity(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Sizes.sm),
                ),
                padding: const EdgeInsets.all(Sizes.md),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: const Icon(
                        Icons.music_note,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: Sizes.md),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Music',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'All your favorites in one place',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SectionHeader(
                title: 'Favorite Songs',
                onTap: () {},
                isMoreVisible: false,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),

              ref.watch(getFavoriteSongsProvider).when(
                    data: (songs) {
                      return Expanded(
                        child: songs.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.music_off,
                                        size: 60, color: theme.disabledColor),
                                    const SizedBox(height: Sizes.sm),
                                    Text(
                                      'No favorite songs yet',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: Sizes.xs),
                                    Text(
                                      'Add some songs to your favorites',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    songs.length, // Modified to remove +1
                                itemBuilder: (context, index) {
                                  final song = songs[index];
                                  return Card(
                                    margin:
                                        const EdgeInsets.only(bottom: Sizes.xs),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(Sizes.sm),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        ref
                                            .read(currentSongNotifierProvider
                                                .notifier)
                                            .updateSong(song);
                                      },
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: Sizes.sm,
                                        vertical: Sizes.xs,
                                      ),
                                      title: Text(
                                        song.song_name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: Text(
                                        song.artist,
                                        style: TextStyle(
                                          color: theme.hintColor,
                                        ),
                                      ),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: song.thumbnail_url,
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.music_note),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          CupertinoIcons.play_circle_fill,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          ref
                                              .read(currentSongNotifierProvider
                                                  .notifier)
                                              .updateSong(song);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                    loading: () => const Expanded(
                      child: Center(
                        child: Loader(),
                      ),
                    ),
                    error: (error, stack) => Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red,
                            ),
                            const SizedBox(height: Sizes.sm),
                            Text(
                              'Failed to load songs',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: Sizes.xs),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.lg),
                              child: Text(
                                error.toString(),
                                style: theme.textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

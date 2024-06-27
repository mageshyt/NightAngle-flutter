import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
import 'package:nightAngle/features/home/view/widgets/section-header.dart';
import 'package:nightAngle/features/home/view/widgets/songs-page/recently-played-song.dart';
import 'package:nightAngle/features/home/view/widgets/songs-page/songs-card.dart';

import 'package:nightAngle/features/home/view/widgets/songs-page/songs-page-header.dart';
import 'package:nightAngle/features/home/viewmodel/home_viewmodel.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(currentUserNotifierProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          children: [
            // Header section

            SongsPageHeader(user: user),


            const SizedBox(height: Sizes.spaceBtwSections),

            // Recent played section
            const RecentlyPlayedSong(),

            // Songs section

            SectionHeader(
              title: 'Your Songs',
              onTap: () {},
            ),

            ref.watch(getCurrentUserSongsProvider).when(
                  loading: () => const Center(child: Loader()),
                  error: (error, stackTrace) => Center(
                    child: Text('Error: $error'),
                  ),
                  data: (songs) => SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: songs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return FadeIn(
                          delay: Duration(milliseconds: 500 * index),
                          child: SongsCard(song: song),
                        );
                      },
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

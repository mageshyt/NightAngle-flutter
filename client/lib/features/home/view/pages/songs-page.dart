import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
import 'package:nightAngle/core/theme/text-style.dart';
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

            Row(
              children: [
                // greeting and user name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Good Evening 👋',
                      style: TextStyles.greetingStyle,
                    ),
                    Text(user!.name,
                        style: const TextStyle(
                          fontSize: Sizes.fontSizeMd,
                          color: Pallete.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),

                // search icon

                const Spacer(),

                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  icon: const Icon(IconlyLight.search),
                  color: Pallete.white,
                ),

                // notification icon
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  icon: const Icon(CupertinoIcons.bell),
                  color: Pallete.white,
                ),
              ],
            ),

            const SizedBox(height: Sizes.spaceBtwSections),

            // Songs section

            Row(
              children: [
                const Text(
                  'Your Songs',
                  style: TextStyles.sectionHeading,
                  
                ),
                const Spacer(),
                Button(
                  onPressed: () {},
                  variant: ButtonVariant.ghost,
                  label: const Text(
                    'View All',
                    style: TextStyle(
                      color: Pallete.subtitleText,
                      fontSize: Sizes.fontSizesm,
                    ),
                  ),
                ),
              ],
            ),

            ref.watch(getAllSongsProvider).when(
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
                        return Container(
                          width: 190,
                          margin:
                              const EdgeInsets.only(right: Sizes.spaceBtwItems),
                          padding: const EdgeInsets.all(Sizes.sm),
                          decoration: BoxDecoration(
                            color: Pallete.cardColor,
                            borderRadius:
                                BorderRadius.circular(Sizes.borderRadiusXl),
                            image: DecorationImage(
                              image: NetworkImage(song.thumbnail_url),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken,
                              ),
                            ),
                          ),

                          // song name and artist name

                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(Sizes.sm),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white70.withOpacity(0.2),
                                        Colors.white.withOpacity(0.3),
                                        Colors.white30.withOpacity(0.1),
                                      ],
                                      tileMode: TileMode.mirror,
                                    ),
                                    backgroundBlendMode: BlendMode.srcOver,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.borderRadiusXl),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.song_name,
                                        style: const TextStyle(
                                          color: Pallete.white,
                                          fontSize: Sizes.fontSizeMd,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        song.artist,
                                        style: const TextStyle(
                                          color: Pallete.white,
                                          fontSize: Sizes.fontSizesm,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // play icon

                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    IconlyBold.play,
                                    color: Pallete.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

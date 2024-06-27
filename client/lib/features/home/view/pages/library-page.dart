import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/constants/constants.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/home/view/widgets/section-header.dart';
import 'package:nightAngle/features/home/view/widgets/songs-page/songs-card.dart';
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
                          // grid view with 2 cross axis count
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: Sizes.spaceBtwItems,
                              mainAxisSpacing: Sizes.spaceBtwItems,
                            ),
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              return SongsCard(
                                song: songs[index],
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

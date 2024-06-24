import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/features/home/models/song-model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SongsCard extends StatelessWidget {
  final SongModel song;
  const SongsCard({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(right: Sizes.spaceBtwItems),
      padding: const EdgeInsets.all(Sizes.sm),
      decoration: BoxDecoration(
        color: Pallete.cardColor,
        borderRadius: BorderRadius.circular(Sizes.borderRadiusXl),
        image: DecorationImage(
          image: CachedNetworkImageProvider(song.thumbnail_url),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
  }
}

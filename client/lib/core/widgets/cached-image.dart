import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height,
      width: width,
      
      // TODO : add shimmer effect
      placeholder: (context, url) =>
          placeholder ?? const CircularProgressIndicator(),
      errorWidget: (context, url, err) =>
          errorWidget ?? const Icon(Icons.error_outline),
    );
  }
}

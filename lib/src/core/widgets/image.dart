import "package:cached_network_image/cached_network_image.dart";
import 'package:flutter/cupertino.dart';
import 'package:pokedex/gen/assets.gen.dart';

/// A widget wrapper for ```CachedNetworkImage```.
class HostedImage extends StatelessWidget {
  const HostedImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  final String url;
  final double? height, width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      height: height,
      width: width,
      progressIndicatorBuilder: (_, s, i) =>
          CupertinoActivityIndicator.partiallyRevealed(
        progress: i.progress ?? 1,
      ),
      errorWidget: (_, __, ___) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Assets.images.appLogo.image(
          fit: BoxFit.contain,
        ),
      ),
      fadeInDuration: const Duration(milliseconds: 1000),
    );
  }
}

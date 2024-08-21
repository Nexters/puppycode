import 'package:flutter/material.dart';
import 'package:puppycode/shared/styles/color.dart';

class SharedNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SharedNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: ThemeColor.gray2,
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Center(
          child: Icon(Icons.error),
        );
      },
    );
  }
}

class UserNetworkImage extends StatelessWidget {
  final String url;
  final bool isDimmed;
  final double? width;
  final double? height;
  final BoxFit fit;

  const UserNetworkImage({
    super.key,
    this.url = '',
    this.width,
    this.height,
    this.isDimmed = false,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
        ? Image.network(
            url,
            fit: fit,
            height: height,
            width: width,
            colorBlendMode: BlendMode.colorDodge,
            color: isDimmed ? ThemeColor.white.withOpacity(0.4) : null,
          )
        : Image.asset(
            'assets/images/profile.png',
            width: width,
            height: height,
            fit: fit,
          );
  }
}

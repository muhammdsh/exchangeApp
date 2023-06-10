import 'package:flutter/material.dart';

import '../flows/home_flow/components/cashed_image.dart';

class RoundedCornerImage extends StatelessWidget {
  /// toWorkOn : set default value for the cornerRadius
  /// toWorkOn : add shadow
  final double cornerRadius;
  final double width;
  final double height;
  final String image;
  final String placeHolder;
  final bool isNetworkImage;
  final BoxFit fit;

  const RoundedCornerImage({
    @required this.cornerRadius,
    @required this.image,
    this.width,
    this.height,
    this.placeHolder,
    this.isNetworkImage = true,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child: isNetworkImage == null || isNetworkImage == true
              ? CachedImage(
                  imageUrl: image,
                  fit: fit ?? BoxFit.cover,
                )
              : Image.asset(
                  image,
                  fit: fit ?? BoxFit.cover,
                )),
    );
  }
}

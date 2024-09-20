import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  final String? image;
  final bool isWebImage;
  final double? height;
  final double? webHeight;
  final double? width;
  final double? webWidth;
  final Color? color;
  final BoxFit? fit;
  final BoxFit? webFit;

  const AppNetworkImage(
      {super.key,
      @required this.image,
      this.webFit,
      this.fit,
      this.height,
      this.webHeight,
      this.width,
      this.webWidth,
      this.color,
      this.isWebImage = false});

  @override
  Widget build(BuildContext context) {
    if (isWebImage) {
      return CachedNetworkImage(
          imageUrl: image!,
          height: webHeight,
          width: webWidth,
          fit: webFit ?? BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.black38,
                child: Container(
                  color: AppColors.blackColor,
                  height: webHeight,
                  width: webWidth,
                ),
              ),
          errorWidget: (context, url, error) {
            return Container(
              color: AppColors.lightGreyColor.withOpacity(0.3),
              height: webHeight,
              width: webWidth,
            );
          });
    } else {
      return Image.asset(
        image!,
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
        color: color,
      );
    }
  }
}

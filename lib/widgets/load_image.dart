import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  const LoadImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.format = ImageFormat.png,
    this.holderImg = 'none',
    this.cacheWidth,
    this.cacheHeight,
  })  : assert(image != null, 'The [image] argument must not be null.'),
        super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageFormat format;
  final String holderImg;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return LoadAssetImage(
        holderImg,
        height: height,
        width: width,
        fit: fit,
        format: format,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }
    if (image.startsWith('http') || image.startsWith('https')) {
      final Widget _image =
          LoadAssetImage(holderImg, height: height, width: width, fit: fit);
      return CachedNetworkImage(
        imageUrl: image,
        placeholder: (_, __) => _image,
        errorWidget: (_, __, dynamic error) => _image,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
      );
    } else {
      return LoadAssetImage(
        image,
        height: height,
        width: width,
        fit: fit,
        format: format,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(this.image,
      {Key? key,
      this.width,
      this.height,
      this.cacheWidth,
      this.cacheHeight,
      this.fit,
      this.format = ImageFormat.png,
      this.color})
      : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final ImageFormat format;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,

      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}

class LoadBorderImage extends StatelessWidget {
  const LoadBorderImage(this.image,
      {Key? key,
      this.width,
      this.height,
      this.holderImg = 'none',
      this.radius = 5,
      this.fit = BoxFit.fill})
      : super(key: key);
  final String image;
  final double? width;
  final double? height;
  final String holderImg;
  final double? radius;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colours.bg_color, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(radius ?? 5.r),
        image: DecorationImage(
          fit: fit,
          image: ImageUtils.getImageProvider(image, holderImg: holderImg),
        ),
      ),
    );
  }
}

import 'package:flashinfo/company/widget/details/gallery_example_item.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryExampleItem> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildItem,
          itemCount: widget.galleryItems.length,
          loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          pageController: widget.pageController,
          onPageChanged: onPageChanged,
          scrollDirection: widget.scrollDirection,
        ),
        Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp5),
              decoration: BoxDecoration(
                color: Colours.text,
                borderRadius: BorderRadius.all(Radius.circular(13.0.r)),
              ),
              child: Text(
                '${currentIndex + 1} / ${widget.galleryItems.length}',
                style: TextStyles.textSize14.copyWith(
                  color: Colours.material_bg,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
            )),
      ],
    ));
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryExampleItem item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider:
          ImageUtils.getImageProvider(item.resource, holderImg: 'none'),
      initialScale: PhotoViewComputedScale.contained,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}

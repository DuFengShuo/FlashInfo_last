import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double? collapsedHeight;
  final double? expandedHeight;
  final double? paddingTop;
  final String? coverImgUrl;
  final String? title;
  final String? type;
  final String? avatarUrl;
  final Widget? sliverHeaderWidget;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.avatarUrl,
    this.title,
    this.type,
    this.sliverHeaderWidget,
  });

  @override
  double get minExtent => collapsedHeight! + paddingTop!;

  @override
  double get maxExtent => expandedHeight!;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(double shrinkOffset, Color color) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return color.withAlpha(alpha);
  }

  Color makeStickyHeaderTextColor(double shrinkOffset, bool isIcon) {
    if (shrinkOffset <= 54.h) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colours.material_bg,
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: sliverHeaderWidget ??
                Container(
                    color: Colours.material_bg,
                    child: Image.network(coverImgUrl!, fit: BoxFit.cover)),
          ),
          // 收起头部
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: AppBar(
                  elevation: 0,
                  titleSpacing: 0,
                  leading: SizedBox(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      // tooltip: 'icon_back',
                      // padding: const EdgeInsets.all(12.0),
                      icon: IconFont(
                          name: 0xe613,
                          size: 16,
                          color: shrinkOffset < 1
                              ? Colours.material_bg
                              : Colors.black),
                    ),
                  ),
                  backgroundColor: makeStickyHeaderBgColor(
                      shrinkOffset, Colours.material_bg),
                  centerTitle: false,
                  // automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      if (shrinkOffset < 1)
                        Gaps.empty
                      else
                        Container(
                          decoration: BoxDecoration(
                              color: makeStickyHeaderBgColor(
                                  shrinkOffset, Colours.material_bg),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ImageUtils.getImageProvider(
                                      avatarUrl ?? ''))),
                          width: 22.w,
                          height: 22.w,
                          // child: Image(
                          //   fit: BoxFit.fill,
                          //   image: ImageUtils.getImageProvider(avatarUrl??''),),
                          // child: Image.network(coverImgUrl!, fit: BoxFit.cover),
                        ),
                      Gaps.hGap8,
                      Expanded(
                        child: Text(
                          "${shrinkOffset < 1 ? "" : title} ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colours.text,
                            // color: this.makeStickyHeaderBgColor(
                            //     shrinkOffset, Colors.white), // 标题颜色
                          ),
                        ),
                      ),
                      Gaps.hGap10,
                    ],
                  ))),
        ],
      ),
    );
  }
}

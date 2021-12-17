import 'package:flutter/material.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'list_animation_layout.dart';

class HeadAnimationLayout extends StatelessWidget {
  const HeadAnimationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colours.bg_layout,
      highlightColor: Colours.bg_layout_f5,
      child: MyScrollView(children: _buildBody),
    );
  }

  List<Widget> get _buildBody => <Widget>[
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 120.0.h,
            ),
            Container(
                width: double.infinity,
                height: 95.0.h,
                color: Colours.bg_color),
            Positioned(
                left: (ScreenUtil().screenWidth / 2) - 35.w,
                bottom: 5.0.h,
                child: Container(
                    width: 70.w, height: 70.0.h, color: Colours.bg_layout))
          ],
        ),
        Gaps.vGap10,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 200.w, height: 15.h, color: Colours.bg_layout),
              Gaps.vGap5,
              Container(
                  width: double.infinity,
                  height: 15.h,
                  color: Colours.bg_layout),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 30.h,
                  width: double.infinity,
                  color: Colours.bg_layout,
                ),
              ),
            ],
          ),
        ),
        Gaps.lineV,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 100.w, height: 15.h, color: Colours.bg_layout),
                Gaps.vGap10,
                Container(
                    width: double.infinity,
                    height: 30.h,
                    color: Colours.bg_layout),
                Gaps.vGap10,
                const AnimationItem(),
                const AnimationItem(),
                const AnimationItem(),
                const AnimationItem(),
                const AnimationItem(),
                const AnimationItem(),
                const AnimationItem(),
                const AnimationItem(),
                const AnimationItem(),
              ],
            )),
      ];
}

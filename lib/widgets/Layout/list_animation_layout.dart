import 'package:flashinfo/res/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListAnimationLayout extends StatelessWidget {
  const ListAnimationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colours.bg_layout,
          highlightColor: Colours.bg_layout_f5,
          child: const AnimationItem(),
        );
      },
    );
  }
}

class AnimationItem extends StatelessWidget {
  const AnimationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: Dimens.gap_dp1),
        ),
      ),
      child: Row(
        children: [
          Container(height: 50.0.h, width: 50.0.w, color: Colours.bg_layout),
          Gaps.hGap16,
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 13.0.h,
                  width: double.infinity,
                  color: Colours.bg_layout),
              Container(
                  height: 13.0.h,
                  width: double.infinity,
                  color: Colours.bg_layout),
              Container(
                  height: 10.0.h, width: 200.0.w, color: Colours.bg_layout),
            ],
          ))
        ],
      ),
    );
  }
}

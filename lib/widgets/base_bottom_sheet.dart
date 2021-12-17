import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({Key? key, this.height, required this.children})
      : super(key: key);
  final double? height;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? context.height / 2,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colours.material_bg,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.w),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Dimens.gap_v_dp16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                )
              ],
            )));
  }
}

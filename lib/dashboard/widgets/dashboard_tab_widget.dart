import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flashinfo/util/screen_utils.dart';

class DashboardTobWidget extends StatelessWidget {
  const DashboardTobWidget({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          bottom: Dimens.gap_v_dp1),
      alignment: Alignment.centerLeft,
      height: 44.h,
      decoration: BoxDecoration(
        color: Colours.material_bg,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: TabBar(
        controller: tabController,
        // padding: EdgeInsets.symmetric(horizontal: 60.w),
        indicatorPadding:
            EdgeInsets.only(left: 45.w, right: 45.w, bottom: -10.w),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colours.app_main,
        unselectedLabelColor: Colours.text_gray,
        labelColor: Colours.app_main,
        unselectedLabelStyle: TextStyles.textSize15,
        labelStyle: TextStyles.textSize15.copyWith(fontWeight: FontWeight.w600),
        isScrollable: true,
        tabs: <Widget>[
          SizedBox(
            width: (context.width - 120.w) / 2,
            child: const Text(
              'Brand',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: (context.width - 120.w) / 2,
            child: const Text(
              'News',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardSearchWidget extends StatelessWidget {
  final Function callBack;
  final String type;
  const DashboardSearchWidget(
      {Key? key, required this.callBack, this.type = ''})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
          height: 44.w,
          decoration: BoxDecoration(
            color: Colours.material_bg,
            borderRadius: BorderRadius.all(Radius.circular(22.w)),
          ),
          child: Row(
            children: [
              IconFont(
                  name: 0xe60b,
                  size: Dimens.font_sp14,
                  color: Colours.text_gray),
              Gaps.hGap10,
              Expanded(
                child: Text(
                  'Search for companies，contact，products',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textGray12
                      .copyWith(color: Colours.text_gray_c),
                ),
              ),
            ],
          ),
        ));
  }
}

class DashboardSearchLogWidget extends StatelessWidget {
  final Function callBack;
  final String type;
  const DashboardSearchLogWidget(
      {Key? key, required this.callBack, this.type = ''})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoadAssetImage(
          'dashboard/dashboard_tab_logo',
          color: Colours.material_bg,
          width: 60.w,
          height: 38.5.h,
          fit: BoxFit.fill,
        ),
        Gaps.hGap10,
        Expanded(
            child: GestureDetector(
                onTap: () => callBack(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
                  height: 38.5.h,
                  decoration: BoxDecoration(
                    color: Colours.material_bg,
                    borderRadius: BorderRadius.all(Radius.circular(22.h)),
                  ),
                  child: Row(
                    children: [
                      IconFont(
                          name: 0xe60b,
                          size: Dimens.font_sp14,
                          color: Colours.text_gray),
                      Gaps.hGap10,
                      Expanded(
                        child: Text(
                          'Search for companies，contact，products',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.textGray12
                              .copyWith(color: Colours.text_gray_c),
                        ),
                      ),
                    ],
                  ),
                )))
      ],
    ));
  }
}

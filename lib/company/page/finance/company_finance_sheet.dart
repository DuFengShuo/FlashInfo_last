import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyFinanceSheet extends StatelessWidget {
  const CompanyFinanceSheet(
      {Key? key,
      required this.child,
      required this.title,
        required this.subTitle,
      required this.firstLeft,
      required this.firstRight,
      required this.lastLeft,
      required this.lastRight})
      : super(key: key);
  final Widget child;
  final String title;
  final String firstLeft;
  final String firstRight;
  final String lastLeft;
  final String lastRight;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return MyScrollView(
      // height: 600.h,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
          width: Screen.width(context),
          decoration: BoxDecoration(
              color: Colours.material_bg,
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstLeft,
                style:
                    TextStyles.textBold12.copyWith(fontWeight: FontWeight.bold),
              ),
              Gaps.vGap5,
              Text(
                '$firstRight ',
                style: TextStyles.textBold24.copyWith(color: Colours.app_main),
              ),
              Gaps.vGap16,
              Text(
                lastLeft,
                style:
                    TextStyles.textBold12.copyWith(fontWeight: FontWeight.bold),
              ),
              Gaps.vGap5,
              Text(
                lastRight,
                style: TextStyles.textBold24.copyWith(color: Colours.app_main),
              ),
               Gaps.vGap16,
              Gaps.line,
              Gaps.vGap16,
              Text('$subTitle',
                style: TextStyles.textGray12.copyWith(color: Colours.text),),
              Gaps.vGap16,
              Container(
                child: child,
              )

            ],
          ),
        ),

        // Container(
        //   margin:
        //       EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h, top: 8.h),
        //   width: Screen.width(context),
        //   decoration: BoxDecoration(
        //       color: Colours.material_bg,
        //       borderRadius: BorderRadius.all(Radius.circular(12.r))),
        //   padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.h),
        //   child: child,
        // ),
      ],
    );
  }
}

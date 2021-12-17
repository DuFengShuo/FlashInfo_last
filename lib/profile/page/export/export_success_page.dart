import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/dotted_border/dotted_border.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExportSuccessPage extends StatefulWidget {
  const ExportSuccessPage({Key? key, this.exportModel}) : super(key: key);
  final ExportModel? exportModel;
  @override
  _ExportSuccessPageState createState() => _ExportSuccessPageState();
}

class _ExportSuccessPageState extends State<ExportSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
        FocusManager.instance.primaryFocus?.unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: MyAppBar(
          centerTitle: 'Successfully exported',
          backOnPressed: () {
            NavigatorUtils.goBack(context);
            NavigatorUtils.goBack(context);
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 65.w),
          child: Column(
            children: [
              Gaps.line,
              Gaps.vGap20,
              Gaps.vGap10,
              IconFont(name: 0xe63b, size: 75.sp, color: Colours.app_main),
              Gaps.vGap15,
              Text(
                'Successfully exported',
                style: TextStyles.textBold16,
              ),
              Gaps.vGap20,
              DottedBorder(
                dashPattern: const [4, 2],
                strokeWidth: 0.5,
                color: Colours.text_gray_c,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp5),
                  child: Text(
                    'The exported content is sent to your mailbox：${widget.exportModel?.email}',
                    style: TextStyles.textGray10.copyWith(height: 1.8.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Gaps.vGap20,
              Gaps.vGap20,
              Gaps.vGap10,
              MyButton(
                fontSize: 13.sp,
                minHeight: 37.h,
                textColor: Colours.app_main,
                backgroundColor: Colours.material_bg,
                side: BorderSide(
                    color: Colours.app_main,
                    width: 0.5.w,
                    style: BorderStyle.solid),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                  NavigatorUtils.goBack(context);
                  NavigatorUtils.pushResult(
                      context, ProfileRouter.exportDetailsPage, (value) {
                    print(value);
                  }, arguments: widget.exportModel);
                },
                text: 'View Details',
              ),
              Gaps.vGap15,
              MyButton(
                fontSize: 13.sp,
                minHeight: 37.h,
                onPressed: () {
                  NavigatorUtils.goBack(context);
                  NavigatorUtils.goBack(context);
                },
                text: 'Back to homepage',
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyDetailsItemHeader extends StatelessWidget {
  const CompanyDetailsItemHeader(
      {Key? key,
      this.onTap,
      required this.name,
      this.iconName,
      this.fontSize,
      this.isNext,
      this.showLine,
      this.count = 0,
      this.isNewIcon = false,
      this.showImage = false, this.imageName})
      : super(key: key);
  final void Function()? onTap;
  final int? iconName;
  final String name;
  final double? fontSize;
  final bool? isNext;
  final bool? showLine;
  final int? count;
  final bool isNewIcon;
  final bool showImage;
  final String? imageName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp12),
      child: Row(
        children: [
          if (showImage == true)
            Padding(
              padding:EdgeInsets.only(right: Dimens.gap_dp8),
              child: LoadBorderImage(
                '$imageName',
                width: 30.w,
                height: 30.w,
                radius: 8.r,
                holderImg: 'company/company',
              ),
            )
          else
            Visibility(
              visible: iconName != null,
              child: Padding(
                padding: EdgeInsets.only(right: Dimens.gap_dp8),
                child: IconFont(
                    isNewIcon: isNewIcon,
                    name: iconName ?? 0xe66e,
                    color: Colours.app_main,
                    size: Dimens.font_sp18,
                  ),

              ),
            ),
          Expanded(
            child: Text(
              name,
              style: TextStyles.textBold14.copyWith(
                  color: Colours.text,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize ?? 14.0.sp),
            ),
          ),
          Visibility(
              // 无点击事件时，隐藏箭头图标
              visible: onTap == null ? false : true,
              child: isNext != null && isNext == true
                  ? const IconFont(
                      name: 0xe612,
                      size: 12,
                      color: Colours.text_gray_c,
                    )
                  : GestureDetector(
                      onTap: () {
                        if (!(SpUtil.getBool(Constant.isLogin,
                                defValue: false) ??
                            false)) {
                          showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => LoginToastDialog(onPressed: () {
                                    Navigator.pop(context);
                                    NavigatorUtils.push(
                                        context, LoginRouter.smsLoginPage);
                                  }));
                          return;
                        }
                        onTap!();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.gap_dp10,
                            vertical: Dimens.gap_v_dp4),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colours.border_grey,
                              width: 1,
                              // style: BorderStyle.solid
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MORE',
                              style: TextStyles.textSize12
                                  .copyWith(color: Colours.text_gray_c),
                            ),
                            if (count == 0)
                              Gaps.hGap4
                            else
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.gap_dp5),
                                child: Text(
                                  '$count',
                                  style: TextStyles.textBold10
                                      .copyWith(color: Colours.app_main),
                                ),
                              ),
                            const IconFont(
                              name: 0xe612,
                              size: 6,
                              color: Colours.text_gray_c,
                            ),
                          ],
                        ),
                      ),
                    ))
        ],
      ),
    );
  }
}

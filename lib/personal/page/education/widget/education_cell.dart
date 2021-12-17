import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/widget/personal_info_toast.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EducationCell extends StatefulWidget {
  final bool isShowLine;
  final Education? education;

  const EducationCell({Key? key, required this.isShowLine, this.education})
      : super(key: key);

  @override
  _EducationCellState createState() => _EducationCellState();
}

class _EducationCellState extends State<EducationCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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

        showModalBottomSheet<void>(
            // 权限提示弹框
            backgroundColor: Colors.transparent, //重点
            context: context,
            builder: (BuildContext context) {
              return PersonalInfoToastWidget(
                name: widget.education?.eduName,
                avatarUrl: widget.education?.eduLogo,
                detailId: widget.education?.eduId,
                startDate: widget.education?.startDate,
                endDate: widget.education?.endDate,
                desc: widget.education?.subject,
              );
            });
      },
      child: Container(
        color: Colours.material_bg,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap8,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadBorderImage(
                  '${widget.education?.eduLogo ?? ''}',
                  width: 42.w,
                  height: 42.w,
                  holderImg: 'personnel/person_education',
                  radius: 8.r,
                ),
                Gaps.hGap10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            '${widget.education?.eduName}',
                            style: TextStyles.textBold14.copyWith(
                                color: Colours.text, fontWeight: FontWeight.bold,height: 1.4.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        visible: widget.education!.eduName!.isNotEmpty,
                      ),

                      Visibility(
                        child: Padding(
                          padding:  EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            '${widget.education?.subject ?? ''}',
                            style: TextStyles.textSize12.copyWith(height: 1.4.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        visible: widget.education!.subject!.isNotEmpty,
                      ),

                      Visibility(
                          visible: widget.education!.startDate!.isNotEmpty &&
                              widget.education!.endDate!.isNotEmpty,
                          child: Text(
                            '${widget.education?.startDate ?? ''} ~ ${widget.education?.endDate ?? ''}',
                            style:
                                TextStyles.textGray12.copyWith(height: 1.4.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ],
                  ),
                ),
                Gaps.hGap8
              ],
            ),
            Gaps.vGap8,
            Visibility(
              visible: widget.isShowLine,
              child: Gaps.line,
            )
          ],
        ),
      ),
    );
  }
}

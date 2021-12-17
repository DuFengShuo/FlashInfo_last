import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/personal/page/experience/widget/experience_only_toast.dart';
import 'package:flashinfo/personal/page/experience/widget/personal_experience_toast_widget.dart';
import 'package:flashinfo/personal/widget/personal_info_toast.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperienceCell extends StatefulWidget {
  final WorkData? workData;

  const ExperienceCell({Key? key, this.workData}) : super(key: key);

  @override
  _ExperienceCellState createState() => _ExperienceCellState();
}

class _ExperienceCellState extends State<ExperienceCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.workData!.work.length > 1) {
            if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
              showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => LoginToastDialog(onPressed: () {
                        Navigator.pop(context);
                        NavigatorUtils.push(context, LoginRouter.smsLoginPage);
                      }));
              return;
            }
            showModalBottomSheet<void>(
                // 权限提示弹框
                backgroundColor: Colors.transparent, //重点
                context: context,
                builder: (BuildContext context) {
                  return PersonalExperienceDes(
                    workData: widget.workData,
                  );
                });
          } else {
            if (widget.workData!.work.isNotEmpty) {
              if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ??
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

              Work work = widget.workData!.work[0];
              showModalBottomSheet<void>(
                  // 权限提示弹框
                  backgroundColor: Colors.transparent, //重点
                  context: context,
                  builder: (BuildContext context) {
                    return ExOnlyToastWidget(
                      name: widget.workData!.companyName,
                      avatarUrl: widget.workData!.companyLogo,
                      detailId: widget.workData!.companyId,
                      startDate: work.entryTime,
                      endDate: work.leaveTime,
                      desc: work.desc,
                      address: widget.workData!.companyAddress,
                      year: work.totalTime,
                      entityType: widget.workData?.entityType??0,
                    );
                  });
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colours.material_bg,
              border: Border.all(width: 1, color: Colours.border_grey),
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.symmetric(
              vertical: Dimens.gap_v_dp8, horizontal: Dimens.gap_dp8),
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadBorderImage(
                    '${widget.workData!.companyLogo}',
                    width: 42.w,
                    height: 42.w,
                    holderImg: 'personnel/person_experience',
                    radius: 8.r,
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Gaps.vGap5,
                        Text(
                          '${widget.workData!.companyName.isEmpty?'-':widget.workData?.companyName}',
                          style: TextStyles.textBold14.copyWith(
                              color: Colours.text, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gaps.vGap8,
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 3.h),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.workData!.work.length > 2
                                ? 2
                                : widget.workData!.work.length,
                            itemBuilder: (BuildContext context, int index) {
                              Work work = widget.workData!.work[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.r)),
                                                color: Colours.app_main),
                                            width: 12.w,
                                            height: 12.w,
                                          ),
                                          Gaps.vGap4,
                                          Visibility(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4.r)),
                                                  color: Colours.line),
                                              width: 2.w,
                                              height: 32.h,
                                            ),
                                            visible: index != 1,
                                          )
                                        ],
                                      ),
                                      visible:
                                          widget.workData!.work.length != 1,
                                    ),
                                    Visibility(
                                      child: Gaps.hGap8,
                                      visible:
                                          widget.workData!.work.length != 1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${work.position}',
                                          style: TextStyles.textSize12
                                              .copyWith(height: 1.0.sp),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Gaps.vGap8,
                                        Row(
                                          children: [
                                            Visibility(
                                              child: Text(
                                                '${work.entryTime}~ ${work.leaveTime}',
                                                style: TextStyles.textGray12
                                                    .copyWith(height: 1.4.sp),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              visible:
                                                  work.entryTime.isNotEmpty &&
                                                      work.leaveTime.isNotEmpty,
                                            ),
                                            Gaps.hGap12,
                                            Visibility(
                                              child: Text(
                                                '${work.totalTime}',
                                                style: TextStyles.textGray12
                                                    .copyWith(height: 1.4.sp),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              visible:
                                                  work.totalTime.isNotEmpty,
                                            ),
                                          ],
                                        ),
                                        // Visibility(
                                        //   child: Padding(
                                        //       padding: EdgeInsets.only(
                                        //           top: 8.h, right: 10),
                                        //       child: Container(
                                        //         child: Text(
                                        //           '${work.desc}',
                                        //           style: TextStyles.textGray12
                                        //               .copyWith(height: 1.4.sp),
                                        //           maxLines: 2,
                                        //           overflow: TextOverflow.ellipsis,
                                        //         ),
                                        //         constraints: BoxConstraints(
                                        //             maxWidth: 200.w),
                                        //       )),
                                        //   visible: work.desc.isNotEmpty,
                                        // ),
                                        Gaps.vGap8,
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  // Gaps.vGap8
                ],
              ),

              Visibility(
                  visible: widget.workData!.work.length > 2,
                  child: Container(
                    alignment: Alignment.center,
                    width: 165.w,
                    height: 44.h,
                    margin: EdgeInsets.only(bottom: 5.h),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colours.line),
                        borderRadius: BorderRadius.all(Radius.circular(44.r))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const IconFont(
                            name: 0xe665,
                            isNewIcon: true,
                            size: 20,
                            color: Colours.app_main,
                          ),
                          Gaps.hGap5,
                          Text(
                            'View More',
                            style: TextStyles.textSize12
                                .copyWith(color: Colours.app_main),
                          )
                        ],
                      ),
                    ),
                  ))
              // Gaps.vGap5,
            ],
          ),
        ));
  }

  void onTapIcon(BuildContext context, WorkData workData) {
    showModalBottomSheet<void>(
        // 权限提示弹框
        backgroundColor: Colors.transparent, //重点
        context: context,
        builder: (BuildContext context) {
          return PersonalExperienceDes(
            workData: workData,
          );
        });
  }
}

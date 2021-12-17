import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/personal/model/person_work_bean.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalExperienceDes extends StatelessWidget {
  const PersonalExperienceDes({Key? key, this.workData, }) : super(key: key);

  final WorkData? workData;

  @override
  Widget build(BuildContext context) {
    // final List<String> allLinksArray = getAllLinks(info);
    return Container(
        // height: double.maxFinite ,
        margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap17,
            Expanded(
                child: MyScrollView(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    isSafeArea: false,
                    bottomButton: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      child: GestureDetector(
                        onTap: () {
                          NavigatorUtils.goBack(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 44.h,
                          width: Screen.width(context),
                          margin:
                              EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colours.border_grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(44.h))),
                          child: Text(
                            'Cancel',
                            style: TextStyles.text,
                          ),
                        ),
                      ),
                    ),
                    children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colours.material_bg,
                                    border: Border.all(
                                        width: 1, color: Colours.border_grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 10.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LoadBorderImage(
                                            '${workData!.companyLogo}',
                                            width: 42.w,
                                            height: 42.w,
                                            holderImg:
                                                'personnel/person_experience',
                                            radius: 8.r,
                                          ),
                                          Gaps.hGap10,
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${workData?.companyName??'-'}',

                                                style: TextStyles.textBold18
                                                    .copyWith(
                                                        color: Colours.text,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                // maxLines: 2,
                                                // overflow: TextOverflow.ellipsis,
                                              ),
                                              Visibility(
                                                visible: workData!
                                                    .companyAddress.isNotEmpty,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8.h),
                                                  child: Text(
                                                      '${workData!.companyAddress}',
                                                      style:
                                                          TextStyles.textGray12
                                                      // maxLines: 2,
                                                      // overflow: TextOverflow.ellipsis,
                                                      ),
                                                ),
                                              )
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                    const IconFont(
                                      name: 0xe612,
                                      size: 12,
                                      color: Colours.text_gray_c,
                                    )
                                  ],
                                )),
                            onTap: () {
                              Navigator.pop(context);

                              if(workData?.entityType==2) {
                                NavigatorUtils.push(
                                    context, '${BrandRouder.brandDetailPage}?brandId=${workData?.companyId}&&isToIndex=${'true'}');

                              }
                              if(workData?.entityType==1){

                                NavigatorUtils.push(context,
                                    '${CompanyRouder.companyDetailsPage}?companyId=${workData!.companyId}&&isToIndex=${'true'}');
                              }

                            },
                          ),
                          Gaps.vGap16,
                          ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: workData!.work.length,
                              itemBuilder: (BuildContext context, int index) {
                                Work work = workData!.work[index];
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12.r)),
                                                        color:
                                                            Colours.app_main),
                                                    width: 12.w,
                                                    height: 12.w,
                                                  ),
                                                  Gaps.vGap4,
                                                ],
                                              ),
                                              visible:
                                                  workData!.work.length != 1,
                                            ),
                                            Visibility(
                                              child: Gaps.hGap8,
                                              visible:
                                                  workData!.work.length != 1,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${work.position}',
                                                  style: TextStyles.textSize12
                                                      .copyWith(height: 1.0.sp),
                                                  // maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                                Gaps.vGap8,
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                right: 10.w, left: 5.w),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Visibility(
                                                        child: Text(
                                                          '${work.entryTime}~ ${work.leaveTime}',
                                                          style: TextStyles
                                                              .textGray12
                                                              .copyWith(
                                                                  height:
                                                                      1.4.sp),
                                                          // maxLines: 1,
                                                          // overflow: TextOverflow.ellipsis,
                                                        ),
                                                        visible: work.entryTime
                                                                .isNotEmpty &&
                                                            work.leaveTime
                                                                .isNotEmpty,
                                                      ),
                                                      Gaps.hGap12,
                                                      Visibility(
                                                        child: Text(
                                                          '${work.totalTime}',
                                                          style: TextStyles
                                                              .textGray12
                                                              .copyWith(
                                                                  height:
                                                                      1.4.sp),
                                                          // maxLines: 1,
                                                          // overflow: TextOverflow.ellipsis,
                                                        ),
                                                        visible: work.totalTime
                                                            .isNotEmpty,
                                                      ),
                                                    ],
                                                  ),
                                                  Gaps.vGap8,
                                                  Visibility(
                                                    visible:
                                                        work.desc.isNotEmpty,
                                                    child: Text(
                                                      '${work.desc}',
                                                      style: TextStyles
                                                          .textGray12
                                                          .copyWith(
                                                              height: 1.4.sp),
                                                      // maxLines: 2,
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              constraints: BoxConstraints(
                                                  maxWidth: 200.w),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                          width: 2,
                                                          color: index !=
                                                                  workData!.work
                                                                          .length -
                                                                      1
                                                              ? Colours.line
                                                              : Colors
                                                                  .transparent))),
                                              padding:
                                                  EdgeInsets.only(left: 14.w),
                                            )),
                                        Gaps.vGap10,
                                      ],
                                    ));
                              })
                        ],
                      ),
                    ),
                  ),
                  Gaps.vGap8,
                ])),
          ],
        ));
  }
}

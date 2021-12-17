import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/widget/header_sharerow_widget.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/load_image.dart';

import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalHeaderDes extends StatelessWidget {
  const PersonalHeaderDes({Key? key, this.info, this.position})
      : super(key: key);
  final String? position;
  final Info? info;

  @override
  Widget build(BuildContext context) {
    final List<String> allLinksArray = getAllLinks(info);

    // late String post = '';
    // if (info!.position!.isNotEmpty) {
    //   for (int i = 0; i < info!.position!.length; i++) {
    //     String ee = '';
    //     Position position = info!.position![i];
    //     ee =
    //         '${position.position},${position.position} ${i == info!.position!.length - 1 ? '' : ' | '} ';
    //     post += ee;
    //   }
    // }

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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: LoadBorderImage(
                            '${info?.avatar}',
                            width: 70.w,
                            height: 70.w,
                            radius: 70.r,
                            holderImg: 'personnel/personnel',
                          ),
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                              color: Colours.line,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.r))),
                          padding: const EdgeInsets.all(5),
                        ),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.gap_dp16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${info!.name ?? '-'}',
                                      style: TextStyles.textBold18.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //  Gaps.vGap5,
                                    Visibility(
                                        visible: position!.isNotEmpty,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.h),
                                          child: Text(
                                            '${position!.isEmpty ? '-' : position}',
                                            style: TextStyles.textSize14,
                                            // maxLines: 2,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                  ],
                                ))),
                      ],
                    ),
                  ),
                  // Visibility(
                  //     visible: info!.intro!.isNotEmpty,
                  //     child: Padding(
                  //       padding: EdgeInsets.only(
                  //           left: 16.w, right: 16.w, top: 16.h, bottom: 8.h),
                  //       child: Text(
                  //         'About',
                  //         style: TextStyles.textGray12,
                  //       ),
                  //     )),
                  // Visibility(
                  //     visible: info!.intro!.isNotEmpty,
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  //       child: Text(
                  //         '${info!.intro ?? '-'}',
                  //         style: TextStyles.text,
                  //       ),
                  //     )),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 16.w, top: 16.h, bottom: 8.h),
                    child: Text(
                      'About',
                      style: TextStyles.textGray12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Text(
                      '${info!.intro!.isEmpty?'-':info!.intro}',
                      style: TextStyles.text.copyWith(height: 1.6),
                    ),
                  ),

                  Gaps.vGap16,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Text(
                      'Link',
                      style: TextStyles.textGray12,
                    ),
                  ),
                  Gaps.vGap8,
                  if (allLinksArray.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Text(
                        '-',
                        style: TextStyles.textBold16
                            .copyWith(color: Colours.text_gray),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Container(
                        color: Colours.material_bg,
                        height: 60.h,
                        child: ListView(
                          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            HeaderShareRowWidget(
                              bgColor: Colours.app_main,
                              title: 'Detail',
                              iconUrl: '${info!.linkedin}',
                              iconName: 0xe65e,
                              radius: 44.0.sp,
                              isVisible: info!.linkedin!.isNotEmpty,
                              leftMargin: 18.w,
                            ),
                            HeaderShareRowWidget(
                              bgColor: Colours.app_main,
                              title: 'Detail',
                              iconUrl: '${info!.twitter}',
                              iconName: 0xe65d,
                              radius: 44.0.sp,
                              isVisible: info!.twitter!.isNotEmpty,
                              leftMargin: 18.w,
                            ),
                            HeaderShareRowWidget(
                              bgColor: Colours.app_main,
                              title: 'Detail',
                              iconUrl: '${info!.facebook}',
                              iconName: 0xe65c,
                              radius: 44.0.sp,
                              isVisible: info!.facebook!.isNotEmpty,
                              leftMargin: 18.w,
                            ),
                            HeaderShareRowWidget(
                              bgColor: Colours.app_main,
                              title: 'Detail',
                              iconUrl: '${info!.youtube}',
                              iconName: 0xe660,
                              radius: 44.0.sp,
                              isVisible: info!.youtube!.isNotEmpty,
                              leftMargin: 18.w,
                            ),
                            HeaderShareRowWidget(
                              bgColor: Colours.app_main,
                              title: 'Detail',
                              iconUrl: '${info!.instagram}',
                              iconName: 0xe661,
                              radius: 44.0.sp,
                              isVisible: info!.instagram!.isNotEmpty,
                              leftMargin: 18.w,
                            ),
                            HeaderShareRowWidget(
                              bgColor: Colours.app_main,
                              title: 'Detail',
                              iconUrl: '${info!.github}',
                              iconName: 0xe67a,
                              radius: 44.0.sp,
                              isVisible: info!.github!.isNotEmpty,
                              leftMargin: 18.w,
                            ),
                          ],
                        ),
                      ),
                    )
                ])),
          ],
        ));
  }

  List<String> getAllLinks(Info? info) {
    final List<String> allLinkArray = [];
    if (info!.linkedin!.isNotEmpty) {
      allLinkArray.add(info.linkedin ?? '');
    } else if (info.twitter!.isNotEmpty) {
      allLinkArray.add(info.twitter ?? '');
    } else if (info.facebook!.isNotEmpty) {
      allLinkArray.add(info.facebook ?? '');
    } else if (info.youtube!.isNotEmpty) {
      allLinkArray.add(info.youtube ?? '');
    } else if (info.instagram!.isNotEmpty) {
      allLinkArray.add(info.instagram ?? '');
    }
    return allLinkArray;
  }

  List<Widget> _industryWidget(List<dynamic>? industry) {
    final List<Widget> arr = [];
    final List<dynamic> list = industry ?? <dynamic>[];
    if (list.isNotEmpty) {
      list.forEach((dynamic item) {});
      for (final item in list) {
        arr.add(_borderText(false, '$item'));
      }
    }
    return arr;
  }

  Widget _borderText(bool isIndustry, String text) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp5),
        // constraints: BoxConstraints(maxWidth: 80.w),
        decoration: BoxDecoration(
          color: Colours.bg_color,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
          //设置四周边框
          // border: new Border.all(
          //     width: isIndustry ? 0 : 0.6.w, color: Colours.material_bg),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colours.text_gray,
            fontSize: Dimens.font_sp12,
          ),
        ),
      ),
    );
  }
}

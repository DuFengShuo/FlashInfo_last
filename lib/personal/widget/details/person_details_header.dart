import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/provider/personal_provider.dart';
import 'package:flashinfo/personal/widget/header_sharerow_widget.dart';
import 'package:flashinfo/personal/page/experience/widget/personal_experience_toast_widget.dart';
import 'package:flashinfo/personal/widget/personal_header_toast_widget.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonDetailHeaderWidget extends StatelessWidget {
  const PersonDetailHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalProvider>(builder: (_, provider, __) {
      final PeoplesNewBean? model = provider.personalDetailsBean;
      late String post = '';
      if (model!.info!.position!.isNotEmpty) {
        for (int i = 0; i < model.info!.position!.length; i++) {
          String ee = '';
          Position position = model.info!.position![i];
          ee = '${position.position!.isEmpty?'-':position.position } · ${position.companyName!.isEmpty?'-':position.companyName } ${i == model.info!.position!.length - 1 ? '' : ' | '} ';
          post += ee;
        }
      }
      final List<String> allLinksArray = getAllLinks(model.info);

      return Container(
          // height: 235,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colours.app_main,
          ),
          child: InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                    // 权限提示弹框
                    backgroundColor: Colors.transparent, //重点
                    context: context,
                    builder: (BuildContext context) {
                      return PersonalHeaderDes(
                        info: model.info,
                        position: post,
                      );
                    });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Stack(
                              children: [
                                Container(
                                  child: LoadBorderImage(
                                    '${model.info?.avatar}',
                                    width: 70.w,
                                    height: 70.w,
                                    radius: 70.r,
                                    holderImg: 'personnel/personnel',
                                  ),
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                      color: Colours.material_bg,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(80.r))),
                                  padding:  EdgeInsets.all(3.w),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: LoadAssetImage(
                                    'personnel/person_logo',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 78.h,
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${model.info?.name ?? '-'}',
                                  style: TextStyles.textBold18
                                      .copyWith(color: Colours.material_bg),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gaps.vGap16,
                                if (allLinksArray.isEmpty)
                                  Text(
                                  '-',
                                  style: TextStyles.textSize14
                                      .copyWith(color: Colours.material_bg),
                                ) else

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HeaderShareRowWidget(
                                      bgColor: Colours.material_bg,
                                      title: 'Detail',
                                      iconUrl: '${model.info!.linkedin}',
                                      iconName: 0xe65e,
                                      radius: 22.0.sp,
                                      leftMargin: 0,
                                      isVisible:
                                          model.info!.linkedin!.isNotEmpty,
                                    ),
                                    HeaderShareRowWidget(
                                      bgColor: Colours.material_bg,
                                      title: 'Detail',
                                      iconUrl: '${model.info!.twitter}',
                                      iconName: 0xe65d,
                                      radius: 22.0.sp,
                                      isVisible:
                                          model.info!.twitter!.isNotEmpty,
                                      leftMargin: Dimens.gap_dp8,
                                    ),
                                    HeaderShareRowWidget(
                                      bgColor: Colours.material_bg,
                                      title: 'Detail',
                                      iconUrl: '${model.info!.facebook}',
                                      iconName: 0xe65c,
                                      radius: 22.0.sp,
                                      isVisible:
                                          model.info!.facebook!.isNotEmpty,
                                      leftMargin: Dimens.gap_dp8,
                                    ),
                                    HeaderShareRowWidget(
                                      bgColor: Colours.material_bg,
                                      title: 'Detail',
                                      iconUrl: '${model.info!.youtube}',
                                      iconName: 0xe660,
                                      radius: 22.0.sp,
                                      isVisible:
                                          model.info!.youtube!.isNotEmpty,
                                      leftMargin: Dimens.gap_dp8,
                                    ),
                                    HeaderShareRowWidget(
                                      bgColor: Colours.material_bg,
                                      title: 'Detail',
                                      iconUrl: '${model.info!.instagram}',
                                      iconName: 0xe661,
                                      radius: 22.0.sp,
                                      isVisible:
                                          model.info!.instagram!.isNotEmpty,
                                      leftMargin: Dimens.gap_dp8,
                                    ),
                                    HeaderShareRowWidget(
                                      bgColor: Colours.material_bg,
                                      title: 'Detail',
                                      iconUrl: '${model.info!.github}',
                                      iconName: 0xe67a,
                                      radius: 22.0.sp,
                                      isVisible: model.info!.github!.isNotEmpty,
                                      leftMargin: Dimens.gap_dp8,
                                    ),
                                    const Spacer(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.w, bottom: 5.h),
                          child: IconFont(
                            name: 0xe612,
                            size: 14,
                            color: Colours.material_bg.withAlpha(30),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: post.isNotEmpty,
                    child: Padding(
                      padding:
                       EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w,),
                      child: Text(
                        '${post.isEmpty ? '-' : post}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textSize14.copyWith(
                            color: const Color.fromRGBO(255, 255, 255, 0.8),
                            height: 1.6),
                      )), ),

               //   Gaps.vGap16,
                  Visibility(
                    visible: model.info!.intro!.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.w,right: 18.w,top: 18.h),
                      child: Text(
                        '${model.info!.intro!.isEmpty ? '' : model.info?.intro}',
                        style: TextStyles.textSize12.copyWith(
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                            height: 1.6),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Gaps.vGap18,
                ],
              )));
    });
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


  void _launchWebURL(String title, String url, BuildContext context) {
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, url);
    } else {
      Utils.launchWebURL(url);
    }
  }
}

import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/personal/widget/header_sharerow_widget.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsHeaderDes extends StatelessWidget {
  const DetailsHeaderDes(
      {Key? key, this.logoUrl, this.title, this.des, this.info})
      : super(key: key);
  final String? logoUrl;
  final String? title;
  final String? des;
  final Info? info;

  @override
  Widget build(BuildContext context) {
    final List<String> allLinksArray = getAllLinks(info);
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
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colours.material_bg,
                              border: Border.all(
                                  color: Colours.bg_color,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(6.r),
                              // 设置四周圆角
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ImageUtils.getImageProvider(
                                      logoUrl ?? '',
                                      holderImg: 'company/company'))),
                          width: 78.0.w,
                          height: 78.0.h,
                        ),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.gap_dp16),
                                child: Text(
                                  title ?? '-',
                                  style: TextStyles.textBold16,
                                ))),
                      ],
                    ),
                  ),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                        child: Text(
                          'Tag',
                          style: TextStyles.textGray12,
                        ),
                      ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                    child: info!.industry!.isEmpty? const Text('-',) :Wrap(
                      spacing: 9.w, //主轴上子控件的间距
                      runSpacing: 9.0.h, //交叉轴上子控件之间的间距
                      children: _industryWidget(info!.industry), //要显示的子控件集合
                    ),
                  ),
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
                      '${info!.shortIntro!.isNotEmpty ? info!.shortIntro : '-'}',
                      style: TextStyles.text,
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
                          padding:  EdgeInsets.only(left: 16.w,right: 16.w),
                          child: Text(
                            '-',
                            style: TextStyles.textBold16
                                .copyWith(color: Colours.text_gray),
                          ),
                        )
                      else
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HeaderShareRowWidget(
                          bgColor: Colours.app_main,
                          title: 'Detail',
                          iconUrl: '${info!.linkedin}',
                          iconName: 0xe65e,
                          radius: 44.0.sp,
                          isVisible: info!.linkedin!.isNotEmpty,
                          leftMargin: 12.w,
                        ),
                        HeaderShareRowWidget(
                          bgColor: Colours.app_main,
                          title: 'Detail',
                          iconUrl: '${info!.twitter}',
                          iconName: 0xe65d,
                          radius: 44.0.sp,
                          isVisible: info!.twitter!.isNotEmpty,
                          leftMargin: (context.width - 64.w - 44.r * 5) / 4,
                        ),
                        HeaderShareRowWidget(
                          bgColor: Colours.app_main,
                          title: 'Detail',
                          iconUrl: '${info!.facebook}',
                          iconName: 0xe65c,
                          radius: 44.0.sp,
                          isVisible: info!.facebook!.isNotEmpty,
                          leftMargin: (context.width - 64.w - 44.r * 5) / 4,
                        ),
                        HeaderShareRowWidget(
                          bgColor: Colours.app_main,
                          title: 'Detail',
                          iconUrl: '${info!.youtube}',
                          iconName: 0xe660,
                          radius: 44.0.sp,
                          isVisible: info!.youtube!.isNotEmpty,
                          leftMargin: (context.width - 64.w - 44.r * 5) / 4,
                        ),
                        HeaderShareRowWidget(
                          bgColor: Colours.app_main,
                          title: 'Detail',
                          iconUrl: '${info!.instagram}',
                          iconName: 0xe661,
                          radius: 44.0.sp,
                          isVisible: info!.instagram!.isNotEmpty,
                          leftMargin: (context.width - 64.w - 44.r * 5) / 4,
                        ),
                      ],
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

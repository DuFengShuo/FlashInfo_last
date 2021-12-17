import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/widget/bottomSheet/company_tags.dart';
import 'package:flashinfo/company/widget/bottomSheet/details_header_des.dart';
import 'package:flashinfo/personal/widget/header_sharerow_widget.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/util/screen_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandDetailsHeader extends StatelessWidget {
  const BrandDetailsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 235,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colours.app_main,
        ),
        child: Consumer<BrandProvider>(builder: (_, provider, __) {
          final BrandBean? brandModel = provider.brandBean;
          final List<String> allLinksArray = getAllLinks(brandModel);
          return InkWell(
              onTap: () => onTapIcon(context, brandModel!.info),
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
                                LoadBorderImage(brandModel?.info!.logo ?? '',
                                    width: 78.w,
                                    height: 78.w,
                                    radius: 8.r,
                                    holderImg: 'brand/brand'),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: LoadAssetImage(
                                    'brand/brand_tag',
                                    width: 38.w,
                                    height: 38.w,
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
                                  brandModel?.info!.name ?? '',
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
                                  )
                                else
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeaderShareRowWidget(
                                        bgColor: Colours.material_bg,
                                        title: 'Detail',
                                        iconUrl:
                                            '${brandModel?.info!.linkedin}',
                                        iconName: 0xe65e,
                                        radius: 22.0.sp,
                                        leftMargin: 0,
                                        isVisible: brandModel!
                                            .info!.linkedin!.isNotEmpty,
                                      ),
                                      HeaderShareRowWidget(
                                        bgColor: Colours.material_bg,
                                        title: 'Detail',
                                        iconUrl: '${brandModel.info!.twitter}',
                                        iconName: 0xe65d,
                                        radius: 22.0.sp,
                                        isVisible: brandModel
                                            .info!.twitter!.isNotEmpty,
                                        leftMargin: Dimens.gap_dp8,
                                      ),
                                      HeaderShareRowWidget(
                                        bgColor: Colours.material_bg,
                                        title: 'Detail',
                                        iconUrl: '${brandModel.info!.facebook}',
                                        iconName: 0xe65c,
                                        radius: 22.0.sp,
                                        isVisible: brandModel
                                            .info!.facebook!.isNotEmpty,
                                        leftMargin: Dimens.gap_dp8,
                                      ),
                                      HeaderShareRowWidget(
                                        bgColor: Colours.material_bg,
                                        title: 'Detail',
                                        iconUrl: '${brandModel.info!.youtube}',
                                        iconName: 0xe660,
                                        radius: 22.0.sp,
                                        isVisible: brandModel
                                            .info!.youtube!.isNotEmpty,
                                        leftMargin: Dimens.gap_dp8,
                                      ),
                                      HeaderShareRowWidget(
                                        bgColor: Colours.material_bg,
                                        title: 'Detail',
                                        iconUrl:
                                            '${brandModel.info!.instagram}',
                                        iconName: 0xe661,
                                        radius: 22.0.sp,
                                        isVisible: brandModel
                                            .info!.instagram!.isNotEmpty,
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: 18.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 27.h,
                          margin: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Wrap(
                            spacing: 9, //主轴上子控件的间距
                            runSpacing: 5.0, //交叉轴上子控件之间的间距
                            children: _industryWidget(
                                brandModel!.info!.industry,
                                context), //要显示的子控件集合
                          ),
                        ),
                        //  const Expanded(child: Gaps.empty),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 17, left: 18, right: 18),
                    child: Text(
                      '${brandModel.info!.shortIntro}',
                      style: TextStyles.textSize12.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 0.5),
                          height: 1.6),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ));
        }));
  }

  List<String> getAllLinks(BrandBean? brandBean) {
    final List<String> allLinkArray = [];
    if (brandBean!.info!.linkedin!.isNotEmpty) {
      allLinkArray.add(brandBean.info!.linkedin ?? '');
    } else if (brandBean.info!.twitter!.isNotEmpty) {
      allLinkArray.add(brandBean.info!.twitter ?? '');
    } else if (brandBean.info!.facebook!.isNotEmpty) {
      allLinkArray.add(brandBean.info!.facebook ?? '');
    } else if (brandBean.info!.youtube!.isNotEmpty) {
      allLinkArray.add(brandBean.info!.youtube ?? '');
    } else if (brandBean.info!.instagram!.isNotEmpty) {
      allLinkArray.add(brandBean.info!.instagram ?? '');
    }
    return allLinkArray;
  }

  Widget getDescWidget(String text, BuildContext context) {
    return RichText(
      // maxLines: 3,
      text: TextSpan(
        text: text,
        style: TextStyles.textSize12,
        children: [
          TextSpan(
            text: 'ViewMore',
            style: TextStyles.textBold14,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('点击了ViewMore');
              },
          ),

          // const  WidgetSpan(
          //    alignment: PlaceholderAlignment.middle,
          //    child:Text('ViewMore') ,
          //  ),
        ],
      ),
    );
  }

  List<Widget> _industryWidget(List<dynamic>? industry, BuildContext context) {
    final List<Widget> arr = [];
    final List<dynamic> list = industry ?? <String>[];
    if (list.isNotEmpty) {
      int i = 0;
      double widthAll = 0.00;
      for (final item in list) {
        final String items = item.toString();
        widthAll = widthAll + 10.w + ((items.length) * 7) + 9.w;
        if (widthAll > (context.width - 35.w)) {
          arr.add(_borderText('+${industry!.length - i}', Dimens.gap_dp5));
          break;
        }
        arr.add(_borderText(items, Dimens.gap_dp10));
        i++;
      }
    }
    print(arr.length);
    return arr;
  }

  Widget _borderText(String text, double horizontals) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontals, vertical: Dimens.gap_v_dp5),
        decoration: BoxDecoration(
          color: Colours.material_bg.withAlpha(30),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colours.material_bg,
            fontSize: Dimens.font_sp12,
          ),
        ),
      ),
    );
  }

  void onTapIcon(BuildContext context, Info? info) {
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent, //重点
        context: context,
        builder: (BuildContext context) {
          return DetailsHeaderDes(
            title: info?.name ?? '',
            logoUrl: info?.logo ?? '',
            des: '',
            info: info,
          );
        });
  }

  void onTapTag(BuildContext context, CompanyDetailModel? companyDetailModel) {
    showModalBottomSheet<void>(
        // 权限提示弹框
        backgroundColor: Colors.transparent, //重点
        context: context,
        builder: (BuildContext context) {
          return CompanyTags(
            companyDetailModel: companyDetailModel,
          );
        });
  }
}

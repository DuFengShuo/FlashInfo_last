import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/presenter/brand_detail_presenter.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/brand/widget/brand_employees_widget.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/logo_container_widget.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyDetailsOrgChart extends StatelessWidget {
  const CompanyDetailsOrgChart({Key? key, required this.brandDetailPresenter})
      : super(key: key);
  final BrandDetailPresenter brandDetailPresenter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
      child: CardWidget(
          radius: 12.0.r,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colours.material_bg,
              ),
              child: Consumer2<BrandProvider, UserInfoProvider>(
                  builder: (_, provider, userInfoProvider, __) {
                final BrandBean? brandBean = provider.brandBean;
                final List<Layer>? layerList =
                    brandBean?.organization!.orgChart!.orgChartModel!.layer ??
                        [];
                final List<SecondFloor>? secondFloor = brandBean
                        ?.organization!.orgChart!.orgChartModel!.secondFloor ??
                    [];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const CompanyDetailsItemHeader(
                        isNewIcon: true,
                        iconName: 0xe63f,
                        name: 'Organization',
                        fontSize: 16,
                      ),
                    ),
                    Gaps.line,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const CompanyDetailsItemHeader(name: 'Org Chart'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 16.h),
                      child: (layerList ?? []).isNotEmpty ||
                              (secondFloor ?? []).isNotEmpty
                          ? SizedBox(
                              height: (138.h *
                                      ((secondFloor ?? []).isNotEmpty
                                          ? (secondFloor!.length >= 3
                                              ? 3
                                              : secondFloor.length)
                                          : 0)) +
                                  ((layerList ?? []).isNotEmpty ? 120.h : 0),
                              child: LogoContainerWidget(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimens.gap_dp24,
                                      right: Dimens.gap_dp24,
                                      top: Dimens.gap_v_dp24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (layerList!.isNotEmpty)
                                        OrgChartItem(
                                          a: 0,
                                          layerModel: layerList[0],
                                          brandId: brandBean?.info?.id ?? '',
                                          brandDetailPresenter:
                                              brandDetailPresenter,
                                        ),
                                      if (layerList.isNotEmpty) Gaps.vGap5,
                                      if (secondFloor!.isNotEmpty &&
                                          layerList.isNotEmpty)
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 26.5.w),
                                          child: Container(
                                            width: 2.w,
                                            height: 20.h,
                                            color: Colours.app_main,
                                            child: Gaps.empty,
                                          ),
                                        ),
                                      ...itemArr(
                                          secondFloor,
                                          layerList,
                                          userInfoProvider,
                                          brandDetailPresenter,
                                          brandBean?.info?.id ?? ''),
                                    ],
                                  ),
                                ),
                                radius: 12,
                              ))
                          : SizedBox(
                              width: double.infinity,
                              height: 20.h,
                              child: const Text(
                                  'There are no Org-Chart for this brand.'),
                            ),
                    ),
                    Visibility(
                      visible: (secondFloor ?? []).length > 3,
                      child: GestureDetector(
                        onTap: () {
                          didpush(userInfoProvider, brandBean, context);
                        },
                        child: Container(
                          width: 170.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                              color: Colours.app_main,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.h))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconFont(
                                isNewIcon: true,
                                name: 0xe636,
                                color: Colours.material_bg,
                                size: Dimens.font_sp20,
                              ),
                              Gaps.hGap5,
                              Text(
                                'See full org Chart',
                                style: TextStyles.textSize12
                                    .copyWith(color: Colours.material_bg),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gaps.vGap8,
                    BrandEmployeeWidget(
                      bdPresenter: brandDetailPresenter,
                    ),
                  ],
                );
              }))),
    );
  }

  void didpush(UserInfoProvider userInfoProvider, BrandBean? brandBean,
      BuildContext context) {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => LoginToastDialog(onPressed: () {
                Navigator.pop(context);
                NavigatorUtils.pushResult(context, LoginRouter.smsLoginPage,
                    (value) {
                  brandDetailPresenter
                      .getBrandDetail(brandBean?.info?.id ?? '');
                });
              }));
      return;
    }
    if (!userInfoProvider.isVip) {
      NavigatorUtils.pushResult(context,
          '${ProfileRouter.businessCenterPage}?isShowLog=true', (value) {});
      return;
    }
    NavigatorUtils.push(context,
        '${CompanyRouder.companyOrgChartPage}?companyId=${brandBean?.info?.id}');
  }

//
  List<Widget> itemArr(
      List<SecondFloor>? secondFloor,
      List<Layer>? layer,
      UserInfoProvider userInfoProvider,
      BrandDetailPresenter brandDetailPresenter,
      String brandId) {
    final List<Widget> array = [];
    if ((secondFloor ?? []).isEmpty) {
      return array;
    }
    for (var i = 0; i < (secondFloor ?? []).length; i++) {
      final SecondFloor? model = secondFloor![i];
      array.add(OrgChartItems(
        brandDetailPresenter: brandDetailPresenter,
        userInfoProvider: userInfoProvider,
        itemIndex: i,
        secondFloor: model,
        brandId: brandId,
        isShowBottomLine:
            i == 2 || i == (secondFloor.length - 1) ? false : true,
        isShowTopLine: i == 0 && (layer ?? []).isEmpty ? false : true,
      ));
      if (i == 2) {
        break;
      }
    }

    return array;
  }
}

class OrgChartItems extends StatelessWidget {
  const OrgChartItems(
      {Key? key,
      this.secondFloor,
      this.isShowLeft = true,
      this.isShowBottomLine = true,
      this.isShowTopLine = true,
      this.isShowBorder = false,
      this.itemIndex = 0,
      this.userInfoProvider,
      required this.brandDetailPresenter,
      required this.brandId})
      : super(key: key);
  final SecondFloor? secondFloor;
  final bool isShowLeft;
  final bool isShowBottomLine;
  final bool isShowTopLine;
  final bool isShowBorder;
  final int itemIndex;
  final UserInfoProvider? userInfoProvider;
  final BrandDetailPresenter brandDetailPresenter;
  final String brandId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: isShowLeft,
          child: Container(
            width: 40.w,
            height: 110.h,
            padding: EdgeInsets.only(left: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 2.w,
                    height: double.infinity,
                    color:
                        isShowTopLine ? Colours.app_main : Colors.transparent,
                    child: Gaps.empty,
                  ),
                ),
                Gaps.vGap4,
                Container(
                  width: 20.w,
                  height: 2.h,
                  color: Colours.app_main,
                  child: Gaps.empty,
                ),
                Gaps.vGap4,
                Expanded(
                  child: Container(
                    width: 2.w,
                    height: double.infinity,
                    color: isShowBottomLine
                        ? Colours.app_main
                        : Colors.transparent,
                    child: Gaps.empty,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: itemIndex == 2 && !userInfoProvider!.isVip
                ? GestureDetector(
                    onTap: () {
                      if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ??
                          false)) {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => LoginToastDialog(onPressed: () {
                                  Navigator.pop(context);
                                  NavigatorUtils.pushResult(
                                      context, LoginRouter.smsLoginPage,
                                      (value) {
                                    brandDetailPresenter
                                        .getBrandDetail(brandId);
                                  });
                                }));
                        return;
                      }
                      if (!userInfoProvider!.isVip) {
                        NavigatorUtils.pushResult(
                            context,
                            '${ProfileRouter.businessCenterPage}?isShowLog=true',
                            (value) {});
                        return;
                      }
                    },
                    child: LoadAssetImage(
                      'brand/org_chart',
                      width: double.infinity,
                      height: 88.h,
                      fit: BoxFit.fill,
                    ),
                  )
                : SecondFloorItem(
                    secondFloor: secondFloor,
                    isShowBorder: isShowBorder,
                    brandId: brandId,
                    brandDetailPresenter: brandDetailPresenter))
      ],
    );
  }
}

class SecondFloorItem extends StatelessWidget {
  const SecondFloorItem(
      {Key? key,
      this.a,
      this.secondFloor,
      this.isShowBorder = false,
      required this.brandDetailPresenter,
      required this.brandId})
      : super(key: key);
  final int? a;
  final SecondFloor? secondFloor;
  final bool isShowBorder;
  final BrandDetailPresenter brandDetailPresenter;
  final String brandId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
          showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (_) => LoginToastDialog(onPressed: () {
                    Navigator.pop(context);
                    NavigatorUtils.pushResult(context, LoginRouter.smsLoginPage,
                        (value) {
                      brandDetailPresenter.getBrandDetail(brandId);
                    });
                  }));
          return;
        }
        NavigatorUtils.push(context,
            '${PersonalRouter.personalDetailsPage}?personalId=${secondFloor?.id}');
      },
      child: Container(
        height: 90.h,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: Dimens.gap_v_dp8,
          left: Dimens.gap_v_dp8,
          right: Dimens.gap_dp8,
        ),
        decoration: BoxDecoration(
            color: Colours.material_bg,
            border: new Border.all(
                color: isShowBorder ? Colours.app_main : Colours.material_bg,
                width: 4.w),
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(10.0.h)),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(75, 75, 90, 0.1),
                  blurRadius: 5.0,
                  offset: Offset(2.0, 2.0)),
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48.h,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(color: Colours.bg_color, width: 2.w),
                  ),
                  child: LoadBorderImage(secondFloor?.avatar ?? '',
                      width: 48.h,
                      height: 48.h,
                      holderImg: 'me/avatar',
                      radius: 24.r),
                ),
                Gaps.hGap8,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      secondFloor?.name ?? '-',
                      style: TextStyles.textSize14
                          .copyWith(color: Colours.app_main),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap4,
                    Text(secondFloor?.positions ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textSize10),
                  ],
                ))
              ],
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.gap_dp4,
                          vertical: Dimens.gap_v_dp4),
                      child: IconFont(
                        isNewIcon: true,
                        name: 0xe63a,
                        color: (secondFloor?.mobileCount ?? 0) > 0
                            ? Colours.app_main
                            : Colours.text_gray,
                        size: Dimens.font_sp20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.gap_dp4,
                          vertical: Dimens.gap_v_dp4),
                      child: IconFont(
                        isNewIcon: true,
                        name: 0xe632,
                        color: (secondFloor?.emailCount ?? 0) > 0
                            ? Colours.app_main
                            : Colours.text_gray,
                        size: Dimens.font_sp20,
                      ),
                    )
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.gap_dp5, vertical: Dimens.gap_v_dp2),
                  decoration: BoxDecoration(
                    color: Colours.app_main,
                    borderRadius: BorderRadius.all(Radius.circular(4.0.h)),
                  ),
                  child: Text(
                      '${(secondFloor?.emailCount ?? 0) + (secondFloor?.mobileCount ?? 0)}',
                      style: TextStyles.textSize10
                          .copyWith(color: Colours.material_bg)),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class OrgChartItem extends StatelessWidget {
  const OrgChartItem(
      {Key? key,
      this.a,
      this.layerModel,
      required this.brandId,
      required this.brandDetailPresenter})
      : super(key: key);
  final int? a;
  final Layer? layerModel;
  final String brandId;
  final BrandDetailPresenter brandDetailPresenter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
          showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (_) => LoginToastDialog(onPressed: () {
                    Navigator.pop(context);
                    NavigatorUtils.pushResult(context, LoginRouter.smsLoginPage,
                        (value) {
                      brandDetailPresenter.getBrandDetail(brandId);
                    });
                  }));
          return;
        }
        NavigatorUtils.push(context,
            '${PersonalRouter.personalDetailsPage}?personalId=${layerModel?.id}');
      },
      child: Container(
        height: 90.h,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: Dimens.gap_v_dp8,
          left: Dimens.gap_v_dp8,
          right: Dimens.gap_dp8,
        ),
        decoration: BoxDecoration(
          color: Colours.material_bg,
          border: new Border.all(color: Colours.app_main, width: 4.w),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10.0.h)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48.h,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(color: Colours.bg_color, width: 2.w),
                  ),
                  child: LoadBorderImage(layerModel?.avatar ?? '',
                      width: 48.h,
                      height: 48.h,
                      holderImg: 'me/avatar',
                      radius: 24.r),
                ),
                Gaps.hGap8,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      layerModel?.name ?? '-',
                      style: TextStyles.textSize14
                          .copyWith(color: Colours.app_main),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap4,
                    Text(layerModel?.positions ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textSize10),
                  ],
                ))
              ],
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.gap_dp4,
                          vertical: Dimens.gap_v_dp4),
                      child: IconFont(
                        isNewIcon: true,
                        name: 0xe63a,
                        color: (layerModel?.mobileCount ?? 0) > 0
                            ? Colours.app_main
                            : Colours.text_gray,
                        size: Dimens.font_sp20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.gap_dp4,
                          vertical: Dimens.gap_v_dp4),
                      child: IconFont(
                        isNewIcon: true,
                        name: 0xe632,
                        color: (layerModel?.emailCount ?? 0) > 0
                            ? Colours.app_main
                            : Colours.text_gray,
                        size: Dimens.font_sp20,
                      ),
                    )
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.gap_dp5, vertical: Dimens.gap_v_dp2),
                  decoration: BoxDecoration(
                    color: Colours.app_main,
                    borderRadius: BorderRadius.all(Radius.circular(4.0.h)),
                  ),
                  child: Text(
                      '${(layerModel?.emailCount ?? 0) + (layerModel?.mobileCount ?? 0)}',
                      style: TextStyles.textSize10
                          .copyWith(color: Colours.material_bg)),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

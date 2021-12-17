// ignore_for_file: prefer_is_empty

import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/company/widget/details/company_details_item_header.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandFinanceWidget extends StatelessWidget {
  const BrandFinanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<BrandProvider, UserInfoProvider>(
        builder: (_, provider, userInfoProvider, __) {
      final BrandBean? brandBean = provider.brandBean;
      final Financials financials = brandBean!.financials;
      final List<Map<String, List<Map<String, String>>>> financeArray =
          financeList(financials);
      return Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
          child: CardWidget(
              radius: 12.0.r,
              child: Container(
                  // height: 540.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Colours.material_bg,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: const CompanyDetailsItemHeader(
                          name: 'Finance',
                          iconName: 0xe675,
                        ),
                      ),
                      if (financeArray.isEmpty)
                        const Text('There are no financial for this company')
                      else
                        NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification notification) {
                              return true;
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: financeArray.length,
                              padding: EdgeInsets.only(bottom: 0.h),
                              itemBuilder: (BuildContext context, int index) {
                                final Map<String, List<Map<String, String>>>
                                    par = financeArray[index];
                                final List<Map<String, String>> arrItem =
                                    // ignore: cast_nullable_to_non_nullable
                                    par[par.entries.first.key]
                                        as List<Map<String, String>>;
                                return GestureDetector(
                                    onTap: () => showBottomFinanceRounds(
                                          brandBean.info?.id ?? '',
                                          brandBean,
                                          index,
                                          context,
                                          userInfoProvider.isVip,
                                        ),
                                    child: FinanceCell(
                                      title: '${par.entries.first.key}',
                                      subTitleOne:
                                          arrItem[0]['name'].toString(),
                                      subContentOne:
                                          arrItem[0]['value'].toString(),
                                      subTitleTwo:
                                          arrItem[1]['name'].toString(),
                                      subContentTwo:
                                          arrItem[1]['value'].toString(),
                                      callBack: () {
                                        if (!(SpUtil.getBool(Constant.isLogin,
                                                defValue: false) ??
                                            false)) {
                                          showDialog<void>(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (_) => LoginToastDialog(
                                                      onPressed: () {
                                                    Navigator.pop(context);
                                                    NavigatorUtils.push(
                                                        context,
                                                        LoginRouter
                                                            .smsLoginPage);
                                                  }));
                                          return;
                                        }
                                      },
                                    ));
                              },
                            )),
                      Gaps.vGap16,
                    ],
                  ))));
    });
  }

  Widget financeItem(String name, String value) {
    return Container(
        color: Colours.material_bg,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyles.textBold12.copyWith(color: Colours.text_gray_c),
              ),
              Gaps.vGap10,
              const Expanded(child: Gaps.empty),
              Text(
                value,
                style: TextStyles.textBold18.copyWith(
                    color: Colours.app_main, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  List<Map<String, List<Map<String, String>>>> financeList(
      Financials financials) {
    return [
      {
        'Funding Rounds': [
          {
            'name': 'Total Funding Amount',
            'value':
                '${financials.totalFundingAmount!.isEmpty ? '0' : financials.totalFundingAmount}',
          },
          {
            'name': 'Funding Rounds',
            'value':
                '${financials.numberOfFundingRounds!.isEmpty ? '-' : financials.numberOfFundingRounds}',
          },
        ]
      },
      {
        'Investors': [
          {
            'name': 'Lead Investors',
            'value':
                '${financials.numberOfLeadInvestors!.isEmpty ? '0' : financials.numberOfLeadInvestors}',
          },
          {
            'name': 'Investors',
            'value':
                '${financials.numberOfInvestors!.isEmpty ? '0' : financials.numberOfInvestors}',
          },
        ],
      },
      {
        'Investments': [
          {
            'name': 'Lead Investments',
            'value':
                '${financials.numberOfLeadInvestments!.isEmpty ? '0' : financials.numberOfLeadInvestments}',
          },
          {
            'name': 'Investments',
            'value':
                '${financials.numberOfInvestments!.isEmpty ? '0' : financials.numberOfInvestments}',
          },
        ]
      }
    ];
  }

  void showBottomFinanceRounds(
    String companyId,
    BrandBean? brandBean,
    int index,
    BuildContext context,
    bool isVip,
  ) {
    if (SpUtil.getBool(Constant.isLogin, defValue: false) ?? false) {
      AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Finance_Login');
    } else {
      if (isVip == true) {
        AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Finance_Click');
      } else {
        AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Finance_Go_Vip');
      }
    }

    // ignore: unrelated_type_equality_checks
    if (index == 0) {
      if (brandBean?.financials.numberOfFundingRounds?.length != 0 ||
          brandBean?.financials.totalFundingAmount?.length != 0) {
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
      }
      NavigatorUtils.push(context,
          '${CompanyRouder.companyFinanceDetail}?index=$index&companyId=$companyId',
          arguments: brandBean!.financials);
    }

    if (index == 1) {
      if (brandBean?.financials.numberOfInvestors?.length != 0 ||
          brandBean?.financials.numberOfLeadInvestors?.length != 0) {
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
      }
      NavigatorUtils.push(context,
          '${CompanyRouder.companyFinanceDetail}?index=$index&companyId=$companyId',
          arguments: brandBean!.financials);
    }

    if (index == 2) {
      if (brandBean?.financials.numberOfInvestments?.length != 0 ||
          brandBean?.financials.numberOfLeadInvestments?.length != 0) {
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
      }
      NavigatorUtils.push(context,
          '${CompanyRouder.companyFinanceDetail}?index=$index&companyId=$companyId',
          arguments: brandBean!.financials);
    }

    // final CompanyDetailModelClass companyDetailModelClass =
    //     new CompanyDetailModelClass(
    //         companyDetailModel!, companySubsidiaryModel!);
  }

// // 用于在底部打开弹框的效果
// showModalBottomSheet<void>(
//     context: context,
//     builder: (BuildContext context) {
//       final CompanyDetailPresenter companyDetailPresenter =
//           new CompanyDetailPresenter();
//
//       if (SpUtil.getBool(Constant.isLogin, defValue: false) ?? false) {
//         companyDetailPresenter.sendAnalyticsEvent('Finance_Login');
//       } else {
//         if (isVip == true) {
//           companyDetailPresenter.sendAnalyticsEvent('Finance_Click');
//         } else {
//           companyDetailPresenter.sendAnalyticsEvent('Finance_Go_Vip');
//         }
//       }
//
//       if (index == 0) {
//         //构建弹框中的内容
//         return CompanyFinanceRounds(
//             list: companySubsidiaryModel?.fundingRounds?.list ?? [],
//             companyId: companyId,
//             companyDetailModel: companyDetailModel);
//       } else if (index == 1) {
//         //构建弹框中的内容
//         return CompanyInvestors(
//             list: companySubsidiaryModel?.investors?.list ?? [],
//             companyId: companyId,
//             companyDetailModel: companyDetailModel);
//       } else {
//         //构建弹框中的内容
//         return CompanyInvestment(
//             list: companySubsidiaryModel?.investments?.list ?? [],
//             companyId: companyId,
//             companyDetailModel: companyDetailModel);
//       }
//     });
}

class CompanyDetailModelClass {
  CompanyDetailModelClass(this.companyDetailModel, this.companySubsidiaryModel);

  final CompanyDetailModel companyDetailModel;
  final CompanySubsidiaryModel companySubsidiaryModel;
}

class FinanceCell extends StatelessWidget {
  final String? title;
  final String? subTitleOne;
  final String? subTitleTwo;
  final String? subContentOne;
  final String? subContentTwo;
  final Function? callBack;

  const FinanceCell(
      {Key? key,
      this.title,
      this.subTitleOne,
      this.subTitleTwo,
      this.subContentOne,
      this.subContentTwo,
      this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          child: CompanyDetailsItemHeader(
            name: title ?? '',
            isNext: true,
            fontSize: 12.sp,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp12),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colours.border_grey,
                width: 1,
                // style: BorderStyle.solid
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Container(
              color: Colours.material_bg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$subTitleOne',
                        style: TextStyles.textSize12,
                      ),
                      Gaps.vGap5,
                      Text(
                        '$subContentOne',
                        style: TextStyles.textBold18
                            .copyWith(color: Colours.app_main),
                      ),
                      Gaps.vGap12,
                      Text(
                        '$subTitleTwo',
                        style: TextStyles.textSize12,
                      ),
                      Gaps.vGap5,
                      Text(
                        '$subContentTwo',
                        style: TextStyles.textBold18
                            .copyWith(color: Colours.app_main),
                      ),
                    ],
                  ),
                  Container(
                    width: 48.w,
                    height: 48.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colours.app_main,
                      border: Border.all(
                        width: 0.5,
                        color: Colours.text_gray_c,
                      ),
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconFont(
                          isNewIcon: true,
                          name: 0xe665,
                          color: Colours.material_bg,
                          size: Dimens.font_sp16,
                        ),
                        Text(
                          'view',
                          style: TextStyles.textSize10
                              .copyWith(color: Colours.material_bg),
                        )
                      ],
                    ),
                  ),
               
                ],
              )),
        )
      ],
    );
  }
}

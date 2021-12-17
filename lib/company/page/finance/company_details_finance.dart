import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_subsidiary_model.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/card_widget.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../widget/details/company_details_item_header.dart';

class CompanyDetailsFinance extends StatelessWidget {
  const CompanyDetailsFinance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, List<Map<String, String>>>> financeArray =
        financeList();
    return Consumer2<CompanyProvider, UserInfoProvider>(
        builder: (_, provider, userInfoProvider, __) {
      final CompanyDetailModel? companyDetailModel =
          provider.companyDetailModel;
      final CompanySubsidiaryModel? companySubsidiaryModel =
          provider.companySubsidiaryModel;
      final Map<String, String>? finance = provider.companyDetailModel?.finance;
      return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
          child: CardWidget(
              radius: 12.0.r,
              child: Container(
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
                          isNewIcon: true,
                          iconName: 0xe64e,
                        ),
                      ),
                      if (financeArray.isEmpty)
                        const Text('There are no financial for this company')
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: financeArray.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Map<String, List<Map<String, String>>> par =
                                financeArray[index];
                            final List<Map<String, String>> arrItem =
                                // ignore: cast_nullable_to_non_nullable
                                par[par.entries.first.key]
                                    as List<Map<String, String>>;
                            return GestureDetector(
                                onTap: () => showBottomFinanceRounds(
                                      companyDetailModel?.id ?? '',
                                      companyDetailModel,
                                      index,
                                      companySubsidiaryModel,
                                      context,
                                      userInfoProvider.isVip,
                                    ),
                                child: FinanceCell(
                                  title: par.entries.first.key,
                                  subTitleOne: arrItem[0]['name'].toString(),
                                  subContentOne: (finance?[arrItem[0]['value']]
                                                  ?.trim() ??
                                              '')
                                          .isNotEmpty
                                      ? (finance?[arrItem[0]['value']] ?? '_')
                                      : '_',
                                  subTitleTwo: arrItem[1]['name'].toString(),
                                  subContentTwo: (finance?[arrItem[1]['value']]
                                                  ?.trim() ??
                                              '')
                                          .isNotEmpty
                                      ? (finance?[arrItem[1]['value']] ?? '_')
                                      : '_',
                                  callBack: () {
                                    if (!(SpUtil.getBool(Constant.isLogin,
                                            defValue: false) ??
                                        false)) {
                                      showDialog<void>(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (_) =>
                                              LoginToastDialog(onPressed: () {
                                                Navigator.pop(context);
                                                NavigatorUtils.push(context,
                                                    LoginRouter.smsLoginPage);
                                              }));
                                      return;
                                    }
                                    showBottomFinanceRounds(
                                        companyDetailModel?.id ?? '',
                                        companyDetailModel,
                                        index,
                                        companySubsidiaryModel,
                                        context,
                                        userInfoProvider.isVip);
                                  },
                                )

                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       left: 16.w,
                                //       right: 16.w,
                                //       bottom: index != 2 ? 12.h : 0),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         border: Border.all(
                                //           color: Colours.border_grey,
                                //           width: 1,
                                //           // style: BorderStyle.solid
                                //         ),
                                //         borderRadius: const BorderRadius.all(
                                //             Radius.circular(12))),
                                //     child: Container(
                                //       color: Colours.material_bg,
                                //       // margin: EdgeInsets.all(8.w),
                                //       child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Padding(
                                //             padding: EdgeInsets.only(
                                //                 left: 16.w,
                                //                 right: 16.w,
                                //                 top: 6.h,
                                //                 bottom: 6.h),
                                //             child: CompanyDetailsItemHeader(
                                //               name: par.entries.first.key,
                                //               isNext: true,
                                //               fontSize: 12,
                                //               onTap: () =>
                                //                   // NavigatorUtils.push(context, CompanyRouder.companyFinanceDetail)
                                //                   showBottomFinanceRounds(
                                //                       companyDetailModel?.id ?? '',
                                //                       companyDetailModel,
                                //                       index,
                                //                       companySubsidiaryModel,
                                //                       context,
                                //                       userInfoProvider.isVip),
                                //             ),
                                //           ),
                                //           Gaps.line,
                                //           financeItem(
                                //               arrItem[0]['name'].toString(),
                                //               (finance?[arrItem[0]['value']]
                                //                               ?.trim() ??
                                //                           '')
                                //                       .isNotEmpty
                                //                   ? (finance?[arrItem[0]
                                //                           ['value']] ??
                                //                       '0')
                                //                   : '0'),
                                //           financeItem(
                                //               arrItem[1]['name'].toString(),
                                //               (finance?[arrItem[1]['value']]
                                //                               ?.trim() ??
                                //                           '')
                                //                       .isNotEmpty
                                //                   ? (finance?[arrItem[1]
                                //                           ['value']] ??
                                //                       '0')
                                //                   : '0'),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                );
                          },
                        ),
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

  List<Map<String, List<Map<String, String>>>> financeList() {
    return [
      {
        'Funding Rounds': [
          {
            'name': 'Total Funding Amount',
            'value': 'total_funding_amount',
          },
          {
            'name': 'Number of Funding Rounds',
            'value': 'number_of_funding_rounds',
          },
        ]
      },
      {
        'Investors': [
          {
            'name': 'Number of Lead investors',
            'value': 'number_of_lead_investors',
          },
          {
            'name': 'Number of Investors',
            'value': 'number_of_investors',
          },
        ],
      },
      {
        'Investment': [
          {
            'name': 'Number of investments',
            'value': 'number_of_investments',
          },
          {
            'name': 'Number of lead Investments',
            'value': 'number_of_lead_investments',
          },
        ]
      }
    ];
  }

  void showBottomFinanceRounds(
    String companyId,
    CompanyDetailModel? companyDetailModel,
    int index,
    CompanySubsidiaryModel? companySubsidiaryModel,
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

    final CompanyDetailModelClass companyDetailModelClass =
        new CompanyDetailModelClass(
            companyDetailModel!, companySubsidiaryModel!);
    NavigatorUtils.push(context,
        '${CompanyRouder.companyFinanceDetail}?index=$index&companyId=$companyId',
        arguments: companyDetailModelClass);
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
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 6.h, bottom: 6.h),
          child: CompanyDetailsItemHeader(
            name: title ?? '',
            isNext: true,
            fontSize: 12,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.w, right: 16.w),
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h, bottom: 12.h),
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
                        '$subTitleOne',
                        style: TextStyles.textSize12,
                      ),
                      Gaps.vGap5,
                      Text(
                        '$subContentOne',
                        style: TextStyles.textBold18
                            .copyWith(color: Colours.app_main),
                      ),
                    ],
                  ),
                  MyButton(
                    onPressed: () => callBack!(),
                    text: 'View More',
                    fontSize: 12.sp,
                    minWidth: 80.w,
                    minHeight: 46.h,
                    backgroundColor: Colours.app_main,
                  )
                ],
              )),
        )
      ],
    );
  }
}

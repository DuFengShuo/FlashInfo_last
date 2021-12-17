import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/investors_bean.dart';
import 'package:flashinfo/company/page/finance/company_finance_no_data.dart';
import 'package:flashinfo/company/page/finance/company_finance_rounds.dart';
import 'package:flashinfo/company/page/finance/company_finance_sheet.dart';
import 'package:flashinfo/company/presenter/company_detial_other_presenter.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_unlock_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyInvestors extends StatefulWidget {
  const CompanyInvestors({Key? key, this.financials, this.companyId})
      : super(key: key);
  final Financials? financials;
  final String? companyId;

  // final List<InvestorsModel>? list;
  @override
  _CompanyInvestorsState createState() => _CompanyInvestorsState();
}

class _CompanyInvestorsState extends State<CompanyInvestors>
    with BasePageMixin<CompanyInvestors, PowerPresenter>
    implements CompanyInvestorsIMvpView {
  @override
  BaseListProvider<InvestorsModel> companyInvestorsProvider =
      BaseListProvider<InvestorsModel>();

  late CompanyInvestorsPresenter _companyInvestorsPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyInvestorsPresenter = CompanyInvestorsPresenter();
    _companyInvestorsPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyInvestorsPresenter]);
    return powerPresenter;
  }

  late int countNum = 3;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        // companyInvestorsProvider.addAll(widget.list ?? []);
        _companyInvestorsPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<InvestorsModel>>(
      create: (_) => companyInvestorsProvider,
      child: Consumer2<BaseListProvider<InvestorsModel>, UserInfoProvider>(
        builder: (_, provider, userInfoProvider, __) {
          String subTitleData = '';
          if (widget.financials!.numberOfInvestors!.isNotEmpty) {
            subTitleData =
                '${companyInvestorsProvider.metaModel?.investorsText ?? ''}';
          }
          return CompanyFinanceSheet(
            title: 'Investors',
            subTitle: '$subTitleData',
            firstLeft: 'Number of Lead Investors',
            firstRight:
                '${widget.financials!.numberOfLeadInvestors!.isEmpty ? '0' : widget.financials!.numberOfLeadInvestors}',
            lastLeft: 'Number of Investors',
            lastRight:
                '${widget.financials!.numberOfInvestors!.isEmpty ? '0' : widget.financials!.numberOfInvestors}',
            child: SizedBox(
                width: double.infinity,
                // height: 270.h,
                child: widget.financials!.numberOfLeadInvestors!.isEmpty &&
                        widget.financials!.numberOfInvestors!.isEmpty
                    ? Column(
                        children: [
                          Gaps.vGap50,
                          const LoadAssetImage(
                            'state/company',
                            width: 120,
                          ),
                          Gaps.vGap15,
                          const Text('No data')
                        ],
                      )
                    : userInfoProvider.isVip == false
                        ? LoginUnlockView(
                            fuzzyImg: 'company/funding_fuzzy',
                            loginName: 'View more details',
                            vipName:
                                'You can view it after you upgrade your membership',
                            onTap: () async {
                              await _companyInvestorsPresenter.onRefresh();
                            },
                          )
                        : provider.list.isEmpty
                            ? Column(
                                children: [
                                  Gaps.vGap50,
                                  const LoadAssetImage(
                                    'state/company',
                                    width: 120,
                                  ),
                                  Gaps.vGap15,
                                  const Text('No data')
                                ],
                              )
                            : Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: provider.list.length < 3
                                        ? provider.list.length
                                        : countNum,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FinanceRoundsItem(
                                          model: provider.list[index]);
                                    },
                                  ),
                                  Visibility(
                                    visible: provider.list.length <= 3
                                        ? false
                                        : true,
                                    child: Gaps.vGap16,
                                  ),
                                  Visibility(
                                      visible: provider.list.length <= 3
                                          ? false
                                          : true,
                                      child: FundingRoundsMenuBtn(
                                        callBack: (bool isHasMore) {
                                          if (isHasMore == true) {
                                            setState(() {
                                              countNum = provider.list.length;
                                            });
                                          } else {
                                            setState(() {
                                              countNum = 3;
                                            });
                                          }
                                        },
                                      ))
                                ],
                              )),
          );
        },
      ),
    );
  }
}

class FinanceRoundsItem extends StatelessWidget {
  const FinanceRoundsItem({Key? key, this.model}) : super(key: key);
  final InvestorsModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
          color: Colours.material_bg,
          border: Border.all(width: 1, color: Colours.border_grey),
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp16),
              child: GestureDetector(
                  onTap: () {
                    print('详情id ${model!.investType}');
                    if (model!.investType == 1) {
                      print('详情id ${model!.investType}');
                      //跳转到公司详情
                      NavigatorUtils.push(context,
                          '${CompanyRouder.companyDetailsPage}?companyId=${model!.investId}');
                    }
                    if (model!.investType == 2) {
                      print('详情id ${model!.investId}');
                      //跳转到个人详情
                      NavigatorUtils.push(context,
                          '${PersonalRouter.personalDetailsPage}?personalId=${model!.investId}');
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gaps.hGap16,
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LoadBorderImage(
                              model?.investLogo ?? '',
                              width: 35.w,
                              height: 35.w,
                              holderImg: 'product/product',
                              radius: 35.r,
                            ),
                            Gaps.hGap10,
                            Expanded(
                              child: Text(
                                (model!.investName?.trim().isEmpty ?? true)
                                    ? '-'
                                    : '${model!.investName}',
                                style: TextStyles.textSize14.copyWith(
                                    color: model!.investType == 0
                                        ? Colours.text_gray_c
                                        : Colours.app_main,
                                    fontWeight: FontWeight.bold),
                                // maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: model!.investType != 0,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: const Icon(
                              Icons.navigate_next,
                              color: Colours.text_gray_c,
                            ),
                          ))
                    ],
                  ))),
          // Gaps.vGap16,
          Gaps.line,
          // Gaps.vGap12,
          Padding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, bottom: 10.h, top: 16.h),
            child: Row(
              children: [
                Text(
                  'Lead Investor',
                  style: TextStyles.textGray13,
                ),
                const Spacer(),
                Text(
                  model?.isLeadInvestor == 1 ? 'Yes' : 'No',
                  style: TextStyles.textSize14.copyWith(
                    color: model?.isLeadInvestor == 1
                        ? Colours.text_043
                        : Colours.red,
                  ),
                ),
              ],
            ),
          ),
          // Gaps.vGap16,
          Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 10.h, top: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Partners',
                    style: TextStyles.textGray13,
                  ),
                  Gaps.hGap8,
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      if (model!.partnersName!.isNotEmpty) {
                        print('详情id ${model!.partnersType}');
                        if (model!.partnersType == 1) {
                          print('详情id ${model!.investType}');
                          //跳转到公司详情
                          NavigatorUtils.push(context,
                              '${CompanyRouder.companyDetailsPage}?companyId=${model!.id}');
                        }
                        if (model!.partnersType == 2) {
                          print('详情id ${model!.partnersType}');
                          //跳转到个人详情
                          NavigatorUtils.push(context,
                              '${PersonalRouter.personalDetailsPage}?personalId=${model!.partnersId}');
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Expanded(child: child)
                          Expanded(
                            child: Text(
                              (model!.partnersName?.trim().isEmpty ?? true)
                                  ? '-'
                                  : '${model!.partnersName}',
                              style: TextStyles.textSize12.copyWith(
                                  color: model!.partnersType == 0
                                      ? Colours.text_gray_c
                                      : Colours.app_main,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // const Icon(Icons.navigate_next,color: Colours.text_gray_c,)
                          Visibility(
                              visible: model!.partnersType != 0,
                              child: const Icon(
                                Icons.navigate_next,
                                color: Colours.text_gray_c,
                              ))
                        ],
                      ),
                    ),
                  ))
                ],
              )),
          Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, bottom: 10.h, top: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Funding Round',
                    style: TextStyles.textGray13,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LoadBorderImage(
                          model?.fundingRoundLogo ?? '',
                          width: 24.w,
                          height: 24.h,
                          holderImg: 'product/product',
                          radius: 24.r,
                        ),
                        Gaps.hGap10,
                        Container(
                          constraints: BoxConstraints(maxWidth: 135.w),
                          child: Text(
                            (model!.fundingRoundName?.trim().isEmpty ?? true)
                                ? '-'
                                : '${model?.fundingRoundName}',
                            // model!.fundingRoundName!.isEmpty? '-': '${model?.fundingRoundName}',
                            style: TextStyles.textSize14,
                            textAlign: TextAlign.center,
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

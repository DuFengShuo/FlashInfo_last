import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/iview/company_detail_iview.dart';
import 'package:flashinfo/company/models/finance_rounds_bean.dart';
import 'package:flashinfo/company/page/finance/company_finance_no_data.dart';
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
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_unlock_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyFinanceRounds extends StatefulWidget {
  const CompanyFinanceRounds({Key? key, this.financials, this.companyId})
      : super(key: key);
  final Financials? financials;
  final String? companyId;

  // final List<FinanceRoundsModel>? list;

  @override
  _CompanyFinanceRoundsState createState() => _CompanyFinanceRoundsState();
}

class _CompanyFinanceRoundsState extends State<CompanyFinanceRounds>
    with BasePageMixin<CompanyFinanceRounds, PowerPresenter>
    implements CompanyFinanceRoundsIMvpView {
  @override
  BaseListProvider<FinanceRoundsModel> companyFinanceRoundsProvider =
      BaseListProvider<FinanceRoundsModel>();

  late CompanyFinanceRoundsPresenter _companyFinanceRoundsPresenter;

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _companyFinanceRoundsPresenter = CompanyFinanceRoundsPresenter();
    _companyFinanceRoundsPresenter.companyId = widget.companyId ?? '';
    powerPresenter.requestPresenter([_companyFinanceRoundsPresenter]);
    return powerPresenter;
  }

  late int countNum = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        //  companyFinanceRoundsProvider.addAll(widget.list ?? []);
        await _companyFinanceRoundsPresenter.onRefresh();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<FinanceRoundsModel>>(
      create: (_) => companyFinanceRoundsProvider,
      child: Consumer2<BaseListProvider<FinanceRoundsModel>, UserInfoProvider>(
        builder: (_, provider, userInfoProvider, __) {
          String subTitleData = '';
          if (widget.financials!.numberOfFundingRounds!.isNotEmpty) {
            subTitleData =
                '${companyFinanceRoundsProvider.metaModel?.fundingRoundText ?? ''}';
          }

          return CompanyFinanceSheet(
            title: 'Funding Rounds',
            subTitle: subTitleData,
            firstLeft: 'Total Funding Amount',
            firstRight:
                '${widget.financials!.totalFundingAmount!.isEmpty ? ' 0' : widget.financials!.totalFundingAmount}',
            lastLeft: 'Funding Rounds',
            lastRight:
                '${widget.financials!.numberOfFundingRounds!.isEmpty ? '-' : widget.financials!.numberOfFundingRounds}',
            child: SizedBox(
                width: double.infinity,
                // height: 270.h,
                child: widget.financials!.totalFundingAmount!.isEmpty &&
                        widget.financials!.numberOfFundingRounds!.isEmpty
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
                              await _companyFinanceRoundsPresenter.onRefresh();
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
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: provider.list.length < 3
                                        ? provider.list.length
                                        : countNum,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FinanceRoundsCell(
                                        model: provider.list[index],
                                      );
                                      //return FinanceRoundsItem(model: provider.list[index]);
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

class FinanceRoundsCell extends StatelessWidget {
  final FinanceRoundsModel? model;

  const FinanceRoundsCell({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      // padding: EdgeInsets.symmetric(
      //     horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (model!.announcedDate?.trim().isEmpty ?? true)
                      ? '-'
                      : '${model!.announcedDate}',
                  style: TextStyles.textBold12
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
                Gaps.vGap5,
                Text(
                  '${(model!.moneyRaised?.trim().isEmpty ?? true) ? '' : '${model!.moneyRaised}'} ',
                  style: TextStyles.textBold12.copyWith(
                      color: Colours.app_main, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Gaps.hGap8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                    color: Colours.app_main,
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
              ),
              Gaps.vGap5,
              Container(
                color: Colours.line,
                width: 2.w,
                height: 126.h,
              ),
            ],
          ),
          Gaps.hGap8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaction Name',
                  style: TextStyles.textGray12,
                ),
                Gaps.vGap5,
                Text(
                  (model!.name?.trim().isEmpty ?? true)
                      ? '-'
                      : '${model!.name}',
                  style: TextStyles.textBold12
                      .copyWith(fontWeight: FontWeight.bold),
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap8,
                Text(
                  'Number of Investors',
                  style: TextStyles.textGray12,
                ),
                Gaps.vGap5,
                Text(
                  '${(model!.numberOfInvestors?.trim().isEmpty ?? true) ? '-' : '${model!.numberOfInvestors}'} ',
                  style: TextStyles.textBold12
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap8,
                Text(
                  'Lead Investors',
                  style: TextStyles.textGray12,
                ),
                Gaps.vGap5,
                GestureDetector(
                  onTap: () {
                    if (model!.leadInvestorsType == '1') {
                      print('详情id ${model!.leadInvestorsRelatedId}');
                      //跳转到公司详情
                      NavigatorUtils.push(context,
                          '${CompanyRouder.companyDetailsPage}?companyId=${model!.leadInvestorsRelatedId}');
                    }
                    if (model!.leadInvestorsType == '2') {
                      print('详情id ${model!.leadInvestorsRelatedId}');
                      //跳转到个人详情
                      NavigatorUtils.push(context,
                          '${PersonalRouter.personalDetailsPage}?personalId=${model!.leadInvestorsRelatedId}');
                    }
                  },
                  child: Text(
                    (model!.leadInvestorsName?.trim().isEmpty ?? true)
                        ? '-'
                        : '${model!.leadInvestorsName}',
                    style: TextStyles.textSize12.copyWith(
                        color: model!.leadInvestorsType == '0'
                            ? Colours.text_gray_c
                            : Colours.app_main,
                        fontWeight: FontWeight.bold),
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FinanceRoundsItem extends StatelessWidget {
  const FinanceRoundsItem({Key? key, this.model}) : super(key: key);
  final FinanceRoundsModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
            color: Colours.material_bg,
            border: Border.all(width: 1, color: Colours.border_grey),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Announced Date',
                    style: TextStyles.textGray13,
                  ),
                  const Spacer(),
                  Text(
                    (model!.announcedDate?.trim().isEmpty ?? true)
                        ? '-'
                        : '${model!.announcedDate}',
                    style: TextStyles.textSize14,
                  ),
                ],
              ),
              Gaps.vGap16,
              Row(
                children: [
                  Text(
                    'Transaction Name',
                    style: TextStyles.textGray13,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // LoadBorderImage(model?.logo ?? '',
                      //     width: 24.w,
                      //     height: 24.h,
                      //     holderImg: 'product/product'),
                      // Gaps.hGap10,
                      Text(
                        (model!.name?.trim().isEmpty ?? true)
                            ? '-'
                            : '${model!.name}',
                        style: TextStyles.textSize14,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              // Gaps.vGap16,
              // Row(
              //   children: [
              //     Text(
              //       'Number of Investors',
              //       style: TextStyles.textGray13,
              //     ),
              //     const Spacer(),
              //     Text(
              //       model?.numberOfInvestors.toString() ?? '-',
              //       style: TextStyles.textSize14,
              //     ),
              //   ],
              // ),
              Gaps.vGap16,
              Row(
                children: [
                  Text(
                    'Money Raised',
                    style: TextStyles.textGray13,
                  ),
                  const Spacer(),
                  Text(
                    // '\$ ${    model?.moneyRaised ?? '-'} M',
                    '\$ ${(model!.moneyRaised?.trim().isEmpty ?? true) ? '-' : '${model!.moneyRaised}'} ',

                    style:
                        TextStyles.textSize14.copyWith(color: Colours.app_main),
                  ),
                ],
              ),
              Gaps.vGap16,
              Row(
                children: [
                  Text(
                    'Lead Investors',
                    style: TextStyles.textGray13,
                  ),
                  const Spacer(),
                  Text(
                    (model!.leadInvestorsName?.trim().isEmpty ?? true)
                        ? '-'
                        : '${model!.leadInvestorsName}',
                    style: TextStyles.textSize14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class FundingRoundsMenuBtn extends StatefulWidget {
  final Function? callBack;

  const FundingRoundsMenuBtn({Key? key, this.callBack}) : super(key: key);

  @override
  _FundingRoundsMenuBtnState createState() => _FundingRoundsMenuBtnState();
}

class _FundingRoundsMenuBtnState extends State<FundingRoundsMenuBtn> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isShowMore = !isShowMore;
        });
        if (widget.callBack != null) {
          widget.callBack!(isShowMore);
        }
      },
      child: Container(
        width: 165.w,
        height: 44.h,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colours.line),
            borderRadius: BorderRadius.all(Radius.circular(44.r))),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 20.w,
                height: 20.w,
                image: ImageUtils.getAssetImage(
                    '${isShowMore ? 'company/office_up' : 'company/office_down'}'),
              ),
              Gaps.hGap4,
              Text(
                ' ${isShowMore ? 'View Less' : 'View More'} ',
                style: TextStyles.textSize12.copyWith(color: Colours.app_main),
              )
            ],
          ),
        ),
      ),
    );
  }
}
